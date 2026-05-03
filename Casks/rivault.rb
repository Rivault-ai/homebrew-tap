cask "rivault" do
  version "0.1.1"
  sha256 "0114fbcd0818cd6fd381b1ac8e13b0911d7d229dc932336c2fd8716bb7364b21"

  url "https://github.com/Rivault-ai/desktop/releases/download/v#{version}/Rivault-darwin.zip"
  name "Rivault"
  desc "Local secrets daemon for AI agents"
  homepage "https://github.com/Rivault-ai/desktop"

  depends_on macos: ">= :big_sur"

  app "Rivault.app"

  postflight do
    skill_src = Pathname.new("#{staged_path}/skill")
    skill_dst = Pathname.new("#{Dir.home}/.openclaw/skills/rivault")
    if skill_src.directory?
      skill_dst.dirname.mkpath
      FileUtils.rm_rf(skill_dst)
      FileUtils.cp_r(skill_src, skill_dst)
    end
  end

  uninstall quit: "ai.rivault.daemon"

  zap trash: [
    "~/Library/Application Support/Rivault",
    "~/.openclaw/skills/rivault",
    "~/Library/Preferences/ai.rivault.daemon.plist",
  ]

  caveats <<~EOS
    Rivault installed. Open the app and paste your API key on first launch:
      open -a Rivault

    Get an API key at https://rivault.ai
  EOS
end

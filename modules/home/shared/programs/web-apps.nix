_:

{
  flake.modules.homeManager.shared = {
    xdg.desktopEntries = {
      github = {
        name = "GitHub";
        genericName = "Code hosting";
        comment = "Open GitHub as a web app";
        exec = "chromium --app=https://github.com";
        icon = "chromium";
        terminal = false;
        categories = [
          "Development"
          "Network"
        ];
      };

      chatgpt = {
        name = "ChatGPT";
        genericName = "AI assistant";
        comment = "Open ChatGPT as a web app";
        exec = "chromium --app=https://chatgpt.com";
        icon = "chromium";
        terminal = false;
        categories = [
          "Network"
          "Office"
        ];
      };

      reddit = {
        name = "Reddit";
        genericName = "Social news";
        comment = "Open Reddit as a web app";
        exec = "chromium --app=https://www.reddit.com";
        icon = "chromium";
        terminal = false;
        categories = [
          "Network"
        ];
      };

      notion = {
        name = "Notion";
        genericName = "Workspace";
        comment = "Open Notion as a web app";
        exec = "chromium --app=https://www.notion.so";
        icon = "chromium";
        terminal = false;
        categories = [
          "Network"
          "Office"
        ];
      };

      localhost-3000 = {
        name = "Localhost 3000";
        genericName = "Local web app";
        comment = "Open localhost:3000 as a web app";
        exec = "chromium --app=http://localhost:3000";
        icon = "chromium";
        terminal = false;
        categories = [
          "Development"
          "Network"
        ];
      };
    };
  };
}

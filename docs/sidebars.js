// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  docsSidebar: [
    'intro',
    'installation',
    {
      type: 'category',
      label: 'Usage',
      collapsed: false,
      items: [
        'usage/install',
        'usage/use',
        'usage/list',
        'usage/list-remote',
        'usage/uninstall',
        'usage/upgrade',
      ],
    },
    'terragrunt-version-file',
    'environment-variables',
    'architecture',
    'uninstalling',
    'contributing',
  ],
};

export default sidebars;

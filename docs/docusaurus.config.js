// @ts-check
// See: https://docusaurus.io/docs/api/docusaurus-config

import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'TGEnv',
  tagline: 'Terragrunt Version Manager',
  favicon: 'img/logo.png',

  url: 'https://tgenv.github.io',
  baseUrl: '/tgenv/',

  organizationName: 'tgenv',
  projectName: 'tgenv',
  deploymentBranch: 'gh-pages',
  trailingSlash: false,

  onBrokenLinks: 'throw',

  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          routeBasePath: '/',
          editUrl: 'https://github.com/tgenv/tgenv/tree/main/docs/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      image: 'img/logo.png',
      colorMode: {
        defaultMode: 'light',
        respectPrefersColorScheme: true,
      },
      navbar: {
        title: 'TGEnv',
        logo: {
          alt: 'TGEnv Logo',
          src: 'img/logo.png',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'docsSidebar',
            position: 'left',
            label: 'Documentation',
          },
          {
            href: 'https://github.com/tgenv/tgenv',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Documentation',
            items: [
              {label: 'Introduction', to: '/intro'},
              {label: 'Installation', to: '/installation'},
              {label: 'Usage', to: '/usage/install'},
            ],
          },
          {
            title: 'Project',
            items: [
              {label: 'GitHub', href: 'https://github.com/tgenv/tgenv'},
              {label: 'Issues', href: 'https://github.com/tgenv/tgenv/issues'},
              {label: 'Pull Requests', href: 'https://github.com/tgenv/tgenv/pulls'},
            ],
          },
          {
            title: 'Related',
            items: [
              {label: 'Terragrunt', href: 'https://terragrunt.gruntwork.io/'},
              {label: 'tfenv', href: 'https://github.com/tfutils/tfenv'},
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} TGEnv. Built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ['bash', 'shell-session'],
      },
    }),
};

export default config;

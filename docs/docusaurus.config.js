// @ts-check
// `@type` JSDoc annotations allow editor autocompletion and type checking
// (when paired with `@ts-check`).
// There are various equivalent ways to declare your Docusaurus config.
// See: https://docusaurus.io/docs/api/docusaurus-config

import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Grupo 05',
  tagline: 'Inovando em Tecnologia e Saúde',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: `https://inteli-college.github.io`,
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: `/2024-1B-T02-EC10-G05/`,

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  projectName: '2024-1B-T02-EC10-G05', // Usually your repo name.
  organizationName: 'Inteli-College', // Usually your GitHub org/user name.
  trailingSlash: false,

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'br',
    locales: ['br'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
        },
        blog:false,
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      image: 'img/logo.webp',
      navbar: {
        title: 'Grupo 05',
        logo: {
          alt: 'Hospital Logo',
          src: 'img/logo.webp',
        },
        items: [
          {
            to: "https://github.com/Inteli-College/2024-1B-T02-EC10-G05",
            position: "right",
            className: "header-github-link",
            "aria-label": "GitHub repository",
          },
        ],
      },
      footer: {
        style: 'dark',
        copyright: `Copyright © ${new Date().getFullYear()}`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
      },
    }),
};

export default config;

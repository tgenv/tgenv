import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--tgenv')}>
      <div className="container">
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <p style={{maxWidth: 720, margin: '1rem auto 2rem', fontSize: '1.05rem', opacity: 0.95}}>
          A lightweight, shell-script based version manager for Terragrunt.
          Install, switch and manage multiple Terragrunt versions on Linux and macOS.
        </p>
        <div>
          <Link className="button button--tgenv-primary button--lg" to="/intro">
            Get Started
          </Link>
          <Link className="button button--tgenv-ghost button--lg" to="https://github.com/tgenv/tgenv">
            View on GitHub
          </Link>
        </div>
      </div>
    </header>
  );
}

const features = [
  {
    title: 'Simple Installation',
    description:
      'Clone the repository and add it to your PATH. No external runtime, just bash. Works on Linux and macOS, including Apple Silicon.',
  },
  {
    title: 'Multiple Versions',
    description:
      'Install any number of Terragrunt versions side by side and switch between them with a single command.',
  },
  {
    title: 'Project-Aware',
    description:
      'Drop a .terragrunt-version file at your project root and TGEnv automatically uses the correct version every time.',
  },
  {
    title: 'Latest Version Matching',
    description:
      'Use the "latest" or "latest:<regex>" syntax to install or pin the newest version that matches a constraint.',
  },
  {
    title: 'Cross-Platform',
    description:
      'Tested on Alpine, Ubuntu, Fedora and macOS. Built around standard POSIX tools so it stays portable.',
  },
  {
    title: 'Self-Upgradable',
    description:
      'Run tgenv upgrade to pull the latest TGEnv release straight from the main branch.',
  },
];

function HomepageFeatures() {
  return (
    <section className="tgenv-features">
      <div className="container">
        <div className="row">
          {features.map((feature, idx) => (
            <div key={idx} className="col col--4" style={{marginBottom: '1.5rem'}}>
              <div className="tgenv-feature-card">
                <h3>{feature.title}</h3>
                <p>{feature.description}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

export default function Home() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={siteConfig.title}
      description="TGEnv — Terragrunt Version Manager. Install, switch and manage Terragrunt versions on Linux and macOS.">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}

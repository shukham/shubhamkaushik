# shubhamkaushik.com

Personal academic website, built with [Jekyll](https://jekyllrb.com/) and deployed to GitHub Pages by `.github/workflows/deploy.yml` on every push to `master`.

## Run locally

```sh
bundle install
bundle exec jekyll serve --livereload
```

Then open <http://localhost:4000>.

## Where things live

| Content | Location |
| --- | --- |
| Home page bio | `_pages/about.md` |
| News items | `_news/*.md` (`inline: true` shows the body directly in the list) |
| Projects | `_projects/*.md` (`category`, `year` (newest first), `importance` (orders projects within a year), optional `img` and `related_publications`) |
| Publications | `_bibliography/papers.bib` (`selected={true}` shows a paper on the home page; `status={Accepted}` tags a paper as accepted until it is published) |
| Talks | `_talks/*.md` |
| CV and papers | `assets/pdf/` |
| Slides | `assets/slides/` |
| Images | `assets/img/` |
| Blog posts | `_posts/` (the Blog link appears once a post exists) |

## Scripts

Run these locally and commit what they generate:

| Command | When |
| --- | --- |
| `bundle exec bin/paper-thumbnails` | After adding or updating a paper PDF; renders its first page to `assets/img/papers/` (needs `pdftoppm` and `cwebp`) |
| `bundle exec bin/citations` | Whenever you want fresh citation counts from Google Scholar; writes `_data/citations.yml` |

## Theme

| Part | Location |
| --- | --- |
| Page templates | `_layouts/` |
| Shared components (header, footer, icons, cards) | `_includes/` |
| Styles (design tokens in `_tokens.scss`) | `_sass/` |
| Theme toggle, mobile menu, abstract toggles | `assets/js/site.js` |

In project pages, images use `{% include figure.html path="assets/img/..." title="..." class="img-fluid rounded z-depth-1" %}`. Wrap them in `<div class="row">` / `<div class="col-sm-6">` to place figures side by side.

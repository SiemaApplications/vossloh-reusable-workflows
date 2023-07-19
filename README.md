# Vossloh Github Actions

This repository hosts [composite action](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) and [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for Github Actions

## Composite Actions
### twister/results-analysis
This composite action parses `twister.json` file and report the result in the step summary.


### mcuboot/stm32h7-banks
Takes MCUboot binary for a specific board and produces `hex` files for each bank and a merged `hex` files which contains MCUboot for each bank.

> As it is not yet possible to perform steps iterations in github actions, this action is interesting only for jobs who compile a single binary.


### debug/show-github-context
Print some of the [github context properties](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) for debug purposes.

Because this is a composite action some properties may relate to the composite action and not from the caller.

## Reusable Workflows
### Twister Signed Compilation
`twister-signed-compilation.yml` compiles the requested application with the provided signing key.
> Note that (despite the name), it supports compilation of application which do not have to be signed.

### Release Zephyr Application
`release-zephyr-app.yml` compiles and creates a github release. This workflow needs to be triggered on tag push event.

### MCUboot Compilation
`mcuboot-compilation-stm32h7.yml` compiles MCUboot for the requested platform with the provided signing key.
This workflows uses `twister-signed-compilation.yml` workflow.

It produces an artifact containing MCUboot located in each bank of the stm32h743.

## Contributing
Store Reusable workflows in `.github/workflows`, and each composite action in its own folder (nothing at the top level).

Due to dependencies between reusable worklows and a composite action, pinning to sha1 references is a real pain (if not impossible). Therefore actions are pinned to a tag which is more stable than a branch name.
While developping a new action, it is recommended to work from a branch and reference that branch, when the action is ready and merged to main, the tag can be moved (as long as compatibility is maintained):

```
git tag -d v3
git tag v3
git push --tags --force
```

### Commit hooks
Install `pre-commit` to check the syntax of the actions and workflows files:
```
pip install pre-commit
pre-commit install
```

## Updating actions versions
`scripts/update_action_refs.sh` can help you set the version of for every workflow in a repository:
```
scripts/update_action_refs.sh -s v3
```
Verify the changes afterward.

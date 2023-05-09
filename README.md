# Vossloh Github Actions

This repository hosts [composite action](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) and [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for Github Actions

## Composite Actions
### twister/results-analysis
This composite action parses `twister.json` file and report the result in the step summary.


### mcuboot/stm32h7-banks
Takes MCUboot binary for a specific board and produces `hex` files for each bank and a merged `hex` files which contains MCUboot for each bank.


### debug/show-github-context
Print some of the [github context properties](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context) for debug purposes.
Because this is a composite action some properties may relate to the composite action and not from the caller.

## Reusable Workflows
### Twister Signed Compilation
`twister-signed-compilation.yml` compiles the requested application with the provided signing key.

### MCUboot Compilation
`mcuboot-compilation-stm32h7.yml` compiles MCUboot for the requested platform with the provided signing key.
This workflows uses `twister-signed-compilation.yml` workflow.
It uses `mcuboot/stm32h7-banks` to produce `hex` files for each bank of the stm32h7.

## Contributing
Store Reusable workflows in `.github/workflows`, and each composite action in its own folder (nothing at the top level).

### Commit hooks
Install `pre-commit` to check the syntax of the actions and workflows files:
```
pip install pre-commit
pre-commit install
```

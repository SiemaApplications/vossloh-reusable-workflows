# Vossloh Github Actions

This repository hosts [composite action](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) and [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for Github Actions

## Composite Actions
### twister-analysys
This composite action parses `twister.json` file and report the result in the step summary.

## Reusable Workflows
### MCUboot Compilation
`mcuboot-compilation.yml` compiles MCUboot for the requested platform with the provided signing key.

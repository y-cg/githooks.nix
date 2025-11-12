# The Missing githooks for devenv

## Usage

Add this flake as an input to your `devenv` configuration.

```bash
# add this flake input to your devenv
devenv inputs add githooks github:y-cg/githooks.nix/master
```

then import the `githooks` module in your `devenv` configuration file.

```nix
# devenv.nix
{
  # ...
  imports = [
    # ...
    inputs.githooks.modules.default
  ];
}
```

or if you prefer fine grained control, you can import specific githooks modules
like this:

```nix
# devenv.nix
{
  # ...
  imports = [
    # ...
    inputs.githooks.modules.forge-fmt
  ];
}
```

## Available githooks

### Forge

```nix
# devenv.nix
{
  custom.git-hooks = {
    forge-fmt.enable = true;
  };
}
```

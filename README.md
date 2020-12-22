# docker-retag
Action to add a tag to an existing remote docker image.

## Usage
The action currently supports two inputs: source and target image.

E.g.:
````yaml
uses: romanlamsal/docker-retag@v1
    with:
      source-image: "docker.io/someone/something:test"
      target-image: "docker.io/someone/something:latest"
````
Will result in the image ``docker.io/someone/something:test`` having the additional tag ``latest``.

There is an example workflow which is used for testing where the action can be seen... in action.

## Caveats
The action compares the images' manifests in order to determine whether an update is actually
required or not. This comes with the caveat that currently (2020/12/22) the flag 
``DOCKER_CLI_EXPERIMENTAL="enabled"`` must be set (which is included in the action itself).


## ToDos

- [ ] Create input which to control if manifests should be compared or not
- [ ] Replace ``docker push`` with ``docker manifest push`` in order to speed up the process
of re-tagging
    - current behavior is to first pull the source image, tag it as the target image and push

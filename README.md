Anton's OpenSCAD library
========================

Because every OpenSCAD ~~programmer~~designer has their own library.

As anyone with a Java background I recognize the authority of internationally
viable namespacing. For that reason I refer to the parts in this library in my
designs as *se/antoneliasson/thing.scad* and thus recommend that you install
it into your local OpenSCAD library path like this:

	$ git clone https://github.com/antoneliasson/antonscad ~/.local/share/OpenSCAD/libraries/se/antoneliasson

assuming that you are on a Linux system.

As this library is currently developed without much thought to backwards
compatibility or stable versioning, you may instead wish to include it in your
project as a git submodule. That allows versioning the library together with
your project and update it (or choose not to) in a controlled fashion.

License
-------

See [LICENSE](LICENSE) for everything but libraries in the
[thirdparty](thirdparty) directory. Thirdparty libraries may have differing
licenses. Refer to each library file's accompanying license file.

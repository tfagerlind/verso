# Verso

Verso is an application aimed to simplify and standardize automatic
versioning in a continuous delivery context.

# Philosophy

The idea with Verso is to reuse part of the functionality needed in
order to implement Continuous Delivery.

The approach to continuous delivery taken is the multi-repo approach
supported by [this
blog](https://www.thoughtworks.com/insights/blog/architecting-continuous-delivery).
That is, modularization of an application is achieved by breaking out
components that lives in their own version controlled repositories,
with their own delivery pipelines. The components are released to a
binary repository, such as Artifactory or Nexus. The dependencies to
the components may be resolved at various stages depending on the type
of component. In the case of a library the dependency typically is
resolved at build time of the dependent application, by the use of a
dependency manager, such as Maven, Pip, or Conan. In the case of a
service the components are instead resolved at deploy time.

In order to encourage modularization it is of uttermost importance to
reduce the friction involved in creating individual release pipelines
for each component. Likewise, it is also important to minimize the
friction and lead time involved by this multi-repo approach;
multi-repo approaches typically require multiple changes in order for
a change to end up in production. The suggested approach is to
automate versioning and releases of components, both for staging and
trunk (trunk based development is favored). Releasing for staging
means releasing candidates for each proposed change (a proposed change
is typically subject to a review, for example pull requests or change
sets). Releasing for trunk means releasing an approved change to the
binary repository.

Automatic versioning a component can be solved is various ways, but
the approach suggested by this project is to use a SemVer-like
approach. Depending on the ambition of the user, the approach can
actually be everything from SemVer to SemVer-like. The reason to use a
SemVer-like approach is to let dependency management look elegant and
conventional. One thing that SemVer for example supports is the
ability to identify the generation of a component, which simplifies
understanding. It can be argued that true SemVer (including the
distinction between major, minor, and patch versions), is sometimes
over-kill for components, at least in small settings, hence the sloppy
use of SemVer allowed by this project.


# Etymology

The name `Verso` is the result of playing with the word `version`, the
literal meaning of the Italian word `verso` meaning `towards` in
English.

# Contributions

Contributions are welcome.



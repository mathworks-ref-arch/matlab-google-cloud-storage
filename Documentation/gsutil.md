# MATLAB Interface for *gsutil tool*

```gsutil``` is a command line application that lets you access Cloud Storage.

### You can use gsutil to do a wide range of bucket and object management tasks, including:

1. Creating and deleting buckets.
2. Uploading, downloading, and deleting objects.
3. Listing buckets and objects.
4. Moving, copying, and renaming objects.
5. Editing object and bucket ACLs.
For a complete example of performing tasks with gsutil, see ```gsutil_example_for_CRUD.mlx``` at [Example MATLAB Script](https://github.com/mathworks-ref-arch/matlab-google-cloud-storage/tree/master/Software/MATLAB/script/Examples).

### Getting started

While it is recommended that gsutil be downloaded and installed as part of the Google Cloud SDK package, it can alternatively be installed as a stand-alone product.
For more information, see [How to install gsutil](https://cloud.google.com/storage/docs/gsutil_install?hl=ru#sdk-install).

### Syntax for accessing resources
gsutil uses the prefix gs:// to indicate a resource in Cloud Storage:

> gs://[BUCKET_NAME]/[OBJECT_NAME]

In addition to specifying exact resources, gsutil supports the use of wildcards in your commands.

By default, gsutil accesses Cloud Storage through JSON API request endpoints. You can change this default to the XML API.

### Built-in help
gsutil contains thorough built-in help about every command as well as a number of topics, which you can get by running:

> gsutil help

This command outputs a list of all commands and available help topics, and you can then get detailed help for each command or topic.

To get information about gsutil top-level command-line options, use:

> gsutil help options

```
NAME
  options - Top-Level Command-Line Options


DESCRIPTION
  gsutil supports separate options for the top-level gsutil command and
  the individual sub-commands (like cp, rm, etc.) The top-level options
  control behavior of gsutil that apply across commands. For example, in
  the command:

    gsutil -m cp -p file gs://bucket/obj

  the -m option applies to gsutil, while the -p option applies to the cp
  sub-command.


OPTIONS
  -D          Shows HTTP requests/headers and additional debug info needed when
              posting support requests, including exception stack traces.

  -DD         Shows HTTP requests/headers, additional debug info,
              exception stack traces, plus HTTP upstream payload.

  -h          Allows you to specify certain HTTP headers, for example:

                gsutil -h "Cache-Control:public,max-age=3600" \
                       -h "Content-Type:text/html" cp ...

              Note that you need to quote the headers/values that
              contain spaces (such as "Content-Disposition: attachment;
              filename=filename.ext"), to avoid having the shell split them
              into separate arguments.

              The following headers are stored as object metadata and used
              in future requests on the object:

                Cache-Control
                Content-Disposition
                Content-Encoding
                Content-Language
                Content-Type

              The following headers are used to check data integrity:

                Content-MD5

              gsutil also supports custom metadata headers with a matching
              Cloud Storage Provider prefix, such as:

                x-goog-meta-

              Note that for gs:// URLs, the Cache Control header is specific to
              the API being used. The XML API will accept any cache control
              headers and return them during object downloads.  The JSON API
              respects only the public, private, no-cache, and max-age cache
              control headers, and may add its own no-transform directive even
              if it was not specified. See 'gsutil help apis' for more
              information on gsutil's interaction with APIs.

              See also "gsutil help setmeta" for the ability to set metadata
              fields on objects after they have been uploaded.

  -i          Allows you to use the configured credentials to impersonate a
              service account, for example:

                gsutil -i "service-account@google.com" ls gs://pub

              Note that this setting will be ignored by the XML API and S3. See
              'gsutil help creds' for more information on impersonating service
              accounts.

  -m          Causes supported operations (acl ch, acl set, cp, mv, rm, rsync,
              and setmeta) to run in parallel. This can significantly improve
              performance if you are performing operations on a large number of
              files over a reasonably fast network connection.

              gsutil performs the specified operation using a combination of
              multi-threading and multi-processing, using a number of threads
              and processors determined by the parallel_thread_count and
              parallel_process_count values set in the boto configuration
              file. You might want to experiment with these values, as the
              best values can vary based on a number of factors, including
              network speed, number of CPUs, and available memory.

              Using the -m option may make your performance worse if you
              are using a slower network, such as the typical network speeds
              offered by non-business home network plans. It can also make
              your performance worse for cases that perform all operations
              locally (e.g., gsutil rsync, where both source and destination
              URLs are on the local disk), because it can "thrash" your local
              disk.

              If a download or upload operation using parallel transfer fails
              before the entire transfer is complete (e.g. failing after 300 of
              1000 files have been transferred), you will need to restart the
              entire transfer.

              Also, although most commands will normally fail upon encountering
              an error when the -m flag is disabled, all commands will
              continue to try all operations when -m is enabled with multiple
              threads or processes, and the number of failed operations (if any)
              will be reported as an exception at the end of the command's
              execution.

  -o          Set/override values in the boto configuration value, in the format
              <section>:<name>=<value>, e.g. gsutil -o "Boto:proxy=host" ...
              This will not pass the option to gsutil integration tests, which
              run in a separate process.

  -q          Causes gsutil to perform operations quietly, i.e., without
              reporting progress indicators of files being copied or removed,
              etc. Errors are still reported. This option can be useful for
              running gsutil from a cron job that logs its output to a file, for
              which the only information desired in the log is failures.

  -u          Allows you to specify a user project to be billed for the request.
              For example:

                gsutil -u "bill-this-project" cp ...
```

To get information about your gsutil installation, use:

> gsutil version -l

```
gsutil version: 4.46
checksum: a8de0ea0f686569c68755bd18261872d (!= c51c2a8b6522b7ecf21b8a51fd31b812)
boto version: 2.49.0
python version: 2.7.13 (v2.7.13:a06454b1afa1, Dec 17 2016, 20:53:40) [MSC v.1500 64 bit (AMD64)]
OS: Windows 10
multiprocessing available: False
using cloud sdk: True
pass cloud sdk credentials to gsutil: True
config path(s): C:\Users\user1\.boto, C:\Users\user1\AppData\Roaming\gcloud\legacy_credentials\user1@company.com\.boto
gsutil path: C:\Users\user1\AppDirectory\Google\Cloud SDK\google-cloud-sdk\platform\gsutil\gsutil
compiled crcmod: True
installed via package manager: False
editable install: False
```
### Accessing public data
If you only want to access public data, follow the instructions in [Accessing Public Data](https://cloud.google.com/storage/docs/access-public-data).
By following the steps found in the gsutil tab, you can immediately access freely available, publicly accessible data; you do not need to sign up for a Google account or authenticate to Cloud Storage to use gsutil for this purpose.

[Reference Github Project](https://github.com/GoogleCloudPlatform/gsutil/)

[//]: #  (Copyright 2020 The MathWorks, Inc.)

From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Mon, 18 Jul 2016 11:03:53 +0100
Message-ID: <20160718100353.GA15163@stefanha-x1.localdomain>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3468614568887228108=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468816661-6345-3-git-send-email-namhyung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Namhyung Kim <namhyung@gmail.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Tony Luck <tony.luck@intel.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3468614568887228108==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> From: Namhyung Kim <namhyung@gmail.com>
>=20
> Add virtio pstore device to allow kernel log files saved on the host.
> It will save the log files on the directory given by pstore device
> option.
>=20
>   $ qemu-system-x86_64 -device virtio-pstore,directory=3Ddir-xx ...
>=20
>   (guest) # echo c > /proc/sysrq-trigger
>=20
>   $ ls dir-xx
>   dmesg-0.enc.z  dmesg-1.enc.z
>=20
> The log files are usually compressed using zlib.  Users can see the log
> messages directly on the host or on the guest (using pstore filesystem).

The implementation is synchronous (i.e. can pause guest code execution),
does not handle write errors, and does not limit the amount of data the
guest can write.  This is sufficient for ad-hoc debugging and usage with
trusted guests.

If you want this to be available in environments where the guest isn't
trusted then there must be a limit on how much the guest can write or
some kind of log rotation.

>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
>  hw/virtio/Makefile.objs                            |   2 +-
>  hw/virtio/virtio-pci.c                             |  50 ++++
>  hw/virtio/virtio-pci.h                             |  14 +
>  hw/virtio/virtio-pstore.c                          | 328 +++++++++++++++=
++++++
>  include/hw/pci/pci.h                               |   1 +
>  include/hw/virtio/virtio-pstore.h                  |  30 ++
>  include/standard-headers/linux/virtio_ids.h        |   1 +
>  .../linux/{virtio_ids.h =3D> virtio_pstore.h}        |  48 +--
>  qdev-monitor.c                                     |   1 +
>  9 files changed, 455 insertions(+), 20 deletions(-)
>  create mode 100644 hw/virtio/virtio-pstore.c
>  create mode 100644 include/hw/virtio/virtio-pstore.h
>  copy include/standard-headers/linux/{virtio_ids.h =3D> virtio_pstore.h} =
(63%)
>=20
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 3e2b175..aae7082 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -4,4 +4,4 @@ common-obj-y +=3D virtio-bus.o
>  common-obj-y +=3D virtio-mmio.o
> =20
>  obj-y +=3D virtio.o virtio-balloon.o=20
> -obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
> +obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o virtio-pst=
ore.o
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 2b34b43..8281b80 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2416,6 +2416,55 @@ static const TypeInfo virtio_host_pci_info =3D {
>  };
>  #endif
> =20
> +/* virtio-pstore-pci */
> +
> +static void virtio_pstore_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
> +{
> +    VirtIOPstorePCI *vps =3D VIRTIO_PSTORE_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&vps->vdev);
> +    Error *err =3D NULL;
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +}
> +
> +static void virtio_pstore_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->realize =3D virtio_pstore_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_PSTORE;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_pstore_pci_instance_init(Object *obj)
> +{
> +    VirtIOPstorePCI *dev =3D VIRTIO_PSTORE_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_PSTORE);
> +    object_property_add_alias(obj, "directory", OBJECT(&dev->vdev),
> +                              "directory", &error_abort);
> +}
> +
> +static const TypeInfo virtio_pstore_pci_info =3D {
> +    .name          =3D TYPE_VIRTIO_PSTORE_PCI,
> +    .parent        =3D TYPE_VIRTIO_PCI,
> +    .instance_size =3D sizeof(VirtIOPstorePCI),
> +    .instance_init =3D virtio_pstore_pci_instance_init,
> +    .class_init    =3D virtio_pstore_pci_class_init,
> +};
> +
>  /* virtio-pci-bus */
> =20
>  static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
> @@ -2485,6 +2534,7 @@ static void virtio_pci_register_types(void)
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> +    type_register_static(&virtio_pstore_pci_info);
>  }
> =20
>  type_init(virtio_pci_register_types)
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index e4548c2..b4c039f 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -31,6 +31,7 @@
>  #ifdef CONFIG_VHOST_SCSI
>  #include "hw/virtio/vhost-scsi.h"
>  #endif
> +#include "hw/virtio/virtio-pstore.h"
> =20
>  typedef struct VirtIOPCIProxy VirtIOPCIProxy;
>  typedef struct VirtIOBlkPCI VirtIOBlkPCI;
> @@ -44,6 +45,7 @@ typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
>  typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
> +typedef struct VirtIOPstorePCI VirtIOPstorePCI;
> =20
>  /* virtio-pci-bus */
> =20
> @@ -311,6 +313,18 @@ struct VirtIOGPUPCI {
>      VirtIOGPU vdev;
>  };
> =20
> +/*
> + * virtio-pstore-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_PSTORE_PCI "virtio-pstore-pci"
> +#define VIRTIO_PSTORE_PCI(obj) \
> +        OBJECT_CHECK(VirtIOPstorePCI, (obj), TYPE_VIRTIO_PSTORE_PCI)
> +
> +struct VirtIOPstorePCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOPstore vdev;
> +};
> +
>  /* Virtio ABI version, if we increment this, we break the guest driver. =
*/
>  #define VIRTIO_PCI_ABI_VERSION          0
> =20
> diff --git a/hw/virtio/virtio-pstore.c b/hw/virtio/virtio-pstore.c
> new file mode 100644
> index 0000000..98cee7f
> --- /dev/null
> +++ b/hw/virtio/virtio-pstore.c
> @@ -0,0 +1,328 @@
> +/*
> + * Virtio Pstore Device
> + *
> + * Copyright (C) 2016  LG Electronics
> + *
> + * Authors:
> + *  Namhyung Kim  <namhyung@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <stdio.h>
> +
> +#include "qemu/osdep.h"
> +#include "qemu/iov.h"
> +#include "qemu-common.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "qapi/visitor.h"
> +#include "qapi-event.h"
> +#include "trace.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-access.h"
> +#include "hw/virtio/virtio-pstore.h"
> +
> +
> +static void virtio_pstore_to_filename(VirtIOPstore *s, char *buf, size_t=
 sz,
> +                                      struct virtio_pstore_hdr *hdr)
> +{
> +    const char *basename;
> +
> +    switch (hdr->type) {

Missing le16_to_cpu()?

> +    case VIRTIO_PSTORE_TYPE_DMESG:
> +        basename =3D "dmesg";
> +        break;
> +    default:
> +        basename =3D "unknown";
> +        break;
> +    }
> +
> +    snprintf(buf, sz, "%s/%s-%llu%s", s->directory, basename,
> +             (unsigned long long) hdr->id,

Missing le64_to_cpu()?

> +             hdr->flags & VIRTIO_PSTORE_FL_COMPRESSED ? ".enc.z" : "");

Missing le32_to_cpu()?

> +}
> +
> +static void virtio_pstore_from_filename(VirtIOPstore *s, char *name,
> +                                        char *buf, size_t sz,
> +                                        struct virtio_pstore_hdr *hdr)
> +{
> +    size_t len =3D strlen(name);
> +
> +    hdr->flags =3D 0;
> +    if (!strncmp(name + len - 6, ".enc.z", 6)) {

Please use g_str_has_suffix(name, ".enc.z") to avoid accessing before
the beginning of the string if the filename is shorter than 6
characters.

> +        hdr->flags |=3D VIRTIO_PSTORE_FL_COMPRESSED;
> +    }
> +
> +    snprintf(buf, sz, "%s/%s", s->directory, name);
> +
> +    if (!strncmp(name, "dmesg-", 6)) {

g_str_has_prefix(name, "dmesg-")

> +        hdr->type =3D cpu_to_le16(VIRTIO_PSTORE_TYPE_DMESG);
> +        name +=3D 6;
> +    } else if (!strncmp(name, "unknown-", 8)) {

g_str_has_prefix(name, "unknown-")

> +        hdr->type =3D cpu_to_le16(VIRTIO_PSTORE_TYPE_UNKNOWN);
> +        name +=3D 8;
> +    }
> +
> +    qemu_strtoull(name, NULL, 0, &hdr->id);
> +}
> +
> +static ssize_t virtio_pstore_do_open(VirtIOPstore *s)
> +{
> +    s->dir =3D opendir(s->directory);
> +    if (s->dir =3D=3D NULL) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static ssize_t virtio_pstore_do_read(VirtIOPstore *s, void *buf, size_t =
sz,
> +                                      struct virtio_pstore_hdr *hdr)
> +{
> +    char path[PATH_MAX];
> +    FILE *fp;
> +    ssize_t len;
> +    struct stat stbuf;
> +    struct dirent *dent;
> +
> +    if (s->dir =3D=3D NULL) {
> +        return -1;
> +    }
> +
> +    dent =3D readdir(s->dir);
> +    while (dent) {
> +        if (dent->d_name[0] !=3D '.') {
> +            break;
> +        }
> +        dent =3D readdir(s->dir);
> +    }
> +
> +    if (dent =3D=3D NULL) {
> +        return 0;
> +    }
> +
> +    virtio_pstore_from_filename(s, dent->d_name, path, sizeof(path), hdr=
);
> +    if (stat(path, &stbuf) < 0) {
> +        return -1;
> +    }

Please use fstat(fileno(fp), &stbuf) after opening the file instead.
The race condition doesn't matter in this case but the race-free code is
just as simple so it's one less thing someone reading the code has to
worry about.

> +
> +    fp =3D fopen(path, "r");
> +    if (fp =3D=3D NULL) {
> +        error_report("cannot open %s (%p %p)", path, s, s->directory);
> +        return -1;
> +    }
> +
> +    len =3D fread(buf, 1, sz, fp);
> +    if (len < 0 && errno =3D=3D EAGAIN) {
> +        len =3D 0;
> +    }
> +
> +    hdr->id =3D cpu_to_le64(hdr->id);
> +    hdr->flags =3D cpu_to_le32(hdr->flags);
> +    hdr->time_sec =3D cpu_to_le64(stbuf.st_ctim.tv_sec);
> +    hdr->time_nsec =3D cpu_to_le32(stbuf.st_ctim.tv_nsec);
> +
> +    fclose(fp);
> +    return len;
> +}
> +
> +static ssize_t virtio_pstore_do_write(VirtIOPstore *s, void *buf, size_t=
 sz,
> +                                      struct virtio_pstore_hdr *hdr)
> +{
> +    char path[PATH_MAX];
> +    FILE *fp;
> +
> +    virtio_pstore_to_filename(s, path, sizeof(path), hdr);
> +
> +    fp =3D fopen(path, "w");
> +    if (fp =3D=3D NULL) {
> +        error_report("cannot open %s (%p %p)", path, s, s->directory);
> +        return -1;
> +    }
> +    fwrite(buf, 1, sz, fp);
> +    fclose(fp);
> +
> +    return sz;
> +}
> +
> +static ssize_t virtio_pstore_do_close(VirtIOPstore *s)
> +{
> +    if (s->dir =3D=3D NULL) {
> +        return 0;
> +    }
> +
> +    closedir(s->dir);
> +    s->dir =3D NULL;
> +
> +    return 0;
> +}
> +
> +static ssize_t virtio_pstore_do_erase(VirtIOPstore *s,
> +                                      struct virtio_pstore_hdr *hdr)
> +{
> +    char path[PATH_MAX];
> +
> +    virtio_pstore_to_filename(s, path, sizeof(path), hdr);
> +
> +    return unlink(path);
> +}
> +
> +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOPstore *s =3D VIRTIO_PSTORE(vdev);
> +    VirtQueueElement *elem;
> +    struct virtio_pstore_hdr *hdr;
> +    ssize_t len;
> +
> +    for (;;) {
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            return;
> +        }
> +
> +        hdr =3D elem->out_sg[0].iov_base;
> +        if (elem->out_sg[0].iov_len !=3D sizeof(*hdr)) {
> +            error_report("invalid header size: %u",
> +                         (unsigned)elem->out_sg[0].iov_len);
> +            exit(1);
> +        }

Please use iov_to_buf() instead of directly accessing out_sg[].  Virtio
devices are not supposed to assume a particular iovec layout.  In other
words, virtio_pstore_hdr could be split across multiple out_sg[] iovecs.

You must also copy in data (similar to Linux syscall implementations) to
prevent the guest from modifying data while the command is processed.
Such race conditions could lead to security bugs.

> +
> +        switch (hdr->cmd) {
> +        case VIRTIO_PSTORE_CMD_OPEN:
> +            len =3D virtio_pstore_do_open(s);
> +            break;
> +        case VIRTIO_PSTORE_CMD_READ:
> +            len =3D virtio_pstore_do_read(s, elem->in_sg[0].iov_base,
> +                                        elem->in_sg[0].iov_len, hdr);

Same issue with iovec layout for in_sg[] here.  The guest driver must be
able to submit any in_sg[] iovec array and the device cannot assume
in_sg[0] is the only iovec to fill.

> +            break;
> +        case VIRTIO_PSTORE_CMD_WRITE:
> +            len =3D virtio_pstore_do_write(s, elem->out_sg[1].iov_base,
> +                                         elem->out_sg[1].iov_len, hdr);
> +            break;
> +        case VIRTIO_PSTORE_CMD_CLOSE:
> +            len =3D virtio_pstore_do_close(s);
> +            break;
> +        case VIRTIO_PSTORE_CMD_ERASE:
> +            len =3D virtio_pstore_do_erase(s, hdr);
> +            break;
> +        default:
> +            len =3D -1;
> +            break;
> +        }
> +
> +        if (len < 0) {
> +            return;
> +        }
> +
> +        virtqueue_push(vq, elem, len);
> +
> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}
> +
> +static void virtio_pstore_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOPstore *s =3D VIRTIO_PSTORE(dev);
> +
> +    virtio_init(vdev, "virtio-pstore", VIRTIO_ID_PSTORE, 0);
> +
> +    s->vq =3D virtio_add_queue(vdev, 128, virtio_pstore_handle_io);
> +}
> +
> +static void virtio_pstore_device_unrealize(DeviceState *dev, Error **err=
p)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +
> +    virtio_cleanup(vdev);
> +}
> +
> +static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **err=
p)
> +{
> +    return f;
> +}
> +
> +static void pstore_get_directory(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    VirtIOPstore *s =3D opaque;
> +
> +    visit_type_str(v, name, &s->directory, errp);
> +}
> +
> +static void pstore_set_directory(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    VirtIOPstore *s =3D opaque;
> +    Error *local_err =3D NULL;
> +    char *value;
> +
> +    visit_type_str(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    g_free(s->directory);
> +    s->directory =3D strdup(value);

Please use g_strdup() since this is paired with g_free().

Or even simpler would be s->directory =3D value and do not g_free(value)
below.

> +
> +    g_free(value);
> +}
> +
> +static void pstore_release_directory(Object *obj, const char *name,
> +                                     void *opaque)
> +{
> +    VirtIOPstore *s =3D opaque;
> +
> +    g_free(s->directory);
> +    s->directory =3D NULL;
> +}
> +
> +static Property virtio_pstore_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_pstore_instance_init(Object *obj)
> +{
> +    VirtIOPstore *s =3D VIRTIO_PSTORE(obj);
> +
> +    object_property_add(obj, "directory", "str",
> +                        pstore_get_directory, pstore_set_directory,
> +                        pstore_release_directory, s, NULL);
> +}
> +
> +static void virtio_pstore_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +
> +    dc->props =3D virtio_pstore_properties;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    vdc->realize =3D virtio_pstore_device_realize;
> +    vdc->unrealize =3D virtio_pstore_device_unrealize;
> +    vdc->get_features =3D get_features;
> +}
> +
> +static const TypeInfo virtio_pstore_info =3D {
> +    .name =3D TYPE_VIRTIO_PSTORE,
> +    .parent =3D TYPE_VIRTIO_DEVICE,
> +    .instance_size =3D sizeof(VirtIOPstore),
> +    .instance_init =3D virtio_pstore_instance_init,
> +    .class_init =3D virtio_pstore_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_pstore_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 9ed1624..5689c6f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -79,6 +79,7 @@
>  #define PCI_DEVICE_ID_VIRTIO_SCSI        0x1004
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> +#define PCI_DEVICE_ID_VIRTIO_PSTORE      0x100a
> =20
>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> diff --git a/include/hw/virtio/virtio-pstore.h b/include/hw/virtio/virtio=
-pstore.h
> new file mode 100644
> index 0000000..74cd1f6
> --- /dev/null
> +++ b/include/hw/virtio/virtio-pstore.h
> @@ -0,0 +1,30 @@
> +/*
> + * Virtio Pstore Support
> + *
> + * Authors:
> + *  Namhyung Kim      <namhyung@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef _QEMU_VIRTIO_PSTORE_H
> +#define _QEMU_VIRTIO_PSTORE_H
> +
> +#include "standard-headers/linux/virtio_pstore.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/pci/pci.h"
> +
> +#define TYPE_VIRTIO_PSTORE "virtio-pstore-device"
> +#define VIRTIO_PSTORE(obj) \
> +        OBJECT_CHECK(VirtIOPstore, (obj), TYPE_VIRTIO_PSTORE)
> +
> +typedef struct VirtIOPstore {
> +    VirtIODevice parent_obj;
> +    VirtQueue *vq;
> +    char *directory;
> +    DIR *dir;
> +} VirtIOPstore;
> +
> +#endif
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
> index 77925f5..cba6322 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -41,5 +41,6 @@
>  #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
>  #define VIRTIO_ID_GPU          16 /* virtio GPU */
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
> +#define VIRTIO_ID_PSTORE       19 /* virtio pstore */

19 has already been reserved.  22 is the next free ID (vsock, crypto,
and sdm are currently under review and already use 19, 20, and 21).

Please send a VIRTIO draft specification to
virtio-dev@lists.oasis-open.org.  You can find information on the VIRTIO
standards process here:
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXjKmJAAoJEJykq7OBq3PIMokIAJ4ObDEQn0YnvKvAKTnSYkBw
2hmMZwBO5yPWIuN0uzUtjprNqLvOpCpLoywAgH5PhK5IyL47dgNf9pL+vhR/0EG/
5+E5gc0nvMEq/+66kLTQQPJ0SXkEJ6OZwJbjiJsO6wQJEZwqjubESZfNBumE2j88
BhFPrkcBBGzyxjdJj4vze1lWLMB3dBJoibF2WBLhgHICy9W4wrOJi8dH8/Gn8E1u
g7pM4DqEFtqnKOSvYmAZjMrg3+Wvu9oOuS9569lUxbNKtQ8392TKwDK0t3NCNvwP
4zD9bHbV8tHxVNIoIFxQJZU2iHtKCKpodVNu8f8g8BWDOvFhi8653rwlLEfKPpQ=
=lSPW
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============3468614568887228108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3468614568887228108==--

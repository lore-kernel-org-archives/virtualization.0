From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 9/9] vhost-scsi: add -vhost-scsi host device
Date: Wed, 25 Jul 2012 08:58:41 +0200
Message-ID: <500F9921.5070807@redhat.com>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
	<1343169246-17636-10-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-10-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 25/07/2012 00:34, Nicholas A. Bellinger ha scritto:
> From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> 
> This patch adds a new type of host device that drives the vhost_scsi
> device.  The syntax to add vhost-scsi is:
> 
>   qemu -vhost-scsi id=vhost-scsi0,wwpn=...,tpgt=123
> 
> The virtio-scsi emulated device will make use of vhost-scsi to process
> virtio-scsi requests inside the kernel and hand them to the in-kernel
> SCSI target stack.
> 
> Changelog v0 -> v1:
> 
> - Add VHOST_SCSI_SET_ENDPOINT call (stefan)
> - Enable vhost notifiers for multiple queues (Zhi)
> - clear vhost-scsi endpoint on stopped (Zhi)
> - Add CONFIG_VHOST_SCSI for QEMU build configure (nab)
> - Rename vhost_vring_target -> vhost_scsi_target (mst + nab)
> - Add support for VHOST_SCSI_GET_ABI_VERSION ioctl (aliguori + nab)
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Signed-off-by: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> Cc: Anthony Liguori <aliguori@us.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  configure            |   10 +++
>  hw/Makefile.objs     |    1 +
>  hw/qdev-properties.c |   32 +++++++++
>  hw/qdev.h            |    3 +
>  hw/vhost-scsi.c      |  173 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vhost-scsi.h      |   50 ++++++++++++++
>  qemu-common.h        |    1 +
>  qemu-config.c        |   16 +++++
>  qemu-options.hx      |    4 +
>  vl.c                 |   18 +++++
>  10 files changed, 308 insertions(+), 0 deletions(-)
>  create mode 100644 hw/vhost-scsi.c
>  create mode 100644 hw/vhost-scsi.h
> 
> diff --git a/configure b/configure
> index cef0a71..2291e7e 100755
> --- a/configure
> +++ b/configure
> @@ -144,6 +144,7 @@ libattr=""
>  xfs=""
>  
>  vhost_net="no"
> +vhost_scsi="no"
>  kvm="no"
>  gprof="no"
>  debug_tcg="no"
> @@ -489,6 +490,7 @@ Haiku)
>    usb="linux"
>    kvm="yes"
>    vhost_net="yes"
> +  vhost_scsi="yes"
>    if [ "$cpu" = "i386" -o "$cpu" = "x86_64" ] ; then
>      audio_possible_drivers="$audio_possible_drivers fmod"
>    fi
> @@ -794,6 +796,10 @@ for opt do
>    ;;
>    --enable-vhost-net) vhost_net="yes"
>    ;;
> +  --disable-vhost-net) vhost_scsi="no"
> +  ;;
> +  --enable-vhost-net) vhost_scsi="yes"
> +  ;;

Case labels are using vhost-net.

>    --disable-opengl) opengl="no"
>    ;;
>    --enable-opengl) opengl="yes"
> @@ -3059,6 +3065,7 @@ echo "posix_madvise     $posix_madvise"
>  echo "uuid support      $uuid"
>  echo "libcap-ng support $cap_ng"
>  echo "vhost-net support $vhost_net"
> +echo "vhost-scsi support $vhost_scsi"
>  echo "Trace backend     $trace_backend"
>  echo "Trace output file $trace_file-<pid>"
>  echo "spice support     $spice"
> @@ -3762,6 +3769,9 @@ case "$target_arch2" in
>        if test "$vhost_net" = "yes" ; then
>          echo "CONFIG_VHOST_NET=y" >> $config_target_mak
>        fi
> +      if test "$vhost_scsi" = "yes" ; then
> +        echo "CONFIG_VHOST_SCSI=y" >> $config_target_mak
> +      fi
>      fi
>  esac
>  case "$target_arch2" in
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 8327e55..37a0d0e 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -161,6 +161,7 @@ obj-$(CONFIG_VIRTIO) += virtio.o virtio-blk.o virtio-balloon.o virtio-net.o
>  obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o virtio-scsi.o
>  obj-$(CONFIG_SOFTMMU) += vhost_net.o
>  obj-$(CONFIG_VHOST_NET) += vhost.o
> +obj-$(CONFIG_VHOST_SCSI) += vhost-scsi.o
>  obj-$(CONFIG_REALLY_VIRTFS) += 9pfs/
>  obj-$(CONFIG_NO_PCI) += pci-stub.o
>  obj-$(CONFIG_VGA) += vga.o
> diff --git a/hw/qdev-properties.c b/hw/qdev-properties.c
> index 24b39e8..0c538d2 100644
> --- a/hw/qdev-properties.c
> +++ b/hw/qdev-properties.c
> @@ -3,6 +3,7 @@
>  #include "qerror.h"
>  #include "blockdev.h"
>  #include "hw/block-common.h"
> +#include "vhost-scsi.h"
>  
>  void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
>  {
> @@ -685,6 +686,37 @@ PropertyInfo qdev_prop_vlan = {
>      .set   = set_vlan,
>  };
>  
> +/* --- vhost-scsi --- */
> +
> +static int parse_vhost_scsi(DeviceState *dev, Property *prop, const char *str)
> +{
> +    VHostSCSI **ptr = qdev_get_prop_ptr(dev, prop);
> +
> +    *ptr = find_vhost_scsi(str);
> +    if (*ptr == NULL) {
> +        return -ENOENT;
> +    }
> +    return 0;
> +}
> +
> +static int print_vhost_scsi(DeviceState *dev, Property *prop,
> +                            char *dest, size_t len)
> +{
> +    VHostSCSI **ptr = qdev_get_prop_ptr(dev, prop);
> +
> +    if (*ptr) {
> +        return snprintf(dest, len, "%s", vhost_scsi_get_id(*ptr));
> +    } else {
> +        return snprintf(dest, len, "<null>");
> +    }
> +}
> +
> +PropertyInfo qdev_prop_vhost_scsi = {
> +    .name  = "vhost-scsi",
> +    .parse = parse_vhost_scsi,
> +    .print = print_vhost_scsi,
> +};

This has changed, see how we do get_netdev/set_netdev.

>  /* --- pointer --- */
>  
>  /* Not a proper property, just for dirty hacks.  TODO Remove it!  */
> diff --git a/hw/qdev.h b/hw/qdev.h
> index a2cbd9d..ddc0791 100644
> --- a/hw/qdev.h
> +++ b/hw/qdev.h
> @@ -238,6 +238,7 @@ extern PropertyInfo qdev_prop_vlan;
>  extern PropertyInfo qdev_prop_pci_devfn;
>  extern PropertyInfo qdev_prop_blocksize;
>  extern PropertyInfo qdev_prop_pci_host_devaddr;
> +extern PropertyInfo qdev_prop_vhost_scsi;
>  
>  #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
>          .name      = (_name),                                    \
> @@ -305,6 +306,8 @@ extern PropertyInfo qdev_prop_pci_host_devaddr;
>      DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_blocksize, uint16_t)
>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
> +#define DEFINE_PROP_VHOST_SCSI(_n, _s, _f)       \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_vhost_scsi, VHostSCSI*)
>  
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
> new file mode 100644
> index 0000000..9ab314c
> --- /dev/null
> +++ b/hw/vhost-scsi.c
> @@ -0,0 +1,173 @@
> +/*
> + * vhost_scsi host device
> + *
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include <sys/ioctl.h>
> +#include "config.h"
> +#include "qemu-queue.h"
> +#include "vhost-scsi.h"
> +#include "vhost.h"
> +
> +struct VHostSCSI {
> +    const char *id;
> +    const char *wwpn;
> +    uint16_t tpgt;
> +    struct vhost_dev dev;
> +    struct vhost_virtqueue vqs[3];
> +    QLIST_ENTRY(VHostSCSI) list;
> +};
> +
> +static QLIST_HEAD(, VHostSCSI) vhost_scsi_list =
> +    QLIST_HEAD_INITIALIZER(vhost_scsi_list);
> +
> +VHostSCSI *find_vhost_scsi(const char *id)
> +{
> +    VHostSCSI *vs;
> +
> +    QLIST_FOREACH(vs, &vhost_scsi_list, list) {
> +        if (strcmp(id, vs->id) == 0) {
> +            return vs;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +const char *vhost_scsi_get_id(VHostSCSI *vs)
> +{
> +    return vs->id;
> +}
> +
> +int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev)
> +{
> +    int ret;
> +    struct vhost_scsi_target backend;
> +
> +    if (!vhost_dev_query(&vs->dev, vdev)) {
> +        return -ENOTSUP;
> +    }
> +
> +    vs->dev.nvqs = 3;
> +    vs->dev.vqs = vs->vqs;
> +
> +    ret = vhost_dev_enable_notifiers(&vs->dev, vdev);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vhost_dev_start(&vs->dev, vdev);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    memset(&backend, 0, sizeof(backend));
> +    ret = ioctl(vs->dev.control, VHOST_SCSI_GET_ABI_VERSION, &backend);
> +    if (ret < 0) {
> +        ret = -errno;
> +        vhost_dev_stop(&vs->dev, vdev);
> +        return ret;
> +    }
> +    if (backend.abi_version > VHOST_SCSI_ABI_VERSION) {
> +        fprintf(stderr, "The running tcm_vhost kernel abi_version: %d is greater"
> +		" than vhost_scsi userspace supports: %d\n", backend.abi_version,
> +		VHOST_SCSI_ABI_VERSION);
> +        ret = -ENOSYS;
> +        vhost_dev_stop(&vs->dev, vdev);
> +        return ret;
> +    }
> +    printf("Using TCM_Vhost ABI version: %d\n", backend.abi_version);
> +
> +    pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
> +    backend.vhost_tpgt = vs->tpgt;
> +    ret = ioctl(vs->dev.control, VHOST_SCSI_SET_ENDPOINT, &backend);
> +    if (ret < 0) {
> +        ret = -errno;
> +        vhost_dev_stop(&vs->dev, vdev);
> +        return ret;
> +    }
> +
> +    fprintf(stderr, "vhost_scsi_start\n");
> +    return 0;
> +}
> +
> +void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
> +{
> +    fprintf(stderr, "vhost_scsi_stop\n");
> +
> +    int ret;
> +    struct vhost_scsi_target backend;
> +
> +    pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
> +    backend.vhost_tpgt = vs->tpgt;
> +    ret = ioctl(vs->dev.control, VHOST_SCSI_CLEAR_ENDPOINT, &backend);
> +    if (ret < 0) {
> +        fprintf(stderr, "Failed to clear endpoint\n");
> +    }
> +
> +    vhost_dev_stop(&vs->dev, vdev);
> +}
> +
> +static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> +                                 uint16_t tpgt)
> +{
> +    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> +    int ret;
> +
> +    /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
> +    fprintf(stderr, "wwpn = \"%s\" tpgt = \"%u\"\n", id, tpgt);
> +
> +    ret = vhost_dev_init(&vs->dev, -1, "/dev/vhost-scsi", false);
> +    if (ret < 0) {
> +        fprintf(stderr, "vhost-scsi: vhost initialization failed: %s\n",
> +                strerror(-ret));
> +        return NULL;
> +    }
> +    vs->dev.backend_features = 0;
> +    vs->dev.acked_features = 0;
> +
> +    vs->id = g_strdup(id);
> +    vs->wwpn = g_strdup(wwpn);
> +    vs->tpgt = tpgt;
> +    QLIST_INSERT_HEAD(&vhost_scsi_list, vs, list);
> +
> +    return vs;
> +}
> +
> +VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts)
> +{
> +    const char *id;
> +    const char *wwpn;
> +    uint64_t tpgt;
> +
> +    id = qemu_opts_id(opts);
> +    if (!id) {
> +        fprintf(stderr, "vhost-scsi: no id specified\n");
> +        return NULL;
> +    }
> +    if (find_vhost_scsi(id)) {
> +        fprintf(stderr, "duplicate vhost-scsi: \"%s\"\n", id);
> +        return NULL;
> +    }
> +
> +    wwpn = qemu_opt_get(opts, "wwpn");
> +    if (!wwpn) {
> +        fprintf(stderr, "vhost-scsi: \"%s\" missing wwpn\n", id);
> +        return NULL;
> +    }
> +
> +    tpgt = qemu_opt_get_number(opts, "tpgt", UINT64_MAX);
> +    if (tpgt > UINT16_MAX) {
> +        fprintf(stderr, "vhost-scsi: \"%s\" needs a 16-bit tpgt\n", id);
> +        return NULL;
> +    }
> +
> +    return vhost_scsi_add(id, wwpn, tpgt);
> +}
> diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
> new file mode 100644
> index 0000000..fb6d37a
> --- /dev/null
> +++ b/hw/vhost-scsi.h
> @@ -0,0 +1,50 @@
> +/*
> + * vhost_scsi host device
> + *
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#ifndef VHOST_SCSI_H
> +#define VHOST_SCSI_H
> +
> +#include "qemu-common.h"
> +#include "qemu-option.h"
> +
> +/*
> + * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
> + *
> + * ABI Rev 0: All pre 2012 revisions used by prototype out-of-tree code
> + * ABI Rev 1: 2012 version for v3.6 kernel merge candidate
> + */
> +
> +#define VHOST_SCSI_ABI_VERSION	1
> +
> +/* TODO #include <linux/vhost.h> properly */
> +/* For VHOST_SCSI_SET_ENDPOINT/VHOST_SCSI_CLEAR_ENDPOINT ioctl */
> +struct vhost_scsi_target {
> +    int abi_version;
> +    unsigned char vhost_wwpn[224];
> +    unsigned short vhost_tpgt;
> +};
> +
> +#define VHOST_VIRTIO 0xAF
> +#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
> +#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
> +#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, struct vhost_scsi_target)
> +
> +VHostSCSI *find_vhost_scsi(const char *id);
> +const char *vhost_scsi_get_id(VHostSCSI *vs);
> +
> +VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts);
> +
> +int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev);
> +void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev);
> +
> +#endif
> diff --git a/qemu-common.h b/qemu-common.h
> index 7c8dac8..ce431b7 100644
> --- a/qemu-common.h
> +++ b/qemu-common.h
> @@ -262,6 +262,7 @@ typedef struct EventNotifier EventNotifier;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct QEMUSGList QEMUSGList;
>  typedef struct SHPCDevice SHPCDevice;
> +typedef struct VHostSCSI VHostSCSI;
>  
>  typedef uint64_t pcibus_t;
>  
> diff --git a/qemu-config.c b/qemu-config.c
> index 5c3296b..33399ea 100644
> --- a/qemu-config.c
> +++ b/qemu-config.c
> @@ -626,6 +626,21 @@ QemuOptsList qemu_boot_opts = {
>      },
>  };
>  
> +QemuOptsList qemu_vhost_scsi_opts = {
> +    .name = "vhost-scsi",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_vhost_scsi_opts.head),
> +    .desc = {
> +        {
> +            .name = "wwpn",
> +            .type = QEMU_OPT_STRING,
> +        }, {
> +            .name = "tpgt",
> +            .type = QEMU_OPT_NUMBER,
> +        },

Why have the wwpn and tpgt (which should really be tgpt) both in
vhost-scsi and in virtio-scsi?  Can we just add them to vhost-scsi?

> +        { /* end of list */ }
> +    },
> +};
> +
>  static QemuOptsList *vm_config_groups[32] = {
>      &qemu_drive_opts,
>      &qemu_chardev_opts,
> @@ -641,6 +656,7 @@ static QemuOptsList *vm_config_groups[32] = {
>      &qemu_machine_opts,
>      &qemu_boot_opts,
>      &qemu_iscsi_opts,
> +    &qemu_vhost_scsi_opts,
>      NULL,
>  };
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc68e15..c3911a8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -561,6 +561,10 @@ possible drivers and properties, use @code{-device ?} and
>  ETEXI
>  
>  DEFHEADING()
> +DEF("vhost-scsi", HAS_ARG, QEMU_OPTION_vhost_scsi,
> +    "-virtio-scsi wwpn=string0,tpgt=number0\n"

-vhost-scsi, not -virtio-scsi.

> +    "                add vhost-scsi device\n",
> +    QEMU_ARCH_ALL)
>  
>  DEFHEADING(File system options:)
>  
> diff --git a/vl.c b/vl.c
> index 8904db1..063ca1d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -143,6 +143,7 @@ int main(int argc, char **argv)
>  #include "qemu-options.h"
>  #include "qmp-commands.h"
>  #include "main-loop.h"
> +#include "hw/vhost-scsi.h"
>  #ifdef CONFIG_VIRTFS
>  #include "fsdev/qemu-fsdev.h"
>  #endif
> @@ -1854,6 +1855,14 @@ static int fsdev_init_func(QemuOpts *opts, void *opaque)
>  }
>  #endif
>  
> +static int vhost_scsi_init_func(QemuOpts *opts, void *opaque)
> +{
> +    if (!vhost_scsi_add_opts(opts)) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>  static int mon_init_func(QemuOpts *opts, void *opaque)
>  {
>      CharDriverState *chr;
> @@ -2613,6 +2622,11 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>  #endif
> +            case QEMU_OPTION_vhost_scsi:
> +                if (!qemu_opts_parse(qemu_find_opts("vhost-scsi"), optarg, 0)) {
> +                    exit(1);
> +                }
> +                break;
>  #ifdef CONFIG_SLIRP
>              case QEMU_OPTION_tftp:
>                  legacy_tftp_prefix = optarg;
> @@ -3333,6 +3347,10 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  #endif
> +    if (qemu_opts_foreach(qemu_find_opts("vhost-scsi"),
> +                          vhost_scsi_init_func, NULL, 1)) {
> +        exit(1);
> +    }
>  
>      os_daemonize();
>  
> 

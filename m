From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host device for use
	with tcm-vhost
Date: Tue, 14 Aug 2012 14:12:29 -0700
Message-ID: <1344978749.22433.116.camel__5350.78653269938$1344978768$gmane$org@haakon2.linux-iscsi.org>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<20120813085929.GI14081@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120813085929.GI14081@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-08-13 at 11:59 +0300, Michael S. Tsirkin wrote:
> On Mon, Aug 13, 2012 at 08:35:14AM +0000, Nicholas A. Bellinger wrote:
> > From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> > 
> > This patch adds a new type of host device that drives the vhost_scsi
> > device.  The syntax to add vhost-scsi is:
> > 
> >   qemu -vhost-scsi id=vhost-scsi0,wwpn=...,tpgt=123
> > 
> > The virtio-scsi emulated device will make use of vhost-scsi to process
> > virtio-scsi requests inside the kernel and hand them to the in-kernel
> > SCSI target stack using the tcm_vhost fabric driver.
> > 
> > The tcm_vhost driver was merged into the upstream linux kernel for 3.6-rc2,
> > and the commit can be found here:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=057cbf49a1f08297
> > 
> > Changelog v1 -> v2:
> > 
> > - Expose ABI version via VHOST_SCSI_GET_ABI_VERSION + use Rev 0 as
> >   starting point for v3.6-rc code (Stefan + ALiguori + nab)
> > - Fix upstream qemu conflict in hw/qdev-properties.c
> > - Make GET_ABI_VERSION use int (nab + mst)
> > - Fix vhost-scsi case lables in configure (reported by paolo)
> > - Convert qdev_prop_vhost_scsi to use ->get() + ->set() following
> >   qdev_prop_netdev (reported by paolo)
> > - Fix typo in qemu-options.hx definition of vhost-scsi (reported by paolo)
> > 
> > Changelog v0 -> v1:
> > 
> > - Add VHOST_SCSI_SET_ENDPOINT call (stefan)
> > - Enable vhost notifiers for multiple queues (Zhi)
> > - clear vhost-scsi endpoint on stopped (Zhi)
> > - Add CONFIG_VHOST_SCSI for QEMU build configure (nab)
> > - Rename vhost_vring_target -> vhost_scsi_target (mst + nab)
> > - Add support for VHOST_SCSI_GET_ABI_VERSION ioctl (aliguori + nab)
> > 
> > Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> > Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> > Cc: Anthony Liguori <aliguori@us.ibm.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> 
> Sent mail too fast, sorry. More comments below.
> 
> > ---
> >  configure            |   10 +++
> >  hw/Makefile.objs     |    1 +
> >  hw/qdev-properties.c |   40 ++++++++++++
> >  hw/qdev.h            |    3 +
> >  hw/vhost-scsi.c      |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/vhost-scsi.h      |   50 +++++++++++++++
> >  qemu-common.h        |    1 +
> >  qemu-config.c        |   16 +++++
> >  qemu-options.hx      |    4 +
> >  vl.c                 |   18 +++++
> >  10 files changed, 313 insertions(+), 0 deletions(-)
> >  create mode 100644 hw/vhost-scsi.c
> >  create mode 100644 hw/vhost-scsi.h
> > 
> > diff --git a/configure b/configure
> > index f0dbc03..1f03202 100755
> > --- a/configure
> > +++ b/configure
> > @@ -168,6 +168,7 @@ libattr=""
> >  xfs=""
> >  
> >  vhost_net="no"
> > +vhost_scsi="no"
> >  kvm="no"
> >  gprof="no"
> >  debug_tcg="no"
> > @@ -513,6 +514,7 @@ Haiku)
> >    usb="linux"
> >    kvm="yes"
> >    vhost_net="yes"
> > +  vhost_scsi="yes"
> >    if [ "$cpu" = "i386" -o "$cpu" = "x86_64" ] ; then
> >      audio_possible_drivers="$audio_possible_drivers fmod"
> >    fi
> > @@ -818,6 +820,10 @@ for opt do
> >    ;;
> >    --enable-vhost-net) vhost_net="yes"
> >    ;;
> > +  --disable-vhost-scsi) vhost_scsi="no"
> > +  ;;
> > +  --enable-vhost-scsi) vhost_scsi="yes"
> > +  ;;
> >    --disable-opengl) opengl="no"
> >    ;;
> >    --enable-opengl) opengl="yes"
> > @@ -3116,6 +3122,7 @@ echo "posix_madvise     $posix_madvise"
> >  echo "uuid support      $uuid"
> >  echo "libcap-ng support $cap_ng"
> >  echo "vhost-net support $vhost_net"
> > +echo "vhost-scsi support $vhost_scsi"
> >  echo "Trace backend     $trace_backend"
> >  echo "Trace output file $trace_file-<pid>"
> >  echo "spice support     $spice"
> > @@ -3828,6 +3835,9 @@ case "$target_arch2" in
> >        if test "$vhost_net" = "yes" ; then
> >          echo "CONFIG_VHOST_NET=y" >> $config_target_mak
> >        fi
> > +      if test "$vhost_scsi" = "yes" ; then
> > +        echo "CONFIG_VHOST_SCSI=y" >> $config_target_mak
> > +      fi
> >      fi
> >  esac
> >  case "$target_arch2" in
> > diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> > index 3ba5dd0..6ab75ec 100644
> > --- a/hw/Makefile.objs
> > +++ b/hw/Makefile.objs
> > @@ -169,6 +169,7 @@ obj-$(CONFIG_VIRTIO) += virtio.o virtio-blk.o virtio-balloon.o virtio-net.o
> >  obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o virtio-scsi.o
> >  obj-$(CONFIG_SOFTMMU) += vhost_net.o
> >  obj-$(CONFIG_VHOST_NET) += vhost.o
> > +obj-$(CONFIG_VHOST_SCSI) += vhost-scsi.o
> >  obj-$(CONFIG_REALLY_VIRTFS) += 9pfs/
> >  obj-$(CONFIG_NO_PCI) += pci-stub.o
> >  obj-$(CONFIG_VGA) += vga.o
> > diff --git a/hw/qdev-properties.c b/hw/qdev-properties.c
> > index 8aca0d4..0266266 100644
> > --- a/hw/qdev-properties.c
> > +++ b/hw/qdev-properties.c
> > @@ -4,6 +4,7 @@
> >  #include "blockdev.h"
> >  #include "hw/block-common.h"
> >  #include "net/hub.h"
> > +#include "vhost-scsi.h"
> >  
> >  void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
> >  {
> > @@ -696,6 +697,45 @@ PropertyInfo qdev_prop_vlan = {
> >      .set   = set_vlan,
> >  };
> >  
> > +/* --- vhost-scsi --- */
> > +
> > +static int parse_vhost_scsi_dev(DeviceState *dev, const char *str, void **ptr)
> > +{
> > +   VHostSCSI *p;
> > +
> > +   p = find_vhost_scsi(str);
> > +   if (p == NULL)
> > +       return -ENOENT;
> > +
> > +   *ptr = p;
> > +   return 0;
> > +}
> > +
> > +static const char *print_vhost_scsi_dev(void *ptr)
> > +{
> > +    VHostSCSI *p = ptr;
> > +
> > +    return (p) ? vhost_scsi_get_id(p) : "<null>";
> > +}
> > +
> > +static void get_vhost_scsi_dev(Object *obj, Visitor *v, void *opaque,
> > +                       const char *name, Error **errp)
> > +{
> > +    get_pointer(obj, v, opaque, print_vhost_scsi_dev, name, errp);
> > +}
> > +
> > +static void set_vhost_scsi_dev(Object *obj, Visitor *v, void *opaque,
> > +                               const char *name, Error **errp)
> > +{
> > +    set_pointer(obj, v, opaque, parse_vhost_scsi_dev, name, errp);
> > +}
> > +
> > +PropertyInfo qdev_prop_vhost_scsi = {
> > +     .name = "vhost-scsi",
> > +     .get  = get_vhost_scsi_dev,
> > +     .set  = set_vhost_scsi_dev,
> > +};
> > +
> >  /* --- pointer --- */
> >  
> >  /* Not a proper property, just for dirty hacks.  TODO Remove it!  */
> 
> Why does this make sense in the generic qdev-properties?
> There's exactly one device that can use this, no?
> 

Mmmm, not sure on this one either..  Stefan..?

> > diff --git a/hw/qdev.h b/hw/qdev.h
> > index d699194..d5873bb 100644
> > --- a/hw/qdev.h
> > +++ b/hw/qdev.h
> > @@ -238,6 +238,7 @@ extern PropertyInfo qdev_prop_vlan;
> >  extern PropertyInfo qdev_prop_pci_devfn;
> >  extern PropertyInfo qdev_prop_blocksize;
> >  extern PropertyInfo qdev_prop_pci_host_devaddr;
> > +extern PropertyInfo qdev_prop_vhost_scsi;
> >  
> >  #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
> >          .name      = (_name),                                    \
> > @@ -305,6 +306,8 @@ extern PropertyInfo qdev_prop_pci_host_devaddr;
> >      DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_blocksize, uint16_t)
> >  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> >      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
> > +#define DEFINE_PROP_VHOST_SCSI(_n, _s, _f)       \
> > +    DEFINE_PROP(_n, _s, _f, qdev_prop_vhost_scsi, VHostSCSI*)
> >
> 
> Can this move to vhost-scsi.c?
>   

Done

> >  #define DEFINE_PROP_END_OF_LIST()               \
> >      {}
> > diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
> > new file mode 100644
> > index 0000000..7145b2d
> > --- /dev/null
> > +++ b/hw/vhost-scsi.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * vhost_scsi host device
> > + *
> > + * Copyright IBM, Corp. 2011
> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> > + * See the COPYING.LIB file in the top-level directory.
> > + *
> > + */
> > +
> > +#include <sys/ioctl.h>
> > +#include "config.h"
> > +#include "qemu-queue.h"
> > +#include "vhost-scsi.h"
> > +#include "vhost.h"
> > +
> > +struct VHostSCSI {
> > +    const char *id;
> > +    const char *wwpn;
> > +    uint16_t tpgt;
> > +    struct vhost_dev dev;
> > +    struct vhost_virtqueue vqs[3];
> 
> Could you add enum for vq numbers pls?
> 

Done

> > +    QLIST_ENTRY(VHostSCSI) list;
> > +};
> > +
> > +static QLIST_HEAD(, VHostSCSI) vhost_scsi_list =
> > +    QLIST_HEAD_INITIALIZER(vhost_scsi_list);
> > +
> > +VHostSCSI *find_vhost_scsi(const char *id)
> > +{
> > +    VHostSCSI *vs;
> > +
> > +    QLIST_FOREACH(vs, &vhost_scsi_list, list) {
> > +        if (strcmp(id, vs->id) == 0) {
> 
> !strcmp
> 

Done

> > +            return vs;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +const char *vhost_scsi_get_id(VHostSCSI *vs)
> > +{
> > +    return vs->id;
> > +}
> > +
> > +int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev)
> > +{
> > +    int ret, abi_version;
> > +    struct vhost_scsi_target backend;
> > +
> > +    if (!vhost_dev_query(&vs->dev, vdev)) {
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    vs->dev.nvqs = 3;
> > +    vs->dev.vqs = vs->vqs;
> > +
> > +    ret = vhost_dev_enable_notifiers(&vs->dev, vdev);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    ret = vhost_dev_start(&vs->dev, vdev);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    memset(&backend, 0, sizeof(backend));
> > +    ret = ioctl(vs->dev.control, VHOST_SCSI_GET_ABI_VERSION, &abi_version);
> > +    if (ret < 0) {
> > +        ret = -errno;
> > +        vhost_dev_stop(&vs->dev, vdev);
> > +        return ret;
> > +    }
> > +    if (abi_version > VHOST_SCSI_ABI_VERSION) {
> > +        fprintf(stderr, "The running tcm_vhost kernel abi_version: %d is greater"
> > +		" than vhost_scsi userspace supports: %d\n", abi_version,
> > +		VHOST_SCSI_ABI_VERSION);
> > +        ret = -ENOSYS;
> > +        vhost_dev_stop(&vs->dev, vdev);
> > +        return ret;
> > +    }
> > +    fprintf(stdout, "TCM_vHost ABI version: %d\n", abi_version);
> > +
> > +    pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
> > +    backend.vhost_tpgt = vs->tpgt;
> > +    ret = ioctl(vs->dev.control, VHOST_SCSI_SET_ENDPOINT, &backend);
> > +    if (ret < 0) {
> > +        ret = -errno;
> > +        vhost_dev_stop(&vs->dev, vdev);
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
> > +{
> > +    int ret;
> > +    struct vhost_scsi_target backend;
> > +
> > +    pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
> > +    backend.vhost_tpgt = vs->tpgt;
> > +    ret = ioctl(vs->dev.control, VHOST_SCSI_CLEAR_ENDPOINT, &backend);
> > +    if (ret < 0) {
> > +        fprintf(stderr, "Failed to clear endpoint\n");
> > +    }
> > +
> > +    vhost_dev_stop(&vs->dev, vdev);
> > +}
> > +
> > +static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> > +                                 uint16_t tpgt)
> > +{
> > +    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> > +    int ret;
> > +
> > +    /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
> > +    fprintf(stderr, "wwpn = \"%s\" tpgt = \"%u\"\n", id, tpgt);
> > +
> 
> Please do not keep debugging fprintfs around.
> 

Dropped

> > +    ret = vhost_dev_init(&vs->dev, -1, "/dev/vhost-scsi", false);
> 
> commented on this separately
> 

...

> > +    if (ret < 0) {
> > +        fprintf(stderr, "vhost-scsi: vhost initialization failed: %s\n",
> > +                strerror(-ret));
> 
> errors should go to monitor, here and elsewhere.
> 

I think this means using monitor_printf() right..?

Looking at that now..

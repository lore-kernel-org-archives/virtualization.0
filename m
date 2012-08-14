From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [Qemu-devel] [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host
	device for use with tcm-vhost
Date: Tue, 14 Aug 2012 14:17:46 -0700
Message-ID: <1344979066.22433.120.camel__13660.398455295$1344979078$gmane$org@haakon2.linux-iscsi.org>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<CAAu8pHttCSW9bUtrdiDG8-PBCpVvW2O=PEdYQoceDDUYydZ+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAu8pHttCSW9bUtrdiDG8-PBCpVvW2O=PEdYQoceDDUYydZ+9Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-08-13 at 19:47 +0000, Blue Swirl wrote:
> On Mon, Aug 13, 2012 at 8:35 AM, Nicholas A. Bellinger
> <nab@linux-iscsi.org> wrote:
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

<SNIP>

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
> 
> Braces, please.
> 

Fixed

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
> > +               " than vhost_scsi userspace supports: %d\n", abi_version,
> > +               VHOST_SCSI_ABI_VERSION);
> > +        ret = -ENOSYS;
> > +        vhost_dev_stop(&vs->dev, vdev);
> > +        return ret;
> > +    }
> > +    fprintf(stdout, "TCM_vHost ABI version: %d\n", abi_version);
> > +
> > +    pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
> 
> Please change vhost_wwpn to plain char *, then the cast can be removed.
> 

<nod>, changed to char *, and updating tcm_vhost on the kernel side to
do the same.

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
> 
> Also here.
> 

Done

Thanks for your review Blue!

--nab

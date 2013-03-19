From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 WIP 2/3] vhost-scsi: new device supporting the
	tcm_vhost Linux kernel module
Date: Tue, 19 Mar 2013 09:40:16 +0100
Message-ID: <20130319084016.GA24393@stefanha-thinkpad.redhat.com>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363653285-23776-3-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 19, 2013 at 08:34:44AM +0800, Asias He wrote:
> +static void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
> +{
> +    int ret = 0;
> +
> +    if (!vdev->binding->set_guest_notifiers) {
> +        ret = vdev->binding->set_guest_notifiers(vdev->binding_opaque,
> +                                                 vs->dev.nvqs, false);
> +        if (ret < 0) {
> +                error_report("vhost guest notifier cleanup failed: %d\n", ret);

Indentation.  scripts/checkpatch.pl should catch this.

> +        }
> +    }
> +    assert(ret >= 0);
> +
> +    vhost_scsi_clear_endpoint(vdev);
> +    vhost_dev_stop(&vs->dev, vdev);
> +    vhost_dev_disable_notifiers(&vs->dev, vdev);
> +}
> +
> +static void vhost_scsi_set_config(VirtIODevice *vdev,
> +                                  const uint8_t *config)
> +{
> +    VirtIOSCSIConfig *scsiconf = (VirtIOSCSIConfig *)config;
> +    VHostSCSI *vs = (VHostSCSI *)vdev;
> +
> +    if ((uint32_t) ldl_raw(&scsiconf->sense_size) != vs->vs.sense_size ||
> +        (uint32_t) ldl_raw(&scsiconf->cdb_size) != vs->vs.cdb_size) {
> +        error_report("vhost-scsi does not support changing the sense data and CDB sizes");
> +        exit(1);

Guest-triggerable exits can be used as a denial of service - especially
under nested virtualization where killing the L1 hypervisor would kill
all L2 guests!

I would just log a warning here.

> +    }
> +}
> +
> +static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
> +{
> +    VHostSCSI *vs = (VHostSCSI *)vdev;
> +    bool start = (val & VIRTIO_CONFIG_S_DRIVER_OK);
> +
> +    if (vs->dev.started == start) {
> +        return;
> +    }
> +
> +    if (start) {
> +        int ret;
> +
> +        ret = vhost_scsi_start(vs, vdev);
> +        if (ret < 0) {
> +            error_report("virtio-scsi: unable to start vhost: %s\n",
> +                         strerror(-ret));
> +
> +            /* There is no userspace virtio-scsi fallback so exit */
> +            exit(1);

It's questionable whether to kill the guest or simply disable this
virtio-scsi-pci adapter.  Fine for now but we may want to allow a policy
here in the future.

> diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
> index 39c1966..281a7e2 100644
> --- a/hw/virtio-pci.c
> +++ b/hw/virtio-pci.c
> @@ -22,6 +22,7 @@
>  #include "hw/virtio-net.h"
>  #include "hw/virtio-serial.h"
>  #include "hw/virtio-scsi.h"
> +#include "hw/vhost-scsi.h"

Can this header be included unconditionally?  It uses _IOW() which may
not be available on all host platforms.

From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 6/9] virtio-scsi: Open and initialize /dev/vhost-scsi
Date: Wed, 25 Jul 2012 09:05:31 +0200
Message-ID: <500F9ABB.4050704@redhat.com>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
	<1343169246-17636-7-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-7-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 25/07/2012 00:34, Nicholas A. Bellinger ha scritto:
> From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> 
> Begin adding vhost support by opening /dev/vhost-scsi.
> 
> (v2: Drop legacy ->vhost_vqs[] usage)
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Signed-off-by: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  hw/virtio-scsi.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
> index 4a787d3..dea3269 100644
> --- a/hw/virtio-scsi.c
> +++ b/hw/virtio-scsi.c
> @@ -18,6 +18,7 @@
>  #include "virtio-scsi.h"
>  #include <hw/scsi.h>
>  #include <hw/scsi-defs.h>
> +#include "vhost.h"
>  
>  #define VIRTIO_SCSI_VQ_SIZE     128
>  #define VIRTIO_SCSI_CDB_SIZE    32
> @@ -137,6 +138,9 @@ typedef struct {
>      VirtQueue *ctrl_vq;
>      VirtQueue *event_vq;
>      VirtQueue *cmd_vqs[0];
> +
> +    bool vhost_started;
> +    VHostSCSI *vhost_scsi;
>  } VirtIOSCSI;
>  
>  typedef struct VirtIOSCSIReq {
> @@ -456,6 +460,11 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
>      virtio_scsi_complete_req(req);
>  }
>  
> +static VirtIOSCSI *to_virtio_scsi(VirtIODevice *vdev)
> +{
> +    return (VirtIOSCSI *)vdev;
> +}

This function is unused and, because it is static, it will break
compilation.  Not that it would compile anyway since VHostSCSI is not
defined yet... ;)


>  static void virtio_scsi_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOSCSI *s = (VirtIOSCSI *)vdev;
> @@ -605,6 +614,8 @@ VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
>  
>      s->qdev = dev;
>      s->conf = proxyconf;
> +    s->vhost_started = false;
> +    s->vhost_scsi = proxyconf->vhost_scsi;

No need for this, just use s->conf->vhost_scsi.

Also, please do not register the QEMU SCSI bus if vhost-scsi is active.

Paolo

>  
>      /* TODO set up vdev function pointers */
>      s->vdev.get_config = virtio_scsi_get_config;
> @@ -636,5 +647,6 @@ void virtio_scsi_exit(VirtIODevice *vdev)
>  {
>      VirtIOSCSI *s = (VirtIOSCSI *)vdev;
>      unregister_savevm(s->qdev, "virtio-scsi", s);
> +    vhost_dev_cleanup(&s->vhost_scsi);
>      virtio_cleanup(vdev);
>  }
> 

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tcm_vhost: Expose ABI version via
	VHOST_SCSI_GET_ABI_VERSION
Date: Mon, 23 Jul 2012 18:56:34 -0700
Message-ID: <20120724015634.GD4093__38485.0181676031$1343138807$gmane$org@kroah.com>
References: <1343093180-5598-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1343093180-5598-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 24, 2012 at 01:26:20AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> As requested by Anthony, here is a patch against target-pending/for-next-merge
> to expose an ABI version to userspace via a new VHOST_SCSI_GET_ABI_VERSION
> ioctl operation.
> 
> As mentioned in the comment, ABI Rev 0 is for pre 2012 out-of-tree code, and
> ABI Rev 1 (the current rev) is for current WIP v3.6 kernel merge candiate code.
> 
> I think this is what you had in mind, and hopefully it will make MST happy too.
> The incremental vhost-scsi patches against Zhi's QEMU are going out shortly ahead
> of cutting a new vhost-scsi RFC over the next days.
> 
> Please have a look and let me know if you have any concerns here.
> 
> Thanks!
> 
> Reported-by: Anthony Liguori <aliguori@us.ibm.com>
> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  drivers/vhost/tcm_vhost.c |    9 +++++++++
>  drivers/vhost/tcm_vhost.h |   11 +++++++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index dc7e024..3f04169 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -977,6 +977,15 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
>  			return -EFAULT;
>  
>  		return vhost_scsi_clear_endpoint(vs, &backend);
> +	case VHOST_SCSI_GET_ABI_VERSION:
> +		if (copy_from_user(&backend, argp, sizeof backend))
> +			return -EFAULT;
> +
> +		backend.abi_version = VHOST_SCSI_ABI_VERSION;
> +
> +		if (copy_to_user(argp, &backend, sizeof backend))
> +			return -EFAULT;
> +		return 0;
>  	case VHOST_GET_FEATURES:
>  		features = VHOST_FEATURES;
>  		if (copy_to_user(featurep, &features, sizeof features))
> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> index e942df9..3d5378f 100644
> --- a/drivers/vhost/tcm_vhost.h
> +++ b/drivers/vhost/tcm_vhost.h
> @@ -80,7 +80,17 @@ struct tcm_vhost_tport {
>  
>  #include <linux/vhost.h>
>  
> +/*
> + * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
> + *
> + * ABI Rev 0: All pre 2012 revisions used by prototype out-of-tree code
> + * ABI Rev 1: 2012 version for v3.6 kernel merge candiate
> + */
> +
> +#define VHOST_SCSI_ABI_VERSION	1
> +
>  struct vhost_scsi_target {
> +	int abi_version;
>  	unsigned char vhost_wwpn[TRANSPORT_IQN_LEN];
>  	unsigned short vhost_tpgt;
>  };
> @@ -88,3 +98,4 @@ struct vhost_scsi_target {
>  /* VHOST_SCSI specific defines */
>  #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
>  #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
> +#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, struct vhost_scsi_target)

No, you just broke the ABI for version "0" here, that's not how you do
this at all.

greg k-h

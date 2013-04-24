From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 3/3] tcm_vhost: Add ioctl to get and set events missed
	flag
Date: Wed, 24 Apr 2013 12:33:02 +0300
Message-ID: <20130424093302.GD11245@redhat.com>
References: <1366774344-11127-1-git-send-email-asias@redhat.com>
	<1366774344-11127-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366774344-11127-4-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 24, 2013 at 11:32:24AM +0800, Asias He wrote:
> Signed-off-by: Asias He <asias@redhat.com>

Looks like a good idea to me. I missed this patch
previously, thanks for addressing this.
Some implementation comments below.

> ---
>  drivers/vhost/tcm_vhost.c | 16 ++++++++++++++++
>  drivers/vhost/tcm_vhost.h |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index def0c57..11fca73 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -1204,6 +1204,8 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
>  	u64 __user *featurep = argp;
>  	u64 features;
>  	int r, abi_version = VHOST_SCSI_ABI_VERSION;
> +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	bool events_missed;
>  
>  	switch (ioctl) {
>  	case VHOST_SCSI_SET_ENDPOINT:
> @@ -1224,6 +1226,20 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
>  		if (copy_to_user(argp, &abi_version, sizeof abi_version))
>  			return -EFAULT;
>  		return 0;
> +	case VHOST_SCSI_SET_EVENTS_MISSED:
> +		if (copy_from_user(&events_missed, argp, sizeof(events_missed)))
> +			return -EFAULT;

This can trigger undefined behaviour because userspace can
make bool have values other than 0 or 1.
So please read an integer here.
This also let you use get_user.

> +		mutex_lock(&vq->mutex);
> +		vs->vs_events_missed = events_missed;
> +		mutex_unlock(&vq->mutex);
> +		return 0;
> +	case VHOST_SCSI_GET_EVENTS_MISSED:
> +		mutex_lock(&vq->mutex);
> +		events_missed = vs->vs_events_missed;
> +		mutex_unlock(&vq->mutex);
> +		if (copy_to_user(argp, &events_missed, sizeof(events_missed)))
> +			return -EFAULT;
> +		return 0;
>  	case VHOST_GET_FEATURES:
>  		features = VHOST_SCSI_FEATURES;
>  		if (copy_to_user(featurep, &features, sizeof features))
> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> index 94e9ee53..b473e25 100644
> --- a/drivers/vhost/tcm_vhost.h
> +++ b/drivers/vhost/tcm_vhost.h
> @@ -123,3 +123,6 @@ struct vhost_scsi_target {
>  #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
>  /* Changing this breaks userspace. */
>  #define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
> +/* Set and get the events missed flag */
> +#define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, bool)
> +#define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, bool)

Please don't do bool in user interfaces. No one does. Make it __u32.

> -- 
> 1.8.1.4

From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v2] tcm_vhost: Multi-target support
Date: Mon, 04 Feb 2013 12:48:37 -0800
Message-ID: <1360010917.29175.31.camel@haakon2.linux-iscsi.org>
References: <1359706570-31808-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1359706570-31808-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Asias,

On Fri, 2013-02-01 at 16:16 +0800, Asias He wrote:
> In order to take advantages of Paolo's multi-queue virito-scsi, we need
> multi-target support in tcm_vhost first. Otherwise all the requests go
> to one queue and other queues are idle.
> 
> This patch makes:
> 
> 1. All the targets under the wwpn is seen and can be used by guest.
> 2. No need to pass the tpgt number in struct vhost_scsi_target to
>    tcm_vhost.ko. Only wwpn is needed.
> 3. We can always pass max_target = 255 to guest now, since we abort the
>    request who's target id does not exist.
> 
> Changes in v2:
> - Handle non-contiguous tpgt
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---

So this patch is looks pretty good.  Just a few points below..

>  drivers/vhost/tcm_vhost.c | 117 ++++++++++++++++++++++++++++++----------------
>  drivers/vhost/tcm_vhost.h |   4 +-
>  2 files changed, 79 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 218deb6..f1481f0 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -59,8 +59,14 @@ enum {
>  	VHOST_SCSI_VQ_IO = 2,
>  };
>  
> +#define VHOST_SCSI_MAX_TARGET 256
> +
>  struct vhost_scsi {
> -	struct tcm_vhost_tpg *vs_tpg;	/* Protected by vhost_scsi->dev.mutex */
> +	/* Protected by vhost_scsi->dev.mutex */
> +	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
> +	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
> +	bool vs_endpoint;
> +
>  	struct vhost_dev dev;
>  	struct vhost_virtqueue vqs[3];
>  
> @@ -564,13 +570,11 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
>  	u32 exp_data_len, data_first, data_num, data_direction;
>  	unsigned out, in, i;
>  	int head, ret;
> +	u8 target;
>  
>  	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
> -	tv_tpg = vs->vs_tpg;
> -	if (unlikely(!tv_tpg)) {
> -		pr_err("%s endpoint not set\n", __func__);
> +	if (unlikely(!vs->vs_endpoint))
>  		return;
> -	}
>  
>  	mutex_lock(&vq->mutex);
>  	vhost_disable_notify(&vs->dev, vq);
> @@ -637,6 +641,28 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
>  			break;
>  		}
>  
> +		/* Extract the tpgt */
> +		target = v_req.lun[1];
> +		tv_tpg = vs->vs_tpg[target];
> +
> +		/* Target does not exist, fail the request */
> +		if (unlikely(!tv_tpg)) {
> +			struct virtio_scsi_cmd_resp __user *resp;
> +			struct virtio_scsi_cmd_resp rsp;
> +
> +			memset(&rsp, 0, sizeof(rsp));
> +			rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
> +			resp = vq->iov[out].iov_base;
> +			ret = __copy_to_user(resp, &rsp, sizeof(rsp));
> +			if (!ret)
> +				vhost_add_used_and_signal(&vs->dev,
> +						&vs->vqs[2], head, 0);
> +			else
> +				pr_err("Faulted on virtio_scsi_cmd_resp\n");
> +
> +			continue;
> +		}
> +
>  		exp_data_len = 0;
>  		for (i = 0; i < data_num; i++)
>  			exp_data_len += vq->iov[data_first + i].iov_len;
> @@ -745,6 +771,7 @@ static int vhost_scsi_set_endpoint(
>  {
>  	struct tcm_vhost_tport *tv_tport;
>  	struct tcm_vhost_tpg *tv_tpg;
> +	bool match = false;
>  	int index;
>  
>  	mutex_lock(&vs->dev.mutex);
> @@ -771,14 +798,11 @@ static int vhost_scsi_set_endpoint(
>  		}
>  		tv_tport = tv_tpg->tport;
>  
> -		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn) &&
> -		    (tv_tpg->tport_tpgt == t->vhost_tpgt)) {
> +		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
>  			tv_tpg->tv_tpg_vhost_count++;
> -			mutex_unlock(&tv_tpg->tv_tpg_mutex);
> -			mutex_unlock(&tcm_vhost_mutex);
>  
>  			mutex_lock(&vs->dev.mutex);
> -			if (vs->vs_tpg) {
> +			if (vs->vs_tpg[tv_tpg->tport_tpgt]) {
>  				mutex_unlock(&vs->dev.mutex);
>  				mutex_lock(&tv_tpg->tv_tpg_mutex);
>  				tv_tpg->tv_tpg_vhost_count--;
> @@ -786,15 +810,24 @@ static int vhost_scsi_set_endpoint(
>  				return -EEXIST;
>  			}
>  
> -			vs->vs_tpg = tv_tpg;
> +			vs->vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
>  			smp_mb__after_atomic_inc();
> +			match = true;
>  			mutex_unlock(&vs->dev.mutex);
> -			return 0;
>  		}
>  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
>  	}
>  	mutex_unlock(&tcm_vhost_mutex);
> -	return -EINVAL;
> +
> +	mutex_lock(&vs->dev.mutex);
> +	if (match) {
> +		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
> +		       sizeof(vs->vs_vhost_wwpn));
> +		vs->vs_endpoint = true;
> +	}
> +	mutex_unlock(&vs->dev.mutex);
> +

This looks racy to me..  Why not just set these while holding
vs->dev.mutex above, instead of releasing + re-aquire..?

> +	return 0;
>  }
>  
>  static int vhost_scsi_clear_endpoint(
> @@ -803,7 +836,8 @@ static int vhost_scsi_clear_endpoint(
>  {
>  	struct tcm_vhost_tport *tv_tport;
>  	struct tcm_vhost_tpg *tv_tpg;
> -	int index, ret;
> +	int index, ret, i;
> +	u8 target;
>  
>  	mutex_lock(&vs->dev.mutex);
>  	/* Verify that ring has been setup correctly. */
> @@ -813,27 +847,32 @@ static int vhost_scsi_clear_endpoint(
>  			goto err;
>  		}
>  	}
> +	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
> +		target = i;
>  
> -	if (!vs->vs_tpg) {
> -		ret = -ENODEV;
> -		goto err;
> -	}
> -	tv_tpg = vs->vs_tpg;
> -	tv_tport = tv_tpg->tport;
> -
> -	if (strcmp(tv_tport->tport_name, t->vhost_wwpn) ||
> -	    (tv_tpg->tport_tpgt != t->vhost_tpgt)) {
> -		pr_warn("tv_tport->tport_name: %s, tv_tpg->tport_tpgt: %hu"
> -			" does not match t->vhost_wwpn: %s, t->vhost_tpgt: %hu\n",
> -			tv_tport->tport_name, tv_tpg->tport_tpgt,
> -			t->vhost_wwpn, t->vhost_tpgt);
> -		ret = -EINVAL;
> -		goto err;
> +		tv_tpg = vs->vs_tpg[target];
> +		if (!tv_tpg)
> +			continue;
> +
> +		tv_tport = tv_tpg->tport;
> +		if (!tv_tport) {
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +
> +		if (strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
> +			pr_warn("tv_tport->tport_name: %s, tv_tpg->tport_tpgt: %hu"
> +				" does not match t->vhost_wwpn: %s, t->vhost_tpgt: %hu\n",
> +				tv_tport->tport_name, tv_tpg->tport_tpgt,
> +				t->vhost_wwpn, t->vhost_tpgt);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		tv_tpg->tv_tpg_vhost_count--;
> +		vs->vs_tpg[target] = NULL;
> +		vs->vs_endpoint = false;
>  	}
> -	tv_tpg->tv_tpg_vhost_count--;
> -	vs->vs_tpg = NULL;
>  	mutex_unlock(&vs->dev.mutex);
> -
>  	return 0;
>  
>  err:
> @@ -868,16 +907,12 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  static int vhost_scsi_release(struct inode *inode, struct file *f)
>  {
>  	struct vhost_scsi *s = f->private_data;
> +	struct vhost_scsi_target t;
>  
> -	if (s->vs_tpg && s->vs_tpg->tport) {
> -		struct vhost_scsi_target backend;
> -
> -		memcpy(backend.vhost_wwpn, s->vs_tpg->tport->tport_name,
> -				sizeof(backend.vhost_wwpn));
> -		backend.vhost_tpgt = s->vs_tpg->tport_tpgt;
> -		vhost_scsi_clear_endpoint(s, &backend);
> -	}
> -
> +	mutex_lock(&s->dev.mutex);
> +	memcpy(t.vhost_wwpn, s->vs_vhost_wwpn, sizeof(t.vhost_wwpn));
> +	mutex_unlock(&s->dev.mutex);
> +	vhost_scsi_clear_endpoint(s, &t);

I think vhost_scsi_release() logic still needs a check here to prevent
vhost_scsi_clear_endpoint() from being called when no endpoint has been
configured, no..?

>  	vhost_dev_stop(&s->dev);
>  	vhost_dev_cleanup(&s->dev, false);
>  	kfree(s);
> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> index 47ee80b..519a550 100644
> --- a/drivers/vhost/tcm_vhost.h
> +++ b/drivers/vhost/tcm_vhost.h
> @@ -93,9 +93,11 @@ struct tcm_vhost_tport {
>   *
>   * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
>   *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
> + * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
> + *            All the targets under vhost_wwpn can be seen and used by guset.
>   */
>  
> -#define VHOST_SCSI_ABI_VERSION	0
> +#define VHOST_SCSI_ABI_VERSION	1
>  

So Paolo's preference was to not bump the ABI rev for this change.  I
don't really have a preference either way, so I'll defer to his and
MST's judgment here.

--nab

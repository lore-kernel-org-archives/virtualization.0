From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V2 3/3] tcm_vhost: Use vq->private_data to indicate if
	the endpoint is setup
Date: Wed, 13 Mar 2013 09:56:41 +0100
Message-ID: <51403F49.7090809@redhat.com>
References: <1363160055-24605-1-git-send-email-asias@redhat.com>
	<1363160055-24605-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363160055-24605-4-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 13/03/2013 08:34, Asias He ha scritto:
> Currently, vs->vs_endpoint is used indicate if the endpoint is setup or
> not. It is set or cleared in vhost_scsi_set_endpoint() or
> vhost_scsi_clear_endpoint() under the vs->dev.mutex lock. However, when
> we check it in vhost_scsi_handle_vq(), we ignored the lock, this is
> wrong.
> 
> Instead of using the vs->vs_endpoint and the vs->dev.mutex lock to
> indicate the status of the endpoint, we use per virtqueue
> vq->private_data to indicate it. In this way, we can only take the
> vq->mutex lock which is per queue and make the concurrent multiqueue
> process having less lock contention. Further, in the read side of
> vq->private_data, we can even do not take only lock if it is accessed in
> the vhost worker thread, because it is protected by "vhost rcu".
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/tcm_vhost.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 43fb11e..094fb10 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -67,7 +67,6 @@ struct vhost_scsi {
>  	/* Protected by vhost_scsi->dev.mutex */
>  	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
>  	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
> -	bool vs_endpoint;
>  
>  	struct vhost_dev dev;
>  	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
> @@ -91,6 +90,22 @@ static int iov_num_pages(struct iovec *iov)
>  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
>  }
>  
> +static bool tcm_vhost_check_endpoint(struct vhost_virtqueue *vq)
> +{
> +	bool ret = false;
> +
> +	/*
> +	 * We can handle the vq only after the endpoint is setup by calling the
> +	 * VHOST_SCSI_SET_ENDPOINT ioctl.
> +	 *
> +	 * TODO: check that we are running from vhost_worker?
> +	 */
> +	if (rcu_dereference_check(vq->private_data, 1))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
>  {
>  	return 1;
> @@ -581,8 +596,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  	int head, ret;
>  	u8 target;
>  
> -	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
> -	if (unlikely(!vs->vs_endpoint))
> +	if (!tcm_vhost_check_endpoint(vq))
>  		return;

You would still need at least a rcu_read_lock/unlock (actually srcu,
since vhost_scsi_handle_vq can sleep)...

>  	mutex_lock(&vq->mutex);
> @@ -781,8 +795,9 @@ static int vhost_scsi_set_endpoint(
>  {
>  	struct tcm_vhost_tport *tv_tport;
>  	struct tcm_vhost_tpg *tv_tpg;
> +	struct vhost_virtqueue *vq;
>  	bool match = false;
> -	int index, ret;
> +	int index, ret, i;
>  
>  	mutex_lock(&vs->dev.mutex);
>  	/* Verify that ring has been setup correctly. */
> @@ -826,7 +841,13 @@ static int vhost_scsi_set_endpoint(
>  	if (match) {
>  		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
>  		       sizeof(vs->vs_vhost_wwpn));
> -		vs->vs_endpoint = true;
> +		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> +			vq = &vs->vqs[i];
> +			mutex_lock(&vq->mutex);
> +			rcu_assign_pointer(vq->private_data, vs);
> +			vhost_init_used(vq);
> +			mutex_unlock(&vq->mutex);

... and a synchronize_srcu here.  But this is not correct use of RCU.
To use RCU correctly, you need to _copy_ (that's the "C" in RCU) the
whole vs structure on every set_endpoint or clear_endpoint operation,
and free it after synchronize_srcu returns.

What you're trying to do is really an rwlock, just use that. :)

Paolo

> +		}
>  		ret = 0;
>  	} else {
>  		ret = -EEXIST;
> @@ -842,6 +863,8 @@ static int vhost_scsi_clear_endpoint(
>  {
>  	struct tcm_vhost_tport *tv_tport;
>  	struct tcm_vhost_tpg *tv_tpg;
> +	struct vhost_virtqueue *vq;
> +	bool match = false;
>  	int index, ret, i;
>  	u8 target;
>  
> @@ -877,9 +900,17 @@ static int vhost_scsi_clear_endpoint(
>  		}
>  		tv_tpg->tv_tpg_vhost_count--;
>  		vs->vs_tpg[target] = NULL;
> -		vs->vs_endpoint = false;
> +		match = true;
>  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
>  	}
> +	if (match) {
> +		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> +			vq = &vs->vqs[i];
> +			mutex_lock(&vq->mutex);
> +			rcu_assign_pointer(vq->private_data, NULL);
> +			mutex_unlock(&vq->mutex);
> +		}
> +	}
>  	mutex_unlock(&vs->dev.mutex);
>  	return 0;
>  
> 

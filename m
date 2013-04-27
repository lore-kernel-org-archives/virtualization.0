From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 2/2] tcm_vhost: Wait for pending requests in
	vhost_scsi_flush()
Date: Sat, 27 Apr 2013 22:40:41 +0300
Message-ID: <20130427194041.GC30188__16924.0712923513$1367091662$gmane$org@redhat.com>
References: <1367032609-30511-1-git-send-email-asias@redhat.com>
	<1367032609-30511-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1367032609-30511-3-git-send-email-asias@redhat.com>
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

On Sat, Apr 27, 2013 at 11:16:49AM +0800, Asias He wrote:
> Unlike tcm_vhost_evt requests, tcm_vhost_cmd requests are passed to the
> target core system, we can not make sure all the pending requests will
> be finished by flushing the virt queue.
> 
> In this patch, we do refcount for every tcm_vhost_cmd requests to make
> vhost_scsi_flush() wait for all the pending requests issued before the
> flush operation to be finished.
> 
> This is useful when we call vhost_scsi_clear_endpoint() to stop
> tcm_vhost. No new requests will be passed to target core system because
> we clear the endpoint by setting vs_tpg to NULL. And we wait for all the
> old requests. These guarantee no requests will be leaked and existing
> requests will be completed.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/tcm_vhost.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/vhost/tcm_vhost.h |  3 ++
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 99d3480..afb5308 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -74,8 +74,19 @@ enum {
>  #define VHOST_SCSI_MAX_VQ	128
>  #define VHOST_SCSI_MAX_EVENT	128
>  
> +struct vhost_scsi_inflight {
> +	/* Wait for the flush operation to finish */
> +	struct completion comp;
> +	/* Refcount for the inflight reqs */
> +	struct kref kref;
> +};
> +
>  struct vhost_scsi_virtqueue {
>  	struct vhost_virtqueue vq;
> +	/* Track inflight reqs, protected by vq->mutex */

Actually, it's protected by dev mutex: you drop
vq mutex before flush.

> +	struct vhost_scsi_inflight inflights[2];
> +	/* Indicate current inflight in use, protected by vq->mutex */
> +	int inflight_idx;
>  };
>  

I'd be happier with a dynamically allocated inflights,
and simply pass it in to vhost_scsi_flush.
I guess we can do this in a follow-up cleanup.

>  struct vhost_scsi {
> @@ -111,6 +122,59 @@ static int iov_num_pages(struct iovec *iov)
>  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
>  }
>  
> +void tcm_vhost_done_inflight(struct kref *kref)
> +{
> +	struct vhost_scsi_inflight *inflight;
> +
> +	inflight = container_of(kref, struct vhost_scsi_inflight, kref);
> +	complete(&inflight->comp);
> +}
> +
> +static void tcm_vhost_init_inflight(struct vhost_scsi *vs,
> +				    struct vhost_scsi_inflight *old_inflight[])
> +{
> +	struct vhost_scsi_inflight *new_inflight;
> +	struct vhost_virtqueue *vq;
> +	int idx, i;
> +
> +	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> +		vq = &vs->vqs[i].vq;
> +
> +		mutex_lock(&vq->mutex);
> +
> +		/* store old infight */
> +		idx = vs->vqs[i].inflight_idx;
> +		if (old_inflight)
> +			old_inflight[i] = &vs->vqs[i].inflights[idx];
> +
> +		/* setup new infight */
> +		vs->vqs[i].inflight_idx = idx ^ 1;
> +		new_inflight = &vs->vqs[i].inflights[idx ^ 1];
> +		kref_init(&new_inflight->kref);
> +		init_completion(&new_inflight->comp);
> +
> +		mutex_unlock(&vq->mutex);
> +	}
> +}
> +
> +static struct vhost_scsi_inflight *
> +tcm_vhost_get_inflight(struct vhost_virtqueue *vq)
> +{
> +	struct vhost_scsi_inflight *inflight;
> +	struct vhost_scsi_virtqueue *svq;
> +
> +	svq = container_of(vq, struct vhost_scsi_virtqueue, vq);
> +	inflight = &svq->inflights[svq->inflight_idx];
> +	kref_get(&inflight->kref);
> +
> +	return inflight;
> +}
> +
> +static void tcm_vhost_put_inflight(struct vhost_scsi_inflight *inflight)
> +{
> +	kref_put(&inflight->kref, tcm_vhost_done_inflight);
> +}
> +
>  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
>  {
>  	return 1;
> @@ -407,6 +471,8 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
>  		kfree(tv_cmd->tvc_sgl);
>  	}
>  
> +	tcm_vhost_put_inflight(tv_cmd->inflight);
> +
>  	kfree(tv_cmd);
>  }
>  
> @@ -533,6 +599,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  }
>  
>  static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> +	struct vhost_virtqueue *vq,
>  	struct tcm_vhost_tpg *tv_tpg,
>  	struct virtio_scsi_cmd_req *v_req,
>  	u32 exp_data_len,
> @@ -557,6 +624,7 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
>  	tv_cmd->tvc_exp_data_len = exp_data_len;
>  	tv_cmd->tvc_data_direction = data_direction;
>  	tv_cmd->tvc_nexus = tv_nexus;
> +	tv_cmd->inflight = tcm_vhost_get_inflight(vq);
>  
>  	return tv_cmd;
>  }
> @@ -812,7 +880,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  		for (i = 0; i < data_num; i++)
>  			exp_data_len += vq->iov[data_first + i].iov_len;
>  
> -		tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
> +		tv_cmd = vhost_scsi_allocate_cmd(vq, tv_tpg, &v_req,
>  					exp_data_len, data_direction);
>  		if (IS_ERR(tv_cmd)) {
>  			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
> @@ -949,12 +1017,29 @@ static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
>  
>  static void vhost_scsi_flush(struct vhost_scsi *vs)
>  {
> +	struct vhost_scsi_inflight *old_inflight[VHOST_SCSI_MAX_VQ];
>  	int i;
>  
> +	/* Init new inflight and remember the old inflight */
> +	tcm_vhost_init_inflight(vs, old_inflight);
> +
> +	/*
> +	 * The inflight->kref was initialized to 1. We decrement it here to
> +	 * indicate the start of the flush operation so that it will reach 0
> +	 * when all the reqs are finished.
> +	 */
> +	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> +		kref_put(&old_inflight[i]->kref, tcm_vhost_done_inflight);
> +
> +	/* Flush both the vhost poll and vhost work */
>  	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
>  		vhost_scsi_flush_vq(vs, i);
>  	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
>  	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> +
> +	/* Wait for all reqs issued before the flush to be finished */
> +	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> +		wait_for_completion(&old_inflight[i]->comp);
>  }
>  
>  /*
> @@ -1185,6 +1270,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  		s->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
>  	}
>  	r = vhost_dev_init(&s->dev, vqs, VHOST_SCSI_MAX_VQ);
> +
> +	tcm_vhost_init_inflight(s, NULL);
> +
>  	if (r < 0) {
>  		kfree(vqs);
>  		kfree(s);
> diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> index 514b9fd..26a57c2 100644
> --- a/drivers/vhost/tcm_vhost.h
> +++ b/drivers/vhost/tcm_vhost.h
> @@ -2,6 +2,7 @@
>  #define TCM_VHOST_NAMELEN 256
>  #define TCM_VHOST_MAX_CDB_SIZE 32
>  
> +struct vhost_scsi_inflight;
>  struct tcm_vhost_cmd {
>  	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
>  	int tvc_vq_desc;
> @@ -37,6 +38,8 @@ struct tcm_vhost_cmd {
>  	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
>  	/* Completed commands list, serviced from vhost worker thread */
>  	struct llist_node tvc_completion_list;
> +	/* Used to track inflight cmd */
> +	struct vhost_scsi_inflight *inflight;
>  };
>  
>  struct tcm_vhost_nexus {
> -- 
> 1.8.1.4

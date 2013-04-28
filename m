From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 1/2] vhost: Allow device specific fields per vq
Date: Sun, 28 Apr 2013 15:50:46 +0300
Message-ID: <20130428125045.GB10796@redhat.com>
References: <1367032609-30511-1-git-send-email-asias@redhat.com>
	<1367032609-30511-2-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1367032609-30511-2-git-send-email-asias@redhat.com>
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

On Sat, Apr 27, 2013 at 11:16:48AM +0800, Asias He wrote:
> This is useful for any device who wants device specific fields per vq.
> For example, tcm_vhost wants a per vq field to track requests which are
> in flight on the vq. Also, on top of this we can add patches to move
> things like ubufs from vhost.h out to net.c.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Asias He <asias@redhat.com>

OK I really want this and the follow-up cleanup
for net.c (and I have added another cleanup on top)
but this has a dependency on the hotplug patches.
So what I propose is I take the hotplug patches
on the vhost tree and apply this and the flush patches
on top, send everything to Linus.

Once he merges net and scsi can do development
more or less independently again.
Thoughts?

> ---
>  drivers/vhost/net.c       | 60 +++++++++++++++++++-------------
>  drivers/vhost/tcm_vhost.c | 55 +++++++++++++++++++----------
>  drivers/vhost/vhost.c     | 88 +++++++++++++++++++++++------------------------
>  drivers/vhost/vhost.h     |  4 +--
>  4 files changed, 120 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index ec6fb3f..683d9a1 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -70,9 +70,13 @@ enum vhost_net_poll_state {
>  	VHOST_NET_POLL_STOPPED = 2,
>  };
>  
> +struct vhost_net_virtqueue {
> +	struct vhost_virtqueue vq;
> +};
> +
>  struct vhost_net {
>  	struct vhost_dev dev;
> -	struct vhost_virtqueue vqs[VHOST_NET_VQ_MAX];
> +	struct vhost_net_virtqueue vqs[VHOST_NET_VQ_MAX];
>  	struct vhost_poll poll[VHOST_NET_VQ_MAX];
>  	/* Tells us whether we are polling a socket for TX.
>  	 * We only do this when socket buffer fills up.
> @@ -230,7 +234,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
>   * read-size critical section for our kind of RCU. */
>  static void handle_tx(struct vhost_net *net)
>  {
> -	struct vhost_virtqueue *vq = &net->dev.vqs[VHOST_NET_VQ_TX];
> +	struct vhost_virtqueue *vq = &net->vqs[VHOST_NET_VQ_TX].vq;
>  	unsigned out, in, s;
>  	int head;
>  	struct msghdr msg = {
> @@ -470,7 +474,7 @@ err:
>   * read-size critical section for our kind of RCU. */
>  static void handle_rx(struct vhost_net *net)
>  {
> -	struct vhost_virtqueue *vq = &net->dev.vqs[VHOST_NET_VQ_RX];
> +	struct vhost_virtqueue *vq = &net->vqs[VHOST_NET_VQ_RX].vq;
>  	unsigned uninitialized_var(in), log;
>  	struct vhost_log *vq_log;
>  	struct msghdr msg = {
> @@ -612,17 +616,26 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  {
>  	struct vhost_net *n = kmalloc(sizeof *n, GFP_KERNEL);
>  	struct vhost_dev *dev;
> +	struct vhost_virtqueue **vqs;
>  	int r;
>  
>  	if (!n)
>  		return -ENOMEM;
> +	vqs = kmalloc(VHOST_NET_VQ_MAX * sizeof(*vqs), GFP_KERNEL);
> +	if (!vqs) {
> +		kfree(n);
> +		return -ENOMEM;
> +	}
>  
>  	dev = &n->dev;
> -	n->vqs[VHOST_NET_VQ_TX].handle_kick = handle_tx_kick;
> -	n->vqs[VHOST_NET_VQ_RX].handle_kick = handle_rx_kick;
> -	r = vhost_dev_init(dev, n->vqs, VHOST_NET_VQ_MAX);
> +	vqs[VHOST_NET_VQ_TX] = &n->vqs[VHOST_NET_VQ_TX].vq;
> +	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
> +	n->vqs[VHOST_NET_VQ_TX].vq.handle_kick = handle_tx_kick;
> +	n->vqs[VHOST_NET_VQ_RX].vq.handle_kick = handle_rx_kick;
> +	r = vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX);
>  	if (r < 0) {
>  		kfree(n);
> +		kfree(vqs);
>  		return r;
>  	}
>  
> @@ -640,7 +653,7 @@ static void vhost_net_disable_vq(struct vhost_net *n,
>  {
>  	if (!vq->private_data)
>  		return;
> -	if (vq == n->vqs + VHOST_NET_VQ_TX) {
> +	if (vq == &n->vqs[VHOST_NET_VQ_TX].vq) {
>  		tx_poll_stop(n);
>  		n->tx_poll_state = VHOST_NET_POLL_DISABLED;
>  	} else
> @@ -657,7 +670,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
>  					 lockdep_is_held(&vq->mutex));
>  	if (!sock)
>  		return 0;
> -	if (vq == n->vqs + VHOST_NET_VQ_TX) {
> +	if (vq == &n->vqs[VHOST_NET_VQ_TX].vq) {
>  		n->tx_poll_state = VHOST_NET_POLL_STOPPED;
>  		ret = tx_poll_start(n, sock);
>  	} else
> @@ -683,30 +696,30 @@ static struct socket *vhost_net_stop_vq(struct vhost_net *n,
>  static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
>  			   struct socket **rx_sock)
>  {
> -	*tx_sock = vhost_net_stop_vq(n, n->vqs + VHOST_NET_VQ_TX);
> -	*rx_sock = vhost_net_stop_vq(n, n->vqs + VHOST_NET_VQ_RX);
> +	*tx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_TX].vq);
> +	*rx_sock = vhost_net_stop_vq(n, &n->vqs[VHOST_NET_VQ_RX].vq);
>  }
>  
>  static void vhost_net_flush_vq(struct vhost_net *n, int index)
>  {
>  	vhost_poll_flush(n->poll + index);
> -	vhost_poll_flush(&n->dev.vqs[index].poll);
> +	vhost_poll_flush(&n->vqs[index].vq.poll);
>  }
>  
>  static void vhost_net_flush(struct vhost_net *n)
>  {
>  	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
>  	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
> -	if (n->dev.vqs[VHOST_NET_VQ_TX].ubufs) {
> -		mutex_lock(&n->dev.vqs[VHOST_NET_VQ_TX].mutex);
> +	if (n->vqs[VHOST_NET_VQ_TX].vq.ubufs) {
> +		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = true;
> -		mutex_unlock(&n->dev.vqs[VHOST_NET_VQ_TX].mutex);
> +		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		/* Wait for all lower device DMAs done. */
> -		vhost_ubuf_put_and_wait(n->dev.vqs[VHOST_NET_VQ_TX].ubufs);
> -		mutex_lock(&n->dev.vqs[VHOST_NET_VQ_TX].mutex);
> +		vhost_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].vq.ubufs);
> +		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = false;
> -		kref_init(&n->dev.vqs[VHOST_NET_VQ_TX].ubufs->kref);
> -		mutex_unlock(&n->dev.vqs[VHOST_NET_VQ_TX].mutex);
> +		kref_init(&n->vqs[VHOST_NET_VQ_TX].vq.ubufs->kref);
> +		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  	}
>  }
>  
> @@ -727,6 +740,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
>  	/* We do an extra flush before freeing memory,
>  	 * since jobs can re-queue themselves. */
>  	vhost_net_flush(n);
> +	kfree(n->dev.vqs);
>  	kfree(n);
>  	return 0;
>  }
> @@ -812,7 +826,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		r = -ENOBUFS;
>  		goto err;
>  	}
> -	vq = n->vqs + index;
> +	vq = &n->vqs[index].vq;
>  	mutex_lock(&vq->mutex);
>  
>  	/* Verify that ring has been setup correctly. */
> @@ -932,10 +946,10 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
>  	n->dev.acked_features = features;
>  	smp_wmb();
>  	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
> -		mutex_lock(&n->vqs[i].mutex);
> -		n->vqs[i].vhost_hlen = vhost_hlen;
> -		n->vqs[i].sock_hlen = sock_hlen;
> -		mutex_unlock(&n->vqs[i].mutex);
> +		mutex_lock(&n->vqs[i].vq.mutex);
> +		n->vqs[i].vq.vhost_hlen = vhost_hlen;
> +		n->vqs[i].vq.sock_hlen = sock_hlen;
> +		mutex_unlock(&n->vqs[i].vq.mutex);
>  	}
>  	vhost_net_flush(n);
>  	mutex_unlock(&n->dev.mutex);
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 1677238..99d3480 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -74,13 +74,17 @@ enum {
>  #define VHOST_SCSI_MAX_VQ	128
>  #define VHOST_SCSI_MAX_EVENT	128
>  
> +struct vhost_scsi_virtqueue {
> +	struct vhost_virtqueue vq;
> +};
> +
>  struct vhost_scsi {
>  	/* Protected by vhost_scsi->dev.mutex */
>  	struct tcm_vhost_tpg **vs_tpg;
>  	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
>  
>  	struct vhost_dev dev;
> -	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
> +	struct vhost_scsi_virtqueue vqs[VHOST_SCSI_MAX_VQ];
>  
>  	struct vhost_work vs_completion_work; /* cmd completion work item */
>  	struct llist_head vs_completion_list; /* cmd completion queue */
> @@ -366,7 +370,7 @@ static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
>  static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
>  	u32 event, u32 reason)
>  {
> -	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  	struct tcm_vhost_evt *evt;
>  
>  	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT) {
> @@ -409,7 +413,7 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
>  static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
>  	struct tcm_vhost_evt *evt)
>  {
> -	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  	struct virtio_scsi_event *event = &evt->event;
>  	struct virtio_scsi_event __user *eventp;
>  	unsigned out, in;
> @@ -460,7 +464,7 @@ static void tcm_vhost_evt_work(struct vhost_work *work)
>  {
>  	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
>  					vs_event_work);
> -	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  	struct tcm_vhost_evt *evt;
>  	struct llist_node *llnode;
>  
> @@ -511,8 +515,10 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  		       v_rsp.sense_len);
>  		ret = copy_to_user(tv_cmd->tvc_resp, &v_rsp, sizeof(v_rsp));
>  		if (likely(ret == 0)) {
> +			struct vhost_scsi_virtqueue *q;
>  			vhost_add_used(tv_cmd->tvc_vq, tv_cmd->tvc_vq_desc, 0);
> -			vq = tv_cmd->tvc_vq - vs->vqs;
> +			q = container_of(tv_cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
> +			vq = q - vs->vqs;
>  			__set_bit(vq, signal);
>  		} else
>  			pr_err("Faulted on virtio_scsi_cmd_resp\n");
> @@ -523,7 +529,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  	vq = -1;
>  	while ((vq = find_next_bit(signal, VHOST_SCSI_MAX_VQ, vq + 1))
>  		< VHOST_SCSI_MAX_VQ)
> -		vhost_signal(&vs->dev, &vs->vqs[vq]);
> +		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
>  }
>  
>  static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> @@ -938,7 +944,7 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
>  
>  static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
>  {
> -	vhost_poll_flush(&vs->dev.vqs[index].poll);
> +	vhost_poll_flush(&vs->vqs[index].vq.poll);
>  }
>  
>  static void vhost_scsi_flush(struct vhost_scsi *vs)
> @@ -975,7 +981,7 @@ static int vhost_scsi_set_endpoint(
>  	/* Verify that ring has been setup correctly. */
>  	for (index = 0; index < vs->dev.nvqs; ++index) {
>  		/* Verify that ring has been setup correctly. */
> -		if (!vhost_vq_access_ok(&vs->vqs[index])) {
> +		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
>  			ret = -EFAULT;
>  			goto out;
>  		}
> @@ -1022,7 +1028,7 @@ static int vhost_scsi_set_endpoint(
>  		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
>  		       sizeof(vs->vs_vhost_wwpn));
>  		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> -			vq = &vs->vqs[i];
> +			vq = &vs->vqs[i].vq;
>  			/* Flushing the vhost_work acts as synchronize_rcu */
>  			mutex_lock(&vq->mutex);
>  			rcu_assign_pointer(vq->private_data, vs_tpg);
> @@ -1063,7 +1069,7 @@ static int vhost_scsi_clear_endpoint(
>  	mutex_lock(&vs->dev.mutex);
>  	/* Verify that ring has been setup correctly. */
>  	for (index = 0; index < vs->dev.nvqs; ++index) {
> -		if (!vhost_vq_access_ok(&vs->vqs[index])) {
> +		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
>  			ret = -EFAULT;
>  			goto err_dev;
>  		}
> @@ -1103,7 +1109,7 @@ static int vhost_scsi_clear_endpoint(
>  	}
>  	if (match) {
>  		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> -			vq = &vs->vqs[i];
> +			vq = &vs->vqs[i].vq;
>  			/* Flushing the vhost_work acts as synchronize_rcu */
>  			mutex_lock(&vq->mutex);
>  			rcu_assign_pointer(vq->private_data, NULL);
> @@ -1151,24 +1157,36 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
>  static int vhost_scsi_open(struct inode *inode, struct file *f)
>  {
>  	struct vhost_scsi *s;
> +	struct vhost_virtqueue **vqs;
>  	int r, i;
>  
>  	s = kzalloc(sizeof(*s), GFP_KERNEL);
>  	if (!s)
>  		return -ENOMEM;
>  
> +	vqs = kmalloc(VHOST_SCSI_MAX_VQ * sizeof(*vqs), GFP_KERNEL);
> +	if (!vqs) {
> +		kfree(s);
> +		return -ENOMEM;
> +	}
> +
>  	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
>  	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
>  
>  	s->vs_events_nr = 0;
>  	s->vs_events_missed = false;
>  
> -	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> -	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> -	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
> -		s->vqs[i].handle_kick = vhost_scsi_handle_kick;
> -	r = vhost_dev_init(&s->dev, s->vqs, VHOST_SCSI_MAX_VQ);
> +	vqs[VHOST_SCSI_VQ_CTL] = &s->vqs[VHOST_SCSI_VQ_CTL].vq;
> +	vqs[VHOST_SCSI_VQ_EVT] = &s->vqs[VHOST_SCSI_VQ_EVT].vq;
> +	s->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
> +	s->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
> +	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
> +		vqs[i] = &s->vqs[i].vq;
> +		s->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
> +	}
> +	r = vhost_dev_init(&s->dev, vqs, VHOST_SCSI_MAX_VQ);
>  	if (r < 0) {
> +		kfree(vqs);
>  		kfree(s);
>  		return r;
>  	}
> @@ -1190,6 +1208,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
>  	vhost_dev_cleanup(&s->dev, false);
>  	/* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
>  	vhost_scsi_flush(s);
> +	kfree(s->dev.vqs);
>  	kfree(s);
>  	return 0;
>  }
> @@ -1205,7 +1224,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
>  	u32 events_missed;
>  	u64 features;
>  	int r, abi_version = VHOST_SCSI_ABI_VERSION;
> -	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  
>  	switch (ioctl) {
>  	case VHOST_SCSI_SET_ENDPOINT:
> @@ -1333,7 +1352,7 @@ static void tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
>  	else
>  		reason = VIRTIO_SCSI_EVT_RESET_REMOVED;
>  
> -	vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> +	vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  	mutex_lock(&vq->mutex);
>  	tcm_vhost_send_evt(vs, tpg, lun,
>  			VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9759249..3f80286 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -266,27 +266,27 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>  	bool zcopy;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> -		dev->vqs[i].indirect = kmalloc(sizeof *dev->vqs[i].indirect *
> +		dev->vqs[i]->indirect = kmalloc(sizeof *dev->vqs[i]->indirect *
>  					       UIO_MAXIOV, GFP_KERNEL);
> -		dev->vqs[i].log = kmalloc(sizeof *dev->vqs[i].log * UIO_MAXIOV,
> +		dev->vqs[i]->log = kmalloc(sizeof *dev->vqs[i]->log * UIO_MAXIOV,
>  					  GFP_KERNEL);
> -		dev->vqs[i].heads = kmalloc(sizeof *dev->vqs[i].heads *
> +		dev->vqs[i]->heads = kmalloc(sizeof *dev->vqs[i]->heads *
>  					    UIO_MAXIOV, GFP_KERNEL);
>  		zcopy = vhost_zcopy_mask & (0x1 << i);
>  		if (zcopy)
> -			dev->vqs[i].ubuf_info =
> -				kmalloc(sizeof *dev->vqs[i].ubuf_info *
> +			dev->vqs[i]->ubuf_info =
> +				kmalloc(sizeof *dev->vqs[i]->ubuf_info *
>  					UIO_MAXIOV, GFP_KERNEL);
> -		if (!dev->vqs[i].indirect || !dev->vqs[i].log ||
> -			!dev->vqs[i].heads ||
> -			(zcopy && !dev->vqs[i].ubuf_info))
> +		if (!dev->vqs[i]->indirect || !dev->vqs[i]->log ||
> +			!dev->vqs[i]->heads ||
> +			(zcopy && !dev->vqs[i]->ubuf_info))
>  			goto err_nomem;
>  	}
>  	return 0;
>  
>  err_nomem:
>  	for (; i >= 0; --i)
> -		vhost_vq_free_iovecs(&dev->vqs[i]);
> +		vhost_vq_free_iovecs(dev->vqs[i]);
>  	return -ENOMEM;
>  }
>  
> @@ -295,11 +295,11 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i)
> -		vhost_vq_free_iovecs(&dev->vqs[i]);
> +		vhost_vq_free_iovecs(dev->vqs[i]);
>  }
>  
>  long vhost_dev_init(struct vhost_dev *dev,
> -		    struct vhost_virtqueue *vqs, int nvqs)
> +		    struct vhost_virtqueue **vqs, int nvqs)
>  {
>  	int i;
>  
> @@ -315,16 +315,16 @@ long vhost_dev_init(struct vhost_dev *dev,
>  	dev->worker = NULL;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> -		dev->vqs[i].log = NULL;
> -		dev->vqs[i].indirect = NULL;
> -		dev->vqs[i].heads = NULL;
> -		dev->vqs[i].ubuf_info = NULL;
> -		dev->vqs[i].dev = dev;
> -		mutex_init(&dev->vqs[i].mutex);
> -		vhost_vq_reset(dev, dev->vqs + i);
> -		if (dev->vqs[i].handle_kick)
> -			vhost_poll_init(&dev->vqs[i].poll,
> -					dev->vqs[i].handle_kick, POLLIN, dev);
> +		dev->vqs[i]->log = NULL;
> +		dev->vqs[i]->indirect = NULL;
> +		dev->vqs[i]->heads = NULL;
> +		dev->vqs[i]->ubuf_info = NULL;
> +		dev->vqs[i]->dev = dev;
> +		mutex_init(&dev->vqs[i]->mutex);
> +		vhost_vq_reset(dev, dev->vqs[i]);
> +		if (dev->vqs[i]->handle_kick)
> +			vhost_poll_init(&dev->vqs[i]->poll,
> +					dev->vqs[i]->handle_kick, POLLIN, dev);
>  	}
>  
>  	return 0;
> @@ -427,9 +427,9 @@ void vhost_dev_stop(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> -		if (dev->vqs[i].kick && dev->vqs[i].handle_kick) {
> -			vhost_poll_stop(&dev->vqs[i].poll);
> -			vhost_poll_flush(&dev->vqs[i].poll);
> +		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
> +			vhost_poll_stop(&dev->vqs[i]->poll);
> +			vhost_poll_flush(&dev->vqs[i]->poll);
>  		}
>  	}
>  }
> @@ -440,17 +440,17 @@ void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> -		if (dev->vqs[i].error_ctx)
> -			eventfd_ctx_put(dev->vqs[i].error_ctx);
> -		if (dev->vqs[i].error)
> -			fput(dev->vqs[i].error);
> -		if (dev->vqs[i].kick)
> -			fput(dev->vqs[i].kick);
> -		if (dev->vqs[i].call_ctx)
> -			eventfd_ctx_put(dev->vqs[i].call_ctx);
> -		if (dev->vqs[i].call)
> -			fput(dev->vqs[i].call);
> -		vhost_vq_reset(dev, dev->vqs + i);
> +		if (dev->vqs[i]->error_ctx)
> +			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> +		if (dev->vqs[i]->error)
> +			fput(dev->vqs[i]->error);
> +		if (dev->vqs[i]->kick)
> +			fput(dev->vqs[i]->kick);
> +		if (dev->vqs[i]->call_ctx)
> +			eventfd_ctx_put(dev->vqs[i]->call_ctx);
> +		if (dev->vqs[i]->call)
> +			fput(dev->vqs[i]->call);
> +		vhost_vq_reset(dev, dev->vqs[i]);
>  	}
>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> @@ -521,14 +521,14 @@ static int memory_access_ok(struct vhost_dev *d, struct vhost_memory *mem,
>  
>  	for (i = 0; i < d->nvqs; ++i) {
>  		int ok;
> -		mutex_lock(&d->vqs[i].mutex);
> +		mutex_lock(&d->vqs[i]->mutex);
>  		/* If ring is inactive, will check when it's enabled. */
> -		if (d->vqs[i].private_data)
> -			ok = vq_memory_access_ok(d->vqs[i].log_base, mem,
> +		if (d->vqs[i]->private_data)
> +			ok = vq_memory_access_ok(d->vqs[i]->log_base, mem,
>  						 log_all);
>  		else
>  			ok = 1;
> -		mutex_unlock(&d->vqs[i].mutex);
> +		mutex_unlock(&d->vqs[i]->mutex);
>  		if (!ok)
>  			return 0;
>  	}
> @@ -638,7 +638,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
>  	if (idx >= d->nvqs)
>  		return -ENOBUFS;
>  
> -	vq = d->vqs + idx;
> +	vq = d->vqs[idx];
>  
>  	mutex_lock(&vq->mutex);
>  
> @@ -849,7 +849,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		for (i = 0; i < d->nvqs; ++i) {
>  			struct vhost_virtqueue *vq;
>  			void __user *base = (void __user *)(unsigned long)p;
> -			vq = d->vqs + i;
> +			vq = d->vqs[i];
>  			mutex_lock(&vq->mutex);
>  			/* If ring is inactive, will check when it's enabled. */
>  			if (vq->private_data && !vq_log_access_ok(d, vq, base))
> @@ -876,9 +876,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		} else
>  			filep = eventfp;
>  		for (i = 0; i < d->nvqs; ++i) {
> -			mutex_lock(&d->vqs[i].mutex);
> -			d->vqs[i].log_ctx = d->log_ctx;
> -			mutex_unlock(&d->vqs[i].mutex);
> +			mutex_lock(&d->vqs[i]->mutex);
> +			d->vqs[i]->log_ctx = d->log_ctx;
> +			mutex_unlock(&d->vqs[i]->mutex);
>  		}
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 17261e2..f3afa8a 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -150,7 +150,7 @@ struct vhost_dev {
>  	struct mm_struct *mm;
>  	struct mutex mutex;
>  	unsigned acked_features;
> -	struct vhost_virtqueue *vqs;
> +	struct vhost_virtqueue **vqs;
>  	int nvqs;
>  	struct file *log_file;
>  	struct eventfd_ctx *log_ctx;
> @@ -159,7 +159,7 @@ struct vhost_dev {
>  	struct task_struct *worker;
>  };
>  
> -long vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue *vqs, int nvqs);
> +long vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs, int nvqs);
>  long vhost_dev_check_owner(struct vhost_dev *);
>  long vhost_dev_reset_owner(struct vhost_dev *);
>  void vhost_dev_cleanup(struct vhost_dev *, bool locked);
> -- 
> 1.8.1.4

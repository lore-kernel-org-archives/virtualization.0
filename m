From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] Add mergeable RX bufs support to vhost
Date: Thu, 22 Apr 2010 15:02:25 +0300
Message-ID: <20100422120225.GA31642@redhat.com>
References: <1271715140.9755.14.camel@w-dls.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1271715140.9755.14.camel@w-dls.beaverton.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: David L Stevens <dlstevens@us.ibm.com>
Cc: virtualization@lists.osdl.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 19, 2010 at 03:12:19PM -0700, David L Stevens wrote:
> This patch adds the mergeable RX buffers feature to vhost.
> 
> Signed-off-by: David L Stevens <dlstevens@us.ibm.com>

Looks pretty clean to me.
Could you send a checkpatch-clean version please?
We should also check performance implications.
Do you have any data?

Thanks!

> diff -ruNp net-next-p0/drivers/vhost/net.c net-next-v4/drivers/vhost/net.c
> --- net-next-p0/drivers/vhost/net.c	2010-03-22 12:04:38.000000000 -0700
> +++ net-next-v4/drivers/vhost/net.c	2010-04-19 14:23:38.000000000 -0700
> @@ -108,7 +108,7 @@ static void handle_tx(struct vhost_net *
>  	};
>  	size_t len, total_len = 0;
>  	int err, wmem;
> -	size_t hdr_size;
> +	size_t vhost_hlen;
>  	struct socket *sock = rcu_dereference(vq->private_data);
>  	if (!sock)
>  		return;
> @@ -127,13 +127,13 @@ static void handle_tx(struct vhost_net *
>  
>  	if (wmem < sock->sk->sk_sndbuf / 2)
>  		tx_poll_stop(net);
> -	hdr_size = vq->hdr_size;
> +	vhost_hlen = vq->vhost_hlen;
>  
>  	for (;;) {
> -		head = vhost_get_vq_desc(&net->dev, vq, vq->iov,
> -					 ARRAY_SIZE(vq->iov),
> -					 &out, &in,
> -					 NULL, NULL);
> +		head = vhost_get_desc(&net->dev, vq, vq->iov,
> +				      ARRAY_SIZE(vq->iov),
> +				      &out, &in,
> +				      NULL, NULL);
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
>  			wmem = atomic_read(&sock->sk->sk_wmem_alloc);
> @@ -154,20 +154,20 @@ static void handle_tx(struct vhost_net *
>  			break;
>  		}
>  		/* Skip header. TODO: support TSO. */
> -		s = move_iovec_hdr(vq->iov, vq->hdr, hdr_size, out);
> +		s = move_iovec_hdr(vq->iov, vq->hdr, vhost_hlen, out);
>  		msg.msg_iovlen = out;
>  		len = iov_length(vq->iov, out);
>  		/* Sanity check */
>  		if (!len) {
>  			vq_err(vq, "Unexpected header len for TX: "
>  			       "%zd expected %zd\n",
> -			       iov_length(vq->hdr, s), hdr_size);
> +			       iov_length(vq->hdr, s), vhost_hlen);
>  			break;
>  		}
>  		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(NULL, sock, &msg, len);
>  		if (unlikely(err < 0)) {
> -			vhost_discard_vq_desc(vq);
> +			vhost_discard_desc(vq, 1);
>  			tx_poll_start(net, sock);
>  			break;
>  		}
> @@ -186,12 +186,25 @@ static void handle_tx(struct vhost_net *
>  	unuse_mm(net->dev.mm);
>  }
>  
> +static int vhost_head_len(struct vhost_virtqueue *vq, struct sock *sk)
> +{
> +	struct sk_buff *head;
> +	int len = 0;
> +
> +	lock_sock(sk);
> +	head = skb_peek(&sk->sk_receive_queue);
> +	if (head)
> +		len = head->len + vq->sock_hlen;
> +	release_sock(sk);
> +	return len;
> +}
> +
>  /* Expects to be always run from workqueue - which acts as
>   * read-size critical section for our kind of RCU. */
>  static void handle_rx(struct vhost_net *net)
>  {
>  	struct vhost_virtqueue *vq = &net->dev.vqs[VHOST_NET_VQ_RX];
> -	unsigned head, out, in, log, s;
> +	unsigned in, log, s;
>  	struct vhost_log *vq_log;
>  	struct msghdr msg = {
>  		.msg_name = NULL,
> @@ -202,14 +215,14 @@ static void handle_rx(struct vhost_net *
>  		.msg_flags = MSG_DONTWAIT,
>  	};
>  
> -	struct virtio_net_hdr hdr = {
> -		.flags = 0,
> -		.gso_type = VIRTIO_NET_HDR_GSO_NONE
> +	struct virtio_net_hdr_mrg_rxbuf hdr = {
> +		.hdr.flags = 0,
> +		.hdr.gso_type = VIRTIO_NET_HDR_GSO_NONE
>  	};
>  
>  	size_t len, total_len = 0;
> -	int err;
> -	size_t hdr_size;
> +	int err, headcount, datalen;
> +	size_t vhost_hlen;
>  	struct socket *sock = rcu_dereference(vq->private_data);
>  	if (!sock || skb_queue_empty(&sock->sk->sk_receive_queue))
>  		return;
> @@ -217,18 +230,18 @@ static void handle_rx(struct vhost_net *
>  	use_mm(net->dev.mm);
>  	mutex_lock(&vq->mutex);
>  	vhost_disable_notify(vq);
> -	hdr_size = vq->hdr_size;
> +	vhost_hlen = vq->vhost_hlen;
>  
>  	vq_log = unlikely(vhost_has_feature(&net->dev, VHOST_F_LOG_ALL)) ?
>  		vq->log : NULL;
>  
> -	for (;;) {
> -		head = vhost_get_vq_desc(&net->dev, vq, vq->iov,
> -					 ARRAY_SIZE(vq->iov),
> -					 &out, &in,
> -					 vq_log, &log);
> +	while ((datalen = vhost_head_len(vq, sock->sk))) {
> +		headcount = vhost_get_desc_n(vq, vq->heads, datalen+vhost_hlen,
> +					     &in, vq_log, &log);
> +		if (headcount < 0)
> +			break;
>  		/* OK, now we need to know about added descriptors. */
> -		if (head == vq->num) {
> +		if (!headcount) {
>  			if (unlikely(vhost_enable_notify(vq))) {
>  				/* They have slipped one in as we were
>  				 * doing that: check again. */
> @@ -240,46 +253,52 @@ static void handle_rx(struct vhost_net *
>  			break;
>  		}
>  		/* We don't need to be notified again. */
> -		if (out) {
> -			vq_err(vq, "Unexpected descriptor format for RX: "
> -			       "out %d, int %d\n",
> -			       out, in);
> -			break;
> -		}
> -		/* Skip header. TODO: support TSO/mergeable rx buffers. */
> -		s = move_iovec_hdr(vq->iov, vq->hdr, hdr_size, in);
> +		/* Skip header. TODO: support TSO. */
> +		s = move_iovec_hdr(vq->iov, vq->hdr, vhost_hlen, in);
>  		msg.msg_iovlen = in;
>  		len = iov_length(vq->iov, in);
>  		/* Sanity check */
>  		if (!len) {
>  			vq_err(vq, "Unexpected header len for RX: "
>  			       "%zd expected %zd\n",
> -			       iov_length(vq->hdr, s), hdr_size);
> +			       iov_length(vq->hdr, s), vhost_hlen);
>  			break;
>  		}
>  		err = sock->ops->recvmsg(NULL, sock, &msg,
>  					 len, MSG_DONTWAIT | MSG_TRUNC);
>  		/* TODO: Check specific error and bomb out unless EAGAIN? */
>  		if (err < 0) {
> -			vhost_discard_vq_desc(vq);
> +			vhost_discard_desc(vq, headcount);
>  			break;
>  		}
> -		/* TODO: Should check and handle checksum. */
> -		if (err > len) {
> -			pr_err("Discarded truncated rx packet: "
> -			       " len %d > %zd\n", err, len);
> -			vhost_discard_vq_desc(vq);
> +		if (err != datalen) {
> +			pr_err("Discarded rx packet: "
> +			       " len %d, expected %zd\n", err, datalen);
> +			vhost_discard_desc(vq, headcount);
>  			continue;
>  		}
>  		len = err;
> -		err = memcpy_toiovec(vq->hdr, (unsigned char *)&hdr, hdr_size);
> +		err = memcpy_toiovec(vq->hdr,(unsigned char *)&hdr, vhost_hlen);
>  		if (err) {
>  			vq_err(vq, "Unable to write vnet_hdr at addr %p: %d\n",
>  			       vq->iov->iov_base, err);
>  			break;
>  		}
> -		len += hdr_size;
> -		vhost_add_used_and_signal(&net->dev, vq, head, len);
> +		/* TODO: Should check and handle checksum. */
> +		if (vhost_has_feature(&net->dev, VIRTIO_NET_F_MRG_RXBUF)) {
> +			struct virtio_net_hdr_mrg_rxbuf hdr;
> +			struct iovec *iov = vhost_hlen ? vq->hdr : vq->iov;
> +
> +			if (memcpy_toiovecend(iov, (unsigned char *)&headcount,
> +					      offsetof(typeof(hdr),num_buffers),
> +					      sizeof(hdr.num_buffers))) {
> +				vq_err(vq, "Failed num_buffers write");
> +				vhost_discard_desc(vq, headcount);
> +				break;
> +			}
> +		}
> +		len += vhost_hlen;
> +		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads, headcount);
>  		if (unlikely(vq_log))
>  			vhost_log_write(vq, vq_log, log, len);
>  		total_len += len;
> @@ -560,9 +579,24 @@ done:
>  
>  static int vhost_net_set_features(struct vhost_net *n, u64 features)
>  {
> -	size_t hdr_size = features & (1 << VHOST_NET_F_VIRTIO_NET_HDR) ?
> -		sizeof(struct virtio_net_hdr) : 0;
> +	size_t vhost_hlen;
> +	size_t sock_hlen;
>  	int i;
> +
> +	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
> +		/* vhost provides vnet_hdr */
> +		vhost_hlen = sizeof(struct virtio_net_hdr);
> +		if (features & (1 << VIRTIO_NET_F_MRG_RXBUF))
> +			vhost_hlen = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +		sock_hlen = 0;
> +	} else {
> +		/* socket provides vnet_hdr */
> +		vhost_hlen = 0;
> +		if (features & (1 << VIRTIO_NET_F_MRG_RXBUF))
> +			sock_hlen = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> +		else
> +			sock_hlen = sizeof(struct virtio_net_hdr);
> +	}
>  	mutex_lock(&n->dev.mutex);
>  	if ((features & (1 << VHOST_F_LOG_ALL)) &&
>  	    !vhost_log_access_ok(&n->dev)) {
> @@ -573,7 +607,8 @@ static int vhost_net_set_features(struct
>  	smp_wmb();
>  	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
>  		mutex_lock(&n->vqs[i].mutex);
> -		n->vqs[i].hdr_size = hdr_size;
> +		n->vqs[i].vhost_hlen = vhost_hlen;
> +		n->vqs[i].sock_hlen = sock_hlen;
>  		mutex_unlock(&n->vqs[i].mutex);
>  	}
>  	vhost_net_flush(n);
> diff -ruNp net-next-p0/drivers/vhost/vhost.c net-next-v4/drivers/vhost/vhost.c
> --- net-next-p0/drivers/vhost/vhost.c	2010-03-22 12:04:38.000000000 -0700
> +++ net-next-v4/drivers/vhost/vhost.c	2010-04-19 14:29:55.000000000 -0700
> @@ -113,7 +113,8 @@ static void vhost_vq_reset(struct vhost_
>  	vq->used_flags = 0;
>  	vq->log_used = false;
>  	vq->log_addr = -1ull;
> -	vq->hdr_size = 0;
> +	vq->vhost_hlen = 0;
> +	vq->sock_hlen = 0;
>  	vq->private_data = NULL;
>  	vq->log_base = NULL;
>  	vq->error_ctx = NULL;
> @@ -856,6 +857,53 @@ static unsigned get_indirect(struct vhos
>  	return 0;
>  }
>  
> +/* This is a multi-buffer version of vhost_get_vq_desc
> + * @vq		- the relevant virtqueue
> + * datalen	- data length we'll be reading
> + * @iovcount	- returned count of io vectors we fill
> + * @log		- vhost log
> + * @log_num	- log offset
> + *	returns number of buffer heads allocated, negative on error 
> + */
> +int vhost_get_desc_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
> +		     int datalen, int *iovcount, struct vhost_log *log,
> +		     unsigned int *log_num)
> +{
> +	int out, in;
> +	int seg = 0;		/* iov index */
> +	int hc = 0;		/* head count */
> +	int rv;
> +
> +	while (datalen > 0) {
> +		if (hc >= VHOST_NET_MAX_SG) {
> +			rv = -ENOBUFS;
> +			goto err;
> +		}
> +		heads[hc].id = vhost_get_desc(vq->dev, vq, vq->iov+seg,
> +					      ARRAY_SIZE(vq->iov)-seg, &out,
> +					      &in, log, log_num);
> +		if (heads[hc].id == vq->num) {
> +			rv = 0;
> +			goto err;
> +		}
> +		if (out || in <= 0) {
> +			vq_err(vq, "unexpected descriptor format for RX: "
> +				"out %d, in %d\n", out, in);
> +			rv = -EINVAL;
> +			goto err;
> +		}
> +		heads[hc].len = iov_length(vq->iov+seg, in);
> +		datalen -= heads[hc].len;
> +		hc++;
> +		seg += in;
> +	}
> +	*iovcount = seg;
> +	return hc;
> +err:
> +	vhost_discard_desc(vq, hc);
> +	return rv;
> +}
> +
>  /* This looks in the virtqueue and for the first available buffer, and converts
>   * it to an iovec for convenient access.  Since descriptors consist of some
>   * number of output then some number of input descriptors, it's actually two
> @@ -863,7 +911,7 @@ static unsigned get_indirect(struct vhos
>   *
>   * This function returns the descriptor number found, or vq->num (which
>   * is never a valid descriptor number) if none was found. */
> -unsigned vhost_get_vq_desc(struct vhost_dev *dev, struct vhost_virtqueue *vq,
> +unsigned vhost_get_desc(struct vhost_dev *dev, struct vhost_virtqueue *vq,
>  			   struct iovec iov[], unsigned int iov_size,
>  			   unsigned int *out_num, unsigned int *in_num,
>  			   struct vhost_log *log, unsigned int *log_num)
> @@ -981,9 +1029,9 @@ unsigned vhost_get_vq_desc(struct vhost_
>  }
>  
>  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> -void vhost_discard_vq_desc(struct vhost_virtqueue *vq)
> +void vhost_discard_desc(struct vhost_virtqueue *vq, int n)
>  {
> -	vq->last_avail_idx--;
> +	vq->last_avail_idx -= n;
>  }
>  
>  /* After we've used one of their buffers, we tell them about it.  We'll then
> @@ -1012,6 +1060,54 @@ int vhost_add_used(struct vhost_virtqueu
>  	if (unlikely(vq->log_used)) {
>  		/* Make sure data is seen before log. */
>  		smp_wmb();
> +		log_write(vq->log_base, vq->log_addr + sizeof *vq->used->ring *
> +			  (vq->last_used_idx % vq->num),
> +			  sizeof *vq->used->ring);
> +		log_write(vq->log_base, vq->log_addr, sizeof *vq->used->ring);
> +		if (vq->log_ctx)
> +			eventfd_signal(vq->log_ctx, 1);
> +	}
> +	vq->last_used_idx++;
> +	return 0;
> +}
> +
> +/* After we've used one of their buffers, we tell them about it.  We'll then
> + * want to notify the guest, using eventfd. */
> +int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
> +		   int count)
> +{
> +	struct vring_used_elem *used;
> +	int start, n;
> +
> +	if (count <= 0)
> +		return -EINVAL;
> +
> +	start = vq->last_used_idx % vq->num;
> +	if (vq->num - start < count)
> +		n = vq->num - start;
> +	else
> +		n = count;
> +	used = vq->used->ring + start;
> +	if (copy_to_user(used, heads, sizeof(heads[0])*n)) {
> +		vq_err(vq, "Failed to write used");
> +		return -EFAULT;
> +	}
> +	if (n < count) {	/* wrapped the ring */
> +		used = vq->used->ring;
> +		if (copy_to_user(used, heads+n, sizeof(heads[0])*(count-n))) {
> +			vq_err(vq, "Failed to write used");
> +			return -EFAULT;
> +		}
> +	}
> +	/* Make sure buffer is written before we update index. */
> +	smp_wmb();
> +	if (put_user(vq->last_used_idx+count, &vq->used->idx)) {
> +		vq_err(vq, "Failed to increment used idx");
> +		return -EFAULT;
> +	}
> +	if (unlikely(vq->log_used)) {
> +		/* Make sure data is seen before log. */
> +		smp_wmb();
>  		/* Log used ring entry write. */
>  		log_write(vq->log_base,
>  			  vq->log_addr + ((void *)used - (void *)vq->used),
> @@ -1023,7 +1119,7 @@ int vhost_add_used(struct vhost_virtqueu
>  		if (vq->log_ctx)
>  			eventfd_signal(vq->log_ctx, 1);
>  	}
> -	vq->last_used_idx++;
> +	vq->last_used_idx += count;
>  	return 0;
>  }
>  
> @@ -1056,6 +1152,15 @@ void vhost_add_used_and_signal(struct vh
>  	vhost_signal(dev, vq);
>  }
>  
> +/* multi-buffer version of vhost_add_used_and_signal */
> +void vhost_add_used_and_signal_n(struct vhost_dev *dev,
> +				 struct vhost_virtqueue *vq,
> +				 struct vring_used_elem *heads, int count)
> +{
> +	vhost_add_used_n(vq, heads, count);
> +	vhost_signal(dev, vq);
> +}
> +
>  /* OK, now we need to know about added descriptors. */
>  bool vhost_enable_notify(struct vhost_virtqueue *vq)
>  {
> @@ -1080,7 +1185,7 @@ bool vhost_enable_notify(struct vhost_vi
>  		return false;
>  	}
>  
> -	return avail_idx != vq->last_avail_idx;
> +	return avail_idx != vq->avail_idx;
>  }
>  
>  /* We don't need to be notified again. */
> diff -ruNp net-next-p0/drivers/vhost/vhost.h net-next-v4/drivers/vhost/vhost.h
> --- net-next-p0/drivers/vhost/vhost.h	2010-03-22 12:04:38.000000000 -0700
> +++ net-next-v4/drivers/vhost/vhost.h	2010-04-19 14:15:24.000000000 -0700
> @@ -84,7 +84,9 @@ struct vhost_virtqueue {
>  	struct iovec indirect[VHOST_NET_MAX_SG];
>  	struct iovec iov[VHOST_NET_MAX_SG];
>  	struct iovec hdr[VHOST_NET_MAX_SG];
> -	size_t hdr_size;
> +	size_t vhost_hlen;
> +	size_t sock_hlen;
> +	struct vring_used_elem heads[VHOST_NET_MAX_SG];
>  	/* We use a kind of RCU to access private pointer.
>  	 * All readers access it from workqueue, which makes it possible to
>  	 * flush the workqueue instead of synchronize_rcu. Therefore readers do
> @@ -120,16 +122,23 @@ long vhost_dev_ioctl(struct vhost_dev *,
>  int vhost_vq_access_ok(struct vhost_virtqueue *vq);
>  int vhost_log_access_ok(struct vhost_dev *);
>  
> -unsigned vhost_get_vq_desc(struct vhost_dev *, struct vhost_virtqueue *,
> +int vhost_get_desc_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
> +		     int datalen, int *iovcount, struct vhost_log *log,
> +		     unsigned int *log_num);
> +unsigned vhost_get_desc(struct vhost_dev *, struct vhost_virtqueue *,
>  			   struct iovec iov[], unsigned int iov_count,
>  			   unsigned int *out_num, unsigned int *in_num,
>  			   struct vhost_log *log, unsigned int *log_num);
> -void vhost_discard_vq_desc(struct vhost_virtqueue *);
> +void vhost_discard_desc(struct vhost_virtqueue *, int);
>  
>  int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
> -void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
> +int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
> +		    int count);
>  void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
> -			       unsigned int head, int len);
> +			       unsigned int id, int len);
> +void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
> +			       struct vring_used_elem *heads, int count);
> +void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
>  void vhost_disable_notify(struct vhost_virtqueue *);
>  bool vhost_enable_notify(struct vhost_virtqueue *);
>  
> @@ -149,7 +158,8 @@ enum {
>  	VHOST_FEATURES = (1 << VIRTIO_F_NOTIFY_ON_EMPTY) |
>  			 (1 << VIRTIO_RING_F_INDIRECT_DESC) |
>  			 (1 << VHOST_F_LOG_ALL) |
> -			 (1 << VHOST_NET_F_VIRTIO_NET_HDR),
> +			 (1 << VHOST_NET_F_VIRTIO_NET_HDR) |
> +			 (1 << VIRTIO_NET_F_MRG_RXBUF),
>  };
>  
>  static inline int vhost_has_feature(struct vhost_dev *dev, int bit)
> 
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization

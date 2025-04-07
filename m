Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890B35970
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743988022; cv=none; b=son2lX++QBIuM7htGHPiNeqH+dRkxzxmEOwZXRvFQhFgrQR0ucksy7qGOLX1t1W6cUceLTIksGRZR8bdwUl56ii64rFGp+lc2Oa+CzCFqHIBbXoiCfDZHONV2aTiV0gHk+3i0Kk+LIa//rmGEKks7VF28fcBWC91nNgz+dEiuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743988022; c=relaxed/simple;
	bh=ch6lvxNheDI1ivTt0ioTzc9Ny+4ood1tqZFhk88N0lc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Gz6eDqnVnFSKBTXH0Y7RZgiy1E0VDWMiNeIEvnV/fbhrzq8fQq4xZ59rIfK0glQkQxGOt+EhlmeNv1xHi53yYWUXFBSEFSmHo6O8/XQz/2N48/plE0URj1LftX2iA4rSrDAJtiLmCDx3OGmOnh1oYkts87eCMXp8yKY/DfiuIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gKU3beZn; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gKU3beZn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743988009; h=Message-ID:Subject:Date:From:To;
	bh=RQsGAvlcouaF8GQ6e4VtQjlTST+z+xj3ljx+lelKUrw=;
	b=gKU3beZnczj9WNOm+nAW+U1d5iOtOoTJHHx6hij0RZQgo55Gl4xuIwcVfBzVJV4k4+CEzHkvROx1y7r/xBHBnlvjfvRiT/QHsouXicx3tPfq8RnJRNJ5M89X7kFUGDbP8fA7LlwjMz6vArf+KCkrdKMa0/EQSQxC1ZPosH55eoU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WVj13AP_1743988008 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Apr 2025 09:06:48 +0800
Message-ID: <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
Date: Mon, 7 Apr 2025 09:03:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
In-Reply-To: <20250404093903.37416-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. This can leads to
> deadlock when napi_disable() is called on an already disabled napi. This
> scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.


So, what is the problem? The refill_work is waiting? As I know, that thread
will sleep some time, so the cpu can do other work.

Thanks.

>
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
>
> Fixes: 6a4763e26803 ("virtio_net: support rx queue resize")
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..4361b91ccc64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,10 +3342,53 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	if (running) {
> +		int i;
> +
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			virtnet_napi_disable(&vi->rq[i]);
> +			virtnet_cancel_dim(vi, &vi->rq[i].dim);
> +		}
> +	}
> +}
> +
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs) {
> +			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +				schedule_delayed_work(&vi->refill, 0);
> +		}
> +
> +		if (running)
> +			virtnet_napi_enable(&vi->rq[i]);
> +	}
> +}
> +
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
>  	if (running) {
>  		virtnet_napi_disable(rq);
>  		virtnet_cancel_dim(vi, &rq->dim);
> @@ -3356,6 +3399,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>
> +	enable_delayed_refill(vi);
>  	if (!try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>
> @@ -5959,12 +6003,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (prog)
>  		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>
> +	virtnet_rx_pause_all(vi);
> +
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_disable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_disable(&vi->sq[i]);
> -		}
>  	}
>
>  	if (!prog) {
> @@ -5996,13 +6040,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		vi->xdp_enabled = false;
>  	}
>
> +	virtnet_rx_resume_all(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		if (netif_running(dev)) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		if (netif_running(dev))
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>
>  	return 0;
> @@ -6014,11 +6057,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
>  	}
>
> +	virtnet_rx_resume_all(vi);
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  	if (prog)
>  		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
> --
> 2.43.0
>

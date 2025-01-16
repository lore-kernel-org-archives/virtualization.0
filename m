Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD6156C76
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014202; cv=none; b=iSuukRoZb9Qhf4I0ASAxEbbfm9icNaKx2xNqS57h3LVLeA3wRZD5wztJOm9nZCkQWNjcI1faimB1w5zMXgQjtMvNu7QM6bxUsHRh/qzR7i7XIA1UYtUfbq+OTYZ9xCI39SqaDQim1dqEmOzlkXETCNcEiRdxmfQb/SmVuKxDDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014202; c=relaxed/simple;
	bh=pkqdGjdMYi1yzQk1vCN3PKgu8+/8JJKz6CLoOkKB+s8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oOhqWHT7wozB/GRXZaqCgpGKpMeao5298Kxt6ZZVaRwlOwj3xoHcFOgHhRwQkSJysv1VGOxaArSZkVs31sYOf7R0SwlcddgHQ6rpWLQajwHosWNJVPszqrK0KnRkAPS95Ne+2u7HXtldpGQ4hZWEOFyHRI0ZILhBuouUXR561gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C16lVM5U; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C16lVM5U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737014196; h=Message-ID:Subject:Date:From:To;
	bh=QyeVoBuE8ZtHm/3gJn14NT7ilefLQr2T3k8o7w8Ll+c=;
	b=C16lVM5UlxxT+ogjQFuVvOOOTqBKPVjPo7OARi4XeFGyaz4d5ygqi+9WNDNmG9hRYfh8/ApRzcykwscNmUA0pxTujvYwLTqPBMC6gq7UtCK2UVU2B4dOO6zLEeQh8F2uo/KgWkXqqY3VtnCTRUk+gxTLEbmaTEohrUzFR709138=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WNkwH05_1737014194 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:56:35 +0800
Message-ID: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Date: Thu, 16 Jan 2025 15:53:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Joe Damato <jdamato@fastly.com>
Cc: gerhard@engleder-embedded.com,
 jasowang@redhat.com,
 leiyang@redhat.com,
 mkarsten@uwaterloo.ca,
 Joe Damato <jdamato@fastly.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
 netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
In-Reply-To: <20250116055302.14308-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
>      of this v2.
>    - Added virtnet_napi_disable to reduce code duplication as
>      suggested by Jason Wang.
>
>  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cff18c66b54a..c6fda756dd07 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
>  	local_bh_enable();
>  }
>
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +static void virtnet_napi_enable(struct virtqueue *vq,
> +				struct napi_struct *napi)
>  {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int q = vq2rxq(vq);
> +	u16 curr_qs;
> +
>  	virtnet_napi_do_enable(vq, napi);
> +
> +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> +	if (!vi->xdp_enabled || q < curr_qs)
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);

So what case the check of xdp_enabled is for?

And I think we should merge this to last commit.

Thanks.

>  }
>
>  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> @@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>  	virtnet_napi_do_enable(vq, napi);
>  }
>
> +static void virtnet_napi_disable(struct virtqueue *vq,
> +				 struct napi_struct *napi)
> +{
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int q = vq2rxq(vq);
> +	u16 curr_qs;
> +
> +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> +	if (!vi->xdp_enabled || q < curr_qs)
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
> +
> +	napi_disable(napi);
> +}
> +
>  static void virtnet_napi_tx_disable(struct napi_struct *napi)
>  {
>  	if (napi->weight)
> @@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
>  		struct receive_queue *rq = &vi->rq[i];
>
> -		napi_disable(&rq->napi);
> +		virtnet_napi_disable(rq->vq, &rq->napi);
> +
>  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>  		virtnet_napi_enable(rq->vq, &rq->napi);
>
> @@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>  {
>  	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> -	napi_disable(&vi->rq[qp_index].napi);
> +	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>
> @@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	bool running = netif_running(vi->dev);
>
>  	if (running) {
> -		napi_disable(&rq->napi);
> +		virtnet_napi_disable(rq->vq, &rq->napi);
>  		virtnet_cancel_dim(vi, &rq->dim);
>  	}
>  }
> @@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			napi_disable(&vi->rq[i].napi);
> +			virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].napi);
>  			virtnet_napi_tx_disable(&vi->sq[i].napi);
>  		}
>  	}
> --
> 2.25.1
>

Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFC79CC
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302213; cv=none; b=BEVcBOeebr8OxpWF6PaESRpq41GY0jem3KG2pKw1Qhc4WLu12pL9GColseIyXbb/djLhFAehLqu4cIn/+tr10xUxqR68kc7pp2rNPc+v5NbP/Zhb+KEekJoOJslsjga5dmHW0CG9lLRRhs2fpN/4MaRsTnjEpsyDxMZdrRLsQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302213; c=relaxed/simple;
	bh=mDbX44iHFAur30ptnsNO/rYztiZYmHy6rFTH9+fEUaE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qLkvqU+QMR6TO/CaRO7LRcwRTLXboj57W3aoGLSDvbjIhXXiGRceJv8fd7QNTtNCM2fRFNFnODB6rajq2y/PCBgFsnizY0wk61b7469NdiXVhtEvkFYZKrzaNeFD9nDmEy0NnRMO6KN7vo1qVXM9zA+zkTDPWvvzaxCCvmWzraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SEC8cJ2b; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SEC8cJ2b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722302208; h=Message-ID:Subject:Date:From:To;
	bh=NurZJnjIPPIG2Wgu5pBlZBRDBNoK5/FjLiE+OAyWfI4=;
	b=SEC8cJ2bnZ7H4LKpzssQtPuuMF251IXxaL4rXQOHEZjNZVwEkOlUfzJcCS+JiiGmYqf2iik1z7xs/SWRVo/apsNDhyV/CSCGd/vVy9IP9e/kmfN0chbKs8o4yo4K79Abdgys6XB6jLvLqddaqS9YUSfxcBsLHDPHS5ymywoxKQY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBdYe0X_1722301889;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WBdYe0X_1722301889)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 09:11:30 +0800
Message-ID: <1722301882.5491223-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Tue, 30 Jul 2024 09:11:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 29 Jul 2024 20:47:55 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> From the virtio spec:
>
> 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..eb115e807882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  	u32 rx_pending, tx_pending;
>  	struct receive_queue *rq;
>  	struct send_queue *sq;
> +	u32 pkts, usecs;
>  	int i, err;
>
>  	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
>  			 * did not set any TX coalescing parameters, to 0.
>  			 */
> -			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_tx.max_usecs,
> -							       vi->intr_coal_tx.max_packets);
> -			if (err)
> -				return err;
> +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +				usecs = vi->intr_coal_tx.max_usecs;
> +				pkts = vi->intr_coal_tx.max_packets;
> +				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> +				if (err)
> +					return err;
> +			}
>  		}
>
>  		if (ring->rx_pending != rx_pending) {
> @@ -3753,13 +3756,15 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  				return err;
>
>  			/* The reason is same as the transmit virtqueue reset */
> -			mutex_lock(&vi->rq[i].dim_lock);
> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_rx.max_usecs,
> -							       vi->intr_coal_rx.max_packets);
> -			mutex_unlock(&vi->rq[i].dim_lock);
> -			if (err)
> -				return err;
> +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +				usecs = vi->intr_coal_rx.max_usecs;
> +				pkts = vi->intr_coal_rx.max_packets;
> +				mutex_lock(&vi->rq[i].dim_lock);
> +				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> +				mutex_unlock(&vi->rq[i].dim_lock);
> +				if (err)
> +					return err;
> +			}
>  		}
>  	}
>
> --
> 2.32.0.3.g01195cf9f
>

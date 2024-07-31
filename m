Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97B34CDE
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425482; cv=none; b=ahap2iUW7d2h6YegRGWx4KR/w0eadwoAI4YrXJygwEgIM1M6zYHbzC6lWD328yzpVH3NjcNyKtbalpOOahmMcZLFvcrO5KPUmaDqjCCoPqyihsw+2cJllouOIFPwj17xmAoHa1rksGnhIemOJB8MVeyESctuYQkD/4sVRpvf/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425482; c=relaxed/simple;
	bh=vwrjvpashV7Ts6cGhVvQN/od+tR6TyWff2zbZvPakr8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Y6Er1r3xzpdvkfrq7ehohVfxVA+A5G05vu0OvD36WS+9LYbPvNCblbPgazjb+KcqdrfRsioUqMsWRFpILehTOjKz8XeHg1/BZFfEhfmtJqXLB39aXorM6u2CH1gNDC0HXUO+PsXLcqtlsWL9n+2SqEbRwEluMc2OEt3E61msMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LRhbC/PL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LRhbC/PL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722425471; h=Message-ID:Subject:Date:From:To;
	bh=GhCYCnb3PTVULPeLefA/NMyDoPeg4ruRf4uoK4eeqJE=;
	b=LRhbC/PLnotNVAu7lNR6oQNkmppyA0yppN//FuS1dvI/UkX23TLWscbkoxZE7ih0CKQj8TiTD/ka5ft7faw7K3wKFwlGR1jE1r1p3SHfrzpQZen349mfhU0S4aIYi8jveBvhZIVwRxidBGbQ+8lE0GF97Drqx6VCFfI3EO9I7d8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjLH2Y_1722425469;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjLH2Y_1722425469)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 19:31:10 +0800
Message-ID: <1722425431.2357254-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Wed, 31 Jul 2024 19:30:31 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
 <20240730182020.75639070@kernel.org>
In-Reply-To: <20240730182020.75639070@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 30 Jul 2024 18:20:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
> 
> subject currently reads like this is an optimization, could you
> rephrase?

Jason's rephrase will be used.

> 
> > From the virtio spec:
> > 
> > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > 
> > The driver must not send vq notification coalescing commands if
> > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > applies to vq resize.
> > 
> > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..eb115e807882 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> >  	u32 rx_pending, tx_pending;
> >  	struct receive_queue *rq;
> >  	struct send_queue *sq;
> > +	u32 pkts, usecs;
> >  	int i, err;
> >  
> >  	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> > @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
> >  			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
> >  			 * did not set any TX coalescing parameters, to 0.
> >  			 */
> > -			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > -							       vi->intr_coal_tx.max_usecs,
> > -							       vi->intr_coal_tx.max_packets);
> > -			if (err)
> > -				return err;
> > +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> > +				usecs = vi->intr_coal_tx.max_usecs;
> > +				pkts = vi->intr_coal_tx.max_packets;
> > +				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> > +				if (err)
> > +					return err;
> 
> Can you check the feature inside the
> virtnet_send_.x_ctrl_coal_vq_cmd() helpers?
> 5 levels of indentation is a bit much

Makes sense. Will update in the next version.

Thanks.

> -- 
> pw-bot: cr

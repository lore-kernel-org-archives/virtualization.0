Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BE168BE
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867330; cv=none; b=Q7/myRjGAGTnS7VxszJxXDgTAnSPNUV8+KxjOPnWhr4B5Crf+EkD5a9ECOZ6MpaOXhGmhbWR08T7yGBaj9y3rqZn+oLJD/h5q75/wZOYa83nIUSGcHSvDVG4hdGeMxFphhHx7CzL2lMC0ODcWpaYiiLmLS0ryywP+rxj4QufZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867330; c=relaxed/simple;
	bh=JFKUS0X5e4eY3eWMFrdWVXy20im3XdqGedmGBm7WLF0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=pMH+hrfHXIg19HBbvppZJaD/PXMI32UFfYT7NGFagWqQ006TTit50zZrOYv+FMsL8DX33+Hogm25v6Qa/Vr2MYBwlLtRGD7/i858RsvYj/IHcjS50oXzZ7x8eZQ4AB+ENwEy+QlQRL5XAvSm0kdI54Vy17P042LNxnHPZZHRjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qnE23DHx; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qnE23DHx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716867325; h=Message-ID:Subject:Date:From:To;
	bh=0pY+mRH71tMWhkIyLQMybAgvNh0N1drY2pCaThwcXlo=;
	b=qnE23DHxmL5uXOcMMbolzLWKig0sZ//vdSAngR3Kw4lqUqUMCfN0EygTEwEAOyGJx9DGub12P08BMHAZYE2pEUTZf0L1i1db+jsO35W059r+Bd0pYxd9X8WeCYXvAOPhYFrhNEGyh5Fps9qxWrA80wzgaPN7fanEbxHm+qVsNx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7OHIBa_1716867323;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7OHIBa_1716867323)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 11:35:24 +0800
Message-ID: <1716865564.880848-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue RX coalesce"
Date: Tue, 28 May 2024 11:06:04 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
 <20240523074651.3717-3-hengqi@linux.alibaba.com>
 <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
In-Reply-To: <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 27 May 2024 12:42:43 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2024-05-23 at 15:46 +0800, Heng Qi wrote:
> > This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
> > 
> > When the following snippet is run, lockdep will report a deadlock[1].
> > 
> >   /* Acquire all queues dim_locks */
> >   for (i = 0; i < vi->max_queue_pairs; i++)
> >           mutex_lock(&vi->rq[i].dim_lock);
> > 
> > There's no deadlock here because the vq locks are always taken
> > in the same order, but lockdep can not figure it out, and we
> > can not make each lock a separate class because there can be more
> > than MAX_LOCKDEP_SUBCLASSES of vqs.
> > 
> > However, dropping the lock is harmless:
> >   1. If dim is enabled, modifications made by dim worker to coalescing
> >      params may cause the user's query results to be dirty data.
> 
> It looks like the above can confuse the user-space/admin?

Maybe, but we don't seem to guarantee this --
the global query interface (.get_coalesce) cannot 
guarantee correct results when the DIM and .get_per_queue_coalesce are present:

1. DIM has been around for a long time (it will modify the per-queue parameters),
   but many nics only have interfaces for querying global parameters.
2. Some nics provide the .get_per_queue_coalesce interface, it is not
   synchronized with DIM.

So I think this is acceptable.

> 
> Have you considered instead re-factoring
> virtnet_send_rx_notf_coal_cmds() to avoid acquiring all the mutex in
> sequence?

Perhaps it is a way to not traverse and update the parameters of each queue
in the global settings interface.

Thanks.

> 
> Thanks!
> 
> Paolo
> 

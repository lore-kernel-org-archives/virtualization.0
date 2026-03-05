Received: from out30-82.freemail.mail.aliyun.com (out30-82.freemail.mail.aliyun.com [115.124.30.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AD39901C
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712066; cv=none; b=qhQbvDkidHYzv8I6fGaeXaRCjUYsH4SE16frQi9HFkM1SnqHJwOBCc00LQxlWFdi5SRxbPVwOqFPAK0b9+glWXoVUKJebfBXM7hlEFurSQZ9bK5aw9K0X8KvGtbOtp8WUJvipkEoyv5vwUmI684KhoYhLaT2LTAqDfIuFXaHnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712066; c=relaxed/simple;
	bh=Arb/GdA6+lTl4sPbNYIHApHyZFMGkgY9FOnJUEXeoNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi66kiqG8c+jnU8puWvVKWn3S2jbVFW0Fn/dSLfBc6yyGC96sDgbYK5ZJeDcBgI24BlPKQmAG9hoR1qOOb9LJJ3XnMDFl25nMXQc4CR4uR4eapHthPaJyn7oIXn5bNVFwtiBGEQblzsNeS6UlIxvFAgwgob9HVlLzkpeDaGEZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=LO/GiU0U; arc=none smtp.client-ip=115.124.30.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="LO/GiU0U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772712060; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=At756iesoGZPzZquPymaWYJcgA0qMiy/N8ArMyjPcC4=;
	b=LO/GiU0UwgTk1+YPl4VkvH5G2Kq1+TmKUn073QP0bN0T5Jl8HApUHmUC2PTRLA03yAtDlsTp8cdZhAcK6wmF2V+96HkUhjDi9Xmi0rSIecsL9qt4DdpnIRN62xgVWqY4WV3B8JCA3sYdCnbCpaoXcP/183dyYHxf6FEb1YLkuQU=
Received: from wdhh66@aliyun.com(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-K9gbA_1772712056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 20:01:00 +0800
Date: Thu, 5 Mar 2026 20:00:55 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Fix data races in split virtqueue used ring
 accesses
Message-ID: <aalwd44kySVAcpOs@wdhh66@aliyun.com>
References: <20260305092927.3866089-1-wdhh6@aliyun.com>
 <20260305044559-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305044559-mutt-send-email-mst@kernel.org>

On Thu, Mar 05, 2026 at 04:48:29AM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 05, 2026 at 05:29:27PM +0800, Chaohai Chen wrote:
> > KCSAN detected multiple data races when accessing the split virtqueue's
> > used ring, which is shared memory concurrently accessed by both the CPU
> > and the virtio device (hypervisor).
> > 
> > The races occur when reading the following fields without proper atomic
> > operations:
> > - vring.used->idx
> > - vring.used->flags
> > - vring.used->ring[].id
> > - vring.used->ring[].len
> > 
> > These fields reside in DMA-shared memory and can be modified by the
> > virtio device at any time. Without READ_ONCE(), the compiler may perform
> > unsafe optimizations such as value caching or load tearing.
> 
> .... but does not.
> 
> 
Sorry, you are right. There is virtio_rmb() doing synchronize.
> > @@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
> >  			&vring_used_event(&vq->split.vring),
> >  			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
> >  
> > -	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
> > -					- vq->last_used_idx) > bufs)) {
> > +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
> > +				READ_ONCE(vq->split.vring.used->idx))
KSCAN just warned this code, and I understand virtio_store_mb() above it
can not synchronize here. Do you think we can just change this line ?
> > +				- vq->last_used_idx) > bufs)) {
> >  		END_USE(vq);
> >  		return false;

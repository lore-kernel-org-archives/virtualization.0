Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DF1CF8B
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412324; cv=none; b=luoMGMwNOQ+TcmppQuoOz+r+VKOGV1S20tntq/KOJx13v28X9nHBtV1WYgGNBUvG9IjwpOimb8zBzTortJtpIG/Q7cVUE5t50/oCMFz/jG1dyUPP0pQEvaNNtafzmTGps4aTROWJapTTotPS3BZrEgtDSDySbn6X80+Em71tT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412324; c=relaxed/simple;
	bh=4u5xVp5TnwLZTh7dIRHY4bKsceG8AE3TAWJalgr5Ac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F+9ov6UDBCpureO65f8Uik9HmaYllPERPZJCLlJB2SsnJE1QqbfteGVsKAHfT5g5Br0QBLLDtVFIVQHdywQe0k6V2mxFn8xHx3eku2OrgfChhwy6Py+GT8szMItzNNArD4szV5v1+tI0GnOppqeDl8ld2al6NMO5HlYgADvUMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyV5ti1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyV5ti1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772412320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv0k8lngNVzpQy1IMYA5foV0UbEwsl2jdcB0vqaVFDY=;
	b=SyV5ti1QjsTUlpL77JFKvFZnRgaNtChECGgFK6laDeVA1FpL9p/ELxK1D3+FYH3Qxr12sM
	p1wTGM6L/JOt+8BWXcLob5qB/mYDOLMI7NsFjNh+GSJHvrp1h5iAMCpHHEPduDDbzdoXrb
	nY7hqa1GPtQehqmH01oLIqMiS5xnrdg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-DDUCJomqNimZ624XPZflGg-1; Sun, 01 Mar 2026 19:45:19 -0500
X-MC-Unique: DDUCJomqNimZ624XPZflGg-1
X-Mimecast-MFC-AGG-ID: DDUCJomqNimZ624XPZflGg_1772412318
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so41495695e9.3
        for <virtualization@lists.linux.dev>; Sun, 01 Mar 2026 16:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772412318; x=1773017118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv0k8lngNVzpQy1IMYA5foV0UbEwsl2jdcB0vqaVFDY=;
        b=ksAmCnX2SsllxyUlokL5DGiwjO8b/eTFE9BL4CXTxgu/6iKOfe2CQaApCLPWaDmauP
         0zpdJd9QQajY3MDNpWTuvOWMJiGkMYmQJtbopdIbHqB/91y2Pq7LT5GjglbA1D8rpfav
         H/6Ow4iUOoxpUSE9EH5aroSAeIdBRVW393r2h19sMbL8q/stFe1hU5D+BIRTL63/745q
         4Jubo4dR9tSjWxj0QXxihpIqtpIc1DCLy65Gb+kqSqSZX0bPL2YA2Ga1/h1/XccwLvE0
         qg3pHcwD2p6IxtTrkOIA16wJpqV3qjj1aQSxR6qDXwtdFQeTPwfTcBtl4Gx36ERBFEYP
         JydA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwiQhIhZ7O3a29IrxccbrvKLHsXaI6Nf8TClUR0tTo9El9Z/PPb1PkPDa9CXKI1WORQIQ6VsR19X+6rgCKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdLmBQ4/n0hML9b78aO6iVNDHzWhtUP3Z+oGGfERZHbf1Ddo36
	0TNAYvPZ3ZvMHnolX+yLPYtIFwRRTYqUoW1//hEOeMn9hG1bC3m4YfSOq+74TrmyYXC1ceTjZ+K
	FGje6GR8oYMhRhExpgNrbCKky2iIrs7a+ORqgpwyTzNSYhgpz1+1+R/w9vK3PX4laJ2rB
X-Gm-Gg: ATEYQzxq2kgMaGIA+h2n4JpJn/OS0QpT7prx90Z04r06ptR1VnLL3jiFmQxzqnXKOij
	2w+S8q+hr/6HHIIe4594VmAJOhGeBulsRhZva+IMMFsbkWToGqZU5ZZOA/e6OiffDd578MqggOF
	APzTiFtWqNwcAQg9D91LRn1/4GomwvUjlKUA3xj3PvwmVxCC2V7rlx9IDKIo5NAXaiGPBettwFo
	7GzxYpLT5f4kyQ5H0mPOEpEofn+lclj7V3JgqAW7SPtrZRMaHXGmVTkvFzW5NQwpO9n3p2cOjdi
	atmV2D8qaRPUoVn6LtJzB1W/WPTR4dBZKy0VfrJNKuidQsa87cj1UCVZ3LMZb1s4yS4i4E47FD+
	og4uuOmtj5CKBW7ICGUPRlIrJ2KxQhFaUO15KUdrB4dzuyQ==
X-Received: by 2002:a05:600c:530c:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c9b971a3mr177121075e9.1.1772412318360;
        Sun, 01 Mar 2026 16:45:18 -0800 (PST)
X-Received: by 2002:a05:600c:530c:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c9b971a3mr177120815e9.1.1772412317848;
        Sun, 01 Mar 2026 16:45:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f2f88sm357274885e9.2.2026.03.01.16.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:45:17 -0800 (PST)
Date: Sun, 1 Mar 2026 19:45:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ShuangYu <shuangyu@yunyoo.cc>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds
 virtqueue capacity
Message-ID: <20260301194456-mutt-send-email-mst@kernel.org>
References: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
 <20260301190906-mutt-send-email-mst@kernel.org>
 <20260301193655-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260301193655-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cI8gXcSvq0PXhLs_V0SGDcXY3lBSFAPefF4wxUpJ_IY_1772412318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 01, 2026 at 07:39:30PM -0500, Michael S. Tsirkin wrote:
> On Sun, Mar 01, 2026 at 07:10:06PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Mar 01, 2026 at 10:36:39PM +0000, ShuangYu wrote:
> > > Hi,
> > > 
> > > We have hit a severe livelock in vhost_net on 6.18.x. The vhost
> > > kernel thread spins at 100% CPU indefinitely in handle_rx(), and
> > > QEMU becomes unkillable (stuck in D state).
> > > [This is a text/plain messages]
> > > 
> > > Environment
> > > -----------
> > >   Kernel:  6.18.10-1.el8.elrepo.x86_64
> > >   QEMU:    7.2.19
> > >   Virtio:  VIRTIO_F_IN_ORDER is negotiated
> > >   Backend: vhost (kernel)
> > > 
> > > Symptoms
> > > --------
> > >   - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
> > >   - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
> > >   - kill -9 has no effect on the QEMU process
> > >   - libvirt management plane deadlocks ("cannot acquire state change lock")
> > > 
> > > Root Cause
> > > ----------
> > > The livelock is triggered when a GRO-merged packet on the host TAP
> > > interface (e.g., ~60KB) exceeds the remaining free capacity of the
> > > guest's RX virtqueue (e.g., ~40KB of available buffers).
> > > 
> > > The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:
> > > 
> > >   1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
> > >     It advances vq->last_avail_idx and vq->next_avail_head as it
> > >     consumes buffers, but runs out before satisfying datalen.
> > > 
> > >   2. get_rx_bufs() jumps to err: and calls
> > >     vhost_discard_vq_desc(vq, headcount, n), which rolls back
> > >     vq->last_avail_idx and vq->next_avail_head.
> > > 
> > >     Critically, vq->avail_idx (the cached copy of the guest's
> > >     avail->idx) is NOT rolled back. This is correct behavior in
> > >     isolation, but creates a persistent mismatch:
> > > 
> > >       vq->avail_idx      = 108  (cached, unchanged)
> > >       vq->last_avail_idx = 104  (rolled back)
> > > 
> > >   3. handle_rx() sees headcount == 0 and calls vhost_enable_notify().
> > >     Inside, vhost_get_avail_idx() finds:
> > > 
> > >       vq->avail_idx (108) != vq->last_avail_idx (104)
> > > 
> > >     It returns 1 (true), indicating "new buffers available."
> > >     But these are the SAME buffers that were just discarded.
> > > 
> > >   4. handle_rx() hits `continue`, restarting the loop.
> > > 
> > >   5. In the next iteration, vhost_get_vq_desc_n() checks:
> > > 
> > >       if (vq->avail_idx == vq->last_avail_idx)
> > > 
> > >     This is FALSE (108 != 104), so it skips re-reading the guest's
> > >     actual avail->idx and directly fetches the same descriptors.
> > > 
> > >   6. The exact same sequence repeats: fetch -> too small -> discard
> > >     -> rollback -> "new buffers!" -> continue. Indefinitely.
> > > 
> > > This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
> > > support, which added vhost_get_vq_desc_n() with the cached avail_idx
> > > short-circuit check, and the two-argument vhost_discard_vq_desc()
> > > with next_avail_head rollback. The mismatch between the rollback
> > > scope (last_avail_idx, next_avail_head) and the check scope
> > > (avail_idx vs last_avail_idx) was not present before this change.
> > > 
> > > bpftrace Evidence
> > > -----------------
> > > During the 100% CPU lockup, we traced:
> > > 
> > >   @get_rx_ret[0]:      4468052   // get_rx_bufs() returns 0 every time
> > >   @peek_ret[60366]:    4385533   // same 60KB packet seen every iteration
> > >   @sock_err[recvmsg]:        0   // tun_recvmsg() is never reached
> > > 
> > > vhost_get_vq_desc_n() was observed iterating over the exact same 11
> > > descriptor addresses millions of times per second.
> > > 
> > > Workaround
> > > ----------
> > > Either of the following avoids the livelock:
> > > 
> > >   - Disable GRO/GSO on the TAP interface:
> > >      ethtool -K <tap> gro off gso off
> > > 
> > >   - Switch from kernel vhost to userspace QEMU backend:
> > >      <driver name='qemu'/> in libvirt XML
> > > 
> > > Bisect
> > > ------
> > > We have not yet completed a full git bisect, but the issue does not
> > > occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
> > > support. We will follow up with a Fixes: tag if we can identify the
> > > exact commit.
> > > 
> > > Suggested Fix Direction
> > > -----------------------
> > > In handle_rx(), when get_rx_bufs() returns 0 (headcount == 0) due to
> > > insufficient buffers (not because the queue is truly empty), the code
> > > should break out of the loop rather than relying on
> > > vhost_enable_notify() to make that determination. For example, when
> > > get_rx_bufs() returns r == 0 with datalen still > 0, this indicates a
> > > "packet too large" condition, not a "queue empty" condition, and
> > > should be handled differently.
> > > 
> > > Thanks,
> > > ShuangYu
> > 
> > Hmm. On a hunch, does the following help? completely untested,
> > it is night here, sorry.
> > 
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2f2c45d20883..aafae15d5156 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> >  static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  {
> >  	__virtio16 idx;
> > +	u16 avail_idx;
> >  	int r;
> >  
> >  	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  	}
> >  
> >  	/* Check it isn't doing very strange thing with available indexes */
> > -	vq->avail_idx = vhost16_to_cpu(vq, idx);
> > -	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> >  		vq_err(vq, "Invalid available index change from %u to %u",
> >  		       vq->last_avail_idx, vq->avail_idx);
> >  		return -EINVAL;
> >  	}
> >  
> >  	/* We're done if there is nothing new */
> > -	if (vq->avail_idx == vq->last_avail_idx)
> > +	if (avail_idx == vq->avail_idx)
> >  		return 0;
> >  
> > +	vq->avail_idx == avail_idx;
> > +
> 
> meaning 
> 	vq->avail_idx = avail_idx; 
> of course
> 
> >  	/*
> >  	 * We updated vq->avail_idx so we need a memory barrier between
> >  	 * the index read above and the caller reading avail ring entries.


and the change this is fixing was done in d3bb267bbdcba199568f1325743d9d501dea0560

-- 
MST


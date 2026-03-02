Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21607175A79
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772411975; cv=none; b=M20hzuwY7dXl0k7clSJ1uZegsTbOnzCwmT1DUcJStq0bX9ieYt956PEzhBzVeVqE6q7tOthhunAoETnwG+QvhgqxjgC7xppozWx1K0wSW7AOSlQwv1p8jOM7AKpG1wS0M2jaq+Snqn9p6Rr7XULjQCpcJKabedSO2OH4sCHRPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772411975; c=relaxed/simple;
	bh=BZvneyi2fug8jCHx1wx/qQYkX8TN4g9GkJ1fUCoTrqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D/vOpznlRkyUfhAHkZpvmUnFeqNNbu9iQEEWHfiIqy1+nw44q47KLUJqMc1Kq2gfmz17lAsXsiYwnOxSfw8PByARoOykfcaSAbNDVVc//i1Dl9D6Ca/9vbqhmOL29aaQIM5g9W0gyUdX5NNISobj7flQKuA+TolIwa0k7C/heUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUkmkdNG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUkmkdNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772411973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTF6kDwd+ASW+3oSbEKWEwX0z9wkMsuXGlelIIfczUk=;
	b=OUkmkdNGgveTdTuOaXEha+bzNsKq/ZCYJMbOZwfDtnlskGr2gTb0SzoOSm9iqY7ZdlqhnN
	+ISSbvkLfc46pJ/YoUM5p9YbTQ5RawFwFK7+04CYz9yNtHDblJuPxRCymqMTzWMmh82bfT
	obrEO1H74Rrnh9MeX62ogIVxipflu3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-G1-_tvDxNYqcNoucsfJkDA-1; Sun, 01 Mar 2026 19:39:32 -0500
X-MC-Unique: G1-_tvDxNYqcNoucsfJkDA-1
X-Mimecast-MFC-AGG-ID: G1-_tvDxNYqcNoucsfJkDA_1772411971
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so32829495e9.2
        for <virtualization@lists.linux.dev>; Sun, 01 Mar 2026 16:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772411971; x=1773016771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTF6kDwd+ASW+3oSbEKWEwX0z9wkMsuXGlelIIfczUk=;
        b=npWZdU93NwUIcgqsZ6b0M4FYxPBF85EnEqjcBjnIHrJ9F76twurASDEddzs0cfjFRz
         98Qc8G8NzZXw0QYIfIPoKCIkEf2eedv+aYj36LV9D9e2ZwxqJwqLo0RiTu1cuqelnXoK
         aSaMxS/aPtZ9SP8fkYuTVuPznVGdNEnHnwPAgO1v1ogBXI7xMiBtrkIiVTgzoBltwJYC
         AM0Bbmt+Tzyg6IdawugoamAsiWLx95q2TYLhym/zX3ukdrhFSBCHt5k0ZhCrAIbnYiFn
         9JDk0K1Z+NeNvDJX3uLEbbMOy9Q7dnrHgOBeJvryGPTNhFYr7fbrM3ojzXiA5Jjb8vuz
         tCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUIHq/LSzKQMyE23TIM/xkc5oyIyO4akFqq4Swo8BMzRBqOSeiW9WkueBrOp8kngKJ/QA7nFu0tA60msY4jiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4BRgIo18ppI5WAqcwyzGl7LguGxFzy3mopvgSMlU718FKYSuA
	ZIZU9cf7PW3dfilpkl2j3g7dDIWmBOErJHRO0zIuQN6tbChEg+B2n2uTi34AKM8gsqg3VOIS9Ck
	ewN7py7pb2JQmRX335HDc41S1RWHs7BDw4LHja151nIVrDdTOLlkvWrCeQbx/jlGteSh4
X-Gm-Gg: ATEYQzxUjVEHzGEgyXyDZnurDGQ5DGz4Djch/cf5mCCvSPVX+MY9mvcx3vug9Pq+cEY
	ujb3mW5eAZFkxX+df+MwyINAmcbD+2ZuuaWy6zsFTyY75GRpL2XKX/vtVexmanjgehHP8/uGBCs
	IrKXE9Y7CEo+kOvhq1WxvA7gUMOzZpSQroybFMZuN2xpCBsxqOjtqs9EwuYGiGQczgjlnX/vbu5
	Al2Jgev60zkNoDT6zZlxpjg5CDFdrLghn6E+cSBOXtl58bbbUwmlnSSxgmSopzDbEyl1ShhdLXH
	XfwPQ0RENXYDakTheyy1Hs0CHbYVNcae2WjBo4F0cZSrgTAbWIZgBoKPwYN4ghAufgxgQoEoUya
	K4/331UG5GY99z3Oo3sAPWLMW7ayquKO0pYPK/gStHGlgmw==
X-Received: by 2002:a05:600c:1f06:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-483c9bc557fmr186715275e9.15.1772411970769;
        Sun, 01 Mar 2026 16:39:30 -0800 (PST)
X-Received: by 2002:a05:600c:1f06:b0:47d:586e:2fea with SMTP id 5b1f17b1804b1-483c9bc557fmr186715055e9.15.1772411970250;
        Sun, 01 Mar 2026 16:39:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm266409425e9.9.2026.03.01.16.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:39:29 -0800 (PST)
Date: Sun, 1 Mar 2026 19:39:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ShuangYu <shuangyu@yunyoo.cc>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds
 virtqueue capacity
Message-ID: <20260301193655-mutt-send-email-mst@kernel.org>
References: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
 <20260301190906-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260301190906-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b6Qd8tkLVLSLR3Wzlf9L3bsOGTdUSgZOaYhoOtjXBc4_1772411971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 01, 2026 at 07:10:06PM -0500, Michael S. Tsirkin wrote:
> On Sun, Mar 01, 2026 at 10:36:39PM +0000, ShuangYu wrote:
> > Hi,
> > 
> > We have hit a severe livelock in vhost_net on 6.18.x. The vhost
> > kernel thread spins at 100% CPU indefinitely in handle_rx(), and
> > QEMU becomes unkillable (stuck in D state).
> > [This is a text/plain messages]
> > 
> > Environment
> > -----------
> >   Kernel:  6.18.10-1.el8.elrepo.x86_64
> >   QEMU:    7.2.19
> >   Virtio:  VIRTIO_F_IN_ORDER is negotiated
> >   Backend: vhost (kernel)
> > 
> > Symptoms
> > --------
> >   - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
> >   - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
> >   - kill -9 has no effect on the QEMU process
> >   - libvirt management plane deadlocks ("cannot acquire state change lock")
> > 
> > Root Cause
> > ----------
> > The livelock is triggered when a GRO-merged packet on the host TAP
> > interface (e.g., ~60KB) exceeds the remaining free capacity of the
> > guest's RX virtqueue (e.g., ~40KB of available buffers).
> > 
> > The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:
> > 
> >   1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
> >     It advances vq->last_avail_idx and vq->next_avail_head as it
> >     consumes buffers, but runs out before satisfying datalen.
> > 
> >   2. get_rx_bufs() jumps to err: and calls
> >     vhost_discard_vq_desc(vq, headcount, n), which rolls back
> >     vq->last_avail_idx and vq->next_avail_head.
> > 
> >     Critically, vq->avail_idx (the cached copy of the guest's
> >     avail->idx) is NOT rolled back. This is correct behavior in
> >     isolation, but creates a persistent mismatch:
> > 
> >       vq->avail_idx      = 108  (cached, unchanged)
> >       vq->last_avail_idx = 104  (rolled back)
> > 
> >   3. handle_rx() sees headcount == 0 and calls vhost_enable_notify().
> >     Inside, vhost_get_avail_idx() finds:
> > 
> >       vq->avail_idx (108) != vq->last_avail_idx (104)
> > 
> >     It returns 1 (true), indicating "new buffers available."
> >     But these are the SAME buffers that were just discarded.
> > 
> >   4. handle_rx() hits `continue`, restarting the loop.
> > 
> >   5. In the next iteration, vhost_get_vq_desc_n() checks:
> > 
> >       if (vq->avail_idx == vq->last_avail_idx)
> > 
> >     This is FALSE (108 != 104), so it skips re-reading the guest's
> >     actual avail->idx and directly fetches the same descriptors.
> > 
> >   6. The exact same sequence repeats: fetch -> too small -> discard
> >     -> rollback -> "new buffers!" -> continue. Indefinitely.
> > 
> > This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
> > support, which added vhost_get_vq_desc_n() with the cached avail_idx
> > short-circuit check, and the two-argument vhost_discard_vq_desc()
> > with next_avail_head rollback. The mismatch between the rollback
> > scope (last_avail_idx, next_avail_head) and the check scope
> > (avail_idx vs last_avail_idx) was not present before this change.
> > 
> > bpftrace Evidence
> > -----------------
> > During the 100% CPU lockup, we traced:
> > 
> >   @get_rx_ret[0]:      4468052   // get_rx_bufs() returns 0 every time
> >   @peek_ret[60366]:    4385533   // same 60KB packet seen every iteration
> >   @sock_err[recvmsg]:        0   // tun_recvmsg() is never reached
> > 
> > vhost_get_vq_desc_n() was observed iterating over the exact same 11
> > descriptor addresses millions of times per second.
> > 
> > Workaround
> > ----------
> > Either of the following avoids the livelock:
> > 
> >   - Disable GRO/GSO on the TAP interface:
> >      ethtool -K <tap> gro off gso off
> > 
> >   - Switch from kernel vhost to userspace QEMU backend:
> >      <driver name='qemu'/> in libvirt XML
> > 
> > Bisect
> > ------
> > We have not yet completed a full git bisect, but the issue does not
> > occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
> > support. We will follow up with a Fixes: tag if we can identify the
> > exact commit.
> > 
> > Suggested Fix Direction
> > -----------------------
> > In handle_rx(), when get_rx_bufs() returns 0 (headcount == 0) due to
> > insufficient buffers (not because the queue is truly empty), the code
> > should break out of the loop rather than relying on
> > vhost_enable_notify() to make that determination. For example, when
> > get_rx_bufs() returns r == 0 with datalen still > 0, this indicates a
> > "packet too large" condition, not a "queue empty" condition, and
> > should be handled differently.
> > 
> > Thanks,
> > ShuangYu
> 
> Hmm. On a hunch, does the following help? completely untested,
> it is night here, sorry.
> 
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2f2c45d20883..aafae15d5156 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>  static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  {
>  	__virtio16 idx;
> +	u16 avail_idx;
>  	int r;
>  
>  	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  	}
>  
>  	/* Check it isn't doing very strange thing with available indexes */
> -	vq->avail_idx = vhost16_to_cpu(vq, idx);
> -	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> +	avail_idx = vhost16_to_cpu(vq, idx);
> +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
>  		vq_err(vq, "Invalid available index change from %u to %u",
>  		       vq->last_avail_idx, vq->avail_idx);
>  		return -EINVAL;
>  	}
>  
>  	/* We're done if there is nothing new */
> -	if (vq->avail_idx == vq->last_avail_idx)
> +	if (avail_idx == vq->avail_idx)
>  		return 0;
>  
> +	vq->avail_idx == avail_idx;
> +

meaning 
	vq->avail_idx = avail_idx; 
of course

>  	/*
>  	 * We updated vq->avail_idx so we need a memory barrier between
>  	 * the index read above and the caller reading avail ring entries.


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD9387597
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464340; cv=none; b=BphspHPi3w1VhJDwugEVtkJnjBa0U0LE59dY6bxbTO+rRWrW1EAo8aRfAYJgjUbQmsaZZI7/eSOxlQeYwQjAtNuhaMEFw2AmtMdBSWNlGutnE4AY8dxoKeTfuF2e4vnl0fu/F/wF8zZo2ZE/5owEaEXFnycoY9Nij2PiLx/LVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464340; c=relaxed/simple;
	bh=op0liavrrZXpHIYFE8b5murCMpJBWBYITF7jRogwVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=owgrppls7IyWfBpEKSR678IRptjglei0L5wrPYqIQh5fqpwEAPtraOU2GyRjZEV5hQf0bf2rfeetS1KJCAdNKAebCC4Q4g/zN94DdCQLvY4E20WxqQQi4OizMxL7PRLZCo1RyP9djtVJ5W2J7kDB38R7Xbk4GwajmI+gBc2vars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PblpajQg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PblpajQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772464338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RF0n2SJ1RvllNep2fFvHq0JPMVeIU4OKpnJDj8ItlsE=;
	b=PblpajQgsZ/jY4gZ0pl6X+2keNeiW7LebN6X4vdrjMFx91WBrJNYXK1Lq0aB2yB7gY634E
	BZpVcldh7vpyvyvbX0Xh9fuKhbmrB4f0wLkWEkRKPMiyC5IENt2GeWGQeh2lWz+XsmDt05
	qNLuOg+7xwW+M3Sk+axVmka+N5NugKQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Sb9cnF4VNxOxG0w7na0K-g-1; Mon, 02 Mar 2026 10:12:16 -0500
X-MC-Unique: Sb9cnF4VNxOxG0w7na0K-g-1
X-Mimecast-MFC-AGG-ID: Sb9cnF4VNxOxG0w7na0K-g_1772464335
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836e35292cso38730695e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 07:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464335; x=1773069135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF0n2SJ1RvllNep2fFvHq0JPMVeIU4OKpnJDj8ItlsE=;
        b=qAvdb23CqJV9YyOQFCO0wibJLjcft0UPtqJktG/sZ3yyHnwtK6eKqMyvcyE6S7mJKW
         W7srEJYg8fiW0HKKdkpjanby/jrsSnF8/8Z7hQedyCQWWwwE7y6pTd4k0IiG5sz+Gsap
         ScbHfFEmSUzOSFOlMm4a3ioIOahVGZQggJjtGRsaDN3g3QLr/0JrYXk0WOuzuSriOe2e
         CN+GXylFDf5irMT+HYPKxqV5V9FUAdFrDhWzBaiDO7WHgb1aw9altMHHaP2oEgZJbsgm
         cEm+RVyv8zzYwBFIVYCJpt973lEgPoeu90s/2o+rOZY+hhE9Z6O6k4e4o33k6ux3e2hp
         x9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVB6hJAd4IudcYdMbuIlL7S+6Dl3UQX9BwFqeSQUuk1tnjB20rVPjJB+zPUpQdvwOUk0pCU+aqi3P9wM6PXyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBIbPsHtc2djbOVwvp2IYffRE+bUuCeCholcaGcj3hv8CeA3o5
	Ot5KsQjibERfhTsHrkFO0lJzTW7Zw5VgRhQJw6g8n0rDzvXKxfPyPDQXhmCTHBzNBX2hvbU5u/y
	M+ap59Xuaccoa3fA5EeQr2S9Q7WaPHe5Q7vsoA8tG1YqGIHwID/3m74tAIEH7mTNV5qPn
X-Gm-Gg: ATEYQzy4gtHixrcHb2aF4xZ2V9bYWSWHwx+fYtDrAfhzp+SdJlSSwMT6TtLNhh5uHFO
	NVSAA+M+xVhoEQku7QMzbThgeVqmg1SD8bEig+DvooYUXM4htJYDvtSaBCftyCGDlByL8xOGpuu
	6E0o8CsINx11v5bxhuFDYmLN/5uckbkHH5SrjDN+DKYiF3x5l84d/Zm4ejacBgT8nXN2N6t9I0h
	PWpGWf8VJc2KGv8gaULeKCkHeTfyTEhfwQKoO9j/2gJYiPcM2IA6P3KksHFypGNFl94SpYhYzUR
	Pt/ujvh/Y5IqQOzYWSKFZOpVALCFJZmPBeZlOjWNxqRfmJU1cmwL832B6F+ucHjJG92y/8htlDs
	dICq1bu4J6wBdqjxFR9zAWge9mfI2hVh65xkDtnYX0TTlHg==
X-Received: by 2002:a05:600c:8106:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483c9bb6559mr206067795e9.4.1772464335151;
        Mon, 02 Mar 2026 07:12:15 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483c9bb6559mr206067215e9.4.1772464334575;
        Mon, 02 Mar 2026 07:12:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd765604sm360962425e9.15.2026.03.02.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:12:13 -0800 (PST)
Date: Mon, 2 Mar 2026 10:12:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <20260302101125-mutt-send-email-mst@kernel.org>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
 <aaWTjPXDqhMZlwLr@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aaWTjPXDqhMZlwLr@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5dynXSyW1A-imDRjw-Jm-QlGvZWMBqpLeGSqBKCDqc_1772464335
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2026 at 03:30:53PM +0100, Stefano Garzarella wrote:
> On Mon, Mar 02, 2026 at 03:51:49AM -0500, Michael S. Tsirkin wrote:
> > vhost_get_avail_idx is supposed to report whether it has updated
> > vq->avail_idx. Instead, it returns whether all entries have been
> > consumed, which is usually the same. But not always - in
> > drivers/vhost/net.c and when mergeable buffers have been enabled, the
> > driver checks whether the combined entries are big enough to store an
> > incoming packet. If not, the driver re-enables notifications with
> > available entries still in the ring. The incorrect return value from
> > vhost_get_avail_idx propagates through vhost_enable_notify and causes
> > the host to livelock if the guest is not making progress, as vhost will
> > immediately disable notifications and retry using the available entries.
> 
> Here I'd add something like this just to make it clear the full picture,
> because I spent quite some time to understand how it was related to the
> Fixes tag (which I agree is the right one to use).
> 
>   This goes back to commit d3bb267bbdcb ("vhost: cache avail index in
>   vhost_enable_notify()") which changed vhost_enable_notify() to compare
>   the freshly read avail index against vq->last_avail_idx instead of the
>   previously cached vq->avail_idx. Commit 7ad472397667 ("vhost: move
>   smp_rmb() into vhost_get_avail_idx()") then carried over the same
>   comparison when refactoring vhost_enable_notify() to call the unified
>   vhost_get_avail_idx().

Indeed.

> > 
> > The obvious fix is to make vhost_get_avail_idx do what the comment
> > says it does and report whether new entries have been added.
> > 
> > Reported-by: ShuangYu <shuangyu@yunyoo.cc>
> > Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Lightly tested, posting early to simplify testing for the reporter.
> 
> Tested with vhost-vsock and I didn't see any issue.
> 
> Thanks!
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> > 
> > drivers/vhost/vhost.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2f2c45d20883..db329a6f6145 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> > static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> > {
> > 	__virtio16 idx;
> > +	u16 avail_idx;
> > 	int r;
> > 
> > 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> > 	}
> > 
> > 	/* Check it isn't doing very strange thing with available indexes */
> > -	vq->avail_idx = vhost16_to_cpu(vq, idx);
> > -	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> > 		vq_err(vq, "Invalid available index change from %u to %u",
> > -		       vq->last_avail_idx, vq->avail_idx);
> > +		       vq->last_avail_idx, avail_idx);
> > 		return -EINVAL;
> > 	}
> > 
> > 	/* We're done if there is nothing new */
> > -	if (vq->avail_idx == vq->last_avail_idx)
> > +	if (avail_idx == vq->avail_idx)
> > 		return 0;
> > 
> > +	vq->avail_idx = avail_idx;
> > +
> > 	/*
> > 	 * We updated vq->avail_idx so we need a memory barrier between
> > 	 * the index read above and the caller reading avail ring entries.
> > -- 
> > MST
> > 


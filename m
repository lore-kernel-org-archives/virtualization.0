Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C13FD155
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461868; cv=none; b=ENyZ9DzphGhR/42crq2gAfl/IIFqrJD9RKIJ51QGkvYZS51Q4eNdUgaEBd4OEoN4IFNAIKYb+yxn2Fpu6wDLlBYAHz7vnDrORKlbEYbOGaSvzhJvbfmN7WibQ5gjVNYZIx6k2vZssOuSF2OoT7rFy8maYYdFzJLsLsnIAPx9CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461868; c=relaxed/simple;
	bh=tu6vW5JzAvAhrtnD0Orm8DgWyEhTriU4R1yaRjCyZQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fUn53fPQ0HDXccIqagfT+SEyftRvMrBLJmxSi9vRJQtOLNSV+zi0YuJ6c4kw0meNOlEispP1Iz2ql1QbrPy4xGtdbJFEx8lYYHwv0n8n5FBAwU2uhDRUzFZidbxU60AL9SAIYbsAYkGnFmWagIsR26GvurHyET068Syxtk6zBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVBnDYoI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVBnDYoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772461866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKZvtx1jQH7FuclJfSavk4MXL11q6SiX0sIanHFtIBI=;
	b=FVBnDYoI0mG4fJ1PiSRkrp9KBk41qSpqh/k1jJXJCS3TSh/LW5snZokuVZGLaTZnpMPbL/
	tOO2WYSuUNuuRQlk8vqGA5R4enhYsf2u9coeRIxVySrTOmtDKvOj/ku8WdJ/MfKf9xMUZj
	FeczdhEX7m0JIkNm44/558ItMK0Y1oM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-RLUlIwASO56svVWYQ2wUKw-1; Mon, 02 Mar 2026 09:31:03 -0500
X-MC-Unique: RLUlIwASO56svVWYQ2wUKw-1
X-Mimecast-MFC-AGG-ID: RLUlIwASO56svVWYQ2wUKw_1772461862
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837246211bso58352875e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 06:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461862; x=1773066662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKZvtx1jQH7FuclJfSavk4MXL11q6SiX0sIanHFtIBI=;
        b=WTu88jRRL2NA4AXtlCgBACLKn7N+Toh6usBJsbDubI7xZwDQDpfLzPAZVIVfPQag4x
         8pJDgfR4iWZX8NOvhHckAhUhMh/TfHKC6M/tI/rlFIVtuVsmqb014Za9GqHtXZEFX+MX
         CudlcO4Qx/580mcAt5AK228cAERpCS0zyfNDWmJDQJ5us38pb/9hZEvcJS/VU8ayJoN7
         jnDbd6Ba6E2xKR9VSO5NfFL/sB+V+6LyaV9f3MzuJMVSKdAhu3MjI5iqQMV5ijYGDWuE
         tQrRAqMg6l0vd3aUpq5BgpUMS/vy2jkn13aeDKw01/Rm1c2/+H1M5XgmWkFYh7YahqWY
         /yCg==
X-Forwarded-Encrypted: i=1; AJvYcCW+iTag+JbqFkRgdsM7FT8ODIlKH3GwuE9u1O/5EXPRlHZlhFJtTGJWyS+bygNTro+vWKOT9rGhW2vdY2UhCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO+A3H4AHKDvqfmmZdoqzmOnAOsivW+tSkt3IMpFtEfSNBWKfL
	ycebVToBMyIlj1mhq03Ja0gQGDR2eFerf28UbfAbjdFg3xDvZC16kuD4cQ8o01yow+oCFlLdMUv
	nU687VwpbswFZorECFbxsThmTT7WUuCv1r5Zp8Qu7SvWRSNxT8iJFvcS94LbxhrhVxTfP
X-Gm-Gg: ATEYQzzYoxz/bQguziY9sdSVcmDFOctIs7F0sLOjcE7/7CUXgqv0037ah77+I5148kC
	/M1/ibtQMIfx8GEvm9Tcr5ODr+GCQTgnnqfOiD3bQT3cSdAYMwnSphhKiYXFxofGyE7ZQbuwZmw
	pGEWki9hxF9/FRQ0jVTV0qFCRZQnXZFX5Sxhp4uDYA+yZFQSRHi1r6FSzi5oElbcmx2A0+WxWDj
	+odNJ255YBDgnAI0yt4txVvq1Uye4Gp5SN4FWfRhPG432D//C+WOLYgt6aCGP4VC/ILIZ+KI97O
	C2H+rdD0UeuD64ML7mgSMM62Ucq51cX9c3HO0ZBg+WawqzhVZWqMcvjRbR66qWzNacvzO5UOSY+
	ae3hzj2mVLVA5fH2iA+IFktcob4tw1PIjOCSGQV97XwpiGzQSZ3XT7QYWk+Bk2rSE7rqngug=
X-Received: by 2002:a05:600c:64c7:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483c9c19a6emr218449395e9.24.1772461862149;
        Mon, 02 Mar 2026 06:31:02 -0800 (PST)
X-Received: by 2002:a05:600c:64c7:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483c9c19a6emr218448515e9.24.1772461861478;
        Mon, 02 Mar 2026 06:31:01 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm206220415e9.6.2026.03.02.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:31:00 -0800 (PST)
Date: Mon, 2 Mar 2026 15:30:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <aaWTjPXDqhMZlwLr@sgarzare-redhat>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QyKWZVnaXvJeuEvZKI8_OX6LLNkSy8WA7nwiusQzF_Y_1772461862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Mar 02, 2026 at 03:51:49AM -0500, Michael S. Tsirkin wrote:
>vhost_get_avail_idx is supposed to report whether it has updated
>vq->avail_idx. Instead, it returns whether all entries have been
>consumed, which is usually the same. But not always - in
>drivers/vhost/net.c and when mergeable buffers have been enabled, the
>driver checks whether the combined entries are big enough to store an
>incoming packet. If not, the driver re-enables notifications with
>available entries still in the ring. The incorrect return value from
>vhost_get_avail_idx propagates through vhost_enable_notify and causes
>the host to livelock if the guest is not making progress, as vhost will
>immediately disable notifications and retry using the available entries.

Here I'd add something like this just to make it clear the full picture, 
because I spent quite some time to understand how it was related to the 
Fixes tag (which I agree is the right one to use).

   This goes back to commit d3bb267bbdcb ("vhost: cache avail index in
   vhost_enable_notify()") which changed vhost_enable_notify() to compare
   the freshly read avail index against vq->last_avail_idx instead of the
   previously cached vq->avail_idx. Commit 7ad472397667 ("vhost: move
   smp_rmb() into vhost_get_avail_idx()") then carried over the same
   comparison when refactoring vhost_enable_notify() to call the unified
   vhost_get_avail_idx().

>
>The obvious fix is to make vhost_get_avail_idx do what the comment
>says it does and report whether new entries have been added.
>
>Reported-by: ShuangYu <shuangyu@yunyoo.cc>
>Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>Lightly tested, posting early to simplify testing for the reporter.

Tested with vhost-vsock and I didn't see any issue.

Thanks!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> drivers/vhost/vhost.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 2f2c45d20883..db329a6f6145 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> {
> 	__virtio16 idx;
>+	u16 avail_idx;
> 	int r;
>
> 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
>@@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> 	}
>
> 	/* Check it isn't doing very strange thing with available indexes */
>-	vq->avail_idx = vhost16_to_cpu(vq, idx);
>-	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
>+	avail_idx = vhost16_to_cpu(vq, idx);
>+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> 		vq_err(vq, "Invalid available index change from %u to %u",
>-		       vq->last_avail_idx, vq->avail_idx);
>+		       vq->last_avail_idx, avail_idx);
> 		return -EINVAL;
> 	}
>
> 	/* We're done if there is nothing new */
>-	if (vq->avail_idx == vq->last_avail_idx)
>+	if (avail_idx == vq->avail_idx)
> 		return 0;
>
>+	vq->avail_idx = avail_idx;
>+
> 	/*
> 	 * We updated vq->avail_idx so we need a memory barrier between
> 	 * the index read above and the caller reading avail ring entries.
>-- 
>MST
>


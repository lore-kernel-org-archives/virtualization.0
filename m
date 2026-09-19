Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714C3148BF
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845885; cv=none; b=ROF89kDBu93HjWKDxhmPbLBNZY6+vv+iY89D/Tw53JzZ+Prriszik1nlMFmu3qGJP0joYGdnmQRfLAUDahIxQGzIKGe2MvD13xJcEgHkZz/G1bdwv9EZoSE+JK0BNXNZ3/7M86LmEPyn17kRWeq2ebpC91Mfa7OVbwHonHiW19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845885; c=relaxed/simple;
	bh=NeHshQNFCGwJF2ysi+RWsWuwph5Ge0ieMHHyeUv2SS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E1EGULdgGK+x6T5zv1bLeu+2Y12R25bn5KgXKyWisCs67Jr1Pz9x5xINu1s60lS0wRVh7h7aNF1y+SczWLFOlzFnmj0zU0Uld0fn8Zu6EXv0qfKYlhYhGngf4H8zmMv/ybHgxcOKL1CHCFT0Dqb1cFQdiL/6J0SiG+1Up/0galo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGzD+gLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGzD+gLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789845882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjyUSthyZu35KpQeM9B/0jd7CF9c0bVVky2/qXbbeS4=;
	b=VGzD+gLlsQrMifF3+CMMRFj6AhU9LHFoULnB0WVC6DkdNAAilC57HBfz/M3b7/4ea449qV
	eTu2ubozrffDgvbJ5ZVP4hem0peLofHY5AaxfAnZZdSH1hSMaPMBF4l9w0xN3M2k4ws1m0
	pFcGiKatmM92Gfb22eiWpO7YEHJvcio=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7dAF649vNGmvHEYw7AzmaA-1; Sat, 19 Sep 2026 15:24:40 -0400
X-MC-Unique: 7dAF649vNGmvHEYw7AzmaA-1
X-Mimecast-MFC-AGG-ID: 7dAF649vNGmvHEYw7AzmaA_1789845880
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso21207215e9.3
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 12:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845879; x=1790450679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjyUSthyZu35KpQeM9B/0jd7CF9c0bVVky2/qXbbeS4=;
        b=2cTIJXIxK3GB7RLOiFMMahmVCZyKEn80B4lojT9Ocyfj4RcTc3OIuh5kgbE4iWKTdp
         +bc76dASj9JMTNnW69iGsFJtGLp0qxtZq9aX4+0mbVPX1KnrXZWH79Vrmf50A/jVrWps
         F6KCk80k9WtFILjzyVS4xKdoFCaCNwM0/6RXWcl8sNOldQXJIKNCQ2FSb11MRGk2JrUk
         qjuf9DsXQU0Rk0pbh//LVx0ldElIJ9QpH6kxlC2OmyTUxKfrSIw0bU0UkUmTC7kr50K5
         c/hys2iFllmkhydhvB+fnIUilc1EBZCH9+VDAt93tD2fD9uJCk0pME/LtXRnabdIHnv1
         PseA==
X-Forwarded-Encrypted: i=1; AKwUvBxdW8Kco6umq1gYoLx+lAK98sve83FSDoqrh2+a2pnqXmxrej5mnvTJ/FwgvTsnFKlnFbW/zjIwaCmT+QnsiA==@lists.linux.dev
X-Gm-Message-State: AFuF++kmvgI4+182npH//ZABRklFYyoAZGYFk5/pNYjKhpby98bkcBco
	JWCEfPIhsciaWquAxgjPCvJWj+Ne1E+6G6LcJ5upEYkZlP/RiGqMysnJCO+2vj5KM46XipWDuS7
	FGwBwcRgbK+XenQJSoTDPkJYzmME3Vx06sU5Hpxz+OHX0UkzRNhK6VH7sRpaeXiW/cMYQ
X-Gm-Gg: AYBFou2FYN40MU2p6EUlTEYbWaeaaYKIPdTyP6YyrMDDuQSjuNPl7S7g1JsAc2X/zeC
	D+VulgFKffpcxIqU05t5a5SahGv0UkAsTNG/O8n4JvZO3xooeDwnkYhuTEEhgA+euPHG9y22D73
	RfSEaMzgnQQfhMvAaF0oxcf4Zb0eCQNxozbZHpU0WXpYW+eYr46saj7kCY8DZHxzNE56BQQ5lLG
	xrZy4Gb5+Dh/2OrInYG1qsuwVRln2Nnv4e4P6RLNSYPUlZKHLcW0scl3Wmz+zmy0pHy/HwjbkUl
	NOop08i0qtIO3Cug8D8d79bYOvvx9K9jHhmSPMfJrwENuwrB94Dt24LSxL5HGK6Xo6pDI/AkB7G
	mtPGOTsusoLZD7WlRPN3NZGg=
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr78443145e9.23.1789845879495;
        Sat, 19 Sep 2026 12:24:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr78442915e9.23.1789845879068;
        Sat, 19 Sep 2026 12:24:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0874c3sm138399065e9.14.2026.09.19.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:24:38 -0700 (PDT)
Date: Sat, 19 Sep 2026 15:24:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is
 attached
Message-ID: <20260919152336-mutt-send-email-mst@kernel.org>
References: <20260919131744.131030-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260919131744.131030-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VLEGKlCi0ba_zzWqmFUqVgHicCQfmOj1842AyNCavYQ_1789845880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 19, 2026 at 09:17:44PM +0800, Jia Jia wrote:
> vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> completes the command.  If userspace changes the vring addresses while the
> command is in flight, the completion data is copied through the old iovecs
> while vhost_add_used() updates the new used ring.  The guest then no longer
> sees the completion.

I do not get what all this is trying to say. if you break it you get to
keep both pieces. when is this a real problem?

> 
> Reject changes to the vring addresses while a backend is attached to the
> queue.  Keep accepting the current addresses so userspace can update
> VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> that have not been attached retain the existing setup behavior; userspace
> must detach the backend before changing their addresses.
> 
> Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vhost.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..074590838de5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  				a.flags & (0x1 << VHOST_VRING_F_LOG),
>  				a.log_guest_addr))
>  			return -EINVAL;
> +
> +		/*
> +		 * Commands may retain iovecs derived from the current ring
> +		 * addresses.  Keep the addresses unchanged while the backend
> +		 * is attached.
> +		 */
> +		if ((vq->desc || vq->avail || vq->used) &&
> +		    (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
> +		     vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
> +		     vq->used != (void __user *)(unsigned long)a.used_user_addr))
> +			return -EBUSY;
>  	}
>  
>  	vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));


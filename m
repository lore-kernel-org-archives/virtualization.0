Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B8388E6B
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160856; cv=none; b=ZeVaneGrERtOfhYlN5YeGu+HKiIvDRGjnZEliMVIbBjHTApbaG7yAcUrhuAkkxYLCIY4LtcVpHPFKIU5M/7hc97hstXTMgWBQLET1OnSD6xZn63scbAJcsoZhO3WeGbCUtl6mUb33GnEksifvVl5tg7Qmi9/0yu5bH064Tmcvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160856; c=relaxed/simple;
	bh=BzoDKri2AnQ0Gzc0Q9uN7BE4vlA65vCGXfLvgcKu5xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BzIH2LBKH9OnBrDuYtXcfdovc3xhaH+IsPy8OcJFvoKc8awuk/U6gHajnBOWJlYYqFm+frWQmw9Q//Ad2MPOcxZNt+Ws9U9j2/bEaqxqs/82JspKzAM6pR+WjEcVx36fDuLD78J/s75kHjiPiQCW/13viux/R7Z6TFfTzJQPnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDnp94WL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDnp94WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781160851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyfejcTOJzGfkGjW2j6iDmBXVI3fZpPrk4NxQ/CTQBQ=;
	b=XDnp94WLhgiz9zgC07XOiHVsFI1DH+16Rmm6dzhZLrN24/569RXR+gToKSNdYNSY4UBDZE
	sNqUw4TXNLzlESaky9axHz1lWiM4K+nxh+MmzeGzhIl6PfMmomBqSOAMg17KTx30LxecW6
	XCgHEVbh5clQC6Zh5yTODDXJhYVoI8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612--cWITS4KM5GPT4VDt6AQww-1; Thu, 11 Jun 2026 02:54:06 -0400
X-MC-Unique: -cWITS4KM5GPT4VDt6AQww-1
X-Mimecast-MFC-AGG-ID: -cWITS4KM5GPT4VDt6AQww_1781160846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so48270525e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160845; x=1781765645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyfejcTOJzGfkGjW2j6iDmBXVI3fZpPrk4NxQ/CTQBQ=;
        b=O38OtVRKljPpjjBVJ6j6oYbCE6GLYr/qRzVttJuL8f95+5O8VaGFphULbAJkdgr76o
         WLgg70130Gb6j/wubSRUoK516UQHrCPgq5WzcLFaFSTsZZzTwJ2NO/ee6vSlKheWQ4GO
         YM5jfTOFPy1JyBCLG8pb/gI1nqmf96bPC2df0HVss28osjzKKHTSwVW90DLslyRbBl9l
         /OIYGt7GtSuITyN+IWALyZ6G6VQH6LQWPs2+7dZ2NVBrtq5RaasoT/5fl+TOLRPb43Ia
         8qaHJMU1tjCAsGLtV4KuuYPzQ/SDD4Dvd+pc84320WTNRfEC9BO9hYgp9GdPL8d+e9xi
         FlDg==
X-Forwarded-Encrypted: i=1; AFNElJ9DCs1tdG1PmBhUy2vY4E5T3sd4zdh4VQUWyW6U8OJwyfr4R+sgJjV0FgXBZ/bYS3jnTWDLr9hve6WfDveazA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+k96cVFAX357qKY8y4EY4jjb8XTKkvPk7h9b4jDAP7flre5q4
	WjA5O4Vg1XCidjb5kd3x2GTb3a8oIdlWg9Bp/G03R8MdsRxF7Ku8GguyGpesY3xgmX+PLSDxhJa
	50i27DBqgeakM/Spoxut51jiyYlk2RAjWWCmvsi3D6K4EJB/Blk8CJ2Ia+QPCDiMT10zr
X-Gm-Gg: Acq92OFiB+TK4QDztQ5wHAU1/AlHQYwW1QZx9Yzv/D/6/QcDR5uszv17wgVio/S2Un2
	sj9XaNGqPgTEMLmQS1kl2TyqRH8hBrJgis7xkHmp1UmnJELJLWnQIiiHWcyx7LJ5J7FVwHIkmLe
	xOSOgVudrKLqUphqe9UC98LB5wRR1Q+7Kv5NsKT078CJxOIivYCYGpvRPYWeicQFAXpkN3PnZb4
	RzeBIWAa9KqheTRelDLEpyHJooCWQXJi7pQvMtjX0mo4D8C/4EO3bTQoQT9hAfShaYkf+9Tk0F4
	5vBeVFI/A1Kau5Z3j9J0aVcbmZOrLaGF19AcluoIZCFkFy2dpCaEpE1SZe6FNvE+SUZg5Lxc8Lz
	0jLzpUYQKvB2AGqpBdqj00P4hNZixZJUjGbCs4Vb61zhLLdXsK75R0g==
X-Received: by 2002:a05:600c:c04b:10b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-490e561e473mr9784595e9.35.1781160845362;
        Wed, 10 Jun 2026 23:54:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c04b:10b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-490e561e473mr9784225e9.35.1781160844845;
        Wed, 10 Jun 2026 23:54:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm67202077f8f.32.2026.06.10.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:54:04 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:54:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] vduse: Fix error around jumping over a __cleanup()
 variable
Message-ID: <20260611025332-mutt-send-email-mst@kernel.org>
References: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RL0KmxUZLPRli2Sr7YkIMq-2LetDlIsHNBUl-HrNJyc_1781160846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 12:16:49PM -0700, Nathan Chancellor wrote:
> When building with clang, there is an error in vduse_vq_kick() from
> attempting to jump over a variable declared with the cleanup attribute
> using goto:
> 
>   drivers/vdpa/vdpa_user/vduse_dev.c:566:3: error: cannot jump from this goto statement to its label
>     566 |                 goto unlock;
>         |                 ^
>   drivers/vdpa/vdpa_user/vduse_dev.c:568:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
>     568 |         guard(rwsem_read)(&vq->dev->rwsem);
>         |         ^
> 
> Jumping over a variable declared with the cleanup attribute does not
> prevent the cleanup function from running, it would just result in the
> variable being passed uninitialized to the cleanup function .clang
> errors instead of generating the invalid code, unlike GCC.
> 
> The jump is only present to call spin_unlock(), so convert the
> spin_lock() and spin_unlock() calls to an equivalent guard() to avoid
> the jump while leaving runtime behavior unchanged, clearing up the
> warning.
> 
> Fixes: 6c141c034c1b ("vduse: Add suspend")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Eugenio?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index a257fdcb77b7..0500da043761 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -561,9 +561,9 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>  
>  static void vduse_vq_kick(struct vduse_virtqueue *vq)
>  {
> -	spin_lock(&vq->kick_lock);
> +	guard(spinlock)(&vq->kick_lock);
>  	if (!vq->ready)
> -		goto unlock;
> +		return;
>  
>  	guard(rwsem_read)(&vq->dev->rwsem);
>  	if (vq->dev->suspended)
> @@ -573,8 +573,6 @@ static void vduse_vq_kick(struct vduse_virtqueue *vq)
>  		eventfd_signal(vq->kickfd);
>  	else
>  		vq->kicked = true;
> -unlock:
> -	spin_unlock(&vq->kick_lock);
>  }
>  
>  static void vduse_vq_kick_work(struct work_struct *work)
> 
> ---
> base-commit: 6c141c034c1b0b74a2ca4dd3d6fbb6d9054f6e46
> change-id: 20260610-vduse_vq_kick-fix-guard-usage-d1037c331419
> 
> Best regards,
> --  
> Cheers,
> Nathan


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FB1D61AA
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673106; cv=none; b=l2FnWy8U3MdciTsTwpSkkUQPbp5rgddt7k/HYcYGm8ysA8ckE/+XDva1HLG4tS/i+LysLlkmVcWzlnJnlPhDl6DGceBw76COcDiULbaWM0SnH2zmRLWGrZDNNFXpXB75mdDxhII6dGLXotLRQkUMb1gorHQemHxIpBfFGk20iVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673106; c=relaxed/simple;
	bh=+iHvtiP4dVRUwu8zgMFFhXFii73LKNAGPkqOJ4OL0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E9ekJ0yAWaJnJePhIHlQsNAYVctJoHiiBxcIa3dcGk57bSkX0kLucOawewwqjOGd2S/mhH4zruyYAoK1lWFdNHhuQFDl6wXQhpB1Xw8mpR5EiXrFKzs9DdSEfUlupj1szwH0FMMOA/UHGgX0mWT/ukywFGXgv5Kxu5MWEaU6eDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D56+NFU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D56+NFU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
	b=D56+NFU2VZxwh7GnGrvz5rfBvueRc8DMoYhwRgYHkqHzR4rPIu+9fPysGuOfXY3P/IjUFz
	OwcTdzJ10U/P2v2Lajhx8FW/izNsLkw1a4Zx9doNesYvMW/u3+FQ56S8CC/p7Rg5+SS/oX
	VobIkuM4UgMxsT9vLeOAPJec4HC4PG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-hrjs8YY1Okif8iJjwjWjCg-1; Wed, 16 Jul 2025 09:38:20 -0400
X-MC-Unique: hrjs8YY1Okif8iJjwjWjCg-1
X-Mimecast-MFC-AGG-ID: hrjs8YY1Okif8iJjwjWjCg_1752673099
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2594899f8f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673099; x=1753277899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
        b=T43m0oEs6Zgw3tnWvGIb2QUVCn5nteKKOWPBhdrqt9GkHNKLDAN7zWiSJ7u8BGMwP6
         bgDRJPd1dE/UHAQN5luNsbtrlOl6I1MtTridF4G9VVkCOsCGEX7k+lmkIXj/r9ESi7ed
         jfC21d8k2myIlGBhqlKG3LX89e9w3B9DMcXqApBKtvH8gDAhpB2oVCASyfDDAopXyKAJ
         fZrKEiwBwEwMfK5EYZ4bktGFfif9iPKm2AweKDDUgocDhB5JU4XveXsl97fOFDhZWCn/
         bWh3mkQpwAddH1u1idWzXsW1QHLrrm9hxbBFOuIBjFX/6EIECxu0XyOChWy9UAF/VuL4
         nfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVCHXZ9fDqfJjOifeSI76LPhX51eKa6NbvRxCSo+QwmXtoXJue78o3F33U6NdVKOATk6eSMwOAI7+mfPREnDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXND8UNBnmMavQMrj7SypQt2JuDtJpsfeftXKoTvLRpa3/WwW5
	XxEGV+HYCLGekBFg+vTC8h4MucHxeppIQnpVVFWEmAp7dYb8i4i85m/QDcUXKnNGmOHJ+cGotGD
	5RdnsT50iuX9dfb0UNdljhaF2HgotPLrV/0gEyyVpibZpxyeE8TkToXUgnZZXv5JmxmZS
X-Gm-Gg: ASbGnctrsRfpWKjiVya9kmfbNBaYLcCTAOt6da/JD+ND7Ma6rp3E6O3gQSOKYYNVtfd
	Vp0FuZGuoOAdJLcYCxn74uILSAwlhvM5m2rsCbaSYsaAzDA7ZzaCQz5MLwi9ZIVi3wUYFQbkanj
	KnA8PcljTwjujMScwpM3pHc2tr8eAT34CHIB45xcQEC78B1ZSA+7Yx1SEOGUD8d6nTUf6y7z05l
	Z6tOa9EkVcn1cwsUYvUO023b8YGYz48RpTSbfs9QXXpHlpFaoU0rbRRWU6cGwmBnf+P+fCqquVZ
	GS8/Du/tuE70XX3FFJjMAd+O/bJxTGU8
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892565f8f.16.1752673098836;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHONniWygBXciPr26x3pHj0nvSDyjvuSRdQI8CkI7uj3vzxwTl+/0L6TJlAmz7DGZ27LNtzhw==
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892536f8f.16.1752673098367;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm21517885e9.10.2025.07.16.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:38:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: Fix typos in comments and clarity on alignof usage
Message-ID: <20250716093552-mutt-send-email-mst@kernel.org>
References: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i9hd5BErKJVXrOJuwyT_9u3fThG3VgfE17YhcqfVQe0_1752673099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 15, 2025 at 10:39:11AM -0700, Alok Tiwari wrote:
> This patch fixes multiple typos and improves comment clarity across
> vhost.c.
> - Correct spelling errors: "thead" -> "thread", "RUNNUNG" -> "RUNNING"
>   and "available".
> - Improve comment by replacing informal comment ("Supersize me!")
>   with a clear description.
> - Use __alignof__ correctly on dereferenced pointer types for better
>   readability and alignment with kernel documentation.
> 
> These changes enhance code readability and maintainability.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks, I applied parts of it.

> ---
>  drivers/vhost/vhost.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..0227c123c0e0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -594,10 +594,10 @@ static void vhost_attach_mm(struct vhost_dev *dev)
>  	if (dev->use_worker) {
>  		dev->mm = get_task_mm(current);
>  	} else {
> -		/* vDPA device does not use worker thead, so there's
> -		 * no need to hold the address space for mm. This help
> +		/* vDPA device does not use worker thread, so there's
> +		 * no need to hold the address space for mm. This helps
>  		 * to avoid deadlock in the case of mmap() which may
> -		 * held the refcnt of the file and depends on release
> +		 * hold the refcnt of the file and depends on release
>  		 * method to remove vma.
>  		 */
>  		dev->mm = current->mm;
> @@ -731,7 +731,7 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
>  	 * We don't want to call synchronize_rcu for every vq during setup
>  	 * because it will slow down VM startup. If we haven't done
>  	 * VHOST_SET_VRING_KICK and not done the driver specific
> -	 * SET_ENDPOINT/RUNNUNG then we can skip the sync since there will
> +	 * SET_ENDPOINT/RUNNING then we can skip the sync since there will
>  	 * not be any works queued for scsi and net.
>  	 */
>  	mutex_lock(&vq->mutex);
> @@ -1898,8 +1898,8 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  		return -EFAULT;
>  
>  	/* Make sure it's safe to cast pointers to vring types. */
> -	BUILD_BUG_ON(__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE);
> -	BUILD_BUG_ON(__alignof__ *vq->used > VRING_USED_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->avail) > VRING_AVAIL_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->used) > VRING_USED_ALIGN_SIZE);
>  	if ((a.avail_user_addr & (VRING_AVAIL_ALIGN_SIZE - 1)) ||
>  	    (a.used_user_addr & (VRING_USED_ALIGN_SIZE - 1)) ||
>  	    (a.log_guest_addr & (VRING_USED_ALIGN_SIZE - 1)))
> @@ -2840,7 +2840,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(vhost_signal);
>  
> -/* And here's the combo meal deal.  Supersize me! */
> +/* Add to used ring and signal guest. */
>  void vhost_add_used_and_signal(struct vhost_dev *dev,
>  			       struct vhost_virtqueue *vq,
>  			       unsigned int head, int len)
> @@ -2860,7 +2860,7 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  
> -/* return true if we're sure that avaiable ring is empty */
> +/* return true if we're sure that available ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
>  	int r;
> -- 
> 2.47.1


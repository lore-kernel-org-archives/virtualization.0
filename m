Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1392433E9E
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102115; cv=none; b=bHwXlUsEw2qwmLZTZHQw3ThplCbSAvRrqqF3xWIPu1kgiI3T/mVHOy2Hh4qgu7N4PqVGYciZOOy7BkLVPT0abxwb4iGvTmrEly4Ld2pxurnSW8p3cuElX8q8Xtd4tJdrZNcZcflkbzcr00raVUlWpOa5jqhu0yYlfdMke2liDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102115; c=relaxed/simple;
	bh=dHHZ3K8y10/env+CSCM+isXdc2ntqu+4Ms7TXC53OGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XAo5LKFcC7Ih67sK2jRix6UuDX55hkqfsVZAgQugKhLQr1PUVEmKZUQa7Mgvw+8JzhXwbaPnzIFCv/G3icLHAK+z6xikwOI13HuPoyYLt+iF0u4kcFYyba1lzUO0ou8Jo/aRoh3m0iAmyJyanH434yXqDacAIvyru2E36+p0y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrX5vrFP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrX5vrFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790102112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I3Aqw9/+f4eSPjaI78DYRAV/Pprlcx0/eYJ061KVMvw=;
	b=WrX5vrFPrcfGz7je4bYnJLCFQ2d1vxu2lB/jM/KJA+2ggPxPFtmjJTuFvXGUw/rspLLR4v
	H+iliE8cpdFjvyhXymUHOUCvTp9YJraN/a3npy3LNZ+5X+yUNjoMGvQ/cYkG8UA7ARE2FP
	146z2X6shjGTF6RdOWbO4PX0Sc8aONk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Rd_A82cdN5KqXquqX_kQUQ-1; Tue, 22 Sep 2026 14:35:11 -0400
X-MC-Unique: Rd_A82cdN5KqXquqX_kQUQ-1
X-Mimecast-MFC-AGG-ID: Rd_A82cdN5KqXquqX_kQUQ_1790102110
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6862e924so501925e9.0
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 11:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102110; x=1790706910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3Aqw9/+f4eSPjaI78DYRAV/Pprlcx0/eYJ061KVMvw=;
        b=Yqwe3DrDUdu78Fks17YBLlMM//4rMSZtlHIJOCy7jwVEd4cSLEj1XmL0FWvbpIi+Ug
         0l5pqmx4314Ulhk9dwOYRxTs/YteW7zN3HKgtvlOlraIGp75mRjTANqsfT9SmYTzNBuA
         jUc3ZsS35IlzGCQuSaryQOqA+jh4grXhXZcTtvFefawHwxO8iwUGFtNTcMdO3Tgx2OHX
         OI4ki55RKL68y5zmYoqWZWVxyySFksaIVnyGc2bJnlT8EY3jUPYD2hrC2uuXQQgQoBkO
         L+AYJ3eRrfebK0+AR5NkCqIaXEEeVUuY1bEx+7ywDsQ965h3S8sH5N5kN14YsLWM3aVV
         pXIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8kKAP67Uqgr9ATbJjkcR9Ii/Deb2s2hKLLqb3Q4f9CIxKXRym7o9fhQvVRMOgWLcklza/RL9QkSiPW7o+jw==@lists.linux.dev
X-Gm-Message-State: AFuF++lRkmis5+MBq9zhmaqRZfjUUIvJGW/KFBnmzP+RhSKut5DgcpTE
	cxe7eWCgmvZ1GA+57KbyWIhPspYSGGsmkQTpERvy8jUpdGG7BYzEibHHBM6O0Ga32MXW1WP2ss0
	wo9aH5Gp5T/+qjHNiPZyLiycCFTaQN4StU6QOxBKsOIHCXXyGuZrBfBYUcd5IFCCdrr8i
X-Gm-Gg: AYBFou3x+652Jr+VqmeesyCeaXsGP+f5L/izgHonwNu+4PflZbNSQwxQS5I/LScXQbU
	7X4TPKoZSunNXgw4XRAqDtu1ZgChi2uBxeV9hng+BoGdkXC0TPpSk545kLe56eH/BQBq6Fki5BO
	ylqaQ65kPm1+eatrZB51BhLvezy1sk3P/co69I82TLhzQgHMG6VdHg+p5nb88OWzt/6M6U4LGy7
	D5vCyszhMeyEYBOwnUwHyG/k972HjzSvhI9T0XeZIwComcZag0ad2rIa8MWbSrvy4Nkow5YyU7z
	WMt+oF+fquq6fi3Mt3A/Trzax2eLpPsfHgpvTN6b40iinQZ6k/yL03zQXhPXndEJDCpDfQ==
X-Received: by 2002:a05:600c:8b30:b0:49f:ce73:7aa with SMTP id 5b1f17b1804b1-49fdf34b3b1mr1051795e9.35.1790102110132;
        Tue, 22 Sep 2026 11:35:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b30:b0:49f:ce73:7aa with SMTP id 5b1f17b1804b1-49fdf34b3b1mr1051515e9.35.1790102109563;
        Tue, 22 Sep 2026 11:35:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877c379sm286912f8f.29.2026.09.22.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:35:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:35:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Siddharth Karanam <sid9.karanam@gmail.com>
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: update multi-line comments to the preferred style
Message-ID: <20260922143419-mutt-send-email-mst@kernel.org>
References: <20260922171636.201408-1-sid9.karanam@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260922171636.201408-1-sid9.karanam@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9wxidy1phMxtvP8qbEyRCTTuU9oK_uhxma5UWQXkHOc_1790102110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 10:46:36PM +0530, Siddharth Karanam wrote:
> Some multi-line comments were not in the kernel coding style.
> 
> Signed-off-by: Siddharth Karanam <sid9.karanam@gmail.com>

not really interested, sorry. whoever is editing this code
can change the surrounding comments, this kind of thing is
just pain for backports for no gain.

> ---
>  drivers/virtio/virtio.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b6c9e927bef5..c6dffced864a 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -51,8 +51,10 @@ static ssize_t features_show(struct device *_d,
>  	unsigned int i;
>  	ssize_t len = 0;
>  
> -	/* We actually represent this as a bitstring, as it could be
> -	 * arbitrary length in future. */
> +	/*
> +	 * We actually represent this as a bitstring, as it could be
> +	 * arbitrary length in future.
> +	 */
>  	for (i = 0; i < VIRTIO_FEATURES_BITS; i++)
>  		len += sysfs_emit_at(buf, len, "%c",
>  			       __virtio_test_bit(dev, i) ? '1' : '0');
> @@ -80,8 +82,10 @@ static inline int virtio_id_match(const struct virtio_device *dev,
>  	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor == dev->id.vendor;
>  }
>  
> -/* This looks through all the IDs a driver claims to support.  If any of them
> - * match, we return 1 and the kernel will call virtio_dev_probe(). */
> +/*
> + * This looks through all the IDs a driver claims to support.
> + * If any of them match, we return 1 and the kernel will call virtio_dev_probe().
> + */
>  static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
>  {
>  	unsigned int i;
> @@ -565,8 +569,12 @@ int register_virtio_device(struct virtio_device *dev)
>  	INIT_LIST_HEAD(&dev->vqs);
>  	spin_lock_init(&dev->vqs_list_lock);
>  
> -	/* We always start by resetting the device, in case a previous
> -	 * driver messed it up.  This also tests that code path a little. */
> +	/*
> +	 * We always start by resetting the device, in case a previous
> +	 * driver messed it up.
> +	 *
> +	 * This also tests that code path a little.
> +	 */
>  	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
> @@ -615,15 +623,19 @@ static int virtio_device_restore_priv(struct virtio_device *dev, bool restore)
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	int ret;
>  
> -	/* We always start by resetting the device, in case a previous
> -	 * driver messed it up. */
> +	/*
> +	 * We always start by resetting the device, in case a previous
> +	 * driver messed it up.
> +	 */
>  	virtio_reset_device(dev);
>  
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  
> -	/* Maybe driver failed before freeze.
> -	 * Restore the failed status, for debugging. */
> +	/*
> +	 * Maybe driver failed before freeze.
> +	 * Restore the failed status, for debugging.
> +	 */
>  	if (dev->failed)
>  		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  
> -- 
> 2.55.0


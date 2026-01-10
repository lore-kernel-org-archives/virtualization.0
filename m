Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3A290DBB
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768089405; cv=none; b=sfyKJf3RDP9vbku4Qv8j8xutcI+xH9+bMS6lugCWOmhroyg4XSjkx7pqc6YSavJG+WFQHQ7mG0pHPiMJdKHvHeCPgEkn8iargFteR10O5gUs1dPlSfAgrvr9vyTLDmBnBXDlFX7qwXlvtw3gyy8cuXtE6mewcut8ozw1+6SP1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768089405; c=relaxed/simple;
	bh=oSZpmpbHEb6tzCzxTenTJdf3AIJElepN6l9aT3H1t7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y6hmU6J4Kx3oRhU/AeqGYzXQUAKea9sWj74u2OLdWeYTTBkE/Vtk/Nyj1xZhTJWDYlNYN/vOaFEo30Mo6rDW5fa/+iJaGtY6NASY00+0XFQg3xXFNV79IqrUTbY4Wgo6GPK7lS4GFtvGtFCEVzHwvX+MjIgZYxDPVHfV5SI+/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bI8ognUj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI8ognUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768089403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyBJOHNVWh1pMbWNvjS6UNm7LqY3XuqgU+QcDkd7SHc=;
	b=bI8ognUjJtueWXACCu1cB5ezooe8nIXpFpN/4063b1eWrS+oP5Axbr0jVXAYFTs8RZ7/S0
	bgEh7vYfl/gh53uUITnbZDD/n+AvX30r6BkSHvvrH+KhJtatVO8aeMkIa+LaT+OphTXrHy
	pmTlJD4Jqg9LI3vbsgO2vPbO0DARwQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Xxh8hcNdMi-OzZo3syxSCw-1; Sat, 10 Jan 2026 18:56:40 -0500
X-MC-Unique: Xxh8hcNdMi-OzZo3syxSCw-1
X-Mimecast-MFC-AGG-ID: Xxh8hcNdMi-OzZo3syxSCw_1768089399
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563e531cso38207655e9.1
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768089399; x=1768694199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyBJOHNVWh1pMbWNvjS6UNm7LqY3XuqgU+QcDkd7SHc=;
        b=GzsAAUrTfiJDnhu31QUUzDQ8DjTwioCdLNs0ef5X7c+Obnmh6PHA0Cg9VNBrM5PjHC
         rDooZZx88dsoKOb0oiY3ST4QBfzlkn+ZZ11Bh3x8ERZHRcTAN3nGtRDvTAsYhktYJqak
         f0yNVDJUjl9/g387f5IuFC8ge06tfHnpGjikoBWRb4IIftjpi0JwLO/XR3JjhvMz0TSz
         +JYlccbRW7DJhRoZyrXFf9+99MtCscI3hCvXyh0XbZ8M9JX99cx9mYfJeGdaqFwH6dNK
         qyUH/WB/xpOL8XeF5iF0iaXgxPP5WsMq5cAAAc3nbkdZcftXsvhHgSc+CjA50daYY9Id
         Uztg==
X-Forwarded-Encrypted: i=1; AJvYcCXkcjn5nVTN2XHQMybpBfvh8WcGgSrcXXWau9F6AD2ZNVFsNdpYGGPhgnFs9pbXHFSHIQvUzPx9ZW+msWaRUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylhNF5zOeW2Bioy3FNWS/tD9jgG20Z9bJN7j9431cI82vW8bpV
	TJ8MDsgPXoDcRJU6BOd4T/2JjF8bKaOgs4Jfzoov9r/qFlnANLTzR7pRrDCxHVUN/nE5t1F+0nr
	8mayrg80XZHCcJBHWU665FwZGW+/8UosIfvzxdRnvL/sgoJkIKzaxJTEdeeeLi0w0fWbg
X-Gm-Gg: AY/fxX6Vdzgc1LrUl9bmBMP4cgq5S2bSHVrME2lc7GW8fGL6WfcCY+0E/xpVnQrRJxt
	t5H3YNuupNLIU0HaDXS3L+KGxbKUPGYIDbZpFqB8uCvwD60Yc95TS0u1HrVYkvY/w4Y6X5KuD1t
	M/ozmXrlFfYTwQq3KMU/bgJ5LIeobOWxEsFukc5Ijp38o/M8WylJZx1CWQdAUxYjPK2URWtgXPY
	7IpjvAwv1zcNRbW912vrvl/9X3vBdptI18oIff73CvH+J3TA1dZ7WLdY3i2oEUcC1mqxPQABJT6
	SKiDiIGpJax1gucF5W45nMVcxzscA9yYtd3aFStQn4STf2BRgAp5U77YDZPo/2O0VyvlO3z/Fns
	449iBJppCUCL5Bh6EXSxLNfmxorKMG4U=
X-Received: by 2002:a05:600c:1392:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47d84b32ef1mr163447095e9.24.1768089398681;
        Sat, 10 Jan 2026 15:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJUPkLdK+1YXRbQP66VSK+zjr+TmjpHH6UHm5SjncMz/aKt2PLPw4C93qJew8xNlAE1tUjUQ==
X-Received: by 2002:a05:600c:1392:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47d84b32ef1mr163447015e9.24.1768089398224;
        Sat, 10 Jan 2026 15:56:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm96167405e9.1.2026.01.10.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:56:37 -0800 (PST)
Date: Sat, 10 Jan 2026 18:56:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 10/12] vduse: merge tree search logic of IOTLB_GET_FD
 and IOTLB_GET_INFO ioctls
Message-ID: <20260110185423-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-11-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-11-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UmG4R39_Ebludy2PInJ3lldr7qo7Y7EYcHr7XHmlGGw_1768089399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:28PM +0100, Eugenio Pérez wrote:
> The next patch adds new ioctl with the ASID member per entry.  Abstract
> these two so it can be build on top easily.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v11: New in v11
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 101 ++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 675da1465e0e..bf437816fd7d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1247,6 +1247,50 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
>  	vq->irq_effective_cpu = curr_cpu;
>  }
>  
> +static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
> +				 struct vduse_iotlb_entry *entry,
> +				 struct file **f, uint64_t *capability)
> +{
> +	int r = -EINVAL;
> +	struct vhost_iotlb_map *map;
> +	const struct vdpa_map_file *map_file;
> +
> +	if (entry->start > entry->last)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->domain_lock);
> +	if (!dev->domain)
> +		goto out;
> +
> +	spin_lock(&dev->domain->iotlb_lock);
> +	map = vhost_iotlb_itree_first(dev->domain->iotlb, entry->start,
> +				      entry->last);
> +	if (map) {
> +		if (f) {
> +			map_file = (struct vdpa_map_file *)map->opaque;

map_file assigned value when f != NULL here ...

> +			*f = get_file(map_file->file);
> +		}
> +		entry->offset = map_file->offset;

but dereferenced unconditionally here.

> +		entry->start = map->start;
> +		entry->last = map->last;
> +		entry->perm = map->perm;
> +		if (capability) {
> +			*capability = 0;
> +
> +			if (dev->domain->bounce_map && map->start == 0 &&
> +			    map->last == dev->domain->bounce_size - 1)
> +				*capability |= VDUSE_IOVA_CAP_UMEM;
> +		}
> +
> +		r = 0;
> +	}
> +	spin_unlock(&dev->domain->iotlb_lock);
> +
> +out:
> +	mutex_unlock(&dev->domain_lock);
> +	return r;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {


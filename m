Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C23277017
	for <virtualization@lists.linux.dev>; Fri,  8 Aug 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652383; cv=none; b=pfLfrgIcXdeqTurM6mSpnUj7w5hOyRTyHkwzldNS1DxN5muB6DaGAajzmH6WaC5auCRnQrmEB+dUjMN/z+f1UJ6lj69pgzKtq6mdKUH/AhDt04/WfDwZIL+weGJmhdCW0t9yL2I/3IRcDpGXGP0w5RE0AUCTFhvaES05MUgPYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652383; c=relaxed/simple;
	bh=k0A8SEwr9YEM82RQSEfv6eQV60PVVOgkI3XkiazoVq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q2s3i6TABgRSZyw8M9+x9cBoiFeUFqeKg1JnsZouzWrdqkTdoJEAhkGGRKZpo9fboxQ4B2CL8YITkDZoMnv+aMpSNChip27PBeFa1OPtLsmfWcy//R9Y8ePQr8zvMdx/AYc/oG4ywzjmJXQOVhmLWkCcN9uC6JHnMdV3u+27IJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqNhfXng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqNhfXng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754652377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ07bfQKJ55z5/ZFRW4FDXltPPcwKKigW3feHNbRLXM=;
	b=WqNhfXngNiHz1VWN312lRS6OlZXoy9bThkR/Uo5orld26HzOibJmBbyL4hdrDpuiA5/rBv
	4ISmvaCkoisdOPMDNJrCC878fkG7/Z6VcKXUp7fgPaf0QAbLkE6sINEoxdN/LEeSZTeE5c
	CKirEod3PdjlFIZejieQr8uUVeNCBWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Ltl-b7oRMsCTFKaWzxutdA-1; Fri, 08 Aug 2025 07:26:14 -0400
X-MC-Unique: Ltl-b7oRMsCTFKaWzxutdA-1
X-Mimecast-MFC-AGG-ID: Ltl-b7oRMsCTFKaWzxutdA_1754652373
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458f710f364so13926585e9.0
        for <virtualization@lists.linux.dev>; Fri, 08 Aug 2025 04:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652373; x=1755257173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ07bfQKJ55z5/ZFRW4FDXltPPcwKKigW3feHNbRLXM=;
        b=HZ3F1WT6Pjoaa6G3xkDWjsLp7wVEJZ97nWsFPEZDyg4vnNbLj91eNSg0+UOrOZ0Ach
         GgVUfjJND+ohkjPCP1BYf6A7ETwcqvyw/zYn56DLuoQX9jSZfXsKGPNl3JFAzHwnam7X
         6rcTQo8cRLIDBISOG/J7VjluJ7gj/zhhZfLfVeQ4PQn1lmQMbAxNRA05T9Z50mrW/Z/m
         +ywk4NVfv1ykfP84xJDcX8CDlfZ9X77EIO2T2C055kRmRB/P1iyjJPvN524XkrflUy0l
         5V1WviOpqp8HxSu8EztJo6ziT5HDiadW4CObBoXPiy0IiTx3iQCq0ZLGv1xlJkfoqoQt
         0zjg==
X-Forwarded-Encrypted: i=1; AJvYcCUCVrEGGrsIHFe7i7sfHI4XR2ajWQ6nNWS3drjVEvgaCRalkBH0OEyrU/A0u803HuMtfRe+QzytzM3S6OFXcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yws0qGwSITrgBsmf5+8AjN0Ku8BUbmPWLyZx22VF+rIHegQhz+P
	ES6hJMChIYi4QJIbcbKPT+bqqIpb6FVtJ1FZaTEgi4uo1O4k6pYPaIkk5GJay6BwZ9jmwI8FYJR
	ZP1OpgPTmjppEx6Be0iWlbcyuT4ZzFgREK1TEoQKSBtnGbUQPgBnnUke+6sorFnTqiFNF
X-Gm-Gg: ASbGncvXT3k8V2AXoyoOYJHn8sPZe2g2zObPMf84B3eVqfwydV8x1IXV9YuglWgvFm5
	8Vhk5lVrKkeDSK67ayRwOSYZ8b/6DUJNke058/arTv7d5CGFl/6hx/h62prtfmumt0BlXnGdWP9
	gQi6O2h7CfzQPLdB3pC1yeHDkJhYmfqIzo/myRDdCv9xZkCRZcpUYIg5ZUBsIPpwLISRH+Rvxxg
	ieT9Vk1n7fdX0Fn5jatXrmhUUWPSuYr5OX2Uc2+bH+ywSDlS0o/X8Fn2HcW7zrrbDI/GMmJ/hc4
	OWmiGdWuf6z/XojYbhJn+HLiCUT++s1L
X-Received: by 2002:a05:6000:26c8:b0:3a5:8d08:6239 with SMTP id ffacd0b85a97d-3b900b4d3d3mr2056916f8f.21.1754652372841;
        Fri, 08 Aug 2025 04:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA9/k3yhh1VIv9RCtmLiti9qOFoG49fzaTwYSvxJDxAb5Rj0fU3D0pOzBQfzEMDyq3eal5Og==
X-Received: by 2002:a05:6000:26c8:b0:3a5:8d08:6239 with SMTP id ffacd0b85a97d-3b900b4d3d3mr2056896f8f.21.1754652372421;
        Fri, 08 Aug 2025 04:26:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm158780705e9.1.2025.08.08.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:26:11 -0700 (PDT)
Date: Fri, 8 Aug 2025 07:26:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: sami.md.ko@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	dmitry.osipenko@collabora.com
Subject: Re: [PATCH v2] Revert "virtio: reject shm region if length is zero"
Message-ID: <20250808072533-mutt-send-email-mst@kernel.org>
References: <20250807130326.82662-4-igor.torrente@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250807130326.82662-4-igor.torrente@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dRvbtnOy8xj7ohS8U98QU-tTCnN8ZpTpvjAA8Hma9Ug_1754652373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2025 at 10:03:29AM -0300, Igor Torrente wrote:
> The commit 206cc44588f7 ("virtio: reject shm region if length is zero")
> breaks the Virtio-gpu `host_visible` feature.
> 
> Right now in the Virtio-gpu code, `host_visible_region.len` is zero because
> the struct comes directly from the `kzalloc` allocation. And Virtio-gpu
> is using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read
> the `addr` and `len` from Qemu/Crosvm.
> 
> ```
> drivers/gpu/drm/virtio/virtgpu_kms.c
> 132 vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
> [...]
> 177 if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
> 178                           VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> ```
> Now it always fails.
> 
> As the Virtio-gpu relies on the previous behavior, this patch reverts
> the offending commit.
> 
> Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible")
> 
> This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.
> 
> Signed-off-by: Igor Torrente <igor.torrente@collabora.com>


Fixes has to be adjacent to Signed-off-by.
But anyway, I already included v1 in my tree, pls check it out
and tell me if more fixes are needed.

> ---
> v2: Improve the commit message (Michael S. Tsirkin)
> 
>  include/linux/virtio_config.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b3e1d30c765b..169c7d367fac 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,8 +329,6 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>  			   struct virtio_shm_region *region, u8 id)
>  {
> -	if (!region->len)
> -		return false;
>  	if (!vdev->config->get_shm_region)
>  		return false;
>  	return vdev->config->get_shm_region(vdev, region, id);
> -- 
> 2.49.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A4305056
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178380; cv=none; b=pRCn7rjf9THHuPW/KSWSFDqEB0ITYgMoxlCudoEyx/wOVLXW8SVzjlhnCiQWepzQpk6KNMlTFGdpMzojnMYnvIsqfIgEo5QyBRSRJMtUFmVoaZCpSuWkjQcrxA4ZZLFgrjgMgoO39h5O0VaaHKoT3KF+zI0c0PiEkm4WMG/0gx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178380; c=relaxed/simple;
	bh=OXyZ9JYBNGHxLdfTkXhQDxzS13sXQv5trq+Gy8pkZes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTTPnUf8fEoa90nWKfxpT6mgqMhjo8CvGBstjJLi61ev17q5v96P03r55z/ykMD3+8DXG29kMswozq5T0iJJTHfWON4n0Dl4DnK3cd0IDzsFfgVuJUC7aLjUnsYMVGwRcts80J5UiwiR4v7TTNZUDpLCJzFPuOiBhu4QK8aRk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6cqXF+6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6cqXF+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762178376;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsxzOKYHqHXC5PUWfDfFaZwNataXiFJtKNUMBtRzjIc=;
	b=U6cqXF+6HKhunm2FMSTp2mDA3hlqIUEQ1syFEvYDENuVb4gJQ4ZfLKjlId6m2ZZK8qC2ik
	pBkdBufoZL1F+1pI4byUkCbxq+maIf7SEROxIA1QoKEMuYatTr3ikxSeDVW9wyk+0aSSFT
	/hxXsSCinEMcwFkxC9nsJxzoen9mdQ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-SGNpXY49MGaDJ2TSCldoZA-1; Mon, 03 Nov 2025 08:59:34 -0500
X-MC-Unique: SGNpXY49MGaDJ2TSCldoZA-1
X-Mimecast-MFC-AGG-ID: SGNpXY49MGaDJ2TSCldoZA_1762178373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso31684375e9.2
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 05:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762178373; x=1762783173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsxzOKYHqHXC5PUWfDfFaZwNataXiFJtKNUMBtRzjIc=;
        b=GrnVfdqmF5aggC6y4gNPlh/nQa1Wr+wDr3jGHqoa5StbN5MnDgmmwAtFUvYht8nDvm
         0HwgwVS45WzCP+M0BMlSMbL6c+0kQVk1yjVyZLbAeo7IqNmuWTrZ1yIHwZ7FjOt+AuU3
         j6NA/fvEpe/H6uNKAGJE91z5pyA15LybFYbCy8BmwfCIhvFJjdF0WaeDfLI7hORnhfYy
         UWay/JAN9VuiqctNxLWxdnSg/e6iXt/l3+hSZAHZd4rwtkGOP6tXyifn9EG1pxZ6YmIr
         az33u2JexcYXnnhyldjkSqMFhPsw3XQgP8dIz/yinHT3V4/C7WaSpJ5/6UJDySCst8sd
         T57g==
X-Forwarded-Encrypted: i=1; AJvYcCXrOd2fY61yWZftASg5JRpmkw0f6uTySZVoNN/5BW4LeWYs+VZ/nJmOL4YkNEcqsvKkDzq11YUMs0GxVwsUUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxltMedCwNeE/CkrskPtqmIDVPrl3mPAy/EvZp5lUHd8ICngEtU
	3Nyud4QTePmqOJVK4cg9RGScFyleGhV5/CoP8S0RqChkd59xXLuiHjME5uOrUNZCKmvlCpIZdbL
	ZVAyZlzOUMAQTtpxa5yuelfaqQ4o719kK/0C20q3BoShrP2Uadn82/4lWxr5JB3WgBIbr
X-Gm-Gg: ASbGnctD1nbXA55q98WuVC5vBIwQLmhc12CZHD7L0qOWuFKy+K5knna1qA5V5gzke8G
	lAWh4Q90ZY3a28hJOhV9SU0uh+PiFH0w+o/cuiB7lIhII4Pkt8zJj7CdPBkCxbsbldFUaOV/pK6
	HAgHkVGMRCdC9+TqPDXuHew1KZBQjat9UKuytYY4FFqnY6aQcIk3FGidq0fvkrq6G0h7PlKwDaR
	XXakZRpmndRn34ImR47KtiLW0iQR+CSgMsZLYwqTFBkI6OEwnS0Su7JPlt0wtxctscuLqnzs84D
	s30HasE7e1n52uwfkMZ+ltVL99dyl2WJh1zFC9pzomrcNWUSxYDbwdnBc2sPuIBynFJKdHbc55X
	IhLFxwq2pjF29WZkyhLLWzUBrk9+LMIGKuYnyVz6NnntM4Q==
X-Received: by 2002:a05:600c:3b15:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4773089cd1amr118452165e9.33.1762178373394;
        Mon, 03 Nov 2025 05:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKpOeJ3OCF2vnsxcvEkg/1eMNuJuaakX/5JjRbkHK8VRtwHXD8pikxeGoOHXlvFPGq9VVSPQ==
X-Received: by 2002:a05:600c:3b15:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4773089cd1amr118451615e9.33.1762178372957;
        Mon, 03 Nov 2025 05:59:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e6771sm156241435e9.2.2025.11.03.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:59:32 -0800 (PST)
Message-ID: <0815321f-00d5-402c-b84d-99bc862b4575@redhat.com>
Date: Mon, 3 Nov 2025 14:59:29 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 09/22] vfio/platform: Provide a get_region_info op
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, David Airlie
 <airlied@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brett Creeley <brett.creeley@amd.com>, dri-devel@lists.freedesktop.org,
 Eric Farman <farman@linux.ibm.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
 Longfang Liu <liulongfang@huawei.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Pranjal Shrivastava <praan@google.com>,
 qat-linux@intel.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Mostafa Saleh <smostafa@google.com>, Sven Schnelle <svens@linux.ibm.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Cc: patches@lists.linux.dev
References: <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WlWL9g6V2MrDWbV4a-ke5foioHiVEBBSRCvKNNgKfCk_1762178373
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 10/24/25 1:09 AM, Jason Gunthorpe wrote:
> Move it out of vfio_platform_ioctl() and re-indent it. Add it to all
> platform drivers.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  1 +
>  drivers/vfio/platform/vfio_platform.c         |  1 +
>  drivers/vfio/platform/vfio_platform_common.c  | 50 +++++++++++--------
>  drivers/vfio/platform/vfio_platform_private.h |  2 +
>  4 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index 9f5c527baa8a36..d600deaf23b6d7 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -115,6 +115,7 @@ static const struct vfio_device_ops vfio_amba_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> +	.get_region_info = vfio_platform_ioctl_get_region_info,
Any rationale behind why using _ioctl naming in some drivers and not in
some others?

>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index 512533501eb7f3..0e85c914b65105 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -101,6 +101,7 @@ static const struct vfio_device_ops vfio_platform_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> +	.get_region_info = vfio_platform_ioctl_get_region_info,
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 3bf1043cd7957c..3ebd50fb78fbb7 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -272,6 +272,34 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_open_device);
>  
> +int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> +					struct vfio_region_info __user *arg)
> +{
> +	struct vfio_platform_device *vdev =
> +		container_of(core_vdev, struct vfio_platform_device, vdev);
> +	struct vfio_region_info info;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct vfio_region_info, offset);
> +
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (info.index >= vdev->num_regions)
> +		return -EINVAL;
> +
> +	/* map offset to the physical address  */
> +	info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> +	info.size = vdev->regions[info.index].size;
> +	info.flags = vdev->regions[info.index].flags;
> +
> +	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_platform_ioctl_get_region_info);
> +
>  long vfio_platform_ioctl(struct vfio_device *core_vdev,
>  			 unsigned int cmd, unsigned long arg)
>  {
> @@ -300,28 +328,6 @@ long vfio_platform_ioctl(struct vfio_device *core_vdev,
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
>  
> -	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> -		struct vfio_region_info info;
> -
> -		minsz = offsetofend(struct vfio_region_info, offset);
> -
> -		if (copy_from_user(&info, (void __user *)arg, minsz))
> -			return -EFAULT;
> -
> -		if (info.argsz < minsz)
> -			return -EINVAL;
> -
> -		if (info.index >= vdev->num_regions)
> -			return -EINVAL;
> -
> -		/* map offset to the physical address  */
> -		info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> -		info.size = vdev->regions[info.index].size;
> -		info.flags = vdev->regions[info.index].flags;
> -
> -		return copy_to_user((void __user *)arg, &info, minsz) ?
> -			-EFAULT : 0;
> -
>  	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
>  		struct vfio_irq_info info;
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 8d8fab51684909..a6008320e77bae 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -85,6 +85,8 @@ int vfio_platform_open_device(struct vfio_device *core_vdev);
>  void vfio_platform_close_device(struct vfio_device *core_vdev);
>  long vfio_platform_ioctl(struct vfio_device *core_vdev,
>  			 unsigned int cmd, unsigned long arg);
> +int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> +					struct vfio_region_info __user *arg);
>  ssize_t vfio_platform_read(struct vfio_device *core_vdev,
>  			   char __user *buf, size_t count,
>  			   loff_t *ppos);
Besides Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


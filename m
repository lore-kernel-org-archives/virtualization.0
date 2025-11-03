Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134F30AD07
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179661; cv=none; b=WeB89LAjQa6NOpE0KCR+yaAeY9jkJKnFkDFG9ZWs7ssgx0Q3MIL4Z2DfpeiKn0UppjAnCopYMI7e+2DPA3IgkYOtbMnLzVg2v0a0VxWJsJFwi+wDIfGPKx+mnVpsucFwct2roq3ik0PHC95Y55XAjocJd6cixaYZS/Tjj0MXKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179661; c=relaxed/simple;
	bh=1YE4N+9ygu7tvW7gCAtObLJcxrBRRt5nxWG3Dk/wnq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLY1xVuoXW5Vvjeo4qbe96hkWlnR+lTWdeIcAsNI1vlY3JlHwjsbU1m4YxHpju5AHsCbf2whI4wQGPmoaevcZbvTRygxX6arm45VtRONBwy5nI0WiuHB23VlFgTS1DnMQK16SrT61+OoHfWNBo6CJO5/LbHTGbDc6PuSaAj2GTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDcSarTK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDcSarTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762179658;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7uJpM+IX3iswe8DPfd0iPbF2mfDVsJfMczQqxcPMxc=;
	b=RDcSarTKLRgEH/rUCWYOFdKYYfxJxAlC7QrLa82uUSjMmMuVGfGKZkjU5HBjV9xA6N1Acn
	UZN+dZXQHu/E5Ehtcc83y8T4uUICBodpbM/mzHDt60O3B+cNpKKVnti1tS9DERUfsBrNwj
	c563B7wIBrRiHqSWZ0dAFrBIdEs6l64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ZHBxSe9DOK2jbTTGAv4ZNw-1; Mon, 03 Nov 2025 09:20:56 -0500
X-MC-Unique: ZHBxSe9DOK2jbTTGAv4ZNw-1
X-Mimecast-MFC-AGG-ID: ZHBxSe9DOK2jbTTGAv4ZNw_1762179656
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c71c5892so1566025f8f.1
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 06:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179655; x=1762784455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7uJpM+IX3iswe8DPfd0iPbF2mfDVsJfMczQqxcPMxc=;
        b=m6ci5w3S6JD2GzT5Qmi36JOnTr0NlY9Jrt0FYSiRz281t0YHkyswr1IxhtogoXSGs1
         X4DagoZqoMHlcXijKXpCWXRrZWkqKnzfokLAch4BdvOUqc1Gas579NovjGdYnQByh0xE
         rc6wJr+JGVVIEUrtAIVcvqYP1TBc9cm3QXLUYB955+yZ7ed2XiRjD4LNZ0tZyAO1+0no
         K25/xDJc7LPiTUB1mYO7UzjUTywYRpa7QNAr0H1jxZ+gyTLCm4yUl1cy/4Ull6epRNZo
         2DYL5dd7FSaLMWe1vWXU1x9j2w2H6rc0F5hZ2Qqv67w5Wtgg3kuD9yaLjKmlAA9wI7rW
         J6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXkN1FpUxMrxbAS0xiwPRiVIur6VgPoHu11fRVJ7fXfiKg1FtzeFL5sQBuwaqh3SI61gtr85itJ4T4X76sCig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM/YScS37lcYMwCozwJzIAHLKHlNkFQb+OF+SMeVDzDQzF/DdE
	Mha2rnKCAkowslCBojTUHd2+VWoGUa039g+7+xjLe10kS9XJMh+cz8QrowgHZdvli1PC412IEg4
	T4pkbNBFvqGoK2lm2XzrXuL9C3xOuom7r9Dxxy1ezIs580Y111ex1Ng92qQf3dUmOO2UY
X-Gm-Gg: ASbGnctCDf/bXRoPMh9FG1oqgnjaf/kgwy9r0BUXMV6aczXyJdXnIELVUbZDlYJbIsY
	f6CUktjJiWJhqs51szI18+XXHXlSPXa8Is7YHQnF6EnIJOT8xSoK79eAnUodOBwQBqcFIyooWop
	03AAeKl34xqrOY4T1pS0GG7b3kgRc1wpwyA1DhhXIRLq0dB6UXW8++mPF63Dxr9bbwH1DJiuTS+
	dHGHCjRLCY56J/9kKZc3VVPwzGiDlH96UAKmErbJpH2L2Cv8qRhOKt0tXjC19Pv/NZRMJWF6EbC
	VNJdTpvs+MEBLqcH9Zkg/uH+9C8eBwuArpKRO5UBHeVk6GqkLAg5yNWNUDyky1W1cTUX7kC4/N+
	r1u5gUOQAsjHHeXb2nR7PCsIeyGwG3DmD+mB7SiunUnMFGg==
X-Received: by 2002:a05:6000:2c07:b0:429:d436:f142 with SMTP id ffacd0b85a97d-429d436f26fmr2390304f8f.57.1762179655453;
        Mon, 03 Nov 2025 06:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzkoLi+d77cMUSgKnEhwbdSo0rEoMdb6I48dSnxMn95tj2GQKmjbzhfBOjcWOs+RDqyIi7wg==
X-Received: by 2002:a05:6000:2c07:b0:429:d436:f142 with SMTP id ffacd0b85a97d-429d436f26fmr2390227f8f.57.1762179654772;
        Mon, 03 Nov 2025 06:20:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm20888368f8f.23.2025.11.03.06.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:20:54 -0800 (PST)
Message-ID: <e3eb5b90-5f56-4669-8c89-1f405d23c5d6@redhat.com>
Date: Mon, 3 Nov 2025 15:20:52 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 20/22] vfio/platform: Convert to get_region_info_caps
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
References: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtZDIe2VWsBXBH8xtatI74wHcXuPW1PQxyxgIIydcZY_1762179656
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 10/24/25 1:09 AM, Jason Gunthorpe wrote:
> Remove the duplicate code and change info to a pointer. caps are not used.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  2 +-
>  drivers/vfio/platform/vfio_platform.c         |  2 +-
>  drivers/vfio/platform/vfio_platform_common.c  | 24 ++++++-------------
>  drivers/vfio/platform/vfio_platform_private.h |  3 ++-
>  4 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index d600deaf23b6d7..fa754f203b2dfc 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -115,7 +115,7 @@ static const struct vfio_device_ops vfio_amba_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> -	.get_region_info = vfio_platform_ioctl_get_region_info,
> +	.get_region_info_caps = vfio_platform_ioctl_get_region_info,
This would be nicer if called vfio_platform_get_region_info_caps I think
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index 0e85c914b65105..a4d3ace3e02dda 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -101,7 +101,7 @@ static const struct vfio_device_ops vfio_platform_ops = {
>  	.open_device	= vfio_platform_open_device,
>  	.close_device	= vfio_platform_close_device,
>  	.ioctl		= vfio_platform_ioctl,
> -	.get_region_info = vfio_platform_ioctl_get_region_info,
> +	.get_region_info_caps = vfio_platform_ioctl_get_region_info,
>  	.read		= vfio_platform_read,
>  	.write		= vfio_platform_write,
>  	.mmap		= vfio_platform_mmap,
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 3ebd50fb78fbb7..c2990b7e900fa5 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -273,30 +273,20 @@ int vfio_platform_open_device(struct vfio_device *core_vdev)
>  EXPORT_SYMBOL_GPL(vfio_platform_open_device);
>  
>  int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> -					struct vfio_region_info __user *arg)
> +					struct vfio_region_info *info,
> +					struct vfio_info_cap *caps)
>  {
>  	struct vfio_platform_device *vdev =
>  		container_of(core_vdev, struct vfio_platform_device, vdev);
> -	struct vfio_region_info info;
> -	unsigned long minsz;
>  
> -	minsz = offsetofend(struct vfio_region_info, offset);
> -
> -	if (copy_from_user(&info, arg, minsz))
> -		return -EFAULT;
> -
> -	if (info.argsz < minsz)
> -		return -EINVAL;
> -
> -	if (info.index >= vdev->num_regions)
> +	if (info->index >= vdev->num_regions)
>  		return -EINVAL;
>  
>  	/* map offset to the physical address  */
> -	info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> -	info.size = vdev->regions[info.index].size;
> -	info.flags = vdev->regions[info.index].flags;
> -
> -	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> +	info->offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info->index);
> +	info->size = vdev->regions[info->index].size;
> +	info->flags = vdev->regions[info->index].flags;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_ioctl_get_region_info);
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index a6008320e77bae..05084212a76eb6 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -86,7 +86,8 @@ void vfio_platform_close_device(struct vfio_device *core_vdev);
>  long vfio_platform_ioctl(struct vfio_device *core_vdev,
>  			 unsigned int cmd, unsigned long arg);
>  int vfio_platform_ioctl_get_region_info(struct vfio_device *core_vdev,
> -					struct vfio_region_info __user *arg);
> +					struct vfio_region_info *info,
> +					struct vfio_info_cap *caps);
>  ssize_t vfio_platform_read(struct vfio_device *core_vdev,
>  			   char __user *buf, size_t count,
>  			   loff_t *ppos);
Thanks

Eric


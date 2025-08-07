Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66895FB95
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570768; cv=none; b=FG2YoIuD1oSmlLJo4OsMpuJnON96abEw7WjlIKJXWkKL28okLK0c3cOdnRRQQ5/EVySCIE+a3v+aengZvpaLp4BPG94WXa87tDuIZge88JPHr8sHktOVMx9isOANtwcmz5I7oXY35lSFStT5HF0xl4kN5yozAFoy2hH9GDG8Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570768; c=relaxed/simple;
	bh=SLMjRNqfRB8WZrmm7YlXu1OtnsSA4gA3+W+rAwXSIbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FOLJVG0f5UDGEjmo2Qbf1a+qEZnOo0AZmhCgsEEHkdTfVQTXAU1RNub5V+Wd//+LunGefrB5lpHzvI0sTQ8yQzbq7gTfhbpsm74EKuXM+/zXyHNoJYB2tWvYbYI2PR1qW5UBI61izfvyvvL9x8wg/3rtuPYJni3PSTOxeZDFirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghhbs5Wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghhbs5Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754570762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzpyvLBCuDDbTq0I4txF+uqEBSf1omkOPXzrV+o5WA8=;
	b=ghhbs5Wy8Oa43hPyDfRtYcXfwwdj0ViHaWfcD4jifflUAQolGDnlMOaBbNSuWRwVlabvM3
	E8lmb9rmszwIw4K23UPxigE4NDkzCJqLxukZh2ENkz4yR2WJqXr9/6G5+bkssNnAsMVx6G
	oEWhI4rmhphWhwdErq5lA3VJB/EOvQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-NeFJBk1wPvGDukixI0dXYw-1; Thu, 07 Aug 2025 08:46:01 -0400
X-MC-Unique: NeFJBk1wPvGDukixI0dXYw-1
X-Mimecast-MFC-AGG-ID: NeFJBk1wPvGDukixI0dXYw_1754570760
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e0f54c88so5004785e9.1
        for <virtualization@lists.linux.dev>; Thu, 07 Aug 2025 05:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570760; x=1755175560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzpyvLBCuDDbTq0I4txF+uqEBSf1omkOPXzrV+o5WA8=;
        b=XKYIYGCruFSpiQEQ/eWE+OWegbMmchwq4dt/SWx9JoxIPyCI94IuoJ1DSfV1+BdFVb
         KJ/vyppu4AxUhu6iCVS3aOi6ybSsGwqFGBauFtelv5MSjlgrLXhlM8efdoNsoctUvT57
         eYkRlIY/WfITEkT1NcEu/sN9wYlTIjqA18pwopfdFBDBLpdBEzlfLpe0WeIcBvBdhMbG
         gkr6IcOWfV1uc3csmGOX44tgptxArYRU2oMkGr4Xli28trwMgEGBKqGf7T42UWbUdsHa
         OWZOclhW21q2cLVmujpw/5qlgoVANTu0UJ6ESmMD7JOHTdqw2a3nGaWWFG/YjyRhG4KU
         FdMw==
X-Forwarded-Encrypted: i=1; AJvYcCWKkUyYA5SjvRC6W1ebhkT17bZjV50RaWN1N8cd39fgO3WWNIYOk7qSka9kgTI8Xwui0KA5UJ60J+A4rSYJZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZuhktgC1VVXEHT2nsVJM34sABUpUvD9xT6CHHOdjbJmTiMBDR
	icTCA1lVXGFNFoSLOZtsytLhgwAkX8d22S99BiAh4UQoFxIYB3d8yQDhAfvVDtrk2m8qX0Y039A
	icG+dzfESbmFPpVdDr8HNY/+NzipLUbH7s6h4QI+DPJLmGuZgzOAlct1d/Xx2GqEPiw3J
X-Gm-Gg: ASbGncttOkgfV7e/413yb4GWfckrYQhwnm7StlpKN8j8/Vk6EYw2XMn7bT55C3OWuWO
	CAKuy0kwdCpjhQAiL7kCuFBHAZZvXaxfuA72yQ0ZCAUVgQhLzNyuo9XZKjqgDlCC6RWxqE96tOh
	nYaqR/MW4tc16F4lMNRPFnrtae/9OzdFVsp5ETA7JngjNGst7BRgPk4Ce7VdWR+S+VvuxshPsPw
	Ur3yxwDiLBLb1Z0YGphrk6RMau1pk+o4UXIv2VJjmnRQO1/LGRP3lpk2/fq4nWDf57yWzXIuT/t
	KymaPoAwsw5ly7jAowrwmQPLXzY3ciVW
X-Received: by 2002:a05:600c:1c9c:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-459ee0a960dmr34280005e9.14.1754570760128;
        Thu, 07 Aug 2025 05:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbbXT1nYDpa11Vm4wjS1klHPpTOY7WS4UUDzDQqgWHSoXb4hnl8yYsbxcqS9wXeD7K7Y86cw==
X-Received: by 2002:a05:600c:1c9c:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-459ee0a960dmr34279735e9.14.1754570759734;
        Thu, 07 Aug 2025 05:45:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm26009083f8f.57.2025.08.07.05.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:45:59 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:45:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: sami.md.ko@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	dmitry.osipenko@collabora.com
Subject: Re: [PATCH] Revert "virtio: reject shm region if length is zero"
Message-ID: <20250807084310-mutt-send-email-mst@kernel.org>
References: <20250807124145.81816-1-igor.torrente@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250807124145.81816-1-igor.torrente@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wDP3rz_t2E22y-qdQr1VkjVeflUZlBFSsl4tAvKORSQ_1754570760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2025 at 09:41:45AM -0300, Igor Torrente wrote:
> This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.
> 

No that's not enough. Explain the why not the what.
for example

-------


The commit 206cc44588f7 ("virtio: reject shm region if length is zero")
breaks the Virtio-gpu `host_visible` feature.

As you can see in the snippet below, host_visible_region is zero because
of the `kzalloc`.  It's using the `vm_get_shm_region`
(drivers/virtio/virtio_mmio.c:536) to read the `addr` and `len` from
qemu/crosvm.

```
drivers/gpu/drm/virtio/virtgpu_kms.c
132         vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
[...]
177         if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
178                                   VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
```
Now it always fails.

To fix, revert the offending commit.

Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible")

-------

> Signed-off-by: Igor Torrente <igor.torrente@collabora.com>


> ---
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


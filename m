Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962E23C4E9
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513260; cv=none; b=hJieBUPFJs3/wL6fe4Y55eIdwQMtu5fUh38AHiN722nzEXH69Wg8K4xBcfIkiAgzMau4xNp/2/9OthEfX1gK4i3ZRLsjYmIFrcaT4/G5XFILl02mnLeIwGm8ylACRcBTfTqEvU4ZSaJcnQYvng9oRTVmS2QqC7rXHW7PSHoiJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513260; c=relaxed/simple;
	bh=K32KMutlu0ueMIlLxLbh57mXUrOlGxR7duFPs825SlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qVZZKy8bzXpkiCp0GHxBliSTaFLmxuyAYtWEWkEsnQI+dawJdejGZpjU9PhmCXCcAj4TZwLc9Jc2zKwWLcCk+8fy8wmLqlSkHilZBgQrXJa2Hf9RoiVz30yz9jSgvz6SnfjwVAzGULAu3riPYZ2AbfUZ/2m3ig9ALfPzfQdnHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCZhU1bz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCZhU1bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754513255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlwNsvbEYjfHRGNVKi2/h04wG5TuQNP/hEP/Uihzto4=;
	b=YCZhU1bzRL7Weu1xEokbqvqHtmGhGqM7QNOfSPKLyfPYqy90WC1x6YsMjKSKz6JTqwZdXw
	doY7vcFkB3cTHMJw4A5hxOhjrJ+aaLZRhvfCWgOxaOn0TN7eoOp42HrBJBfwTxFP4ILCge
	iP7Vs7Q3YURyC+GAjL2XY8gQSNzCWO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-wyHmlRYQOFWtSJMKn-s9DA-1; Wed, 06 Aug 2025 16:47:32 -0400
X-MC-Unique: wyHmlRYQOFWtSJMKn-s9DA-1
X-Mimecast-MFC-AGG-ID: wyHmlRYQOFWtSJMKn-s9DA_1754513251
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459dde02e38so1025945e9.1
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 13:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513251; x=1755118051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlwNsvbEYjfHRGNVKi2/h04wG5TuQNP/hEP/Uihzto4=;
        b=YR82V0YjhIAoYHlqUmdZgxpF1uNpHEepam6mPezffIeeVab0B1/SodHwuO7R+JfLu/
         qEq15ORjCnFmme5jfHRF6ydN81WRMA58J5WUhNmkg8X5W4zw+aoEqOsdnhYmHJBW4JN/
         k8WdN0O0hWhYBX1eBOCiTC3c/9JYHlYvQzYC0EPa+8Es5DjFnWrAFVRbmaX5B8jKgUuO
         7YBN9eAoETENiMjgXP8fwXMw4ZOVYmrNP44JPIczOudBykyHRJjbJO3PCG+4w2h6PVG/
         ylCBDU64fWRz+CxPWmnAL7GjAqBA6Rh2FdpXUj16CPAVAqrCc3cJ/kRStPMYIX6dt4HZ
         9ztg==
X-Forwarded-Encrypted: i=1; AJvYcCX3/2EpSZ5lvNE/3io0clRNy0LxRkkVOscRwJIPeBoDWEJ/DNolczodTkDaBmT78kIJ/P0yd4EX7NANTdue3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV7Ilcq1iWqZ/PgcdEaatC+/oQMC3waESaq0oPJHT1TqHdLqev
	w1qo4kNExZCwdikXL7o18Fl0xH4c5Plsb6VmmXVdWi3NiGdgO6IbutlD9Cj5iL+Fcpyll2K62Qv
	ybJynTjPnO0+XLbfkEchfQPM+ITSqOpFHXM7IrvyjaencFa/GhLmbRO4nRNDj/oeGeSKZ
X-Gm-Gg: ASbGnctv7OWQyTDklChEuuG+7LKYL0nL60PdFXvKmYKhjyuScDCbG6rWRy4GGgWNUgi
	PLRfXCwag41nFulJqB2B7R/AwsTRRUJmCA7gOtT/oMul5hHrM3gOGCldW7RwpJOFmndCwassfQV
	CGeTuE5hbtR8UyWHhfAUEtwlYG18ShPWoFCXicfsijCvu7LsN9ztrpB2DbN7OLcjHhtsQtk2LDP
	aMBAc9IEhi/xk6ee+YCN39deEUqJ6BIjzBk2Aeh8uXLBejUUlGRNcajKnl4s82spkron2Td/yGh
	PT+frQV4/odzv0oIseYKam9/7vva47Xp
X-Received: by 2002:a05:600c:6305:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-459e709aae6mr37799235e9.11.1754513251203;
        Wed, 06 Aug 2025 13:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbRLRaL7K60EhkRWSlXNixh8uPd6V6yEGxqI0NMw0jyPpuYmGLkX16WFH/BvDKnaRCqACLiQ==
X-Received: by 2002:a05:600c:6305:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-459e709aae6mr37799045e9.11.1754513250752;
        Wed, 06 Aug 2025 13:47:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5d7deaasm3285773f8f.65.2025.08.06.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:47:29 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:47:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: samimdko <sami.md.ko@gmail.com>,
	virtualization <virtualization@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	eperezma <eperezma@redhat.com>,
	xuanzhuo <xuanzhuo@linux.alibaba.com>,
	jasowang <jasowang@redhat.com>,
	Dmitrii Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: `virtio: reject shm region if length is zero` breaks virtio-gpu
 host_visible feature
Message-ID: <20250806164708-mutt-send-email-mst@kernel.org>
References: <19880aa3804.3aa8c0311540629.5527706858754550702@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <19880aa3804.3aa8c0311540629.5527706858754550702@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YqmS52QP9XGVvQWq3i6GE-gRxQjCc8r6smwL5c-9n6A_1754513251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2025 at 03:34:55PM -0300, Igor Torrente wrote:
> Hello,
> 
> The commit `206cc44588f7 virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible` feature.
> 
> As you can see in the snippet below, host_visible_region is zero because of the `kzalloc`. 
> It's using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read the `addr` and `len` from qemu/crosvm.
> 
> ```
> drivers/gpu/drm/virtio/virtgpu_kms.c
> 132         vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
> [...]
> 177         if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region, 
> 178                                   VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> ```
> Now it always fails.
> 
> I don't know exactly what issue this patch is trying to solve, but right now Virtio-gpu relies upon the previous behavior. 
> Can we just revert it?
> 
> BR,
> ----
> Igor Torrente


Pls go ahead and post the revert. We'll see what happens.

-- 
MST


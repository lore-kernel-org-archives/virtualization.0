Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FA1CDA3F
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462001; cv=none; b=usoL82zhgG5FhNxyFCp3keQ/B/au8YnLWEcx6DIfzKTq0dx4PU49AOk1IerGpmmtH/S+ghjJD4zeH3ZV4oezwDEV2+PdhEE6rjwiJ+cBfBWLWof8se21Zky3fKcg/H6STQMsBq03UDRPZziqoSbDrRI357NJ198Xekmi34rjxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462001; c=relaxed/simple;
	bh=Fr0YTAU+jzS2hTVLmxjX355fDOiiw6bVHBgQDsvSUwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AufLPJsqVlqJbPL0VRfaqtucjPE+O9AbYKO+Ptr62ks4+Pa8WWzBlGFA9dXKOGfmB69fZuHFcKpvJzkJy0PsnqWgqrcjxPSBZWLu5/vBEnOlpTp3soHFGUWlFTjCitu+uHyQYI9IUa+CDZxrp0J6FMvlR3c+C2PHpyDErzEQIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acyRnW+L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acyRnW+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739461998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm65mUYAEbhhNi250l1nY6B0IiEBXXQj82KeWsM7Zn0=;
	b=acyRnW+L3fVI948s6sQF35IfKmbp9iXRCKUwTDy47/kEdPoZjN92c3etynBAEwZQ1lP8nm
	3mECY6ihs9xi4ecfh90EF+LUC9SAwkQ8Nbz7bAKdmQ65oodEX7KSuhXnkFXhEjLoh8kaCP
	1GgAakidhOtz1Ads2Yy1x3IfouHrads=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-aZ9kBOBZNZ-p1Ow_45uRtg-1; Thu, 13 Feb 2025 10:53:13 -0500
X-MC-Unique: aZ9kBOBZNZ-p1Ow_45uRtg-1
X-Mimecast-MFC-AGG-ID: aZ9kBOBZNZ-p1Ow_45uRtg_1739461992
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab7ee928985so118948866b.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 07:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461992; x=1740066792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm65mUYAEbhhNi250l1nY6B0IiEBXXQj82KeWsM7Zn0=;
        b=kyhcYw5sme5NVs5yPZlW/OPGN86nq4IltQ0TzUnjiWZU8Do3ipkr7NWMSXCDXVpwU/
         SNVf264mHPg9Qk0Tofe9yYDZSmkaPDWficrEMecOBOZ1NvGpseIB+jiLnFz6SUTG/kv3
         KK/OKJsqI5WKPnfK3yfqmursTCvZ4aBN7UeoCVdh6TD2DNdLOouc/9P1AMY4WpeuuV57
         uKVKBPuCcHMkgZf6dN0lLztpeyGKWnPrOVWRzOm6hHoHwbhcxfGqB6ix0q/+MwShNZLr
         5Uyk/kwEX3NDAc3xUU5Fhe2ryX67b4nLRpboePbLbueLz8HO5Z5JkgF2hernuUBQLoOF
         BSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPkTF4pw3fRqTZvghOCWJGzf4P4vnqhuWHoiv9NTt1Hc9UDaWbtnh8Jt+ebyOMtEmHGye3cvAEVUK8KthCxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3rRKHdkcWLY05oUNaGzm4TAlTolUq3OCfP0ko0W5Gs/z15J9p
	sBFnwDhgK7/ySNrA9sjg+JmNXGkay8igeIaZxpc4zRgL/l43dJDnC4e7Xy0xFm2SefKeL2CGB9N
	Dkp8+Zn66x3nI8rziL5trnIMDNU7VuNTxG1nmu1hlA+pYv+DtLjqZ2XedRs2qIgEx
X-Gm-Gg: ASbGnctM4wFvuuiK0uaG4XTj06QR6jeKusByee1g4VNp3t7UwiZJc9NpwLFty0BLXEE
	TogGmS5HC8q9o6yfkJwNe12Yegd4T5fBSPvgG/Wi+7FX/wLOytJj/zWUz4H7KbRMHFrexCljgl0
	Kfwky5fHuTbFk2FAtRlvuu15MNPu0a4Jo1pRpb034uTSVTTLaxDJPE+2N8V7FxmfuYabFhoYxgC
	O30U74f9oKbHm3dXEj11TX2ZUwH4YSc0WrABr9V5w1cAZDsnd5YJxLcxnW2UGMWtDj8axeNTQ==
X-Received: by 2002:a17:907:9710:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab7f33f5f15mr585698666b.30.1739461992359;
        Thu, 13 Feb 2025 07:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPYyt4663087uMZIIKURYrG8Pp4HqyogPBtf0brGd9uzETM6Wmccz2T6+v992nLi1pX3fRsA==
X-Received: by 2002:a17:907:9710:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab7f33f5f15mr585695966b.30.1739461991960;
        Thu, 13 Feb 2025 07:53:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:171:92b6:64de:62a8:325e:4f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532581acsm156316266b.50.2025.02.13.07.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:53:11 -0800 (PST)
Date: Thu, 13 Feb 2025 10:53:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	fnkl.kernel@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/5] virtio: obtain SHM page size from device
Message-ID: <20250213105231-mutt-send-email-mst@kernel.org>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GOIDYql50PE2kc-3zgouNrfLjeb5txzyHh7qtA20udo_1739461992
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2025 at 04:49:14PM +0100, Sergio Lopez wrote:
> There's an incresing number of machines supporting multiple page sizes
> and, on these machines, the host and a guest can be running with
> different pages sizes.
> 
> In addition to this, there might be devices that have a required and/or
> preferred page size for mapping memory.
> 
> In this series, we extend virtio_shm_region with a field to hold the
> page size. This field has a 16-bit size to accommodate into the existing
> padding virtio_pci_cap, simplifying the introduction of this additional
> data into the structure. The device will provide the page size in format
> PAGE_SIZE >> 12.
> 
> The series also extends the PCI and MMIO transports to obtain the
> corresponding value from the device. For the PCI one, it should be safe
> since we're using an existing 16-bit padding in the virtio_pci_cap
> struct. For MMIO, we need to access a new register, so there's a risk
> the VMM may overreact and crash the VM. I've checked libkrun,
> firecracker, cloud-hypervisor and crosvm, and all of them should deal
> with the unexpected MMIO read gracefully. QEMU doesn't support SHM for
> the MMIO transport, so that isn't a concern either.
> 
> How the SHM page size information is used depends on each device. Some
> may silently round up allocations, some may expose this information to
> userspace. This series includes a patch that extends virtio-gpu to
> expose the information via the VIRTGPU_GETPARAM ioctl, as an example of
> the second approach.
> 
> This patch series is an RFC because it requires changes to the VIRTIO
> specifications. This patch series will be used as a reference to
> propose such changes.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>


don't you want to negotiate the page size with the
driver then?

> ---
> Sergio Lopez (5):
>       virtio_config: add page_size field to virtio_shm_region
>       virtio: introduce VIRTIO_F_SHM_PAGE_SIZE
>       virtio-pci: extend virtio_pci_cap to hold page_size
>       virtio-mmio: read shm region page size
>       drm/virtio: add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params
> 
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>  drivers/virtio/virtio_mmio.c           | 13 +++++++++++++
>  drivers/virtio/virtio_pci_modern.c     | 31 ++++++++++++++++++++++++++++---
>  drivers/virtio/virtio_ring.c           |  2 ++
>  include/linux/virtio_config.h          |  1 +
>  include/uapi/drm/virtgpu_drm.h         |  1 +
>  include/uapi/linux/virtio_config.h     |  7 ++++++-
>  include/uapi/linux/virtio_mmio.h       |  3 +++
>  include/uapi/linux/virtio_pci.h        |  2 +-
>  9 files changed, 60 insertions(+), 5 deletions(-)
> ---
> base-commit: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
> change-id: 20250213-virtio-shm-page-size-6e9a08c7ded1
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>


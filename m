Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94B4279F9
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002314; cv=none; b=HhKs71+Lr0HxMRGq03/smCkin7LFkTbg/eaWZDWX+ziTcNecUsa8iw+XOQvw4NF9bU/OTqWZz7a88IIlLCN4bCs85dnOONdZZKwSPlMXx4Wvsosa593yGvGZvkWXagD+TccD0+ULM6+m0ZAZMJ5fWS5ddZYoEU/NXaFtPKPkU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002314; c=relaxed/simple;
	bh=DcH9k9Tlh2c03HyU3Zw/7RvqbH8v2zIC0lTji3hhsSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhut56dTzP43yzH0m8qPHM3GLBPwL7HeYsYqCb8v5YbBI2r7bwb9Hj09eqb+vcsjUdfT4/cP+ZpYgc7BZTWHxtI2KKPtUPG2K5MBKa00gwyH7pT2RnWmIgh2C0N4AUfiFis341RYdP66P0RzNO1Y/NTOb/4+ByL8kEyRYmrpe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PXHLgd6I; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PXHLgd6I"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502a26e8711so28381881cf.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769002311; x=1769607111; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aX294P4TliS2B0BrPhrC1yfpgvWNBReUGID/aL6TSBE=;
        b=PXHLgd6IRa4fT/3+fpQP1lH4fS1ZjAJPbfMwDrXf9z6BOINz8xuLSHN/3fV/zl1z1h
         /hdqcrgWDWToR9MJ73EVdT3Tl+vnsWNSBTHY3ArV/39MXllsg4kR2DFGpAn+J04mXJNW
         KvKek9lDwfKb2AQtiv8PMtepBDp+1rLOCF+9E4dOv8vaNDjUTxFhj4kHZZW3U5r0VMC6
         2M6m+EfuRyFr0UQtCg7ION0/AKc/ma3Yk6J/mZkAjK6xyIeuXXbSMmFTq5lv9h5D54sJ
         1I2XAuqx4iuYp5cNg/9YJJCSgXiXwNbuPjnHdTUZRJlaeWrw8tk1yO1HhDLFbpe30AVK
         xZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002311; x=1769607111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aX294P4TliS2B0BrPhrC1yfpgvWNBReUGID/aL6TSBE=;
        b=cUayFJDWvfRgxgHpfcMcBbd9tF0EnmalMg/po31j80mUeFQTVQUzk857k1UIJiRa2y
         VxKuOew0hdEHkM7GMmX7nSr4GLIpnuPBo7XK1Z/jsdfMNWjLeqrN0w6jVzTREELIRhgC
         kEw9cR8+3BCyQ+5mnqPBTO+nhzzdT/YmYdUjwDEvyXBE4kVQATNhyWeBJlEISrUpb22O
         M2xf2fC4wCQ09drGlfJz7XaKKZH7g7Tymo+5Ts+68UpGXHPv0SIKn0q7vqE6Tftn6P6P
         24dj1h8gt26211AxTp5kDdfoRn52dh3hGZ6PLDYI13JM5bhxLDQSfOb4K7UGF5hG34co
         0LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFgVUnYUWGX4PTjgT8sXCf61/EG/G5/Vyc5RWTvBUyRPTgxXcKpYdIiBiy5oamxTInqGmdM3V4qI9cr7iKPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUtoACWoGVUjzPdJncD8lJlKKegSG4xFbsxOvXCDAsrdJoCFGj
	IE6QintYXcns+fcSbcj6Xj2/z7srqpDtlcnSKonbOil3daEXoRSpOReH09dmlQU+kS0=
X-Gm-Gg: AZuq6aJ4yWWmoXb2BG7MfZyUzPlIH0efurzYomzwE8YJnbjyFrDkH/YxqCPgcAbDWm4
	ZuPv6lzpm/VDAmutHOLPHTJtd5h83fkAQzctuqMXl8wQ6CKZT7sTNk+Q/9jfFzQmdszMtE3MllX
	Aiy7/4QPznEW529x2m5XbZi1o0YguFQn1eDQLFO+svDU/1kHbABWJ4shiENUZQBFP/PGUL1FfyP
	fLowcoMn+Emv5zrI0LGzt9i4L++bCwZYg4eM433EnSZH69cDYfRTY52fh6/rBAb12zTP4IyCleo
	RllZYia/n3zGMOyBSLZiV8JNLNSgOXk6U2cnlwr2e325NCLejCjbiznpM5cWwH736/3SpkQQUnP
	LeX3/+WooPIx2jkVzVMCb30ip7XJPZLmr9JQ05AmmO67+8UDn4zi3T2rYzAFaLvwGANUv+TBK3x
	rN7xGO99qmp0sXGga5ZBHRG31XHHt5BFoIN8REoYhQXQaqANSUhX/SjrZsu5XPi2l6HBB/2RTZe
	zsOjQ==
X-Received: by 2002:a05:622a:1aa1:b0:4ee:2200:409e with SMTP id d75a77b69052e-502d82772a6mr67009251cf.4.1769002308002;
        Wed, 21 Jan 2026 05:31:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1c1c4sm108692291cf.33.2026.01.21.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:31:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYJG-00000006Dbm-2x5v;
	Wed, 21 Jan 2026 09:31:46 -0400
Date: Wed, 21 Jan 2026 09:31:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260121133146.GY961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>

On Wed, Jan 21, 2026 at 10:20:51AM +0100, Christian König wrote:
> On 1/20/26 15:07, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > dma-buf invalidation is performed asynchronously by hardware, so VFIO must
> > wait until all affected objects have been fully invalidated.
> > 
> > Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Please also keep in mind that the while this wait for all fences for
> correctness you also need to keep the mapping valid until
> dma_buf_unmap_attachment() was called.

Can you elaborate on this more?

I think what we want for dma_buf_attach_revocable() is the strong
guarentee that the importer stops doing all access to the memory once
this sequence is completed and the exporter can rely on it. I don't
think this works any other way.

This is already true for dynamic move capable importers, right?

For the non-revocable importers I can see the invalidate sequence is
more of an advisory thing and you can't know the access is gone until
the map is undone.

> In other words you can only redirect the DMA-addresses previously
> given out into nirvana (or a dummy memory or similar), but you still
> need to avoid re-using them for something else.

Does any driver do this? If you unload/reload a GPU driver it is
going to re-use the addresses handed out?

Jason

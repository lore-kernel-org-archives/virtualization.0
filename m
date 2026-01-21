Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844747A0AA
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003236; cv=none; b=RNpdJvgcHnM8z39TGuDD331dSzzcf35X1YSqgPTOJD3jiQM9Du//BLK5lmm3LkdMnwjxLzKFMP3UcewyaXBytWmfGU73bFBWQOu86k4+pV0Zw2ydLFIjgDEdx70Y0Ux/mJk+ECkLunGPGT7Sm7T5YChpV6wZ/ntnaLfoGSblp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003236; c=relaxed/simple;
	bh=fn6QDJCmTOKiiaWIAjab6bH+PZ+yr8u3rj/vi81/cYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRzrkAy3f7fS/Mo6oOBOF6dfLWz89VkOzMppuNjPfXsQwRbSqDVbsWfMrwwUh/wXL8DtCMmqdMgALcJaWgGQ7VwOE+t9jXQuv8d9WkfULWtsZAT1TWtf4CVWSwmNzDXRjGJkBsQdOM9F0iX/VdARC4czDcChf3K16loT/n8diKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SvFVa2Tf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SvFVa2Tf"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6d76b9145so47219585a.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003233; x=1769608033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=SvFVa2TfnO4c1SacRXKLC6gpb5M82wQBQp98c5QPjZikU/ftoxdl7hDajo6MMK9nca
         sw5GANg7qOf3ceIb301MxckhMeWS/BgxdavItK3Hi6kxthfZerPIW2iNAug0KSGHN21G
         bWXuf/h1T1wEkazJR/AlllY5Cjc/GbBjZjY2Lqz10Naain22TIWMFrxsbkAFIekLqOJI
         Gdz6MyWSl54RZQgomt2epAZ2gm/TElB6+VCqAbGM8/kbwYUH1M45/jzcYFrrpx0mbr32
         Ci+sgAmTAiR5poxA030dpBFH3pRUA777C0Xpfd9e/VlI9F4Lvc0z0Ic7N9UfNgH4aOQg
         E2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003233; x=1769608033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=MNVI22p6v8B1bFYoDeKnjAxZHXJ6HmI6ZkUiHakZIxzqGvC4S4EkBUZv3EDRJ+awjC
         v3a1oBC6FhMD3m7tX+FFfrnLW7bngZyBi9QVaL9PCJL/w4cNz68fivGPzCYHUno2Si/8
         aDrSLx75MAZB4Nu3jv42M0geZmrX1+YmNguYmAWa9W+8UPed2eEm/nvzDE1+/NNsEcix
         bS9bwAH6b6cQH2ubD0PAqRBS7/Bcuslo4NSvcaUhaIU0kc1QTaHr2bid8fIMerS+eZBB
         n0+C3bI9ySYCiqAGwkArvaFN66QM+pQDPrIZ9/V9conGeHS1wIclOvbM0xLc9XXuC1hK
         oJBA==
X-Forwarded-Encrypted: i=1; AJvYcCUiFFRy400ttYKuEci7wPilZr1f/ka7Xj3ZS6ZL85V13qtt0m096udkm1ckdt/HoXdLdoXllaR6pe3MkvYNFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiAStRjq4arV+SmmLKB3Z56TkkbeVCXJSjDRYHIo8IGn6ACwU+
	Dpq71iBu+doFmUsOzUu68GG/QNHT762psDyEDCYtyF1wgnZP+juHPvuQOeNIhRnzDBw=
X-Gm-Gg: AZuq6aKCV+rCSaHI6Fw5N2fPWpbEs8Cja5tWM4ohQ8Phvyh4JpCdtNJtXs1Gg+g6V/J
	OxJbb53cok+FxRUWaaju1eH3tcbprUrE4acs83+X3bgDUylqxTRicp1K3O7q6CxY/aU7837gZWa
	x21NRhlJBXA8MWWfuEJkYoSd6E1eSzSvCcwE7HXVPRzd2nyDWpn5dMAEzZC4ALxVwmbrl2GM2Nh
	V+yC5OcEQrdquJhkWtJwgGf+ZeudjWpM3RiuJ2+WuuRj/llqQkSo8K5eqe/W3aEJ4g2+7lgNWZg
	guGf6DE/D7INkJeX2SyKTVquNEthoZ6bJKPFUZAmnnSZV+xbzVw1yAtaf0zjp7Eo4GUZ1/UStpp
	8f2a+7fr3J/udNDpf33WE5IWd0wUcveXhYOU+7fP8OOsQPCSYIFF+us6vOQw9OyQ3aHm+bnffws
	2V7u78/Bp5GD1ARi+heenO/94YG7lnxRGf1P0lrHeu9DoZD8a6voFS9qgMiNXRnZXd0kWbZPwLE
	D/4Tw==
X-Received: by 2002:a05:620a:4003:b0:8b2:f090:b167 with SMTP id af79cd13be357-8c6ccdbf81fmr639187685a.24.1769003233554;
        Wed, 21 Jan 2026 05:47:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab288sm1307247385a.6.2026.01.21.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:47:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYYC-00000006Dum-1GTZ;
	Wed, 21 Jan 2026 09:47:12 -0400
Date: Wed, 21 Jan 2026 09:47:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121134712.GZ961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>

On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Use the new dma_buf_attach_revocable() helper to restrict attachments to
> importers that support mapping invalidation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 5fceefc40e27..85056a5a3faf 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  	if (priv->revoked)
>  		return -ENODEV;
>  
> +	if (!dma_buf_attach_revocable(attachment))
> +		return -EOPNOTSUPP;
> +
>  	return 0;
>  }

We need to push an urgent -rc fix to implement a pin function here
that always fails. That was missed and it means things like rdma can
import vfio when the intention was to block that. It would be bad for
that uAPI mistake to reach a released kernel.

It's tricky that NULL pin ops means "I support pin" :|

Jason

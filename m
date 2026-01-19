Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC628850B
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839631; cv=none; b=ingTCvtaigVAaEcO/rNITpm+K2oSecDGwBwFBv+l0Wubd79wwZ3FWmve0tuc/fUayss2uutQSYJwJo6AgmZ1p0NU+UP0j1MpIDmf0H2xHNpxKAz+NKrCfCevx1gFcr13IhbS595pO9P30GU7K+gRUaEVjvg06moU5LB0dIedHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839631; c=relaxed/simple;
	bh=lLsaw5dNuTdwtV9+A4M72uMo0bYM3iY+i5XXMuIoHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y82OcIbeNWbduMWVt7jxbhVL5w04cC/BGzM0Bfaez70mJxdxAhefe+T9pVY2aOPbErU48IQgnrzUaXf9zwfVjFHXmOzk6vt/amnIKOjSe3r7+dzPwKd6QA3E4fj6J45IFQDZSCTy4Y4Y1LGA+CFgkdlVxEx1AwmzlWPT4E8Ej3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K9PHWl7Z; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K9PHWl7Z"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c5384ee23fso484379585a.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768839629; x=1769444429; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8e3LOQmDLtNbqPr2ZRZYrAEb0+eSE57gTBol5BlL7sE=;
        b=K9PHWl7ZnDUz0MrewIh/oz33gCPvrGyLg4/Ug6Fgnrc9Z81VsE5AR8mC2hWzR4AqEr
         lviNdgfqS1VljPbG0kSo0LBmwuPmAtzvRY2tGCP6b10rJxGJx+9BzyV0HMbQGuw4w7jS
         FXP/8YffqXUZ6S3wbG85wpp+xZaaFLlj/NPZs1+YERWVabAbOWh58wv7tDHkWRPYck5U
         iy5vEKYZGRW2Co1VpZ/PfNSGDPvz04K5JGgnLmCLDhwehHJ1RmvbxqMBWGaC8YE2Eis1
         wytdY5+tuS/N36Q8+9yqhQy4hKEpLP9bUeZ294Zf7xyUegLhC6F2v/UrPl0OnSybCRBf
         5lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839629; x=1769444429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e3LOQmDLtNbqPr2ZRZYrAEb0+eSE57gTBol5BlL7sE=;
        b=qjX3AUlWo86tiNoo7kBuzKhWhc98kjA5Wz4Ul4xHPUtC7jJ0YR+o+ssac7XORU4N4W
         F3V6SWBsUKNsNvrhEnkmlBBjA/pHj5uk2BI1DM/TI1iXa6+NZBypEWMRuMjQhxWcU8+I
         tmpIQq5dBIvpdGGnHdNoNscIlascscLXmzAAqxwm/7SWOgSGas34ETkwkPDTmsR3piub
         UIfYpZBxjVDUC5GifxWzQNRtzX5rvbkIv8C6mUMHTP3W+CEBQK4v80PqfATHG8FtoXMv
         6VIXmN7rVi+ZGJXMFfddEyz9SFLyGBkZqek904F2o7AWOuwgqTQC8Hl2pxAvPfJEovg6
         8Vlg==
X-Forwarded-Encrypted: i=1; AJvYcCV2YhKOwNtkItyPsWOCKFY4w3TtUOLg+UhtesXhlFvBFEo6HqdNLd8AJBpZm6Fje+4NJIB+cnC56Cm7GWR/yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWlchx2Usp67utB0EBrP1xUiuPVBLCNcpZiakRhehNRGOpeyWt
	dYyDVX8XeUlCboG5bxrZxjSrlau8L0wJ+IfCHczFQZ448r6gAIrY71cavGVYghGTRNs=
X-Gm-Gg: AY/fxX5JjKhw5RHqY5CV4J64paHNqa/R+ll1YET0asLAq3GOcfrW9guVOMa5VRVA9xc
	Ekxn5ZkswDyjvyeOGbVS7UIF0k2lan3RcSy4vMPjN5Eh6An88sOdP6Xec1oDeH/5z4v5q+4Wzp5
	MHJ/73hbJ4vAjarSoJF8aA6EStJrisNlUcfDQHdNHL7yRNi+6XWsWh1IafHD7Y37Glsr9sN8lUi
	9j2KQq/ZwuNiZIfLNzH+C+A+7Rw/0waQVqEU6YNeGu7B6yjFkhwgQe70u2BW69BbuUiFHfZbaXu
	/Xz5FLik0jl+wFHAYO8amHHLNmh7eTxrTnb5k8m/+Yd9Y9PoCWUF7P/wDu4ZEP3oz8gx+evvjgK
	m/VAhkGwhzYgSZsClaKB+vf2I6nWwMXPNOjI76ERHvFA74CiM6YSc28HE1JL/CHo5LLerQAQ2RO
	Wi6nw0SW2PXAODKRzr+cvcSDa6HOvJxLxG8q8amE/KfwJnDtLpQ0wrBSV/Na2V8U7vC4+RCqF3s
	s97RQ==
X-Received: by 2002:a05:620a:7102:b0:8b2:7679:4d2d with SMTP id af79cd13be357-8c6a6948169mr1559881085a.63.1768839628533;
        Mon, 19 Jan 2026 08:20:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6af506829sm597447585a.37.2026.01.19.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:20:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhrzP-00000005HvQ-0mnE;
	Mon, 19 Jan 2026 12:20:27 -0400
Date: Mon, 19 Jan 2026 12:20:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119162027.GD961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>

On Sun, Jan 18, 2026 at 03:16:25PM +0100, Thomas Hellström wrote:
> > core
> > “revoked” state on the dma-buf object and a corresponding exporter-
> > triggered
> > revoke operation. Once a dma-buf is revoked, new access paths are
> > blocked so
> > that attempts to DMA-map, vmap, or mmap the buffer fail in a
> > consistent way.
> 
> This sounds like it does not match how many GPU-drivers use the
> move_notify() callback.
> 
> move_notify() would typically invalidate any device maps and any
> asynchronous part of that invalidation would be complete when the dma-
> buf's reservation object becomes idle WRT DMA_RESV_USAGE_BOOKKEEP
> fences.
> 
> However, the importer could, after obtaining the resv lock, obtain a
> new map using dma_buf_map_attachment(), and I'd assume the CPU maps
> work in the same way, I.E. move_notify() does not *permanently* revoke
> importer access.

I think this was explained a bit in this thread, but I wanted to
repeat the explanation to be really clear..

If the attachment is not pinned than calling move_notify() is as you
say. The importer should expect multiple move_notify() calls and
handle all of them. The exporter can move the location around and make
it revoked/unrevoked at will. If it is revoked then
dma_buf_map_attachment() fails, the importer could cache this and fail
DMAs until the next move_notify().

If the attachment is *pinned* then we propose to allow the importer to
revoke only and not require restoration. IOW a later move_notify()
that signals a previously failing dma_buf_map_attachment() is no
longer failing can be igmored by a pinned importer.

This at least matches what iommufd is able to do right now.

IOW, calling move_notify() on a pinned DMABUF is a special operationg
we are calling "revoke" and means that the exporter accepts that the
mapping is potentially gone from pinned importers forever. ie don't
use it lightly.

Jason

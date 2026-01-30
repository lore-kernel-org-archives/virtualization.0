Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8D2EB87E
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784258; cv=none; b=sHvDbPWjo0LokoCA2YTlA+yYOzO0PoT7VedvEBBZ55HBT6a60QMHYLUAZ5Ir3I3+elCD0f5NVf2QcF1KtQ5Mr8FEuhO71UqXEuziWcxfR+uVWiQLXnT7TggLM+UCzdOzoxhPR1hOe9UUHbHOcfOjNIK8gKNbJmlPzEkhEyippMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784258; c=relaxed/simple;
	bh=VsbMM5xoKqA8UQ3isRtzAP4PmVkOh9whfmV8sar8q8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/2jnyer26LvKT/sWgwT1nw08Qyz/VgJvdZ1nh9ir8qPs+j7HGeAoFmF1ywM5xyPMLcdfSbWMykkwubaOkvQfKSd3Ujo2Khnrwgwl6C9saX2BLmCgDdJpZ1tF5t11KQaN+QGMgLm2hG5BvrJsAW+npGfyShSN6gG1qu6uUB98jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LJmGvR8I; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LJmGvR8I"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5029901389dso16328471cf.2
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769784256; x=1770389056; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=LJmGvR8IqrpJDPc8jT0PD+X9VvToKaanktMZQnxVNibAi0U9NqfLUaJE1S/W8EqxNP
         u1+c2st9Mn1muRaw1YRBJmXeIg6esrtQxLks8Ji3kUx0uPFzUSdzKE1aVh6B6uk+Qw4E
         iKtk+BjfbJlRhdV+LINIizvqGiGz6RxLzmKZTiOb0vUSMlQdkQWOFAw4L4LbM/crIyt4
         gnOGtiqgMRxeLkRkoynolW/BogxpPer1ihRjlVTL971TbShh7ehmPoKp/erzBnba+Aa6
         KYdWFk8asWeZzB81BK1SMEF22aa3QIftg0xJCHCx6FpGpiw0j79IUb7iBup/ZwIay4mh
         u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784256; x=1770389056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlIFC23S9unnjQhVGEC3vUha1a+Kfy5xxpLqRiUCtvQ=;
        b=uzCI0vtZpJK4B2tjz+rt/sKWIyk4rnqysMN6yA0atsoY/1Nf+iBzs2jQIFUoIjQRDZ
         tDqX3FNc8yyiJ7C3is6OHC9+vOvEwl6W4uHYmMLFWrD/jyfD8bhte1GPeH+EZL9CCm2q
         m9HBdOq2KARA80u+NrKFAjKwkxapd8bRKfbVmtdyqcQU9+Zz8aEn3rzrKbRZRRXnhU+S
         iNfbividZsg2MhnjZSGfVgvKIMjLHxr+04tTP/UQgewLX7XhesiLmPPp9jxqyDVDlcKI
         9sdldqYmchlJ/s2sY5MEbxZvF0dt2+a8vciQDImt1KqrDL0Ts0988vywHXxC36klQ4Kg
         Lo1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGzi71vLt1YrfU38MiMjOAOdHp4yuC30ACQcnNj+zeV2VoXrcVMQI7OCxxqYMtoPL48yb9G5RswBWPMTALAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/okxkQWKvPjO+1hIP9Kx4JsMDC+Gu7pRhzK5nKO19mmpHJfOt
	BPJKBzdM7U+/QFT50yEzmBzs3PkN1pADniOthp7vKUKS7WQbKKwGp9fEpIO/pTyUWsg=
X-Gm-Gg: AZuq6aLnLGgBcsiX4F5lveeHaNoLsPPs8zm6kGvhDAxS/iSonTTfuCgHaoPS5LhgYJA
	tPGoRCGtKf90CpiNgBulsj5iQfqjgqNwH0ogyHzWclzUIH5NXv3Im7fvPtImNS3SBXjE0KBsB7e
	YNgHQ/qU78CGbwN5v+WaTN0L/hyvUD7bsjkUZknnDCpJq9BseJIzR1Ed/Iz3c0iy0msKshFE0IK
	x6e9uGtnBuQ2/4avEoN2V/a21CHY5/0R155mwcz0lOBWB9Sgr9JJSe+2vTTd0HooFKXlGocYh2b
	59aSSTvfVbGjkTJ8+si2b1trkQAYBBbHbBOoT9wgRKmrLImtYwP8TjT+TZAENCfEqLod1KQncv1
	bTk7Gd51AmyZJFcpQUrGAvqxPiJZ16XZYquPt7fkFwD5sp4YYCg0TLw3Sk/KWwkFkWkwzG6lHgf
	5UXWm/9LYF5clJGfeTRLciz8OxtobmE6zow9kYWtDYBNCQOf+/Dd/5w1omB12EhILlmo8=
X-Received: by 2002:ac8:7f0f:0:b0:501:51b6:cd3e with SMTP id d75a77b69052e-505d21a4775mr39321141cf.29.1769784256186;
        Fri, 30 Jan 2026 06:44:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c426sm56137391cf.7.2026.01.30.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:44:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlpjL-0000000B0t1-0Fhg;
	Fri, 30 Jan 2026 10:44:15 -0400
Date: Fri, 30 Jan 2026 10:44:15 -0400
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260130144415.GE2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>

On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> On 1/30/26 14:56, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> > 
> >> That would work for me.
> >>
> >> Question is if you really want to do it this way? See usually
> >> exporters try to avoid blocking such functions.
> > 
> > Yes, it has to be this way, revoke is a synchronous user space
> > triggered operation around things like FLR or device close. We can't
> > defer it into some background operation like pm.
> 
> Yeah, but you only need that in a couple of use cases and not all.

Not all, that is why the dma_buf_attach_revocable() is there to
distinguish this case from others.

Jason

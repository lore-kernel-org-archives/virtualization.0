Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EE37882C
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045146; cv=none; b=NPDOqqq12npKR20nrsqDvSPiyBsJGYjB9Q2j/iRauVxShYkqWQ59QmzwBR3NsWzlgMNkuBrgJQlbZPhvrb6FfXfjk6lklOwfjv64rrSFpk0BrXg3bBdgaHh3T99bc9WUmJOy7QE1mSl/5ebSOKR+Zr4aC8yS92t+fs+nFIGSj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045146; c=relaxed/simple;
	bh=rQqYEXSh+ob8KxdPcyhxAvs4tWXZTKZFQO51kRUI59c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE8/D4aAd6rFVYcx7KqKZP7E3WF4KVYlqRqujMWxcPncL+Ytfw7mNyuucSJYlHj0a8vOowYGEeJCETIxhIyZQnbJiP8uGT6WVIkKbq/GUtMn7l4MNrd/7P09HjPcbWMU+SXxeHr5btg6p4eT2VvTPoPxnBEXinq6ZaDyXuhvn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X8MTT2Pi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X8MTT2Pi"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502a26e8711so26665221cf.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770045143; x=1770649943; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xO0aL+oRN74yVSsHQO79QNqtu9/dj8jxjzC/60StG/Q=;
        b=X8MTT2PizjjwwBAhepArmSWsKXSqcuYUfBLh1z8A6Fvk9GRmxQocJyc0CRAvinpmEo
         0U+eQSnOLgdKGQS5wND7ve7psbXSGt5H1YguSCNpH006Q5e3bSR7vy9/hDFa6l+cL13j
         3wbMdRI1I6jDTfX7mfANRrlLVumNfE0M7sPnkTZPqLoPUKuPUwypxjXtdfF/8CtdoTjF
         /bysXXbgkT+r1+Oe6xE5HMJuHqtzcSgvubZlmKMwPiRuRlUVmGLsMaiPoAYLDurr2Dn+
         asbUNc0S1GR5V5lG+ZX0HV8JadxB+g8ldBB/5GD3dMu6m1VFAyVU6jwX1Qw2snHdbNsP
         lbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045143; x=1770649943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO0aL+oRN74yVSsHQO79QNqtu9/dj8jxjzC/60StG/Q=;
        b=njRx1mu3B6DGGOvz3yI0blFiZZz8yxExV9f8IE30KkNm5hReBPvgcmqapAHkjK4ep8
         JtPmOWNRJ9aqmkhsVaVEaMBrbkdxrFfqfeJJydYFlGcd0jqcYw3E36pbB//P1/gQ/sAi
         bxSFym0No74nCgEqgmmvkO2eSi2maIvnxtAS+IWfh7RoPLz7TRYB8/8uas7Q/at/jSon
         EhknU6IYX2MQHk2lst9wnLvaDQ2mq0M5F3f5QELvMLiUTz86PRX+adplwhdEtBSOt7pw
         fhAH8feRkFO8MYSIkBxB74zLGXq20lnN8KbUKAjbSDqUZPoD/m46juIyziaE013EnEIS
         /S+A==
X-Forwarded-Encrypted: i=1; AJvYcCVah7exrYVr1MAZs2cdsTisMs6Cqwfi3fgUb7A+w0qx+vPj5IKF1LLHIBRku2Qy5vDcQx2BTKBRElQnq6j7cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVbaG/hE9Dy0RY2Nu5BI0w2ofpWpzHXMKULGflEaEeAULqvtlA
	W+rP7NbiLRJROg5eHaI9I3NFeYp02paOLIIX/oSWfEbnIqcexlsOeoNixVAltjtkXiI=
X-Gm-Gg: AZuq6aIcYOhomIFwMdVeof/POWQuiGdXZ0m5cfEnFiiwmpB5gOd2bm71YhHHoGlz4X1
	PWgf3PaCafc+RCYxJSo8qD8EazmA3hD4tmdcEaWon08WEkjaSqoNnIf7JFt4zHpTnKoDJ34O2ui
	Q6z7SRQtI8mSTArNgO469NMnDC5Ekx7WFw7qsU1S7a4YdlHjsKiL7dPtPCO1LyRhrQP9r7ddqTK
	5Q1V9OqJSY9M/vmTTWH0hbwy1RyELtmVHQpzEN0D5nKffdwYARCM2mH/pQJz7ambvDHR2Ud5mpf
	ZyYyh3OZNf03lShG54Fv2x1ZdX49EVtI7WzIKyfEZgWFXnKaMEkVGNF6X+hkFhKE+mvaVJhMNS5
	ErAQ8nl3+GteogjbVIKBGjzjp/8UhVQZsaDybltffCwu9SMDlpiKJDo2ZlopDFMVeKZoLu8vLNI
	0wPZVZHUlaU8WJoNPuy5dIRW+3Q5bfSFXLgBAyWQlX+pIOGnIbZLHFVJ/KMNDVxoQTipc=
X-Received: by 2002:a05:622a:1993:b0:4ee:1903:367b with SMTP id d75a77b69052e-505d214ba65mr150834861cf.5.1770045143271;
        Mon, 02 Feb 2026 07:12:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bb9d21sm106856261cf.26.2026.02.02.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:12:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vmvbB-0000000FJuI-3Zxp;
	Mon, 02 Feb 2026 11:12:21 -0400
Date: Mon, 2 Feb 2026 11:12:21 -0400
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
Message-ID: <20260202151221.GH2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
 <20260130144415.GE2328995@ziepe.ca>
 <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>

On Mon, Feb 02, 2026 at 09:42:22AM +0100, Christian König wrote:
> On 1/30/26 15:44, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> >> On 1/30/26 14:56, Jason Gunthorpe wrote:
> >>> On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> >>>
> >>>> That would work for me.
> >>>>
> >>>> Question is if you really want to do it this way? See usually
> >>>> exporters try to avoid blocking such functions.
> >>>
> >>> Yes, it has to be this way, revoke is a synchronous user space
> >>> triggered operation around things like FLR or device close. We can't
> >>> defer it into some background operation like pm.
> >>
> >> Yeah, but you only need that in a couple of use cases and not all.
> > 
> > Not all, that is why the dma_buf_attach_revocable() is there to
> > distinguish this case from others.
> 
> No, no that's not what I mean.
> 
> See on the one hand you have runtime PM which automatically shuts
> down your device after some time when the last user stops using it.
> 
> Then on the other hand you have an intentional revoke triggered by
> userspace.
> 
> As far as I've read up on the code currently both are handled the
> same way, and that doesn't sound correct to me.
> 
> Runtime PM should *not* trigger automatically when there are still
> mappings or even DMA-bufs in existence for the VFIO device.

I'm a little confused why we are talking about runtime PM - are you
pointing out an issue in VFIO today where it's PM support is not good?

I admit I don't know a lot about VFIO PM support.. Though I thought in
the VFIO case PM was actually under userspace control as generally the
PM control is delegated to the VM.

Through that lens, what is happening here is correct. If the VM
requests to shut down VFIO PM (through a hypervisor vfio ioctl) then
we do want to revoke the DMABUF so that the VM can't trigger a AER/etc
by trying to access the sleeping PCI device.

I don't think VFIO uses automatic PM on a timer, that doesn't make
sense for it's programming model.

Jason

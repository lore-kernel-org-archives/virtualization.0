Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6D2E62B7
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531279; cv=none; b=U5mYFadByWQ3hM6DLM32mdCdmgK/4KG5RI7lCCPc0yv1NcDt9pQVxbMoCdNNVfSAuFEXVWPFERE3bYyjOHYJZXNbFhuUS+So3KEaqXYS4SVwTcrped3+5k7RvGagiJJVI9/z92smhuNhB6DsUcvyFd7gLLs61qciX9Z8HBPEU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531279; c=relaxed/simple;
	bh=EzvzbPpROKuqvVQCoJHluXwjW5pJqoCNcXzstaHV6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml7Nv0JGFC6gsOesN8hHFZG1rQj/f8aqY6ZSGVaB7c5Khz0o7zlbQz/o6HQ57YpVgJTePofJAYltfQ6iRuIlYr6RHDO9jEN9msCtIWU4ri2hRtexsFlaSYvZrTF6cL0OIO+EheDt5hABWXx0N+tPoDpHcKAZhejRq5F+SA6lLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QbHzJ0+s; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QbHzJ0+s"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501469b598fso44445071cf.3
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769531276; x=1770136076; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=QbHzJ0+smE6PhWIo5Phi+Yhw1URDugVYWz8I2pHz3ogvOciXOu16vdGuRjbo6cIktn
         asFrAlE1agEkgOq2/mNuDG/lNFaZx19I4FmDtRWquEC9V00/iVUR4j2CN4p3KScJfZoe
         thZwHqqxueRVgCOnY1JDLCsHf9NX8Ls9nlQP20rt2E2c48SeGcRdU3kTdrGMEkiUsU65
         9xhgki86gRDZJseNbd9fsP2ugtSg2aSXm5CATMkR8UTifJeKPkSfdxnYh5CiRlxMp2/E
         pOWkvmLKEH4J5bv1cuC/n1526dRrdC9ZoNhH8zhzII1N4FOh7ZDD6ewI3LQL9W6Nhosy
         XGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531276; x=1770136076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=KsvdX9tkrOvIeRFSvhI+4tpOMNGVd+RvnsxJljenLkLv6Z2GRnAdeQCGPZBslxoG/q
         u0QunkfhFFztbkX55o/91lY4ZbT9ZeH41CAJGxUxCMwL/+AzDVVl/3mcqlL3G9vBPBXy
         vVYJtrtayppC+xQm4U3IlpEl8kdfHgGms4af/tuBvQwzBu9nggnyn6IWzGlw8sC1B14S
         jFmVjaalyfTE2ojQyMAOxaTPec6eWm4LgpaQXe/L+DbGboGd70H+b8Pc6thPi0KjYG+P
         Fg/7gnni40FvmOjTdQz+qNzPSfBXr/xLxZdH5j4im3e7sPpMW6DwHPUmdcvELpSqP2By
         Nn7w==
X-Forwarded-Encrypted: i=1; AJvYcCXop2QuCtayDlSqeciWCgY+dJy0/4alvyfk/lBo6DfP5OQCrC0XrmaE7TiPclVwPWDCZcYnq3KdkZ9dkuYp4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHGTyqHfiGWLGA3wZsb7KukQ2cTrWNWWSB7AIUkgJf6sGx2TwR
	p2p04Grwa4H/B4v+acsWv8Kw47e6T+fkJD7YcYazOkrZazLyK1h7HTYzkn+YT0BFBZk=
X-Gm-Gg: AZuq6aLdpuqJgtWdJSrcDK1/anHdN8gxPt0FWG29t5RZmk9tPtqYa4WvG5xyRsRVIjK
	ZX3sQD24OhPlkFvVh9bthfb8R32W2PbxwvyLmOns96Y2cJAWmJPTvNzUFRtyvsC83+HwmtNrIcs
	2TDWlsv+GNmbDh6vwqtkS1X0Oasu+FnNooDajIeFr6TDHuZm0FQSgTgu0m+1PeIkGoFPAvavfKX
	qVHd2nK5TRbHhkR5gNUHiWgMSXam9IkhPkvUixqM2LSQt/V6bN7eWNFHXaH1rw5gUdhB5cM1xBh
	XB4Tjb4r7dyEUknfWEe/AK6weOpCB11JC0CUMv3Q7l8qWRrJPV8/qho/ck5H3tudcT0DHmJtuA8
	/NDg33Yom54AG0FT05WiXaRBVN2fjavtd6cRR/2bEPghZ895gSKRQIxfNirE8rHeodyAE3ZN2DT
	hddwflfvoEwPGZDQivKEN9lHpLHIe/KvBn/G/ebK/mk4qUHXDvseQ29Mv7IQO/ARd4bjtnviadp
	qKcUA==
X-Received: by 2002:a05:622a:612:b0:4f1:ba00:4cc6 with SMTP id d75a77b69052e-5032fc167d4mr25702421cf.79.1769531275530;
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502fb8e74ebsm102277581cf.0.2026.01.27.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vklv0-000000095Ys-1TUe;
	Tue, 27 Jan 2026 12:27:54 -0400
Date: Tue, 27 Jan 2026 12:27:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
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
Message-ID: <20260127162754.GH1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com>
 <20260127085835.GQ13967@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127085835.GQ13967@unreal>

On Tue, Jan 27, 2026 at 10:58:35AM +0200, Leon Romanovsky wrote:
> > > @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> > >  			dma_resv_lock(priv->dmabuf->resv, NULL);
> > >  			priv->revoked = revoked;
> > >  			dma_buf_invalidate_mappings(priv->dmabuf);
> > > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > > +					      DMA_RESV_USAGE_BOOKKEEP, false,
> > > +					      MAX_SCHEDULE_TIMEOUT);
> > >  			dma_resv_unlock(priv->dmabuf->resv);
> > > +			if (revoked) {
> > > +				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > +				/* Let's wait till all DMA unmap are completed. */
> > > +				wait = wait_for_completion_timeout(
> > > +					&priv->comp, secs_to_jiffies(1));
> > 
> > Is the 1-second constant sufficient for all hardware, or should the 
> > invalidate_mappings() contract require the callback to block until 
> > speculative reads are strictly fenced? I'm wondering about a case where
> > a device's firmware has a high response latency, perhaps due to internal
> > management tasks like error recovery or thermal and it exceeds the 1s 
> > timeout. 
> > 
> > If the device is in the middle of a large DMA burst and the firmware is
> > slow to flush the internal pipelines to a fully "quiesced"
> > read-and-discard state, reclaiming the memory at exactly 1.001 seconds
> > risks triggering platform-level faults..
> > 
> > Since the wen explicitly permit these speculative reads until unmap is
> > complete, relying on a hardcoded timeout in the exporter seems to 
> > introduce a hardware-dependent race condition that could compromise
> > system stability via IOMMU errors or AER faults. 
> > 
> > Should the importer instead be required to guarantee that all 
> > speculative access has ceased before the invalidation call returns?
> 
> It is guaranteed by the dma_resv_wait_timeout() call above. That call ensures
> that the hardware has completed all pending operations. The 1‑second delay is
> meant to catch cases where an in-kernel DMA unmap call is missing, which should
> not trigger any DMA activity at that point.

Christian may know actual examples, but my general feeling is he was
worrying about drivers that have pushed the DMABUF to visibility on
the GPU and the move notify & fences only shoot down some access. So
it has to wait until the DMABUF is finally unmapped.

Pranjal's example should be covered by the driver adding a fence and
then the unbounded fence wait will complete it.

I think the open question here is if drivers that can't rely on their
fences should return dma_buf_attach_revocable() = false ? It depends
on how long they will leave the buffers mapped, and if it is "bounded
time".

The converse is we want to detect bugs where drivers have wrongly set
dma_buf_attach_revocable() = true and this turns into an infinite
sleep, so the logging is necessary, IMHO.

At worst the code should sleep 1s, print, then keep sleeping..

Jason

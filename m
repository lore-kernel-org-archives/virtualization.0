Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A22D6E74
	for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459937; cv=none; b=Eme2BEx9wwcSjHZGFRiYNpyu2OqbVQvOxHZ+/qc26sCI1a6wB8D0zIrog90EERrA+tKlqRNINp7Mi2UsuUO97TH/1d/1Wm3bmwdT9M1cgx9OltP416kyzPK1CHGTKKHgXdTmEZr+JyNswm6IX3tlMNwEjbqs2ogheoRVqGbsLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459937; c=relaxed/simple;
	bh=ReePk5ebIABc/04zyOJasPQOtiwxWbIgDXrD19pnIPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDAePSlXw0U2Rn7myW1W4bJZY1Q5fUuPS1Flgcns4YW6q1WqiiLxVBqAkaa3oF7YPRec3iwytx3oJb1h2rI6v7g0B1K3lQbMlJ7Fxbfv3rgjQS3ZPRxq1t21Ky8oNXwurFR4pVN10azL5YGeIihyaxXSHMzAumkZLdUYQjceqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wgG4lN5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wgG4lN5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a35ae38bdfso1705ad.1
        for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 12:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769459934; x=1770064734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heQW4XXGxVNpbsMWtr+Uf/Qjg2mRHLgzAq6EBq5z5Gc=;
        b=3wgG4lN5S20A42o/e7sgVg1a+cStHF+a/1Vhl5H68n+GDVfScQ+ZXwW1tU9siI6LFm
         WpGX3IJbbSX2DzLMXeeQmD2fRMfji42IB2n/LOJjbWaRNA1s2lqog0wpuclOs5Q3b6Cq
         apJlgEgRkMGzNf9lff/95+L4gawsTFNo2N42tesP0IJibqwtD98K2Uiir+m3OG8ShNXa
         wyhAEkIrXc32hwUT23qMhkDncPfp2F0QTN9DogpjibQd3eFpZHbCQF6YvCI5En3hZSFR
         eLtzziJU0JpJh1mlj/oiMYy/NELGW9QaeoSEAdsM7sYBSL4eWescffE+OHuH61jwWh+f
         NFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769459934; x=1770064734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heQW4XXGxVNpbsMWtr+Uf/Qjg2mRHLgzAq6EBq5z5Gc=;
        b=ftTCpnuq5uEo97YZfjZ/s19vrAcXWXQxgvriGupcoQjy6MWlFlRPVwNwIs1teyzAB8
         vEawe2MVFIPex/nxR/jHTHJdj9JWDUYl1spVa6Y/JJ4/7ZX2/VdDlvAcspoFVo4SDONN
         QVCFDhTSujdcw12W7k+smrBh1Q7kC9StkR75JI3Qvl+ezcwALlxMPxjPjiKp78sAUKOW
         JtJDhOmtaCCnm9/TXft6eHN+d71MM2c4P9XJRaaxY4n21IJeGqF4DZsjpgUrQMLMxkUC
         edp+MpPPFvuRh1a0hOi6dbMm/uTvUluhLETaRXIak3R8++//wlq7IOrWguamxy6RTMtH
         +Buw==
X-Forwarded-Encrypted: i=1; AJvYcCURCnH1u8pBkcYvZESigprqOwPK1TitnTWSXYv0FChf5h6waz4KV8Ufrx3yeTsDAIYRcuxrPheYULJPXdHJeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbKmiU1dYn6uwEbo9P2mnlE+icb0yZluuHN4knAN3wbaRva+AN
	RsN2i7vN8MtNHP2o2l55V5HPfHy3jMClqFoyuTswy9uuy0wALPsjuW2xYuUcNCt5wg==
X-Gm-Gg: AZuq6aLt7e+sMJBee02vQ2Iu4rTEO+AKIh4wZasBVC7ABC+74oEZFm68bf1TkqeI+qE
	zbPp1RNyNT64wAADzF3Pd8If2ZzyLmN1TcazcJGxF2+GkgFS4K/XLUsZfBt7Zeru6Pm8QDBHrzt
	627Jr2X42dQzAusivB57qg096P9iF6c7Kxn617iS0F48M1UtqNl+4yoTi0VgaUdZ3wXjeAaNdVf
	DSYUmd3zDjWeBObmMAvWVaL0QN3DSacn2A6V0CrdW0n8knAST2UdXAvnM3ct2E0lCzjGGH7he9H
	QEoiAO9sXhp5XNbpPOK4uxxcXxvo6B4fRDSU9yhwLUAmDOEfIy7dQIgxjoW4xscIzV7psghTrSm
	ADhmJ8wuEwbyzkl5y+Re074ZhaNP+HHgLd/QUNAU5cUw+AS5WhTcTp/QzFlwt7oAFdv4ffw2Lgs
	BWXU4hSR+eyqG6ZcIu06GZa634pboVwf5H/mJ98jQy0PiibfMF
X-Received: by 2002:a17:903:32d2:b0:2a7:7f07:340e with SMTP id d9443c01a7336-2a844901809mr3288195ad.4.1769459933510;
        Mon, 26 Jan 2026 12:38:53 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdce1fsm94536115ad.101.2026.01.26.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 12:38:53 -0800 (PST)
Date: Mon, 26 Jan 2026 20:38:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <aXfQ1LFNDUrfeuHf@google.com>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>

Hi Leon,

On Sat, Jan 24, 2026 at 09:14:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Some exporters need a flow to synchronously revoke access to the DMA-buf
> by importers. Once revoke is completed the importer is not permitted to
> touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> DMA-buf today defines a revoke flow, for both pinned and dynamic
> importers, which is broadly:
> 
> 	dma_resv_lock(dmabuf->resv, NULL);
> 	// Prevent new mappings from being established
> 	priv->revoked = true;
> 
> 	// Tell all importers to eventually unmap
> 	dma_buf_invalidate_mappings(dmabuf);
> 
> 	// Wait for any inprogress fences on the old mapping
> 	dma_resv_wait_timeout(dmabuf->resv,
> 			      DMA_RESV_USAGE_BOOKKEEP, false,
> 			      MAX_SCHEDULE_TIMEOUT);
> 	dma_resv_unlock(dmabuf->resv, NULL);
> 
> 	// Wait for all importers to complete unmap
> 	wait_for_completion(&priv->unmapped_comp);
> 
> This works well, and an importer that continues to access the DMA-buf
> after unmapping it is very buggy.
> 
> However, the final wait for unmap is effectively unbounded. Several
> importers do not support invalidate_mappings() at all and won't unmap
> until userspace triggers it.
> 
> This unbounded wait is not suitable for exporters like VFIO and RDMA tha
> need to issue revoke as part of their normal operations.
> 
> Add dma_buf_attach_revocable() to allow exporters to determine the
> difference between importers that can complete the above in bounded time,
> and those that can't. It can be called inside the exporter's attach op to
> reject incompatible importers.
> 
> Document these details about how dma_buf_invalidate_mappings() works and
> what the required sequence is to achieve a full revocation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/dma-buf/dma-buf.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma-buf.h   |  9 +++------
>  2 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 1629312d364a..f0e05227bda8 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1242,13 +1242,59 @@ void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment_unlocked, "DMA_BUF");
>  
> +/**
> + * dma_buf_attach_revocable - check if a DMA-buf importer implements
> + * revoke semantics.
> + * @attach: the DMA-buf attachment to check
> + *
> + * Returns true if the DMA-buf importer can support the revoke sequence
> + * explained in dma_buf_invalidate_mappings() within bounded time. Meaning the
> + * importer implements invalidate_mappings() and ensures that unmap is called as
> + * a result.
> + */
> +bool dma_buf_attach_revocable(struct dma_buf_attachment *attach)
> +{
> +	return attach->importer_ops &&
> +	       attach->importer_ops->invalidate_mappings;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "DMA_BUF");
> +

I noticed that Patch 5 removes the invalidate_mappings stub from 
umem_dmabuf.c, effectively making the callback NULL for an RDMA 
importer. Consequently, dma_buf_attach_revocable() (introduced here)
will return false for these importers.

Since the cover letter mentions that VFIO will use
dma_buf_attach_revocable() to prevent unbounded waits, this appears to
effectively block paths like the VFIO-export -> RDMA-import path..

Given that RDMA is a significant consumer of dma-bufs, are there plans
to implement proper revocation support in the IB/RDMA core (umem_dmabuf)? 

It would be good to know if there's a plan for bringing such importers
into compliance with the new revocation semantics so they can interop
with VFIO OR are we completely ruling out users like RDMA / IB importing
any DMABUFs exported by VFIO?

Thanks,
Praan

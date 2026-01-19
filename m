Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041531D39A
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841066; cv=none; b=A6UTRZfJp1nZSiqcsZVsJwrHIsui65nnbAemVCNxmw4iyTeLfaL+0cPLKbFDte52S8LIyI4WbtZxIe2VVcBL/bWGtiNnmdrkP8JkfyXdCNHr7Xjw4Ub8GeeJ40hDhnCWdvrnTFjEreKodkp+Qz8K2Jt5e/hnabAPeTsdXd94GbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841066; c=relaxed/simple;
	bh=Bnp3gemiqQAFqwPr305DyvhcAz0o+HO4/eTH34cXlNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuzAYpyQ0QpsD5l8rLW6xdv2uVd9oHXJy0oVJ7e4pLccqqKFXC5QVP9w/J0Xt1qg8FXNna2/tQAQT0ie2GG+nm+JA0zzwI/YSZBh1dHaUj8ZAVpHiy5OMnmeKH4fDDan449o62vhGvKEyDw0GRufduL7JHKJk91gww1TV6ozyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZRn6J2r9; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZRn6J2r9"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014b671367so56784731cf.3
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841062; x=1769445862; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7mLdSjko9gcpWp2LFuEj2HWiy0Q3Aa6qTfE9JkGPgsY=;
        b=ZRn6J2r948twTnMWPUQ+8DL86/zB14MfdGra4+af7MuPW/6pJyjm2U9uu2h3FZQPD5
         cyR9V5VUj7232F/CeYJXfGdNMjXwaXogUy9LyNTkl2pJMily1qfABBSvrZ5rsf07j0Ea
         dyNVXiYJZVRNDNPA0l/PqxW6pFci6PuEcK+DtqgoTnEefw83SI8Xy/Gm64lWZEXKOgWR
         tjpY5ZkNRCGASOrjSuUo9AJ4LgYIvnkfmQiZ8rqx2t70+8aTDMmJujwc0R2JBWlvkI0F
         ciYAIjfXEqVa/QukhOZmVNTGGFR0gukBDi1x5Bis5z+w3G4xTo6CSEc9HGrlNwdedGa/
         ws9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841062; x=1769445862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mLdSjko9gcpWp2LFuEj2HWiy0Q3Aa6qTfE9JkGPgsY=;
        b=eMQLw9AatqGrXMuFSEpazjp037BE7hozJwULFP9e2d4V656wK36sm0Fe1TjTWyinEB
         LJPFm6hTl2g5TsqGzfTxol0n+d15zXZJhZ9qTdPLjm05J4kngEE/Hy1OtZdfdmZUhds4
         ZCPgeyM5VTciejzuisVsRPi3Hc2MCNZr7b2SQtF+sgotMxQuFFrgEg4S9PqjR9R1eC6q
         eIwC+IDeys7miBMXwVZl3ioI+xB6tRlfk6UI/O1FZoFZc2gWO4fQDVkc/i5x06qvBG6F
         oUOPsob2VMgS6eL3a0TB3CXe2BhSVBgckK2EMlZH8RUPlEDHHdMADyVPkc8V1uCaR7Ai
         2wBg==
X-Forwarded-Encrypted: i=1; AJvYcCXZY5PNMc68QfYQLq/mWrwNfe5aQ9KKhsZZwqYiB2MJEimfZyGRQkDkzENlpa8/IAVahzCInDFX4JFV1oaBHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5NXRE6unnlbv3vAUQt2ZNjX35nDU1M6Qhztl8/gb9LxvCGoRE
	1zKz1Om9qadprXZUoOsB+8a68uwc6gw8MPwhjIq4sPMbNY5PO7O7eJqUVsGcLkPvNrk=
X-Gm-Gg: AY/fxX4WH5ngkg1zvM/kWFaHrEd68jG/ssn5C8t96WuHUNRHDmpD12lWV/kWpcy+YTC
	/LVz2J0E9cI6pNXWZPaTdqdk+/0fB/AsjOf/PX0j3c++MB3A3kM/SSyQ2Vq3vvhObyQUfeS5reo
	xuZm+Rl20tRghBFcvSb62b5NmfKlXVnPhtkIXOjeMUly9LrnSmothfPQEDquP4COOGE90fFutan
	qk3s8TJj1LGp2IUwiIBwNrbZCDyrHRA3Pr2ZmnQMtUyTvMcFXWIgvZThYzNK0f9VPHO8Zbbppvk
	u5tK2UvU/YUMukzo/wYVAse/vf/u2LP3Hnlz6GFeF6EjoygJ/ruPj1D7AVtfdZG8J/HRQfBOjxt
	KNUIqMgUVL0LrKqFH1AmEvNR/X3Fn3AgsV7hXZmAnCxRQFPysaLvcnWafrLow5QzQ/hz5EVjqIs
	1qvwpG9JXa1iH2X504dWUlAwbo5k4UP7DrRny7oG9wWgRZbTa4rAda9LNTSw3qD5y6Wq8=
X-Received: by 2002:ac8:7d16:0:b0:4ee:1b36:b5c2 with SMTP id d75a77b69052e-502a1f87eb4mr182498161cf.68.1768841062394;
        Mon, 19 Jan 2026 08:44:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ed3155sm72779401cf.19.2026.01.19.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:44:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsMX-00000005IKH-0ezs;
	Mon, 19 Jan 2026 12:44:21 -0400
Date: Mon, 19 Jan 2026 12:44:21 -0400
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
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-buf: Document revoke semantics
Message-ID: <20260119164421.GF961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:46PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Document a DMA-buf revoke mechanism that allows an exporter to explicitly
> invalidate ("kill") a shared buffer after it has been handed out to
> importers. Once revoked, all further CPU and device access is blocked, and
> importers consistently observe failure.
> 
> This requires both importers and exporters to honor the revoke contract.
> 
> For importers, this means implementing .invalidate_mappings() and calling
> dma_buf_pin() after the DMA‑buf is attached to verify the exporter’s support
> for revocation.
> 
> For exporters, this means implementing the .pin() callback, which checks
> the DMA‑buf attachment for a valid revoke implementation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dma-buf.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 1b397635c793..e0bc0b7119f5 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -579,6 +579,25 @@ static inline bool dma_buf_is_dynamic(struct dma_buf *dmabuf)
>  	return !!dmabuf->ops->pin;
>  }
>  
> +/**
> + * dma_buf_attachment_is_revoke - check if a DMA-buf importer implements
> + * revoke semantics.
> + * @attach: the DMA-buf attachment to check
> + *
> + * Returns true if DMA-buf importer honors revoke semantics, which is
> + * negotiated with the exporter, by making sure that importer implements
> + * .invalidate_mappings() callback and calls to dma_buf_pin() after
> + * DMA-buf attach.
> + */

I think this clarification should also have comment to
dma_buf_move_notify(). Maybe like this:

@@ -1324,7 +1324,18 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_sgt_unmap_attachment_unlocked, "DMA_BUF");
  * @dmabuf:    [in]    buffer which is moving
  *
  * Informs all attachments that they need to destroy and recreate all their
- * mappings.
+ * mappings. If the attachment is dynamic then the dynamic importer is expected
+ * to invalidate any caches it has of the mapping result and perform a new
+ * mapping request before allowing HW to do any further DMA.
+ *
+ * If the attachment is pinned then this informs the pinned importer that
+ * the underlying mapping is no longer available. Pinned importers may take
+ * this is as a permanent revocation so exporters should not trigger it
+ * lightly.
+ *
+ * For legacy pinned importers that cannot support invalidation this is a NOP.
+ * Drivers can call dma_buf_attachment_is_revoke() to determine if the
+ * importer supports this.
  */

Also it would be nice to document what Christian pointed out regarding
fences after move_notify.

> +static inline bool
> +dma_buf_attachment_is_revoke(struct dma_buf_attachment *attach)
> +{
> +	return IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY) &&
> +	       dma_buf_is_dynamic(attach->dmabuf) &&
> +	       (attach->importer_ops &&
> +		attach->importer_ops->invalidate_mappings);
> +}

And I don't think we should use a NULL invalidate_mappings function
pointer to signal this.

It sounds like the direction is to require importers to support
move_notify, so we should not make it easy to just drop a NULL in the
ops struct to get out of the desired configuration.

I suggest defining a function
"dma_buf_unsupported_invalidate_mappings" and use
EXPORT_SYMBOL_FOR_MODULES so only RDMA can use it. Then check for that
along with NULL importer_ops to cover the two cases where it is not
allowed.

The only reason RDMA has to use dma_buf_dynamic_attach() is to set the
allow_p2p=true ..

Jason

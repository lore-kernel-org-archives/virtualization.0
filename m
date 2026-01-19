Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D729AAEA
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841927; cv=none; b=JWYk9JEJKRTwgiWc4VwYnBgaoanIMN3qSwY1nTp+j6lSMgT0D/EANoETZpV21o31TTC3+1D8+wFdCmek2mxahcn+wymsaqNITc46thrfKBwvI9JmYt6XwqtBMtePb3UxktKVVexqsQn7exgz2fLVKrVQ6cObhq+WmEztcGbJ8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841927; c=relaxed/simple;
	bh=nsqjKuZBX2xVAZ9wDedc6M6Km3uKRKGPzdUMml50yUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZ740WU52A04hPtdRYekZNX7olBhc163OG2+uoAedvxv/jvf1ozWYUn4elJLBxNVJcGyMS0V+svDYVem397DayhrWC4wRaklyTy4BdY0Wm8GOoUSwUUqOJLoN4X7ErnjhW9UOyK+TdVpls7Xrza2RyxnvmAq7TmxMuQFUF1iCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uw05Wsf/; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uw05Wsf/"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2d21427dso33403886d6.3
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841925; x=1769446725; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=Uw05Wsf/Lc8IguIUTL2YD/c5r+Q2RvrG2Bc/Lp0rz3o5BWVspqfLA8gdH49QhZz8zS
         TUBG0GQEN7yFe0sijHdZg/PdiJQztbudTQE4HJo9uuEnkUjSgeedstsxRsas0lVcP9IS
         5O/aute2UfGVpUnkey3ubXo3Ks6QRpF6PAOhKNFrs+kvszqPSePBK4KbJHFafdWhOTJW
         5mco/3yq5O6cqm56AjzGCs+wMyPfFoQMlSOod36XbCjDjSPbDti8sD7D5BT9w6qxpHA8
         GTihGLFgh2PmazMbBPX3S07wHh83Q0RAjmnhtk3Jbc6WQRVl6LF+8tfLmh8vrMlrM75M
         4SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841925; x=1769446725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=GIfkwgGZdHXPpDPBeJ3YLgf766NItROxLXFEOqXMH1s74rqQebujcu4/s+jofvJuvW
         utryfBbHYLM0SQN7OPFC0hji2SIaqfq5JOYyqVNqrQqfJmaZHicjh5cmN/xcMiHrdw+Q
         zKYrxr89ePIjvwxNLP/YDJ6HdBjyUaXXfYX5enu4kUrv8YeJ8sMA8ZeM3PEQubeu+vNI
         ejoq+NVCloA4uxjl6JPSj2dhNVCobYOAq2Kld7H0Kgzz/HBLz6fKQDVgkDCsdGDZ5qS8
         XTph3U0l2J1jK+I65EwaX5713YOTyIXPwqZbFL6aYZ+YUYLggirjJdreexJenWe8wCoP
         m/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvdn3vG8BrP29KVjZC+P9aU0dZv7F0Xd9K/ZaPd6f/fualeHiwiC+0xwgDX0pm7/GDepPiyRIdiEPUHtsQDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXKwD2H/yzFVhUfZ12phc+XidjDhfF5cxbv7qmza9ijvTfeDyg
	JBTM5EVakbntneZxYHLz37tJgjnuT53eVnjxqmLH0QCOFj9sCKwPDu8ukhL7fMn+WH8=
X-Gm-Gg: AZuq6aLbcIRKDhcvnakP2WN2qz01xhRlCI1mR1cLAl4tXndT3FEkhSsG5TrqVuBhPhm
	ZRdmk4urxVIWpGSaPzhS7ZoDSi24ihKnC2gMeXmoal09RSyftIbqn3jo0/5yskIZdKUoCFu22Nr
	JEbaTjqhwlQk/4x1sN70m3serhV30WBRxm+4vxlWTtv1BNMjv0nIdNvYQf8I6PGy+t0gSSy+57z
	dAuyGK3dvQEpcIWaBu72X0NQljhMZkvyERNdSM8b3nEvIkfBcbPCwkf7VngLEMsGK1dBEgxBAts
	jQCWpe/b94MgYEamJQEsSvKEMyoiQGOA78FFCkJ+uDJfEDZ0Uf8hN1JssTxeDON3SAOB4Pn1tpD
	aB9FDOLThjB4ztwtyQDOAI7nkH5x8ewgwyPiNSvqUnhwrBs/KF3eA9qZBRffgAdOCYtBEGL0rAg
	7vBWjxu40EhryREsg13GAZHv+mLy4Iv/6JnWj9ZcjQtnamP1bwSCUDzdRQLXFudjsxO+N+B2sC0
	lopwg==
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id 6a1803df08f44-8942dd9e90fmr129930286d6.57.1768841924690;
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e526dsm87021366d6.12.2026.01.19.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsaR-00000005IQb-2Wqn;
	Mon, 19 Jan 2026 12:58:43 -0400
Date: Mon, 19 Jan 2026 12:58:43 -0400
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
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119165843.GH961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:44PM +0200, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Changed series to document the revoke semantics instead of
>    implementing it.
> v1: https://patch.msgid.link/20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com
> 
> -------------------------------------------------------------------------
> This series documents a dma-buf “revoke” mechanism: to allow a dma-buf
> exporter to explicitly invalidate (“kill”) a shared buffer after it has
> been distributed to importers, so that further CPU and device access is
> prevented and importers reliably observe failure.
> 
> The change in this series is to properly document and use existing core
> “revoked” state on the dma-buf object and a corresponding exporter-triggered
> revoke operation. Once a dma-buf is revoked, new access paths are blocked so
> that attempts to DMA-map, vmap, or mmap the buffer fail in a consistent way.

I think it would help to explain the bigger picture in the cover letter:


DMABUF has quietly allowed calling move_notify on pinned DMABUFs, even
though legacy importers using dma_buf_attach() would simply ignore
these calls.

RDMA saw this and needed to use allow_peer2peer=true, so implemented a
new-style pinned importer with an explicitly non-working move_notify()
callback.

This has been tolerable because the existing exporters are thought to
only call move_notify() on a pinned DMABUF under RAS events and we
have been willing to tolerate the UAF that results by allowing the
importer to continue to use the mapping in this rare case.

VFIO wants to implement a pin supporting exporter that will issue a
revoking move_notify() around FLRs and a few other user triggerable
operations. Since this is much more common we are not willing to
tolerate the security UAF caused by interworking with
non-move_notify() supporting drivers. Thus till now VFIO has required
dynamic importers, even though it never actually moves the buffer
location.

To allow VFIO to work with pinned importers, according to how DMABUF
was intended, we need to allow VFIO to detect if an importer is legacy
or RDMA and does not actually implement move_notify().

Introduce a new function that exporters can call to detect these less
capable importers. VFIO can then refuse to accept them during attach.

In theory all exporters that call move_notify() on pinned DMABUF's
should call this function, however that would break a number of widely
used NIC/GPU flows. Thus for now do not spread this further than VFIO
until we can understand how much of RDMA can implement the full
semantic.

In the process clarify how move_notify is intended to be used with
pinned DMABUFs.

Jason

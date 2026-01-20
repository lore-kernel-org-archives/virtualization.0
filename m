Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC3207DE2
	for <virtualization@lists.linux.dev>; Tue, 20 Jan 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914935; cv=none; b=D9fxl2DkLRk4YZePKTMBedmGUzgqXjc2VpRJwkrsRy32VsJ8kaXuw4b9ZhN619HRXS0nQRg3jKnztWkHj46yHhZ/SKJpYr7JevUOWEXGS34ok9MQXnM9tXXoEsCrQab+Rz/AoIoRKhFKlO18xgfLctaOkPUrkPr/qi+rwU3sWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914935; c=relaxed/simple;
	bh=xnk/b5HPpyfNnMbI+XkeyZX1b7NurY2cBOv/ZUy0nkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjNQ7kVDw0ogCdPxrhK7DvvdNun+W0jbWSjXWOoxgR6iaAW+dtsKU2sSk9gxlmLmIoaCODBzVxxgMw2c0tGV2X8tK/6A7suMHuNgJ9n6IqKG4b53R4kZMIfBtU4LtQHc/T1r0/t4tHPMZwNam1n47oALvVFxDLH3DSYPsLMPukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jm7unndh; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jm7unndh"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c537b9fcbfso545061385a.1
        for <virtualization@lists.linux.dev>; Tue, 20 Jan 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768914932; x=1769519732; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jl2KF0othdvrwDImGzxJcxoX7WKdbBXFC823mMEO8nY=;
        b=jm7unndhDNAJ8/2HjH/H0Tl1pgoYi/yICriEfNtcyQgjImHo02ZwAOr/PjrAcvaeEb
         WXJE9iH7aQEFmdeTQ5T283uelYjIXZST81+PvyCwK7yYCahnCBselZris2Ka3PtBFm70
         crwKZ5UuqZfHVFL3d+kQcxQn+/siJcMFRuwG5Ri9svaNuHfrVY+nxcnY2nVJiuGnBQJ5
         ZyR5iZQD2rHAdLKP+mnbWepAEw+dkEcyaEdw+guSnwvehzeqojZcSCULLs2iOHswkwJy
         Di9eQbdHuHlDnnIy0Ux6k5SUZffH9U3ewkFVfZ0n6aMExVieVBAs/WITJC2T8PtZV8ch
         5i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768914932; x=1769519732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl2KF0othdvrwDImGzxJcxoX7WKdbBXFC823mMEO8nY=;
        b=QxdxSQaIL20kJgpeWOkYVq3LL1uZDJ7J+1i/El0BzUbGKqmRijs+E4+1EIuROxwv34
         TjynCW47cAkvvfLQojxUYnn0vuBjVtMg/4Iyvk7yuVdMZMu9HRfPpX3YCd5akhttrJ7b
         YIX53EmmjKRC/s01zZIpG9ncZLQkQ8S8aHIUvOETFWZdJgJbtTrc/0ATAp9JUi8phEOm
         4IEwatWXDhELUeNsd0FgT0rUETG7B0zEPmZOvHapkMRHE2hXUq52BY7m68OI7dcibsgH
         dLYpZdS8vZdqQI+7sxP5zXJNlAb2GbYYO3ZPmoiBuNCYhcfL9rFE12IS4HCbpeCyfA/3
         7mTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9G13oNexNhRWytDjhoVdCYdFkWIZ59K3vy2rRSZL16gpX3AGM6DL6ysPVrviV7DbAB/GAfjGYFO6EchI8VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFUyzzfeOWRTnCJ6AYdvfeddealr116gKNG/WdsLh/WX1lgn+S
	PeyKOVZR0quBhD53h2ibPsnJlU9PG7i0AFOgDTcp6qzaDH9PZq91shQO/9c9oESPFSA=
X-Gm-Gg: AY/fxX4XCd32zaVlslmmI2O4hYkR5uS3Hsou1LiXhTIqtwucnXbY3csPQVZrJIPCrAE
	mxPKv2WtsHGJIOF7Pdo4Iru5kqXwHYYeH0rwaGU8/MgDPqTUwt1DT67ium21FbK8tHd9G7JqKZA
	9FmFhkMxxOHUbOt9on6GwwK1o0bNhq/NxX5glFhQNQzXfthPXyLMmxSQImJmsh94go7ApZdFW1N
	5n3qmu4Y2YXAB2ApSrsrnMouLPbxWJp7Y8SGJYwdlY5rrRIBvotOShEpGsGH9mlmF4Edo89Hbjx
	Vx+r5vH+GApwMOiCCGK2cyrD+WxVjp6d5GReQkCPKMN+R3WS6uhQjEk7+NPK7GHkU0gkGwylZ/c
	ydSkoGTaTK1aqEzb7/3wZE0YB0Rx5AiUG8RasJmt/NT8wlW1mPf3IyDQ/1lVzq/zOlSL6Y78f8T
	2ov/Yn8M/WgHADl63Qz7EZoYmPk0QNTw7u6Rgc+j5qjm+cTO4AyB+13CPgoyOxJJqJBIg=
X-Received: by 2002:a05:620a:999:b0:8c6:a68a:bc04 with SMTP id af79cd13be357-8c6a68ac1c8mr1389837085a.7.1768914931884;
        Tue, 20 Jan 2026 05:15:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7292cfbsm1017788585a.50.2026.01.20.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:15:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viBZy-00000005W6K-36CW;
	Tue, 20 Jan 2026 09:15:30 -0400
Date: Tue, 20 Jan 2026 09:15:30 -0400
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
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260120131530.GN961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
 <20260119165951.GI961572@ziepe.ca>
 <20260119182300.GO13201@unreal>
 <20260119195444.GL961572@ziepe.ca>
 <20260120131046.GS13201@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120131046.GS13201@unreal>

On Tue, Jan 20, 2026 at 03:10:46PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 03:54:44PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 19, 2026 at 08:23:00PM +0200, Leon Romanovsky wrote:
> > > On Mon, Jan 19, 2026 at 12:59:51PM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > IOMMUFD does not support page fault handling, and after a call to
> > > > > .invalidate_mappings() all mappings become invalid. Ensure that
> > > > > the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> > > > > (for example, VFIO).
> > > > > 
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > ---
> > > > >  drivers/iommu/iommufd/pages.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > > > > index 76f900fa1687..a5eb2bc4ef48 100644
> > > > > --- a/drivers/iommu/iommufd/pages.c
> > > > > +++ b/drivers/iommu/iommufd/pages.c
> > > > > @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
> > > > >  		mutex_unlock(&pages->mutex);
> > > > >  	}
> > > > >  
> > > > > -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > > > +	rc = dma_buf_pin(attach);
> > > > >  	if (rc)
> > > > >  		goto err_detach;
> > > > >  
> > > > > +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > > > +	if (rc)
> > > > > +		goto err_unpin;
> > > > > +
> > > > >  	dma_resv_unlock(dmabuf->resv);
> > > > >  
> > > > >  	/* On success iopt_release_pages() will detach and put the dmabuf. */
> > > > >  	pages->dmabuf.attach = attach;
> > > > >  	return 0;
> > > > 
> > > > Don't we need an explicit unpin after unmapping?
> > > 
> > > Yes, but this patch is going to be dropped in v3 because of this
> > > suggestion.
> > > https://lore.kernel.org/all/a397ff1e-615f-4873-98a9-940f9c16f85c@amd.com
> > 
> > That's not right, that suggestion is about changing VFIO. iommufd must
> > still act as a pinning importer!
> 
> There is no change in iommufd, as it invokes dma_buf_dynamic_attach()
> with a valid &iopt_dmabuf_attach_revoke_ops. The check determining whether
> iommufd can perform a revoke is handled there.

iommufd is a pining importer. I did not add a call to pin because it
only worked with VFIO that would not support it. Now that this series
fixes it the pin must be added. Don't drop this patch.

All the explanations we just gave say this special revoke mode only
activates if the buffer is pinned by the importer, so iommufd must pin
it. Otherwise it says it is working in the move mode with faulting
that it cannot support.

Jason

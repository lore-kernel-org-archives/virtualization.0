Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110B4B8DCF
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006863; cv=none; b=AepC8o16KEoSdGJRdk6DIHT//0aA8TX/JCSKcgJyZqfc02d5ni4vFSzfFiyDvXQbrdYuiv7A2VuN7Pv6STAZd+ls1fc6UY9Dh3YkEN9dmlgzLbznG1ylSpz+vkaFPWsxUbULMtujJiSNR+LFVBlOcY37q+pcBq4Etfe9H6cgs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006863; c=relaxed/simple;
	bh=ACESqUkTA5xhzkocxzu1Q/cYXSAEkWy1ze88m+Pg+BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD9q/63DrkW4f82YRar4XTm5M+eK6ca+gJ1xvUPacHB++YZs4CHAs0mV8x1DOGCslWDZlOyn/HLDBA/P/bglKj9brfpPr2xhmAVZ8hzHJBmcQyeaewOOYI1HO/KzIslUJe3OX6tpHMhl1Ks83XpZYImBD8obmiBu9eRh6PT7PUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFc8jczZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFc8jczZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a35ae38bdfso75485ad.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006859; x=1769611659; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=ZFc8jczZf2Jcc5qasxHAubU2Wjsy1lZt1ACiNIwuDsgHuPVRnhdAyaC6ulXzQei3N/
         r0YFxL9QwUyQ6kfPLrhNbRM3NJv+XCt6P1rvM5fAYvbP1rbURfodZrWLYoHvv1kFk032
         K2NsX3neAFMtoLrajJhQagw31QWaVBHVU6t2pGSlyxqqLQ4FBnSWm962UNSnpgxPEHaW
         2M9w4fqEAxfDwjEhyh3RlVKEzh2LaqQFUSVz0ZkNtJtKkTc1HW0Ja2S2zYOpjXnp4n0w
         tN+MzgmWc9y7PqVhDX5P/pCHmJlpapYTRtmtztQ1yp7+ClKOD/bQjdV/S+ATc6FKIOfr
         pjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006859; x=1769611659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=XxkOkHCoA7V7qzUkSVkMCq3exn3A7i4jJ4HA5PJic9yAyIXl9p7imJWktbeyN3hwIZ
         QcRFMEs73hQFPP/f0F6RwWvM6mkLz4n8N4R4dq4zuGcI7C+bKJ5qiJQw7u6bgPxJqmKX
         aS185Rc//bEDRMm2MUTli4WtEeA1UvKtjCAWdO8VDMENVUCMCLNNIKYheWz3O4aJQD66
         nfnYJDeKl7yIYEp9yINUtcL9dDixPV3RghhIIO08tHMOYQV4oCCcoA3SxhSMpojpTcJJ
         GJ6hSJ7JXLH4uyK8alPGFo9lWY3P9G3GUfkL17sZsOL36YkslXaakPIlMA561AS88l7P
         OxxA==
X-Forwarded-Encrypted: i=1; AJvYcCX/lnLNtHLnUyKWaYn0RgPtXsh4zucA8a8KkidDroHp1e1coK7Jhbp9/7G8OIZhijzl/PMoap9WE3ot/IGApg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkTM6XgnPsqlWYpevmshWUrfBIUsqEBg1sh610wpD/Pjh0PFfj
	O/2fjAIYD5IRD1IXPkG4ll5sWZ4Okuox2/QGSj+pXI2dKZCyAFtfO196b/8uLEej7w==
X-Gm-Gg: AZuq6aK7HF5hBHUe06J10jp7YFiHQNJ9Q0REOwl4gVZQdisiQxc+vb81sUI261GXLHL
	FNh5pN14CZBHJcEm3Z7ZeGbJoONlmtuiBI5s8gUP9Z66w0g5GjcIznlk93iZ5hhoQurOG248EHi
	qIx6txs9spNYiMXUhwFq8aDvsRoubPF+3KqpeRTOw8lpPfC0qodsCQyPJkoW/CPto4OrmoCTst7
	pNi9QP0B86950+CdZhZv7ZleaKVkxXLS9pPQHm6JsU0kjho+Id7zMs0cTlOYC5tT7qv0H3EFJkf
	BJceamgJyvUnCEr978da4tG/963hR3Asrr9I+MmV+tKi2b8eH0EPuAOrL+rurNXsoKPJifMoVCW
	NvA8HFIzw5zEQZiwZ27fQazfQaNj8+W5TGxgwPrsJDNDB/XttDCoKl2N3WYxXVNKb2zvMMJNCYs
	rvkoLq3mZDTfY3xj1v0UffH/b1DxHwHH6Qa70+9o8LUh71eOX9
X-Received: by 2002:a17:902:dac8:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2a7a245b58cmr2655545ad.15.1769006858836;
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b21fsm15434806b3a.13.2026.01.21.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Date: Wed, 21 Jan 2026 14:47:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Semwal <sumit.semwal@linaro.org>,
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
Message-ID: <aXDnAVzTuCSZHxgF@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121142528.GC13201@unreal>

On Wed, Jan 21, 2026 at 04:25:28PM +0200, Leon Romanovsky wrote:
> On Wed, Jan 21, 2026 at 02:22:31PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > > > importers that support mapping invalidation.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > index 5fceefc40e27..85056a5a3faf 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > > >  	if (priv->revoked)
> > > >  		return -ENODEV;
> > > >  
> > > > +	if (!dma_buf_attach_revocable(attachment))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > We need to push an urgent -rc fix to implement a pin function here
> > > that always fails. That was missed and it means things like rdma can
> > > import vfio when the intention was to block that. It would be bad for
> > > that uAPI mistake to reach a released kernel.
> > > 
> > > It's tricky that NULL pin ops means "I support pin" :|
> > > 
> > 
> > I've been wondering about this for a while now, I've been sitting on the
> > following:
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index a4d8f2ff94e4..962bce959366 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)
> > 
> >         if (dmabuf->ops->pin)
> >                 ret = dmabuf->ops->pin(attach);
> > +       else
> > +               ret = -EOPNOTSUPP;
> > 
> >         return ret;
> >  }
> > 
> > But didn't get a chance to dive in the history yet. I thought there's a
> > good reason we didn't have it? Would it break exisitng dmabuf users?
> 
> Probably every importer which called to dma_buf_pin() while connecting
> to existing exporters as many in tree implementation don't have ->pin()
> implemented.

Fair point. I agree with Jason that we cannot leave this open for VFIO
and we can have a pin op that always fails.

But at the same time, I'd like to discuss if we should think about
changing the dmabuf core, NULL op == success feels like relying on a bug
I agree that it means the exporter has no mm, but I believe there should
be some way for the importer to know that.. the importer can still
decide to use the exported dmabuf while being aware.

Thanks,
Praan

Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E325299A82
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841996; cv=none; b=j6ik1xi7ZuG1lxPnER/aZb/5XTYGSQrTsAEaE4lodQN9zc9Lg/3EmrPCB6DJXubTNtBW5dDRp9uPXyAnCAAXX+ltulDuRAfI0by2zhcJIhXzXpYj1mPW7oALg1MvxYkLoLeewwNM7AlkyJJcXO/ocXCTQ44u8U86zDd8UQL1bHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841996; c=relaxed/simple;
	bh=bhDzKe3hBaMep6hb4Ruwhdat9qUjuZInlAgPSftgqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzF4oXG7GEP7SUx+kBKCMXwz8s6sZIy9rPOiEc3oOsG+OprUXQDiIzRfudc/C2ifcoX+rI+LtRvw9DDlgPt0UprdH7Zq0sYCsVHTu3anY6tPmP4O7JmTtbqazd334n63B971UGUOc6xxP0DSmkBEG4kWHewAF4Y5ex1C7VA3SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ud4leYJB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ud4leYJB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50146483bf9so59740661cf.3
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841992; x=1769446792; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=Ud4leYJB89gXsZ4uDZ/4u7oLHV5PkFCtSnjixqJMSxzGe5RUTXD7+cNX7nTc48ftFR
         xgvEr9/K60f1NOn8W69HaHHkWzf15SCHL2XnfoY6ZMuUurwdGiv9TmGhH5MW1eHxUEni
         luZ6bC3/JhhKvpyGvGJJ63PP+7N5UO7x26gFrVK8RH3jdeq3WtaXSP8PynQjwOEa6sYp
         mIB5UjV4oXSt1KTbL08xrTX359q4JBnQvefy25yqlR2ITOSjrVjABY3FAKUduzL/9o9B
         8mt0Cr1EkOkQNLG1TudUvPB+nEyMZAUYPuTonPl4Yy+Jm+jqjKOprDSRxeoOeI1wf2GS
         QhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841992; x=1769446792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=UGvYXJUysKKzC998qOzhbX+4UYVPWZna35/4tMOXqa5EPUJOdwjG3xECZHOruTR5Sf
         N9yQhowyg1Xqy+GEwEgpHxcq0KVIYG7m9ODfOIaMVCF4QO7gIFwNYojKMRvJ9ZDoV3x3
         ADpeGI6CQWgf3YQ0nB3UzuRRbUjxeSShgvLb1VTfsdnTB9otSFZWESBTFJVY7RmHas5u
         A1VHAw/WQDSsdnvq48xQ7P9yEsFv/s6tOOSORPlfWsJYpK/q+vy2oX9m5WeQPkPT3kCH
         AKJcTOc8U384OM0hCsk1oe10Mq5GLVyH98H0MAIHvt00doYKa71FLuH0C+WZ2lZFh4zK
         NkBw==
X-Forwarded-Encrypted: i=1; AJvYcCWm3Yd/uLK/98uFl3utGUnGPgXqPzFopHB5bgyJXDAo31AS/vySIL41YkevClKYqVYlhmiKSnMrG9fgYqi4Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw25HpCOtY33utwESrDu/FYDqC8GOzKoOxZyJgp+tlL4PSzisKV
	RUwF7rjNB4DuQpTCiiup16cZkAC/5G2xseCNbm2sZ91GynEPneh6r2gn9bNZH2GuAz8=
X-Gm-Gg: AY/fxX5YUd8sZE13hgRjeVfOhs43nNfUo09ZszZ3qTjLwL+YslUT2UC2gJigw3Kr6Ya
	FAoPknqQy5Ox9twWs7eQWTyRYzkduN0bnwpw2tSPe7Lc7fQA1KUSoReUgX5xYjKKlgvDHRv9MdY
	CE4rN4sZjlzFAf2xadOTEKFTOhfzs+czf6dglbzucY/9js50JpvMqpiLcQD6BIEYfbfVtmYFHMZ
	5TIAXB/J/vrWQRmfWwHadUZofUfcu3+Jcl1g3cbs0nH418it7XyzJFX5uh5OOvVVNeWzhd+Vtvo
	A+0oOoHhzSTEI9RLCStW9DpHMGzutCvv3V94RnXL8LLmfRiK41MqZg65eLPPvS+IX2T/dWWss9V
	+GXngh+Z9gJHi3mlzLehNTzE5IAJFlywv8J+mJhc7F7ewLORcJTrbcdPiVc7t14S3Qr09GUAsnq
	12SMdQrcU5b3mwdBcytngk5ClzVSp9iBexXg34Gbgg3Y5hTKGE6AqAKlTqc6/r+wlrlpM=
X-Received: by 2002:ac8:7f56:0:b0:501:50cd:cd3a with SMTP id d75a77b69052e-502a16b363amr184663241cf.43.1768841992288;
        Mon, 19 Jan 2026 08:59:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e4d79sm93947786d6.2.2026.01.19.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:59:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsbX-00000005IQz-1QSu;
	Mon, 19 Jan 2026 12:59:51 -0400
Date: Mon, 19 Jan 2026 12:59:51 -0400
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
Message-ID: <20260119165951.GI961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD does not support page fault handling, and after a call to
> .invalidate_mappings() all mappings become invalid. Ensure that
> the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> (for example, VFIO).
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 76f900fa1687..a5eb2bc4ef48 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
>  		mutex_unlock(&pages->mutex);
>  	}
>  
> -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	rc = dma_buf_pin(attach);
>  	if (rc)
>  		goto err_detach;
>  
> +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	if (rc)
> +		goto err_unpin;
> +
>  	dma_resv_unlock(dmabuf->resv);
>  
>  	/* On success iopt_release_pages() will detach and put the dmabuf. */
>  	pages->dmabuf.attach = attach;
>  	return 0;

Don't we need an explicit unpin after unmapping?

Jason

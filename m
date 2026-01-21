Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1B41C31F
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010102; cv=none; b=iHGlkF28mpKn6rLqzFTWhT+rgyI5EAUd91F/M/zMyBDLoQ8vi4gwKDW0WNpq6d4ADp8jhnUkyFtKxuTEHCCEfKcZ3PxcDQIG02MLu06YEmVGWPbTfXZzVJsGR0ljSlW9i5uKS4Xdtujqrf7o5MPsXrgIVC7ttTlpF4Fl+Ux/6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010102; c=relaxed/simple;
	bh=MtzfM60Cs9mbb/vDYLGt1i8sN5P/nhUKDazT3BzO028=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5i4i2wHKnP6SmbhyFk6CLaDTjbWJMdh+OUylwIe6ly8CblatNvV3fM1MB0FEfoYnpoCV6TL/xH4leqzSFw3sivnDmGkv5GzKxiG1dANoUuGIh9owwihKQcj3wA59twb0ISYcEPSp4bR0KVq8BDyR58sQ2ZV/V+dMf8xzE4H/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pkdw/Wdx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pkdw/Wdx"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-888bd3bd639so12378976d6.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769010099; x=1769614899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
        b=Pkdw/Wdx7h3NSghDc1cg/82xhZWnvj2ZYNn45nAQFE7AWVSRoSTmKI901S1zsEIC2V
         l1yu63YMa/eM8dHf5nzXO0ls87Pdth5WFh7LA3RX9hVQw4ptxoDxn5tC0PQK++mqEXh5
         PIA0u1NXCff5BDr5GvJWMTnnlIBv66j3oDj9ZjueQraOjV3IfDfim0Z0V9AnB22emdN5
         KTkZ3GgCO+pGskteahcW+Tt8M7jU+VVwuHutXCel8cyOThOBtPvPtq65gY9W+SEjVKBS
         QqV0umdQtOVW/RxK+N9a+w2SC3vHGNo5+LNyPkGzJnLgw4ByRTlzCF+WD66xBaaDWmLQ
         fMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010099; x=1769614899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
        b=HwnqElv42P6qLcYOwxwHu5SCDiplTBnJQ4SibaF/luMEw1ompB0gLNN/I5oB+20m6E
         rhV4ardz1fwX8YiSfnZXk5qkuI9wXsItu5j1L3ltLvP3U7i5BhQdCQ4pJIlQ0QQ//OwD
         tnOXZFLcx8gDxPtRLWGwnxagf9o/CepifWI+5jY4i1+u9a4i1VywX4N5tGzFcBPikwgc
         wFUs2PXjB9EXHNprFDv8s7PkZ2SgQQuBhpPmtf48AUDKog4T0aWz/Rh4dLfe4/FZIzOn
         n01XUChxXHJD0keGXujLXVmV5wHYs0MkX5vYLp3UjXifFp5IuASJE4i/Tx63QhYCQifl
         0Bxg==
X-Forwarded-Encrypted: i=1; AJvYcCVAiDy61wIIXT6tPQJM+qGSdJ+i6ARLKzP+M8xZgekqfu/vgFVQ3/MjvnIMzCe1YOqSCpU4MmCLxtBymVvYQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/u8TBqvOsfOqRLYmunkT6JCsYPLKKZReY8a7Id97Tx+8gZV/X
	sHbFAM6C6XModQSWDQKkCbBXHGudF3sZsoEt+JvifwNy19/0Qix0ZBi/YI+SOSSVxkc=
X-Gm-Gg: AZuq6aJYDGIioHS73c3tC/OEb4WjENJNxj1iIJ+ARuUu6B7DBDiTHsoXk4uHB2onFRE
	ZNa4l1hZ4sWTWlrMt1rrbGV6C4hcEOAKO19uqyPMQ80HTp9ZcL7rllwsD9hC84AAU+Iu2KCISLf
	81Vn0vR6C5PnXdsjCmbAvZj244siERaAwMgL502W8ymxrF4dvdTe3/b0pPf6ssayBJSBpDjztyL
	Nrn1Dzp1ciw9oT8DYm8ERYOS3fNg8vioWQP2ajlM4MlKUsa5JWnRxme8UBxrSmO08L7NzxzTJQa
	CIjW9cF64UkMWPpgOaSWpvFnSUt6fO62M8VAej5x1TaMvV9zeRtyvfIEboHaAQh88Ej4z/7su0J
	Rf/6uB+H7mKl1XVXguKuA05R/6ZQT/qQFW44q+SvDuSCGD3G/2C1TkShelgW0kq3+7pV97c7vhG
	D787e/mF4P+sI/yWXcnzWgmgHNqIi4xJgUO4PngjcBnOunWwRbTOl7Arrz5SAgZHzFaeBB/XNGM
	CaOXA==
X-Received: by 2002:a05:6214:212b:b0:888:6fde:7b72 with SMTP id 6a1803df08f44-8942d7e0460mr262093776d6.32.1769010098574;
        Wed, 21 Jan 2026 07:41:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946a1e3d28sm30951806d6.7.2026.01.21.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:41:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaKv-00000006EjK-1pDz;
	Wed, 21 Jan 2026 11:41:37 -0400
Date: Wed, 21 Jan 2026 11:41:37 -0400
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
Message-ID: <20260121154137.GD961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <20260121144701.GF13201@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121144701.GF13201@unreal>

On Wed, Jan 21, 2026 at 04:47:01PM +0200, Leon Romanovsky wrote:
> > We need to push an urgent -rc fix to implement a pin function here
> > that always fails. That was missed and it means things like rdma can
> > import vfio when the intention was to block that. It would be bad for
> > that uAPI mistake to reach a released kernel.
> 
> I don't see any urgency here. In the current kernel, the RDMA importer
> prints a warning to indicate it was attached to the wrong exporter.
> VFIO also invokes dma_buf_move_notify().

The design of vfio was always that it must not work with RDMA because
we cannot tolerate the errors that happen due to ignoring the
move_notify.

The entire purpose of this series could be stated as continuing to
block RDMA while opening up other pining users.

So it must be addressed urgently before someone builds an application
relying on this connection.

Jason

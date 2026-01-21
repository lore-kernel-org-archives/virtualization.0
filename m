Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DA3491FB
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001537; cv=none; b=neu3cD4hVAWHeE7Rqdex3ITsphn2q33EjU1MJ0tR3dPvIxk2tzRV6esQjiqLCs+mWBk/PAzH+uih6Y9Cp8H7pOydbIYhVglGvH3V3BwhBp60/Ur3CFKMrR2z4zo/wXYP8YvOBjkqLYNIzp82dLPk3QgF8QwBWe0ll2PCmt17Yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001537; c=relaxed/simple;
	bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppPIsvIdHi7Hw0yqXuS5jL9BVejDIMrLdczJzluUXMYK8CzOJhDn4vknkGMKq6evkgjK8uQhg52Yl8WAX6AxztDkdscDfvGq6znmO5LCQ+iW31nC+IULk57vLTYntQvEA/tVJ9Mg4MA9O93GicNc1947bDtau7rPnNLBf/5NV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hnFe/433; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hnFe/433"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6a822068eso680331185a.3
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769001534; x=1769606334; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=hnFe/433GxRz2hr5i6+dpScjsWLhGlEObyIfXbGHTbMaEMRySw7IJH4hindawcRdWy
         YHQZIpgwhvz5mBsI+DmRDf434kJQat+Xl3u3xsvQGkwZ1g5GF58DBzs5uKruhqgRCPE4
         1LgXlA8IQbsA7I7EWMqn1FUgnNybnVeqN42C3RN6LgPpVneCpXFNBuKZLC4Z9XLtuDSy
         jxnr3AIotIBuj7uXdPk8XmKLdQ198HnjEPP2JqoZC1yiI/7C/pt7udKYNRqe7n70419d
         5xkdwa4X0umkRN6xg76pPGPYB0fBwOT/e4ncNIoTIUPwPx5c7giABdq0pzZLaVgo/NUY
         1tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001534; x=1769606334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=JiJuPlMWIDNju93kgBdM9RvdbmLpisp78sDgjOd0owsTUU7CSQWYwTecK/FEfP4HJC
         0U4jCsUKBITXxps5GJPN7MP1kyNfjQHWcYj9kGN7wnDF5GrRGuL6QvO7eIs9fidbbDbW
         gqftpbo3GOf4iWUCNGeUjjKsGtOLVQ2TMTiKtfUr4PcdE8gHlh4O7PlmG6yK4MGqhauU
         gbl+AfT4gx9opKoq1mjlAl+Bj7SXCrNsHuFIwWfp5P2l5OhNJIri0Glu/2sx8/5LsBcA
         7RVaQ5G+WO2S3v0XfDBK8BGCC97OCQ/QfKONxC87CPsy2ByHdzcmKg2Vgp1ANmAAR4jz
         Ylrw==
X-Forwarded-Encrypted: i=1; AJvYcCWBYvoGu4vk5LGfkOjukvPnZxgW58C1W/1tBIR3rcflZ14GLpreZcwFfQ4USE7uLu/lWeT1ZJZJ8FzN5o+ODg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpQQIBU86HO3SKOxLE5GS9De9DpvFUACJR1lGO6hUD0f0nwv37
	Jeu3Mp6jlxl8EM0/rPXt/hrVgx+R/STSJjuG73GLXkz1RcA74HQdfd0RwMP/Go/dfBQ=
X-Gm-Gg: AZuq6aJ+JaJuqmhxX3nWedMDpb39ZNh0xOauHpqrh4aaATseBYE7vNtdn65ZdP4xXe0
	FNGO2gtbQcnc1HaXUrbCUWJ5KkS/bYGRJTmgqQbgkSL2EVOlVZmFENjmHVp1dfDnYQg6MZGPmYl
	sLrf8smPR/PuS9g5bDvQJaRtFvaORKAGKFdOumTrLj2h4Qpa0vSok1qgGCN/S2rP9MaOEzCA4PS
	Zw5xbiOoKwmyW3xN8rZBSj00B6x7owIW1KgN9zGZJsoX0aEmjO9vUBNrNWhJF3nf6nuFjhrJs8N
	hDLUrVim0jd6znlMgvv1QAjx4+kzC4+AHVwJIcGfI6ImowgXEsf7f5N4RaYZNFfp5nPuxi2gFaf
	alMFMDXszeF+RP3q0M1RCKUkjP/Af4FxlRMy/zqIoaDaLqlwgQUng1jFNjjyWk70TMEkq/SF0sO
	CVZb6uj+KxPRglF/t2avJZN49wrzuJSpUnGBdag+jy+RgTwHpX5H1wtu5CdbyAQit4flM=
X-Received: by 2002:a05:620a:a819:b0:8c6:aaf3:cb44 with SMTP id af79cd13be357-8c6aaf3cd9bmr2247463385a.4.1769001534382;
        Wed, 21 Jan 2026 05:18:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad820sm1209794385a.10.2026.01.21.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:18:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viY6m-00000006DUF-3lkE;
	Wed, 21 Jan 2026 09:18:52 -0400
Date: Wed, 21 Jan 2026 09:18:52 -0400
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
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121131852.GX961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>

On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> The whole idea is to make invalidate_mappings truly optional.

But it's not really optional! It's absence means we are ignoring UAF
security issues when the exporters do their move_notify() and nothing
happens.

Given this I don't want to loose the warning log either, the situation
needs to be reported..

Jason

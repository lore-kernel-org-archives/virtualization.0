Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE927A477
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301274; cv=none; b=WNwVjxRWnjGTap0pa5KLx95RdlSWiqZeX4+MaCvpX93dWvi1L6YuvrdeRZbr/xYKo24levQrBtKvSqjAUoPOqGRW6FXsmNhKFfKoYrywtEy31V6wqDRFQW9pr0IEj8CZX+tryCQeEsA9sL03ZjFbX/BNEv/c+j7wTRKNsGSb8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301274; c=relaxed/simple;
	bh=2XDmVAyyw3kHSva2SZjpEPftSjaLFto+qTX6dWpgwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+S9sbQNCMk4PN2s/KYhWZIAXnjxmg43l9quQczuryFNlRNo8tLldX3Zwuxcll5mbrFbrRW7razE8PlnI+K9Ip3vBIivZHiGfJie8oJOtUwnYfAwtfrs4MYE1CmVfjDQYA2emn1We3hRTBNUMh2bKPZn1aWGjts7Cg5NCMPhZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N1Ublbf6; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N1Ublbf6"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89473f15ed8so9283406d6.2
        for <virtualization@lists.linux.dev>; Thu, 05 Feb 2026 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770301273; x=1770906073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
        b=N1Ublbf6zAICNgf7v6uRvLsbh3GYxyyfhCUVD29aJ0+2EXYNp0pJ7ukMLY9zK8G9FN
         mV6uC+9t7qQRSuzup2aaeJtnejb+PQrCfODpcQjBBFxBvIVgCSo/8BdZdq5iQ2ZdKdQ5
         Du37t0p+qJRtdlRwLERqKC2/b4qWeIDQakVlmMquNhgSIUC0PmagpJXJYGw9k6zJp4xW
         b3M000wZuUind4ZgQWWmQPdu9hcgSLHpJaAuR2docUqZwMujUHD/ynIIYYpOl0vRhAJ1
         9QwqNXvkV4KjoeBX9g++WVlR1nDOHpTSlzO0Rmi7LmRFZPjvofs5rJtBqjOxzWTdJX70
         sMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301273; x=1770906073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
        b=HgEhuqeNHGpH0gezEiKhF0NeOQYL0uPv/NbvKFJlBhVD1VV1tXW2lzuuvT1NX0PSVZ
         jJAji5gKK30cfQhCCne9o9UNY6dCcxeAk3uXIy5SHFmnoXxedX6+WWoWVmTtObciaRS9
         ltJ4Npt7kS5wZULPx5of1PTv12794Y5Lwhz7KQ2jn1pEx6PYsZOhVGXGpGUhzQOGzYTg
         fwyl0Kkk6z9KgDiDcw9Am7jvuZ8A1sV2oiDoerY3tZ0IX88Hs2nGxTk0hJcZU24imqdl
         qdFJ4ePid6zSDYnT87CON75a0HcZ4m8pNqSpBeaiyjnxuFIXlCptive/EKvnrnVGzdsF
         7m+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmGd76AF3N8XuKjIRhQxHGVU/EihrxsYP/kTvzuY7BlUwi3HZ5yPNBob9JjwFp0K3jfpv63Fp//5Y0HSKODw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGqMsd3NFuodlxlthh5/CJxv5f77YnmwqrxxEkqGnW2KkTBvtb
	8uBqiy+oeaIeIB4OyI0wFcttnOtF3CwH6CIFEm+BVNUSHOm3Pka8qznuEvGJzxj4pTA=
X-Gm-Gg: AZuq6aKHqk3+ABIGoQD3Indm+80dnps4LRTR9E5jcCRwxxDD0pVEZkJrMaHgmMC2YAo
	VuipYGWHMFMhojzJ5Wf3U6YxGfpiKAVU+m1+QAtFYDBrZXuNzjyO0oe4ZGaRLD/Rx+L8kT/2s9J
	4Hjw5WwPpXZdDuA11f6u0IbRjCpscdX4R3N82msvei1sckfIZppP+Vr7nikrIUvpND2ai/T5npj
	pBbg4TSkGEMhicPS8JtsX12mpPlRQPb6WkYqNGGGGj9Ut3pIhtIM3gsyWFfqpt31LJKPJAcqmTr
	vEGBQYcW1e26DeM1nYxN0yKWftaJx4v5qvaW1DzHp2CPGM4+Q3UYwl/J1BWx7FC6QIy98n7f2QG
	3m8qsLrpWxz7tvjEGpehd3XMZx+IqWz51mLL6HVICO0cIjlbTrxA6XHmnjFTs15qEAqGd3MWMuN
	T5uEq8TvKKIN7qN3DrgAWSrp5a9zegxFZrFB/byP9Ped7t80YnWAWzGh9GfKOkK3vPsMg=
X-Received: by 2002:ad4:5cc6:0:b0:88f:ca72:6ae8 with SMTP id 6a1803df08f44-89522189787mr84672066d6.45.1770301272999;
        Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bff53esm42252276d6.8.2026.02.05.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo0EJ-00000000kPY-3gpa;
	Thu, 05 Feb 2026 10:21:11 -0400
Date: Thu, 5 Feb 2026 10:21:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260205142111.GK2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
 <20260204095659.5a983af2@shazbot.org>
 <ac33ad1a-330c-4ab5-bb98-4a4dedccf0da@amd.com>
 <20260205121945.GC12824@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205121945.GC12824@unreal>

On Thu, Feb 05, 2026 at 02:19:45PM +0200, Leon Romanovsky wrote:
> You don't need any backmerge, SHA-1 version of vfio-v6.19-rc8 tag is the
> same as in Linus's tree, so the flow is:

I'm confused what is the problem here?

From https://anongit.freedesktop.org/git/drm/drm-misc
 * branch                          drm-misc-next -> FETCH_HEAD

$ git show FETCH_HEAD
commit 779ec12c85c9e4547519e3903a371a3b26a289de
Author: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
Date:   Tue Feb 3 16:48:46 2026 +0300

    drm/komeda: fix integer overflow in AFBC framebuffer size check

$ git merge-base  FETCH_HEAD 61ceaf236115f20f4fdd7cf60f883ada1063349a
24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
$ git describe --contains 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
v6.19-rc6^0

$ git log --oneline 61ceaf236115f20f4fdd7cf60f883ada1063349a ^FETCH_HEAD
61ceaf236115f2 vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF

Just pull Alex's tree, the drm-misc-next tree already has v6.19-rc6,
so all they will see is one extra patch from Alex in your PR.

No need to backmerge, this is normal git stuff and there won't be
conflicts when they merge a later Linus tag.

Jason

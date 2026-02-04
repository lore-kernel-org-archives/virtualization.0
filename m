Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C9268690
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212126; cv=none; b=adqJKZN0YP5NAZ7/qPohurtu/Ly7O0DI2DM3racrkLPCpshJr6Dgb4vwnEeo6OZKB4xuFi2SqWQO9t+rA/S6MRHAH1azXTHGTJo3BM/l33wb/vk/gBPOWPnAett35dTR3Yy1I+nU59tbMMI5O4Lx2uFBGYbh/dXRQoAaLv5E5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212126; c=relaxed/simple;
	bh=H/kTkGZP8AkvmyFzU3sXO08Z5L27cMenr5LlCq/UphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHuVhLamyBBqpyiLArvhq1By+3fKHTA0pR4rKN02J3kvZw+0GgWk4iSiBpQsVnO2sMiq8amxDCPdf2AJ4dmwjj9Vcebs8V50ixX/hcC4ZJ0ChYPXGEzbPZSAMmohWWx6bOeg0fXKn4hi51ACrezCvobLQnaObp4kG9zIkqd9PvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kfDajl8Z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kfDajl8Z"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c9f6b78ca4so721831485a.0
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770212125; x=1770816925; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
        b=kfDajl8ZWCHJ4wEQn9mWHAMxyaEpasIlun6y+nrhOLLycIIMpymW2ti272hCw4a0LK
         29jg4Ev24Z6anw2nk8SUBAj6lYwCa1CM4XXzWhJ/xTjUakeoNPZtEDUHBxky2wZ9VSuf
         mJ+FxHvT76cBM4VADklqdNjBO8yHiRl7hcVnwexMD137auGLoYLuWUycaM2XwpFzSSqA
         kkG76865vHD5wK9DUh2HVQT16lduWf8xsvZEIyPRbCbvpblsAKaogiOdu2SQ9kAiWXHs
         p8RnBrlG3hzflO0xOQzwYtV6Pl214pRYt3hIhPCD4CRYQh3dCDxKhU77fEQKRuD0FHNB
         PLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212125; x=1770816925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
        b=hC/tCAw7ULPJZ1Et800fkHZu9SQMQ5Icl39CBEZMqHAJEnUd9pOXPHxQZi4KQF1Pon
         pIXLdFCFljFHzysgcJLsWIx5s/xoC7oDmJUkf/gjM741//STe2jT8NhtDLB21kj/Z5Ec
         cLJ3halpMqumnk97r8y62fhfNTERpBcBKbwgqZvpOzJ3y30UMrmAIHpBb4qgQKo2Q5Zd
         hgXkr2sd+INMplQ+zYIFfOpDDTVHROGDvCm4gwvF9/0JE4cBnUg0dW1oMurcf3/5Xemm
         kaGJOFZ0ZiIFXa8iFFUpiRia+S810giZebPRjsKBcfUu8t6xWyrHMvzjfHPLL0mzAdps
         XDgg==
X-Forwarded-Encrypted: i=1; AJvYcCV7RMKLXEsBjeCKmvUSSWnwuvEYekLNPdFSK81acOcugrbpo5KaMGZw1I8/K85kdeTq0o+DVApet0hzuGF8wA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlKBkb/E+CJEFWn12I4vZAF3xiyxaaZr9DFA0K1D8SYl46MgIU
	6K0o0SF1vd9uJ1r5sCVBRbP67IG5/C+dvfTNns80t7Awj9kLPtxvs/viFZvNuUg8Zbw=
X-Gm-Gg: AZuq6aJAdag+G5NXVkrS18+/Lu6wmJAPpGDuvO4ef8jPkYy/Xv2kdi/GwaNOSALMqtC
	IBl/H6BruHjDUDujs+9uLYUGUY5tIkqcNDAtS8R2h7froadI6n1Z7nI4ZlsESSQpZYqGGHia8Qx
	Ivb5drCr9f5hh43zN4aiyucj8LqFWzhmgrPvmSkBqi2hCSLy2I/AqQsEcmEcR7sRSs5Ba6oCRV0
	QwjRsA6gBSIZuHbdsKNwS8RYPLNK5c5R+E3fShl+oobMoW5yrHzZzs3XYkZ52XpsJzkB83c8ol/
	p4uobu8yOTcG0TxjeVYG8muONNOppHEAXCaiOh9HFisv27eEV9elUsKIadtdPAEe8OPUl3dy4wF
	oKvyox0hPQpsUvnYbEt4QlbWgJF+BJesIz4NfKjE8R0e2LKJZEiJpBefsoXTQXs+JGMHQ7DBJnc
	Ht7COHOWCG1BQIH0bzHWdVtwqVqbqcikOd4jtIH/NQr3X7p54QlV1xGS8YsdoBfYNmU14=
X-Received: by 2002:a05:622a:1aaa:b0:4f4:d29a:40e7 with SMTP id d75a77b69052e-5061c1c1dc5mr32950871cf.74.1770212124739;
        Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c17babbsm16346801cf.15.2026.02.04.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnd2R-0000000H0ml-1uPP;
	Wed, 04 Feb 2026 09:35:23 -0400
Date: Wed, 4 Feb 2026 09:35:23 -0400
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
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
Message-ID: <20260204133523.GD2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal>
 <20260204081630.GA6771@unreal>
 <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>

On Wed, Feb 04, 2026 at 09:54:13AM +0100, Christian König wrote:
> 
> Mhm, sounds like AMDs mail servers never send my last mail out.

Oh :(
 
> As far as I can see all patches have an reviewed-by, I also gave an
> rb on patch #6 (should that mail never got out as well). The
> discussion on patch v5 is just orthogonal I think, the handling was
> there even completely before this patch set.

Leon I guess grab the reviewed-by from this email and we have a full
package if it needs a v8

> For upstreaming as long as the VFIO and infiniband folks don't
> object I would like to take that through the drm-misc branch (like
> every other DMA-buf change).

No issue here, both subsystems are waiting for this..

> So as long as nobody objects I can push that today, but I can't
> promise that Dave/Linus will take it for the 6.20 window.

Sure, thanks, and if it doesn't happen for whatever reason lets just
consider it pending for the next cycle.

Next is to work on the dma mapping type, I should be able to post a
rfc next week for people to look at.

Thanks,
Jason

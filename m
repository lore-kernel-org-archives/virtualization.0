Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77653115A2
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839869; cv=none; b=VgbWnMcCXAQlWyCq+/Pii3L1uGi/dfJ242US9ICDRV+OdTKTlzOyi7LJsbEcagPfKD/f/rdiyEjs7uRBOln2IPLD99DLopB5lsl3C4y4zQqpCcKhgFZwR01sMHGzgSrI0wOhioV0WclaRWxT68zqV+jLpUjaQEFGTYHW1K9+TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839869; c=relaxed/simple;
	bh=y4swwYbPI6raB2hvkPRsghll5RR/RHHzFup3OVrjU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1EW/y6f0fIZw/pR0bgOEw3Tuga7RrhRxxXYzeqL0/VS0nsJpl9V41gE3ANI46zDm6hO8DPdRc8U5jT6LL+FyAwmV7zcAWRseIRowSYF3u6Q0JtuS5MPGltG2q3HbktN4hlihjixVlJoXIe5m09vITXvoix9/e9Eif7CijGmllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CislqUfv; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CislqUfv"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c537a42b53so697780785a.0
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768839866; x=1769444666; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=CislqUfv34gE7OcRNtPj3BcVW6YbJ1IahbGjSqddNvqzBlUmZ2AZf+rf6oCmEF+R1e
         Bgh/TR/vsdEhb7HgVAa4gWL5DhQpJRGGuJkB/mmiWbVJbH+WbjWqbGWe6PipWj46ktCo
         Kocd3I7h43y+c2lv5iT4RBi686qNiJhhZU2GA3fG99/WYSqKWZgZ6TcD2OyBgndKLRsB
         qIFyn6/SD8z9ablKh21TYjygyLKtn2fp6+sSqKL4eD8KTgLUnLCTL+qANUWWgPaQfSYL
         872+zOrwW0S8mviwVD2eBh6J+DtBqPwIZ9nIxMP+95yiYFKC0fmXCYgw2X7p+oBG5pDD
         775A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839866; x=1769444666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=vXO4cCwQm4L7sUEspnwxrzqyIjLAOXjgEUnxPm7pXrgGpCfFrqLPQiCCwzZMbCjwYu
         QMxbb+OqBzxBihAr+KsFwxKRpL1dwubI/hQXZ4ub3kufRXh43nGVGEid6A/+8moTPzp2
         0wrC2CrcQ6Fe0ghCJM4HJWx2QX+hu83X3ul82UP/Cpvc84WxyF/edsncGebJSdAg1ReC
         937lnQTbFDRtdVVryrepHUjHkJ57aaNhzrbndh+uzu136JoQEorS8U6Hsbl00rLXXUeR
         1fkTvyTRkzu1PJGI9c+sR+mgV1we2RFaE6hkrAGtVHaI10RU5ZB8TnVMY9mgY+UZFHXY
         EHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcxNWAgJArvHyRAIhFJMvyI+6Acf6lk3nWbmWCCxkH2Ud2yp4Dsjhgyv46l3pQ3lqJLsKnhMxzj3WBqBf0Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuMwDZOub00Lslv+BHAmdWSJ4aQi+Qz6uhhpfe5skznquTa/6o
	hg3LVwxKi45FTT0bMXceVYE7eZXtHGlZiiukd4rwKT9rztGMb9TrwOBuyX04n/uU91c=
X-Gm-Gg: AY/fxX5C0f2i27MFcbn1Ej7nW38AtOCh1fkJSyIrk8SnFodi4ESsLxV94hXLhwOuLcF
	9DkHi0WKEMcwoTif/BJqtN7OtyIoH725heIUUCM7jmhEm3csVo3/2NvPYiYFMGqUUKVoq7Ap4aq
	1NGfSKHgevO25PXjkmlGYe79TRFSowWI8rur6EDpzRYA2ddCCGSpLxskiOyRiOh/JTXyo0C5p91
	qsvTIvoG06/6H0fSqHPObyLWNz1NgrdhOMLAib0bE+gOsr80NcMd9w03a15uLwrV/dJUVlU2mZt
	RxCLw+MDHnhm+y1bVt0akWa1EolO3JRckx2rkt2H3l87UcsOAmSFAppgi8vdkEh7+rW8QZ6yNlp
	8s4Q20K7FIw+JR3OGs553EdGBUfdVRHRvb2Q9a5YKR3w8mPr1J1uoq3xG/IX2NhB36aReyCtO+y
	CgcdFoOTCl+cAd+ZximS8kiz5YLDMAgbUUP+PtEk2hb/YfqEdegYxAs6d1f5wgZJfEd64=
X-Received: by 2002:a05:620a:2a02:b0:8c5:33bf:5252 with SMTP id af79cd13be357-8c6a6963403mr1445548485a.70.1768839865634;
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724a484sm800372485a.33.2026.01.19.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhs3E-00000005I0S-2Krj;
	Mon, 19 Jan 2026 12:24:24 -0400
Date: Mon, 19 Jan 2026 12:24:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Message-ID: <20260119162424.GE961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
 <20260119075229.GE13201@unreal>
 <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>

On Mon, Jan 19, 2026 at 10:27:00AM +0100, Thomas Hellström wrote:
> this sounds like it's not just undocumented but also in some cases
> unimplemented. The xe driver for one doesn't expect move_notify() to be
> called on pinned buffers, so if that is indeed going to be part of the
> dma-buf protocol,  wouldn't support for that need to be advertised by
> the importer?

Can you clarify this?

I don't see xe's importer calling dma_buf_pin() or dma_buf_attach()
outside of tests? It's importer implements a fully functional looking
dynamic attach with move_notify()?

I see the exporer is checking for pinned and then not calling
move_notify - is that what you mean?

When I looked through all the importers only RDMA obviously didn't
support move_notify on pinned buffers.

Jason

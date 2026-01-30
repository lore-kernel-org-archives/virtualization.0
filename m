Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E983195EC
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781681; cv=none; b=lyldtW7Jy4HiIF0LkqLmHG5sln6gXiFfnMfurb10gBVbjIVORSUucJHNvcX5BUrBx3tKjXIqOMS6XsQuben2vUzIsnBPAiC5UZCKA7juIZtwekCo1PWi+V7QG4I+Z6wyl0CxJvGVrpMLwGR8dvyZ+ft+69mWVnnZhQJntjI5WzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781681; c=relaxed/simple;
	bh=B2BjUDXErJP5w+VRNup6GLKty66RY3PW3GzWxgahGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmN9hKa3HdrWRdB9Lm5gvCyJ0hQCdp/kJM88R/7F2ws1n6xFd9cMTV5lya2t0Ux563MCq7ycxLRWpLPrG00vKu4AScWZbJ6fjuZQbA2eoKi2YebQOQWq9wDVUMk0GgI2EB37sE4UHJ7myNNTrYQd1HvRORSc9to2jtiQD9olx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BCBE4/hS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BCBE4/hS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c59bce68a1so159214085a.0
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 06:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769781679; x=1770386479; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=BCBE4/hS6fo0DTZ0gzevSQjor0Ne4XLHYsu+UPZTmGQvCEsrYCYVIgEmBl1I7UMS6r
         mdCnVp194MEbJn81k/kYNRLO4W9NlAG9UGDfR14JOwzAGgHPzlzKoRcvEysQCNZgH6l4
         q1IF33NbEomgpA/SDRLy1VlIrGPn9HUS5ai8TZOsHayTvcQo3V1KiOP3xHQQinxoNyy+
         evrPai0k8QN0NpPN3dYVg/qF7/gMVllK/ZvQTwaQrCbcQyyNM2/TS9x4MmastcgTkTAZ
         J5KHI4BuV3Tb/b+IQMWIb+kmE0otr2frE/gYcf4wN/1SLUl52+8HOZOja7ynLRR4dDJN
         qX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781679; x=1770386479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZzJd1rUXnKgbbFoik2J/HwA+Mcwjh2UI/kxMGq+fms=;
        b=tVsRVS9fGUfjaRMdKzKnBZrWRZ0ExFYB8k88xm1tHJpvz/dXJpSgNRflKWBH99wkBB
         HFbitPa0qPqwEApKQU4WApHXASkDqZvZQqkeNJcz3mt7kN3yTH44G7ax3A2yThWjE8cX
         1TnmxS3RRQ4pR+3C18w4VqNjau6TjwtIH1gwW4jPwYvuEU1XpFee28lNpG6AS/7fh14w
         VQYCBtm6uzXJzmqfHlsRo/volWP9cm56Rscq2jx5Ly9FiNagBPMjVrfiJDqpqAn0dnI6
         O/bEN+v/QUDo26zeyAO4eRL5yef9/ZCcNRA89KmcIiX7jJEEx41Qja57ekkC+nFAi7/A
         B4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1SOUT0riQvEow0G+VVwM8xhHhYD1uYHHbTXoxPX9nQ1vkIodgw0YCDD1JQUua/DcaNZqPrqZ5dLM+VFaVOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqLN7Cs8hiOgeT2x0Q3rfy1jNBAjm0oGtFLxKNBIKAfHMePHbt
	gcUr36PJEi1fS10nfgVg7RrV+hRinm0PwiDp/Td/lZlVtjBZr7+3u9fyVirXBXyDWKA=
X-Gm-Gg: AZuq6aLmPGr92YLg1TuJZr7B3AW0pVypd8vZcnEkF+rjKndAaJQ2JhJ9h6Sm70pXAbu
	AGeeSYfbzX4sBEhAFJF/q6VX05p/Tygs2qeYbTLX2Uda+WGNE3wYxTuBZ8Fvk8ayPMMIsCChpTI
	TZXtn8dr/FrnSFcDr+85ukdb4osiDf2wIZaB8vHzx2wPZq5YdZ5Gv9BANAB9lIp/26PSrPQjehq
	MAEf3hpa98oxzJt0IhkCce8DiUK7PMYHb85aU4zcLbw75UztabLzsfS+kbhqQo1SGjV+r2bWroZ
	ikAg2qM/ggTn770YydvC9YDUz5ZCBuLGpo+xTTHVFx0uuaK3mIAlvbrjpskxxIHcN/js4hf9xIz
	1MEEBa+2+JJ6GCEHIUWTtCt/q5xhpTjvE/jXeGhr2zgs5mbqMRJ/dm6r+dlRQ27uB8Wbutm0DKC
	xSz9TtwHhPZ0wrR271/qAP6FmvHbaxJX5xh0/rwLxM2CD9g8yfwCkIHStV+aVah9MAFdC2rcI61
	cuZzg==
X-Received: by 2002:a05:620a:290f:b0:8c3:650d:577e with SMTP id af79cd13be357-8c9eb224827mr368793585a.4.1769781649371;
        Fri, 30 Jan 2026 06:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e4esm700915485a.15.2026.01.30.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:00:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlp3H-0000000Annc-1AWG;
	Fri, 30 Jan 2026 10:00:47 -0400
Date: Fri, 30 Jan 2026 10:00:47 -0400
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
Subject: Re: [PATCH v5 6/8] dma-buf: Add dma_buf_attach_revocable()
Message-ID: <20260130140047.GD2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-6-f98fca917e96@nvidia.com>
 <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4cf1379-d68b-45da-866b-c461d6feb51b@amd.com>

On Fri, Jan 30, 2026 at 09:43:22AM +0100, Christian König wrote:
> On 1/24/26 20:14, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Some exporters need a flow to synchronously revoke access to the DMA-buf
> > by importers. Once revoke is completed the importer is not permitted to
> > touch the memory otherwise they may get IOMMU faults, AERs, or worse.
> 
> That approach is seriously not going to fly.
> 
> You can use the invalidate_mappings approach to trigger the importer
> to give back the mapping, but when the mapping is really given back
> is still completely on the importer side.

Yes, and that is what this is all doing, there is the wait for the
importer's unmap to happen in the sequence.

> In other words you can't do the shot down revoke semantics you are
> trying to establish here.

All this is doing is saying if dma_buf_attach_revocable() == true then
the importer will call unmap within bounded time after
dma_buf_invalidate_mappings().

That's it. If the importing driver doesn't want to do that then it
should make dma_buf_attach_revocable()=false.

VFIO/etc only want to interwork with importers that can do this.

Jason

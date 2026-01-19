Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685C5B1EB
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841183; cv=none; b=rH37ygfrD1NNRjEVFsihuYbwlRLcyOKPtPVoxtMQxNL+gSZnGzkadsZ+iXb6kLOVBmhBk2Un5FCUs0i1zGesuETDtkntxnVp+stf/ULx6tVyPYQ5/es1FFPIjUhKPRgUn9M6dxc8Ek69JgrRm9oiPKmAUnVly/dioOqDbwDIWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841183; c=relaxed/simple;
	bh=QIsc13zuNMkL3drL8s77g4pkAR1CgvBQvDpaSTaFqoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRFExAX5iowaHp78QZh7P/DNy2s58OOjq3eg2lFNNvsOcKtQQpLHUO7VZxh0CXnrTSsZYY/jAQdXVA7+TbdeFBQ0eFcb7PhBOg+MTewnirJB8Tqg0YQZWsKv+UpJEOvf5iuFlNtZqxFwnhYWoFIwZbWOK4owy9Rfy5+hSE9o/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BzjajVOq; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BzjajVOq"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so37390131cf.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841181; x=1769445981; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
        b=BzjajVOqiCRnwQSNC9QGYRmvShy3rjnjFXjSufSEmGHw0w1sGeImq/zIwxjKN31qic
         XNhCrt0fuk9iNTuZHq6kqH0UrYMYq7hyDSh9rhfJjVzyTcYhfiOGx8bnIB7ywJIovS1U
         RMC7isVHiPUTG8tnr03D+o+L7BYHltg7WLaNO+kH2aQ35OvcyH17nMdteKtQm0MUFemg
         0ZVHznDBEzYjk0OYD84KS1cHgj26oCfxrc4wqHU7hGlXfusZvkF/eyvSxz+U+S4mz7ZO
         ceHn7ApZ/KPfvhKEgvr19x5jd+L4skMegQvvUE4jhOhldJqReML4rb4zp0r65zooQt4q
         cenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841181; x=1769445981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfC54g6ZC0VxR+dcM7NfRz1NWoEdvriN2xR6YNn2bfs=;
        b=Pti/rmRHBfrGMPMkQa8SQ5E2CQwsCnvJSc4cxG5ZBktn1ztgtEgPOj4VITt88WU1vC
         9DStC050UW4ytPV9j9UIuUo8nXabZcAP1UFP1krIOUYcvlyf6W7gA5tAEYJF96L07Jwh
         gpvP2VrsM4N9l0LBdL7dA6WRctaskqsnaix3RG9+pbc5c8ei8aIx2KXMoXc7MaCxHVNv
         qF7ACYJAaBz9uw7lg/npWC0MzsS4rprH9FJREk37sy+hraKfQ+LsUJwQDpfg9knVWDY9
         bKWJQNnNqbmtlI9P0iPq+MiGYSyc6fOm/ynhK5QdDzw59GS9fHQvI4SyR2jupzknl02y
         xg9g==
X-Forwarded-Encrypted: i=1; AJvYcCWjg+84asGPqErWkTIBloSalW44RTtIq3S9dl4tLQb5y5ejprNct1tZ6EeS9wRr7MmyVlqfZ28TJDxvojh/CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBeOcWaAKeXpTizGHMVdwVKFQK8Iq9t7zBkX5Nj68ln0ibNO30
	znTTX0cz1EqgIFCIjd+OodxWtKfmIKFrVbJcAFomZUGuERhT71cq3X3Z4l9aJed1T3g=
X-Gm-Gg: AY/fxX5dk+79jchC4QMnLxLo0u7T8peSk6MzQdIkQ9Uioyi9i6WlMWNe2j50hv243xj
	AQK1M8y7jEwgSXKYuxqL6rgZh6yICZP3awRqkxaH6Bor7CbP3kLxjUEJF143scXJcxlPirqCkbe
	tQcpQJbhzGDAfdxLnK/QnGcqD8w9es0XOBcBqWKOZWtNDfNXZZvm9MH3vfNUXykVO0FySYaxm9O
	LNIwrggkGtC5icTLz7dhPtjtWWdn8dHX5ftKThZ3v/q67JdkYVzUauGaO17+6YuLSkhL5ShUfU7
	CpKVgyIBann3T739TOPxU7EVb/ZgdWSdeh4RRnSUI4IwfXYYlFkBa+eZ3KdZV9uUikf4RMNwwbD
	Tweon97Ib5tZWDQv9WYgljlLQU+Lr04N7RD+mryEH6YxGuV0I3CDvJLVc6iDbJ84xITDlRZWRhq
	pIGmGvWHVouvanAkvfDeLKoNz+HkKCvGKGmHqtlAiRAko5pQbLDRFFUImuhzfHDyHGeW8=
X-Received: by 2002:a05:622a:58e:b0:4ee:17e9:999a with SMTP id d75a77b69052e-502a1e551b4mr166978451cf.33.1768841180580;
        Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm71855641cf.14.2026.01.19.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:46:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsOR-00000005IML-2VzR;
	Mon, 19 Jan 2026 12:46:19 -0400
Date: Mon, 19 Jan 2026 12:46:19 -0400
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
Subject: Re: [PATCH v2 2/4] dma-buf: Document revoke semantics
Message-ID: <20260119164619.GG961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-2-a03bb27c0875@nvidia.com>
 <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc75706c18c410f9564805c487907aba0aab627.camel@linux.intel.com>

On Sun, Jan 18, 2026 at 03:29:02PM +0100, Thomas Hellström wrote:
> Why would the importer want to verify the exporter's support for
> revocation? If the exporter doesn't support it, the only consequence
> would be that invalidate_mappings() would never be called, and that
> dma_buf_pin() is a NOP. Besides, dma_buf_pin() would not return an
> error if the exporter doesn't implement the pin() callback?

I think the comment and commit message should be clarified that 
dma_buf_attachment_is_revoke() is called by the exporter.

The purpose is for the exporter that wants to call move_notify() on a
pinned DMABUF to determine if the importer is going to support it.

Jason

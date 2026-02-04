Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433A40B6D1
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213419; cv=none; b=LijHPLTG+oh2WxmN8mh4E4EmKkTb4+0+CyiEnVWy7Ubf8yGGVDapfmZgFQ/iz4+19dDv7o1nTQ7W0EoOWoh86TLqO7eusjyxlIgT6opJJfbOkOfrMCt+zeMWpUacwE1WWxu3HprBVgV19Jnyl5GN8dn4pz7irn7fyM8a4p2jh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213419; c=relaxed/simple;
	bh=Ne+l1aDUaLXnO+/mFbaO6kEskLTskqAwvLQ5aTo6Qxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEwn3XXr+2I2bN2doE9Gho8Q3PvWh6pVW3FqlrQaaaDh35ODTi00fd5naPrMC+Dmi1Ulfa4GuD7UCDDS42djZEoDyf0x2gPCQ7rEjZ5Tr54Rmiv/+hMtghpO4WkA+7sj+PJYd5PVXSjZk/3jBaG7gmoIr5IJzAeHTuEDoAUh/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q3Up0cF5; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q3Up0cF5"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c69ffb226eso934532985a.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 05:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770213418; x=1770818218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRrqXVZVX7Z3YtbKGBkBfsPXFsl6FxGibC0bf/QAItY=;
        b=Q3Up0cF5yivGaZ6hVkFGA5JNx5l8NXN8Fjb6GMLwPMc3a2bXJGNlv5SfyRQdwdm7YE
         SQDUeHUWmJKn3wrrI9U5q1XP+pNgLcJK/4njp5uOSLj7tjKGHHZV2JBNgRzKcAbGFkWm
         avifna743req9ZZ6cE575rm+mEeS3UDwqPT0glrMpGM21NkJG7BoZvHgV9dtPPXCrtFo
         1DEAw0ir6gN1Ei41/2lW0czDqcXFyt5L2jp/RsXwR3Q0q9Gj6GWYnbP+RWEXRMNBds5l
         XZWxCZIvfqUWPA+OpcBfI7ozjYTaIPiy3In8khy2D9x7NL1B1B5I5BtoV33vYyQjd8SG
         5v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770213418; x=1770818218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRrqXVZVX7Z3YtbKGBkBfsPXFsl6FxGibC0bf/QAItY=;
        b=WFQSv2kz4H/C2jhRzL80mM8+iUL9tmHOCF6Gh1g/lct+YbByDBrLGkBfaMtEQKugeA
         QbKl1JijqnwnUqwuFr458TOD3kdbgPX7WNQ3Ne6FpUhRiaYA5No7pFGMS+rWHDMQMpM5
         o76njkCReIljlUKx8uMTDAEJgOgQw7AEVwqOWSg6BKn2cxs4wwsu9DNkTzZxPppFyjCx
         BLMuZNx00+yDlnT0cbJvQbKdId34pvCfM5GrtYOdBP6lg3R1JrADfScuzkNpvE2jV6md
         Y95+nhlhssVa0mmR9wt9FIaOvhUNn4DkE2DlvJ9r5Q8emK3ntX9GwHijJpeUE+y/pEO/
         M5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVrI5EmZti8CLxsESbeXGQGeXnUTM8EuFuqLLC/TSyQdysqzi8ePcns9nDcpa9ElthJT0gpmd2MajpS3f3O2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdDIW4grIRcXSWzGMztDrDB8f04dApA04bmH+bE/jxyKbfDwvr
	YNV3BmUE7Uv7CP5y330BxLM/V6PxBFrLlPtorMv/O5FLMbjh5POTp4m5UQS+dVPRkQs=
X-Gm-Gg: AZuq6aIamhXsjhYXSBzpV/4jHsP/MASSgnXnDiKx51WT1YUEKmZ/dbCG/7/2qx4uzop
	tlsLog7pHomCFmznJfzDc9aRrnPNuXPdX7MZzE+YbdcfK9TLgTcmZ3vpz9o8TADu1tOlhNziV9G
	s18Pj8Tcd3r0vs8EQEfSdyhM7on8wQQJYz8xqPnH2R70Bg5uT6La1kD3a5wV0xseksFpdRrddKE
	kysj+lemXki+vHoi7H8OWHkMUQw8D9kGCR/58vhjIgZr0PuAotHZ36hZKyf4poJ/YL5D9mBENvQ
	/11CMnrc/A4xUjuwgfVUGk0eCPayZaHrYGmOdKfM7mMiN4Pd/hTyXLAtlWoF+JVtV92ktsXjWGa
	tUA8YwnKXifHUuEEd/8KspM44hdQuwwKtzzEI7m3Mtaa0hp2Q5rqcts/7ezfqXYyIXcfcfilAZH
	BDuZPUCfol/d3W7yW75geKyFCJpumn2Z+em4rcnqsOINxgE2+NYPFfuLOaUaFjO6jhlog=
X-Received: by 2002:a05:620a:3953:b0:8a1:21a6:e045 with SMTP id af79cd13be357-8ca2f82b068mr371751685a.19.1770213418187;
        Wed, 04 Feb 2026 05:56:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa552f2sm187407785a.11.2026.02.04.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:56:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vndNJ-0000000H1He-18eG;
	Wed, 04 Feb 2026 09:56:57 -0400
Date: Wed, 4 Feb 2026 09:56:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Maxime Ripard <mripard@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <20260204135657.GE2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal>
 <20260204081630.GA6771@unreal>
 <20260204-icy-classic-crayfish-68da6d@houat>
 <20260204115212.GG6771@unreal>
 <20260204-clever-butterfly-of-mastery-0cdc19@houat>
 <20260204121354.GH6771@unreal>
 <20260204-bloodhound-of-major-realization-9852ab@houat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-bloodhound-of-major-realization-9852ab@houat>

On Wed, Feb 04, 2026 at 02:44:42PM +0100, Maxime Ripard wrote:
> > From what I have seen, subsystems such as netdev, the block layer, and RDMA continue
> > to accept code that is ready for merging, especially when it has been thoroughly
> > reviewed by multiple maintainers across different subsystems.
> 
> He said it multiple times, but here's one of such examples:
> 
> https://lore.kernel.org/all/CA+55aFwdd30eBsnMLB=ncExY0-P=eAsxkn_O6ir10JUyVSYdhA@mail.gmail.com/

Woah, nobody is saying to skip linux-next. It is Wednesday, if it
lands in the public tree today it will be in linux next probably for a
week before a PR is sent. This is a fairly normal thing for many trees
in Linux.

Linus is specifically complaining about people *entirely* skipping
linux-next.

> So, yeah, we can make exceptions. But you should ask and justify for
> one, instead of expecting us to pick up a patch submission that was
> already late.

I think Leon is only pointing out that a hard cut off two weeks before
the merge window even opens is a DRMism, not a kernel wide convention.

Jason

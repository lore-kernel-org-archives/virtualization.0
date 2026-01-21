Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EB48C412
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003992; cv=none; b=kHxk6mToz5Wbu6wZ36183bdm+W/ceUSZ6DTk5b8h6/K74lY5jJz3aA9C49qvqXR/G1YXWTYnMKQtWPHpSicPWfiBHWF4RHNfiCrHjWxYIMK3x/Ff7ECjH1NDYL2U3dPIpXARTzs/uN4+cfznSnMKBM9ozsunlyJK/uO3CbncsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003992; c=relaxed/simple;
	bh=tR+AFnMPEtzcHlOQnrldwGxBaKLMhAwLG9LVsjQDN2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK2IU0rwsSudhr804onnrcyhN578lGxi8ED4XQF7LRsT081RnH0ImR7Hk6tuIca8vC4slZ6X2qvErF0Ho0kPB8AbwA3hwUiTm+yDo7zsf2bjB8s8z4PsEWqvv9lQb51hC5csKI49I5YAC0d3M01EOshADote66Tsz5I6fZAh54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QR2R02WC; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QR2R02WC"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5018ec2ae21so57076741cf.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003989; x=1769608789; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrFwAYZYjJdV2hWLBqDeijXZcUvvrfRZB3KhQxPCGpU=;
        b=QR2R02WCYbAliyryBsdWSWKV2o5gTS41Avup6vdCMregM/OFtJLG6vTHY66Fuut+KY
         2r9r8rJkSa3Tb3UD7WMDlQMVpQHrJf6ME/Z2wF4WDTERtzWZXN8rDOiUh86jmGXnV2Te
         1mh07IP+Te7BfG6ffCWe1mm5VMaDhdyW5yk5Fg8JZQrydsIDHls+8LL9lcuyFLN0Ae/s
         O+NJ40cTrGBhS7Or/xLCUwiWLhFSxH5hUqtz7cts/IgnHgK2TlBpjQU3SQlMq4olkjmx
         YSHG2o+vRxjoIsBmn5TBZybRXJrp9Z/pKdLTAb2WUeWS77URN+ex+MXaUoIFnmYeog7M
         Ua5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003989; x=1769608789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrFwAYZYjJdV2hWLBqDeijXZcUvvrfRZB3KhQxPCGpU=;
        b=Uok72ntJu/R7eA3roUP49jlTDImv51tGKz0zSnb4Gah4wf8SWf9TD0MjzVCTV+eVhF
         ZiLWoZ9FMOXJY73/D0Wx6hEOfDY3Bqxcrw8tVqvaDl0xaqpwWHfW5KaqCeyok1D2nRuv
         Z8IAKHKVw45/aINZyat0CEQI30o5jNzuBxkffQaKs8VO6RL/GVigJzKDB0Qg9BWVM9g5
         wKY7e0JCYusG7A27EKNIpwaDwcG8A2r9qRyBn2V1ePhggyeitIOPbz+edh9qBzAAbjnT
         oTlgEAQR+vwnxPuiRnH3PUceGgi2A3iPnxp37dcuQqUeAskZj8GuLVn+uiw1nX4SE7m2
         OcKA==
X-Forwarded-Encrypted: i=1; AJvYcCU3LwG7CZXCWNip3XjlE1dwyZQwExficTLls5A1W+dU1COMw+CPA4Y2PdAU3OLJE0vZQN7IKTH0F6iEvZQG2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqYfybf03wl/fYUk3qqKUN9r2dYPJkRewJ1pmFynqQIT8GUsOV
	NCZarHGh5Hq0aBYNUd3ZSBopz6ge8Uxo/wbIBU+O69OmNlSUCszFpMlxzhf0LiWcZ88=
X-Gm-Gg: AZuq6aK3nCE7iNRK4yELHUd365fUry5ETMGp1VE38zGP+i78h/AErmK5skOigwS64Pe
	9totvIAf4BPbNqOPuVIg4Bl/PWXMmKOs5sfZvSBuXtQ/h2h190G8M1lohhkRcxia5bvydEc1+c5
	AorMqlYj70Vh3A24TVSlURq97cSBNn2VbDLHzoh380lA1ff66bquVnOVb1c9vFJTJm7m4N20WNg
	7tc58PszhUoZGHXP/5QYMJq0AdqBB44nU+lTA9jb+8fqSnhSOMZRzc2kmPzGXOehtFaZcb1Gztr
	8Fy2JR4hKF97wo/RY0J7fxdH9Oe2J9Jlyu5nuZU5UUdEMv3gmRixIYk2YJcHsnO8PUUZZlFQjCo
	N+hfMIG7ecmKCSJ8xjKknhex6VIcJjfA8o6ho7akG1xT4lzYaMkhNi5xLGyL9jJ85WxDFEW/7wU
	KJ3ox2kqD9JjGfF9oCLrv7EswEiTakyJLO//xC9cwi1xGBn1yPm8q0GhvtVcPH+7HnSVs=
X-Received: by 2002:ac8:5d14:0:b0:4ff:c5f7:f812 with SMTP id d75a77b69052e-502d855fe29mr65972911cf.38.1769003989233;
        Wed, 21 Jan 2026 05:59:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f480sm113423091cf.13.2026.01.21.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:59:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYkO-00000006E8Z-0XjE;
	Wed, 21 Jan 2026 09:59:48 -0400
Date: Wed, 21 Jan 2026 09:59:48 -0400
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
Message-ID: <20260121135948.GB961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
 <20260121131852.GX961572@ziepe.ca>
 <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>

On Wed, Jan 21, 2026 at 02:52:53PM +0100, Christian König wrote:
> On 1/21/26 14:18, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> >> The whole idea is to make invalidate_mappings truly optional.
> > 
> > But it's not really optional! It's absence means we are ignoring UAF
> > security issues when the exporters do their move_notify() and nothing
> > happens.
> 
> No that is unproblematic.
> 
> See the invalidate_mappings callback just tells the importer that
> the mapping in question can't be relied on any more.
> 
> But the mapping is truly freed only by the importer calling
> dma_buf_unmap_attachment().
> 
> In other words the invalidate_mappings give the signal to the
> importer to disable all operations and the
> dma_buf_unmap_attachment() is the signal from the importer that the
> housekeeping structures can be freed and the underlying address
> space or backing object re-used.

I see

Can we document this please, I haven't seen this scheme described
anyhwere.

And let's clarify what I said in my other email that this new revoke
semantic is not just a signal to maybe someday unmap but a hard
barrier that it must be done once the fences complete, similar to
non-pinned importers.

The cover letter should be clarified with this understanding too.

Jason

Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5522B8A9
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125457; cv=none; b=T8r7qZKfTQYZdJyZSFmuyTRa5K3qDdMkkf+TYNjnQ32Q0w5yFOJryN77nQSIc710apzIDW0jMjH35KR4seVxe0Bk+cUIJLnxMzewCcUJMNdSG/uj+EZb/bJygXQSTmcKLdzoOiUBlCotqpvdrErWwZFlr5AcdAQkN2n60GJZ7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125457; c=relaxed/simple;
	bh=tD5f+h84ofqnK09ZH5j1acZDqC2EpodfEzB0D4Jj1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcTDEFLEREEaDGFPkj10uLCKcqE0MygJJSg3dbRTRN/p66YarpqAE75tDEGhTCSbuIknV1bqieRA/0rZvef3uKxcg7CG6KS5uauBwYwDMn33+Gi/DJHj1FrV9mqww+yn4ZJgmHUJ7e5gz/QleezzTVyzgfZeOqVW5AfIH4CPaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QaWjTl2G; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QaWjTl2G"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88888d80590so28525196d6.3
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769125446; x=1769730246; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
        b=QaWjTl2GNlmqM7AA3iQDtHNOQnxRwDeNgeisoyFAlSa41uKV2oCHE/C1SKVqa3ldRN
         d3K8LsS/SCL3rKF7PgttV2xHEFzVvoj1BC+WJi+6X0m0FpVyl7eGHyRTn3VWJ7+MBeTe
         EVQ+lXtrtPEj/CFjy8uKnfwZbgE5VnUM5bL6la2BbzbkGDWORjHQjKeQ5RCcNbPTfePl
         35CiTTZwGuHCTuZ6I8Ugw4sN1ku1F63ualVuEaIZlBTa6alhG+mELDueTI27/HFVFzSj
         vwiT4UexK9DxcwDTmeQVJH/IU0/mF8MApqCT4CE3Gv3f2hJN6Q4SVHWaMTtVkhjOAvhc
         gocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125446; x=1769730246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
        b=QdB5tU/qfRn5r7niy2/j+guGOGam5iUj7PDA1pISYATNviqKFwRKkgSghHQdn2bFdL
         hX5gK0l9QvROD4shyhD8Ui+ekrKmKJb0/i2CaHO9iYsU6Pc8o+LCJSXfOTwFuHX0eU+U
         wTZetn0GKmIRwZSoeR3NWXqzR3JAOp2NWaevE/3SbKxPBNBNo0nONeEbS/c/5zg54zgN
         XeDlhGCoHkXAHkKI2RzPM9+Dqo4ZRST0pR06ARN+uhciSirMXssTL4Jgr77RR8HpY8Ri
         uY3gKtg8jmgHL94IgEPFTUiyCAgYMNIxWXfiF0ZGctNCeUeN41foSnxLNf1qyMx8XtWu
         OzsA==
X-Forwarded-Encrypted: i=1; AJvYcCUrdSoOz5LjOX5CDF/91UZ9ml5230WRpPYcxaL5MHhNNlzvhvNG4pjRlIQYD2bZ24o+5ZzhTGBhLMkQHrDBpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz05mYoqwhqfyIWqwcJ2ntHFnhpJlmxHIO+31Iou3s0NJPqmd65
	2UXpUxyeIulnNDyQHcMsLrdrscqPX4fZ/t7nEq1Tdvzphh3cdSDFGHpQ4EpaygVgfPo=
X-Gm-Gg: AZuq6aIof5MrJa7Tm+gDkm3lykX0BkEJ4gPD2scvlY+iQidlIKtu4eZSv1QwOMNzVxo
	QZWXaQ2Pl8NbbCX0ATlSPIa/af6CedNPccGJdLHeJA4UoJFj7NTLrUkoaz8IT/o8eHWYMTbEXOi
	YembCMXpdbJ/Z6PvD8nf8/vmUhzMMqAdd6bKFxOO+/EhD4bKpUR8lxy/uTGjwHcT4AsntDQxS6N
	hCg6C7XNtX4Jb50Ogm0RCDL2DA8p1EM8fwn81o/io12xrIfXM3EDIpZrQgSRhnUnZzDOMfYIzaD
	smK6Yyrpk26SunBse2+2LcKvfoKK4aFjVilP6BMKKJxZIQ69MN86oRZ9Qt9gVRSvu4ZIz4Uvzev
	liKbZKoco9sm9dnOf2y2eZMLMoFWhNE6MNRE2XtZCAsOmXqviQGbHLXig6onD1ISxW+lR5vd0eG
	wUP04slz/ll3pLQ/A/WwuKUWLlueOFDGCMqgRCgWxOA6eJ4wYXOSStvhN3Sq/XKLbjA4w=
X-Received: by 2002:a05:6214:2269:b0:894:6530:efd1 with SMTP id 6a1803df08f44-894901ac85dmr20677696d6.19.1769125446269;
        Thu, 22 Jan 2026 15:44:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854a6csm44128885a.41.2026.01.22.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:44:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vj4LM-00000006gRo-0Lke;
	Thu, 22 Jan 2026 19:44:04 -0400
Date: Thu, 22 Jan 2026 19:44:04 -0400
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
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260122234404.GB1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>

On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> >> What roughly happens is that each DMA-buf mapping through a couple
> >> of hoops keeps a reference on the device, so even after a hotplug
> >> event the device can only fully go away after all housekeeping
> >> structures are destroyed and buffers freed.
> > 
> > A simple reference on the device means nothing for these kinds of
> > questions. It does not stop unloading and reloading a driver.
> 
> Well as far as I know it stops the PCIe address space from being re-used.
> 
> So when you do an "echo 1 > remove" and then an re-scan on the
> upstream bridge that works, but you get different addresses for your
> MMIO BARs!

That's pretty a niche scenario.. Most people don't rescan their PCI
bus. If you just do rmmod/insmod then it will be re-used, there is no
rescan to move the MMIO around on that case.

> Oh, well I never looked to deeply into that.
> 
> As far as I know it doesn't block, but rather the last drm_dev_put()
> just cleans things up.
> 
> And we have a CI test system which exercises that stuff over and
> over again because we have a big customer depending on that.

I doubt a CI would detect a UAF like we are discussing here..

Connect a RDMA pinned importer. Do rmmod. If rmmod doesn't hang the
driver has a UAF on some RAS cases. Not great, but is unlikely to
actually trouble any real user.

Jason

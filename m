Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289682ECD32
	for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177504; cv=none; b=YCIP9Xv6vn5gp5akJJtxsbWBGt5yFSBKiP9o6eMFbf+V3ewFgy+h1t4VZjYtata6QMqEK/BYctgxxLHTmW6oCDJeqnWUOwOktE7bWjJf5C3JsnhVRw4z1UO86zA5Wvkz5YIlXjm0tnJx0FpNCtsd7jB4H9jPnji0UjMonIXb8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177504; c=relaxed/simple;
	bh=58had73B0AHtHiPbJGrC4Y2rRw/02IpIYPrJvcRhLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCuGHbCUFhNELy9r/IEJxHa/eBprXci0fQPhRiic/PgDZdYZuGMI6sa5l/tQjPlG87BrVDAjAZVDam4knU9JSAvGghSnZAFV+upsQpMD+hIbx+BA2VwT+e+pjKZaPv6TMkEIWbMblVyK2Pd9kEcwSCmwGq4nwssmpsI49LFrQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mSnk0Ipf; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mSnk0Ipf"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89469143ebcso20501706d6.1
        for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769177502; x=1769782302; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=mSnk0IpfOBBMuMUMPYt7tKy0WpZutBsRIKFWWmRnURMYE0Kgit5oONUF6FKeLZIHAb
         e/hgSrCNeUGS2vJimoiqEf+sISGUA8utcSoRkJacIutEquJRkrE0J4wUK6EVEoWk3o3G
         qs17+OT5RUGE096PMnjOqPJWnnHchvstALQTn0WpnyjoxWKVjB0EATaKpuhAYTkC2OzN
         XVdrs/6255bYyESOHfn7ttgvs+GOcjtmhRr0gSNQau1JOFFiR9xtXKK1Qs/Qv5JUUz+O
         oIL+45OphWLO3GTenkJAUUm5RVuet4piojS3E5fBTGLVgGiWZhrnT5B682Uki+9yAw4d
         6rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177502; x=1769782302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=m3JrdcLDiEepIAWplhTyalOyX/ZBCy7Al7Fr+6FsJ1S4OuoylUYOYYs25DkV6o5TCH
         o0xpiqIhucAbMAUngd8DcKDJl2AZbmgA7+hfcuHXVo/i1OGL5kqbfBRQx1qVzQi1HXKR
         McnqA1Vl7B1TYoBDa92cS7Zm8AS52DOwWaOokfGhdBeI0k0LxwaI7va409KeyxhvIF6a
         h06y/dGVUosqZYEcGCA99TsvAi0eVoq9ccB5AzK9g9XgHAzB842wlW3N96MVttYlimRG
         D5iJ410iAtzihKtrA/WslFqh7VxKAH7bH0NcgJAd/OVPLGBDEMyAHIqQ5MFW11q4//dM
         SaWg==
X-Forwarded-Encrypted: i=1; AJvYcCXhnSxHl/TvijgWar179jxmf5Mf8EafDeBw+fP03CHRlZAVeyqEg0f+Vs3vhmK8A7/pc1SRsnCHgrRZ20uV7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUakgvXTp5JmmbCRh5uFZBSzK37GxJZmBdogKosF4E65nQZRZs
	Y5KYWm0lQgCLRohWiVj1sqs+QS0NGiEhdW1aoNFrgF26VceELiZktJBKqnJEvpDoGgQ=
X-Gm-Gg: AZuq6aJmyhmdQ6vojdNuD9Lbsl6IxMb7h5jZS7Cg7ZrubzTsGFr8brQahtywbBrjSMt
	ZSNuBhds2OAvVyNidZXJHS3VnP8SKUTuFEEKAd2MwCAbabzWwv/4ObnznzRK1nzXjjELqNGt4Pd
	lFy5rzqupXJy8gF/HOnkYrc5v2Zupm7dKYtf6WFqMTZ7/aSNlgz0so4vLcWDPiFHByOeueBr3av
	xIPUyeYzA+4sWGwFx6ndVysaqWJO1Ve+DQaWGsPt3CGpcUZODMPTsL74LH3BwMeksMj35gaRZml
	sfTeTSJ9QqWS/ywTZ84lZSU3vAqzsSXRfFuoeWCE5NfoYENo3rOQWswA+5tdH1enpaDxhdQDR8n
	o6qz0o78qZJe77vJYOmgJ07URjtDJBVAGsB6Vs67482ODGLbdVocf6mBp4QmRUqqRPMVpxUKdRq
	neZY1ojY8oBKeLnu6ndQIYOn7Q5fsbf7JTwtbQ2/sOGnIne3X+9j6h34nA1luz9Hbf9ovlHkf5D
	ddxWA==
X-Received: by 2002:ad4:5c46:0:b0:88a:589b:5db5 with SMTP id 6a1803df08f44-894900d6bccmr42275406d6.0.1769177502022;
        Fri, 23 Jan 2026 06:11:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c8fa6sm187731585a.4.2026.01.23.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:11:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vjHsy-00000006stw-3Bfb;
	Fri, 23 Jan 2026 10:11:40 -0400
Date: Fri, 23 Jan 2026 10:11:40 -0400
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
Message-ID: <20260123141140.GC1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122234404.GB1589888@ziepe.ca>

On Thu, Jan 22, 2026 at 07:44:04PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> > >> What roughly happens is that each DMA-buf mapping through a couple
> > >> of hoops keeps a reference on the device, so even after a hotplug
> > >> event the device can only fully go away after all housekeeping
> > >> structures are destroyed and buffers freed.
> > > 
> > > A simple reference on the device means nothing for these kinds of
> > > questions. It does not stop unloading and reloading a driver.
> > 
> > Well as far as I know it stops the PCIe address space from being re-used.
> > 
> > So when you do an "echo 1 > remove" and then an re-scan on the
> > upstream bridge that works, but you get different addresses for your
> > MMIO BARs!
> 
> That's pretty a niche scenario.. Most people don't rescan their PCI
> bus. If you just do rmmod/insmod then it will be re-used, there is no
> rescan to move the MMIO around on that case.

Ah I just remembered there is another important detail here.

It is illegal to call the DMA API after your driver is unprobed. The
kernel can oops. So if a driver is allowing remove() to complete
before all the dma_buf_unmaps have been called it is buggy and risks
an oops.

https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c

As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
is not allowed..

Jason

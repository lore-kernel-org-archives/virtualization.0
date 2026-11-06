Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981228;
	b=xo+QiYltnQ2lwzvruBq7VX5McxP4sjl/kxz3utAg+nNZJs/DtlG363HPOQYFGohCOIF/
	 rWf2A6zK4yO4+D8gg/j54o7YKaDb0Gk7y5fc8IposCClcyDktryKJRl0/bVzWVVhxqkeQ
	 WSaIJwpin2zswraf0Qt/yBAfVvFSUsyNhfAht+8YFIcI6X4/yepNmJK42//A8Z4hhLCHu
	 Oezf376pN6Q0Cgqdj1G50+Ww8+uywVEf5rQ2fhTfOx3dMLLmAone8drZ1u2kuHYNmkLQE
	 S2hTMf2Rjcnsv/zvhrbK90yhfINIju4tYWXu6qEFDFSs7I/zZbUQQPljTuNnsVP6XIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981228;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=24tcA7CkBj6LFWiedM+EjtolEDXjlrMm3/iSbAJVeAU=;
	b=ozWRiHawXjbVIPOlQh2OIHgjq2G3VCZFptRG3+ZMGbTPuvREWSsRZqIz6CKRoXPIyq8S
	 Yunh/lV1ruEQNHvwvxM8qCFzh4csQAGH7baPoAywUhJnGMYyJBi6Qglq3Yc7sNs8Cg5yZ
	 C1gbHmHlJC612qr3nxbHLkLkJqyN0y8fJqpolK7r8xA2mvD3I+zdFZPt9ws0pyPJkJapZ
	 SsG0PQRPLejfcE2ibXC0d77sIHJkfb3BcCmm+1GvBAe5YM2ontm8RABEdcq8BrKNoKbJL
	 Wy1GwyZwiPTg0LC7GzU7WJeIc7RPewrmJlqPDqNS7tMrLVgTDyLaM6vRCSCtU6jKIEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TR/x0BVs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A7606A326;
	Fri,  6 Nov 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TR/x0BVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9321F0089F;
	Fri,  6 Nov 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981227;
	bh=24tcA7CkBj6LFWiedM+EjtolEDXjlrMm3/iSbAJVeAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TR/x0BVsUbOGO2/IySWpntHAUb7M2R3jo2gI0q/2mExprKo6qljhE1F8WAv4R6kcJ
	 x7dJ+SK+L6E1+37UBNA8kqXdoxsMR4cyqZ2WXgIzSlz9o9XBQQRTcPT7LZmmmE1m7f
	 OFfmfqmXsKEMR0jL1nYfsBW5t2WSuskIIa1d8TUtZdcRtOfYB78k2k+9t/pmDCrmO2
	 /rJOWlucwV1am6WOd06eu9v9vXvVsq/MPXSTHEEaj4tVLSmcMRGG+obfMg0oKWGph9
	 ByKZ+tfx9nJFuTQo+Eb7pTNNdqKh+/dAazeFPJ0nEBamH7B1G9WAiqQ9ZkW1qJOcMP
	 GauGt68yKqbZQ==
Date: Fri, 6 Nov 2026 16:07:40 +0000
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Cam Miller <cam@linux.ibm.com>
Cc: virtualization@lists.linux.dev, iommu@lists.linux.dev,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: iommu/virtio: design question: hot-removal allowed?
Message-ID: <20261106160740.GA76938@myrica>
References: <6e6eaf23-9194-488b-8961-63cc062024ca@linux.ibm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6eaf23-9194-488b-8961-63cc062024ca@linux.ibm.com>

Hi Cam,

Thanks for investigating this

On Thu, Nov 05, 2026 at 03:54:20PM -0500, Cam Miller wrote:
> Hi,
> 
> 
> Testing on x86, I noticed that userspace supplies a mechanism for hot-removing a virtio-iommu device.
> 
>   echo 1 > /sys/bus/pci/devices/<virtio_iommu_dev>/remove
> 
> Hot-removing virtio-iommu should NOT be supported, right? The intention is clear in the QEMU source,
> which fences off hot(un)plugging virtio-iommu devices.

We would also have to prevent:

* unbinding the driver. For that we can use .suppress_bind_attrs

* unbinding the transport driver: virtio-pci, virtio-mmio

* possibly other weird cases like PCI bridges upstream of the IOMMU
  getting removed

Module removal is fine because the IOMMU core holds a module ref for
each endpoint.

> If I am correct, then shall we fence off hot-removal (perhaps by simply omitting this remove file
> from sysfs)?

That would be a PCI core change, I guess?

I'd much prefer handling forced removal as gently as possible in the
viommu driver, but as you've noticed, we're not there.

> Else, keep reading...
> 
> ...I believe I have found two bugs in viommu_remove() path that I would like to bring attention to.
> The first bug is that the echo above causes the following kernel panic.

Yes please send a patch

[...]
> After applying the fix shown above, a second problem is exposed. Unregistering the IOMMU while
> endpoints remain active is like pulling out the rug from underneath those endpoints. The following
> warning catches this case.
> 
>   WARNING: drivers/iommu/iommu.c:743 at __iommu_group_free_device.constprop.0+0xb9/0xe0, CPU#1:
> bash/1250
>   --- snip ---
>   Call Trace:
>    <TASK>
>    __iommu_group_remove_device+0x95/0xe0
>    ? __pfx_remove_iommu_group+0x10/0x10
>    remove_iommu_group+0x39/0x60
>    bus_for_each_dev+0x85/0xd0
>    iommu_device_unregister+0x3d/0xb0
>    viommu_remove+0x1d/0x60
>   --- snip ---

Device links would likely prevent this sort of thing. I worked on it a
while ago but at the time I was hoping the new fw_devlink would
automatically create those links. Unfortunately there was (is?) at least
a problem with having the IOMMU on the same bus as the endpoints. So we
should add explicit device_link_add() in the driver, to force endpoint
unbind before viommu unbind.

> ...Point being that hot-removing virtio-iommu is currently broken.
> 
> In summary:
> - Should hot-removal be supported/allowed?

Reluctantly allowed, I think

> - If no, then how shall we fence it off? Via sysfs?
> - Else, there are some bugs that need to be fixed (and I would be happy to work on that if that is
> not already evident).

That would be really welcome!

Thanks,
Jean

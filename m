Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B551C831A;
	Wed, 24 Sep 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735889; cv=none; b=V4OwP3AaB7euoeU7QghzjyPNfl/S9JxzywvKkA1qf8yOG8Bg8C1GhT9a2ZgQHovyLVxjxVO3LYzGhGpAuF382OrR836ELQlasAOkAb+WsVq0Q/tO/LLztTYy/Jc7cfzFXqsGAH6FCiYm0TT1DGER8rTqqvCVzcCdlbzOXYuc2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735889; c=relaxed/simple;
	bh=atiga3Cl4KuVb0GshrSWxi1oAcJp0lpigTHD+s/jZK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YemNLhvBEt0zf0cbYz6rqZIb1tfIhnVhP94lV9ekVHHlpl0cBiCs7v1xjlmlg9T1J60Emf9W49inKYTIEOewEmXu3O5TzNS06MjN0Mc1gnuT0rmSL/Bwi3v9DazB44mfhIk5RlRqTyG3iO8F+tnikdLoPO7Kx2zk0BMaXXyvj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EA67106F;
	Wed, 24 Sep 2025 10:44:37 -0700 (PDT)
Received: from [10.57.32.18] (unknown [10.57.32.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39EC3F694;
	Wed, 24 Sep 2025 10:44:41 -0700 (PDT)
Message-ID: <e105af78-3edb-448f-b3c2-ea28defade80@arm.com>
Date: Wed, 24 Sep 2025 18:44:33 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iommu/of: fix device tree configuration for PCI
 devices
To: Shyam Saini <shyamsaini@linux.microsoft.com>, thierry.reding@gmail.com,
 robh@kernel.org, joro@8bytes.org, jgg@ziepe.ca
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, will@kernel.org,
 jacob.pan@linux.microsoft.com, eric.auger@redhat.com, code@tyhicks.com,
 eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
 bboscaccy@linux.microsoft.com, saravanak@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, lizhi.hou@amd.com, clement.leger@bootlin.com
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-3-shyamsaini@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250909154600.910110-3-shyamsaini@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-09 4:45 pm, Shyam Saini wrote:
> Individual PCI devices lack dedicated device tree nodes, but
> their IOMMU configuration (including reserved IOVA regions) is often
> defined at the PCI host controller level in the device tree. The
> "iommu-addresses" property in reserved-memory nodes specifies IOVA
> ranges that should be reserved for specific devices.
> 
> Currently, PCI devices cannot access these configurations because their
> dev->of_node is NULL, preventing of_iommu_get_resv_regions() from
> discovering reserved regions defined in the device tree.
> 
> There are at least 3 ways to reserve iommu-addresses for individual PCI
> devices,
>   - 1) By dynamically adding DTS nodes for individual PCI devices using
>     [2] CONFIG_PCI_DYNAMIC_OF_NODES, this requires hardcoding PCI device
>     IDs in DECLARE_PCI_FIXUP_FINAL
> 
>   - 2) By adding PCI devices nodes either in DTS or by modifying FDT at
>     boot time in the firmware, eg [3] However, of_iommu driver doesn't
>     seem to handle individual PCI devices, additionally this approach
>     doesn't seem to much scalable for the complex PCI hierarchy
> 
>   - 3) By configuring PCI host controller DTS node for PCI device so
>     that it can inherit iommu-addresses defined in the parent node.
> 
> This commit addresses the problem using approach 3) by assigning the
> PCI host controller's device tree node to PCI devices during IOMMU
> configuration, enabling them to inherit the host controller's device
> tree properties. This allows PCI devices to properly discover and
> reserve IOVA regions specified in the device tree.
> 
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>   drivers/iommu/of_iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6b989a62def20..077482917e3e8 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -145,6 +145,17 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
>   		of_pci_check_device_ats(dev, master_np);
> +
> +		/*
> +		 * For PCI devices, ensure the device's of_node points to the
> +		 * PCI host controller's device tree node so that reserved regions
> +		 * and other DT-specific IOMMU configuration can be found.
> +		 * PCI devices typically don't have individual DT nodes, but
> +		 * their configuration (including reserved regions) is defined
> +		 * at the PCI host controller level.
> +		 */
> +		if (!err && master_np && !dev->of_node)
> +			dev->of_node = of_node_get(master_np);

This is just wrong. Disregarding the fiddly aspects of node reuse that 
are completely ignored here, an endpoint device is not the host 
bridge/root complex device, so it is wildly inappropriate to associate 
one with the other's DT node and all its properties, resources, etc.

If it truly is the case that boot firmware has somehow "reserved" some 
small amount of *IOVA* address space for specific endpoints (but without 
any endpoint or SMMU configuration, given that those both get reset by 
VFIO?) then frankly it *should* populate the PCI hierarchy in DT so it 
can accurately and truthfully describe what it has done.

On the other hand, if as I suspect it is simply the case that the host 
bridge has limited windows into system *physical* address space, like 
plenty of other systems do, then just like those other systems that 
should be described as standard "dma-ranges" instead of trying to wave 
silly hacks about.

Thanks,
Robin.

>   	} else {
>   		err = of_iommu_configure_device(master_np, dev, id);
>   	}


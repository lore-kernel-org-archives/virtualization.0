Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB8477285;
	Tue, 18 Aug 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059992; cv=none; b=msObqoimVfXRl3OsA65r9UH0naS0x2jUDYCktEWU6wfA6wDQy44qKuleSV11ddHokQkYDP4NTg5rUEufOWMpX7WRK6Jumypmx4O8RbYNCTR8IqnjV/ZvUeQXAYCxII8zBeuykv0+n2iMHQGAQ2TRgKzWP96l9TGF0k9YgaDanuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059992; c=relaxed/simple;
	bh=zQAWgqdGYKgXHibSUELUPJWa6ELvFlQknaivtwA+BIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meYUKeyTeIbMFsvq79xNjoqQe9fwcKbTYeI1zrGDf2OKZNdBCetWK/H+agQCsfHaEmxHSbicPMyEMtsFzVTQiyAZvE6Z8a6JO4ZNRziHNvljJCRx4VVeL7c8XVHT6Vt3LKXND6YBrnagN4ahpOQd8E9Qcd5MrN0ZGkjeaPyUAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAfPfo+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAfPfo+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCDD1F00ACA;
	Tue, 18 Aug 2026 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059991;
	bh=GsAWXxN10cRN+8CUfIm7pyw2iUPg5jnmD3dMiCwHuUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XAfPfo+1qLQNkLY8fd/vzrGFGrlJXMOawyXyxL/id8KW434JMv/x6jguV81bbdhmt
	 2dxHSVVhiNJE8gozMR26gQYvn3aL/phTiE2zCaRCfBjs2NM2er1CD6cZVx200UUNpd
	 eXA3ta9rSKb1l1qluBK2A7HMhXLSbDbOXiMvNASZcO9925xTkHmjA4zm8a2iSD6BTI
	 R3jPv13c7RLRDSS2y/9KACY878n5wHPL1d22T+Jsj3wrTghg2K5ioxa+lpmE66b1HS
	 jyE5N29PbE9cdjPPAmtw8ItymizcOqPcOEL5IokqoBHwqmVUDrEjio65A2BPxMK7n5
	 X8NEExq1b15dg==
Date: Tue, 18 Aug 2026 14:33:39 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: LiMing Wu <liming.wu@jaguarmicro.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v2] iommu/virtio: Add debugfs state dump
Message-ID: <20260818133339.GA319267@myrica>
References: <20260818123618.637-1-liming.wu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818123618.637-1-liming.wu@jaguarmicro.com>

Hi,

On Tue, Aug 18, 2026 at 08:36:18PM +0800, LiMing Wu wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> Expose basic virtio-iommu runtime state through debugfs so that the
> relationship between endpoints, IOMMU groups, domains and active mappings
> can be inspected from a running guest.

Thank you for the patch. Do you have a use for this feature, a platform
with virtio-iommu?  I'd rather not add new features to the driver unless
someone needs them.

> Create per-device files under /sys/kernel/debug/iommu/virtio/:
> 
>   status    - negotiated virtio-iommu features and geometry
>   endpoints - endpoint, group and attached domain information
>   domains   - domain type, endpoint count and mapping count
>   mappings  - active IOVA mappings tracked by the driver

endpoints, groups and domains are described in /sys/kernel/iommu_groups.
Mappings are not, but a VMM like QEMU can provide a trace of ATTACH,
MAP, UNMAP requests which is quite useful when debugging.

> +	seq_puts(s, "features:\n");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MAP_UNMAP,
> +			       "map_unmap");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_INPUT_RANGE,
> +			       "input_range");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +			       "domain_range");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_PROBE, "probe");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MMIO, "mmio");
> +	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_BYPASS_CONFIG,
> +			       "bypass_config");

Virtio provides the feature bits in /sys/bus/virtio/devices/. Not as
convenient as text description but a simple script could help decode it,
for example https://jpbrucker.net/git/iommutools/tree/lsiommu.c#n743

Thanks,
Jean


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808229;
	b=DqDHp580h3A0aZDIjI06rVEtKi6Qb6ISArJmNF81AKHaHsQaFAWVCoKT6O0Rzya0YGL+
	 y8rFnsCJtXKYOim8AGxM/QWy0ye35bN7Qb5Lh+33Ug4PQkovHEGyBWqmziasKCcSNSWPS
	 FL/jJjiEdAmy3BTiTgk1Nul5kLycR+1vSGjumRlQsJqJdimrZJKnBGJW8AxlZYeXPgimc
	 0/Ed4nNIhZwrhWJeeMp2+6YaAhfzaTxfiacuGnDnLNOtuzFabPNtxEPUa1APAwEj1wgK5
	 GUln7FGAXOwPpvpVQHxAn00cHsuxvW6TyTQHbzZSd3z78UkbzXLRiJo6whViYUcPQDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4z0jvqdS/1LMWIjFo97DLyqM1S7YnHqeCK2uONFB0l0=;
	b=MO83QFkT2YdfJtyKLkx/y023AZAobTdDtkE7doTUWNuxma6dgdWnThWwW3qx2EqNnI85
	 Jn/ciP63h/cV7Ngbupc3wRSKxJARrtc6lqWEPe1B0VNk+oZDKZJ8qx2sLzxeo8AnRU2u1
	 B+rRGNSia6VszK44Xnecs3ApB0LtkcKKqXKmGy60id317u9bIWPOq7Ytl6GAP7spkHyMV
	 O/xI9K7t4rRPiK1VM/F+rlgE7Wpcu93p5K2l34Gxd6vYcML5CNPGVj5mjRAprMPkxyijp
	 HiR9uzCl82LSSfCoSPtkJESd0dJQ5510lTErnZEsa08ziJIqCQNY67qSFQS637mVlBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvmssJKq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AC606A337;
	Wed,  4 Nov 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvmssJKq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAF61F00A02;
	Wed,  4 Nov 2026 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793808228;
	bh=4z0jvqdS/1LMWIjFo97DLyqM1S7YnHqeCK2uONFB0l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lvmssJKqKlBB8zb6lcm8q6aHeXG/qCiP+gUjcU9nvF+xGya/hGTMk+h5EqGwaP7Dg
	 hCEjLaOMvxn99ux2L1vQ1WZcAx2UrUfxZq7tcVAtMx/fDv/Y5cU6wFg00SgqtSbZ+a
	 /WXDF59xns9xcQX8OTZxjVf71BkxvniIjNyKm58RvBXNg83UcnxxNX2rY1B43JrSuJ
	 8RqAyPwTf10OjQuQ7aJ8eKOoS80vk/S9VLlqiPDSLY5yZngtZ4hz6g28t2nn+PF25i
	 8xKOs2XnzNhgBZUBhfQUJEOVMjBCn0dWJFHOAMfzJuGQi9BEpg3Gc3u0bauDSadtxU
	 b+XunlvXOSbvg==
Date: Wed, 4 Nov 2026 10:03:46 -0600
From: Rob Herring <robh@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
	Eric Auger <eric.auger@redhat.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, devicetree@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
Message-ID: <20261104160346.GD3951195-robh@kernel.org>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
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
In-Reply-To: <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>

On Tue, Nov 03, 2026 at 08:59:33PM +0530, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> "iommu-ranges" was introduced to specify the device specific IOVA ranges
> when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c | 134 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>  	if (start == phys->start && end == phys->end)
>  		return IOMMU_RESV_DIRECT;
>  
> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
> -		 &start, &end);
> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
> +		&start, &end);
>  	return IOMMU_RESV_RESERVED;
>  }
>  
> +/**
> + * of_iommu_derive_resv_regions - derive reserved regions which
> + *                                are outside of iommu-ranges
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * A device can describe its own usable IOVA ranges directly on its node
> + * via "iommu-ranges". Everything not under those ranges is derived
> + * as a reserved region so the IOMMU allocator won't use it. Entries may
> + * appear in any order in the property.
> + */
> +#if IS_ENABLED(CONFIG_OF_ADDRESS)

Is this really needed? Assuming CONFIG_OF is enabled, this is only false 
on Sparc. I don't think Sparc needs anything in this file. There 
aren't any IOMMU drivers for Sparc unless COMPILE_TEST is enabled. So 
maybe building of_iommu.c as a whole should depend on CONFIG_OF_ADDRESS?

Rob

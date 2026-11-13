Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575500;
	b=vU1SvFRo5Epe70xdtZshrzYHTLrmVUBIsdH+Jgjh/bHV7RYOTLE6q/OLVwLnHa+KDqPX
	 3XMQ+u6eTY/rAJUUXlbGuR6qeMZRlcvgbVfmuVYCkpJZJPWK7Es9OaxGvZqNOKhyS2shR
	 9H8BLSUdPYhRE0x5UWTIb5HoaiY7OHVjpVof4/lukB2me5A+GwmKkNg3+q2YKAMrBHK2k
	 bT+NoyFHZSwwxpIPc7XYYz7/yCXLrWH1y5hLuMYk4L/J7axJeUewYwL1TaUNpT6b8w1kM
	 JQRKpDQRTxUp7TGSgoVpMktDDg4oKoPc7xqr3o9H/1t54p6QAWoBxL1KP9mxBZGIH5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575500;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UJJGqVjSBQwrXCt5oO1oVp31bm2wr0tRxTzs6y+s5eY=;
	b=iQ2fofjGwAm8s/O7r7hvbnpEQzOn3cbPDIL4NjBfuMsK7OC8RxDTTaZd4RA43N5/id9r
	 B3a2psO9X6O0V0rUPSJPYBjp3OCdVLFY8Nz6nI3LILfB6ZvhAP+qPDAsU8ij+lYcKiLXS
	 fWHRbbkQP8gUAVFzLgbq+nUMdXrtt2wGEW3T9wi9XDEkUhnM6Pz94stmK+Vmz8kBrLwvA
	 jnsfraS7vxdXQHI6/qyAJJ1q/GjVdtJ9Nh3H/8iD7QmaBxeSyMpDQuwj/Zsr2m7AKsp8A
	 3rK9J5sPNdqp7ELiP7lytDtR/xv2qJmSH98V3ceJGCwUCedhqOXRFT9ihagu0mFS7FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhntSPDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68156606A339;
	Fri, 13 Nov 2026 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhntSPDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151971F000C4;
	Fri, 13 Nov 2026 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575500;
	bh=UJJGqVjSBQwrXCt5oO1oVp31bm2wr0tRxTzs6y+s5eY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HhntSPDz4hBtYpgjSDSSVhehC3ugFdt3d8uKPZhC9zPonuqtlUMxXtQgAXMu51sk+
	 c6XaBX4mO0q+UZo6swHPzJFo/cu1cNYby+GumuSJb/pVqWa6M9JH4jlEBT/Exzl7GL
	 ilydPvL3dZGNK7a2kUtrXtR0vCyfsSfrp37MQPRL04JKFaIyA2wxO0cy5ZJPxSTlr0
	 v8iYKnqyavXMWdSClMn6YoV3XhTdrYpDGEwipYibWKjBD7yNxpuoauoWKAYDDvAG18
	 HB+RxkZpbQXP1mMGqKExpbXk0lrd8Hkf6F0/bRiOljbAPatD7c8Cs1nGKblzyWcaU1
	 yoMV4p8by0Ezg==
Message-ID: <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
Date: Fri, 13 Nov 2026 14:11:30 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Joerg Roedel
 <jroedel@suse.de>, Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 18:14, Vikash Garodia wrote:
> The "iommu-addresses" property describes an identity 1:1 mapping between
> an IOVA range and the physical memory specified by "reg" in the same
> reserved-memory node. Without "reg", there is no physical memory to map.

This looks like ABI break.

> 
> The DT schema now requires "reg" whenever "iommu-addresses" is present.
> Align the kernel implementation with this requirement.
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> An identity mapping requires matching IOVA and "reg" ranges. Reject
> mismatched ranges and report an error.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>  {
>  	phys_addr_t end = start + length - 1;
>  
> -	/*
> -	 * IOMMU regions without an associated physical region cannot be
> -	 * mapped and are simply reservations.
> -	 */
> -	if (phys->start >= phys->end)
> -		return IOMMU_RESV_RESERVED;
> -
>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
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
> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  		struct resource phys;
>  		int size;
>  
> -		memset(&phys, 0, sizeof(phys));
> +		maps = of_get_property(it.node, "iommu-addresses", &size);
> +		if (!maps)
> +			continue;
>  
>  		/*
> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
> -		 * that represent reservations in the IOVA space, which are regions that should
> -		 * not be mapped.
> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
> +		 * the physical address and size of this memory region, for an identity 1:1
> +		 * IOVA mapping to that physical memory.
>  		 */
>  		if (of_property_present(it.node, "reg")) {
>  			err = of_address_to_resource(it.node, 0, &phys);
> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>  					it.node, err);
>  				continue;
>  			}
> -		}
> -
> -		maps = of_get_property(it.node, "iommu-addresses", &size);
> -		if (!maps)

I miss the point why you are moving this part. Irrespective to actual
ABI break, why do you nee to check for iommu-addresses before?


Best regards,
Krzysztof

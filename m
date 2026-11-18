Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004887;
	b=3MHesBjkR/eT1EEtazzjLn7olain9ObMPp9UwrwEpDwtVKPexsxw+t2XajATXXWFx1Nj
	 lS+zRIDGEavmuRX028QDVcSMIlMv++9MrMdzRSAp9A/B9PPf3XLYRqE9V8uRX2WtEvL2W
	 yWYnqZdqUSpMqD6cywItHPkc3jLJ31b8u1qS/eP2JMp2yQ6HozXTJsHk70zi9i5jwRKAN
	 Mmvp8L9tCiURYNQtqPDBobSEuB5/jh429gTvoyv3Q643r77v4FZ4i2oH+UfqR1EQCzyGL
	 20OObDxd9HSZumZQIBnj+CuERogK1Sz3s4AcqmuBlWpNTTXN+jrP8trZaN8EUw54+pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004887;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=7nE1yiuDOjsLguXXYCbkeb5cqi2x+QFFIbocCPDIlo0=;
	b=l9IVl6+VCInSHtPLlMnoO16r6smkBKzpA6HH9PdhuKfzObx4Oe5Mjx3fjl36FzWQ6zgI
	 GRnM10F2qq4olzfxL4vvB9MjlHDnZQfsWiguLl8I/f0RNOoGsXIOphicDf+vXKqFvaGWt
	 d8vq92TPiOdpJo2cZ3oY/wJ+LYqBo57HpduoaCEQHHrgyJ5DN7fs0th4dqPTDJSuOl9Ce
	 8yiuSlEtTcsjbmFfRFsBCnU0a28HxEifoiK5uK/ZGtJloy0nxuqpq5z4VmiR9l/8TPpl6
	 9aPP+fyIMCceXy2oSz3/NboUz+LQnud4aSozu6/YyBhr9ZLSf2CTNFi3I4fGsegqplQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaaDvu4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB641606A333;
	Wed, 18 Nov 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaaDvu4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD51F000C6;
	Wed, 18 Nov 2026 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004887;
	bh=7nE1yiuDOjsLguXXYCbkeb5cqi2x+QFFIbocCPDIlo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LaaDvu4YPm/fHnBCwRzmpD+68yqRHRW4X+WsoTN0tJU+7aNITlo+ALKPdsDhyzsCN
	 qoEMNd2sXdXF1UB5rB9oitscv978YkoQA23nT38MDTYZ1sg9JGXpTM8yBOnxZbwcjP
	 a5udyJfBq6OSTrpL3mwlST3B2NvdhvqoYCOheEp8aZAuVsVdmAtdHJlNYUYeCebOLQ
	 LKIKCxIK6XblDRVNfhO4GJYP12jbF93CAKuFqxpr5bROMLyRUcCrNNzWcThFDXbOpC
	 86AJjr5BI/qYlh1hdkFlcapE9oVvFkwH4uMlMny0XhSj/1RqdJktrQxy6a7N48M001
	 E/H7GFUexQ6jg==
Message-ID: <2a282370-025b-4c0e-8a87-4d05aa1d87a0@kernel.org>
Date: Wed, 18 Nov 2026 13:27:58 +0100
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
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
 linux-media@vger.kernel.org
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
 <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 17:24, Vishnu Reddy wrote:
> Hi Krzysztof,
> 
> Thanks for review.
> 
> On 11/13/2026 6:41 PM, Krzysztof Kozlowski wrote:
>> On 06/11/2026 18:14, Vikash Garodia wrote:
>>> The "iommu-addresses" property describes an identity 1:1 mapping between
>>> an IOVA range and the physical memory specified by "reg" in the same
>>> reserved-memory node. Without "reg", there is no physical memory to map.
>> This looks like ABI break.
> 
> The original discussion was to avoid keeping iommu-addresses in the
> reserved-memory, if not backed by reg. In such cases, it is more meaningful
> to move that entry to corresponding device node.
> Given this direction, the schema was defined accordingly and the code is now
> updated to match the dt-schema. At least on Linux, I do not see any client
> using iommu-addresses without reg.

Yeah, but ABI is for all users, not only in-tree.


> 
>>
>>> The DT schema now requires "reg" whenever "iommu-addresses" is present.
>>> Align the kernel implementation with this requirement.
>>> https://github.com/devicetree-org/dt-schema/pull/207
>>>
>>> An identity mapping requires matching IOVA and "reg" ranges. Reject
>>> mismatched ranges and report an error.
>>>
>>> Suggested-by: Rob Herring <robh@kernel.org>
>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> ---
>>>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>>>  {
>>>  	phys_addr_t end = start + length - 1;
>>>  
>>> -	/*
>>> -	 * IOMMU regions without an associated physical region cannot be
>>> -	 * mapped and are simply reservations.
>>> -	 */
>>> -	if (phys->start >= phys->end)
>>> -		return IOMMU_RESV_RESERVED;
>>> -
>>>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
>>>  	if (start == phys->start && end == phys->end)
>>>  		return IOMMU_RESV_DIRECT;
>>>  
>>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>>> -		 &start, &end);
>>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>>> +		&start, &end);
>>>  	return IOMMU_RESV_RESERVED;
>>>  }
>>>  
>>> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>  		struct resource phys;
>>>  		int size;
>>>  
>>> -		memset(&phys, 0, sizeof(phys));
>>> +		maps = of_get_property(it.node, "iommu-addresses", &size);
>>> +		if (!maps)
>>> +			continue;
>>>  
>>>  		/*
>>> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
>>> -		 * that represent reservations in the IOVA space, which are regions that should
>>> -		 * not be mapped.
>>> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
>>> +		 * the physical address and size of this memory region, for an identity 1:1
>>> +		 * IOVA mapping to that physical memory.
>>>  		 */
>>>  		if (of_property_present(it.node, "reg")) {
>>>  			err = of_address_to_resource(it.node, 0, &phys);
>>> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>  					it.node, err);
>>>  				continue;
>>>  			}
>>> -		}
>>> -
>>> -		maps = of_get_property(it.node, "iommu-addresses", &size);
>>> -		if (!maps)
>> I miss the point why you are moving this part. Irrespective to actual
>> ABI break, why do you nee to check for iommu-addresses before?
> 
> It is more optimal to check for iommu-addresses and then read the reg. On the
> contrary, earlier reg is read irrespective of iommu-addresses is present or
> not. So in a way reading iommu-addresses first would ensure that reg is read
> only if iommu-addresses is present.

Sorry, I don't follow. What is here on the contrary? To what part?

Best regards,
Krzysztof

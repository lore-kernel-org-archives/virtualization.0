Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809394;
	b=GxO0mx8XZi97Xm8KaDiaQI1WvFQ/RC+Iu4b15pOqxyys0mQzywJfT/pqDN4TNkHIG5RD
	 Y+aA4MI/Y8A2+phObHn/8HAdGizCo+52aD+edPSULh2e6TUwHySROhhb7p0Cl07kRo6t0
	 UONx7HnozLcpic2wX79BDMG7spSaqsp4aZyiUsjWUxQ7lQ/XVmJRqGZBv9b38Qm0g3866
	 HSCXRHyKk86KtcIKTa/oklk5TA7VzfLuW4e/vbSU8wmV2vvIS4pgnO+E7ouBiWOq8lhtr
	 gf4K3V3dqzpI6RPsP0oNNKXBZuZq7Zi3vuQxv+HnJcNSIk8aw/xtcTJd/L7l3IuDnew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
	b=isB/gONiVZL8HBjXpfGvaLPOs3grsl5G61uYOjnJtJckBd0xKwGMyNab1Erdivuafg0F
	 En/9q9DTxpOvOXyoq9urOVIyRHORqBmZRRQtcaok31SQ+fHDlJXuDUWAKFrEHv6aC+usC
	 3tT86WWyD0mh5I0mVBoBNmqx/1ysZirknSy58qeGIjBZNir2LMaFSvXQTsgpTALgoEU5t
	 1r862Z48blTbd2gJ9KJQz+BS6wIQEzr59X6JfpVS60LWkQLGRAfqUzKTDoY74wO8+oRic
	 YVhJUYiBvITIbw/WZ99zrzw0uNDg7jd/WfgZ6tg/xr026xZms56jSH/h/Utd6pVLskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdQJmj61;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33779606D80A
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33779606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kdQJmj61
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so12542825e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793809391; x=1794414191; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
        b=kdQJmj61fGHKGwx1dWASklCXYb2Tb47QaXXzlzfqZ6Y0VoSkXYa4rWD0fwo545mfCv
         DvAXBH7Pr+2kHxi5i0a+lX0Ym+ajj6aGirn5v8hnL/NcR8DdYbM9qChmRwQ+Cc3Gomru
         MqbakvtOjJlTpbus7yTNCjMmY5MyZ1l4gQo/v+9jdomiFEAuxBv5Qhrx2vyWeJ6keN+F
         DKW4xbo7Az7l8Jw+xnVemDd/krlGcGBSjEed9Q5fVMG2ES21/X4MNY2VhNTqIe/7Wv7F
         BCNEDDmd/JZHXYHrIDRf8zmOWZaxp29vOKlZMILZI0zt/aeY26WLRdclQvPZMMHyUdNT
         pQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809391; x=1794414191;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vocGYEw/5tonadEsgL+tN2/v9RawaaHXU9Cku3rNbjM=;
        b=UA/lAbh9ySzd3aCrfc/PqliYK/9pouo4ePnJmE1Mh4//ikl+yGIVEw8BU2usI0qiGo
         Mv05fu8FKxfeBs/RPFZi/WZOFmDY8y1pM4YG0mfcFwRTK2d2mya2pbew2wsr2R2tFsyd
         PfJZnH+4QIcZhbt5OkYCPW1i2uvbAxRyE0nozyUa7xHweqPmdPtxrEnbZRBPk9WSHEQM
         6wNGBHPbn4SJwbG5NlU9vwiZVPt5KYYXL6SunzAcJ7nrgjQz7cDiyzpZMDSaiNybPHW8
         441RK6V35YwqIy+ZLc9N4woCLt6jlBSOm7/Na+RJlD4hqLLTmzhenL9lyO+V7lgifJb4
         +tWw==
X-Forwarded-Encrypted: i=1; AKwUvBzSKrtXukssiXt46bkBKnyf1dru4325u9Hx+rf2+KHwsaYxdxJKYSqppgPWUj7bff0a8z3u52l3GZnb2wHRbw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pMDZzpoli0kH2927YszKYQC53Wg3g+1J3F8hTV/jTruPIetdJ
	p9SWKxOPSHTimGSKZs2rjwEKtybqVCdUuZICQS1rMgnN/EO8uofTY5AtN5yFGIovja8=
X-Gm-Gg: AYBFou2A441hcpxDqhCF7mWW0bLsTnizjdOV5wsioYsURFgZrMEvKdfe1DgoXRF3bvw
	rajGZbJgOVWQzftO6b0XqYS0Tzq0lYiZHRcy+01UCW67vIBY5ZrREJBxvG3p74S0kvowFWoQUN1
	3k5naM9gjRg3a8B20bYIz/1978k9R1smz0Pf5z/Syd3GdG5OBVVQJHPr+vUWISL8811VYtapMRZ
	jcWDpOgr7nvy5G4p/EtcK3FCCxUZq0oY0hokBNBei2DLeJZELt49iVyFAT1v1u6u1pC9q6qzPuY
	vfNwIDbh3IR+D0T1LglS680eoiZTCAbUaoYn6YyAC/T1LJKX4q3EQAsXjYnKyYZ4lEdsOylJfGJ
	x1ig7V+sb2xxvQ95WuNNL7+agX68S/DfkaGSiGojibkLDvMv0yXSxQ1LPgEpeJcIjboPXwU2Hgi
	PdREr8CfPdXeKDBSFJNmW+rePEcFhC9uLaizf4/TwNnmxjJSUSi0BHMsUQ0ls1I1XWAWbbwUfSE
	dIIy5bo3Fqrxh6sC5DZBRmxceV5xd14/VJx82C+hyL1Ad8zCzRTWpYyB8PCZfmB6y/I2K2kHMJQ
	vxdbiyegFuYbSXrGlb0RuUZ88c8KbR7l9rCGSuZgig==
X-Received: by 2002:a05:600c:1907:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4b55c8743d8mr75395e9.3.1793809391436;
        Wed, 04 Nov 2026 08:23:11 -0800 (PST)
Received: from [192.168.0.167] ([109.76.163.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e0fe6sm168477495e9.1.2026.11.04.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:23:10 -0800 (PST)
Message-ID: <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Date: Wed, 4 Nov 2026 16:23:09 +0000
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
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2026 15:29, Vikash Garodia wrote:
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>   	if (start == phys->start && end == phys->end)
>   		return IOMMU_RESV_DIRECT;
>   
> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
> -		 &start, &end);
> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
> +		&start, &end);
>   	return IOMMU_RESV_RESERVED;
>   }
>   

Same feedback as @ the last version of this.

I still think this behaviour change should have its own patch that 
preceds this patch so that the logical change is clearly explained and 
understood as a standalone change.

Supporting iommu-ranges != not mapping misaligned ranges.

Otherwise this change goes under the radar of the new functionality 
addition.

---
bod

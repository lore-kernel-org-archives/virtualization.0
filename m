Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885990;
	b=INoVCjS2BZMVU3xDE2r7/+AKanGI0J3kcJFjymZ7aAN1e2ERcFVJ5sv/SbT5orAFMUBQ
	 j5W7nw4GVQC+YQx97JhsKH7rGnBG8YiUuMg+ac4vwaBmW3/byMWYx1IQc54fXQQNUNh6A
	 fBQuq99SgcF8eKNfQAdh7YqYBJ16Gx7HbNxeJ1nR4NzxhUYV4I+BkBGo7evFdYmOVUwRj
	 3UTyXl3LfLyyQ4PY34RGWrsbG055YIAgY/NcbzrIxTucU2R35OIJ4soW6HP8JABd4Kgay
	 TOMgWjgZPKeUolb3m12cnKZffeXCNRFBdV4f3Sm1mJCBo751287NoYPn4yBsQCpAMdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
	b=I/0zmnqKerMU8YjBii0rMEKNeXj7h8mv2iwdatHvt3XK+F7YREveppyHh2DlFW2T6Hzx
	 LtOOvYv7fRME7EpnLBEzMF0XwGOSUV1FmzpKKTx3Rxc2jANjDwnOyF/Lx0pTWp1RTRNnz
	 JRUAJD7lLt7WnBcpD1rAU03DqH9e36YYP6jAk1ztN0kRwfBRd6uUJ+DSvyGv5AG5h40Wx
	 30RhrhT7VsovPhWL+WzRQoutBE3iIYokXJcgaipHhsdgsUgLFComHE4gJjX8i63mjgXXN
	 CHF12seKmGFnRsXSRnKic+VftiAvMzLdIsI6O5ZlLzoXQKG9RShqj/dTkSnBIYyWBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CClOpqWi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ekEpDu2m;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48879606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48879606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CClOpqWi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ekEpDu2m
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59thsK3531963
	for <virtualization@lists.linux.dev>; Thu, 5 Nov 2026 13:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=; b=CClOpqWiTvqkA03E
	ytnL7SM0+W+sCOnUnxqSaoBQS7OcqQR1mhJF8edLeQQtPhGLvG7IpgErn/E+4vrM
	l4HuE4tHLfdNcLfum8Gku0xiQJfBimzs/Cn+Ryam4yafeo7Ft6ly2Ub9vHiPMGvU
	O+KdHkf1LUD0sS0E4H+MbuDZ6z2uNOV3fx8MaU7Be0GlMrWnqh78rvsu1pSAN2KZ
	UEBWZBtl+uRBrivSlv6Eo9cuikEbxgdlwJ/6fazpYuprtx0gGIAsei8WL44Ya6DO
	KOC6WT5+C2hrdLZmmdyV7pqD5nqI3IEMj1X9YdzYEgMMMUacY+Vy08/oL704tM9C
	L19VWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9w69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 13:39:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd65285537aso876456a12.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885988; x=1794490788; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
        b=ekEpDu2mcyKl+3d1Pkca6ad3q8O3iJ6oero3EE6XZNHcgz/5I60mPz2/PfYcZqyBtN
         +SGF/h377PUbtUyoNTeLFx51Ay5m63+4MNLWEzwHAxt6nKUAAweYciNXq4uK+GO5f52L
         KNGExtD6WwSlKp+GScRvcM63sqzBxauTRUA2STEN2+yiEVR5z5acVWwCi3e1C6latnBW
         8n/Bjyg+xcJOhprBqtf9ATG7zP711tPcpHs/eHVxOrIGIebCTt2oYivZzGGeAS00BkR2
         mTFyDyV0Ud3fTUmw4LQdtNwobplKcFHoimOHm0bpiGTwfGj0Rtki9OCnNxqc1U8rHHyz
         biWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885988; x=1794490788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca75OONoSil29mOME3yxUZukBMpNuAXeGO/o4FyBT1k=;
        b=JWjROj+0qdNqUHY/VH3FH+pCcambWqgMPRGMfBzxnJ+jaOw24kHW8th+KnCITYTjDG
         CGfcXQ23pi3g0q48scfX75E74b/7g+hMPYhalSRuevW8XVKwq4ZHOMozcqDbsKAOYudU
         8pj8NMUqPXRBNx6NmGp/wM8g8HttuxqRdg1Y8XJF12BG7wkTjfxeu/xl8KRDm3SNmLQW
         FqK+Swo3k6uZrz8Br8OdzeanqilmVBeX05GzuFkp15LsdG0Abkj+k/fXzJnn80fzxvG9
         bqc4aNDfGlZGWseEQnmQfkGf3fZCY57Z4SYCdB+ngbJw+uwgMznMfGwxhO3f/whfDEdY
         jwMg==
X-Forwarded-Encrypted: i=1; AKwUvBxuNPGn1YCBriaFIPq9ZQK0kXFTneQpTq/w+i7F6cShc7Dk0V0J3r5gvJsfM92V5EfKPKthtLo6wz5HqbytGg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+T9uiUb98wAJAqx2ic7yCuO/lBZQtRy3ZhNuZ65lr9D6WbsMCf
	BCIiKYz/xBd2km2ArLN0nZR4/QoOIi6Ri5jMwseJdCDRsH36U5QiJVkvBXFTpD7dzYmGhR1XwtZ
	pNGplBkzf8C+iIj0H2/zTXrD8fr7o0LA9MZm3qV7YRCEq0FEcpwCcqD7Z1MdQgp1y5vZm1A==
X-Gm-Gg: AYBFou1EHnxUP0cCcek1YDpSJOJUTUxEX3QGkEMyDgELqw7aEq6F7w0P4SnhKhDTps3
	R3vuPiHy62kV8pNYYGZdlkvvG5HXTMcSvg3f2vdtZbKlqKw924REaRIixEDfjiXe0drYrmGy588
	snJ7/rBY4GaAjAevlS24KiiSGmLJlP4b334ezP2K2TuciZ2yfL0UmMW1bDmxCtGu6Xi5FOMf3F3
	UnEUyCXOxdo0VZARFB7ja/Kov/lrmFGWl04kDiIi3hjzgLyM9+xoev25e/I9ufIF59/kNzBQ7jb
	sBhTZB5DFwVBkulzdaddby+4+OHiQw75nCfpwQPgT4ulM/s7cT+AGh3B0DMen1VhN7sfhQelGtr
	QMtC/NeAeOpoAukPm3v3JY5ThgOmvnNnE9GVTQAVk4QmJQalPvOBzT5kR3Pg4vb52tmzSl0h+bM
	ScUA==
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3ae897f61aamr16476338a91.24.1793885987716;
        Thu, 05 Nov 2026 05:39:47 -0800 (PST)
X-Received: by 2002:a17:90a:da86:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3ae897f61aamr16476312a91.24.1793885987137;
        Thu, 05 Nov 2026 05:39:47 -0800 (PST)
Received: from [10.206.97.48] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d431sm2208325a12.11.2026.11.05.05.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:39:46 -0800 (PST)
Message-ID: <e7d81da2-c083-4aca-8fe9-38a068613ddd@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 19:09:38 +0530
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
To: Rob Herring <robh@kernel.org>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
 <20261104160346.GD3951195-robh@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261104160346.GD3951195-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX7sg3FNf+f6KS
 3lfa84LCSaPORPOc8tVUmPecdlFk72oLInlkLF7Y6JQwiZKOAH97ftf8T8yGd1r5ezMQ3DD/yCl
 Rsx04ClqthLmKA0hxKynHxdT6YpzBNaYJrOxbhxqS3jkwzK8WfmP8dJO6rIP9+I1F7P7KvSEjzf
 EVrRIITwm73ioQV6JJCQ1BHsy4Apk+DOpOib0PUkhJ9DvlQdCPiNu5MyQlX/+7kcdcUfZNNGOsX
 f48b3T7rSNcTbgxIs6CLYbb/Y0WeOxQkhZXlwqbZpS7VsgpbCU3c2KsDOti1hkXTVhN49k36JWQ
 kC7+ZhA1b3a9jHbhnXMhL3dLG2IjlQeRMaimYnFepTQcVeMoWUs/bkvNG3SVHAaZBQUON/UmGcz
 zxTyc4bXPsxjXiH4K/FfXYTj1FWPxzIs1om6j+AirTei7ldFQ48nEuK7fMe9NnIW0qD+rIklvPe
 ichqkovR9lE5QJs2BJA==
X-Proofpoint-ORIG-GUID: s-ZOwYJFxP7mH37si1mJyIxZUlkimN6z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX+lEz5Ik7gsyW
 LRx0+YhFDWIsgWSSBubgEDQ1i5rV/cwD1LpnfpvspJLxFK85xNBo2G4qFSp0CF/TmaEi3rxagsb
 GAq1G8PR0u2FqhalAIOqwhRIwIhJ+Bc=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec8725 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e-HLqTR_PI6rTb-hZFoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: s-ZOwYJFxP7mH37si1mJyIxZUlkimN6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050054

Hi Rob,

Appreciate your reviews/suggestions on this patch.

On 11/4/2026 9:33 PM, Rob Herring wrote:
> On Tue, Nov 03, 2026 at 08:59:33PM +0530, Vikash Garodia wrote:
>> Reserving an IOVA address using "iommu-addresses" requires it to be
>> placed in the reserved-memory node. But when "iommu-addresses" is the
>> only property being described and there is no backing "reg" (i.e. no
>> actual reserved system memory), it does not really belong under
>> /reserved-memory. A device IOVA range is specific to its own address
>> space, and does not describe the system physical memory to make it
>> qualify under reserved-memory. Given this, place "iommu-addresses"
>> inside reserved-memory only when it is paired with a "reg", otherwise,
>> define it within the device own node. It was discussed here:
>> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
>>
>> Existing "iommu-addresses" property expects a phandle, which does
>> not make sense when the property is defined within the device node.
>> "iommu-ranges" was introduced to specify the device specific IOVA ranges
>> when there is no backing "reg".
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/of_iommu.c | 134 +++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 125 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>>   	if (start == phys->start && end == phys->end)
>>   		return IOMMU_RESV_DIRECT;
>>   
>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>> -		 &start, &end);
>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>> +		&start, &end);
>>   	return IOMMU_RESV_RESERVED;
>>   }
>>   
>> +/**
>> + * of_iommu_derive_resv_regions - derive reserved regions which
>> + *                                are outside of iommu-ranges
>> + * @dev: device for which to get reserved regions
>> + * @list: reserved region list
>> + *
>> + * A device can describe its own usable IOVA ranges directly on its node
>> + * via "iommu-ranges". Everything not under those ranges is derived
>> + * as a reserved region so the IOMMU allocator won't use it. Entries may
>> + * appear in any order in the property.
>> + */
>> +#if IS_ENABLED(CONFIG_OF_ADDRESS)
> 
> Is this really needed? Assuming CONFIG_OF is enabled, this is only false
> on Sparc. I don't think Sparc needs anything in this file. There
> aren't any IOMMU drivers for Sparc unless COMPILE_TEST is enabled. So
> maybe building of_iommu.c as a whole should depend on CONFIG_OF_ADDRESS?

Agree, that's much better than adding the check, will drop from other 
places too and make it conditional compilation.

Regards,
Vikash

> 
> Rob


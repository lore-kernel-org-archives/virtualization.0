Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886095;
	b=TYVvkBxA5YkS+2qMpbLgc9FzFpdIb6z+mc2qfd5j62FY1b9MsZYfguumECNvwIKoJHOA
	 OVEIckJXwIeFdHQW+9MVB1huFUOUAm6eupo2GKIzxX329wi1rex1m2hnXCISFy7U8rEzK
	 QooOQhYOGD/aCgbSjK8s75cRKWj/W5BkmCXoJ6OmpB8Bb6RU++lOqhnyxsgqgE6KS5bMZ
	 G82IihKS81mwbEaeMw+lvAmeVdH/9GM3EwHkkxJcl2ycz3Ls9pxVvHrUi0vK8SBpWb+1Z
	 Xo83q4j5SFJa1z3ucpDYi7FkYrAIbGt3VDFLE78qPb4X+VPKmMgqL2lrnpgZ/0y4rEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886095;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
	b=e9He7jCbuTFjmOkXCrg68aElU57u7S4bumZS/vPIioN3zjKwa9LzezbdRFpERl5+Il9m
	 pzFuVmMOQn+HuyXkpSjpYg+AiYdHckB/6jQmmSrMgiGwAuTiiGB3XeFQOB2ylpz7Ccxy3
	 UEtS9BktLU0PvKzHSg2wS+GNerImU8hr2Px0VFVoy6+pWMJHFpvGx61g+5t0y1nxVPKvZ
	 gq0YzQgKtMAZbiA9oDSK2wlXZwsf/Jxd9H7PJV2dLUXt+yGhJ14Y3DYVeUrf3ItvnVhzi
	 RjjvsNNubmXS4DIuU/DOr/jJr7qJ1/bcEHOO0PjN7WmmRZ/gcM/hA24hyDaZi1ycAYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5zgv4O6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YHQNikH7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A9606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0A9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5zgv4O6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YHQNikH7
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tC9u444454
	for <virtualization@lists.linux.dev>; Thu, 5 Nov 2026 13:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=; b=c5zgv4O6mlrsJZlO
	cPzXh1UHezP5ML4J4r5c31GBVxZ0Ykk6w/uDPWl4toE+EZX7+bkDJecE+su/sjCz
	WZPi6cJsGi2fjYb0LqQMK5dO55ZA3d/BGLHfRikIn77zVgzsQOO8sBeVmV7gl9Yp
	H4bcZae8VebNfHWWB3kau7qQ6aR4RHE1iOAhuczoiiwc2V8uWmWODdrRjVNX7L3u
	hKGtM6ej0KYKiPa8ZaMhWizVeg8vj589RFIvEGxzr/YtsIgqOw2wg81bZ+9uzarD
	FFGYjUoXQJAG9r4bAC5rVI8NC0YdGpfWGrm2y4H6wKLXm8WRhiNlZ0PuAjnCsmYW
	tCstVA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaah99j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 13:41:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so2681265eec.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 05:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793886093; x=1794490893; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
        b=YHQNikH7vzmkHly57QArvV3ccz8bYmqyiO1mQVTDDsN/WVQ7AEqi6CDn5f+Rciz6He
         K7j9m0Uih+PW39xmob3IbH0j8TzOhwov+38z67bz4SXQ41ew6lL1skM3S6wt4Ugs4FeV
         m/Q53OBqIm0sirhkDhgmv2v8KPP4vm5gTCjDj2liOnwxXWxKIKEiB+3vGZlEy7prKa0s
         izb5Qf+jb2VqTIH/JKnlXMh0Kt2KVC2gkQbYAB/1OVr7g2anak9tkZZ2S4P3SyXuxjDI
         xJxpG3CctMBFCDLMlZeYShR4igQeSqFiqPY8xzVpLVKFE5+SECGNcGdSvC3+Mu11skWE
         sahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886093; x=1794490893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
        b=kVjVvZy1dQzpZtKIIP3elfsPksDRfRUFeBGOydhjjEg+x8UY6OVBhmaVHhmwcXBiJf
         WUoCi3Frqry/lkpFHQwB4Dd0qDdIrdo/zJinITE6A46nf3APEuaI2MfyiJKxFUZOBAgW
         AZ2X4DQTz5HIcw6XIRdZ9aRabI316G0gE3AwVwwYPdUuhQWZg/ZfTo5hnqoxsq97XE8l
         S7CNoDhIVSKEvGb3hP7bD/FEgG2rrUtNe/u6zLVoWIy9WNVaor/T4o/SBqCoeIm0uSOu
         WXKdbjHnm3lUBvy05mrj7lsTdqxaGVFUvOxaelz4Bvkc75GOLCq8k5SgM6j9jmgwieQy
         n+cw==
X-Forwarded-Encrypted: i=1; AKwUvBz9cFHZAtrWVI+snyONJA83tmQ0TahPQ92y4HmzNDeMqD4IJYxTmZqWRJOOu7ePYWbUb+PJR/7FHX2Z6zDy2A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QCPHUaOln/9bXV17HIpnErh9bc9ZQGtWMBqkwBBfUQzPI/Gh7
	QTCvJl2EpAdd4LgqQXPtGWwv4ovBHAHIxWHMfG1U0pPPVXovZaOyCd6SzzyTBwp6yUu+MjYMVBy
	C/tmWMjrLVYpa4lGpie52OYWfI6bNmZDFg9HnIW+wtzGjbQuA07DTgorBc1rcxooOQuZjBw==
X-Gm-Gg: AYBFou01A9v2yqgT9WxPqbTRH7zV1nmNc1kC8wTOs+vFsuy5xeWdlCBQEHI+NQBzQqu
	Os4PJkVtHm7vC1ahbMyAT2fKYLNAdqAcD9tb25vDWm1SxBEabO6X2iYKtI4sdHue08u0+5ZyyB5
	8neQ/Yakmm9CkM32pCOmPtwyNAM8hBsBr2iEtunBjRP1jYjjJih70so7SkzFPSqUDcp4msvWZqD
	8eC2C4LKYmJlJBqEBAk/qa6F4k9bt7ZchPIuikBs/fr6WGX0dPkX10/cOMzZgL3sdfMz090uLJe
	cBZy/B2JQeh6/mWlR1XkeUVW4GnlLpalcDd41JNNReEEvh+lWb5TrL8KUpS0AU+y6ZS6N4PZtlQ
	5+579eWR/j5topBKUmJjDuxN4uPWMtXPjpB51j4Nj715Ywy4xTohkO0YjClNMEVPWHm3mTMfHzl
	e34w==
X-Received: by 2002:a05:693c:409a:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-36a42364b83mr31028058eec.12.1793886093253;
        Thu, 05 Nov 2026 05:41:33 -0800 (PST)
X-Received: by 2002:a05:693c:409a:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-36a42364b83mr31028024eec.12.1793886092676;
        Thu, 05 Nov 2026 05:41:32 -0800 (PST)
Received: from [10.206.97.48] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fe477sm15424892eec.17.2026.11.05.05.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:41:32 -0800 (PST)
Message-ID: <15ff1391-d35a-480a-b28d-a6507b69ba66@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 19:11:25 +0530
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
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
 <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX4Pn0hutYtgGB
 +XFwsLVW2O9Hh/rDEZnLAEBj2TlCk2nOTuJJICP9Rn5BTnCZiSjX+aRRek0jGc6zEZ86bp0BTUA
 6Ys2N2X/+9K9QLicSFzCkaABDio9Wdlo9B9C/YTnUD2scuvb1v1SoqJLF0lqU4DCP4KjtEy0fzL
 F4A38W4XisTsrUMbVylZ6SvuaSK9ubzm+o0yZXAwXI6EH7iHG5w5E6Raem4gwGFJdBb7Jki/60t
 xDyz+rnW3qtZYopRav2gElM8doEcSjZ7iFLkku0CVa3rjk4fp/KeiKnaGX/obY35qhS5AYdM9m9
 bcHPLHwwvaYzlVu5bJpU1KHZX5Nq5o5h3S/Kz3B147+T6O5XGkX0nW0Nm13MDNJp0SjeO1Dg01u
 9QzT0Bj+W8XAGty6uMyVrtFbrfHwRjbx8BIsTQPebJtEUID962h9qjCJZHesciUD8aCP/uVQcsS
 DA430OgvJkfL6j/M8CQ==
X-Proofpoint-GUID: PEDpcxJCtKJRB9DuC3IFTI5vWS7KeRTG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXybOWK+wjfN9N
 ju4XzFnE7qiVG0es3qAHvVaPNcfaj/afA1do2cAf2JXDjdKw4ib3dx19/I19imiY6WudNPD4w9S
 ZTFokyuuya/RTl84zgtuV8Z2PV2Na3w=
X-Proofpoint-ORIG-GUID: PEDpcxJCtKJRB9DuC3IFTI5vWS7KeRTG
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec878e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=r7ux6a0TY3_jL4VTlKIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

Hi Bryan,

On 11/4/2026 9:53 PM, Bryan O'Donoghue wrote:
> On 03/11/2026 15:29, Vikash Garodia wrote:
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 
>> 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>>       if (start == phys->start && end == phys->end)
>>           return IOMMU_RESV_DIRECT;
>> -    dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] 
>> as reservation\n", phys,
>> -         &start, &end);
>> +    dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not 
>> supported\n", phys,
>> +        &start, &end);
>>       return IOMMU_RESV_RESERVED;
>>   }
> 
> Same feedback as @ the last version of this.
> 
> I still think this behaviour change should have its own patch that 
> preceds this patch so that the logical change is clearly explained and 
> understood as a standalone change.
> 
> Supporting iommu-ranges != not mapping misaligned ranges.
> 
> Otherwise this change goes under the radar of the new functionality 
> addition.

Ack. Will push this out as a separate patch.

Regards,
Vikash

> 
> ---
> bod


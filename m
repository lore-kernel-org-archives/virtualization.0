Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490852;
	b=xAog5p9bcY4sR3whO9Vl8zEABJo69EEhar+sIHUXtaoiJYT4gLnk3YXLrRJ5zkrx1bst
	 DVYs+t/QGPYRouxeIYUcVUiGoDDttbcz8M0Yu87yI2pOVHqdyvTbFbE4ll00lMtqnJdB9
	 92AHLTotbjNEhT/Lbfeno9zgf93jn2r61iRR63LtOIKuOC+9kZHUU8lTetZh+vdubyEju
	 2WCyB6tSpeqDced5EnYMpXIexLZMkkNa56jamv80RZw3rmJykDQGCX+8bVDlSzQMA4R5t
	 GpXssohrLGgC2JwRM+ttfjbLHRPJYS7xnk2edndR5jSVkeIaAe9G9TOfWvLDKnYBrJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490852;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
	b=ZwPAfenhrmSGT+51v0os4rQMuF/qoeG0viuk12QGg46l9MjbHqbmC3ugs/i+EBJSmMwm
	 7UTLHNnwHlY92jiWlEwxR3arhhjT/xZoepvu3VS9qi4OqsSk06puPnk9TNfPgILWLOSWB
	 raadsrQz3YPkZt2BHkywhGMpFp8Tr4cQeZ9fwHybfAxfEuVyn0W9LayBfACvM4r9KN1HM
	 78s48HPQHjaZtFTaKqv/kR6aUMUHPr1PLJ1wnwEiPAzgo94GPRScDQBSLspJeOID12q4h
	 mBzqJxZvzs2r5ND0zX3LOHhnC+FD7SAHO8+0RoPKefhJQpGCPMGWt8ZAzyMo2tg4hUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRt3s7Ol;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702A606A885
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8702A606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRt3s7Ol
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBSbrS3893521
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 13:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=; b=MXJW4p4qCPwmk/Nj
	siwIg8CGYz4mbx14lK8b/4E+PnycciVQXlZJAZ8KGyrp72XmYPlT6XINOryUMlVD
	nDORnlOrglRbxPRrD8Ce94CVNek//0daPypSbJ7FrPd+8429gRKZ31NGBbZDFxDb
	CQt1dWund3Qs79JYMVks4RK/cbVJ1/caZ9wFdGJgKC1/BXyL6IZ5rat16Vwp5mnA
	Ec60Smk3bCyg/RuP0INway6N9K9eppnWti6IFvRizqfIFbF5MzmukU1O7+1fLGpe
	z5VKzpKHuTBX5By+fOfQ2f41A0wbe/foYCdXKRmuYzDkNkPVbdMbfQsP3lTXjq54
	YLAyEA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1t7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 13:40:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c6c1e082bso15249186d6.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490851; x=1795095651; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=RRt3s7Ol6qkg0DQzIBVASk01x0cROBANeMzFD2S/H7Y/WU09sc1ajOblzd8tygp02N
         LVUlkaq2N7N/Z0qskqim45FmPdM0yFTR9cME7dYQ8mGeACLkmbF6SSX/DxJuuHBqvg0f
         Ozz5St9AuY3stMB8vhBmxAJv7ZBcRWaOIXpGxuIBtWeF10R71eArWPw61qDRAzp8MT/T
         NSXOdipVyBBrRnZE2UyzH+43+ZzasbU9mVJiAA5YBgpjO5UvmOTR9v7UYGRC0UU3TA39
         MAw8KAtdBB5niX5I8Uj7iWic0tP1N8xTWA3CkVTrer6H0Q+z8EQ+8UwlTImE0aznoymZ
         TR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490851; x=1795095651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=UgZQi2zr0FhYtStKMNp/wTLRfKxc+ueRPKRP0xTcnWFBAMq6cQhiRkMcQgMlZYUrG3
         BrtSL8/GeXSKqp8m0ltAMJ3ftjHHGCzDT/VDAWusRcoeee2d5oZ0jzXLjutNGaKHUmkx
         yZui+OpLsm6WM2ICNcaeIezhqIsVr6IxJPhuB9Sb1/I8ImvFBipcAFJmhyNUbGwNTehn
         G3fdNjgLZr75GVvntygsPP2TpXbLcQ0Ym33mOv9zwmYeCv7qCf11TBdrhltIt29zK7n8
         QteYqBfpxFGWtWXOiTO21vUHfUiOs8pl0veGm6pYyzta+HBALUHGKuQQvivRzsNu8Zr4
         ZlsA==
X-Forwarded-Encrypted: i=1; AL+hErFwavok82fAqDN8JVMX5Z1UJXgePWj9WV4iqSx1/a0ZcuGTuUCdRIBaS12Z3Rgid+tLkQNS7yT37hI5dByUrA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8g1o4OTCzJrp4ZT71JLuKoROakBcKUPW4VPFujCW5Ij/aHkWCe
	r6wSP1fjqhiSmj0T4w1AF8oTNc5LhmJhPyuMxzRAjtDCg3qOYhBD1LM81holi9cp4Ix8FpN37TB
	4P+QqHt2mWgsYFYXGnVtryfJM+/KwG7u36xNObO7d/BLHDChlU0fUnZhE261xKzMesV66TQ==
X-Gm-Gg: AYBFou1fHVp9/83Zpc+xCWU6RcD4P9p+IXvczLd5xh2kOi02jCoATVwAIdD4nvhMH1S
	p+heus0dpooDv4bZjvhFBGU4iB81PtHQbma/bBP+UH8JQuMije5oYqdb+gC4MjBfUf1gU2oA8Tn
	KdyB6aVuBPclCMdMmBJyfq8lt4k9Deyrt0lDBBR4SUsGubf9Qm3UzTaXqqCKRNUmmhV8sPxxp2E
	Ws8/eYesPIv8OtifXrLKd72zsrZYs1mQG6kexceULodP1qVaX4rQFRZ2zPmiOPHLbMNU1um7u1C
	pq1PiErAIVB1pG7YhsgKs0/eIWzIxm8VrB5uY0V2qCoumj4JdoiKAxeGVsWfno6Bj4kouish1kS
	7KGktubDVb8I9qp/ejrUvvjmLFwZ3kol1VmyDLIMM8vfoxT+rc6PZskk/yf9RI3bG1Ph3swno+x
	rSKMkk
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380771cf.27.1794490850569;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380501cf.27.1794490850119;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
Received: from [10.206.104.93] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b942e83sm74301171cf.18.2026.11.12.05.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:40:49 -0800 (PST)
Message-ID: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:10:38 +0530
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
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O9o8AoPd0lMmPdUnWGG8pISmi7r0WyFq
X-Proofpoint-GUID: O9o8AoPd0lMmPdUnWGG8pISmi7r0WyFq
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5c1e3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UM6UlptfRCpVODDSDqIA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX4JL7OKxsF70j
 WbysK0tPnA2vS/4snVI+9CZDzhQPpowqLXOjKFKoQfzHzWPxCBRAkCkqCo6Be3Fn98QsHUbvS/W
 87i+EPSqkbMn3xh+XYVe1+n6Fs4C80M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXwZULeZYGkD0x
 5cB6LPe5akjyZkCnTK9Oz+/BeWOcQ/Rr1O/ii+mo0QVNitGbC6sUChW+UfuXCovJ+ji3CNjfwId
 bJEnkoCwBNe5jW3jsKiZ5zqqJe5RaBawVvz3DIKIQUadmrr0TtONsGFl1BVLU6PFaKR7AFhHo1v
 BSomhry8EjMtM/s8xKdcybbSi81bk4w3trjFVSnTAmn+sromsqVfILm25LqUWFSE90TD4zrrKS9
 doy0cHYC+lmIGQ9/jJV/5+jih/CApMX5gBEpRaYWf0DaS/JlYaR5K9U0jTbOikmMLnhVL7eIIbz
 m5tuUcqwZTxwYYH7qT3Xfr/PhHoJ2O68ov5yBy+I8QcbVPclhPV+fyjyPh2fVTlia3Xm+q3rrID
 TcwDs2qX/LLOstXZRTWT7AsED/bIO5Vy58T57EuQ6ypkUJpYLUBl+/R1uUCA7buAOTYynl9b9h0
 jITgMtUHkRyZUBh8XfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054


On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>> The OF_IOMMU code relies on OF address parsing helpers, but the
>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>> annotation to handle configurations where OF_ADDRESS is disabled.
>>
>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>> preprocessor guards and __maybe_unused annotation.
> 
> Why? What's the problem that you are solving? Why is the current code
> bad?
> 

The commit describes the problem as "The OF_IOMMU code relies on OF 
address parsing helpers, but the dependency on OF_ADDRESS is not 
expressed in Kconfig"...and instead the code had checks for config or 
__maybe_unused for cases like sparc.

It was discussed in prior rev
https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

Regards,
Vikash
>>
>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>> does not use OF_IOMMU, so no functional change is intended.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/Kconfig    | 2 +-
>>   drivers/iommu/of_iommu.c | 4 +---
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
> 


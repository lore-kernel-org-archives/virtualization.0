Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932694;
	b=K4oYi/zUXruAxQt7nsS+htSLbrKR1d4O875oyv5g8wtztUbT782+UZvpoPhXOPb4her4
	 JfkUeIhrF131mPmuXe46txF+Ocyqbx9vQqhhbWVqbbKDdSvz5mDXkHRxhGeQjuuNfHUCp
	 u1KrKLO4AMSF0P42IEHABLgSLPB7cDD9ik/xgIMDaGiH15IXm6VCf4Tg3M8NL+AnzagLe
	 higyu3pQZSb7YylDWQg4Ta2QHZy9wF8AthxUbJHo9gZchw7BMG5nTINFx0IKDvG+LbA5X
	 48+Pjktps1O1eG774gb0xbBJtqtBRd2mxBXzIfPM9tEtwzVcamYa20l/2PmWQ9sanoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
	b=OUeLnDHxQz4NgENOoorqsNJy2I+rYrLNmHn/bPoddpcZAxl+tQdwFjNGABk70ht6GXeJ
	 eSfzHReKEvbh5qTHWixjlDMff0O46RLyMBJ9d7+5YyGVHvbPpAo3UMyxr9YjUWB+PgXYv
	 zI6GLm3hQZQg/ADGFrIMw+HT0v1LgENDI0/D7hpUX/psq6WSSuXaO0ntYDejgrJnzGXDs
	 TGWpPc16wVDEwc/gkjsBV9SFQBPQWLMZiPtaSgVGD+HwsZwFGCI2B67OUSbmrvrsCkpr8
	 VfdPV0AFBQVapK3/FdRyidb4s9fuvU+E+cjzjOf+Lk1r2JP5J4rw2oZpQysDNzWsN4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxNekRGl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B82606A330
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 16:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B82606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxNekRGl
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHGJOPe3327669
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 16:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=; b=TOQ8+lCUML5ZO5h5
	H/qF60e2dPbCcKHoYulEN4H55jM5yHe+56cu9z5mHWHJvDpenV3Nx8kiTSJ6jQHp
	bhh7xA0QexaksUp3Rqqb1lIlzXljRLnYmuNw7tWpcyiizbcPqOpo2hqTwloA5g6s
	IaovTRep/vtw6UMFwr6B2eV+EAwdQm6qYPEAvPTlxQHd1lzS1wzhOfJGBzi8jOAE
	rPdLUBbDbWn9VxP2HR6YRcotGmxxAwj7RiauSqrxOxD/Vqk7a9jikwbX8PWixTMc
	cqAGMcFJYiWnFHqMIe6wY6jJAjQr1q2n9s9/tDRnM9QAfNxNVyXdUyiCFV2xKFtj
	DC+G2A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbar0w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 16:24:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f26e6abe9so63281eec.0
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794932691; x=1795537491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=WxNekRGlXmvMGoCQJvnvwtBv2gFhz9ENUYP2+ULRGxscELCp8AHF2GPgjD3f6Cj3vl
         0ZvDijBjelNcWG//lFw9Z+9Tz9bMBQOTvXjOQw8A4UUzAD4iAwhlcUE4EihUDwvnQHPV
         o6G6M4NzONyb2Op9OMEf7G3xYxrh4bjMRX3zFnDQAOoUEDri3azZ4XAlx5f6ZONToLSX
         xbk+aXGCv+JwXkAM/HzKQeWW3Zaozm4y04y8/Ae61P+0IE5/YzGXu8FbYXRdZxXHeUIQ
         IouIKq3zBIP8B6yqZTEeLYFin0Vwsha89htonnkbCTesyUl51EcMuXSDF2oVI62Zf0cs
         yBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932691; x=1795537491;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=rk0wx5QZ3pAz7LJ9biTK/ObdOaEa6nI9VJ92QXq6PiRYb3cu5HA8Zl1Edz1Xt1JZfD
         kK6rR6enIJYLE2Oe0cxpwBCm/XbwHpHi5C6t+52mjNGDAq7sPEG5cec/FodWGmIbR7Y8
         onautR2198qZLYXHXkuv+WVEJBtC8EpwY3y9/pETWROUbXIw8MHPOzqAUhxeOzNJgCnw
         axNUPwbnjnL/YnxUWzDaHpDJvbw8cpWGkAhuOmo5G78z2Rst/AM5m40qQ0f7Mp324UtA
         tV711fYOacNt854LHrN/W05Hhorp8dFJHiYBm+i13CoDUJG2nYaLVunh3c8oDY+EQWd8
         TqmQ==
X-Forwarded-Encrypted: i=1; AL+hErEYRZ6Cmvw6BBOOr/izMHcQg6ey0qgExLFmcNQm1CvB9peCAzdJAKze5dM7Qujv2Dfb6E767ehm40JusoXAqg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9QPIo6xxQOkOYfXpf0naVQ8w7L9pg1vqd2wBOBJxbLYP/WMbPl
	1ffHLO8WcXrOagqZQrTkLFb3WP0cwSw4eIonmMA7nQOf8FiW2onaocs75GxW3+8A45fvkm1JNpf
	ET0XWPxot/CwIONqdoeIC7/yrWvXwVccmvxA1PF/W2gBODRv8w893VLFOd+B0YkqkhQOvOA==
X-Gm-Gg: AZFdTZfn5XxKEagyfJpLxt2J12kD1KgI4mKjIAGB20YXFeVtrOW7Xg0n3FVm0oxcn0P
	dameV7VbvTIvC44Woo2/uTqNxBQ1F+ulcB6Qn6x41AmamTAa6a3qY1LCTVbpqS9yg9Uk74O8V7c
	KxdFlOKqBnpeeXgGFMA0jGOJQ+XR55UHqcFIIUcIp7qSYVkU8/M9CbcuO2ulY3foOYuvxExzv03
	I8HHUzsk91vB9+7gfnTfAPJdfdL3Kza8jALIW4Jr3R94iAef9UkI98K1FWZwTVl77zu9mdDNC33
	NeAyQyayPa5Z+FJTf1R4vr+O7f3YgUXvCRYvACZ2t8vlmu+TwEmDt6X8gsEh5Dp5ewSC64EBfHb
	BZWWuZoOBIPluzzdezwwOPfSwmAdNh5lJY6c87xiVIBS0hKTHDWXNvsZe7DgSvMZidX3SR305oG
	WvWw==
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266833eec.4.1794932690895;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266785eec.4.1794932690165;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
Received: from [192.168.0.6] ([183.83.140.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm48642584eec.23.2026.11.17.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:24:49 -0800 (PST)
Message-ID: <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:54:39 +0530
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NCBTYWx0ZWRfX445iL/3YlAhl
 n/6oZ9HrcVmD6TY044YIs9JqriwvWBDSIw87eewSq5aZSdFQUZFJAxHW1mSzqzkqwa4cukDJeao
 hekXMtmp0AFPXSu5dImomSq/nnPN+jjnQOn4j4hybHKUbnB51IxJTHDPui82AE3x+l2NZF1b+re
 cSYRaGk4AA8YvaYIWJvLLoHDOAD2kFUR9aLJd6xKRDJwLtjw/+jxZbYLQ880XQ7y+0D8KeDKDHg
 VFNAtKnGG1FeP2lXqlAMe0efgPIVkpvfzmN/DJpHP5vowcKioI0KthFY+JWGBXBER2ymMaRv956
 cn43mOmzd+2ntrJzfC92qhM6x/8KY2slJMji+DT7S3rb3xd/vbQDLnzzouRO3UVYwFK4nlNki0c
 Z5LY9ion3LOO+88AT1ZjE94x+gj1sNAKOiFwsarlkShP+/eepmt5zBFnuiYd5plGXgc4ILA5OVB
 gNH0r9BpPKg/pBACS5A==
X-Proofpoint-ORIG-GUID: kqvKz8SjIFYpw-7s5aMK2Ef3IkxdhTIo
X-Authority-Analysis: v=2.4 cv=Vsy2kO2n c=1 sm=1 tr=0 ts=6afc7fd4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=jbSCbZcLpKDW+DqD08IedQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xx2vz8YcUDPT77_BzWYA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: kqvKz8SjIFYpw-7s5aMK2Ef3IkxdhTIo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NCBTYWx0ZWRfX5nRxAgneWDx5
 VOvz3WsL3wHLyHyfpTHrmPsIR5MFSAo0Bjaoz3E/5iGy08/9Ntra1UB7qNqjc2wdr3Zuoc3XSw5
 PpEaD3gKjWtxCUwhEnVPonLpwxLTayY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170064

Hi Krzysztof,

Thanks for review.

On 11/13/2026 6:41 PM, Krzysztof Kozlowski wrote:
> On 06/11/2026 18:14, Vikash Garodia wrote:
>> The "iommu-addresses" property describes an identity 1:1 mapping between
>> an IOVA range and the physical memory specified by "reg" in the same
>> reserved-memory node. Without "reg", there is no physical memory to map.
> This looks like ABI break.

The original discussion was to avoid keeping iommu-addresses in the
reserved-memory, if not backed by reg. In such cases, it is more meaningful
to move that entry to corresponding device node.
Given this direction, the schema was defined accordingly and the code is now
updated to match the dt-schema. At least on Linux, I do not see any client
using iommu-addresses without reg.

>
>> The DT schema now requires "reg" whenever "iommu-addresses" is present.
>> Align the kernel implementation with this requirement.
>> https://github.com/devicetree-org/dt-schema/pull/207
>>
>> An identity mapping requires matching IOVA and "reg" ranges. Reject
>> mismatched ranges and report an error.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>>  {
>>  	phys_addr_t end = start + length - 1;
>>  
>> -	/*
>> -	 * IOMMU regions without an associated physical region cannot be
>> -	 * mapped and are simply reservations.
>> -	 */
>> -	if (phys->start >= phys->end)
>> -		return IOMMU_RESV_RESERVED;
>> -
>>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
>>  	if (start == phys->start && end == phys->end)
>>  		return IOMMU_RESV_DIRECT;
>>  
>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>> -		 &start, &end);
>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>> +		&start, &end);
>>  	return IOMMU_RESV_RESERVED;
>>  }
>>  
>> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  		struct resource phys;
>>  		int size;
>>  
>> -		memset(&phys, 0, sizeof(phys));
>> +		maps = of_get_property(it.node, "iommu-addresses", &size);
>> +		if (!maps)
>> +			continue;
>>  
>>  		/*
>> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
>> -		 * that represent reservations in the IOVA space, which are regions that should
>> -		 * not be mapped.
>> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
>> +		 * the physical address and size of this memory region, for an identity 1:1
>> +		 * IOVA mapping to that physical memory.
>>  		 */
>>  		if (of_property_present(it.node, "reg")) {
>>  			err = of_address_to_resource(it.node, 0, &phys);
>> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  					it.node, err);
>>  				continue;
>>  			}
>> -		}
>> -
>> -		maps = of_get_property(it.node, "iommu-addresses", &size);
>> -		if (!maps)
> I miss the point why you are moving this part. Irrespective to actual
> ABI break, why do you nee to check for iommu-addresses before?

It is more optimal to check for iommu-addresses and then read the reg. On the
contrary, earlier reg is read irrespective of iommu-addresses is present or
not. So in a way reading iommu-addresses first would ensure that reg is read
only if iommu-addresses is present.

Regards,
Vishnu Reddy

>
>
> Best regards,
> Krzysztof

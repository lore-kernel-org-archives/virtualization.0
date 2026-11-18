Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001328;
	b=c6f6itmy3b5zI+2ma8y17842ogdO4RMixGh79TW/nOVOnyfhNvLYGZQrc62miriXfpBE
	 nwaFi/1PMCEtE6wTtBnmSXQpEFA6gwPa7eimnS4jDxNfUNDTgUaGNpOcm4rJ+KanipC6f
	 wFwvXZs2Q/XgqefzTWDskoPvlv/NW/Jci0C5jsuAOnBg5jZLzwOIl+e4o0TYdQpw+Js/V
	 5Z3Gp4t+9bFJQLcPWMH96EHXTeffbodhGlbyrCDHnsp6Bum1wtLazscQdGZr9ajPHjV9w
	 DJo4i5iqMpkGh7LwOFA9JH0c/tfeiKOfbXKFWooE/jaRm7nxW2j+SZ8Wx0cIqhtvPBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
	b=0GlsqZMw+u9nxU4MSNICQL8yNtV+uO2sTkZY16/5oPSmcV3HE+BJWlS2NwiK6nAMe+/o
	 kJo34s2evQoW2+v+oOmrb0g1J07tR1OaHhJblCW2zpzxZm7LgNyU3R7+GzfJFRfAdFBe9
	 jilMNeJALw3/gU2hO4AvMWn0HUSITs/Adx1vkmTCPYaVFYtWV/hHYwAXQh/hQApIMGhs8
	 SWe6ryurro8pWLueNwgV9umLZHrScrZtecXjhQz9QjvRWoRIwUintElwbyNQrsUVtdMI4
	 wGv8hn+1xxucw2mM4yZOXdrl9iZFm9a7SqtCY4ca58dFh0wsPT0swOJ5gGrDwGIcHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mug1xXvd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593160A2603
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 11:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1593160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mug1xXvd
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBM3NW100817
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 11:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=; b=ntylGciUuJZfpWf0
	c9UM6MyqepvVZTCUP0ikndK0p570RLatJXjQ8tNCA42mvik8m09Q7kgxjCpYLS5w
	3be24pUUqP+OfFXhNIl/dv7A8fLLeH6RfrBGHOO/30xV0aBqh2ZfzKxI677TTEDd
	KcbZ5VbENV+w640ft3HbjuEvm/246WpbBNMsmpm1min/ZK1eV/GhMmmg5YZH3KU0
	zAgVZSwH03j1TilDVNNqaeyEAJ8AqtYa9gTsWf9+netIh/R8bQgtN/NKSM5Ri6RX
	MunrHSIsDg22tgIDcwR6X4XJZb2Z0OVbk665hfMAIpeETNnFmWOLuL8vK6pqqlau
	GQpvbQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9jr40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 11:28:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1091589eec.0
        for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795001325; x=1795606125; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=Mug1xXvdEZjzPEM85EZcd9eQCcITEnXlN1OP2fEDTU7Q9KXHnPDkAJUubwt5zXj1tB
         syiG4lK7PV2Mm6S2A3b9Kl+hA5sTZEGGD1ei4kIuXS7QjEo+IVi6pg2GK3fjYI1WjVwv
         dhUMF/cIYNrNkvYpKCK1v/gd/z+wwGjakcuP99eegX+tsXL45a2lqhDdld/bNtHNE/jr
         udythPw6Vli4Hq1G1phprcfQdJoFGQtTtndg96P3tEccPsbVNcznHFBK5Bepc6OwgSZw
         r8osPT0zpsmN6RiWdvmvodQqpSDrdfKaMTkFuWSm3Gno412WfUrNx+Q4ZIJzqs1OVzYM
         s+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001325; x=1795606125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=W7w3/n8p2qldWiRceDMVG271SroA4sMQXeOowLXkFATK4YoRnVTpwd31gNn+dkTsCy
         yNxuwCJnKeWWB350/Dh13h16zCpOgqxefMefXlHdVW/mwfXLdPbLAnOeR6M+yAlJK154
         jYtDGvHGkZ4nM3WwpMhJE5mM+bg/cagnEdNunLBa9IaTydoCoAy/8KjlyRgi/LGetOpx
         14x8qV6LwFy2snAbpMHg6gaDzIMybFK/w14ipXBKPNj0wV60pnZgHMQDdUJzEFjLxExK
         25bl+sDUaT19mB67FQ9WpsgzBNMvUctdmTPEB2vfoKtNmmhPgHyCdy7LugekhQ23Ir4U
         3Huw==
X-Forwarded-Encrypted: i=1; AL+hErFsifTuXL23CBs6ulk+WntXcCDDIAdFwnMA9AihGwGgxvTyB+788Tvp4/yTNukHEduK8Cw6NY8zGy6987wWhA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XDhmXK2MbtGST0XGFZbicIz0qJHaPnJR5LUWKP8XqxJjbQatH
	6E1G3wbcedETKMk/rdfNyIS68uQOmamPDmtzIpIOfAACpv1imm9PcISkmfY6llbmgUjMf+2sXhu
	YkiCTYNUURyV6sCqYWmLHsvtL/OE80zhcUofA9/khRwgQSb6bEOR15dno/5J9A41kzaE5Gg==
X-Gm-Gg: AZFdTZfVgyD4iyXw7Ocp1Z3uhNPX7QGC75jYD/4gP3PPDaRvlaVc8E1039RXEUJ1p5f
	JKKNZ5mjqM6Gtw0q481NjK+XZTVJ1n3Nie3MITLwrT9NoRjb3gTj45uP1jK0o6X8D7YtBV3ToNU
	dD1WoflLemw4RNFL7Hy7Dzu0M6Lg2VfpD7IjGDPgMfprR4/8XAR4sBW3nGKWK98PhgW0zRWym9t
	GXoZU1iTgWZ54rsfI36770kh8+7eksQI+Gj5IbiP07C+ql7YY+zaUZrq7nhUjaEAyrUPt+3OCL5
	AqShQyYu7sYF19TloNL9TVKWBLOSfdfWhoT2pkv0M2cRZ/+YFJqDT4o+aLABXt8iQogbXLZGr3J
	8o54tvu0RBGiNtcPW6jeghqSCH/gIq8+tIy9TwVZjgLFkMGP12yRiEfujOfubQZuMr7jgeb+JRN
	its6gJaQ==
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400856eec.21.1795001323967;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400813eec.21.1795001323169;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
Received: from [10.204.100.88] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm8539071eec.18.2026.11.18.03.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:28:42 -0800 (PST)
Message-ID: <1fcd89e4-feaa-4072-a5c4-56318b1d8475@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:58:32 +0530
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
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
 <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: q0a7g6t-FwUok8SN9FHLAvVXdtHmKp_3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX2opoLQrzXGyE
 vWQ/FdzBV4+X4KZ82mqQ3LWYfKHrt8ZxKbAD14f7Okls5+J5xpadhuTFQKrSpRoon3XhX/fvPnM
 jYSXue8eYvDWBNZxKAcrYGdx/Uq8J0E=
X-Proofpoint-ORIG-GUID: q0a7g6t-FwUok8SN9FHLAvVXdtHmKp_3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfXzC2S+Xyo42vt
 cEqn3N8qftLA8a/oheYJPdh/geVs1EKy0+VwjGSWF4IGuhKmlvZQb4VLFn6Hg8RSRWQaUvEoMLU
 B1B7Ba2j31XQdwm/osTIhHbY3fmTvGwO2th9m2bl/4ctJIpurQpIsILqcgfjKCxhcFfqSh59DK0
 dm4yTGcFxOKTSiZ++kbx1vcSLuPnS43f8rKu3EL1RGs2DyXKExReIBsNWL28zLQCIts1hKbNrZU
 xtKJI6KzOMg/aub/cG0LUdprvkv2OSniWoA15RfoB3bYR/sA1qGUUAzToJ0+IgWsXj15SxXbRal
 Jzp/TxwcbavtVdsB3jQ4OtIIzVyXdjw+mlZllkyBpWQ/YLSnYeumGT4EFoEoS9GEqvmUI7Pm9il
 vLzwrB4cvfY0KKdPw2d0m0v/kPazVDWTrOQmhjBnqZDEWMf+AhtJr4M1DLBaWfVQRM4C+xSHSGY
 6bNC0JWFZIMShAG6Vrg==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afd8bed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HfRq2NBFtK1Lh0_1ebIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180045



On 11/18/2026 2:32 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
>>
>> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
>>> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>>>> The OF_IOMMU code relies on OF address parsing helpers, but the
>>>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>>>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>>>> annotation to handle configurations where OF_ADDRESS is disabled.
>>>>
>>>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>>>> preprocessor guards and __maybe_unused annotation.
>>>
>>> Why? What's the problem that you are solving? Why is the current code
>>> bad?
>>>
>>
>> The commit describes the problem as "The OF_IOMMU code relies on OF address
>> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
>> Kconfig"...and instead the code had checks for config or __maybe_unused for
>> cases like sparc.
> 
> What is wrong with this approach? What is the problem? There is one, but
> please state it in the commit message. Something is wrong, otherwise you
> wouldn't be fixing it.
> 
>>
>> It was discussed in prior rev
>> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/
> 
> That's fine, but the reason must be capturedd
> 

Ack.

>>
>> Regards,
>> Vikash
>>>>
>>>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>>>> does not use OF_IOMMU, so no functional change is intended.
>>>>
>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/Kconfig    | 2 +-
>>>>    drivers/iommu/of_iommu.c | 4 +---
>>>>    2 files changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>
>>
> 


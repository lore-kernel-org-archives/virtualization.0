Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381247;
	b=HKUZ8HVDl+4aqoBeb2NwUbrlzbzLHMrtxpHH5YyfOteR8H3nXqpQM1q4m3aYTmsj+6hP
	 TxDgDqyk1PAdU+inRVyII3cQJ2oOBjfHomxbO+w32Vk71mBD7xfvKjcO61mMePpacvsCJ
	 1CjmiPxUPpulPOiwPTru4H9tN4QnCaACrREs3WisWvdq1/p2z2Olvjy4BOJeOk6jkRVqc
	 q+NO3FjjrCdauEvaDKYrmDfvedjox1phw77P97bmzwbL8iuNw5BScJyB+dMYfZDwXqtV5
	 6Lv5S+CcW5Gq5Iquyl21HCm5Z+wnYQR3VfVKZQwxkV2jFgGny4rg+/nAn5I/w3imxXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=;
	b=WmcKLD6pL0BCGSJc0m+M9lgDP+jlbB9j8Eot4EFvctNOmqXesascagCOwHfjhHIJU6mo
	 WliZ2Yjg1ICFzpr0lEhF7ZUD2l/5CKbKtCt3CqmVpDx30YJ+VbDm9RMm5q5RcbEHPPT5T
	 efLuDRaBmzJM/ZipYI9P79ROAUMj667bDauJB9pQxh0lKH6rmFu2y9XBHEZ28Ja448Oag
	 suklQ+f9a9E0FsvHNYR73K9qYTRFClAQYne5Behor1rqzU5H9vqQ6OTHdmb2ssDnhRqXW
	 3rlkWxbyJkpU+TiKQIv+xB1z2PntylGj9zcp0oWCT8/FFl9EifhvZlJFJUngqIe6hUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E6ZtrJWS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klI03bWh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B4606A324
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E6ZtrJWS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klI03bWh
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KRdl3959068
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=; b=E6ZtrJWS36NJglrd
	wrr1bpaV9Jd9mV9zd7xBCZYYEwwSNptUySacWLWhEtOics1GqNNZGOztM2ZpUOIK
	lsJ79vl+7z2qX3fM4jggXDLB9fin1eITfHQZ64UTV7ypRU9OKeO+7RVI76duUfm1
	uYBjm5xXKfiH8hn55EK8aO+XONk6UCcCKHIdeVmicDZysX1GbQ1kYILRRrb2PPIR
	33CqW2bWiaWFITu6A8Ve3eYH9i9aSTg6Zupi21eeaTG3lhCKhKdiHBsMTCpzic5Q
	oqRxqFCPKU3V5DRzDhPN0GfEeu5SR7eequFTx3qGGHRZ/N0IcQMMZdvFYhm3I2cI
	iWIFpg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b32cby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:14:06 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b238436265so1381914c88.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794381246; x=1794986046; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=;
        b=klI03bWhdII4+QwRziwGR/d9v5Ls66+2lwW2wxlEiUXLJxHo5nCFnY+ye6/hMpJS3n
         dNhrG2PHRIc93J6I0Kxfs3BNSiF1aVtLFJ2e0ocN89LkYoXwngl8qT3RuPAiDbCxzXBG
         cIs4H1FrRkXJy7HVFPUDwhNXHihmbW1ulNtiymqJyLlo5sbNAtxu3CEPHIATJYcjcISs
         /bpHfUlBsoN7FdixvcDhzFa7ovJsDuYAHDUQph6EV5ebdXuRkEEV06mgOYQABUTObxQA
         rvucxO/xg/lHw0VrKFqbko32uW2fM8Q4/fdNlw7aIfm7qIOEmoCn81mSPRXlFmkhsOFX
         c7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381246; x=1794986046;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yhiVcwHv7tpMqJImC6knJLtSlQ8s0N4Jer0j4grDt2w=;
        b=l+KWaRR7bm3Al/ydqt5y3t+S7D1ziJWcW1HnZOnHBjsaBiblpVhKPckXUKhy3M6tu5
         bpncY9A56xw+GnhPoyYJPMPv7WQlWiwPoaGtbHDvfEt00DztoY5WeVMLR6pB+bHr5UFA
         wUd3Ootm40KmxrSpo9R7dEmYGJncBJ+roHNoSkkvSYGIDaWMyBlfmRG8w8nEDoYHOrv0
         MrcIL7J+NdhTCuSI753LKND9kWQ9V+gqrzu+nbRndLyodjUgcK/nmfnYpl3/rGVnme31
         hq/pmpHzpMqdYLc8tOxOyHb+iEdaoIZw2M5YAAoImQk7544FSw92ooafMJ1AN4wcvxZ8
         e9+w==
X-Forwarded-Encrypted: i=1; AL+hErF+FPp1GXX6frZ1VIC98zgBk62NW9F7Iiicn2UaGDnpC/gYEqdfUv2nPDPc+PpOLFA2IjX2KXJ7KstM4Q/fQQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lIRSBtpg59wv0j3ZfsyaV/PUAhBGs4+PVaW3VEwtYJH+2RKby
	npByzI7UiUmtpKSZsyafN8slB7NBhY51YMwRT8TDPEnSgU5BTZNjRuGCBgAm4yQiM1q4ym68+6t
	agHMscR1/l4zrbRI9KjlIBh/kakXoRBlGLEZ9HPngHKVrU+ED+Xo+9ZLMwv2iN6dU9S0r3w==
X-Gm-Gg: AYBFou2/H0Lt8J9xtsOyTid5K+GvfBYZl6LkasoiaPqNAxymTevTCqfVkCD/p2MZBkd
	El9oW7wbIs1CHDyqygFtMBIp4sPek+3dXInY5vQERhXGhI6csn5zZBB6mhyu2pVh9w+HAps9ipw
	MlFsx6ovo4AtB6xkrsaoHLe9RuFFo+oVAhXwh2topNW9vI+Rx5MyInfhSoqbdOdrdSOdsJvzAee
	wOI6tEoF7tSRZET/9nmRPkG70djPDKUVPYCbtQ85oiSGXE1itEAm6wkweqS0lSiWCm7bBZmGli3
	uiJfdGHgdDsagTjIz9YYliGVlxooc+hYHvAdpV3X0T6FBIWZhXnbGr+z5ZmEChHRhrndazB+xwe
	EnnKVnNzzVLW7SG/n/8GmgoXuBOKCC0A73jqOWKh8J3OMn94NK/kKKHbf6n0bpJnf+WvrLxH/nE
	PUtMIyQ1A=
X-Received: by 2002:a05:7022:170a:b0:190:da74:2c89 with SMTP id a92af1059eb24-1b3c0324aafmr1387046c88.21.1794381245617;
        Tue, 10 Nov 2026 23:14:05 -0800 (PST)
X-Received: by 2002:a05:7022:170a:b0:190:da74:2c89 with SMTP id a92af1059eb24-1b3c0324aafmr1387024c88.21.1794381244935;
        Tue, 10 Nov 2026 23:14:04 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm13146024c88.1.2026.11.10.23.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:14:04 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <512f4c94-15a0-4ea2-aa70-b0015fcb4079@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:43:53 +0530
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
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <20261027-camouflaged-orca-of-debate-316694@quoll>
Content-Language: en-US
In-Reply-To: <20261027-camouflaged-orca-of-debate-316694@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af415be cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iiY4aUXpewVHb1WYKVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX7ziZUK2RFd80
 hivKj8yKAXPXJUuKq5YWMVNRMt+PA/CI2x6N8ffnWC1Mw33Z8ysYBGHQzBPX5utSNG4mHYwXouM
 jJO5rEeZckpg4Apq4F1uO29a991HOjWcV9Unhm8PbK6Hyfrl0tpNZZHtSRr7T25bR5bIjPcZS94
 7AZQZ8FSxEeG2uOC4X/FREgkc4hZxMg2JTpTsyJWMAgun9unG1KFSmQvJ9/RLxlqT/X47oQqiFA
 0lOCpGXW9qsZOJJOpRAV1GFq0ma5ZrWX0OG3/C3fqh+y17711KGvdbVoCLxjthUHW1NrrwBM0BP
 XHqcLxp0cqWj1+2Ya/6wrosomdQ0j7EeHTsk8ZwAskFjL3ug7/KcHg9gNM0KGGtLspp2PCaxT39
 nHu8Q7wRXJBcANFzUDYuDHlM0Es/qUilS5JEM7mDbK2AZdqFgQ7BXvSQA6ErawZp4Aop2l4davQ
 C/xdyfPQYiBa6Q0HXwQ==
X-Proofpoint-GUID: RHchVO_z3Udpm_3JQKmala8355HqnsqF
X-Proofpoint-ORIG-GUID: RHchVO_z3Udpm_3JQKmala8355HqnsqF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX5yf4fUe+ApFp
 9qYiDl+18oB1Kd1YkkYZVy0Wl/b/+fpSQCWk5VXXlF/GAMB4ijdjlOVg6tjAKN1DAtNP5vZC0ej
 9qqjqcvcBmGMI2E6+J4cK3UeuMOMN78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110028


On 27-10-2026 14:06, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
> What is a DCP platform?
>

Will address this in v3.


>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the Qualcomm transport
>> wrapper, display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>> subsystem. Document the IPCC power-notify resources, transport and
>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>> after the IPCC power-notify sequence has completed.
> It's still DT for real hardware, so I wonder why no SoC specific
> compatibles were used.


Thanks. The same DCP transport wrapper works on Hawi and Maili, so the 
current driver uses the generic qcom,dcp-virtio compatible.

If a future SoC requires different wrapper handling or has a different 
layout, we can add a SoC-

specific compatible and match data then. The child’s virtio,device34 
compatible identifies the VirtIO function.


> Best regards,
> Krzysztof

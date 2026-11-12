Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476891;
	b=A3QpI972AUn54VGftZSWU+tym4No+0WwtzR/pqoB4lKChrvrObFtrSy7FxljN3dnPtwf
	 sDaNj+xamKaZhkUPE0j5OgxVfPsFP5OuDhIMJa1K8l4pMA92CmiXIEkW7svOvSlBtcZD7
	 J0FMGPrSzaqh+lanP1pTFezsNcP1vTeFkxuTUKgWxB3Gfbx9VRVW0tauz+GIzP7/kl2OZ
	 dsrp5ybGrtU+Q+FM9SkXg/cvLC+LS7b8PQXZY/TLdbttm91AQhuAo1KLfGJCUcmEerApk
	 eMyT9HKBnj30/z+0TFE+bKGvNXzf8EZIJfrABICUiy0rqOSXO2mIRBv25hmPuYIn7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476891;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
	b=A6uHwYpyCtbWk3/JvoqlU+Nl5V6aszaVilScLsZ1xtZLHwVMm7OsXEta4agVU7NgnMJx
	 LeHb1yNOMFR0bFuVH8kZ+tlMtAeloQHD9ooYNHgIPL+5xhXa/UIKwkR2F3KTjN3AwUtmE
	 dR28wZvUaoRnDl9Eh/M+bD9c1ylnwz9Q7Q7rZ48pFVxltDUQ8zGpFptntIvD3wrgJ+rZP
	 8dPyNIW8eoMyeFXSz0Txni4hdy2+S9Q3IXvcBKuI/csg43qhnMPov+/A2DmtQU+GJNti0
	 7Sdyz9ToGJ5qu2kmmJoBbbnFzgeUfgPy5LoFNFjVifdDKX8cf0CYYBgC5RIJLc9GI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEYzziPz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g1GVq4hp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03E606A32A
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D03E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEYzziPz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g1GVq4hp
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5484A3477432
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=; b=lEYzziPz3E3wXE1N
	/r8Q21KLI0GSOoZbw37IOQi+XRe64yyHxO4KJMKXyD6wHBr3+uN2A2DqG1aZFVCb
	td0orAtjRp1dC4j/KyPqG5d96q5y7vKMm2BKTOKsdt1dlyUwp24z+1cEnebHmiba
	lsmQibx194c8rA9m2TXh3aOD9i7AI6KxyLK00WTHqjhvlhD4uAN/bB+W+ouD9DVf
	YFu1UNcSm+Up02WumBc+r6ikblrY5kMlzpu37riEDvTPfzmaBSpLyb+pCef3TTpE
	LJnjDCjjnF+Cz0U9C2aBPvT6jwMkRiiKlKn3l4dQXbHdnu8pkdbQTpnhKR5UBEBO
	sdPQmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yugyk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:48:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so5118971a91.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794476889; x=1795081689; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
        b=g1GVq4hpNj+LUfMCV9Lz5qYRX3uiYuuTl4+rd9E3cC69OFVyt6p7jtdQ8WnFHaNq8V
         gFLwwViLDLoVG2F4brQUDsj7SzZoUlD5oXzn1AFBNRGURnwfyX6OHqHVQIy16nJNdsEZ
         yRI15YFfcIaMLCH5fzljmQ3Qvfl09jIk1F3g1bS0o/ENZDHgNw66ewQ4gZO4elWnVfws
         oWFD8OzXIN2ilbnxaXRrdrn5HHPoIwBTpNTKEhYTyCBkpnPzhw3se9DNDe06SOMt/jmp
         LTGhpHl0/u2b7KEOMGrY6dmEHByjC7CAYjmLkGQxMKfywa72E2bJdDRjj5nAW5f1OnoJ
         a+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476889; x=1795081689;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
        b=uUsSZCJNtCCWYnAPj3TSwL2FvWFadaZOiRoaLfQkOnDh0gSK9ojgBgVOT7Gwvd9PjH
         9M2MR6Enu8YGuI85vYTRtjCape9YkA8rrQfj93cfEPN5KHxyN+hSd8wyBNCK7Fh5zHKN
         Bym+ouIG5e8zySbbg/eFRNXlCxIXTnIcRwkiOgsP9RYrX0Hvmg7kQZ5fMUIK3DZUBKKC
         c/KBg37qsotfkEZZdIO0oqV/sdU0dnS4ZwLTZcodOBOakeR6L9i7N+dvvFX4pGIob57N
         42UkYGBguOsNBooEfdZJ+knZO6S/pzXdfHcYPTN1JYEpazHSA/oh4PAgw4tl2Ivse5l6
         f27A==
X-Forwarded-Encrypted: i=1; AL+hErHVPRuNrKPtJVSzjmq5Z50H5GCto65kqTn9LEtdih673B6FYh7rk4kWlv26kzUNJdcW4ERzwdVHJ6gzIYvOWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vZP9/lBci/ND1Qzoocxc3tJCOac5jXSGO8Gr9eD73b3voPCAD
	nrwqr+6M9pjlfDOUYEXOeUVlGCfhwwhn+dm2nfWk6B+ekTEqhvLkF7VWaf+V3+QRFR1IAwxRRfu
	Bm+q9wjNXIvLpQbzqne1jlNBUOdNFp+ay7dp+sA36XMouN/+Md88sBY53leQYb4j6gikGRw==
X-Gm-Gg: AYBFou1O7V7nz+Pc4JPjCkyLsumZINsIx3NlpR2OOt9waSnTvSmupB7w49JqAFo1A+D
	anda6cGxbn5g6xqa9mOWWo1YqOhhI2SFwMbZVUSdGNrBxN4HK9bDZz0G5xsPeVsIG9DLerduwJO
	zH5aSciKuFTobyDEqdpl2Y1EACsaj9owPAPXu5jYIXVUyQDo9EeT5sCMxTC/1jYISb3roXK6XQE
	F8Xwd/SLpcbS6/g3DGoWewBRy7SYZGaKLPCUfD/iFIFkQ7QMp4gL5tILlCnTJfkQxiR2drSi/gb
	iXUdOqAwbgVd6vc+t9h1fk1fIlfZY/5RLgjjyND4hXOJWEZECxNdZgCJqs6mBD8gKWZ55t0dJ41
	l1ILor222IhEw973dTnW32/wkFOXbRSs9zebm6nI8OqnSLxubpwlWvDuJA8jPq+MuwG/VY/Lbxw
	LdkjjCBrk=
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b182e9457fmr5003624a91.12.1794476888794;
        Thu, 12 Nov 2026 01:48:08 -0800 (PST)
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b182e9457fmr5003594a91.12.1794476888303;
        Thu, 12 Nov 2026 01:48:08 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm3913394a91.10.2026.11.12.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:48:07 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <2932200c-d930-4d5f-a308-0bde202af349@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:17:55 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
 <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Language: en-US
In-Reply-To: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pn7kcZOAHHeVC0cIJOPIu0s0WIvyrjDY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXyGg1jaD+Yb/+
 GeN9R0/SpiVKJ+1GZucguZCZuYeJkr5W7f8RHKCf51bR3PdpBRzpWWn7v0NjfnB8h8QRrbmWo3P
 tzDDhMLtTNGI558Wbf49XFWj9ts9JL4=
X-Proofpoint-ORIG-GUID: pn7kcZOAHHeVC0cIJOPIu0s0WIvyrjDY
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af58b59 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8VBehk7qD7xQtsfHT0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX2TD+g0pALEFM
 kVoKnQXGjKjq3FWaXq9kQFiKsb37MtRyy96rTtGNBvVV1zYDOo6N/D+jR1/xPPMf0kJOuojFknv
 q5iNcoC095H0pbF7VijuejE6e+JLSeyEus82U4fL+9WRChR/DN+k1+8sBeCODwxgxoSIkFL2ILa
 SSmHX2viRJZgF1/1fp1Lk9SHnPdxGtp4+jsMEmMsP8RG7V0dOQnGpbcH1feJWu1w4puyhHYOsMl
 hWhHjB6XPWWLdxLHCUHi7zenFIlAHkCSjim7YXj8AovYqUZGqzv/IsY5SBliecPBDptuBtJwQXf
 zt9mQOMsab086qML8+ISc7UVE3N64CzTp2PqnPeAYRQqjA+ko54Itr2OrD/rt53IqFHjZ3eJDO4
 PFX456iOQMKwzrxkdOkQk49Z6MzhtdNr/5+AyV0zTo+FKsQ4Tqo1seYJGFFO/w+gQL8P0QjnQrP
 2FotBDvKID9IoqWHjQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120038


On 11-11-2026 19:43, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
>> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
>>> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
>>>> DCP platforms place the display pipeline under firmware control, so Linux
>>>> cannot discover display resources through direct register access. The DRM
>>>> driver therefore needs device-tree descriptions of the Qualcomm transport
>>>> wrapper, display topology, IOMMU contexts, and panel connections.
>>>>
>>>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>>>> subsystem. Document the IPCC power-notify resources, transport and
>>>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>>>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>>>> after the IPCC power-notify sequence has completed.
>>>>
>>>> Assisted-by: LLM
>>>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>>>>    .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>>>>    .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>>>>    3 files changed, 334 insertions(+)
>>>>
>
>
>>>> +
>>>> +patternProperties:
>>>> +  "^dsi@[0-9a-f]+$":
>>>> +    $ref: qcom,dcp-dsi.yaml#
>>> When adding DP support, would you add more devices at the same level? If
>>> so, we risk getting a warning about multiple devices using the same
>>> address.
>>>
>> Is it good to model each firmware INTF as a single interface@N node carrying
>> the INTF reg, with the protocol-specific DSI or DP description nested
>> beneath it?
>> The driver can then obtain the INTF index from the common parent, avoiding
>> duplicate addresses across protocol types.
> Yes, it might be good, but it's not what is happening here. You are
> adding dsi@0, although, I guess, INTF is 1.
>

I raised that approach before v3, but the patch still uses dsi@0 
directly. I’ll update it to use a common interface@N node keyed by the 
INTF index, with the protocol-specific DSI/DP description nested beneath it.



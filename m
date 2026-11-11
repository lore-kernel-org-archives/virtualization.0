Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406391;
	b=Ige6o+XhCo0c1hZRhR3pqHuO66QXE2e/Mb5UmEf2ybruSM8DftMtx+jQG7r8M5ilTiFb
	 2WFfv5i35mz/2OLxz1tc6fzVsFNiBoVDspT1K9T6sXdf4FVEScgr9lwQwcjhjTCrRz/Yx
	 4v++aLWJNRuy93Mfzi276H5CeRS0YIgQPsKKh6ZwS+yxH3tIxK0EFXNfyDqp9ubcq33pY
	 v6RYvtDWmajBXEdI4k8JlZPXMD8oURdwf/zbyCEqqkPHXUlVGDBSynd/HF3MUCCH/x8YM
	 e7/qH8P2xHbMERYwA5x6F7cf1Ss11/n47l1EbQyYBl4V1ogC3x6z0AXlHtJyWywfAAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
	b=U6B8nQBqkjvs/IVbXbbw/CHUJd1T+RJz35ZYjb5P74LaGNfChU3Q+J+I30F0R8Oaz+MO
	 c/GDbf1ytGP7thml+2rPDM9X+2aGveu6Xmho8ruIXLLv023phi3tSSNFwht2Ebd/k6Fyv
	 /T9qxIvra6utJO38qdNQswLhekILaWxwE7epUl+N+KBBg/AsVjLrBK9M5tk9DtAoz39XS
	 7vmPHOaUuCvVlKAQc3RkcnOTtCXRmYaTaRvGDRsvKikkzBHeGLzq35LDiul+nArQsfLwB
	 t6knn6OAa1C6REix83w2NFam7GoyRTVEZTskAL/JvDoBcYu6Wxh//GmisLQuMqaY3sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ZCbj/bq/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P37pJT02;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA3606A338
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EA3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCbj/bq/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P37pJT02
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ2x02001453
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 14:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=llfh8etuwqMEBoatS7BG9atT
	A4vpv1pJNPCbkPuzpyI=; b=ZCbj/bq/7etR5mduMsXYp0jpAwQ/AZdMzdYdASci
	VmMJONZ+iJEIUbANBiDjtZphcWabwse7wGo9h645cixX6XcXKZ/uGGfPLJ4JCERB
	e8I7/d5uvjtX6Fw9P/v8ncTMUJg6MECCmrpbVV9qB8RiuOe8CAEq5tV0DSgzvrXS
	ey5Gg1BPNsa8KT+NcxPxPlnh+AJcYxc7TyWgZXzrM+P5SfYUHqybWuG1ftpAHVZW
	5w25MerOy+XYX+KP/GioZbvtfeBkosizv8g9POZL/G7BWgPNt+jueA+IlNyGQM38
	I9qm7lpjucG7INeL2Za54FsOjajj4386I+7u307pJIeOXw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh2yyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 14:13:09 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99062be02ddso501690241.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794406389; x=1795011189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
        b=P37pJT02fll5VAqvLNE8taolV3X1t50GxToR4R3nJyS29yupT4P84L/l1KADc4+Ajd
         sy66H3El6ZB+KT3htPzpVHyHnL26SZFGTUmeQDXbWU7oAaPvCQSbgh6fx5n7TUqsfimt
         ikvX1w2UriHp/xBUK+AhrMMcW6DyK3kA/9xnTqUIQQzQLp0DjpGolqEiFppPrA41w5Vp
         Hmsf2Mst0eMN86hhyJ6JuTpMHehuPInlbcFySI/QULEzrm9dL9GOfVVQick5pujL+2EU
         0vYBgTCW5LIHPfjXIaefnqlE16Vq7i/k+om7tTpw6Wj+uRucQs6Anm5yXqqFQBhf9WyN
         AH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406389; x=1795011189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
        b=wEed99i7TxMdLG3SBhVyAIlxYbKkHnYDQQTVsbSTtBIoZQ+BdajjuKsbemeHoxIp2N
         c56kC5urguZ3FQuClRlD9MiyMVi8HbhOffJYAlHsP+OanWuy1OBReht0oGHJ7i4m7Ao4
         ilmeCwjRLfyPYgWmztP/NmfgcRxoqVK5t1cm5nZLdFvP9c7WgNIioNNW2fFx7lq34EAt
         abgh1mseNuVcALW0kDIGMkjqmxpY9BktTAz87VfgK+iiWi+8DKsDLeGgVASRuaAJOrfJ
         7ZTlTfvSTcBRDS7QOrN3b4goE1t9ewm2XgGyMCpSECGII3pVbVz3mQoxeWNsbENNOXfP
         5zOw==
X-Forwarded-Encrypted: i=1; AL+hErHF+zeEwxiEailTMgjagTNZYLk7DeInS58ln0WF80NTpxOX7oc58J6Ie+5NzImbNp4w+vKj6nIoX3ktsvCBIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Fh/iMWDCtfB/W+KK3KBIhkszWDN79AcGp17y92ifTaKitKwqz
	Qh5OKbL0z88uIaDT+SG2NINAC+FXKwauS4meXxyWB+faC+a+i8cF4NIDsvPTqh50HJhYC8eCPQW
	46A95QymJIUpN5mnyrZ48fumIUbCpgRBw5I6Ql51KwC9WCn2ODDaA+Bjy1424nnige4PGNg==
X-Gm-Gg: AYBFou0o2TDj/VYF8IzBEL3rEXA7X7GLUOHpjYy88Wfz2enFDJBhEGjRSpeTpFqRxSQ
	4mX0khvtzjpwxYeFESncNCE/M+lBUhVfcuV5LA1b3N2RXyqou3sZuEN+uGv94XaFbW3CE+er2J2
	1qsaT/m+QtyQp06PZLTCer86XdRZ92ZgBtRPwQVFk86fU8oAFNPe1it0W0ELkSVS1oI7eNw3LyD
	xzFuqrVoAtHjpoyI+4GDQEi0F+ppUma0NsyNGYHbkl0+L+ghbmj2Ygjklh0WeCQHCNrYLdzNnoW
	vG5bnx+KOEnx/OyOnHEWIlbRINHeVr7yTM6/I/X7maTWFdl9uzVF/3mPKbVQI1TJwT2l+axjDoO
	ve+Rb5AJ9Ps33JOI5f77Sd4FljDijhuIp1pC8jUrhfBIV0T5rX1MxXxMwrkjzTfb/6e6HV3L1te
	WEVJFhbQaS0JNU51uiw2Enwr/ayZmV/Yg1URTz+/k2tI6fcNoKvFV7FSw/0/yVng==
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ee1c462ffdmr791592e0c.16.1794406388863;
        Wed, 11 Nov 2026 06:13:08 -0800 (PST)
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id 71dfb90a1353d-5ee1c462ffdmr791529e0c.16.1794406388144;
        Wed, 11 Nov 2026 06:13:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb7839sm956114e87.74.2026.11.11.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:13:07 -0800 (PST)
Date: Wed, 11 Nov 2026 16:13:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX7fqjrv4sFx/z
 ZNFawa7G/xJZOggoiomPKY72QUvnrEKqg0AT0XAie5/7cCchBiBzvH3UCNW0G2SxHnkdKCNw875
 5mxF+zyKli5YfCwf3xJjzf6BQUnlzEw=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af477f5 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=XCsYekLr3cgse1I9aysA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: A9NLkcQEA_Oec9i8JYhhyzS5Nd7ftUhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX1nSRr6wH9AZ7
 2p/IgSRtCNsfRea4XHwOTp1Agg+req697xmCNuUav/nj5n2DPAA/gKHK5S2F5oIdGSpGaOCvCte
 a2m1h63l74aTilDuRYgc0aGrebStTnBb2ANEmShbFfNRpq1P+tBbufskJetoUusNijx17VBPNEc
 Y6kbnxlVxAxLSA4nZNjQY278Ldm8JHRpW3iWqINmOMHoM9rU/X0xBgJxUMZYzDjsRLrWc84syRw
 DY64DjnFNGpTUQAfwfInvjCnM9/Iz+9im1Fp8fB5Tn2An+h+L9O0wMbPW2qIPkbx49mUZ49ciA2
 twx9ogdbCp+64fFzttN+Zorvz4Zph8XhV06uYj2HaKr+2OtJh0jGq31glwCI4WZJUVM5Pew5YDm
 eKruDoippiwoIZR+YG4Dq98MaJ/h4dWrh9Jxf9vrXVrcovw4wwbPp2ltwkSpUYtph3Lhs5asAdp
 3yx4u19/+3xUGJlF92g==
X-Proofpoint-ORIG-GUID: A9NLkcQEA_Oec9i8JYhhyzS5Nd7ftUhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110056

On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
> 
> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
> > On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
> > > DCP platforms place the display pipeline under firmware control, so Linux
> > > cannot discover display resources through direct register access. The DRM
> > > driver therefore needs device-tree descriptions of the Qualcomm transport
> > > wrapper, display topology, IOMMU contexts, and panel connections.
> > > 
> > > Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> > > subsystem. Document the IPCC power-notify resources, transport and
> > > framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> > > DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> > > after the IPCC power-notify sequence has completed.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
> > >   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
> > >   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
> > >   3 files changed, 334 insertions(+)
> > > 



> > > +
> > > +patternProperties:
> > > +  "^dsi@[0-9a-f]+$":
> > > +    $ref: qcom,dcp-dsi.yaml#
> > When adding DP support, would you add more devices at the same level? If
> > so, we risk getting a warning about multiple devices using the same
> > address.
> > 
> 
> Is it good to model each firmware INTF as a single interface@N node carrying
> the INTF reg, with the protocol-specific DSI or DP description nested
> beneath it?
> The driver can then obtain the INTF index from the common parent, avoiding
> duplicate addresses across protocol types.

Yes, it might be good, but it's not what is happening here. You are
adding dsi@0, although, I guess, INTF is 1.

> > > 

-- 
With best wishes
Dmitry

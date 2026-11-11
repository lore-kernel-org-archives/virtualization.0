Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381694;
	b=GfEymWb6IbVxMnA6rHZq0QrPtXbeuMbWyOjjLrBJbXKyHnP819Q/x3Ms/o7KsoxuIML/
	 0ufT3xtz414cxZhwNrAHka8XKpxOblJ9K5h5nWid+vdzQQW6FSX/PCKJsyIhuAI6uGt/Y
	 J68VZiMfNkHfverBN0e4Hb9Pix2B5Y1IU96R1BBnyOLScFlwNGzqUFFPaVHbAqX6dzeoW
	 egoPEMcMmM8p9/NufOW1AG/Iw7b5T0bQr+KWw1xqT8hOeBcik5WI9KvU3yf5TCZwoHxp/
	 0zMe7TtRH1mbtnUc8nxAW/e6jHeyNbHgMmljrC+wNBXoRs2GDa1bl0bGUeqqRptlAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E36nUJlmupCRlPI23cpWhu71/+TGCX9VO1VgPG365Bc=;
	b=14kncqZucTE0RUW+sIAyH5Sr+k7HMLNml/GUh4F9dhWaUG4Ermdj7IJg6IS5xFMZ/K4P
	 kInBbjWMatQhhxogME8xFp5hTHOiXFadaueOHTI2R3Pe9vY5hS06sYOiJKekndA8VeoyD
	 mNs26KYBjCYxD7PnpO2QRDxv+2WyCWcmfaRaJCjC+RMv0qVGuLcefYk+GVw4tr2vMjTQ4
	 22EzRi2++iZUblItoexxxM+Y7G7KRokGMemwxqFq8TuU/GxeBcXd48aK1PIFKPOYYll6j
	 9nFFpGnCXuZcdaCGOnr+GteWvaicjNOK6cmN8F1AEKZhKNlJ7hzlzjURJi67pQxrPxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kyTGiJMP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PvGYNu1/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C4606A321
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kyTGiJMP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PvGYNu1/
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KpsQ1052622
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E36nUJlmupCRlPI23cpWhu71/+TGCX9VO1VgPG365Bc=; b=kyTGiJMPKLkSsQxY
	YyShBsVrJd4hS1jvae3ghDzUj0bu++it2pLqGix760acTRzksw+/9IKAMhz7i7/6
	fTfGuTVCQiOw0Crw80NrroJ2iYfYAM+Xs+pWTdOxoX9pdoRziPwsgEcUvjpg8We2
	Cyg1zodg/RRUfQDC8yTPwcN2d3fV21xWiIF1NQixWN+Du1xCs2szfeGea8fCe1KL
	QhsF3/rTpit1jZB2mb4GaeZsCxIPGgJ3dspccfg6ErReu1osM5Mkyv2TdnrhbrHX
	RLHeM1QNWhZZEigr3GLmgzzr83vBGv+uwLEkF9ivaH81mRwl2X2c/mXzKE+VAl2v
	C1f1/Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh1bm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:21:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b69b8c6dd5so3695128b3a.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794381691; x=1794986491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E36nUJlmupCRlPI23cpWhu71/+TGCX9VO1VgPG365Bc=;
        b=PvGYNu1/XotkirzPy/P2TwwcJiOhF52OyJ1aM9cwGXSNaOEMfyQfA67+VGymbauJsh
         I70gVNScE8PLfXyKd9yX3uePoCzO4gUo59ukB/KU6mdKbotGW3N+asB3nmSNQGLS3Hso
         rMlApJovFcIIYRk/GP93th0/9aqLrGbo1WzRnjSuwMwUgD4uG26Lzufsaa9vvhoJ/ybi
         fFYadakdLxxWp1TXpbXVHWF/R4pLSFV3nfdKcXlNwiG2J9/FdpMB598/fB6DmQHG80br
         0FRYZGYQpWlNxnarZEEc8eA/dQAxbkGVn0hD+9KkitEbFiwuHBZq/WdmUNrl3yHo0S/M
         9ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381691; x=1794986491;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E36nUJlmupCRlPI23cpWhu71/+TGCX9VO1VgPG365Bc=;
        b=bBntp2wtxOiD43Hcv03BmgbtZdRapw41GdOnXse20az4HsmejvR1brGr1xOnwJ3Gah
         M3mWdIs7279qFFHhMYicfyfVxwqVNOAOi7uioD+qE6GodZHagtwXfDr2q7xsppCNp5Zi
         ftf7MF1aaO9Tf0XTMNZfOYm5NHouAHvDDSdsyJh9nIaraK3VFCI3glxNBkcEs7K6oH7N
         VTQrgvQl8l/IqP6O69NTy3Ck60gx214rvV1HPeZQTJphsrP4G0ZIN2crUmDsXZ4ZhXtp
         AnIYSDdJOwWmo36PHI/M5X8KiD5kBjGC0m0N8Wswj4V9wbajR0fbqBc9Sz8uIB9kN2zj
         hFNA==
X-Forwarded-Encrypted: i=1; AL+hErEZGD74JmUw/H4jsomYjVvCRZ72u4D9rwDoNZ/pQyDsFX9SIaP1G6fHV4InRKw9U8V33wB6XjILxDujcaglBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8hycBECuRnn+2LKPjCd3oD3gPd8nmX3uC5ptWi0eFVal+De/YL
	zesZUa6mqkOZRdRHKJqqVmocEAsRWMg0wbue1ES0BRaonwMuELKC6WyAyTQUfRwfk0ky5pFFqPe
	J9YolWx0RaOGeIUs3Fwtqb9HRNAsdbeVlUYKE2BjHLQalFWRk8UBFIIDfBqVOkLdqdGhnwg==
X-Gm-Gg: AYBFou2knPtc31mhCbSW9ChgZZQzBWhUNG26jZ+KuWn5BkEYMx/Y9vFBpPmoFpIv4Xj
	E6XLYN/ZvvBZbQDKfMCd90lSioEsN2uwBxQ+EvFKYSYOEQXccme7OaL9MjIm85qIRsHlhnJYD2+
	l+A+rFbAs4E0ObMYeve1v/VimLbzZg/0Y2jiixB3G3n0FWzbfruuyISkVIC6P6y/C6RROtA9dd0
	VT+5g3oxNqaIHVN0zGeMbbDPKSqEiX1ZzPKmGjW4hMlbjQ0aYfwjVWaq91H/V/Cf9lIh8H4MRuH
	MIeGxGfRI1+bO4DqwRJGpkCBUM4A6mycgXy7/SNE3vFdBLM68XZRr0b5RorQY5OyEpSbH0nlyg7
	Re3eu6IofrqgIT71ZqHw0RkeU5E3UW4XnYL8IfgPPLhEyOixTQ/M6ZC+28IRRPtv9g5cLIlAsjj
	jgkou+OCM=
X-Received: by 2002:a05:6a00:3c86:b0:88b:72d6:b438 with SMTP id d2e1a72fcca58-8bc1bec662dmr1861278b3a.29.1794381690749;
        Tue, 10 Nov 2026 23:21:30 -0800 (PST)
X-Received: by 2002:a05:6a00:3c86:b0:88b:72d6:b438 with SMTP id d2e1a72fcca58-8bc1bec662dmr1861216b3a.29.1794381690017;
        Tue, 10 Nov 2026 23:21:30 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dccc7sm1725318b3a.52.2026.11.10.23.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:21:29 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <5126ee96-1109-4e5e-8b55-3351bad25d29@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:51:16 +0530
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
Subject: Re: [PATCH v2 15/23] drm/msm/dcp: Add DCP DSI host and panel support
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
 <20261026-jshekhar-dcp-hlos-v2-15-7cf014efdee1@oss.qualcomm.com>
 <evgqb4hmoxz5pvzulcl75fmi4hwauhquzbwvc6ngkz33rsrl3a@tnolis72u5vu>
Content-Language: en-US
In-Reply-To: <evgqb4hmoxz5pvzulcl75fmi4hwauhquzbwvc6ngkz33rsrl3a@tnolis72u5vu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfX95cP0NM+zQhG
 mzwx+cgK1z2cDj30xOVJ9+DalcvNzyG6kt7YXPxgK2H7fuoZ4QiEef+b6MD9YFGaK9oKarER5Wx
 JZZ7vb1gFtz5h1LbWhPPv1T52s8gyxM=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af4177c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5KJyw0EJLqpdfcsonpYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: OaTs5swdyg8KORo5WxCZgvwIbufqcCct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOSBTYWx0ZWRfX9JStYvvDv0cW
 3phGlYsJ62V+bnPMdQTuFg7TpCuFqBp2Ex5iY0iM48r4ah3eb01jiqMl+SkToo/VQs79cSUGXi0
 lMofJ8rdbLB5BCdq+/+7beag7I8EHT+T/iIWxkucGT4SGESF9+nXmGGc922GH1VPPV+LoirtRxY
 vlDIXmcx8iVN+K+BkafF0ll8C49eqsx5ojxnOQ1OMmDZECdqN0mia8fF87lrtsBONgiQjIWBkBX
 1MJaBeoJSKf0OPS3kmmn5efQXnvaYoBSv0hOa6/QxjXj7frOARWsXgF5Xsdg0p72ikbp7MyDmB6
 SXB15j6nr4su5PKpArhi2T5OAKdReRn+pQZux2PX15F1LTafPVnywpIOAX10r0d+qPKcczYDPjC
 ZZut6RNrvmyUP/lb1ZMy+e+QVpoU5DziKd/F3Q0ZFLWhZCBLof5hwZdN/W9lISF19IOf1zCeGpY
 LgWAX6sjRBjEBK6GVGA==
X-Proofpoint-ORIG-GUID: OaTs5swdyg8KORo5WxCZgvwIbufqcCct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110029


On 26-10-2026 16:38, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 11:51:25AM +0530, Jayant Shekhar wrote:
>> Expose the DCP DSI host and panel as DRM-facing objects. The DCP
>> display path needs a host, panel configuration, bridge state, DSC
>> setup, DCS transfer buffers, and panel lifetime management before it
>> can drive a physical display.
>>
>> Implement the MIPI DSI host, panel-device support, bridge state,
>> DSC configuration, DCS transfers, and DSI buffer management.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/Makefile             |    1 +
>>   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c | 1110 ++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h |   76 ++
>>   drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h  |   13 +
>>   4 files changed, 1200 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
>> index 4024f6b1e3cf..9f0a9bfeb2a7 100644
>> --- a/drivers/gpu/drm/msm/Makefile
>> +++ b/drivers/gpu/drm/msm/Makefile
>> @@ -75,6 +75,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>>   	dcp/dcp_crtc.o \
>>   	dcp/dcp_dpu_kms.o \
>>   	dcp/dcp_plane.o \
>> +	dcp/dcp_dsi_bridge.o \
>>   	dcp/dcp_hfi_core.o \
>>   	dcp/dcp_hfi_crtc.o \
>>   	dcp/dcp_hfi_dsi.o \
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c
>> new file mode 100644
>> index 000000000000..b3e782b8f047
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c
>> @@ -0,0 +1,1110 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * DCP DSI bridge driver.
>> + *
>> + * Implements a DRM bridge for DSI displays in the DCP firmware-delegated
>> + * architecture. DCP firmware owns the DSI PHY and controller; this driver
>> + * uses HFI commands to configure DSI parameters rather than direct register
>> + * writes.
>> + */
>> +
>> +#include <linux/component.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/completion.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/iommu.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/math64.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <drm/display/drm_dsc.h>
>> +#include <drm/display/drm_dsc_helper.h>
>> +#include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_bridge.h>
>> +#include <drm/drm_connector.h>
>> +#include <drm/drm_encoder.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_of.h>
>> +
>> +#include <video/mipi_display.h>
>> +
>> +#include "dcp_crtc.h"
>> +#include "dcp_dsi_bridge.h"
>> +#include "dcp_dpu_kms.h"
>> +#include "dcp_hfi.h"
>> +#include "hfi/hfi_defs_panel.h"
>> +
>> +struct dcp_dsi_bridge_state {
>> +	struct drm_bridge_state base;
>> +	struct dcp_dsi_panel_state panel_state;
>> +	int prepare_error;
>> +};
>> +
>> +#define to_dcp_dsi_bridge_state(s) \
>> +	container_of(s, struct dcp_dsi_bridge_state, base)
>> +
>> +static struct dcp_dsi_bridge_state *
>> +dcp_dsi_bridge_get_state(struct dcp_dsi_bridge *bridge)
>> +{
>> +	return to_dcp_dsi_bridge_state(drm_priv_to_bridge_state(bridge->bridge.base.state));
>> +}
>> +
>> +static struct drm_bridge_state *
>> +dcp_dsi_bridge_atomic_create_state(struct drm_bridge *bridge)
>> +{
>> +	struct dcp_dsi_bridge_state *state;
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +
>> +	state = kzalloc_obj(*state);
>> +	if (!state)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	__drm_atomic_helper_bridge_state_init(&state->base, bridge);
>> +	state->panel_state.topology_mixer_count =
>> +		dsi_bridge->hfi_panel_config.topology_mixer_count;
>> +	state->panel_state.topology_enc_count =
>> +		dsi_bridge->hfi_panel_config.topology_enc_count;
>> +	state->panel_state.topology_intf_count =
>> +		dsi_bridge->hfi_panel_config.topology_intf_count;
>> +	return &state->base;
>> +}
>> +
>> +static struct drm_bridge_state *
>> +dcp_dsi_bridge_atomic_duplicate_state(struct drm_bridge *bridge)
>> +{
>> +	struct dcp_dsi_bridge_state *state, *old_state;
>> +
>> +	if (WARN_ON(!bridge->base.state))
>> +		return NULL;
>> +
>> +	state = kzalloc_obj(*state);
>> +	if (!state)
>> +		return NULL;
>> +
>> +	old_state = to_dcp_dsi_bridge_state(drm_priv_to_bridge_state(bridge->base.state));
>> +	__drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);
>> +	state->panel_state = old_state->panel_state;
>> +	return &state->base;
>> +}
>> +
>> +static void dcp_dsi_bridge_atomic_destroy_state(struct drm_bridge *bridge,
>> +						struct drm_bridge_state *bridge_state)
>> +{
>> +	kfree(to_dcp_dsi_bridge_state(bridge_state));
>> +}
>> +
>> +static void
>> +dcp_dsi_bridge_build_hfi_config(struct dcp_dsi_bridge *dsi_bridge,
>> +				const struct dcp_dsi_bridge_state *state,
>> +				struct dcp_dsi_hfi_panel_config *cfg)
>> +{
>> +	*cfg = dsi_bridge->hfi_panel_config;
>> +	cfg->topology_mixer_count = state->panel_state.topology_mixer_count;
>> +	cfg->topology_enc_count = state->panel_state.topology_enc_count;
>> +	cfg->topology_intf_count = state->panel_state.topology_intf_count;
>> +}
>> +
>> +static void dcp_dsi_host_dev_release(struct device *dev)
>> +{
>> +	of_node_put(dev->of_node);
>> +}
>> +
>> +static bool dcp_dsi_bridge_cmd_mode(const struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	return dsi_bridge->dsi_device &&
>> +		!(dsi_bridge->dsi_device->mode_flags & MIPI_DSI_MODE_VIDEO);
>> +}
>> +
>> +static u64 dcp_dsi_link_clock(const struct dcp_dsi_bridge *dsi_bridge,
>> +			      const struct dcp_dsi_hfi_panel_config *cfg,
>> +			      const struct drm_display_mode *mode)
>> +{
>> +	const struct mipi_dsi_device *dsi = dsi_bridge->dsi_device;
>> +	int bpp;
>> +	u32 bpp_x16;
>> +
>> +	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>> +	if (bpp < 0)
>> +		return 0;
>> +
>> +	bpp_x16 = cfg->dsc_enabled && cfg->dsc_bits_per_pixel ?
>> +		cfg->dsc_bits_per_pixel : bpp << 4;
>> +
>> +	if (dsi->hs_rate)
>> +		return dsi->hs_rate;
>> +
>> +	return div_u64((u64)mode->clock * 1000 * bpp_x16, dsi->lanes * 16);
>> +}
>> +
>> +static void dcp_dsi_power_control_work(struct work_struct *work)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge =
>> +		container_of(work, struct dcp_dsi_bridge, power_control_work);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +
>> +	dcp_hfi_display_power_control_ack(kms->hfi,
>> +					  dsi_bridge->session_id,
>> +					  dsi_bridge->power_packet_id);
>> +
>> +	complete(&dsi_bridge->power_done);
>> +}
>> +
>> +static void dcp_dsi_power_control_cb(void *priv, u32 display_id,
>> +				     u32 power_mask, bool enable,
>> +				     u32 packet_id)
>> +{
>> +	struct dcp_dpu_kms *kms = priv;
>> +	struct dcp_dsi_bridge *dsi_bridge = NULL;
>> +	int idx;
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(kms->dsi_bridge); idx++) {
>> +		struct dcp_dsi_bridge *b = kms->dsi_bridge[idx];
>> +
>> +		if (b && b->session_id == display_id) {
>> +			dsi_bridge = b;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!dsi_bridge) {
>> +		dev_warn(kms->pm_dev,
>> +			 "DSI: power_control for unknown display_id=%u\n", display_id);
>> +		return;
>> +	}
>> +
>> +	dsi_bridge->power_packet_id = packet_id;
>> +	schedule_work(&dsi_bridge->power_control_work);
>> +}
>> +
>> +static const struct component_ops dcp_dsi_component_ops;
>> +
>> +static int dcp_dsi_host_attach(struct mipi_dsi_host *host,
>> +			       struct mipi_dsi_device *dsi)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
>> +	struct dcp_dsi_hfi_panel_config *cfg = &dsi_bridge->hfi_panel_config;
>> +	int ret;
>> +
>> +	if (!dsi->lanes || dsi->lanes > 4)
>> +		return -EINVAL;
>> +
>> +	cfg->dsc_enabled = false;
>> +	cfg->dsc_version_major = 0;
>> +	cfg->dsc_version_minor = 0;
>> +	cfg->dsc_scr_version = 0;
>> +	cfg->dsc_slice_height = 0;
>> +	cfg->dsc_slice_width = 0;
>> +	cfg->dsc_slices_per_pkt = 0;
>> +	cfg->dsc_bits_per_component = 0;
>> +	cfg->dsc_pps_delay_ms = 0;
>> +	cfg->dsc_bits_per_pixel = 0;
>> +	cfg->dsc_chroma_format = 0;
>> +	cfg->dsc_color_space = 0;
>> +	cfg->dsc_block_prediction_enable = 0;
>> +	cfg->dsc_rc_override = false;
>> +	memset(cfg->dsc_rc_min_qp, 0, sizeof(cfg->dsc_rc_min_qp));
>> +	memset(cfg->dsc_rc_max_qp, 0, sizeof(cfg->dsc_rc_max_qp));
>> +	memset(cfg->dsc_rc_bpg_offsets, 0, sizeof(cfg->dsc_rc_bpg_offsets));
>> +
>> +	switch (dsi->format) {
>> +	case MIPI_DSI_FMT_RGB888:
>> +	case MIPI_DSI_FMT_RGB666:
>> +	case MIPI_DSI_FMT_RGB666_PACKED:
>> +	case MIPI_DSI_FMT_RGB565:
>> +	case MIPI_DSI_FMT_RGB101010:
>> +		break;
>> +	default:
>> +		dev_err(&dsi->dev, "unsupported pixel format %u\n", dsi->format);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dsi_bridge->dsi_device = dsi;
>> +
>> +	if (dsi->dsc) {
>> +		struct drm_dsc_config *dsc = dsi->dsc;
>> +		u32 chroma_format = 0;
>> +		u32 color_space = 0;
>> +
>> +		if (dsc->native_422)
>> +			chroma_format = 1;
>> +		else if (dsc->native_420)
>> +			chroma_format = 2;
>> +		if (dsc->native_422 || dsc->native_420)
>> +			color_space = 1;
>> +
>> +		cfg->dsc_enabled                 = true;
>> +		cfg->dsc_version_major           = dsc->dsc_version_major;
>> +		cfg->dsc_version_minor           = dsc->dsc_version_minor;
>> +		cfg->dsc_scr_version              = 0;
>> +		cfg->dsc_slice_height             = dsc->slice_height;
>> +		cfg->dsc_slice_width              = dsc->slice_width;
>> +		cfg->dsc_slices_per_pkt           = 1;
>> +		cfg->dsc_bits_per_component       = dsc->bits_per_component;
>> +		cfg->dsc_pps_delay_ms             = 0;
>> +		cfg->dsc_bits_per_pixel           = dsc->bits_per_pixel;
>> +		cfg->dsc_chroma_format            = chroma_format;
>> +		cfg->dsc_color_space              = color_space;
>> +		cfg->dsc_block_prediction_enable  = dsc->block_pred_enable;
>> +
>> +		dev_dbg(&dsi->dev,
>> +			"DSI%u: DSC enabled: version=%u.%u slice=%ux%u bpc=%u bpp=%u.%u\n",
>> +			dsi_bridge->intf_idx, dsc->dsc_version_major,
>> +			dsc->dsc_version_minor, dsc->slice_width,
>> +			dsc->slice_height, dsc->bits_per_component,
>> +			dsc->bits_per_pixel >> 4, (dsc->bits_per_pixel & 0xf) * 100 / 16);
> I'd rather see this happen at the atomic_check state. We are trying to
> shift towards that model.
>

Sure, will update in v3


>> +	}
>> +
>> +	ret = component_add(&dsi_bridge->dsi_host_dev,
>> +			    &dcp_dsi_component_ops);
>> +	if (ret)
>> +		return ret;
>> +	dsi_bridge->component_added = true;
> What for? Can the bridge really be attached twice?
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int dcp_dsi_host_detach(struct mipi_dsi_host *host,
>> +			       struct mipi_dsi_device *dsi)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
>> +
>> +	if (dsi_bridge->component_added) {
>> +		component_del(&dsi_bridge->dsi_host_dev,
>> +			      &dcp_dsi_component_ops);
>> +		dsi_bridge->component_added = false;
> Can it be detached twice? How? Why?
>
>> +	}
>> +	dsi_bridge->panel_bridge = NULL;
>> +	dsi_bridge->dsi_device = NULL;
>> +	dsi_bridge->hfi_panel_config.dsc_enabled = false;
> Why do you need to NULL all of that?
>
>> +	return 0;
>> +}
>> +
>> +static ssize_t dcp_dsi_host_transfer(struct mipi_dsi_host *host,
>> +				     const struct mipi_dsi_msg *msg)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_host(host);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	u32 session_id;
>> +	bool temporary_session = false;
>> +	ssize_t ret;
>> +
>> +	guard(mutex)(&dsi_bridge->session_lock);
>> +	if (!dsi_bridge->dcs_tx_buf)
>> +		return -ENODEV;
>> +
>> +	/* Serialize DCS transfers */
>> +	guard(mutex)(&dsi_bridge->dcs_lock);
>> +
>> +	if (dsi_bridge->session_open) {
>> +		session_id = dsi_bridge->session_id;
>> +	} else {
>> +		/*
>> +		 * mipi_dsi_host_ops::transfer() may be called while the host is
>> +		 * disabled. Open a transaction-only DCP session in that case;
>> +		 * atomic_pre_enable() will create the full display session later.
>> +		 */
>> +		ret = dcp_hfi_display_enable(kms->hfi, dsi_bridge->intf_idx,
>> +					     dsi_bridge->fw_display_id,
>> +					     &session_id);
>> +		if (ret)
>> +			return ret;
>> +
>> +		temporary_session = true;
>> +	}
> Nice
>
>> +
>> +	ret = dcp_hfi_dcs_transfer(kms->hfi, session_id, msg,
>> +				   dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova,
>> +				   dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova, 0,
>> +				   dsi_bridge->hfi_panel_config.ctrl_indices[0]);
>> +	if (temporary_session) {
>> +		int close_ret = dcp_hfi_display_close(kms->hfi, session_id);
>> +
>> +		if (ret >= 0 && close_ret)
>> +			ret = close_ret;
>> +	}
>> +	if (ret < 0)
>> +		dev_warn(kms->pm_dev,
>> +			 "DSI%u: live DCS command transfer failed: %zd\n",
>> +			 dsi_bridge->intf_idx, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dcp_dsi_component_bind(struct device *dev,
>> +				  struct device *master, void *data)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge =
>> +		container_of(dev, struct dcp_dsi_bridge, dsi_host_dev);
>> +
>> +	dsi_bridge->panel_bridge =
>> +		devm_drm_of_get_bridge(dev, dsi_bridge->dcp_np,
>> +				       dsi_bridge->dcp_port, 0);
>> +	if (IS_ERR(dsi_bridge->panel_bridge)) {
>> +		int ret = PTR_ERR(dsi_bridge->panel_bridge);
>> +
>> +		dsi_bridge->panel_bridge = NULL;
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void dcp_dsi_component_unbind(struct device *dev,
>> +				     struct device *master, void *data)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge =
>> +		container_of(dev, struct dcp_dsi_bridge, dsi_host_dev);
>> +
>> +	dsi_bridge->panel_bridge = NULL;
>> +}
>> +
>> +static const struct component_ops dcp_dsi_component_ops = {
>> +	.bind = dcp_dsi_component_bind,
>> +	.unbind = dcp_dsi_component_unbind,
>> +};
>> +
>> +static const struct mipi_dsi_host_ops dcp_dsi_host_ops = {
>> +	.attach   = dcp_dsi_host_attach,
>> +	.detach   = dcp_dsi_host_detach,
>> +	.transfer = dcp_dsi_host_transfer,
>> +};
>> +
>> +static int dcp_dsi_bridge_attach(struct drm_bridge *bridge,
>> +				 struct drm_encoder *encoder,
>> +				 enum drm_bridge_attach_flags flags)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	struct drm_bridge *panel_bridge;
>> +	int ret;
>> +
>> +	panel_bridge = dsi_bridge->panel_bridge;
>> +	if (!panel_bridge)
>> +		return -EPROBE_DEFER;
>> +
>> +	ret = drm_bridge_attach(encoder, panel_bridge, bridge, flags);
>> +	if (ret) {
>> +		drm_err(bridge->dev,
>> +			"DSI%u: panel bridge attach failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +		return ret;
>> +	}
>> +
>> +	drm_dbg_driver(dsi_bridge->kms->dev,
>> +		       "DSI%u: panel bridge attached\n",
>> +		       dsi_bridge->intf_idx);
>> +
>> +	dcp_hfi_set_power_control_cb(dsi_bridge->kms->hfi,
>> +				     dsi_bridge->kms, dcp_dsi_power_control_cb);
>> +
>> +	return 0;
>> +}
>> +
>> +static u32 dcp_dsi_bridge_get_mixer_count(struct dcp_dsi_bridge *dsi_bridge,
>> +					  const struct dcp_dsi_hfi_panel_config *cfg,
>> +					  const struct drm_display_mode *mode)
>> +{
>> +	u32 mixer_count = cfg->topology_mixer_count;
>> +
>> +	if (!mixer_count)
>> +		mixer_count = 1;
>> +
>> +	if (dsi_bridge->dsi_device && dsi_bridge->dsi_device->dsc) {
>> +		const struct drm_dsc_config *dsc = dsi_bridge->dsi_device->dsc;
>> +
>> +		if (dsc->slice_count)
>> +			mixer_count = dsc->slice_count;
>> +		else if (dsc->slice_width && mode->hdisplay)
>> +			mixer_count = DIV_ROUND_UP(mode->hdisplay,
>> +						   dsc->slice_width);
>> +	}
>> +
>> +	return mixer_count;
>> +}
>> +
>> +static void dcp_dsi_bridge_publish_session(struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	struct drm_crtc *crtc;
>> +
>> +	crtc = dcp_dpu_kms_get_crtc(kms, dsi_bridge->fw_display_id);
>> +	if (crtc)
>> +		dcp_crtc_set_session(crtc, dsi_bridge->session_id);
>> +	else
>> +		drm_err(kms->dev, "DSI%u: no CRTC for session %u\n",
>> +			dsi_bridge->intf_idx, dsi_bridge->session_id);
>> +}
>> +
>> +static void dcp_dsi_bridge_clear_session(struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	dcp_crtc_clear_session(dcp_dpu_kms_get_crtc(dsi_bridge->kms,
>> +						    dsi_bridge->fw_display_id));
>> +}
>> +
>> +static int dcp_dsi_bridge_setup_dsc(struct dcp_dsi_bridge *dsi_bridge,
>> +				    struct dcp_dsi_hfi_panel_config *cfg,
>> +				    const struct drm_display_mode *mode)
>> +{
>> +	struct drm_dsc_config *dsc = dsi_bridge->dsi_device->dsc;
>> +	enum drm_dsc_params_type params_type;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	dsc->pic_width = mode->hdisplay;
>> +	dsc->pic_height = mode->vdisplay;
>> +	dsc->convert_rgb = !dsc->native_422 && !dsc->native_420;
>> +	dsc->slice_chunk_size = DIV_ROUND_UP(dsc->slice_width *
>> +					dsc->bits_per_pixel, 8 * 16);
>> +	dsc->simple_422 = 0;
>> +	dsc->vbr_enable = 0;
>> +
>> +	if (dsc->dsc_version_major != 1)
>> +		return -EOPNOTSUPP;
>> +
>> +	switch (dsc->dsc_version_minor) {
>> +	case 1:
>> +		if (dsc->native_422 || dsc->native_420)
>> +			return -EOPNOTSUPP;
>> +		params_type = DRM_DSC_1_1_PRE_SCR;
>> +		break;
>> +	case 2:
>> +		if (dsc->native_422)
>> +			params_type = DRM_DSC_1_2_422;
>> +		else if (dsc->native_420)
>> +			params_type = DRM_DSC_1_2_420;
>> +		else
>> +			params_type = DRM_DSC_1_2_444;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	drm_dsc_set_const_params(dsc);
>> +	drm_dsc_set_rc_buf_thresh(dsc);
>> +	ret = drm_dsc_setup_rc_params(dsc, params_type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dsc->initial_scale_value = drm_dsc_initial_scale_value(dsc);
>> +	dsc->line_buf_depth = dsc->bits_per_component + 1;
>> +	ret = drm_dsc_compute_rc_parameters(dsc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cfg->dsc_rc_min_qp); i++) {
>> +		cfg->dsc_rc_min_qp[i] = dsc->rc_range_params[i].range_min_qp;
>> +		cfg->dsc_rc_max_qp[i] = dsc->rc_range_params[i].range_max_qp;
>> +		cfg->dsc_rc_bpg_offsets[i] = dsc->rc_range_params[i].range_bpg_offset;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
>> +				   const struct drm_display_mode *mode)
>> +{
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	struct dcp_dsi_bridge_state *state = dcp_dsi_bridge_get_state(dsi_bridge);
>> +	struct dcp_dsi_hfi_panel_config cfg;
>> +	int ret;
>> +	u32 opened_session_id;
>> +
>> +	if (!mode)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&dsi_bridge->session_lock);
>> +	if (dsi_bridge->session_open)
>> +		return 0;
>> +
>> +	dsi_bridge->session_id = dsi_bridge->fw_display_id;
>> +
>> +	if (!dsi_bridge->dsi_device)
>> +		return -ENODEV;
>> +
>> +	dcp_dsi_bridge_build_hfi_config(dsi_bridge, state, &cfg);
>> +
>> +	if (dsi_bridge->dsi_device->dsc) {
>
> When is this going to be called?  There are panels which require
> different DSC setup for different modes.
>

Sure, will address this in v3.


>> +		ret = dcp_dsi_bridge_setup_dsc(dsi_bridge, &cfg, mode);
>> +		if (ret) {
>> +			drm_err(kms->dev, "DSI%u: DSC setup failed: %d\n",
>> +				dsi_bridge->intf_idx, ret);
>> +			goto err_close;
>> +		}
>> +	}
>> +
>> +	ret = dcp_hfi_panel_init(kms->hfi, dsi_bridge->intf_idx,
>> +				 mode,
>> +				 dsi_bridge->dsi_device,
>> +				 &cfg);
>> +	if (ret) {
>> +		drm_err(kms->dev, "DSI%u: HFI PANEL_INIT failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +		goto err_close;
>> +	}
>> +
>> +	if (mode->clock) {
>> +		u64 link_clock;
>> +
>> +		link_clock = dcp_dsi_link_clock(dsi_bridge, &cfg,
>> +						mode);
>> +		ret = dcp_hfi_display_mode_validate(kms->hfi,
>> +						    dsi_bridge->session_id,
>> +						    mode, link_clock);
> mode validation should have happened at the atomic_check().
>
>> +		if (ret) {
>> +			drm_err(kms->dev, "DSI%u: HFI MODE_VALIDATE failed: %d\n",
>> +				dsi_bridge->intf_idx, ret);
>> +			goto err_close;
>> +		}
>> +
>> +		ret = dcp_hfi_display_set_mode(kms->hfi,
>> +					       dsi_bridge->session_id,
>> +					       mode,
>> +					       dcp_dsi_link_clock(dsi_bridge, &cfg,
>> +								  mode));
>> +		if (ret) {
>> +			drm_err(kms->dev, "DSI%u: HFI SET_MODE failed: %d\n",
>> +				dsi_bridge->intf_idx, ret);
>> +			goto err_close;
>> +		}
>> +	} else {
>> +		drm_warn(kms->dev, "DSI%u: no valid mode, skipping SET_MODE\n",
>> +			 dsi_bridge->intf_idx);
>> +	}
>> +
>> +	dcp_hfi_set_power_control_cb(kms->hfi, kms,
>> +				     dcp_dsi_power_control_cb);
> And what happens when you add DP?
>

Will remove power register and power control, those are no-op now.


>> +
>> +	reinit_completion(&dsi_bridge->power_done);
>> +
>> +	ret = dcp_hfi_display_power_register(kms->hfi, dsi_bridge->session_id);
>> +	if (ret) {
>> +		drm_err(kms->dev, "DSI%u: HFI POWER_REGISTER failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +		goto err_close;
>> +	}
>> +
>> +	ret = dcp_hfi_display_enable(kms->hfi,
>> +				     dsi_bridge->intf_idx,
>> +				     dsi_bridge->fw_display_id,
>> +				     &opened_session_id);
>> +	if (ret) {
>> +		drm_err(kms->dev, "DSI%u: HFI DISPLAY_ENABLE failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +		goto err_close;
>> +	}
>> +	dsi_bridge->session_id   = opened_session_id;
>> +	dsi_bridge->session_open = true;
>> +	dcp_dsi_bridge_publish_session(dsi_bridge);
>> +
>> +	drm_dbg_driver(kms->dev, "DSI%u: session prepared (session_id=%u)\n",
>> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
>> +	return 0;
>> +
>> +err_close:
>> +	dcp_hfi_clear_power_control_cb(kms->hfi, kms);
>> +	dcp_hfi_display_close(kms->hfi, dsi_bridge->session_id);
>> +	dsi_bridge->session_id   = 0;
>> +	dsi_bridge->session_open = false;
>> +	dcp_dsi_bridge_clear_session(dsi_bridge);
>> +
>> +	return ret;
>> +}
>> +
>> +static void dcp_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>> +					     struct drm_atomic_commit *state)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	int ret;
>> +
>> +	ret = dsi_bridge->session_open ? 0 : -ENODEV;
>> +	dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error = ret;
>> +	if (ret)
>> +		drm_err(bridge->dev, "DSI%u: session prepare failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +}
>> +
>> +static void dcp_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>> +					 struct drm_atomic_commit *state)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	bool scan_start_registered = false;
>> +	bool scan_complete_registered = false;
>> +	bool autorefresh_enabled = false;
>> +	int ret;
>> +
>> +	drm_dbg_driver(kms->dev,
>> +		       "DSI%u: bridge atomic_enable (session_id=%u)\n",
>> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
>> +
>> +	if (dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error)
>> +		return;
>> +	if (!dsi_bridge->session_open)
>> +		return;
>> +
>> +	ret = dcp_hfi_display_post_enable(kms->hfi, dsi_bridge->session_id);
>> +	if (ret) {
>> +		drm_err(bridge->dev,
>> +			"DSI%u: HFI DISPLAY_POST_ENABLE failed: %d\n",
>> +			dsi_bridge->intf_idx, ret);
>> +		goto err_close;
>> +	}
>> +
>> +	dcp_dsi_bridge_publish_session(dsi_bridge);
>> +
>> +	ret = dcp_hfi_display_event_register(kms->hfi,
>> +					     dsi_bridge->session_id, HFI_EVENT_FRAME_SCAN_START);
>> +	if (ret)
>> +		goto err_close;
>> +	scan_start_registered = true;
>> +
>> +	ret = dcp_hfi_display_event_register(kms->hfi,
>> +					     dsi_bridge->session_id, HFI_EVENT_FRAME_SCAN_COMPLETE);
>> +	if (ret)
>> +		goto err_close;
>> +	scan_complete_registered = true;
>> +
>> +	if (dcp_dsi_bridge_cmd_mode(dsi_bridge)) {
>> +		ret = dcp_hfi_crtc_set_autorefresh(kms->hfi,
>> +						   dsi_bridge->session_id, true, 1);
>> +		if (ret) {
>> +			drm_err(bridge->dev,
>> +				"DSI%u: initial autorefresh setup failed: %d\n",
>> +				dsi_bridge->intf_idx, ret);
>> +			goto err_close;
>> +		}
>> +		autorefresh_enabled = true;
>> +	}
>> +
>> +	drm_dbg_driver(bridge->dev,
>> +		       "DSI%u: enable complete (session_id=%u)\n",
>> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
>> +	return;
>> +
>> +err_close:
>> +	if (autorefresh_enabled)
>> +		dcp_hfi_crtc_set_autorefresh(kms->hfi, dsi_bridge->session_id,
>> +					     false, 0);
>> +	if (scan_complete_registered)
> Turn each of the booleans into a separate label.
>

Sure.


>> +		dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
>> +						 HFI_EVENT_FRAME_SCAN_COMPLETE);
>> +	if (scan_start_registered)
>> +		dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
>> +						 HFI_EVENT_FRAME_SCAN_START);
>> +	drm_err(bridge->dev,
>> +		"DSI%u: bridge enable failed; session closed\n",
>> +		dsi_bridge->intf_idx);
>> +	dcp_hfi_display_close(kms->hfi, dsi_bridge->session_id);
>> +	{
>> +		guard(mutex)(&dsi_bridge->session_lock);
> scoped_guard()
>

Sure.


>> +		dsi_bridge->session_id   = 0;
>> +		dsi_bridge->session_open = false;
>> +	}
>> +	dcp_dsi_bridge_clear_session(dsi_bridge);
>> +}
>> +
>> +static void dcp_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
>> +					  struct drm_atomic_commit *state)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	int ret;
>> +
>> +	drm_dbg_driver(kms->dev,
>> +		       "DSI%u: atomic_disable (session_open=%d session_id=%u)\n",
>> +		       dsi_bridge->intf_idx, dsi_bridge->session_open,
>> +		       dsi_bridge->session_id);
>> +
>> +	guard(mutex)(&dsi_bridge->session_lock);
>> +	if (!dsi_bridge->session_open)
>> +		return;
>> +
>> +	if (dcp_dsi_bridge_cmd_mode(dsi_bridge)) {
>> +		ret = dcp_hfi_crtc_set_autorefresh(kms->hfi,
>> +						   dsi_bridge->session_id, false, 0);
>> +		if (ret)
>> +			drm_warn(bridge->dev,
>> +				 "DSI%u: autorefresh disable failed: %d\n",
>> +				 dsi_bridge->intf_idx, ret);
>> +	}
>> +
>> +	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
>> +					 HFI_EVENT_FRAME_SCAN_COMPLETE);
>> +	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
>> +					 HFI_EVENT_FRAME_SCAN_START);
>> +
>> +	ret = dcp_hfi_display_disable(kms->hfi, dsi_bridge->session_id);
>> +	if (ret)
>> +		drm_warn(bridge->dev,
>> +			 "DSI%u: HFI DISPLAY_DISABLE failed: %d\n",
>> +			 dsi_bridge->intf_idx, ret);
>> +}
>> +
>> +static void dcp_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>> +					       struct drm_atomic_commit *state)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	int ret;
>> +
>> +	drm_dbg_driver(kms->dev,
>> +		       "DSI%u: atomic_post_disable\n",
>> +		       dsi_bridge->intf_idx);
>> +
>> +	guard(mutex)(&dsi_bridge->session_lock);
>> +	if (!dsi_bridge->session_open)
>> +		return;
>> +
>> +	ret = dcp_hfi_display_post_disable(kms->hfi, dsi_bridge->session_id);
>> +	if (ret)
>> +		drm_warn(bridge->dev,
>> +			 "DSI%u: HFI DISPLAY_POST_DISABLE failed: %d\n",
>> +			 dsi_bridge->intf_idx, ret);
>> +
>> +	ret = dcp_hfi_send_sync(kms->hfi,
>> +				HFI_COMMAND_DISPLAY_CLOSE,
>> +				HFI_CMD_BUFF_DISPLAY, dsi_bridge->session_id,
>> +				HFI_PAYLOAD_NONE, NULL, 0,
>> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
>> +				HFI_TX_FLAGS_NON_DISCARDABLE,
>> +				NULL, 0,
>> +				2000 /* ms */);
>> +	if (ret)
>> +		drm_warn(bridge->dev,
>> +			 "DSI%u: HFI DISPLAY_CLOSE failed: %d\n",
>> +			 dsi_bridge->intf_idx, ret);
>> +
>> +	dsi_bridge->session_id   = 0;
>> +	dsi_bridge->session_open = false;
>> +
>> +	dcp_dsi_bridge_clear_session(dsi_bridge);
>> +}
>> +
>> +static int dcp_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>> +				       struct drm_bridge_state *bridge_state,
>> +				       struct drm_crtc_state *crtc_state,
>> +				       struct drm_connector_state *conn_state)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge = to_dcp_dsi_bridge(bridge);
>> +	struct dcp_dsi_bridge_state *state =
>> +		to_dcp_dsi_bridge_state(bridge_state);
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>> +	u32 max_width, max_height;
>> +	u32 mixer_count, bpc;
>> +
>> +	state->prepare_error = 0;
>> +
>> +	if (!mode->clock || !drm_mode_vrefresh(mode))
>> +		return -EINVAL;
>> +
>> +	if (dsi_bridge->dsi_device &&
>> +	    (!dsi_bridge->dsi_device->lanes ||
>> +	     !dcp_dsi_link_clock(dsi_bridge, &dsi_bridge->hfi_panel_config, mode)))
>> +		return -EINVAL;
>> +
>> +	if (dsi_bridge->dsi_device && dsi_bridge->dsi_device->dsc) {
>> +		state->panel_state.topology_mixer_count =
>> +			dcp_dsi_bridge_get_mixer_count(dsi_bridge,
>> +						       &dsi_bridge->hfi_panel_config, mode);
>> +		state->panel_state.topology_enc_count =
>> +			state->panel_state.topology_mixer_count;
>> +		state->panel_state.topology_intf_count = 1;
>> +	}
>> +
>> +	mixer_count = dcp_dsi_bridge_get_mixer_count(dsi_bridge,
>> +						     &dsi_bridge->hfi_panel_config, mode);
>> +	bpc = dsi_bridge->hfi_panel_config.dsc_bits_per_component ?
>> +		dsi_bridge->hfi_panel_config.dsc_bits_per_component : 8;
>> +	dcp_crtc_set_topology_state(crtc_state, mixer_count, bpc);
>> +
>> +	dcp_mode_limits(mode, kms->caps->max_width, kms->caps->max_height,
>> +			&max_width, &max_height);
>> +
>> +	if (mode->hdisplay > max_width || mode->vdisplay > max_height) {
>> +		drm_err(dsi_bridge->kms->dev,
>> +			"DSI%u: mode %dx%d exceeds DCP caps %dx%d\n",
>> +				 dsi_bridge->intf_idx, mode->hdisplay, mode->vdisplay,
>> +				 kms->caps->max_width, kms->caps->max_height);
> Don't let userspace spam the dmesg.
>

Comments to be addressed in v3.


>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static const struct drm_bridge_funcs dcp_dsi_bridge_funcs = {
>> +	.attach                  = dcp_dsi_bridge_attach,
>> +	.atomic_pre_enable       = dcp_dsi_bridge_atomic_pre_enable,
>> +	.atomic_enable           = dcp_dsi_bridge_atomic_enable,
>> +	.atomic_disable          = dcp_dsi_bridge_atomic_disable,
>> +	.atomic_post_disable     = dcp_dsi_bridge_atomic_post_disable,
>> +	.atomic_check            = dcp_dsi_bridge_atomic_check,
>> +	.atomic_create_state     = dcp_dsi_bridge_atomic_create_state,
>> +	.atomic_duplicate_state  = dcp_dsi_bridge_atomic_duplicate_state,
>> +	.atomic_destroy_state    = dcp_dsi_bridge_atomic_destroy_state,
>> +};
>> +
>> +#define DCP_DSI_DUAL_MAP_ALIGN	SZ_1K
>> +
>> +static int dcp_dsi_dual_map_buf(struct dcp_dpu_kms *kms,
>> +				struct device *dma_dev, void *cpu_addr,
>> +				dma_addr_t iova, size_t size, int prot)
>> +{
>> +	struct sg_table sgt = { 0 };
>> +	struct iommu_domain *domain;
>> +	ssize_t mapped;
>> +	int ret;
>> +
>> +	if (!kms->iommu_dev || !cpu_addr || !iova ||
>> +	    !IS_ALIGNED(iova, DCP_DSI_DUAL_MAP_ALIGN))
>> +		return -EINVAL;
>> +
>> +	domain = iommu_get_domain_for_dev(kms->iommu_dev);
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	ret = dma_get_sgtable(dma_dev, &sgt, cpu_addr, iova, size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mapped = iommu_map_sgtable(domain, iova, &sgt, prot);
>> +	if (mapped != PAGE_ALIGN(size)) {
>> +		if (mapped > 0)
>> +			iommu_unmap(domain, iova, mapped);
>> +		ret = mapped < 0 ? mapped : -EIO;
>> +		drm_err(kms->dev,
>> +			"failed to dual-map iova=%pad into iommu_dev domain: %zd\n",
>> +			&iova, mapped);
>> +		sg_free_table(&sgt);
>> +		return ret;
>> +	}
>> +
>> +	sg_free_table(&sgt);
>> +	return 0;
>> +}
>> +
>> +static void dcp_dsi_dual_unmap_buf(struct dcp_dpu_kms *kms, dma_addr_t iova,
>> +				   size_t size)
>> +{
>> +	struct iommu_domain *domain;
>> +
>> +	if (!kms->iommu_dev || !iova)
>> +		return;
>> +
>> +	domain = iommu_get_domain_for_dev(kms->iommu_dev);
>> +	if (!domain)
>> +		return;
>> +
>> +	iommu_unmap(domain, iova, PAGE_ALIGN(size));
>> +}
>> +
>> +static void dcp_dsi_init_hfi_panel_defaults(struct dcp_dsi_hfi_panel_config *cfg,
>> +					    u32 intf_idx)
>> +{
>> +	memset(cfg, 0, sizeof(*cfg));
>> +
>> +	cfg->display_type = HFI_PANEL_DISPLAY_TYPE_BUILT_IN_0;
>> +	cfg->num_ctrls = 1;
>> +	cfg->ctrl_indices[0] = intf_idx;
>> +	cfg->num_phys = 1;
>> +	cfg->phy_indices[0] = intf_idx;
>> +
>> +	cfg->dma_trigger = HFI_PANEL_TRIGGER_SW;
>> +	cfg->stream_trigger = HFI_PANEL_TRIGGER_NONE;
>> +	cfg->te_dcs_command = 1;
>> +	cfg->wr_mem_start = 0x2C;
>> +	cfg->wr_mem_continue = 0x3C;
>> +
>> +	cfg->phy_type = HFI_PANEL_PHY_OLED;
>> +	cfg->bllp_eof_power_mode = true;
>> +	cfg->bllp_power_mode = true;
>> +	cfg->lane_map = 1;
>> +	cfg->color_order = 1;
>> +
>> +	cfg->jitter_numer = 4;
>> +	cfg->jitter_denom = 1;
>> +	cfg->dcs_tx_buf_size = DCP_DSI_DCS_TX_BUF_SIZE;
>> +
>> +	cfg->topology_mixer_count = 1;
>> +	cfg->topology_intf_count = 1;
>> +}
>> +
>> +struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
>> +				       struct device_node *np,
>> +				       struct device_node *dcp_np,
>> +				       u32 dcp_port, u32 intf_idx,
>> +				       u32 fw_display_id)
>> +{
>> +	struct dcp_dsi_bridge *dsi_bridge;
>> +	struct dcp_dsi_hfi_panel_config *cfg;
>> +	struct device *dev = kms->pm_dev;
>> +	struct device *dma_dev = kms->hfi->dma_dev;
>> +	int ret;
>> +
>> +	dsi_bridge = devm_drm_bridge_alloc(dev, struct dcp_dsi_bridge,
>> +					   bridge, &dcp_dsi_bridge_funcs);
>> +	if (IS_ERR(dsi_bridge))
>> +		return ERR_CAST(dsi_bridge);
>> +
>> +	dsi_bridge->dcp_np        = of_node_get(dcp_np);
>> +	dsi_bridge->dcp_port      = dcp_port;
>> +	dsi_bridge->kms           = kms;
>> +	dsi_bridge->intf_idx      = intf_idx;
>> +	dsi_bridge->fw_display_id = fw_display_id;
>> +
>> +	INIT_WORK(&dsi_bridge->power_control_work, dcp_dsi_power_control_work);
>> +	init_completion(&dsi_bridge->power_done);
>> +	mutex_init(&dsi_bridge->session_lock);
>> +	mutex_init(&dsi_bridge->dcs_lock);
>> +
>> +	cfg = &dsi_bridge->hfi_panel_config;
>> +	dcp_dsi_init_hfi_panel_defaults(cfg, intf_idx);
>> +
>> +	/*
>> +	 * Allocate the buffers for the firmware DMA domain here. The second
>> +	 * mapping into the display domain is deferred until msm_kms_init_vm()
>> +	 * has installed the final display IOMMU domain.
>> +	 */
>> +	dsi_bridge->dcs_tx_buf = dma_alloc_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
>> +						    &dsi_bridge->dcs_tx_iova, GFP_KERNEL);
>> +	if (!dsi_bridge->dcs_tx_buf) {
>> +		ret = -ENOMEM;
>> +		goto err_unwind_dma;
>> +	}
>> +
>> +	dsi_bridge->hfi_panel_config.dcs_tx_dva = dsi_bridge->dcs_tx_iova;
>> +	dsi_bridge->hfi_panel_config.dcs_tx_iova = dsi_bridge->dcs_tx_iova;
>> +
>> +	dsi_bridge->dcs_rx_buf = dma_alloc_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
>> +						    &dsi_bridge->dcs_rx_iova, GFP_KERNEL);
>> +	if (!dsi_bridge->dcs_rx_buf) {
>> +		ret = -ENOMEM;
>> +		goto err_unwind_dma;
>> +	}
>> +
>> +	device_initialize(&dsi_bridge->dsi_host_dev);
>> +	dsi_bridge->dsi_host_dev.release = dcp_dsi_host_dev_release;
>> +	dsi_bridge->dsi_host_dev.parent  = dev;
>> +	dsi_bridge->dsi_host_dev.of_node = of_node_get(np);
>> +	dev_set_name(&dsi_bridge->dsi_host_dev, "%pOFn", np);
>> +	dsi_bridge->dsi_host.ops = &dcp_dsi_host_ops;
>> +	dsi_bridge->dsi_host.dev = &dsi_bridge->dsi_host_dev;
>> +
>> +	ret = device_add(&dsi_bridge->dsi_host_dev);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"DSI%u: failed to add dsi_host_dev: %d\n", intf_idx, ret);
>> +		put_device(&dsi_bridge->dsi_host_dev);
>> +		goto err_unwind_dma;
>> +	}
>> +
>> +	ret = mipi_dsi_host_register(&dsi_bridge->dsi_host);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"DSI%u: failed to register MIPI DSI host: %d\n",
>> +			intf_idx, ret);
>> +		device_del(&dsi_bridge->dsi_host_dev);
>> +		put_device(&dsi_bridge->dsi_host_dev);
>> +		goto err_unwind_dma;
>> +	}
>> +
>> +	dsi_bridge->bridge.of_node = of_node_get(np);
>> +	dsi_bridge->bridge.type    = DRM_MODE_CONNECTOR_DSI;
>> +
>> +	drm_bridge_add(&dsi_bridge->bridge);
>> +
>> +	return &dsi_bridge->bridge;
>> +
>> +err_unwind_dma:
>> +	if (dsi_bridge->dcs_rx_buf) {
>> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
>> +				  dsi_bridge->dcs_rx_buf,
>> +				  dsi_bridge->dcs_rx_iova);
>> +	}
>> +	if (dsi_bridge->dcs_tx_buf) {
>> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
>> +				  dsi_bridge->dcs_tx_buf,
>> +				  dsi_bridge->dcs_tx_iova);
>> +	}
>> +	cancel_work_sync(&dsi_bridge->power_control_work);
>> +	mutex_destroy(&dsi_bridge->session_lock);
>> +	mutex_destroy(&dsi_bridge->dcs_lock);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +int dcp_dsi_bridge_map_buffers(struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +	struct device *dma_dev = kms->hfi->dma_dev;
>> +	int ret;
>> +
>> +	if (dsi_bridge->dcs_mapped)
>> +		return 0;
>> +
>> +	ret = dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_tx_buf,
>> +				   dsi_bridge->dcs_tx_iova,
>> +				   DCP_DSI_DCS_TX_BUF_SIZE, IOMMU_READ);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_rx_buf,
>> +				   dsi_bridge->dcs_rx_iova,
>> +				   DCP_DSI_DCS_RX_BUF_SIZE, IOMMU_WRITE);
>> +	if (ret) {
>> +		dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_tx_iova,
>> +				       DCP_DSI_DCS_TX_BUF_SIZE);
>> +		return ret;
>> +	}
>> +
>> +	dsi_bridge->dcs_mapped = true;
>> +	drm_dbg_driver(kms->dev,
>> +		       "DSI%u: mapped DCS buffers tx=%pad rx=%pad in display domain\n",
>> +		       dsi_bridge->intf_idx, &dsi_bridge->dcs_tx_iova,
>> +		       &dsi_bridge->dcs_rx_iova);
>> +
>> +	return 0;
>> +}
>> +
>> +void dcp_dsi_bridge_unmap_buffers(struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	struct dcp_dpu_kms *kms = dsi_bridge->kms;
>> +
>> +	if (!dsi_bridge->dcs_mapped)
>> +		return;
>> +
>> +	dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_tx_iova,
>> +			       DCP_DSI_DCS_TX_BUF_SIZE);
>> +	dcp_dsi_dual_unmap_buf(kms, dsi_bridge->dcs_rx_iova,
>> +			       DCP_DSI_DCS_RX_BUF_SIZE);
>> +	dsi_bridge->dcs_mapped = false;
>> +}
>> +
>> +void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge)
>> +{
>> +	struct device *dma_dev = dsi_bridge->kms->hfi->dma_dev;
>> +
>> +	dcp_hfi_clear_power_control_cb(dsi_bridge->kms->hfi, dsi_bridge->kms);
>> +	cancel_work_sync(&dsi_bridge->power_control_work);
>> +
>> +	drm_bridge_remove(&dsi_bridge->bridge);
>> +	of_node_put(dsi_bridge->bridge.of_node);
>> +	of_node_put(dsi_bridge->dcp_np);
>> +
>> +	mipi_dsi_host_unregister(&dsi_bridge->dsi_host);
>> +	device_del(&dsi_bridge->dsi_host_dev);
>> +	put_device(&dsi_bridge->dsi_host_dev);
>> +
>> +	dcp_dsi_bridge_unmap_buffers(dsi_bridge);
>> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
>> +			  dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova);
>> +
>> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
>> +			  dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova);
>> +
>> +	mutex_destroy(&dsi_bridge->session_lock);
>> +	mutex_destroy(&dsi_bridge->dcs_lock);
>> +}
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h
>> new file mode 100644
>> index 000000000000..f2c7abf23ac9
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h
>> @@ -0,0 +1,76 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * DCP DSI bridge state and panel configuration.
>> + * DCP firmware owns the DSI PHY and controller; the bridge submits HFI commands.
>> + */
>> +
>> +#ifndef __DCP_DSI_BRIDGE_H__
>> +#define __DCP_DSI_BRIDGE_H__
>> +
>> +#include <linux/completion.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/ktime.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <drm/drm_bridge.h>
>> +#include <drm/drm_encoder.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +
>> +#include "dcp_dsi_panel.h"
>> +
>> +struct dcp_dpu_kms;
>> +struct device_node;
>> +
>> +struct dcp_dsi_bridge {
>> +	struct drm_bridge    bridge;
>> +	struct device        dsi_host_dev;
>> +	struct mipi_dsi_host  dsi_host;
>> +	struct mipi_dsi_device *dsi_device;
>> +	struct drm_bridge *panel_bridge;
>> +	bool component_added;
>> +
>> +	struct dcp_dpu_kms  *kms;
>> +	struct device_node  *dcp_np;
>> +	u32                  dcp_port;
>> +	u32                  intf_idx;
>> +	u32                  fw_display_id;
>> +	u32                  session_id;
>> +	bool                 session_open;
>> +	/* Protects session_id and session_open. */
>> +	struct mutex         session_lock;
>> +
>> +	struct dcp_dsi_hfi_panel_config hfi_panel_config;
>> +	/* Serializes DCS transfers. */
>> +	struct mutex dcs_lock;
>> +
>> +	void       *dcs_tx_buf;
>> +	dma_addr_t  dcs_tx_iova;
>> +	void       *dcs_rx_buf;
>> +	dma_addr_t  dcs_rx_iova;
>> +	bool         dcs_mapped;
>> +	struct work_struct power_control_work;
>> +	struct completion  power_done;
>> +	u32                power_packet_id;
>> +};
>> +
>> +#define to_dcp_dsi_host(h) \
>> +	container_of(h, struct dcp_dsi_bridge, dsi_host)
>> +
>> +#define to_dcp_dsi_bridge(b) \
>> +	container_of(b, struct dcp_dsi_bridge, bridge)
>> +
>> +struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
>> +				       struct device_node *np,
>> +				       struct device_node *dcp_np,
>> +				       u32 dcp_port, u32 intf_idx,
>> +				       u32 fw_display_id);
>> +int dcp_dsi_bridge_map_buffers(struct dcp_dsi_bridge *dsi_bridge);
>> +void dcp_dsi_bridge_unmap_buffers(struct dcp_dsi_bridge *dsi_bridge);
>> +int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
>> +				   const struct drm_display_mode *mode);
>> +void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge);
>> +
>> +#endif /* __DCP_DSI_BRIDGE_H__ */
>> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
>> index a8898e469b44..cc4e9f4c6fc4 100644
>> --- a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
>> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
>> @@ -74,6 +74,19 @@ struct dcp_dsi_hfi_panel_config {
>>   	u32 topology_intf_count;
>>   };
>>   
>> +/**
>> + * struct dcp_dsi_panel_state - Mode-dependent DSI panel state.
>> + *
>> + * This state is owned by a DRM atomic bridge state. It is combined with
>> + * the static panel configuration when constructing the HFI PANEL_INIT
>> + * payload.
>> + */
>> +struct dcp_dsi_panel_state {
>> +	u32 topology_mixer_count;
>> +	u32 topology_enc_count;
>> +	u32 topology_intf_count;
> Why is it public? Who uses it?
>
>> +};
>> +
>>   /* DCS buffers use IOVAs directly in the firmware command descriptor. */
>>   #define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
>>   #define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
>>
>> -- 
>> 2.43.0
>>

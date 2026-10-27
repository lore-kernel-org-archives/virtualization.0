Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099203;
	b=D4qhiibp6WQvdDS0pQOoh0MzTuR9iGJqI585SeSHPiSFIjG1/5EVhwOnHVC4xPYy7BnL
	 MzbkmqwZAZCLcmoW8m5e0xZ1UJ4W/MLPfgfNcGgwHSAGitSSV9+rhli0mnyiMqfl2Rs7V
	 Vn/Y2rSQfDcH2r9TbSLqPrMXuOwYWs72tb3thduw/VS2cazybGJAHwoUg2TqUmTBmr8QN
	 hceyYxbl+AvdvVKcC/O2UgfglanMUN3aTK4R/Y8aMA4wB638ZfvNV5uPoPTN6QQzf6UY3
	 yoETQDpw4UJoMQWRt33LUCBv3yoMgmmKiHGcYpVNBtMrr31JSV5r2PAsX/akZ9Jffug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099203;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YAs9yE3ryxQ6Hl63Kw+ENBo0qX1XTY4t+VA6gDiBjWc=;
	b=wbfHhmF8Zegejje4XSY2CeP1/z/f5hrVptIUFeM9zVuvKc3dTZ37UFQtwiRiVtFF1sdQ
	 tx8eV+aCcwwtRhRLdefMP0TNipxKIkEqfzrEx+kASFPBUDl4DFi7CAqlOXvpfWFP+HG4d
	 co7PV6+kgcKgDx8DUMQRaoge9VDT66dJHvwY5ojY4+UaCzCQtg+VyHANw/CTB/oLSK5tZ
	 FnAhbIkG4lbbN0qYsXwPfLKRhz9NLMiF8kdUp9BEbcGpOjc4XFUEpNnOCW9zsBaU6iu9U
	 gLCMeW0q4USHo6KGk6b9gFmluvzGpdEK+oaLJLDkrIpxPNBfj9GvFvxc7ZQw11scjqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNGxog26;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="esJ/dn+I";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5A606A320
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FNGxog26;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=esJ/dn+I
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe8Hl3026354
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YAs9yE3ryxQ6Hl63Kw+ENBo0
	qX1XTY4t+VA6gDiBjWc=; b=FNGxog26mwWdehEENsBbB7Oh3lx2xg6xTtvNckj7
	t5xNvF21EAv5y/mrOzf7MPaotkf7OeBeTKZ7KktncNEk8HEJagbOUpflq8Hj8urx
	JjzUSufgbUzhqPQ3vr6WE6zY8ip16rYLar0Y31lJNxCRVPHPC9QzHXrXutahGEJj
	0GU2fEzQP4567PSLaDIv2KA2IAdK8GqifFDnLMJD+XhJKP6X7GVQJ/LJUNZgQBat
	djrJDkQoYiRc9mSFqpOEbU0OLW0IPP1HnOlRIh2HqEf2NTe0MnALNuQyl94Q940S
	pyxFVhqhcvjRQCEwaQA3KiGqE66UKxQtQ53WPegLParnSw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91a4m7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:06:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-990ca9607c3so2594495241.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793099201; x=1793704001; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YAs9yE3ryxQ6Hl63Kw+ENBo0qX1XTY4t+VA6gDiBjWc=;
        b=esJ/dn+IC1tw+Ks7xNeWkLxQYlj6fPKf+XsEDnOdoWXDKsA49B2ikzXNezlErIZpo9
         tbchY2delATeQKgVFWhDGdXRoicCFGHtuzaek8E9HxEvit0v2lajyzHoBKnMw5W0t38M
         4q6syxV69sDA9mXm5tfyK1koroKnVmA2skMEGIC1dLE8HOS1NGsoSd4WYoLmeGiqGJfj
         c0/Bg7dtLmdHw5b4cm6H3M6ne1qNYeVRL/ZwlSHQWDrGdrFimWsX4HDxszK+KW6HUNJ6
         W8GnpQL9crONFu0UYbzhRTG6CwNEg1px0afNdnBXg9ZkSE5cIzwy0ClmnFDkeE91rehI
         uSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099201; x=1793704001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAs9yE3ryxQ6Hl63Kw+ENBo0qX1XTY4t+VA6gDiBjWc=;
        b=DvQx7T8NIUvzwohbRjaAPRbuT5tiQvw9+P0SSEeyoFpwKeQiyciSdMWyE4xi3/+r6/
         O9381le9feD0VTZXHQRNoJENqlQWyJL4CkuULBjLS5V7tbJqx9TRH1f+eQcM9lKYZCnS
         iUp581qnc99/2PJjdeke0ZL8ikXM+9fl+4eLddIheRiQNe56wLu1jTeokFAHkTmFD/4T
         yDxr0mufRvgeGNBHZnRsnmfXwCK4HbdJ6ycfGakvi0GDwN77t+59bAoixbYSoDte7MA7
         NqKnV6nxtGdpi9L+KsACIxKYkbaJrOx6URPjZ2fiApnt9fKctQN75N8bTyte7OTrZtEh
         5GEA==
X-Forwarded-Encrypted: i=1; AKwUvBxq30JsPj++kvFO6C7zzb2iipp0gDbfhlGt7YlshcBbfndYUcBbLANT39s4wxIZsADpCOybeCcpfpPZASvfEg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLL1z8jgX6yewQGqxZhvCllHLuQV0o+3nIipsCBqfhHQSo3X/WB
	MukhT1smZWiHad5xtuc/fOzeVKKSrcVu5eu73EczZru003aCTzFNBjibfHIEOZaVeBtPl46PMmy
	GLboR2ARHSogpU3eXiWkuM3LslsB4pgq8kKXlNCldGHOo3H0M57++pkC03Skm3LWMxZuttg==
X-Gm-Gg: AYBFou0bniEPidkUYk8EFDL+lBu/EjYrdRJ50k7Hl0lHyTEb/FMKegVg4HwMd97yc5h
	FUkRg82PPPyOsWgiPWo/+xyLOeCrijLVfKzX+rXgmm+5eWr5h9RXpq3NHtlyJPPZi//FZfO7oVi
	f4g/IteaP6/9kysTC1GzrZVshTHOMec54lymsGAIzy7p1iokZbXm+wUJj1lJ/WD3SSEARXCvHzY
	XIsyR42umPwxtQMll+qEj7Ixa1+27++zS1NB6kh4OkwC9bw/AN/cjJZoJcAFAdtwpwfuP7J4DU5
	YcbXqJhDUUPWpCArFUgn0KvU/sjuEr+KWa1uWte+TKeP7t4NHEajO0YqjuqWlHfEvnmfzfONgyx
	0rWqhMSpraWTybewKpexI0kUP82vfXH673Bbbsrdb+JricYyBFNFjoFbIWDRs0d3wIxnMYT8i5/
	i4mpVDDYX9V2Sv
X-Received: by 2002:a05:6102:50a4:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7ce5ca0ccd2mr3572982137.3.1793099200616;
        Tue, 27 Oct 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:6102:50a4:b0:7b3:32fe:77b6 with SMTP id ada2fe7eead31-7ce5ca0ccd2mr3572974137.3.1793099200096;
        Tue, 27 Oct 2026 04:06:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac709f3a4csm25383871fa.25.2026.10.27.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:06:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:06:36 +0200
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
Subject: Re: [PATCH v2 10/23] drm/msm/dcp: Add HFI DSI and panel commands
Message-ID: <ebhoujzyf4fn5v3gfmgrskjw646d2e7l5b3yr4pyq2wh4vrclq@5a6vx4zx55w3>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
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
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: iDXcUijku3gnjVfoYhiPCe7n5wnXQ8LW
X-Proofpoint-GUID: iDXcUijku3gnjVfoYhiPCe7n5wnXQ8LW
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae085c2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=XOpGMaQh1TDZy5n8wDsA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfXwtJ5ABNGzvPt
 uuq/GGLp3MS0cDVeneOu40lpHCjK43SdKr4THet4esRVTXyTZWQTTK+vDrGTyq3CwtvblS8hkTe
 9BCIQ8Tju9pJSZnQt1ichFqLOawPuz9rk5kq+O5eRJ8UAFHY59JLjkZ9q81l6jYC4sr3GBIH2BD
 OhyXpoP+J/+zirQ03hh0nbXl33cIoqyWqCOCE594oGfw5Tsu4xIVHV90IJp5rJMu1QKQiuK+Kfq
 cDP/dgmqJ3c1xCHcxvi2U2Hr3HnR1h82/5Lz/3Q5EcwSw2MmM5GVpai4ExIbkwuhnS/tIKEZiHk
 xDo2tgtXhTx7E4qkTxw5e4BAxlNG91vg2Jq8zXbscEjwfLUGdYj76/n6mBs7maNtb1T1knNul0S
 pJFh3lPuSp+s6sIcoB19I7yn/zaLSJgUDt2jY4EDTsbeyFfEleaEzlmLZM8Enz3iMif/TaBmgie
 E6+4/pXbEIIr+gpSzCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NCBTYWx0ZWRfX5nZhN4PGuPd8
 KOg5EslHSd1hHrECa0ds4fFgVRMGLU4rFqs5YaAx5LbbW8Jm2MuH8f/+/7tlfd+u9oYOP/CH7Vo
 kky3vpsKAo6cy9/bR1es7tCQ4SdkgD8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270044

On Mon, Oct 26, 2026 at 11:51:20AM +0530, Jayant Shekhar wrote:
> Translate DSI host and panel operations into HFI commands. Firmware
> owns the DSI hardware, so mode validation, display power, panel setup,
> and DCS transfers must cross the HFI interface instead of accessing
> controller registers from Linux.
> 
> Implement DSI mode validation, display session and power management,
> panel initialization, and DCS transfer helpers while keeping them
> separate from generic display commands.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                |   2 +
>  drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h     |  81 ++++
>  drivers/gpu/drm/msm/dcp/dcp_hfi.h           |  25 ++
>  drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c       | 252 ++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c | 592 ++++++++++++++++++++++++++++

Please stop calling it a panel. There can be any bridge after the DSI
device. From the Linux point of view, drm_panel is a subclass of
drm_bridge.

>  5 files changed, 952 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index bdc5e3b8efa7..77c268aabca6 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -74,6 +74,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
>  msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_core.o \
>  	dcp/dcp_hfi_crtc.o \
> +	dcp/dcp_hfi_dsi.o \
> +	dcp/dcp_hfi_dsi_panel.o \
>  	dcp/dcp_hfi_encoder.o \
>  	dcp/dcp_hfi_kms.o \
>  	dcp/dcp_hfi_plane.o \
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
> new file mode 100644
> index 000000000000..a8898e469b44
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP DSI panel configuration shared by the HFI panel implementation and

What if there is a DSI2DPI or DSI2LVDS bridge and then DPI or LVDS
panel?

> + * the DRM DSI bridge.
> + */
> +
> +#ifndef __DCP_DSI_PANEL_H__
> +#define __DCP_DSI_PANEL_H__
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#define DCP_DSI_MAX_PHY_TIMINGS	32
> +
> +/**
> + * struct dcp_dsi_hfi_panel_config - Complete HFI PANEL_INIT configuration.
> + *
> + * This contains the bridge-owned panel configuration plus the
> + * mode-dependent values assembled before the HFI PANEL_INIT command.
> + */
> +struct dcp_dsi_hfi_panel_config {
> +	u32 display_type;
> +	u32 num_ctrls;
> +	u32 ctrl_indices[4];
> +	u32 num_phys;
> +	u32 phy_indices[4];
> +	u32 vsync_source;
> +	u32 te_dcs_command;
> +	u32 dma_trigger;
> +	u32 stream_trigger;
> +	u32 wr_mem_start;
> +	u32 wr_mem_continue;
> +	u32 dma_sched_line;
> +	u32 dma_sched_window;
> +	u32 phy_type;
> +	bool cphy_mode;
> +	bool lp11_init;
> +	bool ulps_supported;
> +	bool bllp_eof_power_mode;
> +	bool bllp_power_mode;
> +	u32 lane_map;
> +	u32 color_order;
> +	u32 esd_mode;
> +	u32 jitter_numer;
> +	u32 jitter_denom;
> +	dma_addr_t dcs_tx_dva;
> +	dma_addr_t dcs_tx_iova;
> +	u32 dcs_tx_buf_size;
> +	u32 phy_timings[DCP_DSI_MAX_PHY_TIMINGS];
> +	u32 num_phy_timings;
> +	bool dsc_enabled;
> +	u32 dsc_version_major;
> +	u32 dsc_version_minor;
> +	u32 dsc_scr_version;
> +	u32 dsc_slice_height;
> +	u32 dsc_slice_width;
> +	u32 dsc_slices_per_pkt;
> +	u32 dsc_bits_per_component;
> +	u32 dsc_pps_delay_ms;
> +	u32 dsc_bits_per_pixel;
> +	u32 dsc_chroma_format;
> +	u32 dsc_color_space;
> +	u32 dsc_block_prediction_enable;

Why do you need to copy those? Can't you use struct drm_dsc directly?
Having it as a non-NULL pointer would have saved you from having
the dsc_enabled flag.

> +	/* Optional DSC rate-control override panel configuration. */
> +	bool dsc_rc_override;
> +	u8 dsc_rc_min_qp[15];
> +	u8 dsc_rc_max_qp[15];
> +	u8 dsc_rc_bpg_offsets[15];
> +	u32 topology_mixer_count;
> +	u32 topology_enc_count;
> +	u32 topology_intf_count;
> +};
> +
> +/* DCS buffers use IOVAs directly in the firmware command descriptor. */
> +#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
> +#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
> +
> +#endif /* __DCP_DSI_PANEL_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> index 6d3eadb5e811..88d73de69383 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
> @@ -242,6 +242,31 @@ int dcp_hfi_send_resource_register(struct dcp_hfi *hfi);
>  int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
>  				 u32 prop_id, u32 value);
>  
> +struct dcp_dsi_hfi_panel_config;
> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
> +		       const struct drm_display_mode *mode,
> +		       const struct mipi_dsi_device *dsi,
> +		       const struct dcp_dsi_hfi_panel_config *cfg);
> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
> +			   u32 display_id, u32 *session_id);
> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
> +				  const struct drm_display_mode *mode,
> +				  u64 clk_rate_hz);
> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct drm_display_mode *mode,
> +			     u64 clk_rate_hz);
> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
> +				      u32 packet_id);
> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
> +ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct mipi_dsi_msg *msg,
> +			     void *tx_buf, dma_addr_t tx_iova,
> +			     void *rx_buf, dma_addr_t rx_iova,
> +			     u32 post_wait_ms, u32 ctrl_idx);
>  #endif /* __DCP_HFI_H__ */
>  void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
>  				  void (*cb)(void *priv, u32 display_id,
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
> new file mode 100644
> index 000000000000..fbeec03cf90d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * HFI commands for the DSI display-session lifecycle.
> + * Panel initialization and DCS transfers are implemented in dcp_hfi_dsi_panel.c.
> + */
> +
> +#include <linux/device.h>
> +#include <drm/drm_modes.h>
> +
> +#include "dcp_hfi.h"
> +#include "dcp_hfi_priv.h"
> +#include "hfi/hfi_commands_display.h"
> +#include "hfi/hfi_defs_common.h"
> +#include "hfi/hfi_defs_display.h"
> +#include "hfi/hfi_packet.h"
> +#include "hfi/hfi_packer.h"
> +#include "hfi/hfi_properties_display.h"
> +
> +static void dcp_hfi_fill_mode_info(struct hfi_display_mode_info *info,
> +				   const struct drm_display_mode *mode)
> +{
> +	memset(info, 0, sizeof(*info));
> +	info->size            = sizeof(*info);
> +	info->h_active        = mode->hdisplay;
> +	info->h_back_porch    = mode->htotal - mode->hsync_end;
> +	info->h_sync_width    = mode->hsync_end - mode->hsync_start;
> +	info->h_front_porch   = mode->hsync_start - mode->hdisplay;
> +	info->h_skew          = mode->hskew;
> +	info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
> +	info->v_active        = mode->vdisplay;
> +	info->v_back_porch    = mode->vtotal - mode->vsync_end;
> +	info->v_sync_width    = mode->vsync_end - mode->vsync_start;
> +	info->v_front_porch   = mode->vsync_start - mode->vdisplay;
> +	info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
> +	info->refresh_rate    = drm_mode_vrefresh(mode);
> +	info->clk_rate_hz_lo = lower_32_bits((u64)mode->clock * 1000);
> +	info->clk_rate_hz_hi = upper_32_bits((u64)mode->clock * 1000);
> +}
> +
> +static void dcp_hfi_dump_mode_info(struct dcp_hfi *hfi, const char *cmd,
> +				   u32 session_id,
> +				   const struct hfi_display_mode_info *info)
> +{
> +	dev_dbg(hfi->dev,
> +		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
> +		cmd, session_id,
> +		info->h_active, info->h_back_porch, info->h_sync_width,
> +		info->h_front_porch,
> +		info->v_active, info->v_back_porch, info->v_sync_width,
> +		info->v_front_porch,
> +		info->h_sync_polarity, info->v_sync_polarity,
> +		info->refresh_rate,
> +		(u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
> +		info->size);
> +}
> +
> +int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
> +				  const struct drm_display_mode *mode, u64 clk_rate_hz)
> +{
> +	struct hfi_display_mode_info info;
> +	int ret;
> +
> +	dcp_hfi_fill_mode_info(&info, mode);
> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
> +	dcp_hfi_dump_mode_info(hfi, "HFI MODE_VALIDATE", session_id, &info);
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_MODE_VALIDATE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_U32_ARRAY,
> +				&info, sizeof(info),
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_MODE_MS);
> +
> +	return ret;
> +}
> +
> +int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct drm_display_mode *mode, u64 clk_rate_hz)
> +{
> +	struct hfi_display_mode_info info;
> +	int ret;
> +
> +	dcp_hfi_fill_mode_info(&info, mode);
> +	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
> +	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
> +	dcp_hfi_dump_mode_info(hfi, "HFI SET_MODE", session_id, &info);
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_SET_MODE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_U32_ARRAY,
> +				&info, sizeof(info),
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_MODE_MS);
> +
> +	return ret;
> +}
> +
> +int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POWER_REGISTER,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
> +				      u32 packet_id)
> +{
> +	struct dcp_hfi_buf *buf;
> +	struct hfi_cmd_buff_hdl hdl;
> +	struct hfi_header_info hdr_info;
> +	struct hfi_packet_info pkt_info;
> +	int ret;
> +
> +	buf = dcp_hfi_buf_alloc(hfi);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	hdl.cmd_buffer = buf->data;
> +	hdl.size       = DCP_HFI_BUF_SIZE;
> +
> +	hdr_info.num_packets   = 0;
> +	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
> +	hdr_info.object_id     = session_id;
> +	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
> +
> +	ret = hfi_create_header(&hdl, &hdr_info);
> +	if (ret)
> +		goto err_free_buf;
> +
> +	pkt_info.cmd          = HFI_COMMAND_DISPLAY_POWER_CONTROL;
> +	pkt_info.id           = session_id & 0xFFFF;
> +	pkt_info.flags        = HFI_RX_FLAGS_SUCCESS;
> +	pkt_info.packet_id    = packet_id;
> +	pkt_info.payload_type = HFI_PAYLOAD_NONE;
> +	pkt_info.payload_size = 0;
> +	pkt_info.payload_ptr  = NULL;
> +
> +	ret = hfi_create_packet_header(&hdl, &pkt_info);
> +	if (ret)
> +		goto err_free_buf;
> +
> +	return dcp_hfi_send_cmd_async(hfi, buf, hfi_get_header_size(&hdl), NULL);
> +
> +err_free_buf:
> +	dcp_hfi_buf_free(hfi, buf);
> +	return ret;
> +}
> +
> +int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx, u32 display_id,
> +			   u32 *session_id)
> +{
> +	int ret;
> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_ENABLE,
> +				HFI_CMD_BUFF_DISPLAY, display_id,
> +				HFI_PAYLOAD_NONE, NULL, 0,
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
> +	if (ret) {
> +		dev_err(hfi->dev,
> +			"HFI DISPLAY_ENABLE intf=%u display_id=%u failed: %d\n",
> +			intf_idx, display_id, ret);
> +		return ret;
> +	}
> +
> +	*session_id = display_id;
> +
> +	return 0;
> +}
> +
> +int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POST_ENABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_DISABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	return dcp_hfi_send_sync(hfi,
> +				 HFI_COMMAND_DISPLAY_POST_DISABLE,
> +				 HFI_CMD_BUFF_DISPLAY, session_id,
> +				 HFI_PAYLOAD_NONE, NULL, 0,
> +				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				 HFI_TX_FLAGS_NON_DISCARDABLE,
> +				 NULL, 0,
> +				 DCP_HFI_TIMEOUT_DISPLAY_MS);
> +}
> +
> +int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
> +{
> +	int ret;
> +
> +	ret = dcp_hfi_display_disable(hfi, session_id);
> +	if (ret) {
> +		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dcp_hfi_display_post_disable(hfi, session_id);
> +	if (ret) {
> +		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
> +		return ret;
> +	}

Why are there two types of calls, pre and post? Should they go to the
corresponding separate DRM callbacks?

> +
> +	ret = dcp_hfi_send_sync(hfi,
> +				HFI_COMMAND_DISPLAY_CLOSE,
> +				HFI_CMD_BUFF_DISPLAY, session_id,
> +				HFI_PAYLOAD_NONE, NULL, 0,
> +				HFI_TX_FLAGS_RESPONSE_REQUIRED |
> +				HFI_TX_FLAGS_NON_DISCARDABLE,
> +				NULL, 0,
> +				DCP_HFI_TIMEOUT_DISPLAY_MS);
> +	if (ret)
> +		dev_warn(hfi->dev, "HFI DISPLAY_CLOSE failed: %d\n", ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
> new file mode 100644
> index 000000000000..b27fa8fa3160
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
> @@ -0,0 +1,592 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * HFI commands for panel initialization and DCS transfers.
> + * Firmware owns the DSI controller and PHY.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/math64.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_mipi_dsi.h>
> +
> +#include "dcp_dsi_panel.h"
> +#include "dcp_hfi.h"
> +#include "dcp_hfi_priv.h"
> +#include "hfi/hfi_commands_display.h"
> +#include "hfi/hfi_commands_panel.h"
> +#include "hfi/hfi_defs_common.h"
> +#include "hfi/hfi_defs_panel.h"
> +#include "hfi/hfi_packet.h"
> +#include "hfi/hfi_packer.h"
> +#include "hfi/hfi_properties_panel.h"
> +
> +#define DCP_DSI_CTRL_CMD_READ              BIT(0)
> +#define DCP_DSI_CTRL_CMD_FETCH_MEMORY      BIT(5)
> +#define DCP_DSI_CTRL_CMD_LAST_COMMAND      BIT(6)
> +
> +static u32 dcp_bpp_to_hfi(u32 bpp)
> +{
> +	switch (bpp) {
> +	case 16: return HFI_PANEL_BPP_16;
> +	case 18: return HFI_PANEL_BPP_18;
> +	case 30: return HFI_PANEL_BPP_30;
> +	case 24:
> +	default: return HFI_PANEL_BPP_24;
> +	}
> +}
> +
> +static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
> +{
> +	if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +		return HFI_PANEL_TRAFFIC_BURST_MODE;
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> +		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE;
> +	return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
> +}
> +
> +static u32 dcp_lanes_to_hfi(u32 num_lanes)
> +{
> +	u32 mask = 0;
> +
> +	if (num_lanes >= 1)
> +		mask |= HFI_PANEL_LANE_0;

There is always at least one lane. Set the mask to HFI_PANEL_LANE_0.

> +	if (num_lanes >= 2)
> +		mask |= HFI_PANEL_LANE_1;
> +	if (num_lanes >= 3)
> +		mask |= HFI_PANEL_LANE_2;
> +	if (num_lanes >= 4)
> +		mask |= HFI_PANEL_LANE_3;
> +
> +	return mask ?: HFI_PANEL_LANE_0;
> +}
> +
> +static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
> +			       struct dcp_hfi_completion *comp)
> +{
> +	unsigned long flags;
> +
> +	if (wait_for_completion_timeout(&comp->done,
> +					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
> +		return false;
> +
> +	/* Serialize removal with response dispatch before the stack object dies. */
> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +	dcp_hfi_pending_find(hfi, comp->packet_id);
> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +	return true;
> +}
> +
> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
> +		       const struct drm_display_mode *mode,
> +		       const struct mipi_dsi_device *dsi,
> +		       const struct dcp_dsi_hfi_panel_config *cfg)
> +{
> +	u32 num_lanes;
> +	u32 bpp;
> +	bool is_cmd_mode;
> +	u32 display_type;
> +	u32 vsync_source;
> +	u32 traffic_mode;
> +	u32 phy_type;
> +
> +	struct dcp_hfi_buf *buf1, *buf2;
> +	struct hfi_cmd_buff_hdl hdl1, hdl2;
> +	struct hfi_header_info hdr_info1, hdr_info2;
> +	struct hfi_packet_info pkt_info;
> +	struct dcp_hfi_completion comp1, comp2, comp3;
> +	u32 payload[128];
> +	u32 *p;
> +	u32 packet_id, packet_id2, packet_id3;
> +	u64 clk_hz;
> +	int ret;
> +	bool timeout1, timeout2, timeout3;
> +	u32 link_bpp_x16;

Reverse christmas tree, apply universally to all your code.

> +
> +	if (!hfi || !mode || !dsi || !dsi->lanes || !cfg)
> +		return -EINVAL;

And which of those can actually be passed as NULL?

> +	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
> +	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
> +		return -EINVAL;
> +
> +	display_type = cfg->display_type;
> +	vsync_source = cfg->vsync_source;
> +	phy_type = cfg->phy_type;
> +	num_lanes = dsi->lanes;
> +	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> +	if (bpp < 0)
> +		return -EINVAL;
> +	is_cmd_mode = !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
> +	traffic_mode = dcp_dsi_traffic_mode(dsi);
> +	link_bpp_x16 = bpp << 4;
> +
> +	buf1 = dcp_hfi_buf_alloc(hfi);
> +	if (!buf1) {
> +		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted\n");
> +		return -ENOMEM;
> +	}
> +
> +	hdl1.cmd_buffer = buf1->data;
> +	hdl1.size       = DCP_HFI_BUF_SIZE;
> +
> +	hdr_info1.num_packets   = 0;
> +	hdr_info1.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
> +	hdr_info1.object_id     = intf_idx;
> +	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
> +
> +	ret = hfi_create_header(&hdl1, &hdr_info1);
> +	if (ret) {
> +		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
> +			ret);
> +		goto err_free_buf1;
> +	}
> +
> +	{

Jayant, you really like to ignore comments. Please stop doing that. And
also please stop having unconditional nested blocks. If you need one,
extract it to a function.

> +		u32 num_props = 0;
> +
> +		p = payload + 1;
> +		num_props++;
> +		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
> +
> +		/* DCS TX buffer is described by both DVA and IOVA properties. */
> +		if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
> +		    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
> +			num_props++;
> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
> +				       lower_32_bits(cfg->dcs_tx_dva),
> +				       upper_32_bits(cfg->dcs_tx_dva),
> +				       cfg->dcs_tx_buf_size, 0, 0);
> +			num_props++;
> +			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
> +				       lower_32_bits(cfg->dcs_tx_iova),
> +				       upper_32_bits(cfg->dcs_tx_iova),
> +				       cfg->dcs_tx_buf_size, 0, 0);
> +		}
> +		payload[0] = num_props;
> +	}
> +

-- 
With best wishes
Dmitry

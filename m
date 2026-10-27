Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102331;
	b=N3kiLlKsXkeBXP9wE5Olenur0MgGNGNgjLnCznJrUQlCM4QN3ZWZm6f2itwsSSZFhfRY
	 wEgxv+ZLrN0C+yYR614mATDezmvVBj2pxqtLUC3zQeDjGGWyg6yYW5YbFD5JfGb3ofOfj
	 sBPp78XHlKTN3s4oKQCNSzhJ/IgCQca18Js6kRsquTr86EvpvmGkufMYaaX2R67AVyJS8
	 mqakC3Xwst5dui2EvksfeMol5pwVy/Cyr94TmSuWHLSyV5bLN6l14Niay/ytaRcx3W0+h
	 RIBy3+mwMkWTXjn/KrHgy0WsD/XRlMOpjTq/mtJbR3YnUHuwaWVvCSHbsRotZUNiQ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
	b=5kKvM0F9gcUyxH09OgjpMeGkNXbLbHNHIGfCqzCNwJD24ZBjQYZaIgdLUR9vxJHy1G1i
	 vUehWVGVY0lJf3+QdCAh8rmexY/ToEl/suI23WRcRlGJfQ/sSis9ItollsZWRdaBXjHPx
	 usKdCVpBxXHP7M1gjNbdPxrOdGDj0aSUXVtJZItvJi45ilu6h2ozk1UR743eYPlvUeFNL
	 h0IhkDAhvNeBCvqFpw9IdKO2yJHHs5dfDzhDRTzJh3f0gjz2AyQgQi9lGwktdu6Tf0pAQ
	 3RXVxu9O4nEldyAlnJiL2Qy/iWcjpgJDRB4PMfO9w58kal7laL9hJ3FFKD9wx1Q2XzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBfSKDWU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0KpnqVH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621C606A31D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6621C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kBfSKDWU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0KpnqVH
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdsn11973260
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=; b=kBfSKDWUMiXE2MWx
	UfYT9MTCvVbTk9XVkED0JWhz24h90TOvx3quBRZyIGkuBmeOcLVAASYHkSPc5jd9
	20OL1qOFckWZdVF22xCb4DHsImDKQJ+HY0gE9Puoq8vfCxMql1dRBYs6BmAlVWkH
	RckL2BFQH4slxrpmXRzhtbMnE3opd90cHsq4rPjmX5givw+9B3vXRWeJObmuRz6N
	eIczvP7UgFt+gMQysBziSYzWN+aCk2AJj+H9AcxTNT5TBbx8jcMrNpGfkkboZj58
	MM8fBhuJ041bi8ILWgKK1X+7Svs5sFcPpxWAhjOsO50G+lKkwvnJnlDOD4CQpqOn
	EscHRw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1gdpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:58:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9907de400a6so564743241.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793102329; x=1793707129; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
        b=N0KpnqVHHMktm375/9fLv1qzb6VRb81Tg1itXnIrRX6ln7DosRbfv7/qsb3udBCRPb
         1wDT+CXy+5eCRSr6phgEYlIBBEUVKU9kUqRlQ0ddKw1sQZudWy98iYH25NzrPsbPQRLP
         79nlPaEHP9z8QtcqbAJi0sz3FQGoG5HY50QfNAVsTI7Vx8IXH3QnJwT1mG1FHhAA5WjE
         YkkI01kSbjlBOzlHMpkhMxTz68PqbYK9g9oWLaV45Z7WkUzZyKEL5HeHMA0QF8W0SKMf
         bSyDbzZ9ie6s2emLmNSbcwMD7TVuiawXxyOdY3ZEZrNfrGvCO36omjBkJT592E50D/kH
         K5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102329; x=1793707129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8WFUrHNWaio59C4MJug1pehFmtY/vUi9V1RMigc1CXo=;
        b=b8OuROHZst6egL8lehxpuc4DkqiPiDAVUuqqi7q6ePB2N6H2qjqOdC8g/1CRnim/sX
         qDIBI2M3b8W3T5e5aLhMI924PCzndnNECjbcC/KLzMw7rU1Bj16hlX4dGXG2gFPDC3au
         5if5LOGBGHZYUwj/oXe0O3SSX65UCtMHR5Pv9hlqzpUTwl2xA0u8s/WjZrDbKTqBS/8b
         cS7lKNN7Wbtr2NtnOsB2Yh9Ja6QjU+bJrFqQzEI+fVT5CsHBL43bwAdjxNpdiKIsBiWq
         oLfuWRRDeZZPbhzxaaggLPtg0MNQcuZQETJJkK5ruMzRVbzpN5CbVsZvmBFgGqZhoEFc
         RPOw==
X-Forwarded-Encrypted: i=1; AKwUvBzJy+EH1q/fwsdGtHFqX1fPHDRxms7h6rgfhKXcEwQFv9grurmQD8lDV34aDiEvOJqCR8SLOcwusRKEAfrIRg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKpqIPSUnFFp4I4CAmXslsfUmbnxKmN56FQwPxYkv2/LkvenBFZ
	blakz8QkqqYgNKfcr1JOr+fgURojnGkjVUXfJXeuN+7gk6G7kkUhsWXYdjQdxT5YQQUS6rJ1PwT
	62D+qKtKRIBFhIQcAkGLa64CtbgcWkGdpjGjZiDtEp1o6hyLFryclFb8QnapLo4QKNZk/Cw==
X-Gm-Gg: AYBFou06z8OjrFNUqK52h45qfEPiibJL6KDg0AmEB0kyReArS64ikEn0uzGKD28mka2
	We3paxzgUTWBxXNcqgnx7F0zMZimGd4dr3VPAx9Gn/F4fQrQeM+82prApgnC9On3BY4AuuP1KKP
	3W5TzAEMinWiBFod5v46l8I3+vpcdfjsuhWFZjFGYILZBkExSZwLXL9tn+aYtqupPZqCewPSskv
	PxoWPzB6VlmY2bXEzpbaNiax5IAYUCEjfTJTR0Nd9XRctsNfyPCgSk1gUT7zoapb9qywHSR1pOx
	eAOVpWJvdZpaGYtQ0vFpbLAk8g5jHV+kJkCBQ1/KcUeVNnYNHq5U56y6xPiEcZVmJBaTFFE9RlL
	B8AkeuXiv23UZ1VCX2NV3oq2CYThtNlU8i7JT8Hsk7GfwLNOMYoot7dcikhMoxo4DPk2NkvGH/g
	w6jsFlskheJ8ma
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id ada2fe7eead31-7ce5ce246dfmr3089888137.32.1793102329235;
        Tue, 27 Oct 2026 04:58:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad2:b0:7c3:875e:593b with SMTP id ada2fe7eead31-7ce5ce246dfmr3089855137.32.1793102328285;
        Tue, 27 Oct 2026 04:58:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6aca4sm2092776e87.15.2026.10.27.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:58:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:58:45 +0200
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
Subject: Re: [PATCH v2 00/23] drm/msm/dcp: Add Qualcomm DCP display support
Message-ID: <55uzx3sa4jor5p7i5erhyuangyfvc3ssp5rgelagk4ysply2ip@3x46t7swwj56>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae091fa cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=sWvDS1lmqIG2hvCGZjwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: D9A40lMkK1Fb0kTfcdO_xfvCKz9Xy8uP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX62L30cUuVp9G
 PPyCt6xHoIOgHKfWZKzhcbcsg6HEba9Tbyd8clywNGTgqimDmXqGooxgVF6GW9u/r0VPRNrLcDU
 tue6AFOs28BIdwtURqd3STy/FOyr+D0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX7ApAck9yZ06o
 5i8G49nD2qgfNpsB/Q2TFcDiSZ2KgA+AyAoRxV50KMLsdLx+Mhu8ihdk8+WPiX8NgpHUFQgNDth
 H4dIKQvqlfsmKKWDdKqOmUzdibTOXAZLrbt3zN3327F/OW1BgqEawzKbr0xUNjMsAGNxXSrpiHr
 AHENjrz5CwgcvgfA/3twVEPsyDkDE5Z3OcklLZCVAsnQNPfrT1nINXielqeTRmBYtcXKWPixRFG
 N9Pdm3UQ4dFQv2Ot9hyMrN54kYi1cdB2o7j5Qk3qM8U7hdowcWOmP6oD5LxXNt8Hzlmti23cUK1
 kIhQoPvqH45oLce1zL9XpkBpueTBjQJiZmeTZwPJDwR+L0LwHQs9mJNYHuTiA3UrAcNLQFwURjF
 OUOZU3w3DpYc9wByvYQCpQCuuad2rYaM5x76MVc4BBIwJnRwHUyQymALqPUXTy6K9fPc+h67IXN
 JUpnT5I7odMfxIw5Z7Q==
X-Proofpoint-GUID: D9A40lMkK1Fb0kTfcdO_xfvCKz9Xy8uP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270047

On Mon, Oct 26, 2026 at 11:51:10AM +0530, Jayant Shekhar wrote:
> On Qualcomm platforms using the Display Co-Processor (DCP), the display
> hardware is owned and programmed by firmware. Linux does not access the
> display controller, DSI controller, DSI PHY, display clocks, or other
> display pipeline registers.
> 
> The display pipeline must nevertheless be exposed through the DRM/KMS
> interfaces so userspace can perform modesetting, framebuffer updates,
> panel control, and page flips.
> 
> This series adds a DCP KMS backend to MSM DRM. It represents the
> firmware-owned display pipeline and translates DRM operations into HFI
> commands.
> 
> DCP communicates with Linux over VirtIO and uses the HFI protocol for
> command and response handling, capability discovery, and display events.
> 
> This series adds:
> 
> - Device-tree bindings for the Qualcomm DCP VirtIO transport wrapper,
>   firmware-visible IOVA ranges, separate transport and framebuffer IOMMU
>   contexts, IPCC power notification, interrupts, and the external DSI
>   display graph.
> 
> - HFI protocol definitions and packet helpers for capability discovery,
>   modesetting, plane and CRTC configuration, DSI, and panel control.
> 
> - A Qualcomm DCP transport wrapper which initializes the IPCC channel,
>   sends the required power notification, and registers the DCP VirtIO
>   device directly. The wrapper also implements the MMIO transport and
>   keeps VirtIO queue activity ordered with DCP power transitions.
> 
> - VirtIO command and response queues. HFI command, response, and
>   capability buffers are allocated through the DMA API in the address
>   space visible to DCP firmware.
> 
> - Synchronous command tracking, asynchronous response dispatch, timeout
>   handling, and queue teardown synchronization for safe device removal.
> 
> - Capability discovery for displays, CRTCs, mixers, VIG and DMA pipes,
>   DSI interfaces, and panel resources.
> 
> - DRM planes and CRTCs using the standard atomic-state model. DRM state is
>   translated into HFI properties for layer configuration, mixer limits,
>   bandwidth and clock properties, frame sequencing, and triggering.
> 
> - An MSM KMS backend, DCP encoder, and DSI bridge. The backend reuses the
>   existing MSM DRM device, GEM and framebuffer handling, atomic commit
>   infrastructure, encoder, bridge, and connector support.
> 
> - Asynchronous VSYNC, frame-scan completion, and error events propagated to
>   DRM for vblank and page-flip completion.
> 
> - IPCC power notifications to wake DCP firmware and coordinate HFI queue
>   activity across firmware power transitions.
> 
> DCP is integrated as an MSM KMS backend rather than a separate DRM device.
> This preserves the userspace-visible MSM DRM device and allows Linux to
> retain normal DRM/KMS semantics while display hardware remains owned by
> firmware.
> 
> The initial implementation supports the DSI output described below and
> uses resources reported by firmware. Split-pipe, multirect, cursor-pipe,
> partial-update, DisplayPort, and writeback support are deferred.
> 
> Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:
> 
> - Display console at 1440x3200.
> - Panel initialization and DCS transfers complete successfully.
> 
> Device Tree Topology
> ====================
> 
>   qcom,dcp-virtio
>   ├── transport IOMMU context
>   ├── firmware-visible iommu-ranges
>   ├── VirtIO and power-notify interrupts
>   ├── dcp-power-tx mailbox
>   └── dcp-subsystem
>       ├── compatible = "virtio,device34"
>       ├── framebuffer IOMMU context
>       ├── port@0
>       │   └── endpoint ─────────────── panel endpoint
>       └── dsi@0
>           └── panel@0
> 
> The DCP INTF endpoint connects directly to the panel endpoint. Firmware
> internal paths, including the INTF-to-DSI connection, are not described in
> the device tree.
> 
> Runtime Architecture
> ====================
> 
>   Linux DRM/KMS
>   └── DCP MSM KMS backend
>       ├── planes, CRTCs, encoder, connector, and DSI bridge
>       └── DRM atomic state and commit handling
>                   │
>                   ▼
>       DCP VirtIO function driver
>                   │
>                   ▼
>               VirtIO core
>                   │
>                   ▼
>       qcom,dcp-virtio transport wrapper
>       ├── IPCC initialization and power notification
>       ├── MMIO register access
>       ├── VirtIO queue setup and interrupt handling
>       ├── VirtIO device registration
>       └── suspend/resume power sequencing
>                   │
>                   ▼
>               DCP firmware
>               ├── HFI command and response handling
>               ├── display pipeline and VIG/DMA pipes
>               ├── DSI PHY and controller
>               └── display clocks and resource handling

Going through the series, I have come with the quite generic comment.
Please split the series into two independent parts:
- Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
  drivers/virtio/virtio_dcp_*.[ch]

  Driver for the DCP + IPCC VirtIO host. The driver should not know
  anything about the display interface.

- Documentation/devicetree/bindings/display/msm
  drivers/gpu/drm/msm/dcp

  The actual driver for the DCP display engines. It must not know or
  care at all about the particular VirtIO host (or SoC FWIW). It should
  not use IPCC. If we pass it through to the VM via virtio-mmio or
  virtio-pci it must work as is.

Possibly submit those as two separate series.


-- 
With best wishes
Dmitry

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995701;
	b=lPqtIVn3VPUepX60USkd8CKYfc7A6//zv1O3nsiDmrySsvn6up0p3XXBZrYw8ga1kjQQ
	 fWfSwDaYqkhImtyv3CdfT51oHxr8erwZt/kCeIH7xmJzrcktmDEAL5LmDdFzdJWyV1Au9
	 8UwR7WPpgpyOK299oi0lUZ5xq1tG/Q1fhNC+0zSNh4UIGcrgXGbOLpEGynex7J5f4FpiW
	 q1j4aNbEWqBwvm4cnlPCT13ULLYLc+mc48XFlgGP3YwgO8n0e7Gfj7GZ1de+ySKg7C8b6
	 U02CuOH0Fa/irBz2bC2YMaj6Tq2+XylpyNL/BTMrrAScMVZpxWm0eBt+xgGZCWUBodw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3Twx7A+M4Xf78zm3h7xdXXb3QEmDww6Luk+tlQyZzXQ=;
	b=MCVENs8CU0ZdLgA4cyd1lPQrDzDftOZiBJxcuex3uprEw76f2rR5kdUR7HkFQex+S+Ih
	 tEOBuYg5oExtZ3eEGl88F/U6rlLlVFUe0YwuNnF4DerjqbNN1HWepcxe/jtSq0hFxKddt
	 vMGParp/GhAH+Avoi6EX9lY4F+uZazO0gM3qRKsVD6iLhp6GittUdr+VGE/kgZH4kKOpr
	 v+uuh7hN9i1o73nytETmlRPsIyjm8jGfo38qF96WEdHXEzSVc044cb6AxlLFphMSUPSd6
	 rzyvj5EcPEwM6PRSN/5Ol46XwLPdvIGcSSecnkdtLaanutc0wgbQr+bbz2AVf905pRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G6WpKsQm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NEDRB5rX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4C606A31D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G6WpKsQm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NEDRB5rX
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b9bX718228
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3Twx7A+M4Xf78zm3h7xdXX
	b3QEmDww6Luk+tlQyZzXQ=; b=G6WpKsQmfek9XUwnfEGTbPY1LwxqrCjmowHN2i
	H4iLObJkqcgMGfgq0Ssbmyvkj+xuvzzTE9d75IdrtoIUerymoQjQ1k3K42Vrg9mf
	icZbZTMCKhJz0PjmVgkCIqVziOZqS5zLRprT9m0giiCvN6mLZg+j+e3xIMkDng4r
	vvovmwBsSPd5J+LicnD+hAaaYk7ha/q3l1R1vkRc2TUnZPpFmAsFLNPsUls/XHqu
	CHmmZQXrlnn75HNwkr5Rsc/aCeaOqZ2HEyB8+YYjke4B2AkdaktfD6eFhQ0vPwQn
	/JceT+PA4rSgluYaDbKufAIKEE/qF1uhX+jKhzSPDqig5SVg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgss48w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:21:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eabb908860so8295185ad.0
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995699; x=1793600499; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Twx7A+M4Xf78zm3h7xdXXb3QEmDww6Luk+tlQyZzXQ=;
        b=NEDRB5rXRZ2pEWvBzVy5I/PSuMsuW/HuT3pIREwMxz6md8POM7FPF7f+Ihmr7+niml
         qTKQYUTD+iX8Zb9kzYQ2X9OXrJnmJcN4L+NC6y79XPqhnZWICtwt4YZ1kESdDc8nxvIs
         9dDK7GJeiA83Rc6RFpVvLZTD88L5AiklGyAipnRbfOQiWPCZWuLnSLyDsjh/RvngVdUC
         crEQ/0ZMBbU8vmifhsKZO0JQh5jW9Ts2/ijS+Usby3FcoGrBw/W1SgZQe3UzOhxQp2kJ
         35HB7p/H+Wj6X45b5IeOTPpO5U1sb+gmBt+OP1DGpE21OB/VI4VpaJuTRXr0Prdi8Jc7
         eV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995699; x=1793600499;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Twx7A+M4Xf78zm3h7xdXXb3QEmDww6Luk+tlQyZzXQ=;
        b=Hd6RIec35mWHAMwBzEqXxe8biL8G7MUnf0X9p88sa6GCPQ+9T5LTmAaD0NdOpSPGMG
         WeWEZe78XRo2UN2oZF6fqR5tT5s5qVfL93LB1Yqh8v/D9DR7MX6fiyq2aLMXFWo3+Mep
         5LgTHoH4t91WPEGu7+yGyAkYkTYnOqEbGwhLilGf5nqp7J85++x1ikYCIiljNaKwEFTt
         GjpHBMXJyuiH+m0vA4upQebRpaCLLVgT2uPAm8D/YzEOpQsBCgIJ6dxHzMiH+bo0w9cJ
         NBQZaUFodXFZ2Uei6D67RDy8svFfzy5ikJ8gM9AH/tXzrtFeSPT+NbJEDO0Y5O8lcHJu
         /Dlw==
X-Forwarded-Encrypted: i=1; AKwUvBz/qpcF7R8IfiPxUOyeoXqkz8A+IeDYCpSrlkLTEN5NpGOa5YonXJqMQXNpkK16m2e1M0787OPJFeHdmAHR0Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLY83ogoV+3d2hySNN/oXv2u3HvBqWGpathCKfaAXeKj2/MsAkb
	hMW5+BFeGIm//nESUh8eouQSWNT5NwP2c7s+I7dWbtAdDjo8tY5MqOfeaOp/Qi6K4uoyeVlvd/d
	0I8+IXRgy5WNGlUEm1O/nHd/L9a7XaaiQaN0QVdoPiqO6odBb57pwpEjQIcZgN+4d6K9AzA==
X-Gm-Gg: AYBFou1XHZ+bhkIdr9V7deJZCFPkKvAoUbI1CqccQKlnubOw+Ib2mhrsYeXYfaFWN5F
	IhU4Srwf4cei4v7EC0dqn/XmsWoYjCMu15WtumNddNYzaxtn9sURsI3Lnrw1PZp1xI4q1koje4q
	ws8F3ltfNBFZlIZ/+gxCScE48vBy75wUvRAbYZ87V2TbX6didBgbnSNRQBMmi6mZ+D9FW055YUX
	egKTQuBXytmIBfy8yCMSsanWm8+hh0VmqHmkr3fdcgQbdvdhpuLQwd6SrfRybM4jFFFD2gXjIgF
	ppQSHC60Oe0PCssRViCMHuWdbH1DuviFnZkZxlhZ9GsyEUSv9efDr3dyJ8nHlhkm9fTmq2E/XW2
	3hB944cG34eSmEy86/oW6XQDaueoaDzZ7+g==
X-Received: by 2002:a17:902:c411:b0:2e5:d2b1:c70b with SMTP id d9443c01a7336-2ea9c8b0505mr57206525ad.60.1792995699096;
        Sun, 25 Oct 2026 23:21:39 -0700 (PDT)
X-Received: by 2002:a17:902:c411:b0:2e5:d2b1:c70b with SMTP id d9443c01a7336-2ea9c8b0505mr57206245ad.60.1792995698545;
        Sun, 25 Oct 2026 23:21:38 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:21:37 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH v2 00/23] drm/msm/dcp: Add Qualcomm DCP display support
Date: Mon, 26 Oct 2026 11:51:10 +0530
Message-Id: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFbx3moC/02PzW7DIBCEX8XiXCKg/NmnvEeVAz9LIY1jB2yrV
 ZR3L9g9VFqtNNLsN7NPVCAnKGjonijDlkqa7lWwtw65aO6fgJOvGjHCJCWM4WuJ8BVNxt7NON6
 mgp1yjFkSggKO6t2cIaTvnflxOXRZ7RXc0kDNEVNZpvyzh260+f74VPzj5xGPZdxzNtqGYK6N8
 SQAD4qdp1JOj9Xc3DSOp7rQ5XWkZXis9ZHlqIBms7hY3xg6ABe8lEYIqwOzyrLglFfSayqCcc4
 QrntPSOtoTQHc0GkZut5wzajmvqdEKeGC5FrLd1rtnPdcWMWBVUit8PoFc94axVMBAAA=
X-Change-ID: 20261022-jshekhar-dcp-hlos-c7c22b0ff7e4
To: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=16900;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=ZrA35rewL/liKPiVapL764mlCxI5Tw05AfRLImiCE2I=;
 b=xJhEbT2fOWRu5KKdKtwjDJniLGCu8brc9WdEYZ+f84riE5ipPFlWBZfZFut/r2UBjZwNNCnuO
 9/NHsnJFMIGDbOA/ELk7mh7rs3aqhjG7LCvwMfPoUnDnKuXBJ9iDMx9
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+EIkqv+WDc3J
 R0JzgsraeOWkAoctHTarGJ//z/MSyQPN+Cee5OAROoNRPl/TNN9TiBHZSXDfttZBvDuhlx1R9Yp
 oyGkSrO8SxiA2Wu/C8AjV7rL6qCJvNY=
X-Proofpoint-GUID: O8MGxp1jXmsTzXre0gEYb2VwtHdveOXn
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adef173 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=tVI0ZWmoAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8
 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8 a=tA7aZXjiAAAA:8 a=7CQSdrXTAAAA:8
 a=e5mUnYsNAAAA:8 a=tCT4u7A45XCoIME4sw8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=cvBusfyB2V15izCimMoJ:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: O8MGxp1jXmsTzXre0gEYb2VwtHdveOXn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX1WfJQhZPQu7N
 PNJIBVC/yF4Lb9/5QihY8C41luT6TDYJ+XEhhkz6c5K8ie2d9JdiXDjyCDZyClsM0eZDZTPQKKA
 da186ykpktwDpAa23p9uE1C4DRwl5k8peQpZyC8LPMTH8t3SQ6h2lkcI4047sQI6VGts005xTHX
 TYB4U6SyGkqgvhvtG8Rgy7/TlrQUlx4ajFonwaV/IA/uNvKSw7ETahfH1S3suuM1sXFejiipkDY
 +VPed3mrWHctfKMg19L9bMkwebhfXOv2ik+hghIsJLT9hZoRxqhI4ZFKJXNM6AfdI7FWpknQVdy
 ZyRyYjFhTbIH2LDjN8ujXGJ/7uK/Q4nW42Jx0fZZKmz+Z6I3zFhvDaQ20IAkCWfD6t6exHsqyWN
 ZyWM5S9OO+iv9AAM3zsJskpDbIfDIbvbfHNc4pMYOLxZd53CUTnG812Le/WWsIJOdnL6Gq8WzDL
 y3Doh+azdMo/SwhPi7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025

On Qualcomm platforms using the Display Co-Processor (DCP), the display
hardware is owned and programmed by firmware. Linux does not access the
display controller, DSI controller, DSI PHY, display clocks, or other
display pipeline registers.

The display pipeline must nevertheless be exposed through the DRM/KMS
interfaces so userspace can perform modesetting, framebuffer updates,
panel control, and page flips.

This series adds a DCP KMS backend to MSM DRM. It represents the
firmware-owned display pipeline and translates DRM operations into HFI
commands.

DCP communicates with Linux over VirtIO and uses the HFI protocol for
command and response handling, capability discovery, and display events.

This series adds:

- Device-tree bindings for the Qualcomm DCP VirtIO transport wrapper,
  firmware-visible IOVA ranges, separate transport and framebuffer IOMMU
  contexts, IPCC power notification, interrupts, and the external DSI
  display graph.

- HFI protocol definitions and packet helpers for capability discovery,
  modesetting, plane and CRTC configuration, DSI, and panel control.

- A Qualcomm DCP transport wrapper which initializes the IPCC channel,
  sends the required power notification, and registers the DCP VirtIO
  device directly. The wrapper also implements the MMIO transport and
  keeps VirtIO queue activity ordered with DCP power transitions.

- VirtIO command and response queues. HFI command, response, and
  capability buffers are allocated through the DMA API in the address
  space visible to DCP firmware.

- Synchronous command tracking, asynchronous response dispatch, timeout
  handling, and queue teardown synchronization for safe device removal.

- Capability discovery for displays, CRTCs, mixers, VIG and DMA pipes,
  DSI interfaces, and panel resources.

- DRM planes and CRTCs using the standard atomic-state model. DRM state is
  translated into HFI properties for layer configuration, mixer limits,
  bandwidth and clock properties, frame sequencing, and triggering.

- An MSM KMS backend, DCP encoder, and DSI bridge. The backend reuses the
  existing MSM DRM device, GEM and framebuffer handling, atomic commit
  infrastructure, encoder, bridge, and connector support.

- Asynchronous VSYNC, frame-scan completion, and error events propagated to
  DRM for vblank and page-flip completion.

- IPCC power notifications to wake DCP firmware and coordinate HFI queue
  activity across firmware power transitions.

DCP is integrated as an MSM KMS backend rather than a separate DRM device.
This preserves the userspace-visible MSM DRM device and allows Linux to
retain normal DRM/KMS semantics while display hardware remains owned by
firmware.

The initial implementation supports the DSI output described below and
uses resources reported by firmware. Split-pipe, multirect, cursor-pipe,
partial-update, DisplayPort, and writeback support are deferred.

Tested on the Qualcomm Hawi MTP with an NT37801 DSC command-mode panel:

- Display console at 1440x3200.
- Panel initialization and DCS transfers complete successfully.

Device Tree Topology
====================

  qcom,dcp-virtio
  ├── transport IOMMU context
  ├── firmware-visible iommu-ranges
  ├── VirtIO and power-notify interrupts
  ├── dcp-power-tx mailbox
  └── dcp-subsystem
      ├── compatible = "virtio,device34"
      ├── framebuffer IOMMU context
      ├── port@0
      │   └── endpoint ─────────────── panel endpoint
      └── dsi@0
          └── panel@0

The DCP INTF endpoint connects directly to the panel endpoint. Firmware
internal paths, including the INTF-to-DSI connection, are not described in
the device tree.

Runtime Architecture
====================

  Linux DRM/KMS
  └── DCP MSM KMS backend
      ├── planes, CRTCs, encoder, connector, and DSI bridge
      └── DRM atomic state and commit handling
                  │
                  ▼
      DCP VirtIO function driver
                  │
                  ▼
              VirtIO core
                  │
                  ▼
      qcom,dcp-virtio transport wrapper
      ├── IPCC initialization and power notification
      ├── MMIO register access
      ├── VirtIO queue setup and interrupt handling
      ├── VirtIO device registration
      └── suspend/resume power sequencing
                  │
                  ▼
              DCP firmware
              ├── HFI command and response handling
              ├── display pipeline and VIG/DMA pipes
              ├── DSI PHY and controller
              └── display clocks and resource handling

Probe and Initialization Order
=============================

  qcom,dcp-virtio platform probe
                  │
                  ▼
  Initialize IPCC and send the DCP power notification
                  │
                  ▼
  Access VirtIO MMIO registers and register the virtio_device
                  │
                  ▼
  VirtIO core matches the DCP function driver
                  │
                  ▼
  Initialize HFI and create command/response virtqueues
                  │
                  ▼
  Send DEVICE_INIT and discover firmware capabilities
                  │
                  ▼
  Register the MSM DRM/KMS backend

The transport must complete IPCC initialization and power notification
before it accesses the VirtIO MMIO registers. The DCP function driver is
matched only after the transport registers the virtio_device.

Dependencies
============

- The VPU IOMMU series provides the IOVA handling required by the DCP
  VirtIO transport. The Hawi DT series provides the platform nodes and
  IOMMU descriptions consumed by this series.

  https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

- The QPSFI VirtIO device ID used by the DCP transport is proposed in the
  following virtio-comment discussion:

  https://lore.kernel.org/virtio-comment/20261021180031.7175-1-peter.hilber@oss.qualcomm.com/T/#u

  This series adds the corresponding device ID to
  include/uapi/linux/virtio_ids.h and uses it to bind the DCP VirtIO function
  driver.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
Changes in v2:
  - Compared with v1, the series is split into smaller patches. (Dmitry)
  - Reworked the VirtIO transport integration so the Qualcomm
    `qcom,dcp-virtio` wrapper performs the required IPCC power
    notification before accessing the VirtIO MMIO registers and
    registering the virtio_device. The transport registers the device
    directly.
  - Reworked the DT topology so the DCP INTF output connects directly to
    the panel endpoint. The firmware-internal INTF-to-DSI path is no
    described in DT. (Dmitry)
  - Updated the DCP VirtIO binding to document the Qualcomm VirtIO
    transport and VirtIO MMIO register layout, Qualcomm power-notify
    interrupt, IOMMU contexts, mailbox, and firmware-visible IOVA
    range. (Dmitry)
  - Removed the interrupt-names property and used the defined interrupt
    ordering for the VirtIO and power-notify interrupts. (Dmitry)
  - Added panel bridge and component integration so panel bridges are
    resolved through the DCP DSI host before DRM registration. (Dmitry)
  - Tracked CRTCs using firmware display IDs instead of DRM CRTC
    iteration order. (Dmitry)
  - Moved DSI DCS-buffer mapping into KMS hardware initialization,
    after the IOMMU VM became available, with rollback unmapping on
    failure and before VM teardown.
  - Reworked IPCC resource handling to use managed IRQ and mailbox
    cleanup. (Dmitry)
  - Moved IRQ-wake handling to the suspend and resume paths. (Dmitry)
  - Removed the ipcc_valid state and made IPCC initialization and teardown
    follow the channel lifetime. (Dmitry)
  - Embedded the HFI capability cache and removed unused capability fields,
    feature flags, and callback state. (Dmitry)
  - Removed VirtIO config-change capability re-query handling because
    capabilities are consumed during initialization.
  - Removed the temporary self-component shim and registered DCP DSI hosts
    as components. (Dmitry)
  - Added optional GPU component matching for the display-only DCP DRM
    device. (Dmitry)
  - Made HFI packet-ID allocation atomic across wraparound using cmpxchg().
    (Dmitry)
  - Updated bandwidth aggregation to ignore invisible planes and planes
    without framebuffers. (Dmitry)
  - Moved DSI topology values into atomic bridge state while keeping static
    panel configuration separate from per-commit state. (Dmitry)
  - Removed the unused DP catalog and resource path. (Dmitry)
  - Removed unused HFI hotplug and error callback plumbing. (Dmitry)
  - Simplified HFI buffer release paths for callers already holding the
    command lock. (Dmitry)
  - Exported the generic MSM GPU-component matching helper for the DCP
    backend.
  - Replaced deprecated DRM logging macros with DRM device logging helpers.
    (Dmitry)
  - Removed unused includes and fixed indentation, naming, logging, and
    error-handling issues. (Dmitry)
  - Removed status in DT bindings and commit subject. (Krzysztof)
  - Documented the DSI host DT ABI: DSI hosts use the generic dsi@N node
    naming convention, and their reg properties identify the corresponding
    DCP output index. (Krzysztof)
  - Fixed the Assisted-by trailer order. (Dmitry, Krzysztof)

- Link to v1: https://patch.msgid.link/20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowangio@gmail.com>
To: Eugenio Pérez <eperezma@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Christian König <christian.koenig@amd.com>
To: Philipp Stanner <phasta@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Flemin Jose <flemin.jose@oss.qualcomm.com>
To: Mahadevan P <mahap@oss.qualcomm.com>
To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowangio@gmail.com>
To: Eugenio Pérez <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: iommu@lists.linux.dev

---
Jayant Shekhar (23):
      dt-bindings: display: msm: Add Qualcomm DCP
      drm/msm/dcp: Add HFI packet helpers
      drm/msm/dcp: Add HFI device definitions
      drm/msm/dcp: Add HFI display definitions
      drm/msm/dcp: Add HFI panel definitions
      drm/msm/dcp: Add HFI VirtIO transport
      drm/msm/dcp: Handle asynchronous HFI responses
      drm/msm/dcp: Add IPCC power notifications
      drm/msm/dcp: Add generic HFI display commands
      drm/msm/dcp: Add HFI DSI and panel commands
      drm/msm/dcp: Add DCP CRTCs and shared plane state
      drm/msm/dcp: Add DCP planes
      drm/msm/dcp: Route HFI display events
      drm/msm/dcp: Add DCP encoder
      drm/msm/dcp: Add DCP DSI host and panel support
      drm/msm/dcp: Integrate the DSI bridge with KMS
      drm/msm/dcp: Register DCP display pipeline
      virtio: Add Qualcomm Platform Services Firmware Interface ID
      drm/msm/dcp: Add Qualcomm VirtIO transport wrapper
      drm/msm/dcp: Add DCP VirtIO driver
      drm/msm: Support KMS backends without a display IRQ
      drm/msm: Register the DCP backend
      arm64: dts: qcom: hawi: Add DCP support

 .../bindings/display/msm/qcom,dcp-dsi.yaml         |   79 ++
 .../devicetree/bindings/display/msm/qcom,dcp.yaml  |  123 +++
 .../bindings/virtio/qcom,dcp-virtio.yaml           |  132 +++
 arch/arm64/boot/dts/qcom/hawi-mtp.dts              |  129 +++
 arch/arm64/boot/dts/qcom/hawi.dtsi                 |   40 +
 drivers/gpu/drm/msm/Kconfig                        |   25 +
 drivers/gpu/drm/msm/Makefile                       |   22 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c                 |  739 +++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_crtc.h                 |  104 ++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c              |  686 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h              |   59 +
 drivers/gpu/drm/msm/dcp/dcp_drv.c                  |  191 ++++
 drivers/gpu/drm/msm/dcp/dcp_drv.h                  |   46 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c           | 1110 +++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h           |   76 ++
 drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h            |   94 ++
 drivers/gpu/drm/msm/dcp/dcp_encoder.c              |   29 +
 drivers/gpu/drm/msm/dcp/dcp_encoder.h              |   16 +
 drivers/gpu/drm/msm/dcp/dcp_hfi.h                  |  275 +++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c             | 1155 ++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_crtc.c             |  191 ++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c              |  252 +++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c        |  592 ++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_encoder.c          |   64 ++
 drivers/gpu/drm/msm/dcp/dcp_hfi_kms.c              |  366 +++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_plane.c            |   63 ++
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h             |   48 +
 drivers/gpu/drm/msm/dcp/dcp_ipcc.c                 |  173 +++
 drivers/gpu/drm/msm/dcp/dcp_ipcc.h                 |   42 +
 drivers/gpu/drm/msm/dcp/dcp_plane.c                | 1056 ++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_plane.h                |   36 +
 drivers/gpu/drm/msm/dcp/dcp_plane_state.h          |   37 +
 drivers/gpu/drm/msm/dcp/dcp_virtio.c               |  258 +++++
 drivers/gpu/drm/msm/dcp/dcp_virtio.h               |   25 +
 drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c     |  643 +++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h  |   78 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h |  105 ++
 .../drm/msm/dcp/hfi/hfi_commands_display_events.h  |   90 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h   |   27 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h      |  182 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h      |   61 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h     |  464 ++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h   |  247 +++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h       |  287 +++++
 .../gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h   |   79 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c           |  106 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h           |   65 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h           |   76 ++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_device.h    |  102 ++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_display.h   |  480 ++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h |  198 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c         |  157 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h         |   77 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c            |   62 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h            |   56 +
 drivers/gpu/drm/msm/msm_drv.c                      |    8 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   10 +
 drivers/gpu/drm/msm/msm_kms.c                      |    2 +-
 include/uapi/linux/virtio_ids.h                    |    1 +
 59 files changed, 11992 insertions(+), 4 deletions(-)
---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261022-jshekhar-dcp-hlos-c7c22b0ff7e4
prerequisite-patch-id: eecfd66a55b8f2b7b2fc7d76d815facca0489d00

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>


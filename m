Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674255;
	b=BnNXi17/LcRhjeuoWvub1xmz8fsQ2Fz3rBP9hPYQGrJyNcL1rGrDC7Ly3K0HKArVUw3a
	 9G1M2tGLmXIZVZUA5Jre+h1ZGFZlqo8ZB8TSir4P+5eVxeCL/m9ZMTMbNun8uHI6B5yJH
	 aIuM51Mus6lObynVUOE9IIAmRiZ77v5dU3qr9kU5vz7ASJls6z8RrgOYai+fpE+ry0G1o
	 3aa1opW3MlacE2uCYyjxkVgZUwnLCgkV0XaH0PiG/wkrCj6OJJf3nHp03c4DD/x45O5Il
	 7/sdbmYpTY7zznogvaV1jk5qZsfivJE/U1/v6KQuGlsBIVcFxecoTW2GDWmf3Cc2TFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674255;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J3FBGIzfOGOLbBdoGHFxpDy25ir6Jn1t+scYA8xvL70=;
	b=IPjLnkBgX6qLuB1R2sAPWReuUlKxXjtIQ6ZQIg9xPLXUsvz0PhwWahPjTFK/AbJTSpse
	 odwrvCOonbnp/vNlbv3U2Xg5K/tkcM/gJ0sNO4PA926Cn0OGPKbYj5r4lEnlTuXPOT0Lf
	 WIn6ug+RZqG9vm16QZsjSuJCCWZFuR/QC1DKPkrGvveym9qm1Ou+3PIs1mZGtHrvqW4b1
	 i3YL5EanQ7NKLb8BKuL/qMT0lJACN+rQcZczGPr32vXZ9cqbtLB+KUxmUk81wmM6xo/Rc
	 P5w9E0ZlDgzunyrehIDuHmBQYHibr/dqx1F5UjkILC8UYxZeSryEJweJRbOWnaSdIRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R3v5v5tj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MaAAAA2R;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9636606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9636606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R3v5v5tj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MaAAAA2R
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36ID8393975
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J3FBGIzfOGOLbBdoGHFxpD
	y25ir6Jn1t+scYA8xvL70=; b=R3v5v5tjqe4wnKtTeumbsYVbqMrltzRzTcrzpA
	afhHsUTGENeThsYZH511lG5ssq40p0NvxuaL4hckafW9AabmvGW5L6C6hW1O6OFp
	Tai2alPotDak1XOlM6SW9oIGlmnounDy3RjHI9OGVzS34/VnQuJ/0LJY4Dkd1Hoy
	Q5CJ8273MB4ufGX6uEaQnMuYWPNA5OGYHrwG6MfxfN3U1BcIHF80bGMbZOwSBck7
	cFEthAocvQ3LT6lS9b/RQ7eWopqINA0x9SV+zyS6HRVs0wM9aUp2nnDS0g1aCI/I
	31b/GMhuiTXUVzJB0emfnrxxVBU3dLg0vB7e9wGrEZA9O1Iw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y1pn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3fc6a0083so5727140a91.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 22:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795674253; x=1796279053; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J3FBGIzfOGOLbBdoGHFxpDy25ir6Jn1t+scYA8xvL70=;
        b=MaAAAA2RMOxhEZGANryI2/Y09RXdxFsE8dt09ln9H4IEONsFfGwUmYCKLdb7h696u1
         rZTtYb7orxy7nHRdY7lQ9EMfaDFyu6DRuM8z94Webg8iuAghZTYgrSTttz6nTsKyf7mb
         poXW6rAoB4t6hGEO8gqtBrhH7psPrbcjZC83EJR+S7HobwRDKjsoCsgqMHSj3YQOJM1Z
         K0QiBs34G0anhSynREbzzazbioBUqbAynfzLLFCuEWL9XMW/HtsCb+QOiTscPMI0+keL
         0xJj06a4o2GlI0jywuH887rdSYQLDbk0/cI+FLOwlLRT8jI3Rb1R7oQoPdTFaFiahOwN
         s98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674253; x=1796279053;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J3FBGIzfOGOLbBdoGHFxpDy25ir6Jn1t+scYA8xvL70=;
        b=cQVEntjzQsqYvkw4lB46DQrcvieQ33t8lxpUynMDTRnAPVCYpMlJBUbzNVurxEdBSD
         90TOD6ERyoVEOSJj1Gm4s3O8GSiNfxCN3G7w34m5PPTq6KiMotKafIgCxJEpiBUoFIWd
         epgtkwjj6cGribcxaJ5NsQ+VZZvwGzb5xEsmf8in7nVMIfhDQWf+bpFJS3wF/WVHypKq
         dTYkjYccwNyjFyGp4XdINHwPEGG4apxN8dlPRfn2KS6tgPrjv8wsNO28RJLCe4BidoKc
         7FLymSf6FvRO5r6XCHo87lrvn4bQAciXr3bHVkhUuz+eljCLznaDZ+9b13U64FTVQTGY
         r05g==
X-Forwarded-Encrypted: i=1; AL+hErHE73EiVhVEyShI7LKlZraQMMgog3VTf9Jg6Tli1odHlu0YCPvqlbeZ1lq05/RRJHXelR1YatP8Dwvzb40rRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ZKweppZJZ8oZL1flYz2N2Pym842+2I9uQDDNS6ffwS3lBLwky
	8t4cZ1FP0BiO7PzRziYcjl5oOcMsn/XeynTUG4BqesWs1r80SP5m7I8nECyLjjwdDc/h1zIk4uE
	c2y+pZHEC4NMzLkYDctCl7XZxDL6U+c0cN9VbGQzOTf8yNnvFvWCQJOyYo/IHW2IpWrfTPA==
X-Gm-Gg: AZFdTZcAn+6GLy3cbxgNfAMvGMoMd+wl+TxM8EogY7zqfre8RM6ZpHEu00CHuL7we7n
	5l+Nnu3h6mrpjcheBepdhVlAA00H6iaBA/72u3DuwtPqjEl625z5nysgiih0hvTRxKdteA+wr/O
	LPvyYKeMoR/FUgrpBUP/Tii9liEut4rtYQUPYrMjcrBmKfvBTx1j6afA76yaQsou8Wu0gDXKhqc
	bOka4MOGynFAdiwC6MwfxKqjrYSFUfl36QvnraqI7/gmey5GwSguQQXWrmZ598GDXzQpF1cvfEn
	iSBkZmMFtHHJ8RtaWV4xmRmiuJvruCvdyJXu49VjpK/qRqScUnlUmxtrorgXhQukO4UlfZwfOSV
	sXtUgHC6vXnoRr5ZEsJhMyJVthOWQpa9CNq3W9tTwUnvHaDdKzdEnqWz8CalifuVZ1DRQetl8Xs
	hAQkt8mftP
X-Received: by 2002:a17:90b:4a88:b0:3b5:29e:11b0 with SMTP id 98e67ed59e1d1-3b5029e14a7mr2682259a91.17.1795674253168;
        Wed, 25 Nov 2026 22:24:13 -0800 (PST)
X-Received: by 2002:a17:90b:4a88:b0:3b5:29e:11b0 with SMTP id 98e67ed59e1d1-3b5029e14a7mr2682228a91.17.1795674252625;
        Wed, 25 Nov 2026 22:24:12 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fc28asm14988015a91.1.2026.11.25.22.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:24:12 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH 0/3] virtio: Add Qualcomm Display Co-Processor transport
 wrapper
Date: Thu, 26 Nov 2026 11:53:58 +0530
Message-Id: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7QB2sC/y2Py44CIRBFf6XDekh4Q/evTFwUUEzjRLsFNJMY/
 91SZ3mSe8+turOOrWJny3RnDW+11+1MIL8mllY4/yCvmZgpoZyUUvFjX/F3hcYvaTvxW22jbjy
 nnaOz2gmDwmJgVN8blvr3Vn8fPtyv8YhpvHz/iYaXK22OT4ztMNJKi8uEmEp2DqyNoajooyrJZ
 +9ykLZASiBMmLMQL0+EjpyuOdWxTLPRXhg3W02VqGMhg3Y2KGMFAn3hcwkKPDs8Hk/skXqM/gA
 AAA==
X-Change-ID: 20261112-jshekhar-qcom-virtio-dcp-e653604e05e8
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674248; l=3104;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=37r9rIxqHsKolBFf8U18UhY2X4076xQVrB7nUGywNIQ=;
 b=KQaJXbaSnHDbFp/1HrQy/viThm1OlwRqbbQpwKFWwWbOVXVb4WpBN5XczmAjE7FdhCT4INfWm
 oEqXMxcz8SxAzijjhMCbS+sCa7wckax1dnCUftOYQACRytxFAKNEVjS
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXzd34oWy4cXBR
 0ORd1SsXoHrx81oa5npNlGtXMO/rRHP2CDnLN/S0dZb00vqlTeUOtN8d9ir1Je33vXQQJPTb703
 Zzry+ierEhBwBtgxgmsuYrrzXGwsM/EbaquuvYFrj4dlo5MZ49wMP3d/Z+YauEIbfO4a7yFH4Lm
 Tk749X8kKk0lpbCmloHxVlyzealLVol/W7Ag90XqWslOLMfdNGS4DKVvXXcOEevgGfs3UNjAxNH
 kbRHakjinQ6g0+8zeDpqhq3WRwtbg4kyvtFrNaX/28nJ9EtxEdYdhp++o0TfdYgrRAtApzKaqQc
 f7rRUA3NXJmxpfVyXmb/DrLEQ8KarAfTsiWCCDR2YE2Zw3w9wxLAJ+DYHCiMbfZDrk+LMDCytPW
 rx5GUhEmSShh+KOygd1aFVpD3OyxtZbeHztrb/nTYh7w1kIboxUEuxyPpZQrNmetRTVzcGHOkZ7
 35PAG8U5QNc+V+lmW1g==
X-Proofpoint-GUID: 8NbeMZRKkeDdN-9eerACDLtbrWE7D1eU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXxWpddty+2I2H
 T0guRSVrVf1A6Mt4Gd7YNhQVXaMIN/1sf5LyCZlSAsicu/dCdKfCwrkaMZlsxS/iYvYmxYAupU4
 KwipGE9QNlmnlYX5lLWM+WJHfqmrcQc=
X-Proofpoint-ORIG-GUID: 8NbeMZRKkeDdN-9eerACDLtbrWE7D1eU
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07d08d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wU4vZm6J2YNF-1Yk8TkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024

The Qualcomm Display Co-Processor (DCP) firmware exposes its services
through a VirtIO function, but its MMIO registers must not be accessed
until the host sends an IPCC power-notify message and receives the
firmware acknowledgement. The generic virtio-mmio transport probes the
registers directly, so it cannot provide this required ordering or
coordinate the power handshake with system suspend and resume.

Add a Qualcomm platform transport that completes the IPCC handshake
before accessing the MMIO registers and registering the VirtIO device.
It reuses the standard virtio-mmio configuration and virtqueue
operations, while routing firmware notifications to the response queue
and ordering VirtIO freeze and restore around DCP power notifications.

The series adds a Device Tree binding for the transport resources, the
generic VIRTIO_ID_VENDOR device ID (proposed value 52), and the transport
and IPCC implementation. The transport handles device discovery, MMIO,
DMA, interrupts, queues, and power sequencing; display protocols and DRM
remain in the separate function driver.

The proposed VIRTIO_ID_VENDOR value 52 remains subject to VirtIO TC
allocation.

Dependencies
============

- The VPU IOMMU series provides the IOVA handling required by the DCP
  VirtIO transport. The Hawi DT series provides the platform nodes and
  IOMMU descriptions consumed by this series.

  https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

- The generic vendor-specific VirtIO device ID is being discussed with the
  VirtIO TC:
  https://lore.kernel.org/all/20261022091645-mutt-send-email-mst@kernel.org/

  This series uses the proposed VIRTIO_ID_VENDOR value 52, which must not
  be merged until the VirtIO TC allocates the device ID. The corresponding
  DCP function driver must additionally match the Qualcomm vendor ID and
  the DT-described Qualcomm transport.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
Jayant Shekhar (3):
      dt-bindings: virtio: Add Qualcomm DCP transport
      virtio: Add vendor-specific device ID
      virtio: Add Qualcomm VirtIO transport wrapper

 .../bindings/virtio/qcom,dcp-virtio.yaml           | 147 +++++++++++
 drivers/virtio/Kconfig                             |  11 +
 drivers/virtio/Makefile                            |   2 +
 drivers/virtio/virtio_mmio.c                       |  17 +-
 drivers/virtio/virtio_mmio.h                       |  21 ++
 drivers/virtio/virtio_qcom_dcp.c                   | 273 +++++++++++++++++++++
 drivers/virtio/virtio_qcom_dcp_ipcc.c              | 193 +++++++++++++++
 drivers/virtio/virtio_qcom_dcp_ipcc.h              |  41 ++++
 include/uapi/linux/virtio_ids.h                    |   1 +
 9 files changed, 692 insertions(+), 14 deletions(-)
---
base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
change-id: 20261112-jshekhar-qcom-virtio-dcp-e653604e05e8
prerequisite-patch-id: eecfd66a55b8f2b7b2fc7d76d815facca0489d00

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>


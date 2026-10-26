Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995926;
	b=ckdmaoKXaggJU93v+VveFo/AE/7HeHEzqf6jF/5yTbvdQ/AD2DUXNZ1Fszk9LVyZ6ghy
	 sPyNAY7Hdpr0aXF1IE1UAle/Rcop+gn1NIFGRQ0zQAUp3J5W1WvjenBndIvZORM/fHx3F
	 asYazeq0i6MZaFQ1I3Z/a9zxTFEgyKDvZyxReJl6E7FPQQSAEiHTiRY7N020ZOtrA7J2N
	 y/6+xREdIUWJULLPlbtxWrxD1Vxi129HXLjUAI50yTD5gH8+J1JTCwL4jQWoZqeIstHPQ
	 tGYJo9MtZRgW/ITaYr0as9Wh4nQZmWZp7QEcwmAmZWnDSaKQhKIzDPlpcnKw21/ZVqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
	b=n9aqXlRIlN77XJIc5CbQewjyTRBlFfFRTdnIC1cT5hazn7vhr53R0onyR154ntGYO9Hx
	 VWGqoN3z2Ugjyia5bhQlqYE08FyP2AV9KIMZQFriN3HVWXrIQ9/MVa4SB0kpXnX5ivGUZ
	 3yTLLooIh0gHpsTOc0NP4S+R8NnamU/AmG1wgEqp4cGR/Dg5aqpI5oidJ5E4wwDKMsngp
	 AsU7aeBWHB70LJHoQSM42culMYGbjISCbM/hyXe/JqIjREG/sTxk0IZcqRRc/jTjuAvnm
	 kFye/xXY73czg07gy0tP2JcxHQBjZE7QBLVvccjdhXANMA2zu7gN+nniohF2AZau1aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mdi22M0D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlDvUsx1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36341606A320
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36341606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mdi22M0D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlDvUsx1
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4auRO2255131
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=; b=Mdi22M0D0/nX8L8+
	EgIDzXe9Pn4OtwYwlygs/rQOkwznYAJuyISW+R0zkTb09HRmG2w7+CB+dkJ9x3QR
	wROQ2NmY8nxl7d1yrZMAVqeWJtn+OzG0IczwEdfpNHwmuBl4EE+59e38mNe1lefK
	7G4heGBp4GKNN6l0SWxwhsd8B6tw59IiSHlRmZJwi2ajbD0Akb8X0fn6z97ssX0z
	/TOvU/98EJugFgGmR2ANrhqnvA8CA/ikTJl44fYLf2376Z6U8u+/5Ffdx/aQj1RH
	t6H72W7/4ug8+6iR81IVbR/hg9yJ/+ZD4skdctIaqJqMX9rPHhQssTIQZ59oT6XI
	YIo3KQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3n1gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso4152916a91.0
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995925; x=1793600725; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
        b=jlDvUsx1nZW2W36XYaVdWysz5uigqoUlJZLQATYWlq+JdX5Cj8VCv1ykLZVUQEsDl9
         HTXRmEddAx9CIm2alndnPNC0H9d62hrlLoaLcGg1no/RbpVqzRAuckcNk5XpLqnlpaU/
         EGIDAM3dT9AFTM2SlQlr7pR0HTVqWGtGUnHAwb7gM3/iOJxxm3XKGzjMt4aXWJlpco1f
         Wbi7PacVhdF4azJHxdYwu6K07oZtf6AP0H5e2hr6pav4nJe+gUKumyHCi6UhcZovFOf1
         6oCk2Kym2tTMOzU4QgexY04VUDD8/WqWRahyzXaMwc4uZc3F+ugJiNZg3wr7GRkR9Hud
         xfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995925; x=1793600725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckUCQc8xGlckkBfhDS4Z+p+cNno0WawXomSygH6j/Zs=;
        b=AduMwx9nZNokW6xYEwQwkGwwFQOH2CQUPXfmZ2ZWJVQwA4XrbfVJS8KGN4Dikg6JOs
         chMn7UI9Vkzb0JqIUofuVOo71Y/54QMF5jCAbz2RAxZVX1dLaMGZ1hlzqoWx9TobtlOX
         xE4cAKGyOP86DQLvqaX2TfsErCjDiqIN//MLHUrRW5+1Wf58z5WKrc5CBGogx4Jb5I+Y
         PUeVy2otBSLZoYf408l5i8kl/C4BNV82lIIZ3iE7qKPfHYypvE7f47IQMvJ9dfrPLb2s
         37bSswJHWlfaRO/sSl1jTuwwDy2mbxEkiXPgUDEm472/RhujCELxRAPAikuCZq7iD1cp
         8vCw==
X-Forwarded-Encrypted: i=1; AKwUvBw9qlV7z47I6QXFMKGRg7972LQ0l4oVG1H+HML/Piv8HlAjLNUyz+hrdYR7ktBiHdo+j1avMBB5hG8A0dQZ6A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJIMhCI7KNmqYBFSxo1yDPet1lreeZf7XMusxWeO8ENzDfs18hT
	QAmkILPufkdusHSQFB1rHUwBBSv2UuF+Y+ZXd1xbWuNod8YuTh6S698aOAsVm3CDKq/wPh7Xz2J
	SUNKMb7YAHdufyCdO84FE9kqXwQFjLduDzx6LTjiTsM+sFq1aSOtasHu8LmjzYchg3TXNqw==
X-Gm-Gg: AYBFou0fNoXH90NduHgVRJnA0/nJJWH0uIHONgCHTwq7tpmn7e3wOE2F5yz5j91IIeU
	ivRnSq4nHCfpRXdee1SSdFsQQVk9SooDWkWUcioDkrvx++WF3Qa13ImrH55m2bbT+mTvbpnSBic
	cSdjQniNePZjaK3NmSFmOCj7y9R+yFXHq+uC4OrSbcwYX5bTlHE+KNH+bydXski51XXRNu2JkEQ
	pl93AZUhiHMe1NK1lCmdcJmTagiPRcBQeUyZtumpHyppuiqzC/t38tRsB6lXpXMws2Txac4Ewkv
	u34ZR8unX6Rlqh1FonUGBew/o9etDkC6hB52K+w5NVfgDnSWJB+8z3noCTqM8E+UoeTieehMlbP
	/tOgchjmqzDIGk4FsciJm0gzlco4VQbA4nQ==
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3adeaf9620emr4744316a91.47.1792995924558;
        Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac5:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3adeaf9620emr4744280a91.47.1792995924114;
        Sun, 25 Oct 2026 23:25:24 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:23 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:31 +0530
Subject: [PATCH v2 21/23] drm/msm: Support KMS backends without a display
 IRQ
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1124;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DKmn9i1vJXXvP4IBsacfVZJPAx62TejKYArKw6N1S7c=;
 b=vcNZ0ngyibDuHfRXl+gMTdO0b/EpAD7rv0lv4FUaHdf/+mqY8ImRpBvwiZcSIeoQwYeo9vdXJ
 yc8Y5UbPo6uDgvAYRMfqwFRHOii6CxjBVS2R+enurNuUEuwobPHtCor
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: V3Y0t4hvXIstK0IcCPnraHdKaVT6hx2m
X-Proofpoint-ORIG-GUID: V3Y0t4hvXIstK0IcCPnraHdKaVT6hx2m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXz+abd53jAUyc
 b1l/eP1uAsGdDA7BJSg+ysaiLLT8JqlZL4iYm3M96AKacoB6p1desEeWRxw5bHF2eT7q64nTGjq
 GhR4jsGclo8kMHf/s/tzfgYeNqdIwSk=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adef255 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=g9RcmOnx5enkyd0xrYgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4qgW5HBjU7MX
 AONZDrmojdPpQ1OotNbIwA1eQPn6/pZRzSJ4wzDFlwrLs5P2WderIVP8JJXEh89B37Y9SPhXmkJ
 4GQfBSUrsz+nQROWEjesDBEDoMPqSLMmVlIV8KwFIgUfp9fV4Zqnq70v3TiWg26cVrLgGwI2/23
 RAWmFc2eSAgZuL4Ttivwe+Z8i0YseYHt6k0wEmDM7M0wN0ChzPggttUXb+/t53/VLBkn8s4L37l
 mrZNUBdSGmCj2g3Ew9dWsUNgIFKtZI48p2esBPdEY+TJKTsQhMKmcoMOmHF2zJZFgwYw84phYZP
 usS47C+mzTgHeEQgs3xMzsyQzypMI0HGYM/1vo/KDUAyufWry3SbFwVjJ6OKmkRjOIdJ1Jjybrr
 Gi+HPRTCRf/Gdl/R+u3HcVyZc1PGcIBQczB6GlUDLiDuisYYUxJTqfoiiRgvUXGZ+FoJQUNVGjP
 KEWPIqC2w5Q7ivWMu8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Some MSM KMS backends receive display events through firmware or
another transport and therefore have no host-visible display interrupt.
Rejecting such a backend during common KMS initialization prevents
it from using the MSM DRM framework.

Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
interrupt is reserved for power-notify acknowledgments. Existing
IRQ-backed KMS implementations retain their current request and
teardown flow.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..1870a7008ead 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -72,7 +72,7 @@ static int msm_irq_install(struct drm_device *dev, unsigned int irq)
 	int ret;
 
 	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
+		return 0;
 
 	msm_irq_preinstall(dev);
 

-- 
2.43.0


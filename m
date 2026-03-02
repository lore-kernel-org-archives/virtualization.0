Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8686360751
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450286; cv=none; b=f1JyTkNNwUciD2/8y7j1/R/H7qMjYMvtkRuAlZlcz+d+TTjY6nugNMnzvVHoGtAped6SdTzmv/0iGPAfCgybA7+PKri4CbYiqaArAmN8Te+VWi+6QR8T/LDUxRVbBwc2vC/NylU0BA8GxeV9HRUzn+oXmzl6LxAzj9Mt+G8FfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450286; c=relaxed/simple;
	bh=i+UV15jJM/3VZfIUJnkNiYYW3j3bD1XenewJK4VmUOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuCguV0VUvbs8EImHK0qTeR/vVpcKhuUIuw9m3HCkm+oRuUZ7rpIDlDNGlunnqqP3M8e3p8JikvrqmYGAJGmZCz88N+sL391HGOneU1SBbPBAO48OcJHP5N5kHJMScm9DLK4KYo9Gy3u2W9ttS+z7HIROwKrOm5/nXLIBRt8FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXlaX7Ic; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PW7fwMTm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXlaX7Ic";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PW7fwMTm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285X2c662204
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 11:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7WgQA1jpoOh
	hihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=; b=OXlaX7IcEv9APHHnKmMYUuQUDFA
	dKWGpNp0EtanOe+OSR4C3EYxt5xmd18VOm82+nzPneU5cVDU5amU7WRIeGnhD0NN
	Taegz79kCOXYDyCctx7BryTRv6sRtHgJRTCYLOzz/h4bRrKvOnyJfqgkIM8wbMOd
	+dWa7+vOWdLCz6MkOzzU11MmysNu/zhf7l5MdwC2aYlmokLQ625+3FbbixSg4HzQ
	EOHmXEpZleHs5GPVyi4CqJkJuH5hb7mz912pccWWZE2ucv2bMeZ4DGzz5N0Xz/Qs
	MQTVV2shZN6pxe+kh5ZVMXF9+PAFNdckKIJo3S5nLxGfaNydYRocuYrzs+g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2rrme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:18:04 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463c4133ccaso52942695b6e.2
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450283; x=1773055083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WgQA1jpoOhhihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=;
        b=PW7fwMTmGxTcL1BwQ7a0ubGwFi0nSSE418baH6ahH7gi8y0NhL/9oB6ZUSuc8Xtg5f
         dsudSSewBszrUlh6BGO4Co5/gMusVVQc1bSoCkvnzPcIs9SW9+m6cAjPW2xiHwsRJdK8
         CvreYZhcJ+yQf8cR6tvUsAyEK/U/OKjImSJilMM0rbxeHQytN5tweFA7wnVSdxKxhcCa
         3bQctJr6U2narG+YoGMbbnfv9uoifE56japoQh6cUZAHpOXsULPXV7XIB97uFtx8WiL/
         3n+6KUNHYI9prvU0pYNkv3wGV4v750PWOQsoT+4UJ3Ivp+/LGL0kVI5M3Qg4NGna5y3s
         UEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450283; x=1773055083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WgQA1jpoOhhihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=;
        b=sdxabARADs8njWOJjgGBD0xzXHGEK8wzB57ho5snXXZBITSDqnkRQqCNG9fmzrwg9n
         FTTtOQ8jbKJ896gmx6g6VXB/8/PmTBKtYzdXn5KALJCfnG1PDfr978Sb+C0Bv0qlX1V6
         CL4hI6eCpLl28I1aSI1GzouJongCGqESGl3kjG5qt6t+nv0i/2GNg9pdXgQY1FuqRsFp
         99yuBf6s4TmoYL+jc2LH7+xx1n/1M+m1jBg2k8c4iQlnF0HpPIRAD3Td2WovCHSZ/nMq
         At7+VPuw6nIYALYA+FjWybcSXogTLlXz7v5yWmCSORbywzGtYO2/N8qRHHEGM5DAzep4
         AEKA==
X-Forwarded-Encrypted: i=1; AJvYcCVOBYPWGDOuZ95/ZC9AgaSkEQJ4lmlKZsvPzle2KdDFZeU0pJF5qH6fK0DXMd5n30q6FVvMl/JuC27H6Evz2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGe53fXtA3EpBnm11u/u99LFcfh4t2KmKY8ePCC5P2oYD3acbi
	Ky5DWqF0PSOrzLvS/DDuFDEG6oG/dx5aiuKvHr1Gq+SI3hvl8mh+v1eBbFtpzgjMBVEzh05vtru
	yTVIdoeNZ+6LF5zQKUNQ66jHishNycs4YVN/RwpSwaE2Rz6GyAhKFvCFK2b2MuKnY8MoT7g==
X-Gm-Gg: ATEYQzwDpFjP9LGVYFn373bnvEAQDQwd9piD29/yYWR2nEtaMQ5GlxDxLIQWrD0rXM4
	bm+BES3vEeSFGlReZrL/6SvAxbULri7iBwlUuhIgH5rLy0GAWC3C8B1jI85McV6bHcWo/ZJqqOT
	ULkigOKuMdSD/PkhS3VSl6JhNx+q/bYykxlN+T15e60PjEBO2tOKw62oG0NMhU2IegxAvA0sNsf
	W0VkiEEAwTBlecsc1xhzZckG68TUW4ArbFLRdxKjHdqufW/yUtNDcuixLp/CQPmBT2+j3sPZJOw
	xgi+Gdj5QtsPXRt5c3R1X0u3Cd44yUQIywFu+hRuZkGTNla80KfsdFwLHoUPVGugKPrsoFVp4hu
	alPt5mwe5ry0g8gVTCIn/ZkllY2Wk68XhA2lf5aa/YJqDKayrQ+p4H0wd+5Ne7MW3Qhi2Oaxf1T
	C2lEwq
X-Received: by 2002:a05:6808:1396:b0:463:f9ad:a4cf with SMTP id 5614622812f47-464be9de029mr6940049b6e.23.1772450283517;
        Mon, 02 Mar 2026 03:18:03 -0800 (PST)
X-Received: by 2002:a05:6808:1396:b0:463:f9ad:a4cf with SMTP id 5614622812f47-464be9de029mr6940018b6e.23.1772450282960;
        Mon, 02 Mar 2026 03:18:02 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:02 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org,
        jasowang@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Subject: [PATCH v2 2/4] virtio_balloon: set unspecified page reporting order
Date: Mon,  2 Mar 2026 03:17:55 -0800
Message-Id: <20260302111757.2191056-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dK_DQWGsqq2Fq0etucU7e6sCPde26nSC
X-Proofpoint-ORIG-GUID: dK_DQWGsqq2Fq0etucU7e6sCPde26nSC
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a571ec cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfXxrlEcTAvJy1R
 I/e86yD88SiUoTHsFPqnrS/p3MmpV9LXVikwKLNTyx5wCk/UCHG1CBoaOKTenPdZhFD1jdFZxAb
 ArgCn+Mm/5oB6qVDUWhsEpqOITja/pYMnk9/7kDFY79TXt10akeEwmi1lU3EzrY6oannG4y9N0b
 fFBdo9UDHTwzDCHsybz5ZnqnF7MYLdBGo0djQ26V2wD44/no7l3WJ7n+7wCadwPNpndzbEOH40T
 QR3Dqb85wzOlNyaJWRVxSL8wLKn0NWP+xNp8X588IhveJEAi2Omy/UDOsR49ZTJHaOYGy6zQF4U
 VRGx6eosdqHY1RSWpfVg4W3N3YET7f89LKsOhN+TqBrUT5aIeMCSOGdWlIN+4StZt3UbM5LKUq0
 LJlFroVFONbOXdj4CB7nvlWr0OTbXBJqWBn+hblRHqhpp1En3CSRuVv8SangBhIu/2s+Gw+yvQx
 gRgYw7HUxOfCH4d2Gqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020093

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_ORDER_UNSPECIFIED fallback value.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..2dfe2bcd8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1


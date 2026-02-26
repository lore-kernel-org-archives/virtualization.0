Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8238E5C7
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089297; cv=none; b=iUJYYfX2jBNITlxrwBNxjnedO7jdjHRGufsD5sGK2mAvzesch/xXxHeO5U7A174ey3X0/aSeW4Aw92FtoloBdRu4gYtexnV1Z14Peo1jDqjQLVn0qoPmq95pkrIKOMkGeoTDCoK1H+PIfowxevjg5Ivp6A84XiKP9yVMIsFG2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089297; c=relaxed/simple;
	bh=lQHqTjYwySZ6Qu+mrO8hLuEcP32RUNFMW65aLqVKwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlTcuQ1wwpNikliNd3jZ2DDQKuUzPoAcBr51ivm+Z9z1Vll+LPGLeeFHs/+Ej0S0EXT9O6RY9fj4QZkTUmuwvHT+ZXpFVQK4nZ6+yREDqukIWiRJoXR8s3iP3evEbKh7XJqdqyOEi7N4WwgTWYzBvnOEsn4/+X7eQ1MQaDiNDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/VVUEmd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HN3ZOehy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/VVUEmd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HN3ZOehy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V7lq350086
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XvgXEmpB1r4
	WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=; b=Z/VVUEmdWf/8o6COLQb8aFCUwQX
	Dzc5c7cuUzkbwZJ/bMJdJAP0hzVO+oLJ3T/lW2HrM7WY/DA3IpQf/jj6phlJAsUF
	e1jW5k8BIpSAR97a7nDM8ZFmcTVCrck0xpuzStPxj8lMIroSxSr5OYgQH4vPUqxJ
	V38nO5fYQaNhqUDTTo69YZuHciN4aH0+7K/zQOpH8HNJQJDS8/NA0Yug1JOpMfJk
	eX1oC7YIfsDMJYFTCYWVpGcoCnCIHgns3VDujldX03WCjXJFxEZ5e6+PnCJocF1O
	7pxdYMJEptVZW0tV5ejFvRoEqNbEIMNsnMCGnJgpegAmY7H1O8FotCDV8ig==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa5w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:34 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c6ef1538so12672972eaf.3
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089294; x=1772694094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvgXEmpB1r4WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=;
        b=HN3ZOehyN3Saf3BpYRsNptGrqmk0MO4Wg98GoRDGxttCS9cjRSoe2y7k2FNhTCP2yT
         tmyMggfzMW5uQX4okNfmPVRJvOM5/ELDmt3gq4Kzh9Jdb2xCzqg4kC0biVPSz3TaI4y0
         jVw9Lw5x2bO9kw/4iJIR1MFdlpOTyBMomtuM5VlDP8wzXmDDTey40b5fz8ReNurIPtPw
         I7EdIw+S/rEd+gFbz6wFvodyFs+2OeJDzejOMCi9lCcaGVSNQ31rXpGqekH3tZa59xPo
         ZsUnahKNVy/WFWnJOd5ZSXxOdy5rI57URA10fxGIkfoFzMMPeXVqXDjtUWhbXXE1HZ89
         fhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089294; x=1772694094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XvgXEmpB1r4WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=;
        b=YE4ZydHvYM5Zd8tCtaAQ4VljSTqhZrpT7XAKbrC0OYYTiXHAGD4Bf4p9S0hAiUe9xA
         1lOEfTm7yYKnfPqN4r9g6UeNYRVZ7ubWxGk53NHYQe8bAHp4qKN3vph4JJpBTfkbtYb4
         zIERXcihZO+PNVyoIkIxa5Hx9ZLqLfqcwmzR7thJd8vtxMTV0zMd/fOU2XAHkvf9b9NL
         jHrf9poUOYRiF2AOs34tPhJfey+OAE9FHPG0ObQbUV9R1CMtlfYE7ljRKXE6417cjlJ8
         OU59UC/vUC81gsmChpBssYJCgQHrIbbaGHrxifukT2kU4ZkrTGK65ieeb1M/TN1IALDZ
         aNZw==
X-Forwarded-Encrypted: i=1; AJvYcCVK0gC1+JMwZ6L3OmZC4i5Hja/xQjwP2s0hO0Bz1HGy4PtIU9vgFPZ/G3oCYXkqdt8kiZ072h5JkKDb6unWpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuO9GMjeCItEAutBkarCaJ8QX6AB+Nn0klAinO9r3Fuw6Bsc2e
	M1rMg5284za4N3WgPQ89G9kaZHuVZgLvzPER/4wlGyIoefqq2dH3gg/oGtZOeonScH7vg0gmy30
	WpKpPaXkG4tdy6xf8mFkI8CBROid2sJBph+o6TtBRkBcjCIHDxu2R1WgHNeEEkCxHyLRKKg==
X-Gm-Gg: ATEYQzzD+dWM1WUKBojLbYIjoHQrCUjKXl/KdEsLGJPIi2jJIFILJ/ZdR0dIUt8YPcN
	hC1jEPHm04VmmvXOUSDkXH/ShvkxMfhUVpS6MSiv1iCTZMa4nDS70IZm23Ro/HDPnKfmwmCP1xf
	dqFtY3+zd2JgCpbqZ+HjsyVxHrQFBAphpuv8UBzIwvRemAt6/X2wveq5kTKEclx7vWTHrSqGiI7
	khj+Ma9wMow4BceHy/Cd+JfIMFx/weB/C8HdjlO6uTPuCjop8wAwq21MOAr3P7oDRY7NhuDLPCA
	Oli5ub+8LQUqzXY8zcNB2jYzragt/oyk12u4Sk924QDYWVoJL2uS9Q0acsd1tqxkK/Yu5j2r2OA
	U445+uWgCI/SJkDC4oj3tzdz80RBzHc/ew1D9oQBPE7ELnIvCnXgOjtrJJyzO92eInhGOE3JvWN
	bc5FkF
X-Received: by 2002:a4a:edcb:0:b0:678:a4f1:c396 with SMTP id 006d021491bc7-679c449b538mr9081259eaf.30.1772089293994;
        Wed, 25 Feb 2026 23:01:33 -0800 (PST)
X-Received: by 2002:a4a:edcb:0:b0:678:a4f1:c396 with SMTP id 006d021491bc7-679c449b538mr9081248eaf.30.1772089293586;
        Wed, 25 Feb 2026 23:01:33 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:32 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] virtio_balloon: Set pr_dev.order to new default
Date: Wed, 25 Feb 2026 23:01:25 -0800
Message-Id: <20260226070125.3732265-4-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX/GwUm9LUc/cF
 9coUxzOuwjNLpiHZU7TKlM72XKzvfsFQEs8ZviVztv67libbcwnbF0/4xrhaal+YBwICOEHmdtA
 zGRz2IL8b/WTr596N5AHejctl8I/+XWLtY1t29CK4neN3TmFObyHaqni11kLxhGDFtTb5DSVuE7
 iYcm9qK4o7szsFVjKwU3wx6jYealMCnam+sU/y5mlgTsPeGoo0jF4XWns9PmLYTrzGu8a87reM0
 hFJWDhrOOIEgYplCteg4TgGJ64OjUTXqVloG8F3k3KrSzXKMRhBUAP0zzEX/rCxPejkcx2wcbsf
 vLrPappbWCLFszVLk67WjSORFrR11Cvv7v+xJb8wBtAKJgSf44VxpF6+CQPxydW3I/ndrsM4bDT
 6Fqyl/HtCANQAfOzCkLFZIJCByYDFALDqFvfvrEenuQl93zmRoKFSrB8tINMnrVfkSvOANEu9Yl
 6Is17hyO1yf4hSX6s4g==
X-Proofpoint-GUID: t7ZkGbg7bmGSxu5goXlxqJdJfwYMn3Kl
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fefce cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ORiy2k6iMmxUqhiy1H0A:9 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: t7ZkGbg7bmGSxu5goXlxqJdJfwYMn3Kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061

Drivers registering with page reporting used zero
as a way to signal page_reporting_order to be set
as a default value (either passed as a param or
MAX_PAGE_ORDER).

Since page_reporting_order can now have zero as
valid order, default fallback value send by drivers
to page reporting is now -1.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..3cc3dc28a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		/*
+		 * page_reporting_register() takes the order either
+		 * from the driver or the commandline. If neither
+		 * are provided, it falls back to MAX_PAGE_ORDER.
+		 *
+		 * Order given by the driver is required to be in the
+		 * range [0, MAX_PAGE_ORDER].
+		 *
+		 * One way for the driver to not provide any order
+		 * is by setting it to -1.
+		 */
+
+		vb->pr_dev_info.order = -1;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1


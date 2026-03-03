Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758C38CFEE
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530430; cv=none; b=ajoieWUUfGzH6Qa+g66KXs+MczYQ4EIRByVhSdtHIeYKjLM5ocDvnWqikYsOpeMiJGUPDq8kcOAjDQH2GRszZFNXoVUymXwZ/rz1vYrW88UVRszx7Q7Y7lX8AgF0RwJRk27aCa2FQw/Nxnvw+cvi8IhgCo8VekKm4qChCe63aLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530430; c=relaxed/simple;
	bh=YIfiGg54wHsEWICe5AuZdm92KWtiix1jjDHpjH1udtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVaGKufq1jCSlDGOEeTUNSCykxI4jI2ZpYwVjTnnDBmWnjIBaw5C6X8syQtSi9cn9Tr41UKV9jLQYCDfe/42yLstIDlCx4zD3oD1IoOet22CS4Bk7zPz/0k0c8EDx+u1WqgAAp3J7dGkmrtWc9NqvZRcYFnE6F5j0i0P/0UDmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2qQARhJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GgixXPdJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2qQARhJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GgixXPdJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62361I5q1675510
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7rYseVkxS5+
	KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=; b=A2qQARhJi84mnrPGEg8Holq+5M3
	UzdSd1/wYzgXrlZjAnKeXuqHWXGzGIKhgoqB3qYc+PeD+5xwBu1l6QhUC3e3ZfmF
	tmeuo2+drJLiXFCOPcrC3N1KRXSY6WIPzvmnzRBzyPRYpw5DoRWg2YuvwCxh2KVd
	Ybh6FxxDGLv9nHsz40PGyR3tWMYaEG+HCFTCfWzmBYv0tEBbB1uqDeGed7jRKlzU
	MZSHxsEXlDp0kHcU01D6L6tw9x8HTxBiPxa7m3SMSyn5B35Z03C9+gXNy561jGe0
	2E9pEa2aWkHYGziqnFGPKk+mjw8tUWByY+9X8ERby+BXiTJx+meSMJxf5wg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsa7ev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:48 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f07dad7a8so21191103b6e.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530428; x=1773135228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=GgixXPdJ31r7JkS9bqnqPK9UoPIFVrCUt0l4M2RFajvXTx01rEM1moCu5wtE5fhvEO
         Ppf14E7MeWuTjpwdicejn6Lv19RbnIL3G44EeAQPd6lB16IT3+vSYvnwfK9Ol/NEZtid
         znIfQvsS0+CSZraaG/2LCrhFxOKtEApYlI49gLiHKZ7FJYUUMsuyeRMplnhT2W4FCA+f
         KgwbgstPUSfN6g3PuO0T+9BWMxT0udk05lrvvLG/gb3KNyz3ZXIdEOpQ4nasK60A2ixl
         WBQEJknRLszjE2DMzLhLbEci0OGkUT3HP3z/DaWg6QlVLwP4sVOkrjLof6lcA//jhjkG
         PbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530428; x=1773135228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=eFYyvPTzlI6PzyezfWVazk8y9jf7Ms810cM+PdQTfq2Q4d2LFX3pzITdeoXRwSPmZc
         8Bz3XTpOYa9DaDRUxb4Oen2sgMfwebQzljzJ9m0PXUlZWK/Op16tqZI/mllSvluu0Vds
         8jcp9s1zSrFzlEu2hiI4IDuzpFMzD9hbguW5BZG5juH6kqqgNKqfZIDHleDoEZ5G4m/4
         AF1JdieHF1NcA1agcnAYJTdsiCwk+VsoZmZfPBk0JA2L7+qH8Q9GhEWu0hoBIeDxQ2T7
         KAr9tHlnNQ34EiHXba4jc8j7DBUP9QjiC9SvJMxUoS0pzT95yOYrT1KrPO7SLQxyqz9M
         Tvyg==
X-Forwarded-Encrypted: i=1; AJvYcCXSD/U8z5428Kdg27UwX1KOtXd5OFGftZiMn6vWPIvgf6UZnwlTAe/p44Bd8aOd9lsgI737rzvP1h5yjwYAiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc3CambbpBIRdfBHJFvdcMuwqORBn/Z+FgieIEvg767QqDJS+y
	OWfzuVxsxZ0UZdHatj5UsX0/4cPdFrO/JDTDnMFEiPBYk5Vi+N+PAq7gQeG9r/vB/jqxNr9Z2F0
	ghVS0fimyLatGATifseogL9ykuTDnhKZNaW+G4138+LtF5Mm2JQm4jtL80T82DnslY9X1Mw==
X-Gm-Gg: ATEYQzxNHtqSQJpjzm55CXqbTUPzjYJMU8Cc12rQCrGKjvTIne6GBzOafLaysq3ZBNX
	LAIQMMQh40j/tDTBNBkOQ5B5+vUb3PWyIVobdhfq6BbUZw7h3CKKo1WzgOfFp1l/dLl5f5LwMwa
	fUJDtRu6lmYNt/YF65/S5YBDc3aSDgKol2cQk+Cf2YJTOT0xo9M4FtKrAPjvuix6nVxswypYvM3
	FnfIW+xDnp7kuQPvkSkLPBFDBsrEsUnbqPeNHsRG9jtaJ3K3lUd/7s4k/5VDY3aTb6eET8D/4mX
	y/ZhF6KoYl4+HWqWWcM3atraCeaHmV7xnSDNe1nV8Ysczw2DxQoOomxTx3mIix2vWCr5LkWfTcq
	z3lfBde8RwOnCuGrMEh1bWXxFp1NALX3UJewBJ7gsDKD5YGjmx5RuEQvnFv3vjI4DAU9c8tZSar
	8HHZC0
X-Received: by 2002:a05:6820:2913:b0:67a:1d5c:b249 with SMTP id 006d021491bc7-67a1d5cba23mr1025577eaf.74.1772530427977;
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
X-Received: by 2002:a05:6820:2913:b0:67a:1d5c:b249 with SMTP id 006d021491bc7-67a1d5cba23mr1025558eaf.74.1772530427553;
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: mst@redhat.com, david@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH v3 2/5] virtio_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 01:33:38 -0800
Message-Id: <20260303093341.2927482-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MSxODhNOBpraiXq0Y1X3G9ERAYWrXGRc
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a6aafc cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: MSxODhNOBpraiXq0Y1X3G9ERAYWrXGRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfXx1okp2fUrzqR
 Xl1aZknYLvKHxdVmTwU61Y6+df2aDju0XYBGWTHktp20rj298gPlg7OOYLF4V9jA1+gjhwViFN7
 hSMKExz7DvL7xl88eB/FAbbayrKtVItZY1+8Mbcvu1PYxkjH6bnmzDORD6AcAR81on93RHUjQD3
 UbWiGx4kjOOJOoPGET/8sNPx/5KFkpu5EUs0ZHD7z2r8EUwQSTaUDODMz2hGDx4lQJDJP6db6rX
 eLQWI7G9g/gnxTVA/iYotubUburaZrh7znqoc0cFraHeNO2kudlrMUFiHtB/tzT09oH2K8em39b
 24XWQq68RHHR6QnnKX6JfRtxRgeAkP6Fj96qEDzzIeA8pCCSf+khjsu4sQkUoRekua/3f6v/MTp
 jUMnutBOU5xx8oOiy/0kTf/Tu1C+fsjvLwH98WLnp3nPy9OLEs/qv9OOc+A0HI4EcFRr+LGn0ll
 i45Pw83jgoAp4h9voiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_ORDER_UNSPECIFIED fallback value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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


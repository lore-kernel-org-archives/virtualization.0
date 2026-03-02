Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D987362147
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450293; cv=none; b=GViwvczdsJI9cszY/vWgYJjXI2TRJ2G74cC+DbxxsOPsnTk7Z6YAfkWa8lBv66ZfrxqyudgurlybXiw9oQ5dtFbSuy1Vu+nb0WUqOozNMhJDW2N4wdxDSn0+3E0ye4CXriJK2wtNuN9Vwai2q+QZNwz/W4LSVVcNpZQ7N7NUWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450293; c=relaxed/simple;
	bh=HLXtTAzPnUYaOa2u23iqxrz4snTgAGJKoQDn5bKXMek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brI+YY2K990olNa+t8oI7z3xdyp+4u7brz18+LsIaTJoSKHGq6x6HX75kIDj6yVG7jbw12MkIlpQjh1JfM+3FOnx36I+WjZ2ercMDgaIPQcd7bD3PIPjCpoWTF2AeYID+Tx1ZeIqVLzgNXZtWuSZa/UVUdWF8XsSdYs/9SQU488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7dupRXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=izfy1aCP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7dupRXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izfy1aCP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226h90e2504590
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 11:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9SaV6NeFszm
	MR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=; b=e7dupRXgFjWwN5RgK14fr25qfiE
	ViK+0pp8NQ9Biv6jQfqP03nbbdCBZ23zvXjZZhkSR4P9uuO48s6zwScjChTDoVqN
	cMvhLgEAXeZJE1335THfZvZr9Ic2qSLVrn0RUtuY6CJPhzf1kXzypUmxtVWZy7s6
	Z3Wf1Bxn/rmgK5d08iU//gLwYHSspodfSQeNQv4NC6ruBmIWeKicTQhXMWzNfWoz
	DhfL87Qiiha++Ya4rGDPV3tJW4E+7HrBDSWa6jdr+Yz/fhAg9hjonXDjpkXXZeXc
	esfCSegwQCW3rwELNNkw1Hz04rl1NXOBZ1UqDgpRG+Rh6hbG6A/BguFy7Qg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hes08w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:18:07 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463a7f204a7so54140505b6e.0
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450287; x=1773055087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SaV6NeFszmMR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=;
        b=izfy1aCPBb5x6yalAx97kPIrnWZS9tjs0tc8ok+ozhMLiH0lg+wId7wOH+bIPeHfm1
         IEdO1ApZsc2tClsWbgLNh/risbgl8kWY5JONmAx3z31wIOK8n4T3v9Vgbc3mHLcyjoVe
         pepjgTQvl9iCksSkKKou55vXsVHAsU9kD0asR0DN3iNNZAhT7CdgFL+6MC3fTI5dPfIu
         5NV1U1XxWqttmdlrisruvVFf09q0cdxGBWz9i4APww8Rkmsrsr3P97/aDlh3NH5jxjO1
         LYeXp/Lm2bAX+d6WaJlmC5dG0XhopnrYUIBK2lFy8rbjInH1P90HyODDXSgVInCgkre+
         5LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450287; x=1773055087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SaV6NeFszmMR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=;
        b=vS5mBBHW0Qq6OMHko0PR6Vb5WPARUSKqgpSiF9gpHHIts9PGNnSp125ajtbGMKPfrZ
         HGWVyn2UTy9kES5eiVS5e6H+55iNAxobJZzBf55tyxfUgcsaryl5us03ZcLn+osLscSJ
         7a4jZfhlJRkgb2a+bTxW5rKeYby3Qhf8zzuywalXjn9xZMa6vUWrqawZdXfcKS0d7Mo7
         oCf57tnpbzNRDFTSYisGoiAr//jugwuOtOCmr0P+hN7ja+bJ694YkosZlXbv9+v1oKmP
         ZSYegFgBwJR0gkFtg7vja41QTsTmfdpdiTvuDTZLl2uVBxzheEAB4HDd7EfVgjE7EWAl
         W78w==
X-Forwarded-Encrypted: i=1; AJvYcCWlyX+a+Jv/GbHvkvk+cmSJHMYN7zj12IG/mZjrn9X+8VA8Ip891NQjEIvEHy41aSc9DrC8YThMRvOwSEyFoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEGS/cXaq1RA+qy5FCyqq8Mtm7YCoQA4bMpwLMuf6pArr6UFmg
	K+KV2zSyUIPMdn5QDHZ4phvya46adKlZcDgEZbhLwahnZ+Xno5lE5CjT2aAsLeInrUGdSdvyoJC
	KNwdn3AP1F/RKVLWeRqCVRvIXYhpdm2TknO5wWTwXlp72gZlJv+AHmCKLLnIQW82atm3mQw==
X-Gm-Gg: ATEYQzx8ys6bpIkb08CXeb8R/L6oqgRxD/D+nBLqc8rWwn1BhOpDLMP10gTfvdKi/tF
	xd+Xpo6desWOpdPWu6f35NvUwfHydRQcgJ/Rvt1lCukdmeP6okgkpHtfahfn2U/mw/kMq3U/mMg
	B6cqkiOJDjcX9wIVtX3dvI/cXCQMrzPSXiD4NyPsjgDUOyqgu3Qz7kM50UPtvTNZUNGYbKsYBa6
	HZ1cs03F2etwx4y1251T86jByibUjKQ9+DVi/P+/+oOa/EpJ9nFJGjUCGuGghtsaGKYDvEbo3Gp
	LxguGcoa2Md+w+xScGbcrOK7Q0SqLak7PT8ytb4HTGPveMe86LJm6eQfU7T0O1OP+F/ZuzEy8mT
	b9uhJ6dylgf1g72Vcfv5sJbjwNkcjocsOokq8qUC0OX4kV5/hRKZapdkf7wRuPLOThIzMN9Oi8U
	lJX4a3
X-Received: by 2002:a05:6808:1a29:b0:463:a32f:ed4b with SMTP id 5614622812f47-464be9c74e5mr5728065b6e.22.1772450287124;
        Mon, 02 Mar 2026 03:18:07 -0800 (PST)
X-Received: by 2002:a05:6808:1a29:b0:463:a32f:ed4b with SMTP id 5614622812f47-464be9c74e5mr5728038b6e.22.1772450286733;
        Mon, 02 Mar 2026 03:18:06 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:06 -0800 (PST)
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
Subject: [PATCH v2 4/4] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Mon,  2 Mar 2026 03:17:57 -0800
Message-Id: <20260302111757.2191056-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a571ef cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=c6WgzpUFESAvjm-ZtrYA:9 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: gJ63BA8CpyYD7zq-zK6CD1FblFGP0SYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfXwmUlOeCBqycy
 tEZvY3bI7GwscF0GSHnf3by5ETVwDTZFBFtFHixJadV2oZ0zufxfDJ/WfAEaNSQQ7svD+U61WzI
 PD2bEwTFcWmfv4yNAqxyCRJn+7fXybHVpzw/x+bzN4q/BvrsXlRrCLSNe1mrDec91T8Cedk4ys5
 hQVksPwPHR1Wm69BhUpIIl54wpNbCX34ck4KAuOoC+dp87HDhUILMqY2opZLjTTrSad4u4BzZHE
 o0KuhyPYi/+Tneg388fBD3zQxzSNdiPNl2tpP1LaHXh/VHhSC3Dlj9D8nVdEF2R7rprV2FhNM8+
 5Iss1P22ih1TnKcxjvYxKJrvX/lvh/kuvKgh1sQSAAhyrRyt5YwZvI4v5yVXoJXDTYvdPAW/Eag
 wsfPT9J0jvPCFVXGoVmOxlx0YAbzoMIjCSZTfO1wELbqr0y9EatpYpbrpzckQDXNR6766L1Liup
 iqfLLEv3mBCWWyekrfQ==
X-Proofpoint-ORIG-GUID: gJ63BA8CpyYD7zq-zK6CD1FblFGP0SYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020093

PAGE_REPORTING_ORDER_UNSPECIFIED is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_ORDER_UNSPECIFIED to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 mm/page_reporting.c            | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index d1886c657..9d4ca5c21 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,7 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
-#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	-1
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 51cd88faf..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -25,7 +25,12 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
 
 static const struct kernel_param_ops page_reporting_param_ops = {
 	.set = &page_order_update_notify,
-	.get = &param_get_uint,
+	/*
+	 * For the get op, use param_get_int instead of param_get_uint.
+	 * This is to make sure that when unset the initialized value of
+	 * -1 is shown correctly
+	 */
+	.get = &param_get_int,
 };
 
 module_param_cb(page_reporting_order, &page_reporting_param_ops,
-- 
2.34.1


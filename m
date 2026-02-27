Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC9421A10
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201225; cv=none; b=S/TZWcpaWS5lOW6x00Tmi54bsElXXfpL3dWy+7jSGcoUykV2poSqNcHktejipLhnZiHHkve0KJDIv4nBY24KdRBogSZTLBVbIh6NHfyIm8SYYxiAsZj+DgIEmzqYTqa7yVWDtqNuvPmSXjZfpHZ2Lu0yYD7w53AcjhbLdPdQxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201225; c=relaxed/simple;
	bh=Zfj3mi4T99ulY3bjPSNEIIABpDCYHarnUQWquz3SJ0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfvU6CRj2vSo5bx2rC4i20ziUDk48UqVgdwTmfULAZfkz+HGjw9NtlHOcpO2MUQbgNk5VJNMQLoc2XiAPlTy5J3vUSIcRJ6r+RhRrk7m19lSldW2G8NMaQedjlyu5rJ8GFvFLQ9l9NrQQRY04MLh1rPsJDGm0jU6Kh5pJpiJ6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZCZ67n2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JXbiFAY6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZCZ67n2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JXbiFAY6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9kBnu3945767
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hiLJ34i16BM
	9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=; b=HZCZ67n2dWR6CiBijqDWsFZ6epp
	ohL6zAH3hzMzniM+XkdlZ8UlI5X+9odr5MoggeyoFawVDDR1YIMdLJVIvC7CeUGe
	Krsr9CeYzl0Xt5aaLBy/Unonpg2wxVGOr+o9LGUusE29TYnj3fDvmsnk3ovZqTrw
	wVFjggRmMNz4OpL3mauQ4k0YrhZq0xRlfs37XyvaQc7ntGklcqQYAtLvtG9wtmt2
	jjP0J5vPo1f9imAms0kuRTe6uoOsYYWYljO1WfMrt8Ce7HQeKvhybQLGIVu0q6bp
	Jf04CfFCa6lp8EdY/KQZ4mYsgbO0xAisST7ADe52ukKRHpstzBwox6bIivw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck8x88smc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:03 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c6bb79a5so10926050a34.0
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201222; x=1772806022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiLJ34i16BM9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=;
        b=JXbiFAY6/RbQUOGMc8lVzu61zSSHzh7QloHwXQhGVt3miZ/KNWjAZajKmEf1q+46NI
         3TdNQOrovBK8F1uWKREMZ6dEB8+jPQFM5X/tCvp3RaucwLlZcjESOW7Sw8kWflrHwn28
         /FWPijSRf49wwF2oHWaxCc9ABufcUXVgXiE2eyqbzLQJivOOuWD9Yu5t8kVPjInUTEtm
         rMQ7tcCcU+f466+T66qherHVnx87iwc6/VOBRq8sGylRXVQFxsgkqpVTOZG7b+s9k6iO
         uRTw6ATrF5ME+E6hFfWGyZ0N4CoOVTdGWD34BOKMuwa6S5myeqZ8zFXJXvHRDZH/+9ue
         JA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201222; x=1772806022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiLJ34i16BM9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=;
        b=rkGm8xjahgz1E3AuLZX/wySXXdb8MCR5XNA+3c0aoFsdGQMpJ32fTsFLJMSIkK0IbE
         1uCpuCINdNXGAZRj71iU2BUX/snIYtn413t5OPgj30jsaWybKhKay2inNGbq0wCp/zS3
         IB8f23jjaRmNVLjKNGsrbkPt/TB3ui11ZI73y3NegNA/8qofEmrykGEeJZ9Ub5ErSNq6
         2feCMWaygqmU6V3Z8oT2bbKhJ0eZg0tu+W337VBg++GVGpZr8JZSZ1yNHP/PmbpQXwYo
         PsmbNCMuMl7VqBIgpB29mtv7HH+3s0YKXdzSlsEJMoHsrwbVHNP0FNXU15R2Apc3cBU6
         UmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+r/UArGYH5s6mj+Q4ixRiLLnt9ga/GRuT9mv/iW/2uOVnwdfCdbloTNSOfuqentQoyaFLYdwHc7FnuO2Mqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLb/xwE7uBBm1KqgwaIYLZq3I1+IDvpToXNQ6hVu39nC/4ETcH
	Sqoc4teC+Q9p6kcPcjXm1ax/KYY3QSKV0Xbq6O+/N8o7aiMCkV7xIjdMeJFmtVaoxJqvb1o0iuO
	v+0KgT0TSjjmjSO/U81b8tUw67a8XyDjICJJBqSSYu/8L1pv0i7nk1jwGGtoq8BAUPe/rYg==
X-Gm-Gg: ATEYQzylPJZQDdMvMbuGTidrQL9mLGH0YCSZnMcUlkox4idIckSl1NqwsAK5gEIeGir
	DV2GUCtVcel0lsjrs4wFj7GQbR9HE9H4tf2HEKw/z4rRNSLUfNzDdBZ+qPTOSpwBR6POLscwQnP
	A0+B1KhlN2S7hzxWSx2S+JfEQMLt2snqu5k1hdhw1Q/3zSOKrRgtjkYOYy7WizOg0cfIl5M7mP8
	mxytds+4do8kcoWbBZocoQlepe8Gzzrf0mBnNZ6M/BNrIIxJhN/q1IL9b6FLwrWTHRPFH0UwL1N
	1uqpr1iEPcAYGtTO9mBl3hPPpeET5GVTUhLdh1uqgAVbofkWEKlYcglw9TJ1X2ImWENdYFfCJwx
	9FYuqB/nb/E3vhQSKjtgn8ZlvWVWNWii+JYz8XOA9a67QcNQPCNKL33gySHloAT3nThwVqYG9Uf
	l8ssFz
X-Received: by 2002:a05:6830:718b:b0:7d1:94d0:e8f1 with SMTP id 46e09a7af769-7d591b2ce8fmr1792340a34.15.1772201222444;
        Fri, 27 Feb 2026 06:07:02 -0800 (PST)
X-Received: by 2002:a05:6830:718b:b0:7d1:94d0:e8f1 with SMTP id 46e09a7af769-7d591b2ce8fmr1792295a34.15.1772201221840;
        Fri, 27 Feb 2026 06:07:01 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:01 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org
Cc: mst@redhat.com, david@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] page_reporting: add PAGE_REPORTING_DEFAULT_ORDER
Date: Fri, 27 Feb 2026 06:06:52 -0800
Message-Id: <20260227140655.360696-2-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WZwBqkhX c=1 sm=1 tr=0 ts=69a1a507 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=agIWOxjPXKrzBStnBTYA:9 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfXydus/MOSTTyU
 d1SsSMOcAgSWh1yEYbo+l8mtk/V7dGhvO7E7gQftRuY81peomSLeawA+e6e5+YPxPDh5iSkMBMn
 ll7G4cTxNLstOWRTYf5xxG8r8U8RSNL89Tl3PYxjey9v6+tACP9r9XAkmu3S+XVjPiK87Cn7sXI
 sMW8pNNUZfbTyEUKkDO9SZ1J2UshVbThucvWc4vVBHh4c5lC4WoAFVQ68TMz5XF7dFWU0JHm1iS
 u2FUe2L2NuIYWKrvVhiEMPeBs+FyWDGsWE9Lp9ABGwC+C/f70+gajYkKI2kHtfC5llww/cRyEvy
 c6YObsGhH4YKfViFb2+56znSDgi0xx56ttQRuZRQIwxvHnhXROzwyqFxyRGRK9gvc8NpCkHeAjY
 ftbVFLfb9tiPu31RKzTaZDBDhIBi49/0lZlmasaFmEW1syQobubGwhtZ0Dgxz8QmxzjUeRENnt+
 TmsB465rTHMwgZ7DkqQ==
X-Proofpoint-ORIG-GUID: FLtCuLhMbKXk9Kl7xSKswd5uBsqHorwJ
X-Proofpoint-GUID: FLtCuLhMbKXk9Kl7xSKswd5uBsqHorwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_DEFAULT_ORDER and
check for it when the driver is being registered.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 1 +
 mm/page_reporting.c            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3..a7e3e30f2 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define PAGE_REPORTING_DEFAULT_ORDER	0
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..9ad4fc3f8 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


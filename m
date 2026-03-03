Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C247D94B
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537448; cv=none; b=U0ftXv/+9cKnJaoS8138FtQW37BH44BerTSf1hvELAomVA3LeHXRYn+4MnKJxnbMYqZOI7vIDdHkicZMENjMndKNORNm3gz196pCZ5YtFcgyuTKBN09p9uVfe72K6FyGmlSR28HxjsIQzL4ce6GK/LBrC+B2fao7q9vvg/BmCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537448; c=relaxed/simple;
	bh=oBpfbKj10n5yNd8WtYy9cLMMHVSFy+UXcU3wOihiOQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mi5Qxr4gMEDpmdmUj8edXLXTTl+vwdoFvER8KRhZayoyO3w5G5gaW2IjTZS78iSRysheFr2NXN6mSsJNr7CpNXoKuAWW4f1V7xn2kUXLipzQGy6AeJyblIpQAvZw5a6gyPcd9qx2vwVjC9Ix/F3idoWz0Mg+x0jT74IKeYhC9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=id+ozkJT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRwNJ7vY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="id+ozkJT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRwNJ7vY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239miep2613851
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gb6qHftYG9h
	3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=; b=id+ozkJTpWHaKiJG2P5abPU1gIt
	EhpdCcOmUibdXNwCJ0AtMxlgc7G5ySfRo293tPyEecOjmB8i2a4wSmcp0zduPcM1
	tr6H1BgQbeagyVmjyo5+RylXDUCWfNGKgqUpS8twb4RDp6WJ5JtD72h5JhZr2KAd
	NgbjmyCWTZqPE1ScEIullfIdfyBI8QbiZfY75aCjz0j2Sjl6Ohduyto0jWFfwJr9
	gLx1jt9TW3ae4voVVZ+izlnW3Qj392AtcJQ0E9yPKuFdYGKzGAryNStJ1RfxhOw6
	TTlpj28Z7IxQ25l3WMIYYBSlB9onRdEcA7dC0w+hcxvr60uIg+oKORdiMKg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxf8dkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:44 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d1950b48f3so57992426a34.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537444; x=1773142244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb6qHftYG9h3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=;
        b=DRwNJ7vYt7/IOjEyvTWkE/RTKlQjHYjJSFkx0Vr7B0A+9UhAdok8E9OYmzZFXiN+6g
         1UZKM5SHnk+APX9kI2coNuF8SRH5YLJ9V1IVULFv7RVGJt8UbsJlmPZKTOdqfxAr7EoQ
         tXc3hHBaghZydRc9odt64IEaXvFW4+LwyYZWkZDcUURWMpAmdC9uC2ujTPMJcaDqP4Bh
         Wfbb2xUfy8II6jJSzRverqPK8DkfpgzRZNeV/ZH9f+z5CxsY81E2BikrwzPIZDt6JTbk
         Iy8AnT5jljCFGwPumxWAMd+oSHI4AI7zfzm9WYuMmZxrAlUbQ7swN+ptQgSgkJBSF7An
         6OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537444; x=1773142244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gb6qHftYG9h3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=;
        b=OEzFLFIkdjtTDa258DdVd7/TM65to/fIjq7Zy0VrJzt9+RS8mzCfBK9ikGRDFIik9l
         vXU8LFRxgs4nzfYLhAvqNps8FBICh5oHNeH+RQzK+ngOasiCsY+/lnxOG7WhaMCJgGFx
         nSRQipeNSiUpDYXkQhiO7jge040gRESDrTBDB4Xh6mGNA2HkdXw/Ozh0IJEoXTBffSz9
         v0fvUeac9dl11D0RFV9xNlL6pHpB3Kfrnb5btTCoOMM5TsPQjOSZaZ37Fi+wAJZK/2Qn
         rGpsCTbrQ3Sj0z/L99nujx80iDzL0wVX6QZInZabd9O8SQKdLBHFLwUdi8PkWy7Iqgij
         E6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAloznakycJXMhetjfU00MjAz+EdGMcF7K4y+rT8EVldmsMPrcVVqYbmkw4T60Zu0ZS9dNzQwPLhn1d+Hc9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YywvHZnHWM1ymOgU3a6W/JqJhDzpxaG4y2974Ju03qVc/3xTPxT
	WxOQ3Q1Ke7Xn9qKmDIZi6QwXftRddsffBOHy30C9LQ/xFuelBrEL2V0c1/Bk00cABeBwnVdeHEQ
	U22ECtqPCbxqBjF0HF4AZONToBa/zCtm9W9sjsyybSOA3L17/Egf58uwU0rnCnCpHDXisyw==
X-Gm-Gg: ATEYQzxMdXqYzG4857irTWl3BAQswdKfX5JkAGe0SUpM8m2XMpU6t09wHIfqAOMIgJm
	TP+osxv1JQ8CgbYy3GG4xf3b1+gvz/ZwG+H+8TFsKkup2Jl8Ff//3PH5oql+pxed09QegPSn4g1
	q/iOJfI2pUb3ahyo336GuFEA6Iqu1wX+uA3KT2th7GHK/WYO2EOZMbI0EoktJpxnEbfBdZoeWUl
	F0JYIG3LLrQ8zktN61+lrPASEsToZzJekKmzaq3iXivlPk5UJsxHGCk1u80++VYSoHmUdp65ULZ
	NYZDJmxMWyQHTPjaNT8PbnhTrgLvQDC2Oleaen7DodsmA2hdpliWbmojoAf0olsms6kOYnY77Hh
	SZqlQ4yFCWHZeym0enNXK72Dy6ffiTuaQyogEpBcyBUAEmnbtidECgtLgeaIjF3eHpcj30CnX00
	/1H0Ou
X-Received: by 2002:a05:6830:83a4:b0:7c5:3c7d:7e67 with SMTP id 46e09a7af769-7d591be6fe4mr6865300a34.29.1772537443658;
        Tue, 03 Mar 2026 03:30:43 -0800 (PST)
X-Received: by 2002:a05:6830:83a4:b0:7c5:3c7d:7e67 with SMTP id 46e09a7af769-7d591be6fe4mr6865268a34.29.1772537443240;
        Tue, 03 Mar 2026 03:30:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:42 -0800 (PST)
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
Subject: [PATCH v4 5/5] mm/page_reporting: change page_reporting_order to PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 03:30:32 -0800
Message-Id: <20260303113032.3008371-6-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX0GMf2FJUNcbV
 6I8WY5O8oJoOtRNuqTRZITvoNj0vFqRe/+klCltQxhb988Vg0JyxrIy2IEQGRb7QJpSSUngPU0z
 3NXi71lS0yeRpwY8p1ipZhrAI1j0yTI/jAtUJ4VMkLKRPDIt+mcKGPeVFl2YE1iuAZ9NhnbD4gV
 yORIgzHR7Q/bpgnkSfOzajHdlYPubQl1H2FWH/3T16SACbrQb+rCqlqdsHGc5puOeBcnMLkOAgw
 kR7Jb4wEZJSeAD6XLZXxlcmDd0oqkSK+y2KmXu8cYZr0PB1BpTzhSZ1g4ANqDK1FSVsRsn0Pq7U
 d16+LK1kzv9HL33fW1LNNRgbXxJSavmrcI7NZ61jIXkzQADYs7nWWvf0Z9LBN6XKeLxyP98O/jc
 jbVzt40CnGxI5YSPh+WBdW4efSuC1t0pIT4a8lQW8U9drsWuNBuOEGLnUJ6o6XzGzDmJ9deJ/VB
 SM8pKNAGONDfsTa4u/g==
X-Proofpoint-ORIG-GUID: 7oLnAlWclIu3uReAy6BuE1LyJEMVF4i8
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a6c664 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=xOnWzZm5OySgNDGUUPUA:9 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: 7oLnAlWclIu3uReAy6BuE1LyJEMVF4i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089

page_reporting_order when uninitialised, holds a magic number -1.

Since we now maintain PAGE_REPORTING_ORDER_UNSPECIFIED as -1, which
is also a flag, set page_reporting_order to this flag.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index a97ee07cb..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
@@ -369,7 +369,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 * pageblock_order.
 	 */
 
-	if (page_reporting_order == -1) {
+	if (page_reporting_order == PAGE_REPORTING_ORDER_UNSPECIFIED) {
 		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
 			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
-- 
2.34.1


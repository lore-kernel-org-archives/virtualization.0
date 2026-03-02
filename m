Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87475361DAC
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450285; cv=none; b=l8RdPtR0EiBygXF610B/IEFOMLAnsZzs6mx4eUhNxFszpYIK8Ru6CBCa3XUR2oO/VKsf+kJigC4f9ci4iPlhZO2wGiAUf1zFbzd91oN45w1bGvML+i5hmV2+V6DcJSQdNqqxj8G1Li8KV2qoqibDLVDgs2nkiQxkr3Laq0aPuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450285; c=relaxed/simple;
	bh=COLsagByi5TZXo/xLIaTS6XkvVxjncL/ZcCZ03pkC34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xo0wUWtwN26Z659I5vH8KS9pIORIZsupw8oAJ4HqdUFGlGXnqpSoeqT7loyBqqPnX5ICaApceFFYplNM8MckjRTaraMSRsBEQ0UOp9Eo7KoqwDj5rXyw3NaiEXeTG7hw45MAoZ4PDBmw/RBgasOtJko2W16gV4n24hgK3uqWyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa59O0vF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HJ4yxfRx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa59O0vF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HJ4yxfRx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226h9ic2504591
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 11:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5q/hINUJXjB
	L3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=; b=oa59O0vFv/WQU338Lx4dq+BNaOT
	MiSA/QVro7cxbv7wqwQdKu2XDycslEPuyxrSHBUHCBuAta64YXZlSZTN7vhhlZBn
	EMgQZTr2YwwZGmepL3qezrqfW8oRJzZnOO6qrRB330VhcrzVfkcijALBKqAq13lu
	aGeWEPRIhQ6EjiGk7TFY/eMSR4HmMurUC/vbPDG3NHiKliPSAw9j8bL7uWUtg/xB
	mbuc5H3AgLa93XlgXhOlpU9EK0qifbq9CrmP1d9Er8oT8XIWNZkL6HzUh6GJTE1r
	Xvr2hAKhIg9OSjh4Qv/f95wGxSsEfhdlaThO90k0xwoh0+QaZ+AivjUxrZw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hes08n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:18:02 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45a8cdc7e01so53663180b6e.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450282; x=1773055082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q/hINUJXjBL3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=;
        b=HJ4yxfRxjFphfEYsseZ4spNY6/nHKc+kQLJxB0yTxbQkwDhmn9XJIHjJxRDdliUNxt
         VUGX2IxBiukp8NI3fs1FauS4IYsgMufBvUZcZ5WFcBaa5IMNoY+d+49fbqQ5bA6eFEvM
         JnjnF9TCW7dQ2cydBflfn3Kv2CxDpRni1i0nCdvIypKQS4v6jiWcgtGJ3RrbHGcibcQT
         Gd0CZRw5lmtnJJyFbJ4QW/Fwa8qgVZFVfjb4U//AMbzM6xkr647uTNrIVlh2LHznlui0
         lpB693jW25KRsyqJHgzWz05ud+B48frMwvzd0QAAxV3JymgjngSCCprcdp2zbVBdCQgO
         8DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450282; x=1773055082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5q/hINUJXjBL3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=;
        b=D08a6JJauT7g4GUaSCdB+HEZFHcfXXHT69gef7CVxup+Aup4IotVRBepQwAUkPyIPp
         3wi6qMyjTXNNOup7EBA7dg9xuqc1crxODGijtyNGenwQgVdEUPdrUpNCLuhiIvYLx87m
         VknNdv7g25s/sNElKstvrKQp3Yxp2CIN6fCgl5u/Q+fERe//Ka+8Vpm62OEa9OCj0tk5
         hwo4F3gpfmjhwbTBENrwtNs5cQfQxGT+uUFBk5PrSnkAvOKLWDRKzL3O6oT/gPYf5QUm
         FI/PZ9ZxP0jaVt7QikgG+Iq/Iw6qqxT0OH+3IdWyC2CEmkatHVHJ8G01NAt4GgMc9Xki
         1QLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmLqaPXTXInxDTxvAOCPEGbJ9wCUe7CWt6d85398NiJkKYWfgIXWCb7cuV2Wm9dZUS65N+zuzoZfShwuuBIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7kCMH47rL/RoQ/JsU3xRYFEwBAFalWsSx5VEWdsPo4vypqCJr
	+Zplu1ErjrdMD26z/w1TpGMnYnzo6RfLu7Z2UeX4aNoed8oU+URgZ+VD4ZlUr3TgbHWVent5RaE
	2ONZrEd1dccNjfdBna8XoT0OkdvYBPPWzQ+42XqYUpQOxS/gEzg52/T/USjyKL1vA0GU0bg==
X-Gm-Gg: ATEYQzxyP8UeXnhRexDGUAZJyzvIxzNW6DVsJATOaARAdhlfnNhcYtE7swERpgRUs1J
	46hzcNPAJLiVl1zmtEeR07JRmAb+x4fJ24E6cyJAWoSye6kE+C6P9DKfj0zp3Jobe68o7c/ISwY
	A+qaqr3oe1EoRoni1/+i2XjELl+azadVA6jPagR2I1nKV0By+8bMho95vuvcbBl3kYb+mcbLb6V
	RRQ8MoADrPzJqtQpDUZkOSYU92UFVEeWUS+X0K7frBtjubDR3xIFKgIAOZY60w93+mVZJMtuJej
	JJcp00OTfIA5ft+a3xt2/kTn+mpLKVpdZu+I3DWWaq0ApeFnfeYPxp9snttcJojhsWQxMOmwv1H
	hc2cX8ZxkjzBxRpCSIqFY9zdMZ3y5Tw1tOHlOQoFYTAttlRcMrcOyg0KDCaUKlf9bY8YPTXEwYq
	DD/Nhp
X-Received: by 2002:a05:6808:1b0a:b0:459:9630:3742 with SMTP id 5614622812f47-464be9b7765mr5628529b6e.22.1772450281747;
        Mon, 02 Mar 2026 03:18:01 -0800 (PST)
X-Received: by 2002:a05:6808:1b0a:b0:459:9630:3742 with SMTP id 5614622812f47-464be9b7765mr5628511b6e.22.1772450281324;
        Mon, 02 Mar 2026 03:18:01 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:00 -0800 (PST)
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
Subject: [PATCH v2 1/4] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Mon,  2 Mar 2026 03:17:54 -0800
Message-Id: <20260302111757.2191056-2-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a571ea cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DkB-CqvKoiMeaEFB2csA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: 71AyRUJazVg3Ic4JTnFotCPxHmdEm6Xj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX/GBWD477fIe6
 Pb5GBL7uXSKiecn28IQBaaUWrhpBCibslexJvSxEtKkcFnR/jalg42HFPoXJvehfjygrSgRF8ZA
 I+XHhlRZmv5zlWBYONBo2derPIASFbF1Vyc9DwrINmySP+lPqpe0yNAWXipqMATrdDcWSJM4NDh
 mU2HV/EN3YVFUMHu9Y7J/PX2wq2CDQY1lY6uGLtbmBqaaGcmVVWjhc5jFMdXbL1D5bpDRAJZSmk
 YqzDGgeHsiLlMH7wi5dhvgrmePO0ypuGAw5jUsVct9W15xl7Xc1YFDIdQDVlH2KGYAkrOyi1mTt
 djtm5JVjMMWZga9gsBPQJX7PsJ7PVhl/nrIZqAwfxcAw0O03xoh8XfbWQbvztLxhKJH29PTWmzq
 dkOwJ+jhhbRHTGgqyJwwxo9GGCmARa5glsGPts/c4oXAtFfr/WnUdQ9WVl0S9Vw1AaGo2SorfYR
 sKegt3hEn3Fmzbfm1pA==
X-Proofpoint-ORIG-GUID: 71AyRUJazVg3Ic4JTnFotCPxHmdEm6Xj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020093

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_ORDER_UNSPECIFIED and
check for it when the driver is being registered.

This macro will be used in relevant drivers next.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h |  1 +
 mm/page_reporting.c            | 14 +++++---------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3..d1886c657 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..51cd88faf 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
@@ -25,12 +25,7 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
 
 static const struct kernel_param_ops page_reporting_param_ops = {
 	.set = &page_order_update_notify,
-	/*
-	 * For the get op, use param_get_int instead of param_get_uint.
-	 * This is to make sure that when unset the initialized value of
-	 * -1 is shown correctly
-	 */
-	.get = &param_get_int,
+	.get = &param_get_uint,
 };
 
 module_param_cb(page_reporting_order, &page_reporting_param_ops,
@@ -369,8 +364,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 * pageblock_order.
 	 */
 
-	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+	if (page_reporting_order == PAGE_REPORTING_ORDER_UNSPECIFIED) {
+		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


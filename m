Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B647DD47
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537444; cv=none; b=LSvmVS1LiaVD/Y7rBwCH64oE0/g6vBqw/vjqRfklNdBglUDhJCiRcmwBGqO+Syz+mneOO0bBI9VVR+4KaZUWcDYQ4mOMprptGxCivG7WoBA+hClW7pnj4pk6//0xeOuWKNY81Rq2fG86VKaJFG5xW8lK/6G9RqtqxdTaj+HDb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537444; c=relaxed/simple;
	bh=LbKFNBiZ+VRrB07vX9O8FknKJ9OvEGWcCKyR1m6xhDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NS96DYh8LTfOmrmV9lhjIYtEcVaIsQo5e5ZnOG6D4wkrcSX6KzeLiE/u4w0r3ApE6KM1mzTCC4TeMYRxtWdc6CUF41xseA6I5QSgRDAE0/KkfXSK6XTzCS8u7H23HD0iA7U1BwlNzfzCLfZNMUuTZxX2N4iRnyO16sUxUIrxXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFbjZohE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J9S/3+l2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFbjZohE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9S/3+l2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239ms6c3099704
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rSSvKdrdqNt
	Uffp+vZHypJOUj06k8TVBSBVgyR9aCmM=; b=RFbjZohEdYhFNtNFyhW4v07d1Xy
	t7Atad8LzCi6bRyYwCMaTj0Njuntt7rDanIojjQjtoPBxUWmKBFMmGb8NlDjrwxl
	LLGgSA8EdVb0zSP0nhFaWQiC+H6I3Ddf+VaFGvorGD/WHg3Wg4mdikgYxTtwuIp6
	XIvFpZGhRpAIH8/iUObyhlnJU8WLvBN0eAR1Gtl8fj+qlGDtreSm9SecY8HyVUee
	TA9/+pCZLavcYwyWdxRbvhfND4qU09bQvVhy4i+v5SqRSWibrWaFd0b1HQgGv35D
	2KNtCAObhJ7eU5FYHma1tNFzrUoh3OwNjSEtt43fwHtPPRd5iyNOMHAbSbg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnuqu0pwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:40 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so66778817a34.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537440; x=1773142240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=J9S/3+l25lfESYxMl4M7nWrlmnqN14OVZcdEyjb/Eea6D4OpjUoiSTJ9tuXCN1pNSm
         UxqYHQE2CQbUR5mXtgpvujxJaQZCW37X0kqLgS6duKUpOwCyNYoAg+VMC5QokccNp07Y
         s1FUVTLLIUlAksMOoKRE0qo6v1RtS6m6cavIuGmVHflhUrqF555PrGhpsmyKOHpmw8Os
         VB01JbxH5jUQE4/QrVSTbLLs7Nyo9HUh7YXcFMTEmP+liBE2ZmqO25Er0gcHWxS4yfJB
         KxgSd2LoMdB/C2teU2Ip3XdNeK7jSCWSirP+2nPyoCJLjSfj0C5W820rv8I3JTCZMxPU
         xrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537440; x=1773142240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=lHtdkz3BbO9t++DeO6tEyhYnoIwLARGSl8jufMYDVsiC9O7HVIBaPYP+N1HmgSfD6R
         NfVvcJb+470DmapUVOozrnSKUxoUcBLjF41R0bFZW7QIdyqRRdY0iWeRwFVgvmRA22/z
         HFTrFxJMacnLvvlmLhDMjOMwwdW6uKGo8CwJLCyQYqzS/Ak/X91+dJRMYJBvcNfNnWSg
         jAxvXE44nbJFNWwupVQqiaNUmqOtQlzdYbL3L0e3GjruBp37E+ewxFZj1ZfyU4f1alZT
         5Wo7LZxNW657NFrw4jdllN//Rk4cJprjrgWcbk75W8ZXYGBqZsr28VLZVGaulggFwMpd
         BGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtfB3kygRnTfFPARkRyCKy0vEViflG1l+UFRQyIvU7K/9YpHCDQKYWckfZl+gRyKZFoZq+D0atHz2S6OnZCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZpVzgu2TtY4rBvltnb9LQlUuFDxSFYcC5MxEq19xnZ+JS5loF
	GmhdrOna1/K8KJC2CAYzixqqi20xTAC2HhVJ/rPQPy4Im8n2n6rZeIlSQj3Aqci94bCcvVyl+Fy
	XdvVp+NaEJx43Clrx6VgMDNeZ9vXICPiW6Ssf0mvw5Tutl/5WqJzLDmlVOIsHAmaXHoGM2g==
X-Gm-Gg: ATEYQzxrsiuF1xF9AQU+/8kjIMNPMq2gS9dBc4iKK7OswIqMDyRxAKn/Zd99IPPKgiL
	O66c8/YV2ikdkOmUedSHZNRycCYtpnLlbNsK+EWBMBbR5gvVdFs4PVIQwzvvzIOc7ulS+8EzNJ9
	quN8eof1qCVcdQnrsVzWDXe8N4TQoLL/byA6fbEs5nCrqLw/5nOHDuma/vf7bl72ww+GuvhN7RD
	B0eDekv2wbF2laMWM+vcfEVZgR3vyr4tFpDKiKI4hNMPuV9qUKKzNv+Y8/xWXPnO0tCvHytTcSf
	BM8ovIYjnBK45ZsmX0beldKsCej4Xl//dyUko2BGHjgWiolHSoApJcrIk854p1NB6FXylPFB+bs
	L3Y+83iphqnAnNLte1QS4k5WpOAESIOEkcAK9JzLJAnwEJOgqxKfnBxDKDabAIhGTsu8npV2L8O
	oh+Fp5
X-Received: by 2002:a05:6830:6a97:b0:7d4:5057:5ad1 with SMTP id 46e09a7af769-7d591b27bd8mr10409218a34.13.1772537440265;
        Tue, 03 Mar 2026 03:30:40 -0800 (PST)
X-Received: by 2002:a05:6830:6a97:b0:7d4:5057:5ad1 with SMTP id 46e09a7af769-7d591b27bd8mr10409206a34.13.1772537439862;
        Tue, 03 Mar 2026 03:30:39 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:39 -0800 (PST)
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
Subject: [PATCH v4 3/5] hv_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 03:30:30 -0800
Message-Id: <20260303113032.3008371-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69a6c660 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: CwjQ5bEfK_9-9NaFS50gFv7aiW6wqyht
X-Proofpoint-ORIG-GUID: CwjQ5bEfK_9-9NaFS50gFv7aiW6wqyht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX7lYenKvMnJjn
 CU8uSWzp32T1CByqf03yIiscvJfLDB+qu3zw/G0o1OJpjCWqIOLyWGSOmH6vZ0ZBvma/7w3YC8h
 ynfPgtn9CZ7diwf1S0Q39ZV31lM8DFIgsFnXQIAJSiXwID7Ay4PKpiSSgeIxt+lUsF18yommJBw
 NWHV0W5uGDeSV1DqniOF2gW6WCSel5m3ctQSmuEN9xnvYMK4AisH4t4ZBnY1okFqhU5J749cLXC
 RYOEDoD7KaF90p5w6hx1mqR7j0osdbwbzRvQrRhGsXnbp291+prhcEoCD6CMlvK6+vq5AwUfY1u
 P3098DpNdMWzMXvi2FBPFW3hiHHORSgPhvvJUJ1+nELbFf+Q14EqrzgBQuy4QEF9YPZQUgcUJgR
 COY63Tktbgsp70sHnEpAK9kTx+K/GpPS97BfL7T8BrspLklHvkG0d4t3WvhpJYe1puYEhrZq7L9
 0WZwhkvb9mBToXrplTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030089

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..09da68101 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


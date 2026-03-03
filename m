Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA348123D
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537447; cv=none; b=e5Hh6pl8udaw2LcZL94fA5kvWBlCX0SE988rliSmAx/fcC33wAwWsO7lgyX3mEGlP186G8ilfrTrCWvHc5IL0jHXt/75d7ffzduypTDyy3TtiQnQSVjyXaW/0BaPugNiMPVJdkqSm0y8dELWbnTGv85F4ulcrEe+GWzIwnB9pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537447; c=relaxed/simple;
	bh=8F7Y6BaHZbh43Wk3k20V9g5wbvrky1vi4UPv8tA+Qoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbSIc8Tj1Am7vqd2nEnIQXQRjd6A2+ULfgKxlf/Juth/Dv1441a9T2ZdI3BAZAxAnj6QvJjNI8yZs5aEwomNMlpuUPBE3ehMhZ34H37SrTCGK+cC9AxruDjkVAzk7wCR3lrAJythRAOOU2FmLea7dqonSe9ZZlPwdmJzSER2W3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QIFxFnmb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eyl4bkUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIFxFnmb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eyl4bkUz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239nI5l2630357
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zrUsPz7mski
	9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=; b=QIFxFnmbXG6Yb7INz7t4sLwL7mN
	ZVGVg3uC6kBrgYgBPgIyevgE640WHF2F2g6Ee/N8dUy1fhW5T7ENVQf2IzX52DXq
	wGwk+eOQ7HYbv7bK1rTo1NLv3Ob6QwRIJLQ3qZN4qJRQEYNyFvGWtC7ofbJUlk7r
	SFhuOAIAR3sJ8WPaQwrSowQGpmt3NVKshjAAE3SSBORhXHAwZpR3usEvQUkxTt1x
	oCy0DYmoL+NSt4qjUvBMdb9JKiemCouKNA5vW06xuO09/mVHokr6zmrIRsapb0Ur
	PRXp09N3P1i6jXoo1PCoW3eZNeXIobnFjPjeZbDqgzSFMNrU62HoZL+3qaA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx5amgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:42 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463c632f9a3so60412356b6e.1
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537442; x=1773142242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrUsPz7mski9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=;
        b=Eyl4bkUzO63tHh3QeMiG4trRd8XpawW7HsydplTntGXPlGP8RC8hbNsZoHOios6tPB
         zFhvxljc8aIOPpxzLokUB9pnhP+yeTDJzy/Z7rUpKKtPACQ1aBAcisuzJtT7psJEZr1i
         2qy3wOiHnn811Whs8R7T+xRsI8JLpvLhuunIcN4GLsPiMptk/fUh8kYvQHUF9476dvCg
         tEaOQQIe+wjDmkR1yAFkNpLclYEm+kBkn9O1o5C6wQFNKdwW0fUHmxgjEt8NKRObD+mh
         CfDQM2k5GYcmf7/mz+zh5yIcqsk0g1zpc8AetzgBKG3fviSHhxPIqYJcXp53R/mR86ac
         XjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537442; x=1773142242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrUsPz7mski9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=;
        b=OWMcRwcp1rThHgvx/ZaFPG58w5ES0dMS9nzOOJEHkzz00I0nWbB8lXW/lNYLkbfxTe
         haTUiArB7h0GpPLWupDCJD8D1I00EBeLJ/vEu4ETr4nvSBwcnoinyUlhAv17EBrW4ded
         bAZi+8WS2RsCkXtWQsghCSg7SSSnGn6iNUG8UK1wAjXOdEuLdOOVyqLNScMtYPelU4a3
         mMm6By5HqspxyJt0ym2ovcEQC9MWkEpTJjx7US3/yqK0Rv1pKBfUqnqJRSWGfrfPIlX3
         aT+4Bw+DT6WqbDlnZonJpf/O5vw3+7mg0a8s3wmb4ZpbFn1n4HpvwXI/Jc/ByWa+y595
         xzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDLr9qyTbDrNaJvRzT4U9PcBDxvIrP2TxMteg0iLmJWMUM7r+rZ2B2IXZzyCrHnN/fGs7Oh4ebrKJ1+xfSLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5ecuNihHoOwDR7qj+sCYqQ22HE0jBuM5jH2fmunBmS+FYFY9T
	nkwcHI/6aFNkr1VNr3OHKaXayECUZrewmE5h1zVXZSC0synNflVe3To4okkPvHbl78QSpYNH2zQ
	TX8F6tFpQEqtLBixfB8zKQoHWPu2lDI9e0fWUUBlx8jl30yDEUI/sLZbQ22FkD9hASZgIdQ==
X-Gm-Gg: ATEYQzwOAybdtx65KXdCMGy0WFwqcw1gVQPtZRXFZ+bMe7xJo0o+ikKlOJ38o2zBMmm
	xbaZfusy3JnfpnWAYdiqPjWj5+0GPNTL7Xh5LdxaeET7eArh5g5SaKXua8YCop1NQNIVAXMIZl+
	aRYJK5Aq6/FY8dvzRthTa2dOXdaywAUOCvXLQOMHfuwX8jn/M+fVymYHoOQO3GOqNIQSQ3wiZsf
	Ix9I2HUAKXusncvnF4fccIhkTfl2wZ/73fT667X6z5PSs52C8GoorpOdpZm7XFzr3XuT9p/bgvj
	LugLk6475uG9N0N7G2xfloOYhYEM/DUORM8dhKJCjaMBY7LkdQNLfRDWwBTep55KND9yRKQ4uFJ
	vlOTD9ij94XBlj6GjzqDxE/vawf6pfPjMLu1HOCskWVU/dDyg3WVsY4vlg0k4QEMYXHXDOlSPOd
	s8zsKn
X-Received: by 2002:a05:6808:318e:b0:45e:ed45:15f4 with SMTP id 5614622812f47-464beeffd1bmr9623212b6e.35.1772537442043;
        Tue, 03 Mar 2026 03:30:42 -0800 (PST)
X-Received: by 2002:a05:6808:318e:b0:45e:ed45:15f4 with SMTP id 5614622812f47-464beeffd1bmr9623187b6e.35.1772537441604;
        Tue, 03 Mar 2026 03:30:41 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:41 -0800 (PST)
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
Subject: [PATCH v4 4/5] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Tue,  3 Mar 2026 03:30:31 -0800
Message-Id: <20260303113032.3008371-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfXw3q819XOoydy
 SxEPzn4DpziixZUjTT3fh292dp6/wLjT66kvSRoMT9EpwaVInIk7BkWr/PIHfYFfJapKNovoHhH
 O0oDTXzfu+9v+nqVrW17Zju0mxGzH0cKhEY6Al6xfh18FJN9yDlS9V2rw5UtEL6X63U7uabyJA5
 eaUXdkyViEaRCyrCod4nR1GXcHYKJdWUwzOKpSrgA0xbZYd7p0t2x+usQnOUOCnsRiYXrcwUDOt
 YFF2/v0UQHKZwO35MMnIvtJV2LGL4uJYEQi6XW0LSrHdbVQ/QIOYnr/N8P8GQzHWab7yKHbuFsZ
 ryQnTDHUoeAV0TCvercxIO4Ye0KeOsap4Aa/5cZSVwS65o10GeUsz0J1PpVhQhM9lMFMD0GU8V4
 diJc6mANeBZaxdFXUTpsYlFreFnpZ6m8toH1UcngZlalKi8mQ+j0QUBNsvO2b69AmCq8UQzfUDP
 aS2EKWOrKpJjg1y3dCg==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a6c662 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c6WgzpUFESAvjm-ZtrYA:9 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 3n-A78gF63HDC2hl7a20CbtCGJhxNSYw
X-Proofpoint-ORIG-GUID: 3n-A78gF63HDC2hl7a20CbtCGJhxNSYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030089

PAGE_REPORTING_ORDER_UNSPECIFIED is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_ORDER_UNSPECIFIED to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.34.1


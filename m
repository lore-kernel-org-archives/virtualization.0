Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CE47D93E
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537442; cv=none; b=m4c6U9i1M7n4/MpOJm4Y5zLSmqrLWNEnQdhCxdXSd6fk3dY1TdpDwHiJEvZIC6Z/76/YUEdjRvul8IZVQ/ZYZcdzd9hxNWGdzbnw9SFKDZXkMRWvb+mSagxG9e+7d+UFEw5i2gxcIKJImaLteHuT6TpMMRVAYXfdnPGVoOxLQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537442; c=relaxed/simple;
	bh=jY6mRvbmqXELWJqG0Bk+K+vTmlEB3asE/vzhP7nfC5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZR2vep3NIKYnLAZuPaBTSM2h7Mwh0vxkFw4TsI/PtWfcDKIFqXkPjYd5ToEINsAxOgt748sb8z5s9jB8K2FMyHFkLd7To6+WC/X4Sfw15pRZlKbSb/bzcz6Lngxv89lg0k1E5wcIfT8MOaXh9JI0bhawW2MyAyjEufw2xwN1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIppyilW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jLvNsbht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YIppyilW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLvNsbht"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239moLt2733596
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D/GrAB9Zzdx
	foJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=; b=YIppyilW/cAq+Nt7dLWikSamMOV
	5hdhDDms0iUPUaYdRSrcMoM762jvV/Z07RAsZqVRz8lV0HpSxBnBIUvXi8rydy4t
	lw3gwOzdTUVj9bJAQjk4I50p6szGyJLKK19C251YwnUDGPHlMrHZdV5eXUuqe3kF
	paUs65cQeIJxtjdMESnqhR0yBF57NN/AR3sytri1ClNFbRD091zeFIe8scYxe+j/
	2uTY2cQQdR6HP9C7h0jBM8xuMbpjmbo8/ZXNmp8Eg/3BT4/PExwt/7EbX2LS68jn
	fu/Bx2Tk2T31VWthrr4d8n4ztkU0s+QrDgV2CPFGEaIaufPr0IKqG1gK5hg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe13d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:37 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d18e95c658so40520774a34.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537437; x=1773142237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/GrAB9ZzdxfoJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=;
        b=jLvNsbhtZ9vc249nIChxzmeUP8qDg4of6xdQhh5+kGWTnot0R+zmzUTmb5NMcxuMa8
         BgijpiDNRBzEDP7a8ESp8328zjPw0CJ4/0+kwV/kVKsorsclVCNjIoLpgKx0LTbMV7F1
         UZYoUQQofqZUm32ksHvRhnqf2nbLf4qhtqGPpr9k7zq4wqt2UHCYei9htc+GkOTkQw58
         cDVBh4HMEcRuxytUqyU8UWEkcpRTYDNdyFGAgrCC78lKJl4Y/WqWnPlKLCHkjG8apgM2
         Lo4xrU7CI7jYUsI0TDnmpfz5p/RS6Qsgq513dSxBvmmWeDpmiirIAnIWiT5uqL+1iOGE
         xVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537437; x=1773142237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/GrAB9ZzdxfoJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=;
        b=jTXVCO044I1r1QRXWN03b9YTfIBX7bt3YBtGL5ts9DBejQVTZqgSzWmt/F7TwvsCVA
         /p9kh3vlMCRe6jHyKAgVK/ehE1/FX0R1CZ4/R+TsCFb/alM27WC38zJnwVkVm54RiDw6
         5lB0tL4YM55jL63hA00SJolPSCDzcpkJfH4GwghvhBaIzkXk6bW1weSSwe+EOrVBQire
         uQ9dHcD1BU/PWyewK14DKU+RNn74ynkv9OkyfpZLG4an0vnd1Fg3La339KntdeYtGX6q
         V5irCESe+byqFDFxb+ZGvR1pzlFW/q8DTVwpAEoqdiScEG7MZd6IN2XLYjSEf3FUTvxp
         7TqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFo/5Aabu1CNmhcWA7ffOcriiSQdh2n+gGfTH3RdX1NkMZIqgvxTHFhl0/PyZWJy/UuXxAdd4dKO4eVn6nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YynWd3Zh/9spKn/oeSReD0xAhOY7pwiAFHNCnYIJ6EC7eo8/n7F
	Upu1NFLINR1IvcEso1Fv6VaC3Xd/bnag/dXxWgnFedBFaho2TszHeQ7vNhhx1X1Z+1fzr20llxW
	QViLG4CjjVS68NnNvSrty0VIRcHQrcw8Ciq8UjceOGJH7iBUaFXkxLopfM+Tv51WXFC6m8A==
X-Gm-Gg: ATEYQzxVD1p/tOoK/I0gsjHNJGztM0RO2WM5UTskst1hmCnz6pVzN/zD37sCtOsXmUS
	oh7pWeq3Q/As0FAvuoscQzxeuBrQ8401FSdLF2p5nMJsx5i5FK3SOdUwBT7ADEPXeCZdQMFCY5P
	FR/KQJrfKKEmBuv6YqNZovkUOKyFYZ8L4wiErcTKSWQoxOZ6jQiHFusAIQ/B/lK8msM3wriWdXN
	4NYKS1T7Bcn4J2AefFVjmXMp3mWJEAMlXVghpdwRFx3dR97/AL0jel0ZJn4oyimQXP6/2hvToFb
	wgJPv+0/YW2foy/pJy8jjBoci//FRZUsu73Eek6E1vj0eop0jHNrNc30/cNoSdFMk0N4qcQ1TJt
	moiIYaUC0qQKbipHPgQM4VFBXnfQisCE8VS+Kw+vNa+pgDxksAb12k8XHtaGj7cBbsi4BSbzZdZ
	urn7aa
X-Received: by 2002:a05:6830:621a:b0:7d1:90ae:bc16 with SMTP id 46e09a7af769-7d591b6cb55mr10355755a34.8.1772537436999;
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
X-Received: by 2002:a05:6830:621a:b0:7d1:90ae:bc16 with SMTP id 46e09a7af769-7d591b6cb55mr10355739a34.8.1772537436545;
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
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
Subject: [PATCH v4 1/5] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 03:30:28 -0800
Message-Id: <20260303113032.3008371-2-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: GFLoW6QUXrP6BMOKQN7ooc-CkahaSsJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX2fUPCIjhytB6
 Zqsg17+ur4ysmzcsYVyhsdT+k5zCQtcJ1l4EPg05G4VQYmXah5NayRy+A3X90slJVgmQHUABvo9
 irt1U/26w+yYr53l2+p+MTkMr7YDo5cqNfTPzmeF+QV+vrXXV7v9e5iXm0lA3v34xk0z/+bM2E9
 vxt7ZGGACl+iz6rRmu9d8HUPdPDX5HidI5DPjDUrIEJ7SVa4UZ7tloZv5W9I4k/kP2MS/R6qeTp
 4E4hHqAzno6FI4EIbABS8L7W/fz7TSmRo7XV6u9oVG4knkBMRpKaEdSnQ8yDX6RyXZkwUGO/ISJ
 yauw5A+P8mjv5nTbQqXgeFF5iJzgeIFfX0DyBaBSpSYu8g6AkgidxhskRU1A+p0DKLNhXJjOwVJ
 7sTP2NKhoBISDavW84eHwtHBjLPEza5YbgxTbS/rd0hMnxkV56ehzLiQyr8Q8m5YwaF3C1TisdV
 u4mrmTPRWbqa7GT12ow==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a6c65d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=agIWOxjPXKrzBStnBTYA:9 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: GFLoW6QUXrP6BMOKQN7ooc-CkahaSsJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_ORDER_UNSPECIFIED and
check for it when the driver is being registered.

This macro will be used in relevant drivers next.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 1 +
 mm/page_reporting.c            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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
index e4c428e61..a97ee07cb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


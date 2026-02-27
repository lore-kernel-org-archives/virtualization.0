Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57A423A66
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201228; cv=none; b=j4lxfJe+OQfB+xTNmt+HJoc17acPBt3IOHmdiI83iWXsJu43/SPq4DAoXoKlfZ0CypeI0UNGOWcqiSCVZJxKprwrV3E310eZ4+rfzwwpuxPNh1boW9AJLxijFVRzLPnU3agnt1MhaezD+xTeGJAU1PIqiQFmOX5i8DNT+UPEcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201228; c=relaxed/simple;
	bh=2gj7W7Ro6qYNuWMaV81IJjR6heSJWBBxVJC4zCRDsF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmrT6Gr/dToBMaoYHEHVQM2rRvHFqM9OM4W6d19yKIrxyZTRtcwvbclMiuL9ZDIHB8oEMTcu5GDWDobjZ+Bl1+wM4rija1Top8JEcU3rupjaKClmDag5L/L7mLMeFmgW8Us4dIYUq0fJ42xmduQEzw87sk+hntglRfEbixrgq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhFR2Utr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvSzQanG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhFR2Utr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvSzQanG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RA608a2439951
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AYPpVEPSMuP
	PvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=; b=ZhFR2UtrCkUAz0Gn8NnIYKS1xLj
	lLZwdRkb1ryKwiwJgp+p+CdDigW441Uj0/CgPT8o1TZorNXDfZol8EhkzCI0IbbF
	EK9ciAWiY3oIEMjvCL2javeBjUVMJaQZ3ST3Y5G7v8RjS6pBtWYjFIHS/MH8cpn7
	NC0xtuD79zH6oUeDelnjpB4qaX9gxDRv94RJbEqX29oi23Ulq9xE+sSMEAoqASEU
	85DjBpGWN+7d2d8S7WHI+T9hdOBWn8mZLGqFqe8s/Fz6gmMSBN+MDn9VtjYxJLx3
	3y7jifU9ABBzF8xMpeMuGDhkArYgkuz9Z276NGoTuVs5yat32ItWmtytBHQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r3ma5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:06 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4d4db1523so11052189a34.1
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201226; x=1772806026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYPpVEPSMuPPvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=;
        b=cvSzQanGFCAaS5IUFphJN5GnR2pwRIjXiE2Mmsss1zp434SRr+jaHn9oEsZxuCR2vq
         RtbT6xcJ3hL0pznrd8FUgD25tc+EjhkXCLcwYJK+t2EQLYgzOzOmaEL4cwtA+ppzzb/s
         1xmuyCtQdvln1XZYKLGOmjThnHIYyeqeqgBq+Le0pbK/V19bdQVadfmwN73sKi//zcq4
         TVowFfXFVJxFVYEh+rPQncEooHddERfxjReamtOg5Jm7d7eVC8NW/83V2T9QWDMiYzih
         6WwynRGdB5E7GNs3tNtzBlL6kRtD4gAujY4rnTZoBjsg5sfJ7HJacsD7m4B2D71Le/xf
         5SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201226; x=1772806026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYPpVEPSMuPPvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=;
        b=l8cxCL+Lt8YgoqISQIKUsYMWIYjZaqS9ThAZXjpKnSpTC9LjhtcSt5EShGG3YAzwWA
         2/q4lyh8pYlIimX9ZXLMJZAE+06GnADScmMib9S0J8cPZWzafWqQpg+a8HQWXMxByqxG
         PlZZS4tRpfNK0ROJYazZ62x7aeetXHr1wU0JXRAMIvjbkq2PRaTTc3ZFr6dWKmQdlNqn
         zmeDay/lZf4v49qMrjnZNpCweaOdv2EqQcku+Tmt/ammIcvkR2n8tWWrvx8cPP2dais3
         J0Xeysg7H6ViQGH2HMuG5o/L70jRHWOyyMaZ5MRR/ABHfGzeQOCTYN6v96JyXl8KBpyv
         wzgw==
X-Forwarded-Encrypted: i=1; AJvYcCWGmSXg+TV9uRmhh+KInIEOx13MnMGRnjlTzFLw0QhvDzD7CuONYl5PnJOv1lyK9uAzQQVNw98lmzjkd3RZ2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRyDrolMDWaD80SsuAWT60ML0xX3qPHdaDtFJGw/vWI/zq7s9M
	J/baZlilggbFz7SSc1f/1CxvHdy1ZXsPN9ktvXzyUJ+G+WFZGZw3ky0oaETKQgUDFj1Lg583GWG
	soBbtbPafgTGE7GFw1cLPfE3SO8i/Px41WxXN14nEpJHP7CdTTJbaS0HYOT1rijmdsGkvVA==
X-Gm-Gg: ATEYQzzR/44vT0bsfnBbgELMgGaGRG3SxHgtI7as9PpOvd1j1pH8fNuMsWgklnD6RNX
	WBPStf6VRozioWJ56SwKvnML7PTGX7YZ5FNopdi/PD1bDw6yMv1At0J1tpmPRhuRIQzxrZlsJsA
	U7y2FxBmf3SJ0kyk6rzxgbI4KA1RVgOiQacrI/LB5Xd6Qcqh2GiTJdmf+Xl/YneUYK3sVwbNhsB
	tyk6mwtwU61gSd3LcHaoAFvrgghwbqol/04VmBcx6x8KouNlFt0v2bVL7qVUA1dFjEu+nEJimyP
	B9Y3eX6j9atVkqynEsvFO/aajP++8ctgAGLIzWtApaz/ZQA0+l/9/JMo2B5WRCSVb1Jj8ayzspE
	qtegzq9TfswYmrCZB/qb3hFtH9IrVnumC5QRwT2ntU9vQCNWrAjwAOwvVQ0md/JWa03R/4RfvXO
	O/xH1V
X-Received: by 2002:a05:6830:67fb:b0:7c7:69c8:2ce with SMTP id 46e09a7af769-7d591be2615mr1920087a34.27.1772201225853;
        Fri, 27 Feb 2026 06:07:05 -0800 (PST)
X-Received: by 2002:a05:6830:67fb:b0:7c7:69c8:2ce with SMTP id 46e09a7af769-7d591be2615mr1920072a34.27.1772201225419;
        Fri, 27 Feb 2026 06:07:05 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:04 -0800 (PST)
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
Subject: [PATCH v1 3/4] hv_balloon: set default page reporting order
Date: Fri, 27 Feb 2026 06:06:54 -0800
Message-Id: <20260227140655.360696-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX74rJhXZlnJIo
 3cOp9rl83+qaEboGjJi2ainRjh9S/mLnuS6exIodfezmm80kbaqDL6eLt7Zi3QfetYNi204PjB1
 dWoCUn2oHpEpJXqs2pyiV0gG6cydyRBEQ4rrGX3i8NysJe601Pl7GrOJBIJv297BhewAB2nAP3Y
 283PrVlZrP7cc7THWmccD7VpnK1CXCwgCYHaUuMoVqBm+uW+M3h1tzQs6Si9Q4f+Ka7bq5SQ5G1
 wJap3JzDzeCR2V1m0LmtZ2MO1PLpPRELXYIenIG2DMZZJw8VPoPpbubr+rTG+ATRAV541bYbqp3
 Gw6tjRVsTieLRfJ/wcmB3ULVpGJSEoL7UotG1plzlrgsLzeAAqmnqNEekeTdtIY7PyILJvjNLZZ
 cHcb1FxPEXmI44WBIXSRhQ2TKJ6gFoT6NrXWeLo/1sOI8pt7ZT/P4BJw76CnZC5EAXpiZJgwIFK
 bG/eoKfjyrPemovxXVg==
X-Proofpoint-GUID: crR1lJNqWZA7E-DljGeklLU1pLlilHFf
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a1a50a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: crR1lJNqWZA7E-DljGeklLU1pLlilHFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270125

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_DEFAULT_ORDER fallback
value.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..3d6bd9936 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_DEFAULT_ORDER;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


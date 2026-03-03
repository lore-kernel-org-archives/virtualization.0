Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A438CFE2
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530436; cv=none; b=ro0zKux6TLAEfFaG5WC5s2oSAtwOTpXXZLIGeti2db3tt3DoLelnHMaGAWdD8c8iSo3HY6PHgt5n32oSzCXydf0VgFySZ2ScTXhUZsO3g/madKDTnyH9tUNW31mSClA+et1fzS9SJHQZ7UdpDpXd2pJHGejGmZFtNnLr6i6HHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530436; c=relaxed/simple;
	bh=v0AIhcPYO4cND9UJsnnpgcg88iAdJ7oWx8LFxqs5UPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OistcBakXlmZ3RKJIl/01PnN8beFdLK7HRJni/ocS6Gg4glsooMujt/7pxNETMch/6/EKeSNzZLRq4KWU1eHMSi2eDvcsD2FmtbtOoslpEq/jhY8inDCuZinrpztIWacz4WejLU2WjXpGM04AV9gMiOy242RxzWnsE7lkJUzqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N012rIsr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CdmXM032; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N012rIsr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CdmXM032"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236KVxU1675548
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 09:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GErfW5OKwnR
	yFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=; b=N012rIsrwpXUlBt5lmhbGwMdKNS
	HYdreAEP/Mtf/kznRAcoBV7eRxs+pZwKcWXeKd/Le3LkbCFccCECNy4hFpEoicA7
	AxCf0vxaWYougI/3vuKvORxphPWjP2k7INhJKad/VQryitOhUracUxaoUxyvP/+G
	FdVWfd/4rdKOYrHZLWAA59TVtnXS0abcW2r9ALjIb8dYl8YC/Q0sir1rrBAUMACH
	jPdo/BAAXB22BJ5xd0gmn0yLfVX+4ClghL5CkQq6FWaMie55AdzDnyM/Flth0iQ+
	VlRK9bLpQ3LbFBiI+YaiispsgStnG9ArOx+AFAJ5CQifRSr7eMLAvNsUK7w==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsa7fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:33:54 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4639eb7bd4cso25655777b6e.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530434; x=1773135234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GErfW5OKwnRyFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=;
        b=CdmXM032lKtc34kqvC5MKKWCNVsGzAZbqYBjWZ7grO0Z/CQmeur/q37UA20zJ/wB/V
         b/0H4h81bZ5wkkwFEmZxOtxaNGx4AB5QrMFiSKRfEEYQJw8gKdjYC/rpIKtx1dTCSRj8
         R13I7wf0ax1DSlEGxwDLWETsqSXkEOWvZcS+3vO5pdYTpqe47eZcvDldoEhAdly4ht8L
         Awl1vaGGAPp5vofgttyiuuSebHIekbkZdtRzTTb28ZKS/oNNTFKD4fRDQ9rSmJCQfHxi
         x5JMeb0wEtrBFtJaimY6dRE5R4O+ubjOTCm1jr12FYx7BU6PyuzHGmstH9bWavksSbCI
         UNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530434; x=1773135234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GErfW5OKwnRyFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=;
        b=QgkmYrmWQcw7h+6D8JEyl3yr0BhbHOcbuKWDLCseJIFJeU/l3VciGRinxzvT2tp18O
         /MtcQoT38QTnmu/PRAiPUz5X+B0eSl37um05ocMuL2YoTUcpJouSVQnVh7jrNuLlHtFl
         iqo1aoxbCEji2E2fd/SkksATk2A7PL/QhEqmp28sDwMqQLCGgS+z/gKgmwTjPw/rjg+e
         Ig/3CE5bucdz2uQ+Sny3pGLFGi9O65L3+/tamADdtf3+TiIYRPzI1ohSNMESn4TSmNtr
         QXye2jyivl6DX5b38fBhCghaAnFYR1rg26hq1Pd3swGHuXPpFj65Ry55HczfyexG8crf
         CVDg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYJhjsVsmtCSPgfWBROGVGQjsijDcurpPHEXjzaD4P6KgvW4gfaq4fg4NpmdrYG5mgdBS3WePlhZ2GD2euA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+OJxntaU8OzHBrujEG7RpDaxSUaJk4gD9SC9cwTGPDr8wQVnq
	SuukfDwFsv+DY82ALFGPXCqZAiLLt0JZhoQRZR/xC/eT06ailEELB7ZGA+2IxVRuSBNSKTRmQo7
	F/gcWTZqMKSWUvQjmO4eXBQfShMl2kQ0RPSuuM2KPuQi6gDSEPSujusF3aIA1uDwvA+HSsA==
X-Gm-Gg: ATEYQzw6kMDc9DY5++cOFsGYYqX7SA+0u5qHdcmdGTv45c4A/fV+20yfjWZHC8aQ8fN
	i/ZTWJE07gP7ZeJHocGOaKH/BYlloSGcLOcrzOLg1RG/sjy+VpImV5v+LRZhU/g/WiwkTT4ARtZ
	Pa0bmpkpRyu81qDSdToY5tfbnKW6MkyhDqnSm4R+SB3w7w5r6tx/JZtrCGBmU6AfZls1UzYYBfa
	7tdolYt69lOY11LGsEGqiSMSOeCMYjK8/qpG926SKqOvlgfrQxhvNtaaJyz5cqQlhdXH9qVQD7F
	/X0lqG54DBEbN1U3OppCq6uapmk1Ax5A85fb4Dgb0Dcw0r3xGKT7U7T/zfHPu5cEsMufPQQTZEv
	7lmOXw4hyci74Y9ryGpcY+voen1K03s0Xgs6K6fZnYdJRZx7rS6zLLaolIcvFkX70t3eR44DyRp
	/3MG38
X-Received: by 2002:a05:6820:4b85:b0:679:e633:6f53 with SMTP id 006d021491bc7-679faf9d7d8mr7935891eaf.68.1772530433738;
        Tue, 03 Mar 2026 01:33:53 -0800 (PST)
X-Received: by 2002:a05:6820:4b85:b0:679:e633:6f53 with SMTP id 006d021491bc7-679faf9d7d8mr7935866eaf.68.1772530433239;
        Tue, 03 Mar 2026 01:33:53 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:52 -0800 (PST)
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
Subject: [PATCH v3 5/5] mm/page_reporting: change page_reporting_order to PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 01:33:41 -0800
Message-Id: <20260303093341.2927482-6-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: N0Jg08ZpsOWJzRacb2Uk_kschE_wf8KN
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a6ab02 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=snxPPiGZoRN-_fWW4r8A:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: N0Jg08ZpsOWJzRacb2Uk_kschE_wf8KN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX7fsskF0UrOa7
 pK6ZRsudLa62FCNRca5/roDJfg2DG8DsL3tlBJ60k099dKGSKlJteOqVMU9QyYLe8zqDeyIwcTy
 TYkOSW0XPzA/PZW9JGnm4Cb+xUpIIuQ7Gz6380j6XBjhJ/9OtOfQOui89JjoxDq6mHXbRqmctWT
 fRs2UZyMWxsVR9RBmRamdPuy8s4OyhHwqfPS4GOYunTV18AMNYknlee88IikihvEc3zkLQGlUyz
 h4qtHKjJ42XQzPlcEW8/7ntiiGdy5kJCzfikMmxtjUgIe4s16S7BipgZzill1POegzrAJewOfr8
 n14p5lTwhTUZgLfEX9rB0uze1V4FZzrhuVpoDsQlZzN2J8RHU3XBFEaVC+16BqSDHTGS3fu01Fl
 MMRt9CHaqtaGzG3X9Z+OmSTcwmQC9hGTaIC7o6C9pYvMdCJ5vh9JWqUc5JphtCnjTNsaqchLEha
 pPLUHUAFiBYOVYuT9rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071

page_reporting_order when uninitialised, holds a magic number -1.

Since we now maintain PAGE_REPORTING_ORDER_UNSPECIFIED as -1, which
is also a flag, set page_reporting_order to this flag.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 40a756b60..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
-- 
2.34.1


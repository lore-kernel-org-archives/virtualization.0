Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C238E5F3
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089300; cv=none; b=HwF1uOzYDSusOKXs8dJnjeXrgxC6v0Ddcko+jIQKahBmwUivUluYA8+aHOHqa4CmQQO/klL3uNqICji/6TJHOSOqcK9RwF3RuPfIEKXEOyIaYqUk82LLVApKl5D3aN6vBFIoY2Nqc60fobkRJbs7Su6uph4ABwnO/ZLhQ4KzcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089300; c=relaxed/simple;
	bh=fJVeQnZOXsqmKakYSspmc2Cd684q3NJFEKQQw2rrZCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZT6dVd6uJ5GMBIJ0UmT3Kmtlh6VFXmifycfh/Dnug7NmoclDWkh1xgJHaicEcb6XoBxf4fh9Ey9q5R993VoNe2dRbyDjYxn6bgyT1ejy7CCYMbhKwFeWi8vZimpAwZtW3wMAkN6bpb9ej4kkCbOWtIYzTChCMTNVA16pzM1v/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9ooljO9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gb64RqN2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9ooljO9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gb64RqN2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V7a9918911
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6H0aClJ1xZt
	NoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=; b=T9ooljO9Kk1qnZracN1UJbAAvMq
	VxO74DKciFOW6Sg/H/ULiE5D2SQ0Y3bDZANp42lDFtUq9pYWcIBz8fgDcSidCyuT
	Rgq2k3zjKiPD+4bxX6U+UbuSlfJxXfXbIy7pjhJaMIf9+XW0PJ5+pyAQdch2Dxth
	rZXJkLHOT8cSMXQjD5EaRVm+gpsWv6hshSkdudyuju7DQQntNHNU7FISHbSv8IMX
	T3c1qI9rqzPfNbolx4GtJ47AGeayRFXFhQQPXEjtHYpn8ZFT+GQY0bd+NU4B4vY4
	oEA6l8CO1gwZ/VL4gg5FftQ58yikFq0hCKHqUvKUNAUKVmMiUETTBdaWFTg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj4w4t802-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:37 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6798921eff4so10206544eaf.1
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 23:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089297; x=1772694097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H0aClJ1xZtNoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=;
        b=gb64RqN2jgwYYcM5q4lpp1O1qraEa/I904lQVLef6GONBuIZMaf6VUjV5plm7x+hKZ
         vAZ4apAu7bBC7aDuYRc+AEk/rxK1RUQKYwNWbaB53R7bB9MMWIRTH1AFqyo5QbsXwSqL
         JJS0aBJvjzt2pvRqAW9KWd0lIA4YrDxsKPV6J5dccXl7Nao3Wg8MaJR6/uJFU69z5ITE
         DoSGexIqp2vJXldbPYjb6DgsmfiGhH4lrTaEu2fOQznIZvCZY9rvAYlqsVBD8WBmiyZk
         EiVy57NQZyDS/4dFQnPFqR1e02sJvbPnQlhHabLbMwnkp7cZea1tiQf1bZrZfwSwbKa8
         9wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089297; x=1772694097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6H0aClJ1xZtNoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=;
        b=kAbQSxFcU9EL6ioAxEyx4F7JQ96dwvSEj9wRlygsjjmFX+PSYscXeaDh6E5YGByoy2
         R6koo1X/lGM/vdeqBQ0cPw9KA6P6iHeWxTDmC6W4SDjIU0s2mMJTNWHHt7n5/Y4z9glQ
         fFeUwVYUZ5K9cpN6Qtsmw5oDNb9tXWMt68KYSqA/l+0cYjpEwVjouNV4sHcNf4tqKotE
         GNdeZX40PvoqJh9CqKYlOMfkKaQSVae0lUgZ1mBs/Fpr8NjJYT+lwCKnGiBdiRCp+gjn
         cBHB2EfJczzXeRoajDcmdR+MYxSg6gTi8WfvmSwgDYh5DiNcwDQ74OQlHct6S0BvGd6i
         hyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD4vjK0KdUBNG/H8Js6g+3HSHojyAqFVF0beDEDxsBVcAFYyTxy/Q0M8mLg0+psAEN/rEuvV3T2DSyBAEydw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH96NJgOtyKwAU4nyGHDU3w58iZNj9jeiCbHYvJ6/Za4WNcU2U
	8QRAMD2+cENmxlMIyhd7l/lx0hN7m8KLjgBWymqwbcZDuktg0vONFYJTNwxVuUcj2Dy22I8gaTe
	brBU549Fl+rJdOM2X1MIQYq9Ke2+x+aHQ16qmN186ZRy/S6eo+6ICt/6aaS9BKdmMEcNwZA==
X-Gm-Gg: ATEYQzx/P1dYExHMEBd8HNAhVXX8AORywUDbvPRw2JDS3fDqQz5kpaYDACcY4RxSH9X
	qqULMEI4x8BPN2ScnGBvVXaWemFXWlskItZXlDmkeQjibgpp2ISnt2UCf6sRLf4a1wGJOvgemdk
	ZnElvenVioN5ieWsQBSb5wtsvPvi66hUWM/lsx8jiBrPAOP7ylR7II80Ml8YH3TutoUUmhO9lnF
	Fe8fwfviNpk7HobOYGKpxaV3VLI7y0TlrSgJtbX4/0r7cxjovvqYmHA+Qq4LQ0TKLjOXW4LFKBN
	UaadSiXrpJcp7P4WASamTFWWppqa9RvJUBDRKRzIeHcw+G2mf/U7BhRF40s7Lz3U9IMjvHIPsTF
	C/8+501bg39rm+dCdPewJKgLY5RbOMWS3gNpBZy8Hi3b0roncmmWYq352MOQW+sWwgGYZq60mnV
	5YCImq
X-Received: by 2002:a4a:e842:0:b0:679:7d2b:4362 with SMTP id 006d021491bc7-679ef9653d4mr1803372eaf.48.1772089297406;
        Wed, 25 Feb 2026 23:01:37 -0800 (PST)
X-Received: by 2002:a4a:e842:0:b0:679:7d2b:4362 with SMTP id 006d021491bc7-679ef9653d4mr1803232eaf.48.1772089291548;
        Wed, 25 Feb 2026 23:01:31 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:31 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hv_balloon: Change default page reporting order
Date: Wed, 25 Feb 2026 23:01:24 -0800
Message-Id: <20260226070125.3732265-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vUaCRmedKsPitZ1ysOqe-CqOFitpCDfs
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=699fefd2 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=IMYoWy77fT7TwZj6-SAA:9 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX8byqDFA9BL+L
 Ng/p4YuXdp0L/7bIcxf3F/j+jr1O+n5poMa3189ZsXulOkYjQtxbmvlJrCKeagSusV/KKVHU68U
 CKDPpCPcCEDQXTwzQOGGcUvstsRP790+PLQEMa6g0vhk79ImIEOgrlQjVBtwCuERjHf9hY2kwVJ
 r2LUsJrOPE8UjaDqYHWjbOHcJdE940hqcr3O4otyl7pNCqFXhiyamczxss794xUEHaBsISj2fjV
 ++Rp8ZIqYRrKSzdzITOJPPDtIqXnC7eo8BZV0pZcmhVH8OOq67QWqZdQ9Im1RES9eOqA+btNVxc
 1fAKvmogdls9Ev9SykeR/QFNleIgJbdtayinx3yzUc4TGvaRda6tV+5ahaNU0tAymvxcnB6FF5A
 8r88icwLOZFnrv7p3u4QJwi18SF8AfmLOYkxwHZqnbzUJeLS9rBRaj00wtHzjcm6ZnCDlGqipai
 GvZgYVvwW11PyX2WZKQ==
X-Proofpoint-GUID: vUaCRmedKsPitZ1ysOqe-CqOFitpCDfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061

page_reporting_order used to fall back to default
value (passed as parameter or MAX_PAGE_ORDER) if
the driver wishes to not provide it.

The way the driver used to do this was by passing
the order as zero.

Now that zero is a valid order that can be passed by
a driver to page reporting, we use -1 to signal
default value to be used.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..e33d6e3b2 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = -1;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


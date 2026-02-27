Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A7423A66
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201230; cv=none; b=cJI50voAVd6bxclQTbs3MnK0B1J4kzQyLurcekMy0OPGepl1UwRaJjZDbaSM5oWAm6cio83p2k6NwFXReKp2LaRZo7/p6i2xLXScSdJtrgfAiK9xOwShdlXp0zLlffEy5j3r4QucDU+nkduPJ+p/n3rJGc/2E+FQu/Lrv1qFy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201230; c=relaxed/simple;
	bh=ROmmXX5VHYzob4RcDQXPVNrZadRdQPHuQymrhi8wrIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7WdWhfm187wn4W1+I6DX2Tlc41THvWVgtrxcd5dRHjVO2O+80accyjLl6YVsGBDHYaRtA/hGkx/OhDodJm/V/oxWWaWVCEgDnLcEUy4S89MbH9z79hsTjeviDVOT2Z7WhdaiqZuL4iYgpwslFWYthK+creQCEC9TS96u1bVPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azyUuvz2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PrgJjk23; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azyUuvz2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PrgJjk23"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RA4GLZ2440656
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y/M/Mw/VkIM
	mop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=; b=azyUuvz2IKdTpCeERnBMi+mG27W
	GbwNusPYUJBuAMRi7jt23oZKPEppod3GF1AyL726d/GmEuJLXrj4QBq+I7Y+jFAM
	mXJVqJLQ0goLEK8GRPj/8n1YUy4ndj102N1XnE3bthZ1qhH5fNr72BE3wNawuPQ9
	Jiwb9I0BMGS4sTMm3RDmvyvBYEv4M6+tddAfcZ/DwNmDrDlidnH6/jE6YzSaiDNl
	Tc9nN0gJUhuwVW+vbR8lspJHMk7/fpKcwTaNfZDGKYHjoI+lljYERrALXaOZNKKh
	QEKeHYvsRis+SruC9PhXOMFaZmoZQSFwalfp2b9PyqDHrxC+RFeF416hT9A==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r3maa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:08 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c14f388eso11131064a34.2
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201227; x=1772806027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/M/Mw/VkIMmop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=;
        b=PrgJjk23uBlbnelXFhJDVPzueWL2yN98hYZIHW/HRr7VWbS82UPnGdcY/2u73LnC7m
         NFMjs/uPVeGHyCfksEo0zuwbIWs6guLy3Z7w/VVsT7+nRg7R6CBY0cL3ZryVJbkcROQc
         t90N2mJ07oIzd4mAnaWhO0AEdTSO+1GhXD1MszTdAWYB32aTieRvuFR4JH+KOWPzAL4b
         l4fsjUOaituLMNqYE8sruSr3fvoq/WnyR7YnZp7t42gzkF8k+zXHN/S3IKxxJaffmQtt
         2VAlfePVoCURzhrQc936wQIvx8pg+jdAvTTxPnXCSVZ7ezt1Mteh4GEx3vOFqUxieMeV
         VWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201227; x=1772806027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/M/Mw/VkIMmop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=;
        b=p6srZSZINw5dR8tHko2aWAwE+myZqfbTYIKl+gCQmnV1Wya8sKOVheYUMkLtat1KUN
         UMOJ0U51HP9UtvDvkzPUH1aAkab9qnRg/mRgr2jkO1bDXILb3sYEH5VoO1KK4KlaaAJQ
         9nD0hg10vKLJwWc6rPrz619OqpOXSjflLLvEsv4rykEOjtSQvPeq9oXMbY2EgciCyLaw
         EA1F8f8Cp3HrrXSTFakL94HYPAc4vqAHfwam5xNG5fJHgS3c1vk9S+rpETqQ47Bdo56r
         w2ZPbYozrChEGkfOP06/VApgNyqGAhdxfeTHv5/QsEjoejmYLfEo06owL8bl2HCIFgbl
         t4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWZrW/MCB7wZuXMmNQkERNtonsdHsOYJeiXSdMVlBfBgxCF/DKzBy+AkQVvUk6zy2Vz3Sbow8jczUbxPq2iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGLz4g3L5SmkZIV86Hc26E0JESQjH6gRYdq06bLv8pjYtLsFsi
	BsQ0cFNTtp4pntgHzEeHwHVtFd2e/jKJlIdjrEjnE6sJJ7UPqSiD1yXJLDKp1HlLEDPql0Rx6Wl
	i+tZMiSP5wv6AQnhoDoVzve+s/gTKES1PGf64u0R/TOSenGRf4JzOtopApzXtXk7M8GO8Pg==
X-Gm-Gg: ATEYQzyu9zqfT1AkXdSqQ7kyAHYM6molHG5MLLKbVoQppxzy44ytTQ49dPRV/cFoVcN
	gTxutzRcQR14QVMssHgD0Z1/mPs0qwd6TmUBCEm9g1N5OpGzVFMKseDLW8kMkIsLLHztGEOwedr
	7YM4/ZC9sh31PxA0X/4dl+Ie1Scqh4H/wyLDzaHI3IlgwT6d26ARts54K8HrmBedIGS1kkw2cIP
	9ie65odrS5eoOSJkQ6yqFfwDSABBOnVZvnldmQhoIwVtzf6sos/PlrzSduIjtpTBX7YMxhhFK+H
	zqWPi8FJejMgqiu/I7eEzfIB8eSJZ1DyDrHk7VNhTSrgag/HkKoIYMElExAHGxp8lRVvwXX4zc5
	8+2iagiGoAXnqPPOkkAQjP+TIVKMHD/gRu84usdpJ9G0XOnZH2mFEWSzGXgEoM1GIbedeCV/I+K
	auYB9f
X-Received: by 2002:a05:6830:630e:b0:7d4:49a6:d9fc with SMTP id 46e09a7af769-7d591b03f93mr1986608a34.6.1772201227694;
        Fri, 27 Feb 2026 06:07:07 -0800 (PST)
X-Received: by 2002:a05:6830:630e:b0:7d4:49a6:d9fc with SMTP id 46e09a7af769-7d591b03f93mr1986566a34.6.1772201227199;
        Fri, 27 Feb 2026 06:07:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:06 -0800 (PST)
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
Subject: [PATCH v1 4/4] page_reporting: change PAGE_REPORTING_DEFAULT_ORDER to -1
Date: Fri, 27 Feb 2026 06:06:55 -0800
Message-Id: <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX2jl+eid98YfZ
 1xnROxBW0Uwo7rkNicBAYqIx7fkZfMOY0KCnLy4fsyocvQYtJEYMBFNEgBnhE6vmFA9+4bDSgP5
 c44ze0nv55GPeO2naWQygFGwseOeOlyB3QcG5YiJrlWvtjkhBYeZqm6CK7knsSMdeGP8xvhE10T
 hf1fViuphrrrraSFZn4xYngiJ59chLN6mLWdE4NQWwFMTAMAqxUZIvKUdd6mZXXRJHN87hYEsS8
 jlcjGKtWiwxYgDL0YqhptMl8K34Myu3KBhejp6QzsCD68BegOQkdl+FuRhtOYVko+iMJkugYeDM
 cYE+CkM4RrnyFacM9BB9NxsvAu7Hyxx03g2QnnjiBArEX6ODo0p6gr0tOU1Gs4j/+BJfYafWsIx
 AlFG0KzGEcmReKzsnzkc6Abrd/XfgK6Z8JJHqhDsHCVd1LqM73nsxt37FXh4YdpH+9Uvru2MZ6w
 yUbxmPuJ15vqwdddecQ==
X-Proofpoint-GUID: n6I7kAVHEQlLbXNXCKODVesbYcMrgnJt
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a1a50c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=6q7Fjfde3VlTRWJJNBIA:9 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: n6I7kAVHEQlLbXNXCKODVesbYcMrgnJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270125

PAGE_REPORTING_DEFAULT_ORDER is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_DEFAULT_ORDER to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index a7e3e30f2..3eb3e26d8 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,7 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
-#define PAGE_REPORTING_DEFAULT_ORDER	0
+#define PAGE_REPORTING_DEFAULT_ORDER	(-1)
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
-- 
2.34.1


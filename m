Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AE101F2
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213276; cv=none; b=hoLVV8jgK0AHHzvPwsrI9r9eSC0bULYYUxzEU3V+5YKtOkT1F79XC5xH+azdHKexJZ3zZHAy5tGo6UJ2LWAbOAqj6fP0MWRm5FD9IYHZCQMP7vy0UW5pkzbicQcLzysvmtR7kDfC8L+4p+MNm89Gi1Pb07AGh+GxPq1F5J2KGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213276; c=relaxed/simple;
	bh=WiFIVlhta9JercJY9EmcUaUisd+r6zjNrGKcf5WuE0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+bCubuNoN9Pk2yzl8jLoDCKJ4qIUjy/PlOtzghF6BYQGyt68cY4WIsKrC2/2LIn4/gqm/OzVqrljTThUlbS18oDMiANBoIBkIddf7+LOrQKYjwbOPeHOB7mEjRr5uC8oowRAnUj199ErN1mwBPgbDkzjZkH/uxGODkwYEyf52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2QtiTXB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2QtiTXB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCKrU1010931
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 13:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mWchJMmbNPHLwCbrwvJV++oQysNbAeqpc0B
	0OSiGaXI=; b=l2QtiTXBVvxcp8HgXyPKJdK57eSgAU7Z2NWx2e3sledtb9/pdzb
	V6sHhzwVdfE2W5FSEY+yf5gN/k0OQk/D1N2T4q4yyG4SdaNOL2huOQE29SOrE4gq
	nTA+I12nnduXFuG/Fak9P8P2pa53akKvss+Erbm6pws5kdQbZ7nr+rW0HDul7f1v
	/bUEKiiA69tY7Uo32ohOos7q+yCKYJcM50sFEASiKnEKpolFZ3J1/FxGGHcCEOX0
	dL2JGRZEBS2sdGBXgL2yKECLDcGGfqY8u3USN+UteJ2hP35N+IF12j2+02RI+Rks
	ll+7YMOaKPq09IBTyfPzzwtVH/oAc4D4VPg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unrq77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 13:01:13 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-53c8a312193so2316724e0c.3
        for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 06:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213272; x=1756818072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWchJMmbNPHLwCbrwvJV++oQysNbAeqpc0B0OSiGaXI=;
        b=LN/TozzvxLEgLbIPWlnnpVw4ubXODAIfSJBcWjOV5MwDXWPnGa28Pe4KHIpaOElF8g
         kW88J2xxcAQ1z6oJpMxt6lzxDPFh7g7O+zMoMEoF3DZYnBwxTgM6aKu9dUo+g32AGmjL
         X3dxNeK5bOJgTCevvQjFNkoexmKDK/VSNpPpWyX/4z67cd4NuneXOOAbR0WruTnx02/7
         x+fUwtUs2aHk81i7cUvefRlvD6Uk/ebb2o58qeLU0Q5oC5DtWJ0mCyiwvbw5Nit8pPjB
         gNvGzMfU90aRGKUBj6jrccibLZo3DjWKV068XRV1ns5SWBfXHhEKeF3KAV0X4aYeGbzI
         EJsg==
X-Forwarded-Encrypted: i=1; AJvYcCXMBKv5+8Xl0Rw3PhQlEeyOa03HrZU46kVArLCQDdjvw5AMOac7lsZKOQ8v0cVHBK3dbJZk8A2tpBobevQt1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjirthdGgZWf+JCnp3D32F1o9NMNaufOtyLkUAZw99gAulu9GM
	EObtrGOd/eACfHBeWMCLSvPWbgEHS7wvLsD22LGDWxgXh/clTc8t1/kJR77Drh+znEqVZOIur4c
	iKpTPqWndt8P/lfD1/o0JDRn2892pTqvAyghJisnFhx4WAhQrDLIdCxuXF5/SYRLmf3hsBA==
X-Gm-Gg: ASbGncvrk3MeYCamGMDkGfb3+IazFmK/PQbzhV/KFsAey0s/eL6fQfQgUW2KUFrM85q
	++B5unD5bH47YRKKJdDIDydLdLYxmAGdchgZi57uhSllT0tbfTEJI7+TLMW+RFHfycM8ilrDF/f
	eq0RK3sdsRqHy34mnz4Z18CPqwVAsL5GRmBL9p0Mru8oZKRyWqPFeqAl/6gJIPb3yQNDfJ2hsHx
	+uZRkWde4H8+pZReMXlPivOYJZ8a9gAerV1UBoDdZo+SAVjAaRiy5aN/ib20Ymt2LmN6bwmDuWJ
	P0a1FMxOanMn93pdefqirenV3En8nXR4hPQt1OhboUuEZnrMXqEuFY8LrpIlgipS
X-Received: by 2002:a05:6122:8c9:b0:531:4041:c4c7 with SMTP id 71dfb90a1353d-53c8a31e39amr4122191e0c.7.1756213272244;
        Tue, 26 Aug 2025 06:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhdJnTxwNhsMQjYmr19zw8wvmfe8LTYAip5JKv0wVmarkiaQpzy9+sRlZHf0eULP/s0XNZEA==
X-Received: by 2002:a05:6122:8c9:b0:531:4041:c4c7 with SMTP id 71dfb90a1353d-53c8a31e39amr4122141e0c.7.1756213271475;
        Tue, 26 Aug 2025 06:01:11 -0700 (PDT)
Received: from PHILBER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119ffd4sm7020978a12.6.2025.08.26.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:01:10 -0700 (PDT)
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Peter Hilber <quic_philber@quicinc.com>,
        Peter Hilber <peter.hilber@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS, mailmap: Update address for Peter Hilber
Date: Tue, 26 Aug 2025 15:00:15 +0200
Message-ID: <20250826130015.6218-1-peter.hilber@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: udowjl5t8efL7PLVGQqYYNMUBx5T304C
X-Proofpoint-ORIG-GUID: udowjl5t8efL7PLVGQqYYNMUBx5T304C
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68adb019 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tAGQbYHnAAAA:8 a=iox4zFpeAAAA:8
 a=Li1AiuEPAAAA:8 a=COk6AnOGAAAA:8 a=LpQP-O61AAAA:8 a=zd2uoN0lAAAA:8
 a=QyXUC8HyAAAA:8 a=fef9ZFAnUNnnEvqdXjEA:9 a=tNoRWFLymzeba-QzToBc:22
 a=lXWXidlrYx5KKt6n-8sY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=qGKPP_lnpMOaqR3bcYHU:22
 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX7UbqsIAAV639
 Ie44QqcIPbMTYDT4DrafMz4oM45aTq9EWHjZtz0p8yMftVqWhsxnzuhFxddHODhBt/XZkzm2mRX
 bRwRSzmQesQNwUGAg47EoPc+M1M111K7zludHZ1oAf6fwUZfIz+hUQ51iBcdpROBzt3W6B9ED5N
 yHytqHEqBsBNCsPr/Knv3tbIZnvPrmNdc6uy7/OVSGQKNzeDUVJqY29DQJ7uvme5vxCMxUhiwhI
 PPyfXZ7brWxYCW1Vs2WgnY2HDO8219XR1XfAQiQsCZz4C9gn4+xYW4dMXwO4SNU5HboSNcdlwBE
 e0LMF9L224VC7LI1m3uO9byHeoxq4S8j/Lnu8UZFaTY1qaIQrt2P6VLy4YXdl+i74adcFP76Zgj
 EOXNKIGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Going forward, I will use another Qualcomm address,
peter.hilber@oss.qualcomm.com.

Map past contributions on behalf of Qualcomm to the new address as well.

Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a124aeed52a2..523e6e672790 100644
--- a/.mailmap
+++ b/.mailmap
@@ -622,6 +622,7 @@ Paulo Alcantara <pc@manguebit.org> <palcantara@suse.com>
 Paulo Alcantara <pc@manguebit.org> <pc@manguebit.com>
 Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
+Peter Hilber <peter.hilber@oss.qualcomm.com> <quic_philber@quicinc.com>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev> <pierre-louis.bossart@linux.intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..8340dde41aaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26775,7 +26775,7 @@ F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
 VIRTIO RTC DRIVER
-M:	Peter Hilber <quic_philber@quicinc.com>
+M:	Peter Hilber <peter.hilber@oss.qualcomm.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_rtc_*

base-commit: c67e16d30dcacb135bb34a354b7d5e27c731b49f
-- 
2.43.0


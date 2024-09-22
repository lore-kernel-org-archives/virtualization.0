Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE69632
	for <virtualization@lists.linux.dev>; Sun, 22 Sep 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727008500; cv=none; b=rKbJcF5BQEROwvZokhWeZrEmAIMutRzSAPLdxwzTW1ZaANFqPdyhaWXdY4E3H2llQ3dpFl4xuN/lrkSZ5HnBfciptVHOEs8yvjtZ3ZNV9vY8vuWwyw9da+b017vkuNGCwYMAKmla0Vs/55k2r4FGTgy1OFrMoENVZCxvWp5m4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727008500; c=relaxed/simple;
	bh=XVc9bHInXL3zTC8FMuHPHNeZEVEe7u3kHz0JBqYOm10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuJ6ES66J053HfpgJl7Z3vRFAlHiPERURqLd0t0we96r/Ql4UJV65u8ivsVhmbhpl34G1ubmXfCMwlYhM0keBkiGS9iz664sj6cAi88kPaoPa0YiLDMH3NBDt9uKFWjtyjE72F/KKRd7qHOrNzSEmCpp30Tbly3HUSRVGC3uoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Decbyq5u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Decbyq5u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MC74wT024758;
	Sun, 22 Sep 2024 12:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=QvW6L3rE2goqnPv2oj2uARFM01ICtzo/vXYdOwNpeG4=; b=De
	cbyq5ukPMtrcFa1j6dBxf94TmlelJhugfZMNt4g48dA/ENwWiimUei7/AZmteUH1
	Kmayb6UsMTox3D70+5/wKWB8MAyPCl8C77tF2j1FgBMXUKGVIj+Tf/K6TUYLjlTI
	Kc78I8dVJ/lFzhp0dw5bhdEr5JK9RW4+OKQtFbpK8SFOua6w4RQXU9wDmTRGvuds
	lWkmkC8eT2S6tugMp6vSUsW144Q8DRgFexQD5K2cVa8OCljbzrf8zyP06Cu5T3Sj
	qk7JHbE7Oqw/a0Yk3FPTmtWogn4kcMM1V5gGOkqOAKigee7SvixYLuQ4Sh2dEKwv
	TZTr+ZPiRYnIUwFM6ATA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuejd8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 12:34:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48MCYm1V022516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 12:34:48 GMT
Received: from jianguos-gv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Sep 2024 05:34:46 -0700
From: Jianguo Sun <quic_jianguos@quicinc.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Jianguo Sun <quic_jianguos@quicinc.com>,
        Anant Goel
	<quic_anantg@quicinc.com>
Subject: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
Date: Sun, 22 Sep 2024 20:34:34 +0800
Message-ID: <20240922123435.17946-1-quic_jianguos@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j333JciWCffh92NkQc_2uUJJiQzhy7Y5
X-Proofpoint-ORIG-GUID: j333JciWCffh92NkQc_2uUJJiQzhy7Y5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409220096

Add CONFIG_VIRTIO_MMIO_POLL_RESET to as an option to enable
synchronous reset for the MMIO based transport for virtio.

Change-Id: Ifa7e29b4c0cfa26922535f921c6ab69eacdc4cfc
Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
---
 drivers/virtio/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 42a48ac763ee..fb17b1078d53 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -188,4 +188,12 @@ config VIRTIO_DEBUG
 
 	  If unsure, say N.
 
+config VIRTIO_MMIO_POLL_RESET
+	bool "Virti-mmio device synchronous reset support"
+	depends on VIRTIO_MMIO
+	help
+	  Say y here to enable synchronous reset for the MMIO transport based
+	  virtio device. After writing 0 to device_status, the driver must
+	  wait for a read of device_status to return 0 before reinitializing
+	  the device.
 endif # VIRTIO_MENU
-- 
2.17.1


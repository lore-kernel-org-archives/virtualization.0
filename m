Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433339B
	for <virtualization@lists.linux.dev>; Sun, 22 Sep 2024 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727008504; cv=none; b=EYlVDq02wXZuHl5HuPN+GsAXi6ZWftbTmTqIi60B9cSaxrikdzVjyHuRSvC+ejlKTsKEilqn6eGmuqjTDHFks+WlVFcBQJjEHNIIPtVccZiZ/04kaS0yzTwddeKXPVZV6SoqGVEqHOUVyv2VBy1L8O3EJtNlnHDhLLiVZpHrNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727008504; c=relaxed/simple;
	bh=qHe2QY8xYpiPtKvtq9xDyyjeiSDShNsVqf+s564xKn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBxAHH9lRf5TdOFM7JmKOcj/xqv7jrjRu4zB4vRqNPEwgv/2ny3mFwHgmhLgKC562OhqiXESgdvv62egitDo8BVV/8YwTLuq5BSt2O/DflkIgOF6LkJWSxbs2VQQmW3M8qTRMvnE+Jgh6b0onwHXNRg59tUi4rYgtVoCLXTIy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T2m7TP7K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T2m7TP7K"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48M9r0xJ012868;
	Sun, 22 Sep 2024 12:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/lq2oTPvVmHMbRha9Ym54K7T
	0jC/uPfFN6WUwLjYpyU=; b=T2m7TP7KXaXsWitzJi7bbB7htROrv62rnc14KAqU
	alzegT0RmF4APlkhHz/grHgIodZGvSElIu/m55hbyv24klN4iyonXkEmxJU3lBhg
	gPrYd7gpUCwZ+3B88YgAaaTCI96obZdcWV9LR2Uc4dwhHNJX7X4eCMgp5FDtbc4O
	w6qQm88uVMDrmM3atvG06stf4qmWGFTrNhdWr9jRQHi2jMg3/WNbKMOzlbN1Mr10
	1HbAIEjPDyuKkXHSuXuOiyYpUnDRIHQwbykv2UlP0E+K0ftAi6ZH7e/jqZvfEjOB
	eZtf7HrhnEMvSLb7rbXl/LN9u5CFebPq1Ro/mVfPwpWIDA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6jg39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 12:34:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48MCYrh2023485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 12:34:53 GMT
Received: from jianguos-gv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Sep 2024 05:34:51 -0700
From: Jianguo Sun <quic_jianguos@quicinc.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Jianguo Sun <quic_jianguos@quicinc.com>,
        Sreenad Menon
	<quic_sreemeno@quicinc.com>,
        Anant Goel <quic_anantg@quicinc.com>
Subject: [PATCH 2/2] virtio: Add polling virtio-mmio device reset completion
Date: Sun, 22 Sep 2024 20:34:35 +0800
Message-ID: <20240922123435.17946-2-quic_jianguos@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240922123435.17946-1-quic_jianguos@quicinc.com>
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
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
X-Proofpoint-GUID: WgJzhpnffjUedBFO0HK1ZVIAmuU3lIPB
X-Proofpoint-ORIG-GUID: WgJzhpnffjUedBFO0HK1ZVIAmuU3lIPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409220096

We write 0 to device_status to initiate reset of a virtio-mmio device.
The reset operation itself may or may not be completed by the time
write instruction completes. Add polling device_status to return
0 to ensure reset completion before reinitializing the device.

Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
---
 drivers/virtio/virtio_mmio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 90e784e7b721..c34ad1782145 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -70,6 +70,7 @@
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
+#include <linux/delay.h>
 
 
 
@@ -269,6 +270,13 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+#ifdef CONFIG_VIRTIO_MMIO_POLL_RESET
+	/* After writing 0 to device_status, the driver MUST wait for a read of
+	 * device_status to return 0 before reinitializing the device.
+	 */
+	while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
+		usleep_range(1000, 1100);
+#endif
 }
 
 
-- 
2.17.1


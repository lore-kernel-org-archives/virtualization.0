Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933664120B
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317618; cv=none; b=iCP7E9Q+rOFrx6D5AAk6NHu554zCmb078Pm6dM3A/Dy5RGKecOTvqJdXItBB7YVTgvdyxM65NjdQXortQ33aTVOepPix/U2/9Iq9SObHCf1gulTQiJn0ePQqIZH4/t60fPxeLcahxV6kLMDswHE01iBHbKR0hKSTm1Sj0DX8rs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317618; c=relaxed/simple;
	bh=ddHXFnN0p2Mz2daQY8TvXo4vI6hs5vYuxKgUpY4raZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FbSxXFmyBPw73mabZAWvQ4ZWlSJekCMltlNfWBWyC/R2f++bAWj4+FR2336CTQmpIUoSdg6rTNFmW4mGopjESJPr36q1FU43iKOltWAP6nEjt+uWuDawfh3ZQac8JeCcJOn3x0g1jIhcxLS2QiFnV136Z8E3hb9qHyZGJ//OXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kUKQflup; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUKQflup"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH59Rc013247;
	Thu, 26 Sep 2024 02:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=upBu4xToc8IoKGUNxN2KCNa/5gUJ/9bFEzgAD9BTcPU=; b=kU
	KQflup75ffNymxjJmrRWd2nyA3ywg629rz/kohVCoTCUQmKWtdQcEosBI6GBzHun
	q7lASluLnVAZP1c3Vp8PZNqCN5/jv2FqU17OsCIX69ptmC4/MG/C1RelmXvHAj3a
	5zDNta+UOVn5Vcmlt8VxK0QIh8Y2xEYPfD8SpvaknRgfFELgVekau2SatT9Aqud5
	wesdz+EyF7B3FYj6rEqFJCwHceqNT6P8/CildjJutuiPzTDVHAQu5GItpvQmRtJd
	FF9/9Ni7slQTNnYNBKWUukwNbOeY3zNJwFfh3mq/DW+qTTrZT68l+dhXeE8XWxp6
	oNCihJeY8+UM/ThQz4mA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snqyp2ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 02:26:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q2Qa20017630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 02:26:36 GMT
Received: from jianguos-gv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 19:26:34 -0700
From: Jianguo Sun <quic_jianguos@quicinc.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Jianguo Sun <quic_jianguos@quicinc.com>,
        Sreenad Menon
	<quic_sreemeno@quicinc.com>,
        Anant Goel <quic_anantg@quicinc.com>
Subject: [PATCH v2] virtio: Add polling virtio-mmio device reset completion
Date: Thu, 26 Sep 2024 10:25:57 +0800
Message-ID: <20240926022557.8771-1-quic_jianguos@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eVHNbBXR-JI-LztzHywtaYnCiijjmxc8
X-Proofpoint-ORIG-GUID: eVHNbBXR-JI-LztzHywtaYnCiijjmxc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260012

We write 0 to device_status to initiate reset of a virtio-mmio device.
The reset operation itself may or may not be completed by the time
write instruction completes. Add polling device_status to return
0 to ensure reset completion before reinitializing the device.

Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
---
 drivers/virtio/virtio_mmio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 90e784e7b721..cf1a4a3dd35d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -70,6 +70,7 @@
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
+#include <linux/delay.h>
 
 
 
@@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	/* After writing 0 to device_status, the driver MUST wait for a read of
+	 * device_status to return 0 before reinitializing the device.
+	 */
+	while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
+		msleep(1);
 }
 
 
-- 
2.17.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9A142E77
	for <virtualization@lists.linux.dev>; Tue,  2 Jul 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951034; cv=none; b=WaRNixoOJ1DpcLnBckVuVF1JdJ7lQrFViFUxsaR2iB09pZGrrzdxLyfkQQhE+vlyG2h7MUr8TPLlZvTLIQGAv4eElUZrF2QXNLYN5ye/afsxW7wY4Bgpikl5Sx/BT+v3axstZRs0veC4gGcffhfVqaBrfwkOeUOIy5QhJI+qkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951034; c=relaxed/simple;
	bh=kg2Q+tvG2CSfuvv//x7rHQEG0q5L6gS1q4lFnI9QkLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ql33S6qhRpuIliOjsyCaL5DKQyQKiDcJby1Kfc1qKWJYKCwUgOzI9y8vxCEwYkx00HpgfIsC0T6Fc+QVx+NkFbyPbwnT8rnQH1UuZeKCHw4pwBCV0JPqjcRRIgBhuMXQ+a8LwpsGal6enrwtebhHxeiipsLkp7qMxy8eGU6UQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WkRhS5R6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WkRhS5R6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462He7xw004288;
	Tue, 2 Jul 2024 20:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Trl3wBd3Ms8JnkrcozxPpQ
	+/rF1C9Mx5b7+0DvlBfu0=; b=WkRhS5R6xz1354YRk6Jk8GH/06oMJ8gN8a+oc5
	Q0O8kEj+7Z/x3EMQ4FEIkv0b6SEpZ0b0zuw8ufjVJVWV9ICJTrGSeIgvpIWPrnLZ
	27OH6Y68G2HcoU/9unHn+XfRRSOoImdv+RlPYDM9eSan0EulEGWihrNrx0vRxgj/
	Kr2DRLULHFBYU6dqQmkAOz4v8Ok57vbn+RkM6rRdTg+NCSf8xmJy2pEQBaCEp/ZW
	0F7X90qj3SMVgdJoPZ3bCJTK5ll11KgwVlcjV1ELqhkQdXhxJwL3BHr0JDyFSGKB
	NwojvevZXYYp1O/ydlTg8ifPcaeWC55u/t+y3XtSs03Zydfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027yf9wpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 20:10:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462KAJgu030383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 20:10:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 13:10:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 13:10:18 -0700
Subject: [PATCH] virtio: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-sh-drivers-virtio-v1-1-cf7325ab6ccc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKpehGYC/x3MTQrCMBBA4auUWTsQQzDqVcRFfqbNgE1lpoZC6
 d2NLr/FezsoCZPCfdhBqLHyUjvOpwFSCXUi5NwN1lhnvLE4Z9SCWbiRKDaWlRf0xlG8On+5pQg
 9fQuNvP23j2d3DEoYJdRUfrMX18+Gc9CVBI7jC9JagleFAAAA
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HutdNiJI12GPIWG-8IJcQZ7YT0kqB4z1
X-Proofpoint-ORIG-GUID: HutdNiJI12GPIWG-8IJcQZ7YT0kqB4z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_15,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=899 phishscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020148

With ARCH=sh, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_ring.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/virtio/virtio.c      | 1 +
 drivers/virtio/virtio_ring.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..396d3cd49a1b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -609,4 +609,5 @@ static void __exit virtio_exit(void)
 core_initcall(virtio_init);
 module_exit(virtio_exit);
 
+MODULE_DESCRIPTION("Virtio core interface");
 MODULE_LICENSE("GPL");
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2a972752ff1b..1cac7d5b3062 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3244,4 +3244,5 @@ void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
 
+MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-sh-drivers-virtio-704eb84769cb


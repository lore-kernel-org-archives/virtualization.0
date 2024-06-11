Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362957CAE
	for <virtualization@lists.linux.dev>; Tue, 11 Jun 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133741; cv=none; b=qjsGCQ5UO0jfUMqHnQu8Wbyz67OIhv0jZdqwyDSX1MTiS11tWzj6NyhEZtH8UJpbes0G2Ihtnf3742gQTq8cu2uTejuIso/Qqyn6ZKI4ntq3rc/iONBF72E1uhmhJDOiDHwGoteeYHle+LyeNccVfV50QpjHpE3zsAGueWKAv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133741; c=relaxed/simple;
	bh=NWxk0xi3uhd7xmYlGU0qY3zYYQRAlKdsh+Rl6kYqk8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Kxz+i4K9NN/uauXsIHrNuvw/Mv/e0W0QpMoxhk8yIM0kRm10EupcVLkLPDtVj1xeDj0RiLVXXF9nccul9cFa4groUnUtWpXwibTFbFNNVxJcvlZ/PB6fQJVY1eCPGrsxt/+xN1NsGT4kbU/lbnprKzlamK/OFEWIgF/3KSaoMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SUebXWIB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SUebXWIB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFeXSx003049;
	Tue, 11 Jun 2024 19:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KQnVwxYMD9p1crv4V8a2Rw
	oCsLwuUTHMozrqoix0LBg=; b=SUebXWIB+SKcgR5moR0gTpCDE4HTUFREL+caI9
	QKk2/sSZBOS8yLwAINCZeBHL7Nnj1Rnp6J6HkAMh5cDVWDiVktoujLtvzeWOjejB
	Tr4NgltZPTiB8uCKgGVKmjRjOydINYIoktujyrMfN6SDLD/lQi98uAq9Fb5iNlQ0
	pl7irD4lUhTpRtPiBPsFqD7lXfEs2wFpDJjBwGUDzfsw5dC/aZKdzTnklt30xaJF
	pFrefgrMbvla23kZcZXqDtwr7nBsic39Xv2/N552qeCm7q9ymcuSAR8cbDjXtWgL
	lULG59Ka1TGfFKBmzBHzkwxOOzDtAWPTwwTWAK/i47AYoi7Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yphsasvkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 19:22:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BJM9Fg007488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 19:22:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 12:22:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 12:22:08 -0700
Subject: [PATCH] vDPA: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-vdpa-v1-1-efaf2de15152@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAN+jaGYC/x3MwQrCMAyA4VcZORtoOpnoq4iHroku4OpItAzG3
 t3q8Tv8/wYupuJw6TYwqer6Kg106CBPqTwElZshhngMAxHOjGxaxRwrLwn7M8UwMJ0k99CqxeS
 u6/94vTWPyQVHSyVPv89Ty2fFOflbDPb9C3XVsziAAAAA
To: Zhu Lingshan <lingshan.zhu@intel.com>,
        "Michael S. Tsirkin"
	<mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NWbbXaZ8dISxb5ZHSiDuu5olsfwcR9dl
X-Proofpoint-GUID: NWbbXaZ8dISxb5ZHSiDuu5olsfwcR9dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406110133

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/ifcvf/ifcvf.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 1 +
 drivers/vdpa/vdpa.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 80d0a0460885..ccf64d7bbfaa 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -894,4 +894,5 @@ static struct pci_driver ifcvf_driver = {
 
 module_pci_driver(ifcvf_driver);
 
+MODULE_DESCRIPTION("Intel IFC VF NIC driver for virtio dataplane offloading");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8d391947eb8d..1ca445e31acb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1538,4 +1538,5 @@ core_initcall(vdpa_init);
 module_exit(vdpa_exit);
 
 MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
+MODULE_DESCRIPTION("vDPA bus");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-vdpa-391206d17ec3


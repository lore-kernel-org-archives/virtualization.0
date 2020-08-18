Return-Path: <SRS0=0Qmj=B4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D87C433DF
	for <virtualization@archiver.kernel.org>; Tue, 18 Aug 2020 14:58:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5012080C
	for <virtualization@archiver.kernel.org>; Tue, 18 Aug 2020 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sV2AZAHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5012080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 182D320029;
	Tue, 18 Aug 2020 14:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FIQwGHcwwGLs; Tue, 18 Aug 2020 14:58:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6E23120419;
	Tue, 18 Aug 2020 14:58:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55C6CC088B;
	Tue, 18 Aug 2020 14:58:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B74AEC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 14:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8899620419
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 14:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8B8DZjI3hgW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 14:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by silver.osuosl.org (Postfix) with ESMTPS id 4DC1020029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 14:58:51 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07IEwP4C074678; Tue, 18 Aug 2020 10:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=XJwDIKzxpiYskYO19NLcua++csukB3hKsmpYA6iZgV4=;
 b=sV2AZAHOvRB5uDiT56KjswSDw34LDEw4A8xFDRqz5tFbO+3bmjY3zRkYWH7YUePN+7F1
 0fhp5ly6JO9Td/yv0d/gzQACs/yjrBUIXy4rxETx/2NZE2CJOViJJm7pWzEH1bXB3pZZ
 OI+FE2i5V7RTpvagISqsgO9Xv16sEkPq9mme7Dv93Kfj7hT0kseeJLWhDyUPmYLyLxvH
 XELYk9cZ6ry+Y7TCD2wKF0OZJ5NNsS0v0c++IjchgP4NTT5O4iwpoLxv3ZnY9wgS/jXT
 6MS1tJbLFtpE517OPge8FtJCqpulgX78qk03YuiS9eV6DXfTjA7Q5vlDziZIk2PF7JXL vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304te4y1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 10:58:42 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07IEwXVx075654;
 Tue, 18 Aug 2020 10:58:42 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304te4xxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 10:58:42 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IEkNSP027724;
 Tue, 18 Aug 2020 14:58:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 3304c90fqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 14:58:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07IEwYI722610244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 14:58:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC9FD4203F;
 Tue, 18 Aug 2020 14:58:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A1D142049;
 Tue, 18 Aug 2020 14:58:34 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.28.154])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2020 14:58:34 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Tue, 18 Aug 2020 16:58:31 +0200
Message-Id: <1597762711-3550-3-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-18_10:2020-08-18,
 2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=1
 mlxscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180102
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, linuxram@us.ibm.com,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, thomas.lendacky@amd.com, hca@linux.ibm.com,
 david@gibson.dropbear.id.au
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

If protected virtualization is active on s390, the virtio queues are
not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
negotiated.
Define CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS and export
arch_has_restricted_memory_access to fail probe if that's
not the case, preventing a host error on access attempt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9cfd8de907cb..d4a3ef4fa27b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -820,6 +820,7 @@ menu "Virtualization"
 config PROTECTED_VIRTUALIZATION_GUEST
 	def_bool n
 	prompt "Protected virtualization guest support"
+	select ARCH_HAS_RESTRICTED_MEMORY_ACCESS
 	help
 	  Select this option, if you want to be able to run this
 	  kernel as a protected virtualization KVM guest.
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 6dc7c3b60ef6..aec04d7dd089 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -45,6 +45,7 @@
 #include <asm/kasan.h>
 #include <asm/dma-mapping.h>
 #include <asm/uv.h>
+#include <linux/virtio_config.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -161,6 +162,35 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_MEMORY_ACCESS
+/*
+ * arch_has_restricted_memory_access
+ * @dev: the VIRTIO device being added
+ *
+ * Return an error if required features are missing on a guest running
+ * with protected virtualization.
+ */
+int arch_has_restricted_memory_access(struct virtio_device *dev)
+{
+	if (!is_prot_virt_guest())
+		return 0;
+
+	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
+		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
+		return -ENODEV;
+	}
+
+	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
+		dev_warn(&dev->dev,
+			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(arch_has_restricted_memory_access);
+#endif
+
 /* protected virtualization */
 static void pv_init(void)
 {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

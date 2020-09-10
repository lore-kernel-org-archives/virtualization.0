Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A1CC43461
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DBB2078B
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GJealwQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DBB2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3F0A87367;
	Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDlsrDihF4vx; Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 43AD5871BD;
	Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA80C0859;
	Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABCF2C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A40BF204D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qXcTS-vRC5x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by silver.osuosl.org (Postfix) with ESMTPS id D231D20107
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:06 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A8XweY103296; Thu, 10 Sep 2020 04:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=yO1GjViRv1bglEtAAUDSoRen6fdrhR52DgjMHr1Ss7E=;
 b=GJealwQiVQrXqukAXO9zL3qSD0+he4QldOpyqughATuLoumJLkwN2ElncH1Zg1cFFmRD
 j/ufpEIKJKXxnACxidzrxkci2ns+kPwoB6JOMYHLc8DCphqUagtwz7Zd3O/7yxygdzkp
 AHNdCTb3M1y+5YI0Z260ImbvhDYYt9j7XteLw6eRJGsDUaMtYsN7NLE9dWhyi+EsM8fj
 q/ZowfqWXtAWg8nM4eOUFFMskEguOLqnBvssfHc8GyACkesgXipe34UKRA7K8j9ZCtmB
 RjBEpPLaVvDz2gCc6lO0iucO86vBEX+umNv0n4p8ye5KBmAszYvSho7G7Kgqk8nKKieW kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fgmn0p35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:54:01 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A8YIV4103913;
 Thu, 10 Sep 2020 04:54:01 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fgmn0p1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:54:01 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A8qqOI024628;
 Thu, 10 Sep 2020 08:53:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 33f91w885p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 08:53:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08A8qL4R60031370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 08:52:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C12511C050;
 Thu, 10 Sep 2020 08:53:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8050211C058;
 Thu, 10 Sep 2020 08:53:53 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.28.144])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 08:53:53 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Thu, 10 Sep 2020 10:53:50 +0200
Message-Id: <1599728030-17085-3-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=1
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100079
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

If protected virtualization is active on s390, VIRTIO has only retricted
access to the guest memory.
Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
the case.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b29fcc66ec39..938246200d39 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -820,6 +820,7 @@ menu "Virtualization"
 config PROTECTED_VIRTUALIZATION_GUEST
 	def_bool n
 	prompt "Protected virtualization guest support"
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Select this option, if you want to be able to run this
 	  kernel as a protected virtualization KVM guest.
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 0d282081dc1f..e27f050cb516 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -45,6 +45,7 @@
 #include <asm/kasan.h>
 #include <asm/dma-mapping.h>
 #include <asm/uv.h>
+#include <linux/virtio_config.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -160,6 +161,16 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return is_prot_virt_guest();
+}
+EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
+
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

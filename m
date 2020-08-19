Return-Path: <SRS0=s1EX=B5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2786C433DF
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 16:23:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948312083B
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XF/FOeN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948312083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 648F284821;
	Wed, 19 Aug 2020 16:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtqM98aWvyBI; Wed, 19 Aug 2020 16:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8A9784546;
	Wed, 19 Aug 2020 16:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD6ECC07FF;
	Wed, 19 Aug 2020 16:23:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3408EC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 16:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23A3884587
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 16:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_9AthB4e3bT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 16:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 701FE84546
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 16:23:41 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JG1rX8005630; Wed, 19 Aug 2020 12:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=K1juP4O56OpR+1pGnhU0wOY9m5Yds3UI4Ybc3g8AT94=;
 b=XF/FOeN8v7PK4DNs3MQDP3eP9tCMMgHxWH1l9q37pPHXfB3fOuAfH3+yHolodg5t+eVq
 xhQBB+4ChC1xOrDCQWNw+Uagq81HYn/bLEa71BfGelAdrUt8kfF0EgvElGhFjRF5B0wf
 OkcRNhevwliTdHoOTWaize1O1PrZoZz5ua2pOGzzITcmHl6Imqyn5SPiCkfQ7VeCnaDW
 CnhtERrg0TdXHMfTJHoD6Yyrpa1icOOzEj2TI+SUY+Fx7Sk32BYQWQ2GUBtXA+iPp8TP
 wF03sYji/KW9RpDi1o7JLVu98j/a9s53bobVZ8W+H3d2ZajaOI4d1+D3/vbzt7o0FMp5 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304ruew8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 12:23:36 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07JG1vxh005752;
 Wed, 19 Aug 2020 12:23:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304ruew45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 12:23:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JGGtcx019296;
 Wed, 19 Aug 2020 16:23:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03fra.de.ibm.com with ESMTP id 3304c919t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 16:23:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07JGNLX323527920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 16:23:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB7175204E;
 Wed, 19 Aug 2020 16:23:21 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.33.131])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 28F2652051;
 Wed, 19 Aug 2020 16:23:21 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Wed, 19 Aug 2020 18:23:18 +0200
Message-Id: <1597854198-2871-3-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_09:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=959 priorityscore=1501 suspectscore=1 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190133
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

If protected virtualization is active on s390, VIRTIO has retricted
access to the guest memory.
Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
the case, preventing a host error on access attempt.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9cfd8de907cb..c12422c26389 100644
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
index 6dc7c3b60ef6..8febd73ed6ca 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -45,6 +45,7 @@
 #include <asm/kasan.h>
 #include <asm/dma-mapping.h>
 #include <asm/uv.h>
+#include <linux/virtio_config.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -161,6 +162,16 @@ bool force_dma_unencrypted(struct device *dev)
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

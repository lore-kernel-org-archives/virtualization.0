Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2FC07E9B
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 10:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55E960FDA
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E960FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66C0740498;
	Wed, 21 Jul 2021 10:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n9PnidXNvCPw; Wed, 21 Jul 2021 10:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB1FC40496;
	Wed, 21 Jul 2021 10:02:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73ABDC001A;
	Wed, 21 Jul 2021 10:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCDCAC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABAD8607A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7zHGjvMl3ho
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:02:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EX13-EDG-OU-001.vmware.com (ex13-edg-ou-001.vmware.com
 [208.91.0.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21C2260784
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:02:48 +0000 (UTC)
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 21 Jul 2021 03:02:44 -0700
Received: from sc-dbc2166.eng.vmware.com (sc-dbc2166.eng.vmware.com
 [10.182.28.66])
 by sc9-mailhost2.vmware.com (Postfix) with ESMTP id E1C3420275;
 Wed, 21 Jul 2021 03:02:46 -0700 (PDT)
From: Jorgen Hansen <jhansen@vmware.com>
To: <linux-kernel@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2] MAINTAINERS: Update for VMCI driver
Date: Wed, 21 Jul 2021 03:02:46 -0700
Message-ID: <1626861766-11115-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add maintainer info for the VMware VMCI driver.

v2: moved pv-drivers to L: as private list

Acked-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3..969a67a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
 
+VMWARE VMCI DRIVER
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+L:	linux-kernel@vger.kernel.org
+L:	pv-drivers@vmware.com (private)
+S:	Maintained
+F:	drivers/misc/vmw_vmci/
+
 VMWARE VMMOUSE SUBDRIVER
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
-- 
2.6.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

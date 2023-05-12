Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ACBC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 17:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C921C42DA4;
	Fri, 12 May 2023 17:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C921C42DA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WoWQPDZTCVzP; Fri, 12 May 2023 17:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66FF2404DB;
	Fri, 12 May 2023 17:10:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66FF2404DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7DCC0036;
	Fri, 12 May 2023 17:10:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D271FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 17:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9958260B58
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 17:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9958260B58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLxLN7AW7zgN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 17:10:03 +0000 (UTC)
X-Greylist: delayed 00:19:29 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B700460804
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B700460804
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 17:10:03 +0000 (UTC)
Received: from [64.186.27.43] (helo=srivatsa-dev.eng.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpa (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pxVyH-001Zzx-IH;
 Fri, 12 May 2023 12:50:21 -0400
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: jgross@suse.com, bp@suse.de, tglx@linutronix.de, kuba@kernel.org,
 davem@davemloft.net, richardcochran@gmail.com
Subject: [PATCH 2/3] MAINTAINERS: Update maintainers for VMware hypervisor
 interface
Date: Fri, 12 May 2023 09:49:57 -0700
Message-Id: <20230512164958.575174-2-srivatsa@csail.mit.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512164958.575174-1-srivatsa@csail.mit.edu>
References: <20230512164958.575174-1-srivatsa@csail.mit.edu>
MIME-Version: 1.0
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, vsirnapalli@vmware.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, akaher@vmware.com,
 amakhalov@vmware.com
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

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

I have decided to change employers, so I would like to remove myself
from the maintainer role for VMware-supported subsystems.

Remove Srivatsa from the maintainers entry for VMware hypervisor
interface and add Ajay Kaher as a co-maintainer. Also, update CREDITS
for Srivatsa.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Ajay Kaher <akaher@vmware.com>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 5d48f1a201f2..313435c93e2c 100644
--- a/CREDITS
+++ b/CREDITS
@@ -386,6 +386,7 @@ D: dsp56k device driver
 N: Srivatsa S. Bhat
 E: srivatsa@csail.mit.edu
 D: Maintainer of Generic Paravirt-Ops subsystem
+D: Maintainer of VMware hypervisor interface
 
 N: Ross Biro
 E: ross.biro@gmail.com
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d8d000353b5..309d4cc325f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22493,7 +22493,7 @@ S:	Supported
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+M:	Ajay Kaher <akaher@vmware.com>
 M:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

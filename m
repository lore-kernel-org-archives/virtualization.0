Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59AC433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:26:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018C6619E2
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 018C6619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8B016083F;
	Mon,  8 Nov 2021 20:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTpMtGZoSwsu; Mon,  8 Nov 2021 20:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 504CD606E7;
	Mon,  8 Nov 2021 20:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 210A8C0019;
	Mon,  8 Nov 2021 20:26:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 056E6C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB3AD402FD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtsKEQOPyn3e
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31BC2402F8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:36 +0000 (UTC)
Received: from [128.177.79.46] (helo=[10.118.101.22])
 by outgoing-stata.csail.mit.edu with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <srivatsa@csail.mit.edu>)
 id 1mkBDs-000DLJ-Cy; Mon, 08 Nov 2021 15:26:32 -0500
Subject: [PATCH 1/2] MAINTAINERS: Update maintainers for paravirt ops and
 VMware hypervisor interface
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com
Date: Mon, 08 Nov 2021 12:29:45 -0800
Message-ID: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
User-Agent: StGit/0.21
MIME-Version: 1.0
Cc: anishs@vmware.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
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

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Deep has decided to transfer maintainership of the VMware hypervisor
interface to Srivatsa, and the joint-maintainership of paravirt ops in
the Linux kernel to Srivatsa and Alexey. Update the MAINTAINERS file
to reflect this change.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
Cc: stable@vger.kernel.org
---

 MAINTAINERS |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ad926ba362f..118cf8170d02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14188,8 +14188,8 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Deep Shah <sdeep@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+L:	pv-drivers@vmware.com (private)
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
 S:	Supported
@@ -20038,10 +20038,13 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Deep Shah <sdeep@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+M:	Alexey Makhalov <amakhalov@vmware.com>
+L:	pv-drivers@vmware.com (private)
 L:	virtualization@lists.linux-foundation.org
+L:	x86@kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
 F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

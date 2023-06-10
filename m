Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ED3C7EE2E
	for <virtualization@archiver.kernel.org>; Sat, 10 Jun 2023 05:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E47984374;
	Sat, 10 Jun 2023 05:43:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E47984374
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Oxl7XjHx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sinr8v-O7Qkr; Sat, 10 Jun 2023 05:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DB5F84372;
	Sat, 10 Jun 2023 05:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DB5F84372
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63784C0037;
	Sat, 10 Jun 2023 05:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 473AEC0029
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 05:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15DC460B26
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 05:43:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15DC460B26
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Oxl7XjHx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pow8vILOCtwi
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 05:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8311160B06
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8311160B06
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=3E3RMUEpG9p/4/pgtUAbLe6jed5Tpov9MGa9vuVYHA8=; b=Oxl7XjHxrmWf42qVYof+9N6Wf7
 JC7eJ9uHB8Bt3Hyz0awCV8sn5uARn6mzs5tj4QNBnow6urZ29s+lbe1UFURP8s6yoxjUecFNscYZa
 wkMIk7rET0QmfuDr/jJJB4dyrijWSGy5z2zX6Ogy3mjAyCbLdIysmcJjVH1+6pybhoMtvVPfQjO10
 2U9oMGWBOvonApyOEniQShJAQHGiAKg3Z629Hgo4wHZdTCdKsfVtvXSm4sAnt3vQMUht1DUJqoU3c
 jRIK6n7AyrPptS+IlYSOfs+O2FIIJdXlIoq0IEAn+2flmJfP56jloShxeQwQnh4nS/3duOACqDuJU
 OW60QsHQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q7rNX-00FJ2Y-0p; Sat, 10 Jun 2023 05:43:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: virt: clean up paravirt_ops doc.
Date: Fri,  9 Jun 2023 22:43:10 -0700
Message-ID: <20230610054310.6242-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 virtualization@lists.linux-foundation.org, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
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

Clarify language. Clean up grammar. Hyphenate some words.

Change "low-ops" to "low-level" since "low-ops" isn't defined or even
mentioned anywhere else in the kernel source tree.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Luke Nowakowski-Krijger" <lnowakow@eng.ucsd.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/virt/paravirt_ops.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/Documentation/virt/paravirt_ops.rst b/Documentation/virt/paravirt_ops.rst
--- a/Documentation/virt/paravirt_ops.rst
+++ b/Documentation/virt/paravirt_ops.rst
@@ -5,31 +5,31 @@ Paravirt_ops
 ============
 
 Linux provides support for different hypervisor virtualization technologies.
-Historically different binary kernels would be required in order to support
-different hypervisors, this restriction was removed with pv_ops.
+Historically, different binary kernels would be required in order to support
+different hypervisors; this restriction was removed with pv_ops.
 Linux pv_ops is a virtualization API which enables support for different
 hypervisors. It allows each hypervisor to override critical operations and
 allows a single kernel binary to run on all supported execution environments
 including native machine -- without any hypervisors.
 
 pv_ops provides a set of function pointers which represent operations
-corresponding to low level critical instructions and high level
-functionalities in various areas. pv-ops allows for optimizations at run
-time by enabling binary patching of the low-ops critical operations
+corresponding to low-level critical instructions and high-level
+functionalities in various areas. pv_ops allows for optimizations at run
+time by enabling binary patching of the low-level critical operations
 at boot time.
 
 pv_ops operations are classified into three categories:
 
 - simple indirect call
-   These operations correspond to high level functionality where it is
+   These operations correspond to high-level functionality where it is
    known that the overhead of indirect call isn't very important.
 
 - indirect call which allows optimization with binary patch
-   Usually these operations correspond to low level critical instructions. They
+   Usually these operations correspond to low-level critical instructions. They
    are called frequently and are performance critical. The overhead is
    very important.
 
 - a set of macros for hand written assembly code
    Hand written assembly codes (.S files) also need paravirtualization
-   because they include sensitive instructions or some of code paths in
+   because they include sensitive instructions or some code paths in
    them are very performance critical.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

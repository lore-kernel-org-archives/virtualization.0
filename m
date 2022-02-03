Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACEC433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 02:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2788860745;
	Thu,  3 Feb 2022 02:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yLRBxghUjfFE; Thu,  3 Feb 2022 02:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C518960736;
	Thu,  3 Feb 2022 02:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8300AC001A;
	Thu,  3 Feb 2022 02:31:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DED0C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7188760745
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-rypJU5EUb0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA1C460736
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643855501; x=1675391501;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HdaND8u9V1hYcYSjNRBXgne8gGL7vhGYIkgf534pj+o=;
 b=OfCHNyqYgvgm98439DF7+B2z4uTUcy6R10b2BKdftjrMHfXKusdRqw8D
 bj5QprYg5wrMF6s5PfrE+dgFFzFNmZ0ZPpZIJ1BBrs/k+cGfPOthwSL0v
 F3GDp8VmPaD8UERHFJPuFq1+3QNpjNF2eh94umigqnpaYYvd+K1Tz/poR
 hh90oC6itP+eT9XIKGeLHv2RHTpj/wC2r6OdiWfLxmzOFB5MbqC9vV1RA
 dKb0N6tKCnuWIGtZV3CKaQZ2D0y06WZparnU3ejoZPY3pey81/uaIe8yo
 gJczQTqsTki88pX669gfJFADF1ev1i89a2BAw2IiUU8Obs3Eh6hCWrXh6 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247829554"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="247829554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 18:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="566270224"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 18:31:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFRuM-000VRC-2G; Thu, 03 Feb 2022 02:31:38 +0000
Date: Thu, 3 Feb 2022 10:31:15 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH] VMCI: dma dg: vmci_write_data() can be static
Message-ID: <20220203023115.GA58435@f185d0c9484e>
References: <20220202144910.10349-8-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-8-jhansen@vmware.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
 Vishnu Dasa <vdasa@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
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

drivers/misc/vmw_vmci/vmci_guest.c:118:5: warning: symbol 'vmci_write_data' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 vmci_guest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index ca73a19134041e..ba3443dda081bf 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -115,7 +115,7 @@ void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 		iowrite32(val, dev->iobase + reg);
 }
 
-int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
+static int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
 {
 	int result;
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

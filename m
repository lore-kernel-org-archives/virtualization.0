Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FBDC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 21:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 767F382EA1;
	Wed,  2 Feb 2022 21:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 976cDvdll-LT; Wed,  2 Feb 2022 21:10:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 32C3F82F41;
	Wed,  2 Feb 2022 21:10:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CBDAC001A;
	Wed,  2 Feb 2022 21:10:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED1AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB6B582F41
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KhzdhGnlu1T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:10:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C62AE82EF1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643836229; x=1675372229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iMWumcGhp4QWhnuLTMkak/W/OcXG87n/jUcrqAHhooc=;
 b=FeH3wjJdKfU2J5GBgg09KvR2w9yO+XLziCOb0GgL+4tyIyOStbezFOVq
 DI9QB1CnoFUrlxBtGv8+oEreIriUDoSCCL7mkVY/j1QKbMhUnsb0xHyNM
 PI0K3/J9+YjnyVRNJ/Yn0KLr+xagYuvaXPJnHkLVMMgTF2EDitLO8xo4c
 xUDZ1PGnVxAkDDOmLo62GwcW5d+keDbceVspyj0y+QjJohog+P5zml4hZ
 dHmLxA5vqAOkpqBVIaxrZdR203k36dvawkNnkHXjiSfgI8Vo7d5GKaJ1T
 oi3rvyeEKmugBjwGyRuJuasNP1UzYOo8ssyqluoEH+3US3z9rVnNoaEcN w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235420436"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="235420436"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 13:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="699056130"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 13:10:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFMtW-000V8Q-Ni; Wed, 02 Feb 2022 21:10:26 +0000
Date: Thu, 3 Feb 2022 05:09:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH] VMCI: dma dg: vmci_read_reg() can be static
Message-ID: <20220202210943.GA88437@f185d0c9484e>
References: <20220202144910.10349-3-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-3-jhansen@vmware.com>
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

drivers/misc/vmw_vmci/vmci_guest.c:93:14: warning: symbol 'vmci_read_reg' was not declared. Should it be static?
drivers/misc/vmw_vmci/vmci_guest.c:100:6: warning: symbol 'vmci_write_reg' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 vmci_guest.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index d00430e5aba36..081f7b0c23f5f 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -90,14 +90,14 @@ u32 vmci_get_vm_context_id(void)
 	return vm_context_id;
 }
 
-unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
+static unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
 {
 	if (dev->mmio_base != NULL)
 		return readl(dev->mmio_base + reg);
 	return ioread32(dev->iobase + reg);
 }
 
-void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
+static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 {
 	if (dev->mmio_base != NULL)
 		writel(val, dev->mmio_base + reg);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

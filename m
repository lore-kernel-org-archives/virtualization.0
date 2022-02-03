Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89FEC433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 02:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37CB0415BF;
	Thu,  3 Feb 2022 02:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tV6YrmYrACiP; Thu,  3 Feb 2022 02:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB2C74156E;
	Thu,  3 Feb 2022 02:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95827C001A;
	Thu,  3 Feb 2022 02:40:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5748C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA11B400E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJyCUs7Xe3Lu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:40:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E634400A9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643856042; x=1675392042;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GIjjktIkiLNrP/r1mZS+FYVdRHq8JPEaPLAA76V2CRE=;
 b=FvfTNXyrzG78WT3Q2xwMS6PBk4VcGyhromJK5OUCTrI++W+wClfxKrmO
 XTHIu7DErF+o5WeJScmcHEmRuDUvVWAt37JfEgWb6F7eQB82JLdvWUEPu
 l/Z7majcmSuIbfzc9ULnw+rS+UPOOTFra/qfVuOZgPSnp7OtlFCyjXXuF
 3iVGyWM1LvVoQ8WH6gcONKvnkl9VRRLl5MTroUJ+8DKlsoZDwJrVb4TQj
 Y9TB6bPPiDcnB5It/1PgGNfg4MCetjEab6JEHXXzXb70bTeU3wzSoKeUw
 Khzat9j7qB3Fk8SXUV82YjSlBSTq8HFuIcV+1aSZyuJIRTzeKQomv8Mhg g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272554488"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="272554488"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 18:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="627290208"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2022 18:40:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFS34-000VS3-Cq; Thu, 03 Feb 2022 02:40:38 +0000
Date: Thu, 3 Feb 2022 10:39:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 7/8] VMCI: dma dg: add support for DMA datagrams sends
Message-ID: <202202031004.SmRs3Z6M-lkp@intel.com>
References: <20220202144910.10349-8-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-8-jhansen@vmware.com>
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

Hi Jorgen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 7ab004dbcbee38b8a70798835d3ffcd97a985a5e
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220203/202202031004.SmRs3Z6M-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/303777a2a8daa11d529827395318bb698ddee57e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout 303777a2a8daa11d529827395318bb698ddee57e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/misc/vmw_vmci/vmci_guest.c:106:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:106:45: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:106:45: sparse:     got char *
   drivers/misc/vmw_vmci/vmci_guest.c:103:14: sparse: sparse: symbol 'vmci_read_reg' was not declared. Should it be static?
   drivers/misc/vmw_vmci/vmci_guest.c:113:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:113:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:113:44: sparse:     got char *
   drivers/misc/vmw_vmci/vmci_guest.c:110:6: sparse: sparse: symbol 'vmci_write_reg' was not declared. Should it be static?
>> drivers/misc/vmw_vmci/vmci_guest.c:118:5: sparse: sparse: symbol 'vmci_write_data' was not declared. Should it be static?
   drivers/misc/vmw_vmci/vmci_guest.c:554:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char *mmio_base @@     got void [noderef] __iomem * @@
   drivers/misc/vmw_vmci/vmci_guest.c:554:27: sparse:     expected char *mmio_base
   drivers/misc/vmw_vmci/vmci_guest.c:554:27: sparse:     got void [noderef] __iomem *
   drivers/misc/vmw_vmci/vmci_guest.c:909:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got char *mmio_base @@
   drivers/misc/vmw_vmci/vmci_guest.c:909:43: sparse:     expected void [noderef] __iomem *
   drivers/misc/vmw_vmci/vmci_guest.c:909:43: sparse:     got char *mmio_base

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

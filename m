Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B5C433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 00:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2003A40569;
	Thu,  3 Feb 2022 00:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7J7UecNMi2z; Thu,  3 Feb 2022 00:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1992400E4;
	Thu,  3 Feb 2022 00:49:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75ECFC001A;
	Thu,  3 Feb 2022 00:49:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E83ACC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3D0140303
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vv0bXItd1j04
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:49:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A84BD402D8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643849379; x=1675385379;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AVze6/yhOpIsiSvcvqZJsPmefQnSYgxJlx13mlvTxVY=;
 b=W7Yk5AAhUqiowjyUozXMdGYawD4WQPn1UualBwqW5BdHvSC00DF9BhJm
 31yypdgPTTzD8Pr1Rbx03Fib6oW9OtgUy2j4QFZrg9wHLT2UwMyl/8+r2
 BqUiGir5j1H/lWHqQxVfC+qRxxnS4thzNeYkvqd9YSlEpnfbRtoxZK5RF
 1FBCZ3Dtu7EBgnoSuUZYheQGFUz14GGxgFiqfvDVP8WnvtI9aoGffFjul
 RlixNP/9WT1FHNKU6ig7sTbxvCMXfvqDxsx/QFjrBRDVjqFj2O4hMDoll
 bFDaQfi/2ZMh8EHNpxKCB6aqE3i5841l0PThpqJxZngpsug3YyUeA5GDW w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="231616950"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="231616950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 16:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="631174148"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 02 Feb 2022 16:49:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFQJb-000VLl-79; Thu, 03 Feb 2022 00:49:35 +0000
Date: Thu, 3 Feb 2022 08:48:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 7/8] VMCI: dma dg: add support for DMA datagrams sends
Message-ID: <202202030803.BfgZqtfl-lkp@intel.com>
References: <20220202144910.10349-8-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-8-jhansen@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vishnu Dasa <vdasa@vmware.com>, kbuild-all@lists.01.org,
 pv-drivers@vmware.com, gregkh@linuxfoundation.org, llvm@lists.linux.dev,
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

Hi Jorgen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 7ab004dbcbee38b8a70798835d3ffcd97a985a5e
config: i386-randconfig-a013-20220131 (https://download.01.org/0day-ci/archive/20220203/202202030803.BfgZqtfl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/303777a2a8daa11d529827395318bb698ddee57e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout 303777a2a8daa11d529827395318bb698ddee57e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/vmw_vmci/vmci_guest.c:103:14: warning: no previous prototype for function 'vmci_read_reg' [-Wmissing-prototypes]
   unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
                ^
   drivers/misc/vmw_vmci/vmci_guest.c:103:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
   ^
   static 
   drivers/misc/vmw_vmci/vmci_guest.c:110:6: warning: no previous prototype for function 'vmci_write_reg' [-Wmissing-prototypes]
   void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
        ^
   drivers/misc/vmw_vmci/vmci_guest.c:110:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   ^
   static 
>> drivers/misc/vmw_vmci/vmci_guest.c:118:5: warning: no previous prototype for function 'vmci_write_data' [-Wmissing-prototypes]
   int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
       ^
   drivers/misc/vmw_vmci/vmci_guest.c:118:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
   ^
   static 
   3 warnings generated.


vim +/vmci_write_data +118 drivers/misc/vmw_vmci/vmci_guest.c

   109	
 > 110	void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   111	{
   112		if (dev->mmio_base != NULL)
   113			writel(val, dev->mmio_base + reg);
   114		else
   115			iowrite32(val, dev->iobase + reg);
   116	}
   117	
 > 118	int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
   119	{
   120		int result;
   121	
   122		if (dev->mmio_base != NULL) {
   123			struct vmci_data_in_out_header *buffer_header = dev->tx_buffer;
   124			u8 *dg_out_buffer = (u8 *)(buffer_header + 1);
   125	
   126			if (VMCI_DG_SIZE(dg) > VMCI_MAX_DG_SIZE)
   127				return VMCI_ERROR_INVALID_ARGS;
   128	
   129			/*
   130			 * Initialize send buffer with outgoing datagram
   131			 * and set up header for inline data. Device will
   132			 * not access buffer asynchronously - only after
   133			 * the write to VMCI_DATA_OUT_LOW_ADDR.
   134			 */
   135			memcpy(dg_out_buffer, dg, VMCI_DG_SIZE(dg));
   136			buffer_header->opcode = 0;
   137			buffer_header->size = VMCI_DG_SIZE(dg);
   138			buffer_header->busy = 1;
   139	
   140			vmci_write_reg(dev, lower_32_bits(dev->tx_buffer_base),
   141				       VMCI_DATA_OUT_LOW_ADDR);
   142	
   143			/* Caller holds a spinlock, so cannot block. */
   144			spin_until_cond(buffer_header->busy == 0);
   145	
   146			result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
   147			if (result == VMCI_SUCCESS)
   148				result = (int)buffer_header->result;
   149		} else {
   150			iowrite8_rep(dev->iobase + VMCI_DATA_OUT_ADDR,
   151				     dg, VMCI_DG_SIZE(dg));
   152			result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
   153		}
   154	
   155		return result;
   156	}
   157	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

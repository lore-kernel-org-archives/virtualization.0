Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92711C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 17:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29B844158A;
	Wed,  2 Feb 2022 17:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aa-HaApoblA3; Wed,  2 Feb 2022 17:27:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6D19415AC;
	Wed,  2 Feb 2022 17:27:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88A75C000B;
	Wed,  2 Feb 2022 17:27:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE49C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 17:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9972760BEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 17:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5UTqZj6wiEzv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 17:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91F0760AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643822841; x=1675358841;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dE+VPeGUtHZgWsAhv02d/C3FztwU1vH8EMY00U1inVA=;
 b=Uss16xLahkrbsoR/H0FIQ7BViBsd3Ip3zRmXsf5T0dCB2NbX9tnZ5zYB
 GsWY8cW1CZvv0cjiYMN1ePDvZ1GHlmLdWuaPIiB/Mx6G0ldxzu1LUJy86
 Q7gjuvD54AupRlXZuJT6h34/xjbqOP0XmMuG2GLWk4nMZyuckA7ohLGze
 Ox36hsWdXT98dPyYw0tZzlk+HrX+P5iU6DNi4Gr7mnc2LifMKtYXsmBkE
 COT4B/JVmvhf+AIUT7cOlL9UXwGxfAll8UnL+De5sqXorVOOj5ffCYIMU
 hprT6hrwELm7XZQOUZHRGoIiULJXWm/sygDR/OqPKK26uSE31iNSgxHtJ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235375743"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="235375743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 09:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="534924090"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2022 09:14:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFJCr-000UsJ-Ni; Wed, 02 Feb 2022 17:14:09 +0000
Date: Thu, 3 Feb 2022 01:14:01 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 7/8] VMCI: dma dg: add support for DMA datagrams sends
Message-ID: <202202030100.5Mr551y1-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202030100.5Mr551y1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/303777a2a8daa11d529827395318bb698ddee57e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout 303777a2a8daa11d529827395318bb698ddee57e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/vmw_vmci/vmci_guest.c:103:14: warning: no previous prototype for 'vmci_read_reg' [-Wmissing-prototypes]
     103 | unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
         |              ^~~~~~~~~~~~~
   drivers/misc/vmw_vmci/vmci_guest.c:110:6: warning: no previous prototype for 'vmci_write_reg' [-Wmissing-prototypes]
     110 | void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
         |      ^~~~~~~~~~~~~~
>> drivers/misc/vmw_vmci/vmci_guest.c:118:5: warning: no previous prototype for 'vmci_write_data' [-Wmissing-prototypes]
     118 | int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
         |     ^~~~~~~~~~~~~~~


vim +/vmci_write_data +118 drivers/misc/vmw_vmci/vmci_guest.c

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

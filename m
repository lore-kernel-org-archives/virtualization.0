Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9C2C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 00:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFB6340442;
	Thu,  3 Feb 2022 00:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IaCd1I2q39B9; Thu,  3 Feb 2022 00:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B2744047D;
	Thu,  3 Feb 2022 00:18:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10371C001A;
	Thu,  3 Feb 2022 00:18:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 280C7C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03CD44047D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zRBe7XNwKvoe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:18:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1147C40442
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 00:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643847518; x=1675383518;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gshEpsZSJ7uuSyPCXlwkOTrGJ3TT3qAZaZ3s4pjWvEY=;
 b=g7jSOrQ5SLTjvz1d/EXXaqAnYECPr7DioYMUMKkX5jkLS0Tt8jTqgzUv
 ktormqWv2R5gyOmz/1d5iKybdaOuF+JThTedkKSHJUmIpA8mVIWX7PAH6
 rljV5rwBsrK5/BV8ffvosFC41vR6AZFECN4tz4FyCTHSzqDZ+9ynIzkrf
 ANZ5QUF7R4JD/CTMZYdqtfpL/WwTkiJ1taGWeR5dQT68PqekEL2QIdmzD
 u1M0XnQ8vySwaqD4GV9wPSzZB33zhzmbYz0YKEZLEGM/3bOlCoNGSmHIE
 nr0FQgP5AB5uidvX8h/jM9w4BPpCqBuBF+pQlZtkPDhucqQr6vbDjaBD8 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="246879599"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="246879599"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 16:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; d="scan'208";a="483051021"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 16:18:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFPpa-000VJh-GG; Thu, 03 Feb 2022 00:18:34 +0000
Date: Thu, 3 Feb 2022 08:18:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 6/8] VMCI: dma dg: allocate send and receive buffers for
 DMA datagrams
Message-ID: <202202030713.SJ9T0zv6-lkp@intel.com>
References: <20220202144910.10349-7-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-7-jhansen@vmware.com>
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
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220203/202202030713.SJ9T0zv6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/a5ca330527cc5a2ed5eba621707076ab15d856e5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout a5ca330527cc5a2ed5eba621707076ab15d856e5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/misc/vmw_vmci/vmci_guest.c:105:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:105:45: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:105:45: sparse:     got char *
   drivers/misc/vmw_vmci/vmci_guest.c:102:14: sparse: sparse: symbol 'vmci_read_reg' was not declared. Should it be static?
   drivers/misc/vmw_vmci/vmci_guest.c:112:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:112:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:112:44: sparse:     got char *
   drivers/misc/vmw_vmci/vmci_guest.c:109:6: sparse: sparse: symbol 'vmci_write_reg' was not declared. Should it be static?
   drivers/misc/vmw_vmci/vmci_guest.c:514:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char *mmio_base @@     got void [noderef] __iomem * @@
   drivers/misc/vmw_vmci/vmci_guest.c:514:27: sparse:     expected char *mmio_base
   drivers/misc/vmw_vmci/vmci_guest.c:514:27: sparse:     got void [noderef] __iomem *
>> drivers/misc/vmw_vmci/vmci_guest.c:869:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got char *mmio_base @@
   drivers/misc/vmw_vmci/vmci_guest.c:869:43: sparse:     expected void [noderef] __iomem *
   drivers/misc/vmw_vmci/vmci_guest.c:869:43: sparse:     got char *mmio_base

vim +869 drivers/misc/vmw_vmci/vmci_guest.c

   813	
   814	static void vmci_guest_remove_device(struct pci_dev *pdev)
   815	{
   816		struct vmci_guest_device *vmci_dev = pci_get_drvdata(pdev);
   817		int vmci_err;
   818	
   819		dev_dbg(&pdev->dev, "Removing device\n");
   820	
   821		atomic_dec(&vmci_num_guest_devices);
   822	
   823		vmci_qp_guest_endpoints_exit();
   824	
   825		vmci_err = vmci_event_unsubscribe(ctx_update_sub_id);
   826		if (vmci_err < VMCI_SUCCESS)
   827			dev_warn(&pdev->dev,
   828				 "Failed to unsubscribe from event (type=%d) with subscriber (ID=0x%x): %d\n",
   829				 VMCI_EVENT_CTX_ID_UPDATE, ctx_update_sub_id, vmci_err);
   830	
   831		spin_lock_irq(&vmci_dev_spinlock);
   832		vmci_dev_g = NULL;
   833		vmci_pdev = NULL;
   834		spin_unlock_irq(&vmci_dev_spinlock);
   835	
   836		dev_dbg(&pdev->dev, "Resetting vmci device\n");
   837		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
   838	
   839		/*
   840		 * Free IRQ and then disable MSI/MSI-X as appropriate.  For
   841		 * MSI-X, we might have multiple vectors, each with their own
   842		 * IRQ, which we must free too.
   843		 */
   844		if (vmci_dev->exclusive_vectors) {
   845			free_irq(pci_irq_vector(pdev, 1), vmci_dev);
   846			if (vmci_dev->mmio_base != NULL)
   847				free_irq(pci_irq_vector(pdev, 2), vmci_dev);
   848		}
   849		free_irq(pci_irq_vector(pdev, 0), vmci_dev);
   850		pci_free_irq_vectors(pdev);
   851	
   852		tasklet_kill(&vmci_dev->datagram_tasklet);
   853		tasklet_kill(&vmci_dev->bm_tasklet);
   854	
   855		if (vmci_dev->notification_bitmap) {
   856			/*
   857			 * The device reset above cleared the bitmap state of the
   858			 * device, so we can safely free it here.
   859			 */
   860	
   861			dma_free_coherent(&pdev->dev, PAGE_SIZE,
   862					  vmci_dev->notification_bitmap,
   863					  vmci_dev->notification_base);
   864		}
   865	
   866		vmci_free_dg_buffers(vmci_dev);
   867	
   868		if (vmci_dev->mmio_base != NULL)
 > 869			pci_iounmap(pdev, vmci_dev->mmio_base);
   870	
   871		/* The rest are managed resources and will be freed by PCI core */
   872	}
   873	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CCC433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 13:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C51B2425D3;
	Fri, 20 May 2022 13:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClZ1fd9bx944; Fri, 20 May 2022 13:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C84D3425D0;
	Fri, 20 May 2022 13:39:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B3CDC0039;
	Fri, 20 May 2022 13:39:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ADC4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 13:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4842F846BB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 13:39:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pvw3NP7di3aG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 13:39:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9F55846AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653053992; x=1684589992;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tEsNkD67VlMRMMbJpoolW2AuTZVamWWhFYXi0Uoe5Js=;
 b=aGy5tPIFkNtD5JzqPTC8h8ztmUoM9gJpHL/0gLax/PbvbVRoLrjYaFZm
 M+AMMWZsDSvRvkqDDmhhOddlaenP3bFXH+8Nopuzq3vl94wUvtopwphH0
 tFKctlTMInFq3TOr/FWb5+BUOhVDeDJn463+PiN2XckE4VkpVfNjvzWMd
 fD2O8RYWOAkd5I0s2DK96Y6qAUvdh0tzZjgHsBbHFIDYPArnoRoe3OsK6
 XfyyBIPCnDj42WFjkk3LmsYoWScGfntbaatYtJaZ3bOF4nHSLKav1QKqL
 29ROIKzQQD265493ZkUwZJ8xA8AoMYoFzAkymiCGCCKf4+Xza3kUJdpZT w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270191243"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="270191243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 06:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="818556999"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 20 May 2022 06:39:46 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ns2r3-0004k5-Eb;
 Fri, 20 May 2022 13:39:45 +0000
Date: Fri, 20 May 2022 21:39:32 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
 naoya.horiguchi@nec.com, mst@redhat.com, david@redhat.com
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <202205202151.7T3K7Szf-lkp@intel.com>
References: <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
Cc: kbuild-all@lists.01.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
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

Hi zhenwei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220519]
[cannot apply to linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: nios2-randconfig-r002-20220519 (https://download.01.org/0day-ci/archive/20220520/202205202151.7T3K7Szf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a42127073dd4adb6354649c8235c5cde033d01f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
        git checkout a42127073dd4adb6354649c8235c5cde033d01f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `unpoison_memory_func':
>> drivers/virtio/virtio_balloon.c:679: undefined reference to `unpoison_memory'
   drivers/virtio/virtio_balloon.c:679:(.text+0xc00): relocation truncated to fit: R_NIOS2_CALL26 against `unpoison_memory'
   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_probe':
>> drivers/virtio/virtio_balloon.c:1247: undefined reference to `register_memory_failure_notifier'
   drivers/virtio/virtio_balloon.c:1247:(.text+0x1940): relocation truncated to fit: R_NIOS2_CALL26 against `register_memory_failure_notifier'
   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_remove':
>> drivers/virtio/virtio_balloon.c:1323: undefined reference to `unregister_memory_failure_notifier'
   drivers/virtio/virtio_balloon.c:1323:(.text+0x1bcc): relocation truncated to fit: R_NIOS2_CALL26 against `unregister_memory_failure_notifier'


vim +679 drivers/virtio/virtio_balloon.c

   661	
   662	static void unpoison_memory_func(struct work_struct *work)
   663	{
   664		struct virtio_balloon *vb;
   665		struct page *page;
   666	
   667		vb = container_of(work, struct virtio_balloon, unpoison_memory_work);
   668	
   669		do {
   670			spin_lock(&vb->recover_page_list_lock);
   671			page = list_first_entry_or_null(&vb->recovered_page_list,
   672							struct page, lru);
   673			if (page)
   674				list_del(&page->lru);
   675			spin_unlock(&vb->recover_page_list_lock);
   676	
   677			if (page) {
   678				put_page(page);
 > 679				unpoison_memory(page_to_pfn(page), true, "virtio-balloon");
   680			}
   681		} while (page);
   682	}
   683	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

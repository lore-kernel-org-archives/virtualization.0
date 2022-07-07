Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80777C43334
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBF2641161;
	Thu,  7 Jul 2022 23:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBF2641161
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Os06izds
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWu65Z8A1zH0; Thu,  7 Jul 2022 23:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 208CF4014B;
	Thu,  7 Jul 2022 23:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 208CF4014B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF6F2C0035;
	Thu,  7 Jul 2022 23:02:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB70C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 23:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4144B81747
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 23:02:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4144B81747
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Os06izds
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFB9Nb57S4bl
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 23:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FC7F816F5
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FC7F816F5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657234933; x=1688770933;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3byBZehLtKcDOmjsnhhmWfxIRWZEBDCHys/67WVncWE=;
 b=Os06izdskIxiC3FDKrZIFtnU8mEPwtbEimClMFh2zwaqYjq+sAW7qQM9
 r7R0nvWgi4o3AZF6O3IMws6MygzNVWoVAskDrLoJoiwM0kM8IlkjCj7dc
 nJJFp3Kb3dj+owt+hdeCpFbJJO0onW+/6jzmHG4y6hqfucBq2wuHFMzIh
 hPj3+ju3Uvwe4RBNKsmSgHXekT2EWcKq2O6/1jQyg4N5ovJ22Awr9RzGu
 4TcMn5RDM2741MqN8rkStuClPfYN/iMEa9wrKbygy6nFPQMkjmcTOChaG
 AQ1yFrllLfJ1NAjHoEy7Dxsbhm7EVjeD7k2Enhb8j04oJNnTuLxFjdQCy A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="282891998"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="282891998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2022 16:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; d="scan'208";a="543990636"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 07 Jul 2022 16:02:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1o9aVc-000MZv-R3;
 Thu, 07 Jul 2022 23:02:08 +0000
Date: Fri, 8 Jul 2022 07:01:25 +0800
From: kernel test robot <lkp@intel.com>
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com, xiaodong.liu@intel.com,
 maxime.coquelin@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH v2 5/5] vduse: Support registering userspace memory for
 IOTLB
Message-ID: <202207080640.p8q3NqHB-lkp@intel.com>
References: <20220706050503.171-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220706050503.171-6-xieyongji@bytedance.com>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, songmuchun@bytedance.com
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

Hi Xie,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e35e5b6f695d241ffb1d223207da58a1fbcdff4b
config: hexagon-randconfig-r005-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080640.p8q3NqHB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9be699264e4fede9c3be913b2d1003c260d9fa05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/VDUSE-Support-registering-userspace-memory-as-bounce-buffer/20220706-130802
        git checkout 9be699264e4fede9c3be913b2d1003c260d9fa05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vdpa/vdpa_user/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:949:2: error: call to undeclared function 'vfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           vfree(dev->iotlb_mem->pages);
           ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:978:14: error: call to undeclared function '__vmalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
                       ^
   drivers/vdpa/vdpa_user/vduse_dev.c:978:14: note: did you mean '__kmalloc'?
   include/linux/slab.h:434:7: note: '__kmalloc' declared here
   void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
         ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:978:12: warning: incompatible integer to pointer conversion assigning to 'struct page **' from 'int' [-Wint-conversion]
           page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vdpa/vdpa_user/vduse_dev.c:1018:3: error: call to undeclared function 'vfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   vfree(page_list);
                   ^
   drivers/vdpa/vdpa_user/vduse_dev.c:1654:51: warning: shift count >= width of type [-Wshift-count-overflow]
           ret = dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(64));
                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 3 errors generated.


vim +/vfree +949 drivers/vdpa/vdpa_user/vduse_dev.c

   929	
   930	static int vduse_dev_dereg_iotlb_mem(struct vduse_dev *dev,
   931					     u64 iova, u64 size)
   932	{
   933		int ret;
   934	
   935		mutex_lock(&dev->mem_lock);
   936		ret = -ENOENT;
   937		if (!dev->iotlb_mem)
   938			goto unlock;
   939	
   940		ret = -EINVAL;
   941		if (dev->iotlb_mem->iova != iova || size != dev->domain->bounce_size)
   942			goto unlock;
   943	
   944		vduse_domain_remove_user_bounce_pages(dev->domain);
   945		unpin_user_pages_dirty_lock(dev->iotlb_mem->pages,
   946					    dev->iotlb_mem->npages, true);
   947		atomic64_sub(dev->iotlb_mem->npages, &dev->iotlb_mem->mm->pinned_vm);
   948		mmdrop(dev->iotlb_mem->mm);
 > 949		vfree(dev->iotlb_mem->pages);
   950		kfree(dev->iotlb_mem);
   951		dev->iotlb_mem = NULL;
   952		ret = 0;
   953	unlock:
   954		mutex_unlock(&dev->mem_lock);
   955		return ret;
   956	}
   957	
   958	static int vduse_dev_reg_iotlb_mem(struct vduse_dev *dev,
   959					   u64 iova, u64 uaddr, u64 size)
   960	{
   961		struct page **page_list = NULL;
   962		struct vduse_iotlb_mem *mem = NULL;
   963		long pinned = 0;
   964		unsigned long npages, lock_limit;
   965		int ret;
   966	
   967		if (size != dev->domain->bounce_size ||
   968		    iova != 0 || uaddr & ~PAGE_MASK)
   969			return -EINVAL;
   970	
   971		mutex_lock(&dev->mem_lock);
   972		ret = -EEXIST;
   973		if (dev->iotlb_mem)
   974			goto unlock;
   975	
   976		ret = -ENOMEM;
   977		npages = size >> PAGE_SHIFT;
 > 978		page_list = __vmalloc(array_size(npages, sizeof(struct page *)),
   979				      GFP_KERNEL_ACCOUNT);
   980		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
   981		if (!page_list || !mem)
   982			goto unlock;
   983	
   984		mmap_read_lock(current->mm);
   985	
   986		lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
   987		if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
   988			goto out;
   989	
   990		pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
   991					page_list, NULL);
   992		if (pinned != npages) {
   993			ret = pinned < 0 ? pinned : -ENOMEM;
   994			goto out;
   995		}
   996	
   997		ret = vduse_domain_add_user_bounce_pages(dev->domain,
   998							 page_list, pinned);
   999		if (ret)
  1000			goto out;
  1001	
  1002		atomic64_add(npages, &current->mm->pinned_vm);
  1003	
  1004		mem->pages = page_list;
  1005		mem->npages = pinned;
  1006		mem->iova = iova;
  1007		mem->mm = current->mm;
  1008		mmgrab(current->mm);
  1009	
  1010		dev->iotlb_mem = mem;
  1011	out:
  1012		if (ret && pinned > 0)
  1013			unpin_user_pages(page_list, pinned);
  1014	
  1015		mmap_read_unlock(current->mm);
  1016	unlock:
  1017		if (ret) {
  1018			vfree(page_list);
  1019			kfree(mem);
  1020		}
  1021		mutex_unlock(&dev->mem_lock);
  1022		return ret;
  1023	}
  1024	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E738AC46467
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 22:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62DEF60F88;
	Thu, 19 Jan 2023 22:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62DEF60F88
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GXATZjpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o30nMOgDNDEu; Thu, 19 Jan 2023 22:31:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD1D060F80;
	Thu, 19 Jan 2023 22:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD1D060F80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD0DC0032;
	Thu, 19 Jan 2023 22:31:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82F8FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 22:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B6E540734
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 22:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B6E540734
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GXATZjpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LyN7MLU4ZvcT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 22:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19A214063C
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19A214063C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674167491; x=1705703491;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JoJGpj8vaP9dF2CWcRmJfrTrGxAvkWjp3W42IgzKc3E=;
 b=GXATZjpXYxdG4aBE3Knb077gu2F2ss2FBnlybsa+VrJJRnWZfhmwkst8
 aIKTvY0cDHelp7XSgJxRoQ36qNt9lWH1iMsizTAOFh1UDIROGDkrH2CDV
 0KkwgpfWwkvMW8qaEERGQV1OLRr+q3i5EEByHefui9s4sZtuAURroqywd
 GFPDRyKedslBhqZWnQ1mBi3o2+cXmOmwTQ1Gp0941sgBsleKg25iJUilj
 KXDd7VHWFzG7a9NS98LFdCW7MzB9prlqq0bOBp0KQgJhcUZmVktaEObau
 /JtVsBfAkIF4PGZ8eYP6G8Brj5Y4CviCF6YjIII6aUk1j9TyMEnB8yb9v g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389965189"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; d="scan'208";a="389965189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2023 14:31:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768410237"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; d="scan'208";a="768410237"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 14:31:26 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pIdRN-0001uq-2N;
 Thu, 19 Jan 2023 22:31:25 +0000
Date: Fri, 20 Jan 2023 06:31:05 +0800
From: kernel test robot <lkp@intel.com>
To: Babis Chalios <bchalios@amazon.es>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio-rng: add sysfs entries for leak detection
Message-ID: <202301200640.CsblwTsa-lkp@intel.com>
References: <20230119184349.74072-3-bchalios@amazon.es>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119184349.74072-3-bchalios@amazon.es>
Cc: xmarcalx@amazon.co.uk, Jason@zx2c4.com, amit@kernel.org, graf@amazon.de,
 oe-kbuild-all@lists.linux.dev
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

Hi Babis,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.2-rc4 next-20230119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
patch link:    https://lore.kernel.org/r/20230119184349.74072-3-bchalios%40amazon.es
patch subject: [PATCH 2/2] virtio-rng: add sysfs entries for leak detection
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230120/202301200640.CsblwTsa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2a801d93b8225555e4cb293a173e2053870cb2d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
        git checkout 2a801d93b8225555e4cb293a173e2053870cb2d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/hw_random/virtio-rng.c:61:9: warning: no previous prototype for 'virtrng_sysfs_read' [-Wmissing-prototypes]
      61 | ssize_t virtrng_sysfs_read(struct file *filep, struct kobject *kobj,
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/char/hw_random/virtio-rng.c:76:5: warning: no previous prototype for 'virtrng_sysfs_mmap' [-Wmissing-prototypes]
      76 | int virtrng_sysfs_mmap(struct file *filep, struct kobject *kobj,
         |     ^~~~~~~~~~~~~~~~~~
   drivers/char/hw_random/virtio-rng.c:106:5: warning: no previous prototype for 'add_fill_on_leak_request' [-Wmissing-prototypes]
     106 | int add_fill_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq, void *data, size_t len)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/hw_random/virtio-rng.c:120:5: warning: no previous prototype for 'virtrng_fill_on_leak' [-Wmissing-prototypes]
     120 | int virtrng_fill_on_leak(struct virtrng_info *vi, void *data, size_t len)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/char/hw_random/virtio-rng.c:141:5: warning: no previous prototype for 'add_copy_on_leak_request' [-Wmissing-prototypes]
     141 | int add_copy_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/hw_random/virtio-rng.c:160:5: warning: no previous prototype for 'virtrng_copy_on_leak' [-Wmissing-prototypes]
     160 | int virtrng_copy_on_leak(struct virtrng_info *vi, void *to, void *from, size_t len)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/virtrng_sysfs_read +61 drivers/char/hw_random/virtio-rng.c

    59	
    60	#ifdef CONFIG_SYSFS
  > 61	ssize_t virtrng_sysfs_read(struct file *filep, struct kobject *kobj,
    62			struct bin_attribute *attr, char *buf, loff_t pos, size_t len)
    63	{
    64		struct virtrng_info *vi = attr->private;
    65		unsigned long gen_counter = *(unsigned long *)vi->map_buffer;
    66	
    67		if (!len)
    68			return 0;
    69	
    70		len = min(len, sizeof(gen_counter));
    71		memcpy(buf, &gen_counter, len);
    72	
    73		return len;
    74	}
    75	
  > 76	int virtrng_sysfs_mmap(struct file *filep, struct kobject *kobj,
    77			struct bin_attribute *attr, struct vm_area_struct *vma)
    78	{
    79		struct virtrng_info *vi = attr->private;
    80	
    81		if (vma->vm_pgoff || vma_pages(vma) > 1)
    82			return -EINVAL;
    83	
    84		if (vma->vm_flags & VM_WRITE)
    85			return -EPERM;
    86	
    87		vma->vm_flags |= VM_DONTEXPAND;
    88		vma->vm_flags &= ~VM_MAYWRITE;
    89	
    90		return vm_insert_page(vma, vma->vm_start, virt_to_page(vi->map_buffer));
    91	}
    92	#endif
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

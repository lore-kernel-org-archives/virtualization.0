Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B673448
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jul 2024 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720152114; cv=none; b=Vwtecka+ZdVpH7/FksZOH1RZEM/YihB5gbXx7OijFVWV4k3JtZ5WTo6bH1T8Jv8iYA8DCwZ+d3q1zELgaN6W4K6/VRZ4zERA+WyzH55ZNW5XKlGydHBx5ANXusnnxB33lJJ74AWQKOl+v+mho58jLPz2QwvEUWizysnMZzBt8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720152114; c=relaxed/simple;
	bh=5EBce3E8eE1JEfT2FfDkG8yDu+DyvXnM1e4rPXI45c8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VWS3b5SnxtmssX2h1kUGI9m8oKd88mYJiz/QcORABA+/RyCqXPUx69snevTguojHo1EOjUy3pTtGwAS6ZDPP0SgDDxwGwfPRir2Owe9+laT3zIjPLbQYlAxmrwtFRVGacgHzwLEg8cwQFIHxw/TRXGzSmsYvdGccKmRPMiZcy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDWD1cIQ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDWD1cIQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0BB8409C5
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jul 2024 04:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1VKb-Xu1Fion for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jul 2024 04:01:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 10757409A6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10757409A6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YDWD1cIQ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10757409A6
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jul 2024 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720152111; x=1751688111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5EBce3E8eE1JEfT2FfDkG8yDu+DyvXnM1e4rPXI45c8=;
  b=YDWD1cIQ1lAhhiLlIRyWedtD1uPHfz85i1Y7T829m7Sjuk3vEp8Fgg9w
   vEN+AaiEjx58d7D4+rGgVzJTrgRnu7kyokOBm2S1ZzujXPNtB6yMKDCP/
   tPX41kSy+zJQfPWFJ5w324d67OqHDbtGRBONBKqCnQv24x9dptXG7Th8j
   sxtuBDKkHqgAkR6BlG0cP1uxuvymFOT8r1WRboDFbHQAsq7xTMNNEBUjh
   XHetxVoniNI94d9SM9YQr1uyURMg68BumekG7lFulsZf8IT4Ual6cnV0e
   pLWfhlqgYylovvqtzfcdtaZUK2zPGIKDhYsGYvsEMkQS6rFqCV7bWe83N
   g==;
X-CSE-ConnectionGUID: vL92RyA2SRaPr+NRxFKSEw==
X-CSE-MsgGUID: vpQe98skRJSVhWH2tpYqjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17304554"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17304554"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 21:01:49 -0700
X-CSE-ConnectionGUID: jIEgJw+DRYKM1ua22SjyEQ==
X-CSE-MsgGUID: S2q88q0QTd+FLhMN1qHT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46542221"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jul 2024 21:01:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPa8m-000Rsx-0b;
	Fri, 05 Jul 2024 04:01:44 +0000
Date: Fri, 5 Jul 2024 12:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [mst-vhost:vhost 45/58] drivers/s390/virtio/virtio_ccw.c:708:8:
 error: use of undeclared identifier 'vq_info'; did you mean 'vqs_info'?
Message-ID: <202407051104.7NJ6bvCs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   b3dab3dfaa73df6bde78cb52f6bc03f57c4d056c
commit: f07c2dc394264dd811776de1dec9544f2181f2e4 [45/58] virtio: convert find_vqs() op implementations to find_vqs_info()
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240705/202407051104.7NJ6bvCs-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407051104.7NJ6bvCs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407051104.7NJ6bvCs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/s390/virtio/virtio_ccw.c:12:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/s390/virtio/virtio_ccw.c:12:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/s390/virtio/virtio_ccw.c:12:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/s390/virtio/virtio_ccw.c:12:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/s390/virtio/virtio_ccw.c:708:8: error: use of undeclared identifier 'vq_info'; did you mean 'vqs_info'?
     708 |                 if (!vq_info->name) {
         |                      ^~~~~~~
         |                      vqs_info
   drivers/s390/virtio/virtio_ccw.c:692:33: note: 'vqs_info' declared here
     692 |                                struct virtqueue_info vqs_info[],
         |                                                      ^
   17 warnings and 1 error generated.


vim +708 drivers/s390/virtio/virtio_ccw.c

   689	
   690	static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
   691				       struct virtqueue *vqs[],
   692				       struct virtqueue_info vqs_info[],
   693				       struct irq_affinity *desc)
   694	{
   695		struct virtio_ccw_device *vcdev = to_vc_device(vdev);
   696		struct virtqueue_info *vqi;
   697		dma64_t *indicatorp = NULL;
   698		int ret, i, queue_idx = 0;
   699		struct ccw1 *ccw;
   700		dma32_t indicatorp_dma = 0;
   701	
   702		ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw), NULL);
   703		if (!ccw)
   704			return -ENOMEM;
   705	
   706		for (i = 0; i < nvqs; ++i) {
   707			vqi = &vqs_info[i];
 > 708			if (!vq_info->name) {
   709				vqs[i] = NULL;
   710				continue;
   711			}
   712	
   713			vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
   714						     vqi->name, vqi->ctx, ccw);
   715			if (IS_ERR(vqs[i])) {
   716				ret = PTR_ERR(vqs[i]);
   717				vqs[i] = NULL;
   718				goto out;
   719			}
   720		}
   721		ret = -ENOMEM;
   722		/*
   723		 * We need a data area under 2G to communicate. Our payload is
   724		 * the address of the indicators.
   725		*/
   726		indicatorp = ccw_device_dma_zalloc(vcdev->cdev,
   727						   sizeof(*indicatorp),
   728						   &indicatorp_dma);
   729		if (!indicatorp)
   730			goto out;
   731		*indicatorp = indicators_dma(vcdev);
   732		if (vcdev->is_thinint) {
   733			ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
   734			if (ret)
   735				/* no error, just fall back to legacy interrupts */
   736				vcdev->is_thinint = false;
   737		}
   738		ccw->cda = indicatorp_dma;
   739		if (!vcdev->is_thinint) {
   740			/* Register queue indicators with host. */
   741			*indicators(vcdev) = 0;
   742			ccw->cmd_code = CCW_CMD_SET_IND;
   743			ccw->flags = 0;
   744			ccw->count = sizeof(*indicatorp);
   745			ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
   746			if (ret)
   747				goto out;
   748		}
   749		/* Register indicators2 with host for config changes */
   750		*indicatorp = indicators2_dma(vcdev);
   751		*indicators2(vcdev) = 0;
   752		ccw->cmd_code = CCW_CMD_SET_CONF_IND;
   753		ccw->flags = 0;
   754		ccw->count = sizeof(*indicatorp);
   755		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
   756		if (ret)
   757			goto out;
   758	
   759		if (indicatorp)
   760			ccw_device_dma_free(vcdev->cdev, indicatorp,
   761					    sizeof(*indicatorp));
   762		ccw_device_dma_free(vcdev->cdev, ccw, sizeof(*ccw));
   763		return 0;
   764	out:
   765		if (indicatorp)
   766			ccw_device_dma_free(vcdev->cdev, indicatorp,
   767					    sizeof(*indicatorp));
   768		ccw_device_dma_free(vcdev->cdev, ccw, sizeof(*ccw));
   769		virtio_ccw_del_vqs(vdev);
   770		return ret;
   771	}
   772	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

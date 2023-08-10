Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB70C001DE
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 23:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA9D8418A3;
	Thu, 10 Aug 2023 23:53:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA9D8418A3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WgyhdqG1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuTe6kOj-KS4; Thu, 10 Aug 2023 23:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CECB741B70;
	Thu, 10 Aug 2023 23:53:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CECB741B70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1B7DC0071;
	Thu, 10 Aug 2023 23:53:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DB40C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 23:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4321341B70
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 23:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4321341B70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pTsg66j9-A_4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 23:53:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03236418A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 23:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03236418A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691711607; x=1723247607;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=5JIN1Yu4mUkxQTHvXnfAGLOJxcyhh/wZyopkkYQtIuo=;
 b=WgyhdqG1ZYInap0iULTJRcIeN0/rrdW/zFByiOIiCU48KQ33MaMPB/4u
 MLUsZDDZJ/JcrHy2pcvgRq+6GxEh4sjSCckp6ZdltzUPM5vNrzvoU2yWl
 vOPHI+6rLbOOX6/JXKefxpIsTvZ6Ef7cNaO3mVMe0rxEsxuED8KawSsei
 27Nc2BgjzSe4Z4Qsjoa8C0LONDXa2O0pWblP5rDbPK48xSnOk6HzGytaG
 lpgBjsSZzCfYkDjxK5ZQYuensKKaLM8FODlPsmfCmZO/ndnONAJDWnLAk
 SJz38ryB6sA9ngsHHfrpUgla6OUdI/7ttwUHY8EPIaWnlVkEcxJGDYmSu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351872278"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="351872278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 16:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="856092397"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; d="scan'208";a="856092397"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 10 Aug 2023 16:53:24 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qUFT1-0007LM-0U;
 Thu, 10 Aug 2023 23:53:23 +0000
Date: Fri, 11 Aug 2023 07:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [mst-vhost:vhost 34/46] drivers/vdpa/vdpa_user/vduse_dev.c:1812:23:
 error: use of undeclared identifier 'VIRTIO_RING_F_INDIRECT_DESC'
Message-ID: <202308110712.wCQoOG00-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, oe-kbuild-all@lists.linux.dev
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   bb59e1f960bd07f70a4b3d8de99bfd8d71835199
commit: 334f48a83105ebe129a660d1ea1a0c29f87d50c7 [34/46] vduse: Temporarily disable control queue features
config: x86_64-buildonly-randconfig-r001-20230811 (https://download.01.org/0day-ci/archive/20230811/202308110712.wCQoOG00-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110712.wCQoOG00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308110712.wCQoOG00-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:1812:23: error: use of undeclared identifier 'VIRTIO_RING_F_INDIRECT_DESC'
                   config->features &= VDUSE_NET_VALID_FEATURES_MASK;
                                       ^
   drivers/vdpa/vdpa_user/vduse_dev.c:66:11: note: expanded from macro 'VDUSE_NET_VALID_FEATURES_MASK'
            BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
                    ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:1812:23: error: use of undeclared identifier 'VIRTIO_F_EVENT_IDX'
   drivers/vdpa/vdpa_user/vduse_dev.c:67:11: note: expanded from macro 'VDUSE_NET_VALID_FEATURES_MASK'
            BIT_ULL(VIRTIO_F_EVENT_IDX) |          \
                    ^
>> drivers/vdpa/vdpa_user/vduse_dev.c:1812:23: error: use of undeclared identifier 'VIRTIO_F_IOMMU_PLATFORM'
   drivers/vdpa/vdpa_user/vduse_dev.c:69:11: note: expanded from macro 'VDUSE_NET_VALID_FEATURES_MASK'
            BIT_ULL(VIRTIO_F_IOMMU_PLATFORM) |     \
                    ^
   drivers/vdpa/vdpa_user/vduse_dev.c:2007:51: warning: shift count >= width of type [-Wshift-count-overflow]
           ret = dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(64));
                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 3 errors generated.


vim +/VIRTIO_RING_F_INDIRECT_DESC +1812 drivers/vdpa/vdpa_user/vduse_dev.c

  1804	
  1805	static void vduse_dev_features_filter(struct vduse_dev_config *config)
  1806	{
  1807		/*
  1808		 * Temporarily filter out virtio-net's control virtqueue and features
  1809		 * that depend on it while CVQ is being made more robust for VDUSE.
  1810		 */
  1811		if (config->device_id == VIRTIO_ID_NET)
> 1812			config->features &= VDUSE_NET_VALID_FEATURES_MASK;
  1813	}
  1814	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC1CE7A91
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 03:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F7FE60F62;
	Mon, 25 Sep 2023 03:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F7FE60F62
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCHcd59R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRjg5KhZlJAD; Mon, 25 Sep 2023 03:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F71260BF4;
	Mon, 25 Sep 2023 03:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F71260BF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 152E9C0071;
	Mon, 25 Sep 2023 03:19:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1DF5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CC1640589
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CC1640589
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dCHcd59R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n7O3B93ieQG5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:19:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 483EC400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 483EC400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695611960; x=1727147960;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Vy/Xo+gzkc5yJcEHuTcjeuI7dv1QqXm6C+kdkDWEFlo=;
 b=dCHcd59RT8npNbqbp3vEowF6jC8I3aYDbwgLMzqNohvI4fE9JzVumhV8
 v32z4348yobkiHyIRASI46LyhBe+0sUKzwEPnisMecVno+UQOY8eg6Gy5
 j0tBZWyWdoY06Emv3k7TvIqM5U9iXVj1IFmc8RNDg0yOlrbC6i/gtQmkj
 Xu2oq8DYX+Z7cJFVj2bVEeAlxwXnIb2pFQ9Znqxtu4GwGcF629ejaI8NR
 gdv6BxHBD7P1nXy2b3ukAhq4bNxjjao/PmhawA6UrQuakWXHp+GI2raBS
 uGMpbeia1XgO/qCuSQNxEVatUb5uRL2yqjI6LHS8rHVWykTGwdEkcUGoc w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371476829"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="371476829"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 20:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748207659"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="748207659"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 24 Sep 2023 20:19:15 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qkc7t-00018X-01;
 Mon, 25 Sep 2023 03:19:13 +0000
Date: Mon, 25 Sep 2023 11:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, alex.williamson@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH vfio 07/11] virtio-pci: Introduce admin commands
Message-ID: <202309251120.rWbiAZYM-lkp@intel.com>
References: <20230921124040.145386-8-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230921124040.145386-8-yishaih@nvidia.com>
Cc: kvm@vger.kernel.org, maorg@nvidia.com, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com,
 oe-kbuild-all@lists.linux.dev, leonro@nvidia.com
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

Hi Yishai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on awilliam-vfio/for-linus]
[also build test WARNING on linus/master v6.6-rc3 next-20230921]
[cannot apply to awilliam-vfio/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yishai-Hadas/virtio-pci-Use-virtio-pci-device-layer-vq-info-instead-of-generic-one/20230922-062611
base:   https://github.com/awilliam/linux-vfio.git for-linus
patch link:    https://lore.kernel.org/r/20230921124040.145386-8-yishaih%40nvidia.com
patch subject: [PATCH vfio 07/11] virtio-pci: Introduce admin commands
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230925/202309251120.rWbiAZYM-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251120.rWbiAZYM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251120.rWbiAZYM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/virtio/virtio_pci_modern_dev.c:3:
   In file included from include/linux/virtio_pci_modern.h:6:
>> include/uapi/linux/virtio_pci.h:270:4: warning: attribute '__packed__' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
   }; __packed
      ^
   include/linux/compiler_attributes.h:304:56: note: expanded from macro '__packed'
   #define __packed                        __attribute__((__packed__))
                                                          ^
   1 warning generated.


vim +270 include/uapi/linux/virtio_pci.h

   264	
   265	struct virtio_admin_cmd_notify_info_data {
   266		u8 flags; /* 0 = end of list, 1 = owner device, 2 = member device */
   267		u8 bar; /* BAR of the member or the owner device */
   268		u8 padding[6];
   269		__le64 offset; /* Offset within bar. */
 > 270	}; __packed
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

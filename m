Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1417BCE7A8C
	for <virtualization@archiver.kernel.org>; Sun, 24 Sep 2023 05:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8987F417DA;
	Sun, 24 Sep 2023 05:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8987F417DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YSFY2FDY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZ3ES-_zrUmX; Sun, 24 Sep 2023 05:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39D79417C0;
	Sun, 24 Sep 2023 05:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39D79417C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D33C0039;
	Sun, 24 Sep 2023 05:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 347BCC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 05:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAF9881ED7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 05:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAF9881ED7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YSFY2FDY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nzvLj6VAXV3f
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 05:19:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BB2D81E66
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 05:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BB2D81E66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695532761; x=1727068761;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZVGxuFAQWceZXoSUYCCW5E1Bk3FBdhz5SySROx/a4mw=;
 b=YSFY2FDYYwBjYyzvJgYe8Kiq3LZvj7BUthdP117bXTExwWhjnWziyjM5
 mezr+8bejAcG6zYfVYWFD7Rv0buXjt8duJY6F0rdkZUrnmfAs3ixzDYKO
 rqWWb9gSMo/YptOgNIfLgkVKSPDYuYN6RTAUvrfUdn6NO6vVUu0xGa9+U
 gzN3E2Ycc9DRJbj9mIVTBAvJA2Pu68slVlAN3T7Wfw5zFivK8o+57Msij
 Ie/S0D9qRPLngT2mO+7eAtZyxfellKipbqN3pdzTgoURaDEUYtiX4BLQg
 XzT+l9KG/4xbahzcBDySs9ROlGpwqG8Hf0pXVKtWAD1MAVvBAZpDDCMuX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="445181102"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; d="scan'208";a="445181102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2023 22:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="891279479"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; d="scan'208";a="891279479"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2023 22:18:18 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qkHWU-0003Fd-38;
 Sun, 24 Sep 2023 05:19:14 +0000
Date: Sun, 24 Sep 2023 13:18:21 +0800
From: kernel test robot <lkp@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, alex.williamson@redhat.com,
 mst@redhat.com, jasowang@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH vfio 07/11] virtio-pci: Introduce admin commands
Message-ID: <202309241353.ykr3cC2K-lkp@intel.com>
References: <20230921124040.145386-8-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230921124040.145386-8-yishaih@nvidia.com>
Cc: kvm@vger.kernel.org, maorg@nvidia.com, oe-kbuild-all@lists.linux.dev,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

kernel test robot noticed the following build errors:

[auto build test ERROR on awilliam-vfio/for-linus]
[also build test ERROR on mst-vhost/linux-next linus/master v6.6-rc2 next-20230921]
[cannot apply to awilliam-vfio/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yishai-Hadas/virtio-pci-Use-virtio-pci-device-layer-vq-info-instead-of-generic-one/20230922-062611
base:   https://github.com/awilliam/linux-vfio.git for-linus
patch link:    https://lore.kernel.org/r/20230921124040.145386-8-yishaih%40nvidia.com
patch subject: [PATCH vfio 07/11] virtio-pci: Introduce admin commands
config: i386-randconfig-012-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241353.ykr3cC2K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241353.ykr3cC2K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309241353.ykr3cC2K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/virtio_pci.h:250:9: error: unknown type name 'u8'
     250 |         u8 offset; /* Starting offset of the register(s) to write. */
         |         ^~
   ./usr/include/linux/virtio_pci.h:251:9: error: unknown type name 'u8'
     251 |         u8 reserved[7];
         |         ^~
   ./usr/include/linux/virtio_pci.h:252:9: error: unknown type name 'u8'
     252 |         u8 registers[];
         |         ^~
   ./usr/include/linux/virtio_pci.h:256:9: error: unknown type name 'u8'
     256 |         u8 offset; /* Starting offset of the register(s) to read. */
         |         ^~
   ./usr/include/linux/virtio_pci.h:266:9: error: unknown type name 'u8'
     266 |         u8 flags; /* 0 = end of list, 1 = owner device, 2 = member device */
         |         ^~
   ./usr/include/linux/virtio_pci.h:267:9: error: unknown type name 'u8'
     267 |         u8 bar; /* BAR of the member or the owner device */
         |         ^~
   ./usr/include/linux/virtio_pci.h:268:9: error: unknown type name 'u8'
     268 |         u8 padding[6];
         |         ^~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

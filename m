Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FFBC77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 18:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A3BA60AE3;
	Fri,  2 Jun 2023 18:14:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A3BA60AE3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OtAOvrh6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANorBPFJWulz; Fri,  2 Jun 2023 18:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC60161620;
	Fri,  2 Jun 2023 18:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC60161620
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2EBFC007A;
	Fri,  2 Jun 2023 18:14:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 434E8C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 18:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CAAE61620
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 18:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CAAE61620
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5LGlaWTWxJ8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 18:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1DE660AE3
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1DE660AE3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685729639; x=1717265639;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yIozrWDl/5hQ5vXZiPITasCQOwSsn+udVyA99ySkQ4Q=;
 b=OtAOvrh6tGx1HDq2t8zeN3c/OeX9CfJt0xLqF05FyYGUjsE32UaURIgy
 6vmtHGRgSMiqdzhr2SllEOQCv9DH4DN0sEhUG9m2x0sA4BNMgR/8QYTUw
 TrUaBGD2myjevbf7eIvSEyaO1uJqTnRjuLDA1ygjUxc4YgVbjwqiKoS1W
 2rkpmG9BUa7SDB/8xfVPibq2v4UHQtPy/rCx3YvjBX2Bw8+H7reWtpeAu
 PccnYbcOFxeT5XbCSttWQzjO2gBaa9lYztY5YFVWtxglNqfeZ9nANtXOJ
 mT9//LPD1HMcKpcxBAis+ZXeLlc4YU6dPRoB+ccjnIwTAh0GTmBtCE9lL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354782635"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; d="scan'208";a="354782635"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 11:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="702034801"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; d="scan'208";a="702034801"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 02 Jun 2023 11:13:53 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q59Hc-0000oX-1d;
 Fri, 02 Jun 2023 18:13:52 +0000
Date: Sat, 3 Jun 2023 02:13:07 +0800
From: kernel test robot <lkp@intel.com>
To: Shunsuke Mie <mie@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 1/1] vringh: IOMEM support
Message-ID: <202306030216.bpWr6XV0-lkp@intel.com>
References: <20230602055211.309960-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230602055211.309960-2-mie@igel.co.jp>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Shunsuke Mie <mie@igel.co.jp>,
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

Hi Shunsuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master horms-ipvs/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shunsuke-Mie/vringh-IOMEM-support/20230602-135351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230602055211.309960-2-mie%40igel.co.jp
patch subject: [PATCH v4 1/1] vringh: IOMEM support
config: i386-randconfig-i003-20230531 (https://download.01.org/0day-ci/archive/20230603/202306030216.bpWr6XV0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/de2a1f5220c32e953400f225aba6bd294a8d41b8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shunsuke-Mie/vringh-IOMEM-support/20230602-135351
        git checkout de2a1f5220c32e953400f225aba6bd294a8d41b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030216.bpWr6XV0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vhost/vringh.c: In function 'getu16_iomem':
>> drivers/vhost/vringh.c:1610:37: error: implicit declaration of function 'ioread16' [-Werror=implicit-function-declaration]
    1610 |         *val = vringh16_to_cpu(vrh, ioread16(p));
         |                                     ^~~~~~~~
   drivers/vhost/vringh.c: In function 'putu16_iomem':
>> drivers/vhost/vringh.c:1616:9: error: implicit declaration of function 'iowrite16' [-Werror=implicit-function-declaration]
    1616 |         iowrite16(cpu_to_vringh16(vrh, val), p);
         |         ^~~~~~~~~
   drivers/vhost/vringh.c: In function 'copydesc_iomem':
>> drivers/vhost/vringh.c:1623:9: error: implicit declaration of function 'memcpy_fromio'; did you mean 'memcpy_from_bvec'? [-Werror=implicit-function-declaration]
    1623 |         memcpy_fromio(dst, src, len);
         |         ^~~~~~~~~~~~~
         |         memcpy_from_bvec
   drivers/vhost/vringh.c: In function 'putused_iomem':
>> drivers/vhost/vringh.c:1630:9: error: implicit declaration of function 'memcpy_toio' [-Werror=implicit-function-declaration]
    1630 |         memcpy_toio(dst, src, num * sizeof(*dst));
         |         ^~~~~~~~~~~
   drivers/vhost/vringh.c: At top level:
   drivers/vhost/vringh.c:1661:5: warning: no previous prototype for 'vringh_init_iomem' [-Wmissing-prototypes]
    1661 | int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
         |     ^~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1683:5: warning: no previous prototype for 'vringh_getdesc_iomem' [-Wmissing-prototypes]
    1683 | int vringh_getdesc_iomem(struct vringh *vrh, struct vringh_kiov *riov,
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1714:9: warning: no previous prototype for 'vringh_iov_pull_iomem' [-Wmissing-prototypes]
    1714 | ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1729:9: warning: no previous prototype for 'vringh_iov_push_iomem' [-Wmissing-prototypes]
    1729 | ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1744:6: warning: no previous prototype for 'vringh_abandon_iomem' [-Wmissing-prototypes]
    1744 | void vringh_abandon_iomem(struct vringh *vrh, unsigned int num)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1759:5: warning: no previous prototype for 'vringh_complete_iomem' [-Wmissing-prototypes]
    1759 | int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len)
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1777:6: warning: no previous prototype for 'vringh_notify_enable_iomem' [-Wmissing-prototypes]
    1777 | bool vringh_notify_enable_iomem(struct vringh *vrh)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1790:6: warning: no previous prototype for 'vringh_notify_disable_iomem' [-Wmissing-prototypes]
    1790 | void vringh_notify_disable_iomem(struct vringh *vrh)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vringh.c:1802:5: warning: no previous prototype for 'vringh_need_notify_iomem' [-Wmissing-prototypes]
    1802 | int vringh_need_notify_iomem(struct vringh *vrh)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ioread16 +1610 drivers/vhost/vringh.c

  1606	
  1607	static inline int getu16_iomem(const struct vringh *vrh, u16 *val,
  1608				       const __virtio16 *p)
  1609	{
> 1610		*val = vringh16_to_cpu(vrh, ioread16(p));
  1611		return 0;
  1612	}
  1613	
  1614	static inline int putu16_iomem(const struct vringh *vrh, __virtio16 *p, u16 val)
  1615	{
> 1616		iowrite16(cpu_to_vringh16(vrh, val), p);
  1617		return 0;
  1618	}
  1619	
  1620	static inline int copydesc_iomem(const struct vringh *vrh, void *dst,
  1621					 const void *src, size_t len)
  1622	{
> 1623		memcpy_fromio(dst, src, len);
  1624		return 0;
  1625	}
  1626	
  1627	static int putused_iomem(const struct vringh *vrh, struct vring_used_elem *dst,
  1628				 const struct vring_used_elem *src, unsigned int num)
  1629	{
> 1630		memcpy_toio(dst, src, num * sizeof(*dst));
  1631		return 0;
  1632	}
  1633	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF308C433F5
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 20:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FF2A4190E;
	Tue, 31 May 2022 20:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3Wee7aVOb-f; Tue, 31 May 2022 20:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90A4C4190B;
	Tue, 31 May 2022 20:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1B1C0039;
	Tue, 31 May 2022 20:56:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB97AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3B7640292
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0kUuo3VdTL4E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72EED4014B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654030590; x=1685566590;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=KmOBMBNjMDvpHex0XEgSTh2uGSxfl8GV13MikE3newM=;
 b=l4xNtGATDWveQWbVNdfqfaLFGdO1jrsWT4AdmRkjEg0ZusXMx/JG9Ifb
 0/+5kZYGba6ZCen28ikoomBEnu6CXp1dRsibFpRmZnCMNQYYVNUDYPBK5
 2Wh26LKdkPaow/LJXZV6XtNEb1gg5wOn5yFU21r9B6UbNX8v4DUcjuAkx
 OC1mZghvkaY+FFPx6TZK+Bfvc2UQ2jp6XbeKIUY8/laJcyBhxJPQItLCd
 wzkqZzXtqWi81eBy6iDcn83wRHy82u2lBYmR0raq8eVb7YN+aTCkINLRB
 MdxvGEs6nSRl8L36IqNP2upjWQf5qTkcLo61YJYslF/2NdODAjxBllEE4 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300733467"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="300733467"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 13:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="706748538"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 31 May 2022 13:56:26 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nw8uf-00034W-Ih;
 Tue, 31 May 2022 20:56:25 +0000
Date: Wed, 1 Jun 2022 04:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>
Subject: [mst-vhost:vhost 62/65] drivers/virtio/virtio_ring.c:1783:9: error:
 use of undeclared identifier 'vq'
Message-ID: <202206010444.EGBXgPMJ-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 llvm@lists.linux.dev, virtualization@lists.linux-foundation.org
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
head:   5e83df49b4993a11b01399f6ce402f775940f965
commit: a50f09346a341984d34ff41f03dbd14dea6f20fe [62/65] virtio_ring: remove unused variable in virtqueue_add()
config: mips-randconfig-c004-20220531 (https://download.01.org/0day-ci/archive/20220601/202206010444.EGBXgPMJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=a50f09346a341984d34ff41f03dbd14dea6f20fe
        git remote add mst-vhost https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
        git fetch --no-tags mst-vhost vhost
        git checkout a50f09346a341984d34ff41f03dbd14dea6f20fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_ring.c:1783:9: error: use of undeclared identifier 'vq'
           return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
                  ^
   1 error generated.


vim +/vq +1783 drivers/virtio/virtio_ring.c

1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1768  
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1769  
e6f633e5beab65 Tiwei Bie 2018-11-21  1770  /*
e6f633e5beab65 Tiwei Bie 2018-11-21  1771   * Generic functions and exported symbols.
e6f633e5beab65 Tiwei Bie 2018-11-21  1772   */
e6f633e5beab65 Tiwei Bie 2018-11-21  1773  
e6f633e5beab65 Tiwei Bie 2018-11-21  1774  static inline int virtqueue_add(struct virtqueue *_vq,
e6f633e5beab65 Tiwei Bie 2018-11-21  1775  				struct scatterlist *sgs[],
e6f633e5beab65 Tiwei Bie 2018-11-21  1776  				unsigned int total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1777  				unsigned int out_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1778  				unsigned int in_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1779  				void *data,
e6f633e5beab65 Tiwei Bie 2018-11-21  1780  				void *ctx,
e6f633e5beab65 Tiwei Bie 2018-11-21  1781  				gfp_t gfp)
e6f633e5beab65 Tiwei Bie 2018-11-21  1782  {
1ce9e6055fa0a9 Tiwei Bie 2018-11-21 @1783  	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1784  					out_sgs, in_sgs, data, ctx, gfp) :
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1785  				 virtqueue_add_split(_vq, sgs, total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1786  					out_sgs, in_sgs, data, ctx, gfp);
e6f633e5beab65 Tiwei Bie 2018-11-21  1787  }
e6f633e5beab65 Tiwei Bie 2018-11-21  1788  

:::::: The code at line 1783 was first introduced by commit
:::::: 1ce9e6055fa0a9043405c5604cf19169ec5379ff virtio_ring: introduce packed ring support

:::::: TO: Tiwei Bie <tiwei.bie@intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

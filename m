Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC16CD6E74
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 14:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0AF12417FF;
	Wed, 11 Oct 2023 14:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AF12417FF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1dNhFwo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW6hSozLM1G1; Wed, 11 Oct 2023 14:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FAE8416DD;
	Wed, 11 Oct 2023 14:15:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FAE8416DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0004C0071;
	Wed, 11 Oct 2023 14:15:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46DDBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FB75821F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:15:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FB75821F3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=g1dNhFwo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_EGFRsSHE3r
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:15:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CECA782110
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CECA782110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697033743; x=1728569743;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DuNvaLmuSBpRQ/OE9jIM2FpK9gH/+55vqfRXvHb1aOE=;
 b=g1dNhFwoFIs7RHU5h3KQ44AATkF0kyJGjDd9GPYUt2OR6fuzOB5WKkLX
 dTPCFUnxbbQsuPklDSpv72fMf6Nqg90N3PHJ3k0g02/2qiGcuxRdNoBL2
 SQ9oc/P9a9/SjshxzAdCGAKfByuDXprxUXtjk/WtduvZ4+TTbKYWYJ9xo
 t9aTi5dx3wZh+iY+AsmyW79QS1j3i0rAX2Dyo2FUg0SzgrJCT5RzuawCX
 j1yAT7oST57bf6/FGl1uNhqnU/xQ80Omf0077GY2kPjSGpaXJ1cBz/Q4/
 Pj9aElb9PpS1XnWRCuu2L8l+GbpDCy9/9JbSATn2mts4LXXVfaamx2/gN g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364036255"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; d="scan'208";a="364036255"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 07:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="877693397"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; d="scan'208";a="877693397"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 07:15:37 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qqZzF-0002ID-2k;
 Wed, 11 Oct 2023 14:15:15 +0000
Date: Wed, 11 Oct 2023 22:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <202310112204.h03TUDpH-lkp@intel.com>
References: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
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

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc5 next-20231011]
[cannot apply to mst-vhost/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_set_dma_premapped-support-disable/20231011-180709
base:   linus/master
patch link:    https://lore.kernel.org/r/20231011092728.105904-2-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped support disable
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310112204.h03TUDpH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310112204.h03TUDpH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310112204.h03TUDpH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_ring.c:2788: warning: Function parameter or member 'mode' not described in 'virtqueue_set_dma_premapped'


vim +2788 drivers/virtio/virtio_ring.c

c790e8e1817f1a Xuan Zhuo 2022-08-01  2765  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2766  /**
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2767   * virtqueue_set_dma_premapped - set the vring premapped mode
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2768   * @_vq: the struct virtqueue we're talking about.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2769   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2770   * Enable the premapped mode of the vq.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2771   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2772   * The vring in premapped mode does not do dma internally, so the driver must
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2773   * do dma mapping in advance. The driver must pass the dma_address through
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2774   * dma_address of scatterlist. When the driver got a used buffer from
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2775   * the vring, it has to unmap the dma address.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2776   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2777   * This function must be called immediately after creating the vq, or after vq
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2778   * reset, and before adding any buffers to it.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2779   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2780   * Caller must ensure we don't call this with other virtqueue operations
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2781   * at the same time (except where noted).
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2782   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2783   * Returns zero or a negative error.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2784   * 0: success.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2785   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2786   */
f8d1a236ad114f Xuan Zhuo 2023-10-11  2787  int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
8daafe9ebbd21a Xuan Zhuo 2023-08-10 @2788  {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2789  	struct vring_virtqueue *vq = to_vvq(_vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2790  	u32 num;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2791  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2792  	START_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2793  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2794  	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2795  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2796  	if (num != vq->vq.num_free) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2797  		END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2798  		return -EINVAL;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2799  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2800  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2801  	if (!vq->use_dma_api) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2802  		END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2803  		return -EINVAL;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2804  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2805  
f8d1a236ad114f Xuan Zhuo 2023-10-11  2806  	if (mode) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2807  		vq->premapped = true;
b319940f83c21b Xuan Zhuo 2023-08-10  2808  		vq->do_unmap = false;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2809  	} else {
f8d1a236ad114f Xuan Zhuo 2023-10-11  2810  		vq->premapped = false;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2811  		vq->do_unmap = vq->use_dma_api;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2812  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2813  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2814  	END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2815  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2816  	return 0;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2817  }
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2818  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2819  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

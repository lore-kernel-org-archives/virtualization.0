Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320CDC05027
	for <virtualization@archiver.kernel.org>; Sun, 12 Feb 2023 07:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E2F760E31;
	Sun, 12 Feb 2023 07:56:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E2F760E31
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdLUxsZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7LBl5tCm2US; Sun, 12 Feb 2023 07:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80BAA60E24;
	Sun, 12 Feb 2023 07:56:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80BAA60E24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1D8C0032;
	Sun, 12 Feb 2023 07:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7E04C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Feb 2023 07:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F782415E4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Feb 2023 07:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F782415E4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UdLUxsZq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGWsu0_Fjcgh
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Feb 2023 07:56:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4009409B2
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4009409B2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Feb 2023 07:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676188607; x=1707724607;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1z59c0A+4cjBAtzlll8QbX3Ys90B50L6QvIxHeJZpA8=;
 b=UdLUxsZq7DKLW4W8ixkc464ouEaU7J8h5CsoDKSjIlOJUb1Wt5mj3Z8k
 z1ujszkaGpvnW7pex4kC08pL3ZBG4yBQzRuXKDko+u5Zr4GLtdLYOZvOx
 OMREy9NP9cPL+4r5qCaN1O2XjOkV0a4dCBJ6VNlf76t1iInMRer0MPJ3Q
 qeT3TtaeGXXSxpH8N+5jrpHNmWu4fNZrftPax0M3SOgtWVM1DR/u87k45
 qqAF8LSm56ajg6hHsLM8sHvrO2IwI9WYzkMJKbJ3S0M17M8vfWb5Fb5xu
 Q5wTSq05T4bfYKCqVhruoOg1WPKrH5BM3trTuphNENzRZOgxqVm01epES A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="332004010"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; d="scan'208";a="332004010"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2023 23:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="842443833"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; d="scan'208";a="842443833"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 11 Feb 2023 23:56:40 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pR7Dz-00078b-2b;
 Sun, 12 Feb 2023 07:56:39 +0000
Date: Sun, 12 Feb 2023 15:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 22/33] virtio_net: xsk: introduce xsk disable
Message-ID: <202302121555.BtDmbIKI-lkp@intel.com>
References: <20230202110058.130695-23-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230202110058.130695-23-xuanzhuo@linux.alibaba.com>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on next-20230210]
[cannot apply to net/master mst-vhost/linux-next linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_add-support-premapped/20230202-190707
patch link:    https://lore.kernel.org/r/20230202110058.130695-23-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH 22/33] virtio_net: xsk: introduce xsk disable
config: nios2-randconfig-s033-20230202 (https://download.01.org/0day-ci/archive/20230212/202302121555.BtDmbIKI-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3c385ac45368b585d2ca1a45263b4a0536cef0dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xuan-Zhuo/virtio_ring-virtqueue_add-support-premapped/20230202-190707
        git checkout 3c385ac45368b585d2ca1a45263b4a0536cef0dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/net/virtio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302121555.BtDmbIKI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/virtio/xsk.c:133:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct xsk_buff_pool *pool @@     got struct xsk_buff_pool [noderef] __rcu *pool @@
   drivers/net/virtio/xsk.c:133:35: sparse:     expected struct xsk_buff_pool *pool
   drivers/net/virtio/xsk.c:133:35: sparse:     got struct xsk_buff_pool [noderef] __rcu *pool

vim +133 drivers/net/virtio/xsk.c

   116	
   117	static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
   118	{
   119		struct virtnet_info *vi = netdev_priv(dev);
   120		struct receive_queue *rq;
   121		struct send_queue *sq;
   122		int err1, err2;
   123	
   124		if (qid >= vi->curr_queue_pairs)
   125			return -EINVAL;
   126	
   127		sq = &vi->sq[qid];
   128		rq = &vi->rq[qid];
   129	
   130		virtio_dma_unmap(&vi->vdev->dev, sq->xsk.hdr_dma_address, vi->hdr_len,
   131				 DMA_TO_DEVICE);
   132	
 > 133		xsk_pool_dma_unmap(sq->xsk.pool, 0);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

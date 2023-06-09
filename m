Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A6DC7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 00:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48D1A40528;
	Fri,  9 Jun 2023 00:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48D1A40528
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WkXIrwgO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lA3lk2ONnJoG; Fri,  9 Jun 2023 00:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8980D401C2;
	Fri,  9 Jun 2023 00:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8980D401C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7C7C0037;
	Fri,  9 Jun 2023 00:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 491F7C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE590404C2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE590404C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5w9jMq3PRGg3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:34:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9FE2401C2
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9FE2401C2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686270896; x=1717806896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NPBgbxkyvwwXlvp1wqABln5v+5rzW4e4NuoGP9H/glY=;
 b=WkXIrwgO3pfqCVgyXLrqCbLb/4J6TltcKzxMg7OiW5sAWaeZyI3rt5PT
 v1ykUY6DJu0zDqRwuumZ496kvDXNn3TS91GhfZocAQYIfBDT+WH7Nlv50
 lgBTdGqUoGF39HMTXRsmGxhlxrqNjoVvBnEwbEpTQSsS4sfKPyZqK9BEx
 pfV70GzadulIThsSPzLohuhWienHE4OhH5PfViJZ7XkzXRyxgy4S8EP6m
 ZH1x+IdBrujBhMgQLU9nCXUdg0+8Yy6F/a6nD399N8SBBEkrD/SLzpAE+
 RQgDM7suadY6UHhy4ENMZ5/sQTsVOJNeMSs3pBK/INTfv6IfTjr/Wu3L0 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385825515"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="385825515"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 17:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687549137"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="687549137"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 08 Jun 2023 17:34:52 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q7Q5b-0008OS-1b;
 Fri, 09 Jun 2023 00:34:51 +0000
Date: Fri, 9 Jun 2023 08:34:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio-blk: support completion batching for the
 IRQ path"
Message-ID: <202306090808.d1u5ZgZ9-lkp@intel.com>
References: <9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 llvm@lists.linux.dev, "Roberts, Martin" <martin.roberts@intel.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, oe-kbuild-all@lists.linux.dev,
 Paolo Bonzini <pbonzini@redhat.com>, Suwan Kim <suwan.kim027@gmail.com>
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

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-S-Tsirkin/Revert-virtio-blk-support-completion-batching-for-the-IRQ-path/20230609-054840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst%40redhat.com
patch subject: [PATCH] Revert "virtio-blk: support completion batching for the IRQ path"
config: s390-randconfig-r014-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090808.d1u5ZgZ9-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch axboe-block for-next
        git checkout axboe-block/for-next
        b4 shazam https://lore.kernel.org/r/9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/block/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090808.d1u5ZgZ9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/block/virtio_blk.c:10:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/block/virtio_blk.c:10:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/block/virtio_blk.c:10:
   In file included from include/linux/virtio.h:7:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/block/virtio_blk.c:1283:43: error: no member named 'status' in 'struct virtblk_req'
    1283 |                     !blk_mq_add_to_batch(req, iob, vbr->status,
         |                                                    ~~~  ^
   12 warnings and 1 error generated.


vim +1283 drivers/block/virtio_blk.c

  1266	
  1267	static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
  1268	{
  1269		struct virtio_blk *vblk = hctx->queue->queuedata;
  1270		struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
  1271		struct virtblk_req *vbr;
  1272		unsigned long flags;
  1273		unsigned int len;
  1274		int found = 0;
  1275	
  1276		spin_lock_irqsave(&vq->lock, flags);
  1277	
  1278		while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
  1279			struct request *req = blk_mq_rq_from_pdu(vbr);
  1280	
  1281			found++;
  1282			if (!blk_mq_complete_request_remote(req) &&
> 1283			    !blk_mq_add_to_batch(req, iob, vbr->status,
  1284							virtblk_complete_batch))
  1285				virtblk_request_done(req);
  1286		}
  1287	
  1288		if (found)
  1289			blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
  1290	
  1291		spin_unlock_irqrestore(&vq->lock, flags);
  1292	
  1293		return found;
  1294	}
  1295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

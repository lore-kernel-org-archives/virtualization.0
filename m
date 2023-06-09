Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3154C7EE37
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 00:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 452B142428;
	Fri,  9 Jun 2023 00:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 452B142428
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bjKCgSXW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXzIPnlIfnSf; Fri,  9 Jun 2023 00:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3EF634241C;
	Fri,  9 Jun 2023 00:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EF634241C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB33C0037;
	Fri,  9 Jun 2023 00:45:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC6FC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E799B83EB3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E799B83EB3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bjKCgSXW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzDtCfA9kCHL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:45:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD61683EAB
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD61683EAB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686271556; x=1717807556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WsGjDatcxmUQcNFhMQ4/rejB7apToZccSWEeLrCxUkw=;
 b=bjKCgSXWHprMxdDHc1TNaHDUDKjtT32Xi1OE6AjrtR8mfc2oXsaUhq0X
 +B2lNdLwGh1vv7jDuO7smx5Qzlxyhz8XOk2YTzuWY9Vk1GDS74IYfER/J
 K/WrzwDeZVbBwR7/Zcps0LxEcsEyHIwMHlVSqoU+CpAwWMnB61sXtGxbt
 IC7VkzfDClKD+s31HqS5TH/fXA6i0JX1K2c2ylbqinfYUPtKZE3MXWv/a
 WTdnkEoIamyJzb0HYyVlKm2YfMkjkBpCcYL88HkJOd9b5gFtqZUMYO4wg
 xEyZp7t/5UnXDZH0nTTTTMk3mLMi5yVLb+R7RHlEBfSDZExArH3oORcaE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337833132"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="337833132"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 17:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660574508"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="660574508"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 17:45:53 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q7QGG-0008P2-11;
 Fri, 09 Jun 2023 00:45:52 +0000
Date: Fri, 9 Jun 2023 08:45:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio-blk: support completion batching for the
 IRQ path"
Message-ID: <202306090826.C1fZmdMe-lkp@intel.com>
References: <9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Roberts, Martin" <martin.roberts@intel.com>,
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230609/202306090826.C1fZmdMe-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch axboe-block for-next
        git checkout axboe-block/for-next
        b4 shazam https://lore.kernel.org/r/9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/virtio_blk.c: In function 'virtblk_poll':
>> drivers/block/virtio_blk.c:1283:55: error: 'struct virtblk_req' has no member named 'status'
    1283 |                     !blk_mq_add_to_batch(req, iob, vbr->status,
         |                                                       ^~


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

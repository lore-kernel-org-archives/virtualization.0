Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B72BC0015E
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 10:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E65D881FDA;
	Wed, 19 Jul 2023 10:41:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E65D881FDA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LjrQxwiE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTdmV_HaFIJH; Wed, 19 Jul 2023 10:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 515CB81FE8;
	Wed, 19 Jul 2023 10:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 515CB81FE8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F89C0072;
	Wed, 19 Jul 2023 10:41:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE1AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 10:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C675981FE8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 10:41:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C675981FE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHImyFyhibZr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 10:41:02 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 19 Jul 2023 10:41:02 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8865981FDA
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8865981FDA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689763261; x=1721299261;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3SNLOoqbWWFCQ8VFNEXapHXEAc1Q3bC2YRtCrjpFgLw=;
 b=LjrQxwiEnk7yYAdhJlMysyM/9kj46w6okRvDctqBVcdnB0nl4IyUK3KX
 1jItG2ovXsXfnYbYmRH7I0UXkAV9ohwdhL5TRScGw7mVpg2saPHtJGvaX
 NCzQtCd+kkZMdbqDsflLgKYSci+Kd+tVLy+nzW+SIVCkqhAcWrbPtq2qF
 KNUI+Rh7rHuD/ILUJ8y4sp7e4S+bUtV5a1iOa/8uIqPv0lccaDnpPEBHv
 CN7yaE3slpno5dCyVHOAgXCxpQqPveivV+xDvFP6UYZDNOjFXBgzOGTDd
 p5SkJu90A9rtWHBieTLc91nVCegglVbMhTg381sNsqNHD+wR8nNwO5dOr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397282775"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; d="scan'208";a="397282775"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2023 03:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674247426"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; d="scan'208";a="674247426"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 03:33:51 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qM4VC-0004gD-1C;
 Wed, 19 Jul 2023 10:33:50 +0000
Date: Wed, 19 Jul 2023 18:33:05 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost v12 10/10] virtio_net: merge dma operations when
 filling mergeable buffers
Message-ID: <202307191819.0tatknWa-lkp@intel.com>
References: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Eric Dumazet <edumazet@google.com>, oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
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

[auto build test WARNING on v6.4]
[cannot apply to mst-vhost/linux-next linus/master v6.5-rc2 v6.5-rc1 next-20230719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-check-use_dma_api-before-unmap-desc-for-indirect/20230719-121424
base:   v6.4
patch link:    https://lore.kernel.org/r/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
config: i386-randconfig-i006-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191819.0tatknWa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_rq_init_one_sg':
>> drivers/net/virtio_net.c:624:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     624 |                 rq->sg[0].dma_address = (dma_addr_t)addr;
         |                                         ^
   drivers/net/virtio_net.c: In function 'virtnet_rq_alloc':
>> drivers/net/virtio_net.c:682:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     682 |                 *sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
         |                            ^


vim +624 drivers/net/virtio_net.c

   619	
   620	static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *addr, u32 len)
   621	{
   622		if (rq->do_dma) {
   623			sg_init_table(rq->sg, 1);
 > 624			rq->sg[0].dma_address = (dma_addr_t)addr;
   625			rq->sg[0].length = len;
   626		} else {
   627			sg_init_one(rq->sg, addr, len);
   628		}
   629	}
   630	
   631	static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size,
   632				      void **sg_addr, gfp_t gfp)
   633	{
   634		struct page_frag *alloc_frag = &rq->alloc_frag;
   635		struct virtnet_rq_dma *dma;
   636		struct device *dev;
   637		void *buf, *head;
   638		dma_addr_t addr;
   639	
   640		if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
   641			return NULL;
   642	
   643		head = (char *)page_address(alloc_frag->page);
   644	
   645		if (rq->do_dma) {
   646			dma = head;
   647	
   648			/* new pages */
   649			if (!alloc_frag->offset) {
   650				if (rq->last_dma) {
   651					/* Now, the new page is allocated, the last dma
   652					 * will not be used. So the dma can be unmapped
   653					 * if the ref is 0.
   654					 */
   655					virtnet_rq_unmap(rq, rq->last_dma, 0);
   656					rq->last_dma = NULL;
   657				}
   658	
   659				dev = virtqueue_dma_dev(rq->vq);
   660	
   661				dma->len = alloc_frag->size - sizeof(*dma);
   662	
   663				addr = dma_map_single_attrs(dev, dma + 1, dma->len, DMA_FROM_DEVICE, 0);
   664				if (addr == DMA_MAPPING_ERROR)
   665					return NULL;
   666	
   667				dma->addr = addr;
   668				dma->need_sync = dma_need_sync(dev, addr);
   669	
   670				/* Add a reference to dma to prevent the entire dma from
   671				 * being released during error handling. This reference
   672				 * will be freed after the pages are no longer used.
   673				 */
   674				get_page(alloc_frag->page);
   675				dma->ref = 1;
   676				alloc_frag->offset = sizeof(*dma);
   677	
   678				rq->last_dma = dma;
   679			}
   680	
   681			++dma->ref;
 > 682			*sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
   683		} else {
   684			*sg_addr = head + alloc_frag->offset;
   685		}
   686	
   687		buf = head + alloc_frag->offset;
   688	
   689		get_page(alloc_frag->page);
   690		alloc_frag->offset += size;
   691	
   692		return buf;
   693	}
   694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

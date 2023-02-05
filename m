Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1082C636CD
	for <virtualization@archiver.kernel.org>; Sun,  5 Feb 2023 22:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42D25401B2;
	Sun,  5 Feb 2023 22:04:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42D25401B2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YwD+qcuQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKCWdyjE_TTg; Sun,  5 Feb 2023 22:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E2B6400BB;
	Sun,  5 Feb 2023 22:04:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E2B6400BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3686EC0033;
	Sun,  5 Feb 2023 22:04:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D475EC002B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 22:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A952401A3
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 22:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A952401A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBx3seoJOplZ
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 22:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D636400BB
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D636400BB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675634683; x=1707170683;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xaVHZI6dtIw3nflt7wyiHWuKYGBbFllA+XtM5p/ijmY=;
 b=YwD+qcuQ2axWrydnRJ2kkJUyDWQrzCLft+nduLt0qEN1yuAS0Tg0aBAu
 eSbt5hApUeVtG1l2nWUZvnzbbeTPm5Vsy4EqXbWlHz/VnO/p9dQiIJPUs
 24liBLzWMOg6Rw0Qg47l87NSf79KoAvPLhX/6QG3h74R8QWdXJeYuDXz5
 EIAYsfcDXI8DukJxSCbUKku2CTI0Hbl/Tp1csSfOnO+3xXQyKJWHntwOn
 90qaj86u9EGNTQknTS7xqN+Zye7H2NJVzNTZDth9tcEOSwSbnay9ELYmq
 t+vdWXfvubthDk9T0P/39aXkUi+1zVHrFsIKNctoL2zzqcfKalayZGkeX g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="326783291"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; d="scan'208";a="326783291"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2023 14:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659669395"
X-IronPort-AV: E=Sophos;i="5.97,275,1669104000"; d="scan'208";a="659669395"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 05 Feb 2023 14:04:36 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pOn7j-0002FE-2U;
 Sun, 05 Feb 2023 22:04:35 +0000
Date: Mon, 6 Feb 2023 06:04:34 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 10/33] xsk: support virtio DMA map
Message-ID: <202302060542.IxBGSiKh-lkp@intel.com>
References: <20230202110058.130695-11-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230202110058.130695-11-xuanzhuo@linux.alibaba.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]
[also build test ERROR on mst-vhost/linux-next linus/master v6.2-rc6 next-20230203]
[cannot apply to net/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_add-support-premapped/20230202-190707
patch link:    https://lore.kernel.org/r/20230202110058.130695-11-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH 10/33] xsk: support virtio DMA map
config: i386-debian-10.3-kvm (https://download.01.org/0day-ci/archive/20230206/202302060542.IxBGSiKh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/370aefebcea755f7c4c14e16f8dcb5540769fd26
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xuan-Zhuo/virtio_ring-virtqueue_add-support-premapped/20230202-190707
        git checkout 370aefebcea755f7c4c14e16f8dcb5540769fd26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/xdp/xsk_buff_pool.o: in function `xp_alloc':
>> net/xdp/xsk_buff_pool.c:575: undefined reference to `is_virtio_device'
>> ld: net/xdp/xsk_buff_pool.c:576: undefined reference to `virtio_dma_sync_signle_range_for_device'
   ld: net/xdp/xsk_buff_pool.o: in function `__xp_dma_unmap':
   net/xdp/xsk_buff_pool.c:338: undefined reference to `is_virtio_device'
>> ld: net/xdp/xsk_buff_pool.c:339: undefined reference to `virtio_dma_unmap'
   ld: net/xdp/xsk_buff_pool.o: in function `xp_dma_map':
   net/xdp/xsk_buff_pool.c:443: undefined reference to `is_virtio_device'
   ld: net/xdp/xsk_buff_pool.c:443: undefined reference to `virtio_dma_sync_signle_range_for_device'
>> ld: net/xdp/xsk_buff_pool.c:443: undefined reference to `virtio_dma_sync_signle_range_for_cpu'
>> ld: net/xdp/xsk_buff_pool.c:458: undefined reference to `virtio_dma_map_page'
>> ld: net/xdp/xsk_buff_pool.c:461: undefined reference to `virtio_dma_mapping_error'
>> ld: net/xdp/xsk_buff_pool.c:464: undefined reference to `virtio_dma_need_sync'
>> ld: net/xdp/xsk_buff_pool.c:457: undefined reference to `is_virtio_device'


vim +575 net/xdp/xsk_buff_pool.c

   424	
   425	int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
   426		       unsigned long attrs, struct page **pages, u32 nr_pages)
   427	{
   428		struct xsk_dma_map *dma_map;
   429		dma_addr_t dma;
   430		int err;
   431		u32 i;
   432	
   433		dma_map = xp_find_dma_map(pool);
   434		if (dma_map) {
   435			err = xp_init_dma_info(pool, dma_map);
   436			if (err)
   437				return err;
   438	
   439			refcount_inc(&dma_map->users);
   440			return 0;
   441		}
   442	
 > 443		if (is_virtio_device(dev)) {
   444			pool->dma_sync_for_cpu = virtio_dma_sync_signle_range_for_cpu;
   445			pool->dma_sync_for_device = virtio_dma_sync_signle_range_for_device;
   446	
   447		} else {
   448			pool->dma_sync_for_cpu = dma_sync_for_cpu;
   449			pool->dma_sync_for_device = dma_sync_for_device;
   450		}
   451	
   452		dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
   453		if (!dma_map)
   454			return -ENOMEM;
   455	
   456		for (i = 0; i < dma_map->dma_pages_cnt; i++) {
 > 457			if (is_virtio_device(dev)) {
 > 458				dma = virtio_dma_map_page(dev, pages[i], 0, PAGE_SIZE,
   459							  DMA_BIDIRECTIONAL);
   460	
 > 461				if (virtio_dma_mapping_error(dev, dma))
   462					goto err;
   463	
 > 464				if (virtio_dma_need_sync(dev, dma))
   465					dma_map->dma_need_sync = true;
   466	
   467			} else {
   468				dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
   469							 DMA_BIDIRECTIONAL, attrs);
   470	
   471				if (dma_mapping_error(dev, dma))
   472					goto err;
   473	
   474				if (dma_need_sync(dev, dma))
   475					dma_map->dma_need_sync = true;
   476			}
   477			dma_map->dma_pages[i] = dma;
   478		}
   479	
   480		if (pool->unaligned)
   481			xp_check_dma_contiguity(dma_map);
   482	
   483		err = xp_init_dma_info(pool, dma_map);
   484		if (err) {
   485			__xp_dma_unmap(dma_map, attrs);
   486			return err;
   487		}
   488	
   489		return 0;
   490	err:
   491		__xp_dma_unmap(dma_map, attrs);
   492		return -ENOMEM;
   493	}
   494	EXPORT_SYMBOL(xp_dma_map);
   495	
   496	static bool xp_addr_crosses_non_contig_pg(struct xsk_buff_pool *pool,
   497						  u64 addr)
   498	{
   499		return xp_desc_crosses_non_contig_pg(pool, addr, pool->chunk_size);
   500	}
   501	
   502	static bool xp_check_unaligned(struct xsk_buff_pool *pool, u64 *addr)
   503	{
   504		*addr = xp_unaligned_extract_addr(*addr);
   505		if (*addr >= pool->addrs_cnt ||
   506		    *addr + pool->chunk_size > pool->addrs_cnt ||
   507		    xp_addr_crosses_non_contig_pg(pool, *addr))
   508			return false;
   509		return true;
   510	}
   511	
   512	static bool xp_check_aligned(struct xsk_buff_pool *pool, u64 *addr)
   513	{
   514		*addr = xp_aligned_extract_addr(pool, *addr);
   515		return *addr < pool->addrs_cnt;
   516	}
   517	
   518	static struct xdp_buff_xsk *__xp_alloc(struct xsk_buff_pool *pool)
   519	{
   520		struct xdp_buff_xsk *xskb;
   521		u64 addr;
   522		bool ok;
   523	
   524		if (pool->free_heads_cnt == 0)
   525			return NULL;
   526	
   527		for (;;) {
   528			if (!xskq_cons_peek_addr_unchecked(pool->fq, &addr)) {
   529				pool->fq->queue_empty_descs++;
   530				return NULL;
   531			}
   532	
   533			ok = pool->unaligned ? xp_check_unaligned(pool, &addr) :
   534			     xp_check_aligned(pool, &addr);
   535			if (!ok) {
   536				pool->fq->invalid_descs++;
   537				xskq_cons_release(pool->fq);
   538				continue;
   539			}
   540			break;
   541		}
   542	
   543		if (pool->unaligned) {
   544			xskb = pool->free_heads[--pool->free_heads_cnt];
   545			xp_init_xskb_addr(xskb, pool, addr);
   546			if (pool->dma_pages_cnt)
   547				xp_init_xskb_dma(xskb, pool, pool->dma_pages, addr);
   548		} else {
   549			xskb = &pool->heads[xp_aligned_extract_idx(pool, addr)];
   550		}
   551	
   552		xskq_cons_release(pool->fq);
   553		return xskb;
   554	}
   555	
   556	struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
   557	{
   558		struct xdp_buff_xsk *xskb;
   559	
   560		if (!pool->free_list_cnt) {
   561			xskb = __xp_alloc(pool);
   562			if (!xskb)
   563				return NULL;
   564		} else {
   565			pool->free_list_cnt--;
   566			xskb = list_first_entry(&pool->free_list, struct xdp_buff_xsk,
   567						free_list_node);
   568			list_del_init(&xskb->free_list_node);
   569		}
   570	
   571		xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
   572		xskb->xdp.data_meta = xskb->xdp.data;
   573	
   574		if (pool->dma_need_sync) {
 > 575			if (is_virtio_device(pool->dev))
 > 576				virtio_dma_sync_signle_range_for_device(pool->dev, xskb->dma, 0,
   577									pool->frame_len,
   578									DMA_BIDIRECTIONAL);
   579			else
   580				dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
   581								 pool->frame_len,
   582								 DMA_BIDIRECTIONAL);
   583		}
   584		return &xskb->xdp;
   585	}
   586	EXPORT_SYMBOL(xp_alloc);
   587	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

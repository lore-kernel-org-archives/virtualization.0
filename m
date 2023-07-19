Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CE6C001B0
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 11:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6D3B8141E;
	Wed, 19 Jul 2023 11:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6D3B8141E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FesK7vsj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ze1dX1-17qh7; Wed, 19 Jul 2023 11:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21A57818E6;
	Wed, 19 Jul 2023 11:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21A57818E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC6BBC0072;
	Wed, 19 Jul 2023 11:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1742C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 11:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A98914154E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 11:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A98914154E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FesK7vsj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cJPh6BIkeLU8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 11:06:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 847244154D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 11:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 847244154D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689764764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6G25Wpf6urdNog1RrCIh1jSfsrggg+8NTa2ueC8cR3I=;
 b=FesK7vsjFMYMgyGUbIZ+poXZNJDgbdImixj0RSmgitx0Te0ps4xVwbx3d8CL3Y4EejDoKp
 QIRYLnqXBx7w8cDNyjegFmoGh2HKbUkhb74Q9iULzkbLqlpWbDkQtAkJ7wnBQCvzWaY0o5
 ojqnK6ImZV3yQtFikvyu6klaQkFF02M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-v4kzZv0ZPBiT1WpQ1FemYw-1; Wed, 19 Jul 2023 07:06:02 -0400
X-MC-Unique: v4kzZv0ZPBiT1WpQ1FemYw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fccf211494so5491889e87.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 04:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689764761; x=1692356761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6G25Wpf6urdNog1RrCIh1jSfsrggg+8NTa2ueC8cR3I=;
 b=T6UilYR9r989kYf0+Ou/jPMImc4/kxVf/loxjDjnJkt4zilVXnqUizYCC4i97oLSwh
 uFgKVFZZRPXJG9R+3UT+PMusnKaNEIyxPA/dor7ZV47UxvWCrD57D0ILhipW7icNbfCu
 AaxeCjqw6KEk0dkVhD21pNLRzF4Qvt7Pup6vPpYDRPmRwVZ4WdauDPA0AREXpP3N5Xjx
 8Z583ESQYjd9rXeN2mC3StSKl8EHpvBW/ae8VgACoepNRoCJ/aaRfiHh9N9OwjssvAGT
 qjtj6nuD5p1fj/kRJO+hQ7SI3ucDPNqW0hjOLlcJLL/BrzC1Z7zlKgnYSmxBSIv/7enO
 pn1Q==
X-Gm-Message-State: ABy/qLY1asYgdXVbGme0+4wStu9XJ7eaFhpJddWym62RP0ORbbJzI1wH
 DU2oXUXK6zLKe0miUf80FHFfUplvpcgiWQaHpj9ltP/CjTHnWVmj4K3+dkfO2LiQaikrgJn5BLT
 +itD1CTOy2NrlAlGbJZ7i9QZrWEt3iP4utm5UuZHzCg==
X-Received: by 2002:a05:6512:2316:b0:4fd:d9dd:7a22 with SMTP id
 o22-20020a056512231600b004fdd9dd7a22mr96819lfu.26.1689764761270; 
 Wed, 19 Jul 2023 04:06:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVmVc0nOSbjtLvsVkw0Xfo9zLoMCLBrAktPo4kwD8j+ZtvK0aKteVH/Zyf6WXfLny5TxU5yw==
X-Received: by 2002:a05:6512:2316:b0:4fd:d9dd:7a22 with SMTP id
 o22-20020a056512231600b004fdd9dd7a22mr96797lfu.26.1689764760864; 
 Wed, 19 Jul 2023 04:06:00 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 s13-20020a7bc38d000000b003fbd0c50ba2sm1419609wmj.32.2023.07.19.04.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 04:06:00 -0700 (PDT)
Date: Wed, 19 Jul 2023 07:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH vhost v12 10/10] virtio_net: merge dma operations when
 filling mergeable buffers
Message-ID: <20230719070450-mutt-send-email-mst@kernel.org>
References: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
 <202307191819.0tatknWa-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202307191819.0tatknWa-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
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

On Wed, Jul 19, 2023 at 06:33:05PM +0800, kernel test robot wrote:
> Hi Xuan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.4]
> [cannot apply to mst-vhost/linux-next linus/master v6.5-rc2 v6.5-rc1 next-20230719]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-check-use_dma_api-before-unmap-desc-for-indirect/20230719-121424
> base:   v6.4
> patch link:    https://lore.kernel.org/r/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com
> patch subject: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
> config: i386-randconfig-i006-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307191819.0tatknWa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/virtio_net.c: In function 'virtnet_rq_init_one_sg':
> >> drivers/net/virtio_net.c:624:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      624 |                 rq->sg[0].dma_address = (dma_addr_t)addr;
>          |                                         ^
>    drivers/net/virtio_net.c: In function 'virtnet_rq_alloc':
> >> drivers/net/virtio_net.c:682:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      682 |                 *sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
>          |                            ^


yea these casts are pretty creepy. I think it's possible dma_addr_t won't fit in a pointer
or a pointer won't fit in dma_addr_t.

> 
> vim +624 drivers/net/virtio_net.c
> 
>    619	
>    620	static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *addr, u32 len)
>    621	{
>    622		if (rq->do_dma) {
>    623			sg_init_table(rq->sg, 1);
>  > 624			rq->sg[0].dma_address = (dma_addr_t)addr;
>    625			rq->sg[0].length = len;
>    626		} else {
>    627			sg_init_one(rq->sg, addr, len);
>    628		}
>    629	}
>    630	
>    631	static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size,
>    632				      void **sg_addr, gfp_t gfp)
>    633	{
>    634		struct page_frag *alloc_frag = &rq->alloc_frag;
>    635		struct virtnet_rq_dma *dma;
>    636		struct device *dev;
>    637		void *buf, *head;
>    638		dma_addr_t addr;
>    639	
>    640		if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
>    641			return NULL;
>    642	
>    643		head = (char *)page_address(alloc_frag->page);
>    644	
>    645		if (rq->do_dma) {
>    646			dma = head;
>    647	
>    648			/* new pages */
>    649			if (!alloc_frag->offset) {
>    650				if (rq->last_dma) {
>    651					/* Now, the new page is allocated, the last dma
>    652					 * will not be used. So the dma can be unmapped
>    653					 * if the ref is 0.
>    654					 */
>    655					virtnet_rq_unmap(rq, rq->last_dma, 0);
>    656					rq->last_dma = NULL;
>    657				}
>    658	
>    659				dev = virtqueue_dma_dev(rq->vq);
>    660	
>    661				dma->len = alloc_frag->size - sizeof(*dma);
>    662	
>    663				addr = dma_map_single_attrs(dev, dma + 1, dma->len, DMA_FROM_DEVICE, 0);
>    664				if (addr == DMA_MAPPING_ERROR)
>    665					return NULL;
>    666	
>    667				dma->addr = addr;
>    668				dma->need_sync = dma_need_sync(dev, addr);
>    669	
>    670				/* Add a reference to dma to prevent the entire dma from
>    671				 * being released during error handling. This reference
>    672				 * will be freed after the pages are no longer used.
>    673				 */
>    674				get_page(alloc_frag->page);
>    675				dma->ref = 1;
>    676				alloc_frag->offset = sizeof(*dma);
>    677	
>    678				rq->last_dma = dma;
>    679			}
>    680	
>    681			++dma->ref;
>  > 682			*sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
>    683		} else {
>    684			*sg_addr = head + alloc_frag->offset;
>    685		}
>    686	
>    687		buf = head + alloc_frag->offset;
>    688	
>    689		get_page(alloc_frag->page);
>    690		alloc_frag->offset += size;
>    691	
>    692		return buf;
>    693	}
>    694	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

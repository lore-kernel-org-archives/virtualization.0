Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB4CDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 10:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB3D3416FF;
	Fri, 13 Oct 2023 10:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB3D3416FF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MCFCbWu4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NU6JwP8mOdJi; Fri, 13 Oct 2023 10:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FDB14173C;
	Fri, 13 Oct 2023 10:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FDB14173C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41DB9C0071;
	Fri, 13 Oct 2023 10:14:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 588CCC0071
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CFF741FBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CFF741FBC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MCFCbWu4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUGds3YgJjxj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:14:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 583C941FB0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 10:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 583C941FB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697192067; x=1728728067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XFoqaJbduqLCyl9DPecY1ECvrkqVkONk2hKheDsUmwo=;
 b=MCFCbWu45d/+RukE9so9zf15noau1idvW5FM04luUdLusQXIKoQOPj2p
 PmJgFcvcLnwgvSVgpv3cNmJH/Mg3kQe1dmksujQ/Yf/kwtKYviDNtWKgQ
 ePNjpYfBWIbJkwnRukG+zaKLRZ2TZp48WrHE0+EXvbGFQR6TCWu626tOy
 sKPkbckUh9e3/MhC6sWxM99+Fgoofc1fg6gLRczhONbJ/jSQkmWRwNYB8
 7K6RlH1S2EnrPfX16Hw84mjhBJxjGeeNjFjmMLPjKeWe1OtXgWOZa2Iuc
 qW6eiOWgVTGPHgHVZggxj6nclkZfsrMpzzVIESuDukk7Xhp+HZKpKXCTl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416202067"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; d="scan'208";a="416202067"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 03:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754653480"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; d="scan'208";a="754653480"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 13 Oct 2023 03:14:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qrFBQ-0004cX-1O;
 Fri, 13 Oct 2023 10:14:16 +0000
Date: Fri, 13 Oct 2023 18:13:06 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 11/22] virtio_net: sq support premapped mode
Message-ID: <202310131711.QjbkIwe0-lkp@intel.com>
References: <20231011092728.105904-12-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-12-xuanzhuo@linux.alibaba.com>
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
[also build test WARNING on v6.6-rc5 next-20231013]
[cannot apply to mst-vhost/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_set_dma_premapped-support-disable/20231011-180709
base:   linus/master
patch link:    https://lore.kernel.org/r/20231011092728.105904-12-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 11/22] virtio_net: sq support premapped mode
config: parisc-randconfig-001-20231013 (https://download.01.org/0day-ci/archive/20231013/202310131711.QjbkIwe0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310131711.QjbkIwe0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310131711.QjbkIwe0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/virtio/main.c:25:
   drivers/net/virtio/virtio_net.h: In function 'virtnet_sq_unmap':
>> drivers/net/virtio/virtio_net.h:235:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     235 |         head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
         |                         ^
>> drivers/net/virtio/virtio_net.h:235:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     235 |         head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
         |                ^
   drivers/net/virtio/main.c: In function 'virtnet_sq_map_sg':
>> drivers/net/virtio/main.c:600:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                         ^
   drivers/net/virtio/main.c:600:38: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                                      ^
>> drivers/net/virtio/main.c:600:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                ^
   drivers/net/virtio/main.c: In function 'virtnet_find_vqs':
   drivers/net/virtio/main.c:3977:48: warning: '%d' directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                                ^~
   drivers/net/virtio/main.c:3977:41: note: directive argument in the range [-2147483641, 65534]
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                         ^~~~~~~~~~
   drivers/net/virtio/main.c:3977:17: note: 'sprintf' output between 8 and 18 bytes into a destination of size 16
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio/main.c:3978:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                                 ^~
   drivers/net/virtio/main.c:3978:41: note: directive argument in the range [-2147483641, 65534]
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                         ^~~~~~~~~~~
   drivers/net/virtio/main.c:3978:17: note: 'sprintf' output between 9 and 19 bytes into a destination of size 16
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +235 drivers/net/virtio/virtio_net.h

   230	
   231	static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
   232	{
   233		struct virtnet_sq_dma *next, *head;
   234	
 > 235		head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
   236	
   237		data = head->data;
   238	
   239		while (head) {
   240			virtqueue_dma_unmap_page_attrs(sq->vq, head->addr, head->len, DMA_TO_DEVICE, 0);
   241	
   242			next = head->next;
   243	
   244			head->next = sq->dmainfo.free;
   245			sq->dmainfo.free = head;
   246	
   247			head = next;
   248		}
   249	
   250		return data;
   251	}
   252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

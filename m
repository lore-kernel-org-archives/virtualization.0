Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988D4C001B0
	for <virtualization@archiver.kernel.org>; Mon, 14 Aug 2023 14:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1105740B12;
	Mon, 14 Aug 2023 14:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1105740B12
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Eh5R15cu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqlQFNSF0dQ7; Mon, 14 Aug 2023 14:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E89540B47;
	Mon, 14 Aug 2023 14:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E89540B47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 592D0C0072;
	Mon, 14 Aug 2023 14:00:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39791C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 14:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12D6A41753
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 14:00:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12D6A41753
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Eh5R15cu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aflBvXwR-nEw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 14:00:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C68FD4097A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Aug 2023 14:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C68FD4097A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692021619; x=1723557619;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ejv5hEf5eTJPWbPYhLKVJ6OdJcC5J7Oaww5h4B8uP5s=;
 b=Eh5R15cuiYXVF4TagSHbhfiIpJDIm2zDuoC2M8iyhdwyJfgaSymUtYIr
 igF1NyYpvb9RGhXksvYPSHYgcNrkMtW4li3cK3VPglwKAdC7Y/yP77VWR
 /gV08eNhyXbjradyorZJTyQjkXVH2pf5jd+9fakfKphUHvO7WWAZugzDH
 v6YGLuMv7DBqKaQEhr0LZ3tdytLNt2jEsEa6R3x44PY+uVS/scIe1I5iu
 jsrgEdtARO0TDuKEdA7Gxn2ThaM6MToRdUHP+RlcJOr1G+qokXtf3sC0G
 sNheB3oXepWAT1QvJlgfA/h9IvCQ8xFJgWPnuNb6RSTtO9TLTaRVMDHqE A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438374682"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; d="scan'208";a="438374682"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 07:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683315128"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; d="scan'208";a="683315128"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 06:59:59 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qVY6h-0000Aj-1O;
 Mon, 14 Aug 2023 13:59:49 +0000
Date: Mon, 14 Aug 2023 21:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 6/8] virtio-net: support rx netdim
Message-ID: <202308142100.l4cN4g6z-lkp@intel.com>
References: <20230811065512.22190-7-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230811065512.22190-7-hengqi@linux.alibaba.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Eric Dumazet <edumazet@google.com>, oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-initially-change-the-value-of-tx-frames/20230811-150529
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230811065512.22190-7-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next 6/8] virtio-net: support rx netdim
config: microblaze-randconfig-r081-20230814 (https://download.01.org/0day-ci/archive/20230814/202308142100.l4cN4g6z-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308142100.l4cN4g6z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308142100.l4cN4g6z-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
>> drivers/net/virtio_net.c:3269: undefined reference to `net_dim_get_rx_moderation'
   microblaze-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_update':
>> drivers/net/virtio_net.c:1985: undefined reference to `net_dim'


vim +3269 drivers/net/virtio_net.c

  3258	
  3259	static void virtnet_rx_dim_work(struct work_struct *work)
  3260	{
  3261		struct dim *dim = container_of(work, struct dim, work);
  3262		struct receive_queue *rq = container_of(dim,
  3263				struct receive_queue, dim);
  3264		struct virtnet_info *vi = rq->vq->vdev->priv;
  3265		struct net_device *dev = vi->dev;
  3266		struct dim_cq_moder update_moder;
  3267		int qnum = rq - vi->rq, err;
  3268	
> 3269		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
  3270		err = virtnet_send_rx_notf_coal_vq_cmd(vi, qnum,
  3271						       update_moder.usec,
  3272						       update_moder.pkts);
  3273		if (err)
  3274			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
  3275				 dev->name, (int)(rq - vi->rq));
  3276	
  3277		dim->state = DIM_START_MEASURE;
  3278	}
  3279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

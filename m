Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9FCC41513
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 23:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B72F8234F;
	Wed, 11 Oct 2023 23:23:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B72F8234F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIOmfBUz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxqyNA395cnO; Wed, 11 Oct 2023 23:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A294E82521;
	Wed, 11 Oct 2023 23:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A294E82521
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77CF9C0039;
	Wed, 11 Oct 2023 23:22:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E40AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 23:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50CB982521
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 23:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50CB982521
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fS83TKaHjihF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 23:22:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 611A48234F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 23:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 611A48234F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697066574; x=1728602574;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DnucBqEzH8AdiLeLvhjfTNkAqa/SqvErwqJcPz9oNuQ=;
 b=LIOmfBUzyXzJmvlIZrgPNuNKwbVi3JkYw1w2ntHGwlEBqpJJRMdqZxKq
 Qkl5LOuxKBEt6LouZWXk1Ob7tJT0D8UvM8sC9juzzBPK+9yhlBbM0rqKt
 E9vdUIsacxSAierQw6eGGaNCov9xnjq6j0sfdEP8pIZ/xjojeVSbAOHkb
 5qnmLGoeIrreGWn3SunZMzxs23XsGoikwYgnxl8GaoUVubyeB52/rdJXM
 XXxSt8P0fHx/G0mkrhDzpYM0XbY8+6Eepxm8t5WmIho/zbO4kCyGSR2Ri
 nW0N6mqHxX5CMgA7f3KXfPh0MutZqLR6ZF55R6AiNNbQv/82q/YyzhyUM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384641663"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; d="scan'208";a="384641663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 16:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870338199"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; d="scan'208";a="870338199"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
 by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2023 16:22:31 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qqiX7-0002q9-2C;
 Wed, 11 Oct 2023 23:22:29 +0000
Date: Thu, 12 Oct 2023 07:22:09 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 05/22] virtio_net: independent directory
Message-ID: <202310120705.aR0WPj7m-lkp@intel.com>
References: <20231011092728.105904-6-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-6-xuanzhuo@linux.alibaba.com>
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
patch link:    https://lore.kernel.org/r/20231011092728.105904-6-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 05/22] virtio_net: independent directory
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231012/202310120705.aR0WPj7m-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310120705.aR0WPj7m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310120705.aR0WPj7m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio/main.c: In function 'virtnet_find_vqs':
>> drivers/net/virtio/main.c:4091:48: warning: '%d' directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
    4091 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                                ^~
   drivers/net/virtio/main.c:4091:41: note: directive argument in the range [-2147483641, 65534]
    4091 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                         ^~~~~~~~~~
   drivers/net/virtio/main.c:4091:17: note: 'sprintf' output between 8 and 18 bytes into a destination of size 16
    4091 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio/main.c:4092:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
    4092 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                                 ^~
   drivers/net/virtio/main.c:4092:41: note: directive argument in the range [-2147483641, 65534]
    4092 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                         ^~~~~~~~~~~
   drivers/net/virtio/main.c:4092:17: note: 'sprintf' output between 9 and 19 bytes into a destination of size 16
    4092 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +4091 drivers/net/virtio/main.c

d85b758f72b05a drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-09  4046  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4047  static int virtnet_find_vqs(struct virtnet_info *vi)
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4048  {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4049  	vq_callback_t **callbacks;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4050  	struct virtqueue **vqs;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4051  	int ret = -ENOMEM;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4052  	int i, total_vqs;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4053  	const char **names;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4054  	bool *ctx;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4055  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4056  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4057  	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4058  	 * possible control vq.
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4059  	 */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4060  	total_vqs = vi->max_queue_pairs * 2 +
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4061  		    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4062  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4063  	/* Allocate space for find_vqs parameters */
6396bb221514d2 drivers/net/virtio_net.c Kees Cook          2018-06-12  4064  	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4065  	if (!vqs)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4066  		goto err_vq;
6da2ec56059c3c drivers/net/virtio_net.c Kees Cook          2018-06-12  4067  	callbacks = kmalloc_array(total_vqs, sizeof(*callbacks), GFP_KERNEL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4068  	if (!callbacks)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4069  		goto err_callback;
6da2ec56059c3c drivers/net/virtio_net.c Kees Cook          2018-06-12  4070  	names = kmalloc_array(total_vqs, sizeof(*names), GFP_KERNEL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4071  	if (!names)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4072  		goto err_names;
192f68cf35f5ee drivers/net/virtio_net.c Jason Wang         2017-07-19  4073  	if (!vi->big_packets || vi->mergeable_rx_bufs) {
6396bb221514d2 drivers/net/virtio_net.c Kees Cook          2018-06-12  4074  		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4075  		if (!ctx)
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4076  			goto err_ctx;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4077  	} else {
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4078  		ctx = NULL;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4079  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4080  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4081  	/* Parameters for control virtqueue, if any */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4082  	if (vi->has_cvq) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4083  		callbacks[total_vqs - 1] = NULL;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4084  		names[total_vqs - 1] = "control";
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4085  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4086  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4087  	/* Allocate/initialize parameters for send/receive virtqueues */
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4088  	for (i = 0; i < vi->max_queue_pairs; i++) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4089  		callbacks[rxq2vq(i)] = skb_recv_done;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4090  		callbacks[txq2vq(i)] = skb_xmit_done;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07 @4091  		sprintf(vi->rq[i].name, "input.%d", i);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4092  		sprintf(vi->sq[i].name, "output.%d", i);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4093  		names[rxq2vq(i)] = vi->rq[i].name;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4094  		names[txq2vq(i)] = vi->sq[i].name;
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4095  		if (ctx)
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4096  			ctx[rxq2vq(i)] = true;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4097  	}
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4098  
2e9ca760c289e1 drivers/net/virtio_net.c Michael S. Tsirkin 2022-08-16  4099  	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
2e9ca760c289e1 drivers/net/virtio_net.c Michael S. Tsirkin 2022-08-16  4100  				  names, ctx, NULL);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4101  	if (ret)
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4102  		goto err_find;
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4103  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4104  	if (vi->has_cvq) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4105  		vi->cvq = vqs[total_vqs - 1];
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4106  		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
f646968f8f7c62 drivers/net/virtio_net.c Patrick McHardy    2013-04-19  4107  			vi->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4108  	}
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4109  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4110  	for (i = 0; i < vi->max_queue_pairs; i++) {
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4111  		vi->rq[i].vq = vqs[rxq2vq(i)];
d85b758f72b05a drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-09  4112  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4113  		vi->sq[i].vq = vqs[txq2vq(i)];
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4114  	}
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4115  
2fa3c8a8b23041 drivers/net/virtio_net.c Tonghao Zhang      2018-05-31  4116  	/* run here: ret == 0. */
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4117  
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4118  
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4119  err_find:
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4120  	kfree(ctx);
d45b897b11eaf9 drivers/net/virtio_net.c Michael S. Tsirkin 2017-03-06  4121  err_ctx:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4122  	kfree(names);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4123  err_names:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4124  	kfree(callbacks);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4125  err_callback:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4126  	kfree(vqs);
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4127  err_vq:
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4128  	return ret;
3f9c10b0d478a3 drivers/net/virtio_net.c Amit Shah          2011-12-22  4129  }
986a4f4d452dec drivers/net/virtio_net.c Jason Wang         2012-12-07  4130  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

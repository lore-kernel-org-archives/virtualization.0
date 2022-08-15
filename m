Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D040C25B0E
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F32F440320;
	Mon, 15 Aug 2022 21:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F32F440320
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0NgGmOH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bJYfh-dPi87; Mon, 15 Aug 2022 21:02:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6268D4028D;
	Mon, 15 Aug 2022 21:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6268D4028D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36204C0032;
	Mon, 15 Aug 2022 21:02:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33E47C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB17E402B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB17E402B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id beSSkBXNIr10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:02:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2AC54028D
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2AC54028D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660597366; x=1692133366;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VmGl5Uf58OVl4vnbualwt0d6SOklcWUqb3Q8mIDSMf8=;
 b=j0NgGmOH1s7Lvsgfm9Y68sZaO0Mdt7JvRO7smBcAFJxXme6QerqHGCmC
 nbtZauKaRhqVO9QJW5jVZL/5oR/2nFKOswHFQRU7Hpqe7y7f7IpdShiGt
 489TYQwqjDjQxVwkbm1LnVI3NNOhqc5EKs0INZDgBhtgAKBLj8vObtxA8
 SD1s37CWAXI5kEHq6Vw4OIr7qL7/pwYqKdwL4G7ZSQmRfnlZ/VxQrp+SH
 o4ICPLOduenMFt4KV6yS1paHMU7XRLZZkmyN7Xp6YmIZhN+4qhbaftYdc
 8Nuok1aKj5MKml6LzIbNEbIg9G0fn82bKDUghJSWU5urJQXjasOL8tKGK A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289625324"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; d="scan'208";a="289625324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 14:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; d="scan'208";a="749063797"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2022 14:02:42 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oNhEN-0001E1-1P;
 Mon, 15 Aug 2022 21:02:39 +0000
Date: Tue, 16 Aug 2022 05:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 5/6] virtio/vsock: add support for dgram
Message-ID: <202208160405.cG02E3MZ-lkp@intel.com>
References: <3cb082f1c88f3f2ef1fc250dbc0745fb79c745c7.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3cb082f1c88f3f2ef1fc250dbc0745fb79c745c7.1660362668.git.bobby.eshleman@bytedance.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, kbuild-all@lists.01.org,
 kvm@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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

Hi Bobby,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-vsock-introduce-dgrams-sk_buff-and-qdisc/20220816-015812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220816/202208160405.cG02E3MZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cbb332da78c86ac574688831ed6f404d04d506db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bobby-Eshleman/virtio-vsock-introduce-dgrams-sk_buff-and-qdisc/20220816-015812
        git checkout cbb332da78c86ac574688831ed6f404d04d506db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/vmw_vsock/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/vmw_vsock/virtio_transport_common.c: In function 'virtio_transport_dgram_do_dequeue':
>> net/vmw_vsock/virtio_transport_common.c:605:13: warning: variable 'free_space' set but not used [-Wunused-but-set-variable]
     605 |         u32 free_space;
         |             ^~~~~~~~~~


vim +/free_space +605 net/vmw_vsock/virtio_transport_common.c

   597	
   598	static ssize_t
   599	virtio_transport_dgram_do_dequeue(struct vsock_sock *vsk,
   600					  struct msghdr *msg, size_t len)
   601	{
   602		struct virtio_vsock_sock *vvs = vsk->trans;
   603		struct sk_buff *skb;
   604		size_t total = 0;
 > 605		u32 free_space;
   606		int err = -EFAULT;
   607	
   608		spin_lock_bh(&vvs->rx_lock);
   609		if (total < len && !skb_queue_empty_lockless(&vvs->rx_queue)) {
   610			skb = __skb_dequeue(&vvs->rx_queue);
   611	
   612			total = len;
   613			if (total > skb->len - vsock_metadata(skb)->off)
   614				total = skb->len - vsock_metadata(skb)->off;
   615			else if (total < skb->len - vsock_metadata(skb)->off)
   616				msg->msg_flags |= MSG_TRUNC;
   617	
   618			/* sk_lock is held by caller so no one else can dequeue.
   619			 * Unlock rx_lock since memcpy_to_msg() may sleep.
   620			 */
   621			spin_unlock_bh(&vvs->rx_lock);
   622	
   623			err = memcpy_to_msg(msg, skb->data + vsock_metadata(skb)->off, total);
   624			if (err)
   625				return err;
   626	
   627			spin_lock_bh(&vvs->rx_lock);
   628	
   629			virtio_transport_dec_rx_pkt(vvs, skb);
   630			consume_skb(skb);
   631		}
   632	
   633		free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
   634	
   635		spin_unlock_bh(&vvs->rx_lock);
   636	
   637		if (total > 0 && msg->msg_name) {
   638			/* Provide the address of the sender. */
   639			DECLARE_SOCKADDR(struct sockaddr_vm *, vm_addr, msg->msg_name);
   640	
   641			vsock_addr_init(vm_addr, le64_to_cpu(vsock_hdr(skb)->src_cid),
   642					le32_to_cpu(vsock_hdr(skb)->src_port));
   643			msg->msg_namelen = sizeof(*vm_addr);
   644		}
   645		return total;
   646	}
   647	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

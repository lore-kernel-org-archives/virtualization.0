Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADDC00140
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 02:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 998C560E2F;
	Tue, 16 Aug 2022 02:17:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 998C560E2F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZhAHe5IG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjE9g7g-PXT9; Tue, 16 Aug 2022 02:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EAEA60E28;
	Tue, 16 Aug 2022 02:17:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EAEA60E28
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD865C0032;
	Tue, 16 Aug 2022 02:17:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72B54C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 02:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47FD860E2D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 02:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47FD860E2D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mZQPkhe3-qL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 02:17:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0946F60E28
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0946F60E28
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 02:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660616270; x=1692152270;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ke6eAVC77C6+361d8UODTw/ZgPikvq+7bjNByHRqW9M=;
 b=ZhAHe5IGqFndRg1UE/VEok9zs8N0gC0gkavkhq1ttSgjWPf1k0ecnQFR
 x4BpB2gSKJSgcWhNVSru6bCGPe2iYPTyyOQJ+LA1+DSl1j3u1v7XBazmN
 II8kzhQIl6tlNUqnXUCqo9r+vLrL8H999PP3fg6tVpn17g/O62Bc1Yyd2
 C3J2yximMiQVbQ7w8MoeP/8HjUi6rqzrhdvxbQ2Gxtzv1ql1wXyHBmZ8X
 yb/ZtLQpls7lYdF7x557GS1CupCKOWH/Vc8nCBsrSobrZ1M1EKd2vaqNi
 qidHdFJu0g2tW+0qVU6dpUMMj0VKd+AefeJKr/YgZ5qz6z3RsOd+tgAsW w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292901204"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="292901204"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 19:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="696178385"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2022 19:17:43 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oNm9G-0001Mn-2I;
 Tue, 16 Aug 2022 02:17:42 +0000
Date: Tue, 16 Aug 2022 10:16:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 2/6] vsock: return errors other than -ENOMEM to socket
Message-ID: <202208161059.GPIlPpvd-lkp@intel.com>
References: <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d81818b868216c774613dd03641fcfe63cc55a45.1660362668.git.bobby.eshleman@bytedance.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, kbuild-all@lists.01.org,
 kvm@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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
config: i386-randconfig-s001-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161059.GPIlPpvd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/68c9c8216a573cdfe2170cad677854e2f4a34634
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bobby-Eshleman/virtio-vsock-introduce-dgrams-sk_buff-and-qdisc/20220816-015812
        git checkout 68c9c8216a573cdfe2170cad677854e2f4a34634
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/nilfs2/ net/vmw_vsock/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/vmw_vsock/virtio_transport.c:173:31: sparse: sparse: restricted __le16 degrades to integer
   net/vmw_vsock/virtio_transport.c:174:31: sparse: sparse: restricted __le16 degrades to integer

vim +173 net/vmw_vsock/virtio_transport.c

0ea9e1d3a9e3ef Asias He       2016-07-28  161  
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  162  static inline bool
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  163  virtio_transport_skbs_can_merge(struct sk_buff *old, struct sk_buff *new)
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  164  {
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  165  	return (new->len < GOOD_COPY_LEN &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  166  		skb_tailroom(old) >= new->len &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  167  		vsock_hdr(new)->src_cid == vsock_hdr(old)->src_cid &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  168  		vsock_hdr(new)->dst_cid == vsock_hdr(old)->dst_cid &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  169  		vsock_hdr(new)->src_port == vsock_hdr(old)->src_port &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  170  		vsock_hdr(new)->dst_port == vsock_hdr(old)->dst_port &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  171  		vsock_hdr(new)->type == vsock_hdr(old)->type &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  172  		vsock_hdr(new)->flags == vsock_hdr(old)->flags &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15 @173  		vsock_hdr(old)->op == VIRTIO_VSOCK_OP_RW &&
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  174  		vsock_hdr(new)->op == VIRTIO_VSOCK_OP_RW);
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  175  }
93afaf2cdefaa9 Bobby Eshleman 2022-08-15  176  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

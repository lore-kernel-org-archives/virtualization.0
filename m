Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B3DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 19:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB2BD410C3;
	Tue, 22 Feb 2022 19:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJFeVxH5yM4q; Tue, 22 Feb 2022 19:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4767C4086D;
	Tue, 22 Feb 2022 19:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20911C0021;
	Tue, 22 Feb 2022 19:15:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33E42C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1486881767
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elEkxesJ3DMh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A92D81764
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645557355; x=1677093355;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G+u1GVMAA5AenTmPkcf2A62IVjXLsOKGaaxomIJ91iw=;
 b=IbtkdahH8aP+DzoD/UBvDGbtLa6fUOfq0QCTRXp8ou64ALYU9luT57XR
 /afK8IzcOEolYGlCjkmhHfQVu5c9g5VUe20pi7OA42ZSQtazzepkMkmq+
 jmvQDzDqypcatJocWyJhnp9T6Igsu4te9peX6Q5Fg5Ah3zh2924rqeMaH
 RDxcaD3LjaalSf042dDkT8sUSdGDlOdu3/Pv4CMtbuAycUe2xr47VZgvz
 f/0Mh38dhyfztz+LGEtW+mI83QwuDNtjWtE7rxgx8iavRhy562PaW/JhM
 oI9MNC6onyPuT5C3QoBtMAujuRh1Rn46YGdyhEvqjLn8UZY5w3xgLLWZk Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251980222"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="251980222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 11:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="683627455"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2022 11:15:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nMadb-0000Wn-Dz; Tue, 22 Feb 2022 19:15:51 +0000
Date: Wed, 23 Feb 2022 03:15:28 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Melnychenko <andrew@daynix.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH v4 3/4] drivers/net/virtio_net: Added RSS hash report.
Message-ID: <202202230342.HPYe6dHA-lkp@intel.com>
References: <20220222120054.400208-4-andrew@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222120054.400208-4-andrew@daynix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: yan@daynix.com, yuri.benditovich@daynix.com, kbuild-all@lists.01.org
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

Hi Andrew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on net/master horms-ipvs/master net-next/master linus/master v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: i386-randconfig-s002-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230342.HPYe6dHA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
        git checkout 4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>> drivers/net/virtio_net.c:1178:35: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] hash @@     got restricted __le32 const [usertype] hash_value @@
   drivers/net/virtio_net.c:1178:35: sparse:     expected unsigned int [usertype] hash
   drivers/net/virtio_net.c:1178:35: sparse:     got restricted __le32 const [usertype] hash_value

vim +1178 drivers/net/virtio_net.c

  1151	
  1152	static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
  1153					struct sk_buff *skb)
  1154	{
  1155		enum pkt_hash_types rss_hash_type;
  1156	
  1157		if (!hdr_hash || !skb)
  1158			return;
  1159	
  1160		switch (hdr_hash->hash_report) {
  1161		case VIRTIO_NET_HASH_REPORT_TCPv4:
  1162		case VIRTIO_NET_HASH_REPORT_UDPv4:
  1163		case VIRTIO_NET_HASH_REPORT_TCPv6:
  1164		case VIRTIO_NET_HASH_REPORT_UDPv6:
  1165		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
  1166		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
  1167			rss_hash_type = PKT_HASH_TYPE_L4;
  1168			break;
  1169		case VIRTIO_NET_HASH_REPORT_IPv4:
  1170		case VIRTIO_NET_HASH_REPORT_IPv6:
  1171		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
  1172			rss_hash_type = PKT_HASH_TYPE_L3;
  1173			break;
  1174		case VIRTIO_NET_HASH_REPORT_NONE:
  1175		default:
  1176			rss_hash_type = PKT_HASH_TYPE_NONE;
  1177		}
> 1178		skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
  1179	}
  1180	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

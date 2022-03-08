Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B8CC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 16:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB38B60FF6;
	Tue,  8 Mar 2022 16:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vc6cof9zmLT1; Tue,  8 Mar 2022 16:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 878F560B36;
	Tue,  8 Mar 2022 16:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D27EC001D;
	Tue,  8 Mar 2022 16:14:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69285C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45034417A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MqWPL3MvA7i
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:14:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F25B6417A6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646756046; x=1678292046;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=LR5CCv6Q3aBeORtqOyOOhZCKfF2QDO9kvzAaK6wB20k=;
 b=PZpp8an4/OPPvzPc2zL08JTS30oQGgF0NiXvvmhX5M48m9tjkF91PcYB
 RbW5n6EXZC/Jy81V3xo/Fnw8x863S2nLtCldjIgsZI6LbPYwet0n3Y2I8
 HGbF9tD+WN0bvYp0TRbVEiZOy5bg2KMYpYymIPmUhYpRtwyj6D5tALd0v
 xBSpIqECqJdxrrfj3k5MftGlzXu1SEk65ck5nU8Oq+kebFnQFbcz8BN5H
 cj+GHWLplY2DXmOwjNLPy1jp4DqC/XYnINutvjvc+DAjjmha/JSANDlVA
 SsuIDvzl7EETMrbLiBe6N0R6U36/CIbSJDh9gYBTn6ZQJ+Qw/E6uuksde Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254667153"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="254667153"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="711580048"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 08:11:31 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nRcQt-0001fZ-5b; Tue, 08 Mar 2022 16:11:31 +0000
Date: Wed, 9 Mar 2022 00:10:30 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: [mst-vhost:vhost 28/60] nios2-linux-ld:
 virtio_crypto_akcipher_algs.c:undefined reference to `rsa_parse_pub_key'
Message-ID: <202203090014.ulENdnAQ-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, lei he <helei.sig11@bytedance.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   c5f633abfd09491ae7ecbc7fcfca08332ad00a8b
commit: 8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9 [28/60] virtio-crypto: implement RSA algorithm
config: nios2-randconfig-p002-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090014.ulENdnAQ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9
        git remote add mst-vhost https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
        git fetch --no-tags mst-vhost vhost
        git checkout 8a75f36b5d7a48f1c5a0b46638961c951ec6ecd9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/crypto/virtio/virtio_crypto_akcipher_algs.o: in function `virtio_crypto_rsa_set_key':
   virtio_crypto_akcipher_algs.c:(.text+0x4bc): undefined reference to `rsa_parse_priv_key'
   virtio_crypto_akcipher_algs.c:(.text+0x4bc): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_priv_key'
>> nios2-linux-ld: virtio_crypto_akcipher_algs.c:(.text+0x4e8): undefined reference to `rsa_parse_pub_key'
   virtio_crypto_akcipher_algs.c:(.text+0x4e8): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_pub_key'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

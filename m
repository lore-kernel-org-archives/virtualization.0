Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F40BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 15:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0812784735;
	Fri, 20 May 2022 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kjV07IDTX4m; Fri, 20 May 2022 15:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EF4284730;
	Fri, 20 May 2022 15:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C5DAC0039;
	Fri, 20 May 2022 15:29:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C07BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52AD840AA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHrjowdmshF1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:29:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD8D140A8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653060543; x=1684596543;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2leG2LmaeymdY17ZfAaPpngzgqFnDp+gD2t1Nl2U6Yo=;
 b=jcbkru84lCeGawl6nzaaB4R8m2BRCAIfj47AtHKWaLoztw4UiwnHzxpn
 jMb09t3t4ou4GhFKW2jAMiw91KljWojiFJFu2z0wI9+cSypgptpcZdrg9
 DPfG/NPbnMdemRy/2t9bq0L3vExg/auWz1HflP6bBRRcZraxAE59Gx9iX
 rcrB45NenyWkVY9Q1B1PQXiEASnQr2ZZlOA/ZLnQa7lNhSZj+9m8ypQ65
 K6ToZ0wp0PBTuca1SItm+ItKGhod3QiEs4VPn11nCQvLcb1f+UPX7bgE3
 yKvPE7aM4gn3NpozUebtyZ1d6LXja3BrV7r3yYcE8YlJSUIkswFfIwCaS Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253150769"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="253150769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 08:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="899369665"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by fmsmga005.fm.intel.com with ESMTP; 20 May 2022 08:28:50 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ns4Yb-0004rl-NI;
 Fri, 20 May 2022 15:28:49 +0000
Date: Fri, 20 May 2022 23:28:25 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
 naoya.horiguchi@nec.com, mst@redhat.com, david@redhat.com
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <202205202330.u0vQWiWG-lkp@intel.com>
References: <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
Cc: kbuild-all@lists.01.org, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
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

Hi zhenwei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220519]
[cannot apply to linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm-randconfig-r026-20220519 (https://download.01.org/0day-ci/archive/20220520/202205202330.u0vQWiWG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a42127073dd4adb6354649c8235c5cde033d01f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
        git checkout a42127073dd4adb6354649c8235c5cde033d01f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `unpoison_memory_func':
>> virtio_balloon.c:(.text+0x89a): undefined reference to `unpoison_memory'
   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_probe':
>> virtio_balloon.c:(.text+0x111a): undefined reference to `register_memory_failure_notifier'
   arm-linux-gnueabi-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_remove':
>> virtio_balloon.c:(.text+0x12a2): undefined reference to `unregister_memory_failure_notifier'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

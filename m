Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC8BC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 05:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDD4240C85;
	Wed, 17 Aug 2022 05:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDD4240C85
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxVX7sO1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U0MliM0l_4Zi; Wed, 17 Aug 2022 05:10:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4606A400D2;
	Wed, 17 Aug 2022 05:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4606A400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13295C0032;
	Wed, 17 Aug 2022 05:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E48DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 05:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41BEF40C80
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 05:10:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41BEF40C80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id diasXxbthjqa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 05:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15323400D2
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15323400D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660713023; x=1692249023;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AvafYqkxq3og1b2wyCNF9KJ/y92RWHvhMeHMG1bWo50=;
 b=jxVX7sO1lz9Lskf7Um/HiEkW2NzdEEGKMNb1k/GQnNf690lS5QUXcjWf
 DmVMxreAXxfVnnDFkpqT18q9CbpyBatxlKdVUCpz3QUQ7B3yWOVLCyCIJ
 cWlcFX31anxVn3Qi51OO/IJrWTX7voqA5hWw5Sy4WlznhCVTb/rFrYiTe
 AAsbN42qCdLv4a2wRHC5LwmyNsrzeMmRTtJ7GegzOzZD53AjUlWDN9KQc
 pInyzpQaSe7+VF2qCiz0WMsRkIGAhqekFRL45eHHq5rJXSC0E1gk+/Yt1
 VOu3ytsDqZGIQLdlp0lQtB+tUV8tV1TLEwnx13fjQQAw0d6K7jgS/7aNk A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318405603"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="318405603"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 22:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="557976200"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 16 Aug 2022 22:10:11 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oOBJj-0000bM-07;
 Wed, 17 Aug 2022 05:10:11 +0000
Date: Wed, 17 Aug 2022 13:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/4] drivers: virtio: balloon - update inflated memory
Message-ID: <202208171338.xAU3O9KJ-lkp@intel.com>
References: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
Cc: kbuild-all@lists.01.org, llvm@lists.linux.dev,
 Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kernel@openvz.org
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

Hi Alexander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on char-misc/char-misc-testing linus/master v6.0-rc1 next-20220816]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220817/202208171338.xAU3O9KJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
        git checkout d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "balloon_set_inflated_total" [drivers/virtio/virtio_balloon.ko] undefined!
>> ERROR: modpost: "balloon_set_inflated_free" [drivers/virtio/virtio_balloon.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

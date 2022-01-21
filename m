Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F56DC4332F
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 21:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D05BF81902;
	Fri, 21 Jan 2022 21:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNCRXa1dXkdP; Fri, 21 Jan 2022 21:44:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57F4D81465;
	Fri, 21 Jan 2022 21:44:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B4C9C0039;
	Fri, 21 Jan 2022 21:44:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61622C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 21:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DD0A416B9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 21:44:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1hvT4666_Cwv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 21:44:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26D2740882
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642801448; x=1674337448;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8p41zx7lhw7bUtkcYKDSxXkPejlpXaQYhHjrWI+euIg=;
 b=MXqpyPDIR91KhvvjRmuJYdCvNgyvA8k+8BoqfJ/wUenWm7O+nGfXldGf
 +9e/gde/SqahzC3ZLk2up9v4aL8hoy7wMizgKnZBua9lagTlfGISPMWJN
 Kj+UHMFbiYE1uXMRenk71Glrb/g08UM/B6w1g0Gfx2ce6KsXkhnTqxtZa
 H0fWB0yec3sqq+QBKeVi9nlIiAUWBaG36BWaLeRtSkBSjf4hSwMz5D3Hb
 se3ZAEJ7YT/4sv913Jmh3sP01o+2oPU5pPXmT/3FGaZ54ig4I39e7qYJ6
 xwAuKY0Brn1qCRr9N7gbX/wZNLZQTtJRYuxSyfm7uce9kCyN/pJnw4DeG w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="270176379"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; d="scan'208";a="270176379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2022 13:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; d="scan'208";a="694779862"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 13:44:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nB1hU-000Fgy-87; Fri, 21 Jan 2022 21:44:04 +0000
Date: Sat, 22 Jan 2022 05:43:46 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
 arei.gonglei@huawei.com
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201220521.kldW6vYy-lkp@intel.com>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, helei.sig11@bytedance.com,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: nios2-randconfig-c024-20220120 (https://download.01.org/0day-ci/archive/20220122/202201220521.kldW6vYy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/crypto/virtio/virtio_crypto_akcipher_algo.o: in function `virtio_crypto_rsa_set_key':
   virtio_crypto_akcipher_algo.c:(.text+0x4d4): undefined reference to `rsa_parse_priv_key'
   virtio_crypto_akcipher_algo.c:(.text+0x4d4): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_priv_key'
>> nios2-linux-ld: virtio_crypto_akcipher_algo.c:(.text+0x514): undefined reference to `rsa_parse_pub_key'
   virtio_crypto_akcipher_algo.c:(.text+0x514): relocation truncated to fit: R_NIOS2_CALL26 against `rsa_parse_pub_key'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

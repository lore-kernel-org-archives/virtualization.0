Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D5DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 08:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE85A41659;
	Fri, 21 Jan 2022 08:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q09sxpqdQicd; Fri, 21 Jan 2022 08:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C34241649;
	Fri, 21 Jan 2022 08:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F323C0031;
	Fri, 21 Jan 2022 08:39:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7F10C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A28FB82733
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YG1Alj8Um3Z0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:39:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B0DD8249E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642754382; x=1674290382;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RS7d/rieKW2hBYhX4fSMxivDzOWRJaytbe7/otmfuWs=;
 b=R6JEfBcaoKNDKGOGShCIeULSQX5I0aIbtXP6MWAEosdD/HEJtyOpprU+
 WH9DaOp6tzqvI3i/FhTi2vRHxkKTSSJBHIdU7QG5Ka30MsoLyuNSy6BLz
 q2ON0DJfcg9SazjGnqAMRmdw6oykny+s6938M4KbNGNWYK0Cz8opMqE5h
 PEULEfO4i7EgJjEC2xcOPFjGlksjmGoFF5KN0YfHxp6OtU5CY/eMgIY1I
 gvew5LJVHkijarU6XlwX0uLYoNRySjfivZJj1u4zqCVRU3Xnphu+cbbze
 ie8owVq6quA4vavXSt5jao+FVryBvNzpid+EeL+cEnE8mSeZ0/hm3n2Lh g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245551140"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="245551140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2022 00:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="626664541"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 00:39:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nApSM-000F7S-Ta; Fri, 21 Jan 2022 08:39:38 +0000
Date: Fri, 21 Jan 2022 16:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
 arei.gonglei@huawei.com
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201211638.IIpjX8Kd-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220121/202201211638.IIpjX8Kd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: sparse: sparse: symbol 'virtio_crypto_rsa_do_req' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACD4C004D4
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 03:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C9DA4017A;
	Fri, 20 Jan 2023 03:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C9DA4017A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T9loOMUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2-0cIj4AhuD; Fri, 20 Jan 2023 03:07:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A294540126;
	Fri, 20 Jan 2023 03:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A294540126
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77610C0033;
	Fri, 20 Jan 2023 03:07:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7E4AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 03:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BA3D41D4C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 03:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BA3D41D4C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=T9loOMUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aux0w_NJAlKG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 03:07:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A86AB41D48
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A86AB41D48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674184061; x=1705720061;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l+mSYcjCs3VtHdH4MTzk9fTsaIZXQ5VDUn8clsV5ONw=;
 b=T9loOMUrSlEGJ+vEBRAzPzFV41LYAePfRznOyDu7Eu8ccMgHtfU4W0OE
 orjdxKWHUVeOY5IAtfIcj6eWBWiDWb7glTFQB4Uq2ECsp9QuHfNWqNzy/
 evTYHV9/H8jxutqErS6nBqFmrnrvNuQhs3TgmgrQVmSvYLDnmKbuTIRjK
 e77oLshU7E50Be5IyS9FSm/jiRbQxh97n6NmzXALGhRkUSe8LUMSxKYC3
 4arnOEm8K8o0SY1RdbSXCDm4evmx1eKMtHAR6WUhNeYWDSaFFJPtTLyQ0
 avImivNmfDGRovwlq1g/TtspgCxJwk1gJ4L9GfpR6zuqq+H60cm/5HnwR w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411726048"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; d="scan'208";a="411726048"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2023 19:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692719398"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; d="scan'208";a="692719398"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 19 Jan 2023 19:07:37 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pIhke-00027Z-13;
 Fri, 20 Jan 2023 03:07:36 +0000
Date: Fri, 20 Jan 2023 11:07:16 +0800
From: kernel test robot <lkp@intel.com>
To: Babis Chalios <bchalios@amazon.es>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio-rng: add sysfs entries for leak detection
Message-ID: <202301201004.z1gRttwb-lkp@intel.com>
References: <20230119184349.74072-3-bchalios@amazon.es>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119184349.74072-3-bchalios@amazon.es>
Cc: xmarcalx@amazon.co.uk, Jason@zx2c4.com, amit@kernel.org, graf@amazon.de,
 oe-kbuild-all@lists.linux.dev
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

Hi Babis,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.2-rc4 next-20230119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
patch link:    https://lore.kernel.org/r/20230119184349.74072-3-bchalios%40amazon.es
patch subject: [PATCH 2/2] virtio-rng: add sysfs entries for leak detection
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20230120/202301201004.z1gRttwb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/2a801d93b8225555e4cb293a173e2053870cb2d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
        git checkout 2a801d93b8225555e4cb293a173e2053870cb2d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/char/hw_random/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/char/hw_random/virtio-rng.c:61:9: sparse: sparse: symbol 'virtrng_sysfs_read' was not declared. Should it be static?
>> drivers/char/hw_random/virtio-rng.c:76:5: sparse: sparse: symbol 'virtrng_sysfs_mmap' was not declared. Should it be static?
   drivers/char/hw_random/virtio-rng.c:106:5: sparse: sparse: symbol 'add_fill_on_leak_request' was not declared. Should it be static?
   drivers/char/hw_random/virtio-rng.c:120:5: sparse: sparse: symbol 'virtrng_fill_on_leak' was not declared. Should it be static?
   drivers/char/hw_random/virtio-rng.c:141:5: sparse: sparse: symbol 'add_copy_on_leak_request' was not declared. Should it be static?
   drivers/char/hw_random/virtio-rng.c:160:5: sparse: sparse: symbol 'virtrng_copy_on_leak' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

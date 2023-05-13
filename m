Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6662FC77B7F
	for <virtualization@archiver.kernel.org>; Sat, 13 May 2023 17:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B683C42D08;
	Sat, 13 May 2023 17:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B683C42D08
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SqQqiPod
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBJuIWQcOzOp; Sat, 13 May 2023 17:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E20841F21;
	Sat, 13 May 2023 17:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E20841F21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72756C0036;
	Sat, 13 May 2023 17:22:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96397C002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 17:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D40A6113C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 17:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D40A6113C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SqQqiPod
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NBdnfZeMlZt
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 17:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57FC560F5C
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57FC560F5C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683998538; x=1715534538;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yCiE+DM/RmCoDfRlV+pV24ATWliUJ51tjtagVjTL+vM=;
 b=SqQqiPodQjwhMDKL2Gs6E7NgXNRtk2irV0+CaAWDc37atMn5f9GVFrYi
 WzD8K1g5/5VvAKidDRAFPnNQla/wbNB+gn7JvS5K4OGBGUN1CGWDfk6Ci
 OIURZpd1lRNpzyR/QI/9XerSxa79UWFqYW8DCSsRYtqyzsi9/iIyVvKXq
 DmIiolbz9wW5+4mYfQKyhbFtXS3SqynVrrx8JbY+SVrqQ4z1LMDGEycy8
 u3LyW7UzNq5bEgVAKHbKzVxH9FL15RBgYkDQuMW4GnUfhZMh9Z0lQuhb9
 46DewaIrzFAunyi65hoED1OazoRzHPUepkH++j56XIp7KaqCOKAEPO0hh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354118136"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; d="scan'208";a="354118136"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2023 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="824684509"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; d="scan'208";a="824684509"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 13 May 2023 10:22:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pxswf-0005bA-2H;
 Sat, 13 May 2023 17:22:13 +0000
Date: Sun, 14 May 2023 01:22:06 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, stefanha@redhat.com,
 mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <202305140142.c0QQq9wZ-lkp@intel.com>
References: <20230512094618.433707-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230512094618.433707-2-pizhenwei@bytedance.com>
Cc: xuanzhuo@linux.alibaba.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
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

Hi zhenwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230512094618.433707-2-pizhenwei%40bytedance.com
patch subject: [PATCH 1/2] virtio: abstract virtqueue related methods
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
        git checkout 372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140142.c0QQq9wZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_inbuf' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_outbuf' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_add_sgs' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_get_buf_ctx' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_disable_cb' not found
>> ./drivers/virtio/virtio_ring.c:1: warning: 'virtqueue_enable_cb' not found

vim +/virtqueue_add_inbuf +1 ./drivers/virtio/virtio_ring.c

fd534e9b5fdcf9 Thomas Gleixner     2019-05-23  @1  // SPDX-License-Identifier: GPL-2.0-or-later
0a8a69dd77ddbd Rusty Russell       2007-10-22   2  /* Virtio ring implementation.
0a8a69dd77ddbd Rusty Russell       2007-10-22   3   *
0a8a69dd77ddbd Rusty Russell       2007-10-22   4   *  Copyright 2007 Rusty Russell IBM Corporation
0a8a69dd77ddbd Rusty Russell       2007-10-22   5   */
0a8a69dd77ddbd Rusty Russell       2007-10-22   6  #include <linux/virtio.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22   7  #include <linux/virtio_ring.h>
e34f87256794b8 Rusty Russell       2008-07-25   8  #include <linux/virtio_config.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22   9  #include <linux/device.h>
5a0e3ad6af8660 Tejun Heo           2010-03-24  10  #include <linux/slab.h>
b5a2c4f1996d1d Paul Gortmaker      2011-07-03  11  #include <linux/module.h>
e93300b1afc7cd Rusty Russell       2012-01-12  12  #include <linux/hrtimer.h>
780bc7903a32ed Andy Lutomirski     2016-02-02  13  #include <linux/dma-mapping.h>
88938359e2dfe1 Alexander Potapenko 2022-09-15  14  #include <linux/kmsan.h>
f8ce72632fa7ed Michael S. Tsirkin  2021-08-10  15  #include <linux/spinlock.h>
78fe39872378b0 Andy Lutomirski     2016-02-02  16  #include <xen/xen.h>
0a8a69dd77ddbd Rusty Russell       2007-10-22  17  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

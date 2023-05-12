Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AFEC77B7F
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 16:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE6104186E;
	Fri, 12 May 2023 16:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE6104186E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dAQXIO/W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j6poR03UD0kI; Fri, 12 May 2023 16:40:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB12A41BB0;
	Fri, 12 May 2023 16:40:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB12A41BB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1558C0037;
	Fri, 12 May 2023 16:40:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78D9FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 16:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5208C41BB0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 16:40:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5208C41BB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpqNje5Itoxf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 16:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E462541B99
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E462541B99
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683909654; x=1715445654;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PJPVmTdRe4u56JmuEI8g5qgJZK5eGcMCwwuUoq3b64k=;
 b=dAQXIO/WMqRq7lzdV82Pkrz+9AmyfAYHlm8BUf7Rn9TitxVNxeodRIJb
 GYwjPO3ugdzwnKrhkE+4hANPd+cKFyKPJtTyGHaJ/s6DalX8jvAxyh8+6
 rO4YioFHzq6AJz1YfXf9ts254c7Uckh4ZS500OaFKw+SQ21GTLIfY+PWO
 3CA4c7YYB1LkQ9w66f92Y1MffStBXsvHlmsx/vlpRBajtGtIQIAiZ5GjK
 J5XUeAEkVIecLrZyHr06Y5WU6GLCSOYfxCA6YspcSUlUKXT0lJCiVUY5r
 rICyfT5A0+PW7HlPky5CcBp6ounW7taPR0dwTm/G/OgyenV2j+hjzQ6VM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353965521"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="353965521"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 09:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="824416404"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; d="scan'208";a="824416404"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 12 May 2023 09:40:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pxVp4-0004yS-3B;
 Fri, 12 May 2023 16:40:50 +0000
Date: Sat, 13 May 2023 00:40:49 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, stefanha@redhat.com,
 mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <202305130012.LQ2KTO5C-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230512094618.433707-2-pizhenwei%40bytedance.com
patch subject: [PATCH 1/2] virtio: abstract virtqueue related methods
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230513/202305130012.LQ2KTO5C-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/virtio-abstract-virtqueue-related-methods/20230512-174928
        git checkout 372bc1a0371968752fe0f5ec6e81edee6f9c44dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130012.LQ2KTO5C-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/virtio/virtio.c: In function 'virtio_break_device':
>> drivers/virtio/virtio.c:893:24: error: 'struct virtqueue_ops' has no member named '__builtin_loongarch_break'
     893 |                 vq->ops->__break(vq);
         |                        ^~


vim +893 drivers/virtio/virtio.c

   882	
   883	/*
   884	 * This should prevent the device from being used, allowing drivers to
   885	 * recover.  You may need to grab appropriate locks to flush.
   886	 */
   887	void virtio_break_device(struct virtio_device *dev)
   888	{
   889		struct virtqueue *vq;
   890	
   891		spin_lock(&dev->vqs_list_lock);
   892		list_for_each_entry(vq, &dev->vqs, list) {
 > 893			vq->ops->__break(vq);
   894		}
   895		spin_unlock(&dev->vqs_list_lock);
   896	}
   897	EXPORT_SYMBOL_GPL(virtio_break_device);
   898	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

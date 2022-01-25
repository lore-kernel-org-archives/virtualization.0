Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 19:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8C1860879;
	Tue, 25 Jan 2022 19:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvY2tOZKGI7K; Tue, 25 Jan 2022 19:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 606D1607F7;
	Tue, 25 Jan 2022 19:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E645C0039;
	Tue, 25 Jan 2022 19:18:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01026C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E35BC4019C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0jWH8If3D4L3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 986474013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643138300; x=1674674300;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FwntuYkMFyXC8A/fT+dSEYw/mEXLQW02at8ETMVlkJY=;
 b=j5ROqI193X57PxTTDIwZlzOCE5N0X8h7TXVg/1MHNWAinJ0WqGZS6WmF
 gxsp1aQF0oNJuG38jxWpvDuNF7+H/vICAbi2cuE925OKKvxWhyM6U8Q1e
 Jc60yK+00U6LL/e5DM4M43o2yt4bI/D1rsGtGEjLRDIZmccdGfBw3sHIF
 KhiZmORzZIXIWmqYTGlEx2+so/Lz22g7uX3j0RY4uUcnHXBDQCZQJVW/3
 dpiakzrf0vBthR+SwbkKH6gh7ANP9KmgljbrCiGvktSOF0+K127NvKbA+
 1pwVGi8dpcprdzAL7KMBU55eV3gpUd/JLIbrd9/dsIeSSalj6BlXv3XzN w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309709096"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; d="scan'208";a="309709096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 11:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; d="scan'208";a="624579555"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2022 11:18:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nCRKa-000KMG-Dn; Tue, 25 Jan 2022 19:18:16 +0000
Date: Wed, 26 Jan 2022 03:17:18 +0800
From: kernel test robot <lkp@intel.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH V2 3/4] vhost_vdpa: don't setup irq offloading when
 irq_num < 0
Message-ID: <202201260245.1yTB6YwE-lkp@intel.com>
References: <20220125091744.115996-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125091744.115996-4-lingshan.zhu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: netdev@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 llvm@lists.linux.dev, kbuild-all@lists.01.org,
 virtualization@lists.linux-foundation.org
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

Hi Zhu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on horms-ipvs/master linus/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhu-Lingshan/vDPA-ifcvf-implement-shared-IRQ-feature/20220125-174020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: arm-randconfig-c002-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260245.1yTB6YwE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/9242eae873643db8562d24857da7d05a2950ecfe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhu-Lingshan/vDPA-ifcvf-implement-shared-IRQ-feature/20220125-174020
        git checkout 9242eae873643db8562d24857da7d05a2950ecfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vhost/vdpa.c:99:6: warning: variable 'irq' is uninitialized when used here [-Wuninitialized]
           if (irq < 0)
               ^~~
   drivers/vhost/vdpa.c:94:14: note: initialize the variable 'irq' to silence this warning
           int ret, irq;
                       ^
                        = 0
   1 warning generated.


vim +/irq +99 drivers/vhost/vdpa.c

    88	
    89	static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
    90	{
    91		struct vhost_virtqueue *vq = &v->vqs[qid];
    92		const struct vdpa_config_ops *ops = v->vdpa->config;
    93		struct vdpa_device *vdpa = v->vdpa;
    94		int ret, irq;
    95	
    96		if (!ops->get_vq_irq)
    97			return;
    98	
  > 99		if (irq < 0)
   100			return;
   101	
   102		irq = ops->get_vq_irq(vdpa, qid);
   103		irq_bypass_unregister_producer(&vq->call_ctx.producer);
   104		if (!vq->call_ctx.ctx || irq < 0)
   105			return;
   106	
   107		vq->call_ctx.producer.token = vq->call_ctx.ctx;
   108		vq->call_ctx.producer.irq = irq;
   109		ret = irq_bypass_register_producer(&vq->call_ctx.producer);
   110		if (unlikely(ret))
   111			dev_info(&v->dev, "vq %u, irq bypass producer (token %p) registration fails, ret =  %d\n",
   112				 qid, vq->call_ctx.producer.token, ret);
   113	}
   114	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

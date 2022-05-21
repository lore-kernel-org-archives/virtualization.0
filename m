Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A91C433EF
	for <virtualization@archiver.kernel.org>; Sat, 21 May 2022 05:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB69B83187;
	Sat, 21 May 2022 05:21:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnoVlcPZMmOz; Sat, 21 May 2022 05:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 350F1827BB;
	Sat, 21 May 2022 05:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B009C0032;
	Sat, 21 May 2022 05:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27C68C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 May 2022 05:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2343A41D69
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 May 2022 05:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9U9fJrGe8Bj
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 May 2022 05:21:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2F2B41D5C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 May 2022 05:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653110497; x=1684646497;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AxY0/ZwmUN9083vJCm9KBOmh71p8D4zqbsXHhQnXUxI=;
 b=jZ7dETym7jN8kKGOojoE8fgY3aXW97Fuxh/Pj8blEoMaYuZgWAINIa+H
 6YhK2F8C5T8Hmx/6w1dULfv+S0FvHtvMPS+47lW2AI0xFHH+aD6M1y3Uz
 jUJVqCzIJNOaDhA3mUAnDY7EgXH04qJoyOqjR6vmaxDdJBRJAYWfsN5x1
 jemHL/MPk+MhOHBGpR5Ma0myWkLKkeAMONGPYfjU6JgulsaPoEwZ8oBnp
 CiKm66Hqy0mwfFjE41E+6TvXZ1TtiqNpJlCmkFU+dtMyPr9BQlxG5XbBu
 YltctikUbnckqIXNKX25Z2MQeVBMm+Wqj50IoT/4lW5SvC+BoBg9/taoD Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272785443"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="272785443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 22:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="547020986"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 20 May 2022 22:21:30 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nsHYP-0005y2-TN;
 Sat, 21 May 2022 05:21:29 +0000
Date: Sat, 21 May 2022 13:20:52 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] vhost-vdpa: uAPI to stop the device
Message-ID: <202205211317.rqYkIW8B-lkp@intel.com>
References: <20220520172325.980884-4-eperezma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520172325.980884-4-eperezma@redhat.com>
Cc: tanuj.kamde@amd.com, Dan Carpenter <error27@gmail.com>,
 llvm@lists.linux.dev, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Xie Yongji <xieyongji@bytedance.com>, martinh@xilinx.com,
 eperezma@redhat.com, dinang@xilinx.com, habetsm.xilinx@gmail.com,
 Longpeng <longpeng2@huawei.com>, lvivier@redhat.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kbuild-all@lists.01.org,
 gautam.dawar@amd.com, ecree.xilinx@gmail.com, hanand@xilinx.com,
 martinpo@xilinx.com, Zhu Lingshan <lingshan.zhu@intel.com>
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

Hi "Eugenio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on next-20220520]
[cannot apply to horms-ipvs/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/Implement-vdpasim-stop-operation/20220521-012742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: hexagon-randconfig-r041-20220519 (https://download.01.org/0day-ci/archive/20220521/202205211317.rqYkIW8B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd6562e0d85e8d689d30226bcc0f43246e27e4b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eugenio-P-rez/Implement-vdpasim-stop-operation/20220521-012742
        git checkout bd6562e0d85e8d689d30226bcc0f43246e27e4b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vhost/vdpa.c:493:25: warning: variable 'stop' is uninitialized when used here [-Wuninitialized]
           return ops->stop(vdpa, stop);
                                  ^~~~
   drivers/vhost/vdpa.c:485:10: note: initialize the variable 'stop' to silence this warning
           int stop;
                   ^
                    = 0
   1 warning generated.


vim +/stop +493 drivers/vhost/vdpa.c

   480	
   481	static long vhost_vdpa_stop(struct vhost_vdpa *v, u32 __user *argp)
   482	{
   483		struct vdpa_device *vdpa = v->vdpa;
   484		const struct vdpa_config_ops *ops = vdpa->config;
   485		int stop;
   486	
   487		if (!ops->stop)
   488			return -EOPNOTSUPP;
   489	
   490		if (copy_to_user(argp, &stop, sizeof(stop)))
   491			return -EFAULT;
   492	
 > 493		return ops->stop(vdpa, stop);
   494	}
   495	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

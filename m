Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E92C433EF
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 17:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3245841C30;
	Wed, 25 May 2022 17:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImdD4Yo6rP31; Wed, 25 May 2022 17:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3922B41BA5;
	Wed, 25 May 2022 17:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1243C007C;
	Wed, 25 May 2022 17:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A2DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 17:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E083A4107D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 17:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gpdON_00rxos
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 17:53:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2D5141085
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653501192; x=1685037192;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OBl8VqVg26hgXRW1FrdHxYUiLB4y0jncmZM7TnohZuE=;
 b=TKuIxd39uJ2JbWNp+yIiLWVmhYibnxdc4YakCCsGjmjAd49ymUI25WRe
 FHH3nQvBBBjclo0/CuNAIOYnM/6tqe1pu2HpBxFIRWKUt+lm3fWoo2iNy
 +IPGXVN3uwoselHWzFvmDodSQzWREx8dwD+7caVyIn0HqRBPAbRpAH2de
 BFwpSx+1olJwI0wkgLVfuNRKT81JAdz4tKfzRYwFZ7ozM0bhnCszhlGex
 eZAkWklcJ22pFQjYcUEdC0oC6+BK17BbQ8majJC9nigKJ2hWbRcVGr2dJ
 gD4pptXS58lEKL/oe1+LYU9glstUFjtA64KFuHtijkB/cXi7wR21z+bgq A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="272708432"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="272708432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 10:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="664528898"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 25 May 2022 10:53:04 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ntvBv-0003DC-DD;
 Wed, 25 May 2022 17:53:03 +0000
Date: Thu, 26 May 2022 01:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 3/4] vhost-vdpa: uAPI to stop the device
Message-ID: <202205260121.6V500tTl-lkp@intel.com>
References: <20220525105922.2413991-4-eperezma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525105922.2413991-4-eperezma@redhat.com>
Cc: tanuj.kamde@amd.com, Dan Carpenter <error27@gmail.com>,
 llvm@lists.linux.dev, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>, lvivier@redhat.com,
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on next-20220525]
[cannot apply to horms-ipvs/master linux/master linus/master v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/Implement-vdpasim-stop-operation/20220525-190143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220526/202205260121.6V500tTl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/515f6b6d2a0164df801ddbe61e1cb1ae4e763873
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eugenio-P-rez/Implement-vdpasim-stop-operation/20220525-190143
        git checkout 515f6b6d2a0164df801ddbe61e1cb1ae4e763873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/vhost/vdpa.c:668:7: error: use of undeclared identifier 'VHOST_STOP'
           case VHOST_STOP:
                ^
   1 error generated.


vim +/VHOST_STOP +668 drivers/vhost/vdpa.c

   587	
   588	static long vhost_vdpa_unlocked_ioctl(struct file *filep,
   589					      unsigned int cmd, unsigned long arg)
   590	{
   591		struct vhost_vdpa *v = filep->private_data;
   592		struct vhost_dev *d = &v->vdev;
   593		void __user *argp = (void __user *)arg;
   594		u64 __user *featurep = argp;
   595		u64 features;
   596		long r = 0;
   597	
   598		if (cmd == VHOST_SET_BACKEND_FEATURES) {
   599			if (copy_from_user(&features, featurep, sizeof(features)))
   600				return -EFAULT;
   601			if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
   602					 BIT_ULL(VHOST_BACKEND_F_STOP)))
   603				return -EOPNOTSUPP;
   604			if ((features & BIT_ULL(VHOST_BACKEND_F_STOP)) &&
   605			     !vhost_vdpa_can_stop(v))
   606				return -EOPNOTSUPP;
   607			vhost_set_backend_features(&v->vdev, features);
   608			return 0;
   609		}
   610	
   611		mutex_lock(&d->mutex);
   612	
   613		switch (cmd) {
   614		case VHOST_VDPA_GET_DEVICE_ID:
   615			r = vhost_vdpa_get_device_id(v, argp);
   616			break;
   617		case VHOST_VDPA_GET_STATUS:
   618			r = vhost_vdpa_get_status(v, argp);
   619			break;
   620		case VHOST_VDPA_SET_STATUS:
   621			r = vhost_vdpa_set_status(v, argp);
   622			break;
   623		case VHOST_VDPA_GET_CONFIG:
   624			r = vhost_vdpa_get_config(v, argp);
   625			break;
   626		case VHOST_VDPA_SET_CONFIG:
   627			r = vhost_vdpa_set_config(v, argp);
   628			break;
   629		case VHOST_GET_FEATURES:
   630			r = vhost_vdpa_get_features(v, argp);
   631			break;
   632		case VHOST_SET_FEATURES:
   633			r = vhost_vdpa_set_features(v, argp);
   634			break;
   635		case VHOST_VDPA_GET_VRING_NUM:
   636			r = vhost_vdpa_get_vring_num(v, argp);
   637			break;
   638		case VHOST_VDPA_GET_GROUP_NUM:
   639			r = copy_to_user(argp, &v->vdpa->ngroups,
   640					 sizeof(v->vdpa->ngroups));
   641			break;
   642		case VHOST_VDPA_GET_AS_NUM:
   643			r = copy_to_user(argp, &v->vdpa->nas, sizeof(v->vdpa->nas));
   644			break;
   645		case VHOST_SET_LOG_BASE:
   646		case VHOST_SET_LOG_FD:
   647			r = -ENOIOCTLCMD;
   648			break;
   649		case VHOST_VDPA_SET_CONFIG_CALL:
   650			r = vhost_vdpa_set_config_call(v, argp);
   651			break;
   652		case VHOST_GET_BACKEND_FEATURES:
   653			features = VHOST_VDPA_BACKEND_FEATURES;
   654			if (vhost_vdpa_can_stop(v))
   655				features |= BIT_ULL(VHOST_BACKEND_F_STOP);
   656			if (copy_to_user(featurep, &features, sizeof(features)))
   657				r = -EFAULT;
   658			break;
   659		case VHOST_VDPA_GET_IOVA_RANGE:
   660			r = vhost_vdpa_get_iova_range(v, argp);
   661			break;
   662		case VHOST_VDPA_GET_CONFIG_SIZE:
   663			r = vhost_vdpa_get_config_size(v, argp);
   664			break;
   665		case VHOST_VDPA_GET_VQS_COUNT:
   666			r = vhost_vdpa_get_vqs_count(v, argp);
   667			break;
 > 668		case VHOST_STOP:
   669			r = vhost_vdpa_stop(v, argp);
   670			break;
   671		default:
   672			r = vhost_dev_ioctl(&v->vdev, cmd, argp);
   673			if (r == -ENOIOCTLCMD)
   674				r = vhost_vdpa_vring_ioctl(v, cmd, argp);
   675			break;
   676		}
   677	
   678		mutex_unlock(&d->mutex);
   679		return r;
   680	}
   681	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

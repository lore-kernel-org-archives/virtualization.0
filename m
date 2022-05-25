Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28508C433FE
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 14:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0CCC842AC;
	Wed, 25 May 2022 14:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9-UU0F6Fu9b; Wed, 25 May 2022 14:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D3A784293;
	Wed, 25 May 2022 14:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE1BEC007E;
	Wed, 25 May 2022 14:33:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D52FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 14:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1626041C32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 14:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Q0ArEVeYMp2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 14:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDF0341C3F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653489183; x=1685025183;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=e8WdMPHPvUxue/jRn47cDBNn5mZvdiHoI8fDLRKx+b4=;
 b=CyK6SQSUOOhv+w5/q/jod4hDt6Ajmf+9A8l6afxC4zXPb9fXry3yFxUQ
 De6zfF+1+WljvKD1BeAyMod+trlqTFKefS7Pt/mQMIQUUg+vuACrieJec
 MNYpMG+SkMmurKtuuvGnkboa/muzvKRG5JJRz3iMcNjgev7vFTuBEOqkr
 k/YKY00bs5jlt+r76hK7Vpuo7rHA3pNn4bCxX6vgndC7IiggkKogNVpZs
 V5vShNwXiw8USJUDnP0TfVqas43fZZ7oa+FPnboHb17IYosEBF0mEqfHQ
 W9WSZYslQeaKamxn2RHuDaGPPw5VCdUrDkQ5cX5dAnjjnYYnbBrWL1Ffe Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271402794"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="271402794"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 07:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="573264216"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 25 May 2022 07:32:56 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nts4F-00034E-QU;
 Wed, 25 May 2022 14:32:55 +0000
Date: Wed, 25 May 2022 22:32:14 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 3/4] vhost-vdpa: uAPI to stop the device
Message-ID: <202205252236.4ysv1ZWg-lkp@intel.com>
References: <20220525105922.2413991-4-eperezma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525105922.2413991-4-eperezma@redhat.com>
Cc: tanuj.kamde@amd.com, Dan Carpenter <error27@gmail.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220525/202205252236.4ysv1ZWg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/515f6b6d2a0164df801ddbe61e1cb1ae4e763873
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eugenio-P-rez/Implement-vdpasim-stop-operation/20220525-190143
        git checkout 515f6b6d2a0164df801ddbe61e1cb1ae4e763873
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/vhost/vdpa.c: In function 'vhost_vdpa_unlocked_ioctl':
>> drivers/vhost/vdpa.c:668:14: error: 'VHOST_STOP' undeclared (first use in this function)
     668 |         case VHOST_STOP:
         |              ^~~~~~~~~~
   drivers/vhost/vdpa.c:668:14: note: each undeclared identifier is reported only once for each function it appears in


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

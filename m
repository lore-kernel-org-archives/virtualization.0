Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA7C4363A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 05:29:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B4520882
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 05:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 793B887268;
	Fri, 23 Oct 2020 05:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLEC0GYiTEH7; Fri, 23 Oct 2020 05:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C83FD8724F;
	Fri, 23 Oct 2020 05:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6889C0893;
	Fri, 23 Oct 2020 05:29:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02B5DC0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 05:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC3B0203AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 05:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gd6zrp9ejIOc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 05:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 591D8203A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 05:28:57 +0000 (UTC)
IronPort-SDR: lGYv7rC5ege5l/7IvN2JJiQoQZSjKnR0RJ4Ig0ycSbY2L9KZWnnoP981WOHpWARguHrFsQXiYl
 nNkHxJjXWK4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="231824525"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
 d="gz'50?scan'50,208,50";a="231824525"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2020 22:28:55 -0700
IronPort-SDR: 5Nz+6xZodUIB0neJI4FifP00M81Yq5xTzivSfAOmzxclnol2DScAYmc1srbgtRKmmlBV7GyQt1
 HoJ/f1a8B9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
 d="gz'50?scan'50,208,50";a="302654822"
Received: from lkp-server01.sh.intel.com (HELO 1f55bd7cde4b) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2020 22:28:52 -0700
Received: from kbuild by 1f55bd7cde4b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kVpdD-00004Q-Cr; Fri, 23 Oct 2020 05:28:51 +0000
Date: Fri, 23 Oct 2020 13:28:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] vhost: vdpa: report iova range
Message-ID: <202010231319.Ix8DqCWr-lkp@intel.com>
References: <20201023022454.24402-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20201023022454.24402-3-jasowang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: shahafs@mellanox.com, kbuild-all@lists.01.org, lulu@redhat.com,
 mhabets@solarflare.com, eperezma@redhat.com, hanand@xilinx.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

I love your patch! Perhaps something to improve:

[auto build test WARNING on vhost/linux-next]
[also build test WARNING on linus/master v5.9 next-20201023]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-API-for-reporting-IOVA-range/20201023-102708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: m68k-randconfig-r034-20201022 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/446e7b97838ebf87f1acd61580137716fdad104a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jason-Wang/vDPA-API-for-reporting-IOVA-range/20201023-102708
        git checkout 446e7b97838ebf87f1acd61580137716fdad104a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/vhost/vdpa.c: In function 'vhost_vdpa_setup_vq_irq':
   drivers/vhost/vdpa.c:94:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
      94 |  int ret, irq;
         |      ^~~
   drivers/vhost/vdpa.c: In function 'vhost_vdpa_unlocked_ioctl':
>> drivers/vhost/vdpa.c:483:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
     483 |   r = copy_to_user(featurep, &features, sizeof(features));
         |   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/vhost/vdpa.c:484:2: note: here
     484 |  case VHOST_VDPA_GET_IOVA_RANGE:
         |  ^~~~

vim +483 drivers/vhost/vdpa.c

4c8cf31885f69e8 Tiwei Bie    2020-03-26  426  
4c8cf31885f69e8 Tiwei Bie    2020-03-26  427  static long vhost_vdpa_unlocked_ioctl(struct file *filep,
4c8cf31885f69e8 Tiwei Bie    2020-03-26  428  				      unsigned int cmd, unsigned long arg)
4c8cf31885f69e8 Tiwei Bie    2020-03-26  429  {
4c8cf31885f69e8 Tiwei Bie    2020-03-26  430  	struct vhost_vdpa *v = filep->private_data;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  431  	struct vhost_dev *d = &v->vdev;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  432  	void __user *argp = (void __user *)arg;
a127c5bbb6a8eee Jason Wang   2020-09-07  433  	u64 __user *featurep = argp;
a127c5bbb6a8eee Jason Wang   2020-09-07  434  	u64 features;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  435  	long r;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  436  
a127c5bbb6a8eee Jason Wang   2020-09-07  437  	if (cmd == VHOST_SET_BACKEND_FEATURES) {
a127c5bbb6a8eee Jason Wang   2020-09-07  438  		r = copy_from_user(&features, featurep, sizeof(features));
a127c5bbb6a8eee Jason Wang   2020-09-07  439  		if (r)
a127c5bbb6a8eee Jason Wang   2020-09-07  440  			return r;
a127c5bbb6a8eee Jason Wang   2020-09-07  441  		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
a127c5bbb6a8eee Jason Wang   2020-09-07  442  			return -EOPNOTSUPP;
a127c5bbb6a8eee Jason Wang   2020-09-07  443  		vhost_set_backend_features(&v->vdev, features);
a127c5bbb6a8eee Jason Wang   2020-09-07  444  		return 0;
a127c5bbb6a8eee Jason Wang   2020-09-07  445  	}
a127c5bbb6a8eee Jason Wang   2020-09-07  446  
4c8cf31885f69e8 Tiwei Bie    2020-03-26  447  	mutex_lock(&d->mutex);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  448  
4c8cf31885f69e8 Tiwei Bie    2020-03-26  449  	switch (cmd) {
4c8cf31885f69e8 Tiwei Bie    2020-03-26  450  	case VHOST_VDPA_GET_DEVICE_ID:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  451  		r = vhost_vdpa_get_device_id(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  452  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  453  	case VHOST_VDPA_GET_STATUS:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  454  		r = vhost_vdpa_get_status(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  455  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  456  	case VHOST_VDPA_SET_STATUS:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  457  		r = vhost_vdpa_set_status(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  458  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  459  	case VHOST_VDPA_GET_CONFIG:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  460  		r = vhost_vdpa_get_config(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  461  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  462  	case VHOST_VDPA_SET_CONFIG:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  463  		r = vhost_vdpa_set_config(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  464  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  465  	case VHOST_GET_FEATURES:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  466  		r = vhost_vdpa_get_features(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  467  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  468  	case VHOST_SET_FEATURES:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  469  		r = vhost_vdpa_set_features(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  470  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  471  	case VHOST_VDPA_GET_VRING_NUM:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  472  		r = vhost_vdpa_get_vring_num(v, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  473  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  474  	case VHOST_SET_LOG_BASE:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  475  	case VHOST_SET_LOG_FD:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  476  		r = -ENOIOCTLCMD;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  477  		break;
776f395004d829b Zhu Lingshan 2020-06-05  478  	case VHOST_VDPA_SET_CONFIG_CALL:
776f395004d829b Zhu Lingshan 2020-06-05  479  		r = vhost_vdpa_set_config_call(v, argp);
776f395004d829b Zhu Lingshan 2020-06-05  480  		break;
a127c5bbb6a8eee Jason Wang   2020-09-07  481  	case VHOST_GET_BACKEND_FEATURES:
a127c5bbb6a8eee Jason Wang   2020-09-07  482  		features = VHOST_VDPA_BACKEND_FEATURES;
a127c5bbb6a8eee Jason Wang   2020-09-07 @483  		r = copy_to_user(featurep, &features, sizeof(features));
446e7b97838ebf8 Jason Wang   2020-10-23  484  	case VHOST_VDPA_GET_IOVA_RANGE:
446e7b97838ebf8 Jason Wang   2020-10-23  485  		r = vhost_vdpa_get_iova_range(v, argp);
a127c5bbb6a8eee Jason Wang   2020-09-07  486  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  487  	default:
4c8cf31885f69e8 Tiwei Bie    2020-03-26  488  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  489  		if (r == -ENOIOCTLCMD)
4c8cf31885f69e8 Tiwei Bie    2020-03-26  490  			r = vhost_vdpa_vring_ioctl(v, cmd, argp);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  491  		break;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  492  	}
4c8cf31885f69e8 Tiwei Bie    2020-03-26  493  
4c8cf31885f69e8 Tiwei Bie    2020-03-26  494  	mutex_unlock(&d->mutex);
4c8cf31885f69e8 Tiwei Bie    2020-03-26  495  	return r;
4c8cf31885f69e8 Tiwei Bie    2020-03-26  496  }
4c8cf31885f69e8 Tiwei Bie    2020-03-26  497  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--u3/rZRmxL6MmkK24--

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06B9C433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 11:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 924F0813A3;
	Mon,  9 May 2022 11:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VycbvLbRvUiM; Mon,  9 May 2022 11:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1078481397;
	Mon,  9 May 2022 11:27:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2594C0032;
	Mon,  9 May 2022 11:27:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58240C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 408C540124
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxJ9c1WKlIQZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:27:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15311400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652095632; x=1683631632;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ya1pIm6vZbBNzSqJeY65qthxy/T3x9Rl6SrCFaTGnYo=;
 b=myb3QhJpxgzx+LxcaMwLnV/Nhn5udFCznzJHIlrX1qzCsF93CByTCY9t
 bUzal+l6hd8EOi/Z5C8ZL9aMMms0lmUC/A4K4t9XJvthlVBckIeWl4AZv
 cBlTsYDF7LtS/Di/NB5a7GJgp7MomQisE1Bs1jsJlyO9PPThXzxPoSXHp
 7kry3hNKMnW5ovThVLRUDArsGR5A45/HaxdJr69bJ/Z1ZhZgzdRKla+xT
 peyF7VQX2ISenEQUJ5ay4DrxAcC+f63qYLnvcjUrndcA8Qa+a1gEOQLMf
 em9Xlg9Rlcng24eJU/UUuX5WSFZA3xQMMgBmH2P2bUi6iIIZD7la95AAg w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="329614566"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; d="scan'208";a="329614566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 04:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; d="scan'208";a="622923821"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 09 May 2022 04:27:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1no1Xg-000GTA-Fj;
 Mon, 09 May 2022 11:27:08 +0000
Date: Mon, 9 May 2022 19:26:31 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Do not count the pages that were already pinned
 in the vhost-vDPA
Message-ID: <202205091928.dheTGNAt-lkp@intel.com>
References: <20220509071426.155941-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220509071426.155941-1-lulu@redhat.com>
Cc: kbuild-all@lists.01.org
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

Hi Cindy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linux/master linus/master v5.18-rc6]
[cannot apply to next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vdpa-Do-not-count-the-pages-that-were-already-pinned-in-the-vhost-vDPA/20220509-152644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: s390-randconfig-r044-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091928.dheTGNAt-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4225cc2a756b75d1e0ff7ca2a593bada42def380
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cindy-Lu/vdpa-Do-not-count-the-pages-that-were-already-pinned-in-the-vhost-vDPA/20220509-152644
        git checkout 4225cc2a756b75d1e0ff7ca2a593bada42def380
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vhost/vdpa.c:542:5: warning: no previous prototype for 'vhost_vdpa_add_range_ctx' [-Wmissing-prototypes]
     542 | int vhost_vdpa_add_range_ctx(struct rb_root_cached *root, u64 start, u64 last)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/vhost/vdpa.c:571:6: warning: no previous prototype for 'vhost_vdpa_del_range' [-Wmissing-prototypes]
     571 | void vhost_vdpa_del_range(struct rb_root_cached *root, u64 start, u64 last)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/vhost/vdpa.c:581:28: warning: no previous prototype for 'vhost_vdpa_search_range' [-Wmissing-prototypes]
     581 | struct interval_tree_node *vhost_vdpa_search_range(struct rb_root_cached *root,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/vhost_vdpa_add_range_ctx +542 drivers/vhost/vdpa.c

   464	
   465	static long vhost_vdpa_unlocked_ioctl(struct file *filep,
   466					      unsigned int cmd, unsigned long arg)
   467	{
   468		struct vhost_vdpa *v = filep->private_data;
   469		struct vhost_dev *d = &v->vdev;
   470		void __user *argp = (void __user *)arg;
   471		u64 __user *featurep = argp;
   472		u64 features;
   473		long r = 0;
   474	
   475		if (cmd == VHOST_SET_BACKEND_FEATURES) {
   476			if (copy_from_user(&features, featurep, sizeof(features)))
   477				return -EFAULT;
   478			if (features & ~VHOST_VDPA_BACKEND_FEATURES)
   479				return -EOPNOTSUPP;
   480			vhost_set_backend_features(&v->vdev, features);
   481			return 0;
   482		}
   483	
   484		mutex_lock(&d->mutex);
   485	
   486		switch (cmd) {
   487		case VHOST_VDPA_GET_DEVICE_ID:
   488			r = vhost_vdpa_get_device_id(v, argp);
   489			break;
   490		case VHOST_VDPA_GET_STATUS:
   491			r = vhost_vdpa_get_status(v, argp);
   492			break;
   493		case VHOST_VDPA_SET_STATUS:
   494			r = vhost_vdpa_set_status(v, argp);
   495			break;
   496		case VHOST_VDPA_GET_CONFIG:
   497			r = vhost_vdpa_get_config(v, argp);
   498			break;
   499		case VHOST_VDPA_SET_CONFIG:
   500			r = vhost_vdpa_set_config(v, argp);
   501			break;
   502		case VHOST_GET_FEATURES:
   503			r = vhost_vdpa_get_features(v, argp);
   504			break;
   505		case VHOST_SET_FEATURES:
   506			r = vhost_vdpa_set_features(v, argp);
   507			break;
   508		case VHOST_VDPA_GET_VRING_NUM:
   509			r = vhost_vdpa_get_vring_num(v, argp);
   510			break;
   511		case VHOST_SET_LOG_BASE:
   512		case VHOST_SET_LOG_FD:
   513			r = -ENOIOCTLCMD;
   514			break;
   515		case VHOST_VDPA_SET_CONFIG_CALL:
   516			r = vhost_vdpa_set_config_call(v, argp);
   517			break;
   518		case VHOST_GET_BACKEND_FEATURES:
   519			features = VHOST_VDPA_BACKEND_FEATURES;
   520			if (copy_to_user(featurep, &features, sizeof(features)))
   521				r = -EFAULT;
   522			break;
   523		case VHOST_VDPA_GET_IOVA_RANGE:
   524			r = vhost_vdpa_get_iova_range(v, argp);
   525			break;
   526		case VHOST_VDPA_GET_CONFIG_SIZE:
   527			r = vhost_vdpa_get_config_size(v, argp);
   528			break;
   529		case VHOST_VDPA_GET_VQS_COUNT:
   530			r = vhost_vdpa_get_vqs_count(v, argp);
   531			break;
   532		default:
   533			r = vhost_dev_ioctl(&v->vdev, cmd, argp);
   534			if (r == -ENOIOCTLCMD)
   535				r = vhost_vdpa_vring_ioctl(v, cmd, argp);
   536			break;
   537		}
   538	
   539		mutex_unlock(&d->mutex);
   540		return r;
   541	}
 > 542	int vhost_vdpa_add_range_ctx(struct rb_root_cached *root, u64 start, u64 last)
   543	{
   544		struct interval_tree_node *new_node;
   545	
   546		if (last < start)
   547			return -EFAULT;
   548	
   549		/* If the range being mapped is [0, ULONG_MAX], split it into two entries
   550		 * otherwise its size would overflow u64.
   551		 */
   552		if (start == 0 && last == ULONG_MAX) {
   553			u64 mid = last / 2;
   554	
   555			vhost_vdpa_add_range_ctx(root, start, mid);
   556			start = mid + 1;
   557		}
   558	
   559		new_node = kmalloc(sizeof(struct interval_tree_node), GFP_ATOMIC);
   560		if (!new_node)
   561			return -ENOMEM;
   562	
   563		new_node->start = start;
   564		new_node->last = last;
   565	
   566		interval_tree_insert(new_node, root);
   567	
   568		return 0;
   569	}
   570	
 > 571	void vhost_vdpa_del_range(struct rb_root_cached *root, u64 start, u64 last)
   572	{
   573		struct interval_tree_node *new_node;
   574	
   575		while ((new_node = interval_tree_iter_first(root, start, last))) {
   576			interval_tree_remove(new_node, root);
   577			kfree(new_node);
   578		}
   579	}
   580	
 > 581	struct interval_tree_node *vhost_vdpa_search_range(struct rb_root_cached *root,
   582							   u64 start, u64 last)
   583	{
   584		return interval_tree_iter_first(root, start, last);
   585	}
   586	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

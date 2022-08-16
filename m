Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57426C00140
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 03:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7B30409BC;
	Tue, 16 Aug 2022 03:28:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7B30409BC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZKe3+olz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1twhzxjnuh-0; Tue, 16 Aug 2022 03:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDFD7408C1;
	Tue, 16 Aug 2022 03:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDFD7408C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC4FDC0033;
	Tue, 16 Aug 2022 03:28:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90413C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56ADA40951
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56ADA40951
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W8s0ZbrVwLwE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D7F7408C1
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D7F7408C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660620526; x=1692156526;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=G9FMxJUX6IlQCpmWkMAAX8sP79y8pf8oC3P46/tdATk=;
 b=ZKe3+olznIMrmFRuJ3c2L+k0G+uFrhhxOWbxMH4dWufXUoucAx3Af0YB
 0ifkH9QvbNWMhHX2LhSIB4pZfi+Tx94gXG+fxF52Wji8erzexRRjMu7oq
 dZkl+DWCrdz4mNdFOOEZCOZcG1uBFL52Sim2KOdkrtUTRppTSzlPyKSNr
 1M9YRT8tsIdqDiLeVoUZRIq/okzJ/CGon++tIBEbqXuu4dvk9juZZhBNu
 TO9dkLYMHNIZKMIOerqWn10u4ZVbwWPYWuieeusxyqDtSPD0aic+Z3JGP
 I11tDpSrlPwqKucMDHKPxMWXw0aecVDsyERbPPxEKSI8NkENd7+2gpqVw A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="353857711"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="353857711"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 20:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; d="scan'208";a="583132287"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 20:28:44 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oNnFz-0001P2-1L;
 Tue, 16 Aug 2022 03:28:43 +0000
Date: Tue, 16 Aug 2022 11:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [mst-vhost:vhost 5/8] drivers/virtio/virtio_vdpa.c:291:61: error:
 'sizes' undeclared
Message-ID: <202208161151.sMYdFPvS-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kbuild-all@lists.01.org, kvm@vger.kernel.org,
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   43ab8a34f3f0c7301813343b9fed2da33c37754a
commit: 71545b3c933acbf165e6596d5cfa4fd15e1ef543 [5/8] virtio: Revert "virtio: find_vqs() add arg sizes"
config: i386-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161151.sMYdFPvS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=71545b3c933acbf165e6596d5cfa4fd15e1ef543
        git remote add mst-vhost https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
        git fetch --no-tags mst-vhost vhost
        git checkout 71545b3c933acbf165e6596d5cfa4fd15e1ef543
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_vdpa.c: In function 'virtio_vdpa_find_vqs':
>> drivers/virtio/virtio_vdpa.c:291:61: error: 'sizes' undeclared (first use in this function)
     291 |                                                   names[i], sizes ? sizes[i] : 0,
         |                                                             ^~~~~
   drivers/virtio/virtio_vdpa.c:291:61: note: each undeclared identifier is reported only once for each function it appears in


vim +/sizes +291 drivers/virtio/virtio_vdpa.c

c043b4a8cf3b16 Jason Wang  2020-03-26  270  
3153234097f6a0 Solomon Tan 2022-04-18  271  static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
c043b4a8cf3b16 Jason Wang  2020-03-26  272  				struct virtqueue *vqs[],
c043b4a8cf3b16 Jason Wang  2020-03-26  273  				vq_callback_t *callbacks[],
c043b4a8cf3b16 Jason Wang  2020-03-26  274  				const char * const names[],
c043b4a8cf3b16 Jason Wang  2020-03-26  275  				const bool *ctx,
c043b4a8cf3b16 Jason Wang  2020-03-26  276  				struct irq_affinity *desc)
c043b4a8cf3b16 Jason Wang  2020-03-26  277  {
c043b4a8cf3b16 Jason Wang  2020-03-26  278  	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
c043b4a8cf3b16 Jason Wang  2020-03-26  279  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
c043b4a8cf3b16 Jason Wang  2020-03-26  280  	const struct vdpa_config_ops *ops = vdpa->config;
c043b4a8cf3b16 Jason Wang  2020-03-26  281  	struct vdpa_callback cb;
c043b4a8cf3b16 Jason Wang  2020-03-26  282  	int i, err, queue_idx = 0;
c043b4a8cf3b16 Jason Wang  2020-03-26  283  
c043b4a8cf3b16 Jason Wang  2020-03-26  284  	for (i = 0; i < nvqs; ++i) {
c043b4a8cf3b16 Jason Wang  2020-03-26  285  		if (!names[i]) {
c043b4a8cf3b16 Jason Wang  2020-03-26  286  			vqs[i] = NULL;
c043b4a8cf3b16 Jason Wang  2020-03-26  287  			continue;
c043b4a8cf3b16 Jason Wang  2020-03-26  288  		}
c043b4a8cf3b16 Jason Wang  2020-03-26  289  
99e8927d8a4da8 Bo Liu      2022-08-10  290  		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, callbacks[i],
99e8927d8a4da8 Bo Liu      2022-08-10 @291  						  names[i], sizes ? sizes[i] : 0,
99e8927d8a4da8 Bo Liu      2022-08-10  292  						  ctx ? ctx[i] : false);
c043b4a8cf3b16 Jason Wang  2020-03-26  293  		if (IS_ERR(vqs[i])) {
c043b4a8cf3b16 Jason Wang  2020-03-26  294  			err = PTR_ERR(vqs[i]);
c043b4a8cf3b16 Jason Wang  2020-03-26  295  			goto err_setup_vq;
c043b4a8cf3b16 Jason Wang  2020-03-26  296  		}
c043b4a8cf3b16 Jason Wang  2020-03-26  297  	}
c043b4a8cf3b16 Jason Wang  2020-03-26  298  
c043b4a8cf3b16 Jason Wang  2020-03-26  299  	cb.callback = virtio_vdpa_config_cb;
c043b4a8cf3b16 Jason Wang  2020-03-26  300  	cb.private = vd_dev;
c043b4a8cf3b16 Jason Wang  2020-03-26  301  	ops->set_config_cb(vdpa, &cb);
c043b4a8cf3b16 Jason Wang  2020-03-26  302  
c043b4a8cf3b16 Jason Wang  2020-03-26  303  	return 0;
c043b4a8cf3b16 Jason Wang  2020-03-26  304  
c043b4a8cf3b16 Jason Wang  2020-03-26  305  err_setup_vq:
c043b4a8cf3b16 Jason Wang  2020-03-26  306  	virtio_vdpa_del_vqs(vdev);
c043b4a8cf3b16 Jason Wang  2020-03-26  307  	return err;
c043b4a8cf3b16 Jason Wang  2020-03-26  308  }
c043b4a8cf3b16 Jason Wang  2020-03-26  309  

:::::: The code at line 291 was first introduced by commit
:::::: 99e8927d8a4da8eb8a8a5904dc13a3156be8e7c0 virtio_vdpa: support the arg sizes of find_vqs()

:::::: TO: Bo Liu <liubo03@inspur.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

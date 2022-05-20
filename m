Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA91C433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 14:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFE70845E5;
	Fri, 20 May 2022 14:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9mN8WWznaYH; Fri, 20 May 2022 14:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30155845A3;
	Fri, 20 May 2022 14:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB30DC0039;
	Fri, 20 May 2022 14:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3839DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18E27424F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQnuTMdSbOGP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A012D4197E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653055970; x=1684591970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iKY8F/VX/plDWOJFSr49vGSKgylKvy8RoB+nml/xJLw=;
 b=hsLNPaQwHsqqIYLTACpOvM0tMGPTihJR6J5597o1glyyubgfnSHVJuOy
 NbFDN1bY5gpQ6DNkNy6S+wZ6utQ37s8FY9m8NkHOscUff+FHOxPK3TGCX
 oq6lFtgFBO7o2txiuY5wgdaOX93jYaDyqzPzdxkO+rGBz6I0pF08qi+3Q
 k/Ln74eouNRLa/BOEky/VvPXItVkPjW32eEGiM+H3whZf5w7nTHtP0/X4
 2PxOoE/rfg4PScmqqHye4Fk+PTON5Di3kLYwGj8A5i3qtor4vz9qogloW
 w1VG8qj1QeuCeH9E8GjSOh8Gzj3tOIkpplX3JVdeV4Y9BkaM8TrVcYFUR A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333242371"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="333242371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 07:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="628173499"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 20 May 2022 07:12:47 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ns3N0-0004mA-Qu;
 Fri, 20 May 2022 14:12:46 +0000
Date: Fri, 20 May 2022 22:12:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH] virtio_ring: remove unused variable in virtqueue_add()
Message-ID: <202205202236.ztzLWFZ4-lkp@intel.com>
References: <20220520070740.7151-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520070740.7151-1-liubo03@inspur.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Bo Liu <liubo03@inspur.com>, virtualization@lists.linux-foundation.org
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

Hi Bo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc7 next-20220519]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/virtio_ring-remove-unused-variable-in-virtqueue_add/20220520-161845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3d7285a335edaf23b699e87c528cf0b0070e3293
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220520/202205202236.ztzLWFZ4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8344061823a47f3245d81db45f5898d940ac488e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bo-Liu/virtio_ring-remove-unused-variable-in-virtqueue_add/20220520-161845
        git checkout 8344061823a47f3245d81db45f5898d940ac488e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_ring.c: In function 'virtqueue_add':
>> drivers/virtio/virtio_ring.c:1785:16: error: 'vq' undeclared (first use in this function); did you mean '_vq'?
    1785 |         return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
         |                ^~
         |                _vq
   drivers/virtio/virtio_ring.c:1785:16: note: each undeclared identifier is reported only once for each function it appears in
   drivers/virtio/virtio_ring.c:1789:1: error: control reaches end of non-void function [-Werror=return-type]
    1789 | }
         | ^
   cc1: some warnings being treated as errors


vim +1785 drivers/virtio/virtio_ring.c

1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1770  
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1771  
e6f633e5beab65 Tiwei Bie 2018-11-21  1772  /*
e6f633e5beab65 Tiwei Bie 2018-11-21  1773   * Generic functions and exported symbols.
e6f633e5beab65 Tiwei Bie 2018-11-21  1774   */
e6f633e5beab65 Tiwei Bie 2018-11-21  1775  
e6f633e5beab65 Tiwei Bie 2018-11-21  1776  static inline int virtqueue_add(struct virtqueue *_vq,
e6f633e5beab65 Tiwei Bie 2018-11-21  1777  				struct scatterlist *sgs[],
e6f633e5beab65 Tiwei Bie 2018-11-21  1778  				unsigned int total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1779  				unsigned int out_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1780  				unsigned int in_sgs,
e6f633e5beab65 Tiwei Bie 2018-11-21  1781  				void *data,
e6f633e5beab65 Tiwei Bie 2018-11-21  1782  				void *ctx,
e6f633e5beab65 Tiwei Bie 2018-11-21  1783  				gfp_t gfp)
e6f633e5beab65 Tiwei Bie 2018-11-21  1784  {
1ce9e6055fa0a9 Tiwei Bie 2018-11-21 @1785  	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1786  					out_sgs, in_sgs, data, ctx, gfp) :
1ce9e6055fa0a9 Tiwei Bie 2018-11-21  1787  				 virtqueue_add_split(_vq, sgs, total_sg,
e6f633e5beab65 Tiwei Bie 2018-11-21  1788  					out_sgs, in_sgs, data, ctx, gfp);
e6f633e5beab65 Tiwei Bie 2018-11-21  1789  }
e6f633e5beab65 Tiwei Bie 2018-11-21  1790  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

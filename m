Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585314A601;
	Thu, 11 Jul 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704271; cv=none; b=Ez/zWOzKNxwGr9lj/mM2MjPUX+NUl2TnG1mz1Ts4Q8p8dZPj4EXj5BAD9qtrT+b73h5n9+aoznr2+J526YljZePZvjdgECg6N0OYa0Qq8bW3oJiGP2f/Stf1QF2MiCTywx4rQJR+AFWwi/mIdthcUUAnJJ53YW/R2dL/NPg5WTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704271; c=relaxed/simple;
	bh=KAnGBHpCxcNlVVtwdfdNAWR48fJas1MfIdvTMUQRyEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsZ+ePkpU51UZ6PjXp/m6Y7JULvl6FFEtumI79MIReBjgylGMslhUEr16XfYLbZDUSPawacyp9lJ8K8QdDbIItjSnYnsqHz+xs2Y3PnvbFupalcBtToFxB5UUi1w+zAYBtYBbm5ewDy+EgiyfpcQbrOhasgQ4nGgbhkMj2fuEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haSB2/xE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haSB2/xE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720704269; x=1752240269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAnGBHpCxcNlVVtwdfdNAWR48fJas1MfIdvTMUQRyEU=;
  b=haSB2/xEW7znONVEKYqXH77iAxJymTjFNu/wpSuM8bH5oCwop85fdHBR
   8QiSSC+E72M80+5hJz5NaOiwdcplrKFcFC4v6/KQZx0jawBRoh3HaU9V7
   uoN7Joym8p8xfmMyKdSK5hsK6od/sG8Y0cif0wRO23CSz90f8639lccSm
   8Gm4V47Djy+yIDJ1p3aMZyX3A4H63FpCyrgKDCuo5FhNNOvssmLr8Hh74
   ecGVH2nk1cVXj4ZloNexOCy1L31Y8yDZL5qo8ZkOzeBunHx/eHINl1Br2
   GTSC5nVUcaf/MbR0wJw9EGVX7SBjschxOBZmwqzh7ETl44kf/QORFI9Z8
   g==;
X-CSE-ConnectionGUID: fouj+wqvSGqs12Bx0t0s9Q==
X-CSE-MsgGUID: WI64HkRTT5C2RT9eECG3Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18027818"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18027818"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:24:29 -0700
X-CSE-ConnectionGUID: pEL7xV6+SeaKGCCdyc7XKQ==
X-CSE-MsgGUID: Bzn3bDKVSPeVyTDsl7qAwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53733484"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Jul 2024 06:24:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRtmZ-000ZJu-2d;
	Thu, 11 Jul 2024 13:24:23 +0000
Date: Thu, 11 Jul 2024 21:23:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] virtio_balloon: add work around for out of spec
 QEMU
Message-ID: <202407112126.plGUWi8I-lkp@intel.com>
References: <19d916257b76148f89de7386389eeb7267b1b61c.1720611677.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d916257b76148f89de7386389eeb7267b1b61c.1720611677.git.mst@redhat.com>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240710]
[cannot apply to uml/next remoteproc/rproc-next s390/features linus/master uml/fixes v6.10-rc7 v6.10-rc6 v6.10-rc5 v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-S-Tsirkin/virtio_balloon-add-work-around-for-out-of-spec-QEMU/20240711-004346
base:   next-20240710
patch link:    https://lore.kernel.org/r/19d916257b76148f89de7386389eeb7267b1b61c.1720611677.git.mst%40redhat.com
patch subject: [PATCH v2 1/2] virtio_balloon: add work around for out of spec QEMU
config: i386-randconfig-005-20240711 (https://download.01.org/0day-ci/archive/20240711/202407112126.plGUWi8I-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407112126.plGUWi8I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407112126.plGUWi8I-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_balloon.c:603:55: error: too few arguments to function call, expected 5, have 4
     602 |                         err = virtio_find_vqs(vb->vdev,
         |                               ~~~~~~~~~~~~~~~
     603 |                                               VIRTIO_BALLOON_VQ_REPORTING, vqs_info, NULL);
         |                                                                                          ^
   include/linux/virtio_config.h:225:5: note: 'virtio_find_vqs' declared here
     225 | int virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
         |     ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     226 |                     struct virtqueue *vqs[],
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~
     227 |                     struct virtqueue_info vqs_info[],
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     228 |                     struct irq_affinity *desc)
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +603 drivers/virtio/virtio_balloon.c

   560	
   561	static int init_vqs(struct virtio_balloon *vb)
   562	{
   563		struct virtqueue_info vqs_info[VIRTIO_BALLOON_VQ_MAX] = {};
   564		struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
   565		int err;
   566	
   567		/*
   568		 * Inflateq and deflateq are used unconditionally. The names[]
   569		 * will be NULL if the related feature is not enabled, which will
   570		 * cause no allocation for the corresponding virtqueue in find_vqs.
   571		 */
   572		vqs_info[VIRTIO_BALLOON_VQ_INFLATE].callback = balloon_ack;
   573		vqs_info[VIRTIO_BALLOON_VQ_INFLATE].name = "inflate";
   574		vqs_info[VIRTIO_BALLOON_VQ_DEFLATE].callback = balloon_ack;
   575		vqs_info[VIRTIO_BALLOON_VQ_DEFLATE].name = "deflate";
   576	
   577		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
   578			vqs_info[VIRTIO_BALLOON_VQ_STATS].name = "stats";
   579			vqs_info[VIRTIO_BALLOON_VQ_STATS].callback = stats_request;
   580		}
   581	
   582		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
   583			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
   584	
   585		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
   586			vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
   587			vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
   588		}
   589	
   590		err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
   591				      vqs_info, NULL);
   592		if (err) {
   593			/*
   594			 * Try to work around QEMU bug which since 2020 confused vq numbers
   595			 * when VIRTIO_BALLOON_F_REPORTING but not
   596			 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
   597			 */
   598			if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
   599			    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
   600				vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "reporting_vq";
   601				vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].callback = balloon_ack;
   602				err = virtio_find_vqs(vb->vdev,
 > 603						      VIRTIO_BALLOON_VQ_REPORTING, vqs_info, NULL);
   604			}
   605	
   606			if (err)
   607				return err;
   608		}
   609	
   610		vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
   611		vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
   612		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
   613			struct scatterlist sg;
   614			unsigned int num_stats;
   615			vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
   616	
   617			/*
   618			 * Prime this virtqueue with one buffer so the hypervisor can
   619			 * use it to signal us later (it can't be broken yet!).
   620			 */
   621			num_stats = update_balloon_stats(vb);
   622	
   623			sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
   624			err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
   625						   GFP_KERNEL);
   626			if (err) {
   627				dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
   628					 __func__);
   629				return err;
   630			}
   631			virtqueue_kick(vb->stats_vq);
   632		}
   633	
   634		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
   635			vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
   636	
   637		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
   638			vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
   639	
   640		return 0;
   641	}
   642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

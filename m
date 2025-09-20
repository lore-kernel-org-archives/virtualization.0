Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DAB663
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Sep 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379761; cv=none; b=knQj8tDNxSOCbWc1W4fQYyIdwS4/UOv/6TUC1AeXNiLiE3vBXG6z3yrLg6+hijGURVSFavu137pfnpZzCdnm0ylM9Ikz0+1U1Fz1mOmfnjrL12EyBV3qK0ZQGY/CkwlhFi104owO+JmUx5DfrRF0GuCY0Lj2cMluuRwoieXvD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379761; c=relaxed/simple;
	bh=8ESeYby+VBnGxoL4sKU6AzMNuckA9rBZYz1Tl2yfc9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LczDz63ePEy8iAdw5nDo3QxWvj7f28245lnvw+h35RzzpEhEG3s4qJKxQgYnNDCDLzhWTRHIRJXZNB5htngqOdBVsvgTPSO3Sj1xIezVq/FVG7pf1MGrmzFwijFsHtAvpQbgpGikTvr8+c6sajl5aJqYzT+aYwki8oCFzzvAujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq+uTdl4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq+uTdl4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96F6B415F1
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Sep 2025 14:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gj-cTOGxbRy for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Sep 2025 14:49:18 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 20 Sep 2025 14:49:18 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 65312415E0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65312415E0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fq+uTdl4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65312415E0
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Sep 2025 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758379759; x=1789915759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ESeYby+VBnGxoL4sKU6AzMNuckA9rBZYz1Tl2yfc9U=;
  b=fq+uTdl44n7nzaHiVscH1fIvctDam6CGNP+d1rrGhkRa6eG1KOqN8/nm
   88dW6Rf4iUuLQ/qP5xWrHb+GnLLqvVhUf2kCDYDmLt2gVoeH8bkD9yZvm
   P3UKFBAtdEc4O8j9IT4xtpnGzkPhvyhTwSRZXyy/ehMP6+W+hOgRD9e5c
   kMC27OqEwobk4gMo3j2ND29aF2CjKWtYFtMMsR6WQizeFgDzDBkzSVEuO
   7mc2Dgrlfvop+wSBQDXGgasdImHF9Zra6dMOOnyEA1iHDquWWgwzKTHs1
   CAg6fEBskNrEoG20XYdOlhFzUT03c2g6B6tC/bE4n7uLRHSVvT1mrd93I
   Q==;
X-CSE-ConnectionGUID: j11KjpjHQ0GYOZSTQrMQSg==
X-CSE-MsgGUID: Cpz667FmRkGdB2uyv0EtAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60645900"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60645900"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 07:42:10 -0700
X-CSE-ConnectionGUID: oLTEyd53SQGIys1VP2VHIA==
X-CSE-MsgGUID: 8S919d3NRSSML7Z5SxHNpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="206832999"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Sep 2025 07:42:08 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzymq-0005O7-15;
	Sat, 20 Sep 2025 14:42:04 +0000
Date: Sat, 20 Sep 2025 22:41:40 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [mst-vhost:vhost 41/44] drivers/vdpa/pds/vdpa_dev.c:590:19: error:
 incompatible function pointer types initializing 's64 (*)(struct vdpa_device
 *, u16)' (aka 'long long (*)(struct vdpa_device *, unsigned short)') with an
 expression of type 'u32 (struct vdpa_device *, u16)' (aka ...
Message-ID: <202509202256.zVt4MifB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   877102ca14b3ee9b5343d71f6420f036baf8a9fc
commit: 2951c77700c3944ecd991ede7ee77e31f47f24ab [41/44] vduse: add vq group support
config: loongarch-randconfig-001-20250920 (https://download.01.org/0day-ci/archive/20250920/202509202256.zVt4MifB-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509202256.zVt4MifB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509202256.zVt4MifB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vdpa/pds/vdpa_dev.c:590:19: error: incompatible function pointer types initializing 's64 (*)(struct vdpa_device *, u16)' (aka 'long long (*)(struct vdpa_device *, unsigned short)') with an expression of type 'u32 (struct vdpa_device *, u16)' (aka 'unsigned int (struct vdpa_device *, unsigned short)') [-Wincompatible-function-pointer-types]
     590 |         .get_vq_group           = pds_vdpa_get_vq_group,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +590 drivers/vdpa/pds/vdpa_dev.c

151cc834f3ddafe Shannon Nelson 2023-05-19  577  
151cc834f3ddafe Shannon Nelson 2023-05-19  578  static const struct vdpa_config_ops pds_vdpa_ops = {
151cc834f3ddafe Shannon Nelson 2023-05-19  579  	.set_vq_address		= pds_vdpa_set_vq_address,
151cc834f3ddafe Shannon Nelson 2023-05-19  580  	.set_vq_num		= pds_vdpa_set_vq_num,
151cc834f3ddafe Shannon Nelson 2023-05-19  581  	.kick_vq		= pds_vdpa_kick_vq,
151cc834f3ddafe Shannon Nelson 2023-05-19  582  	.set_vq_cb		= pds_vdpa_set_vq_cb,
151cc834f3ddafe Shannon Nelson 2023-05-19  583  	.set_vq_ready		= pds_vdpa_set_vq_ready,
151cc834f3ddafe Shannon Nelson 2023-05-19  584  	.get_vq_ready		= pds_vdpa_get_vq_ready,
151cc834f3ddafe Shannon Nelson 2023-05-19  585  	.set_vq_state		= pds_vdpa_set_vq_state,
151cc834f3ddafe Shannon Nelson 2023-05-19  586  	.get_vq_state		= pds_vdpa_get_vq_state,
151cc834f3ddafe Shannon Nelson 2023-05-19  587  	.get_vq_notification	= pds_vdpa_get_vq_notification,
151cc834f3ddafe Shannon Nelson 2023-05-19  588  	.get_vq_irq		= pds_vdpa_get_vq_irq,
151cc834f3ddafe Shannon Nelson 2023-05-19  589  	.get_vq_align		= pds_vdpa_get_vq_align,
151cc834f3ddafe Shannon Nelson 2023-05-19 @590  	.get_vq_group		= pds_vdpa_get_vq_group,
151cc834f3ddafe Shannon Nelson 2023-05-19  591  
151cc834f3ddafe Shannon Nelson 2023-05-19  592  	.get_device_features	= pds_vdpa_get_device_features,
151cc834f3ddafe Shannon Nelson 2023-05-19  593  	.set_driver_features	= pds_vdpa_set_driver_features,
151cc834f3ddafe Shannon Nelson 2023-05-19  594  	.get_driver_features	= pds_vdpa_get_driver_features,
151cc834f3ddafe Shannon Nelson 2023-05-19  595  	.set_config_cb		= pds_vdpa_set_config_cb,
151cc834f3ddafe Shannon Nelson 2023-05-19  596  	.get_vq_num_max		= pds_vdpa_get_vq_num_max,
151cc834f3ddafe Shannon Nelson 2023-05-19  597  	.get_device_id		= pds_vdpa_get_device_id,
151cc834f3ddafe Shannon Nelson 2023-05-19  598  	.get_vendor_id		= pds_vdpa_get_vendor_id,
151cc834f3ddafe Shannon Nelson 2023-05-19  599  	.get_status		= pds_vdpa_get_status,
151cc834f3ddafe Shannon Nelson 2023-05-19  600  	.set_status		= pds_vdpa_set_status,
151cc834f3ddafe Shannon Nelson 2023-05-19  601  	.reset			= pds_vdpa_reset,
151cc834f3ddafe Shannon Nelson 2023-05-19  602  	.get_config_size	= pds_vdpa_get_config_size,
151cc834f3ddafe Shannon Nelson 2023-05-19  603  	.get_config		= pds_vdpa_get_config,
151cc834f3ddafe Shannon Nelson 2023-05-19  604  	.set_config		= pds_vdpa_set_config,
151cc834f3ddafe Shannon Nelson 2023-05-19  605  };
25d1270b6e9ea89 Shannon Nelson 2023-05-19  606  static struct virtio_device_id pds_vdpa_id_table[] = {
25d1270b6e9ea89 Shannon Nelson 2023-05-19  607  	{VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
25d1270b6e9ea89 Shannon Nelson 2023-05-19  608  	{0},
25d1270b6e9ea89 Shannon Nelson 2023-05-19  609  };
25d1270b6e9ea89 Shannon Nelson 2023-05-19  610  

:::::: The code at line 590 was first introduced by commit
:::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces

:::::: TO: Shannon Nelson <shannon.nelson@amd.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

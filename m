Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937E26656D
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678200; cv=none; b=tEnxNRT4jALvIywONAGasFsOSiMya3+ZlTbD8HjdyNcVquLBZRe9o7gjBObnPGp+MparDdTquChn9yh4LxroAI/b4boZLU9gzqLrVH3rSZbTA/2ID7U2MsxsyxN3dlaARn4AYBjnHT5qbuOPopcTZ1TEoOT/M5RWaBVkHgwTcYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678200; c=relaxed/simple;
	bh=Ujm3qC0orBzqYk5UGsJndf74AenQ037h15KGkkJwDGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rCMyLLXnc1hVaU03WIviIE00lr/SiYFFKQ8vFroYFKoPLrMKlLwPBmDv7gBInV3CmOrQV71H1iUuMGbxlqqwUK7nt9Ep7UY1EmlpL2sjPWovEzkHKU2547FCLCy8Hb59nJNmJDNMc+5Ibq+lRxN1Kdyxa0bejDH9iwtrAURIeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPUgYP57; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPUgYP57"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2965B60B34
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 18:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_EZc7D2WwWb for <virtualization@lists.linux-foundation.org>;
 Mon, 19 May 2025 18:09:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4F72C607DE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F72C607DE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MPUgYP57
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F72C607DE
	for <virtualization@lists.linux-foundation.org>; Mon, 19 May 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747678198; x=1779214198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ujm3qC0orBzqYk5UGsJndf74AenQ037h15KGkkJwDGg=;
  b=MPUgYP57FX+NhVkguIAL6X5HW1twSE0Bx0U2IUpXBxkZnRjVmP1PA4CC
   duRxrpoSDzBpvncjmmAnW3z2eNXyZeI36BM9ooxHnbYUng1bIA6bP/cx/
   gccj0hygeWcpzevG1UnXxQ1otcvtUcSIDz20Tz1XBsd8YLB1cwup3fDSB
   k/tK9CF/JxDG081YpIG6CG42xmTunAFq/TMrHRlnq7Ck0Y1TLhldKR6Dp
   nPWRMEMceJxp0WHHFdVG6pEKtFLY1bByGdh+NlfCtsPm231ueVvAw9Akn
   2Z+wT2lRyRk779DUOVuXbnK0sO5+3Odlz1kFfNp6nKhrYsoyy5B7gCrJm
   g==;
X-CSE-ConnectionGUID: N3T+pSX8SVmFYLTEs7kvJg==
X-CSE-MsgGUID: dA99I0QsQK6Fvlq1L+Rvqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49727480"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49727480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 11:09:57 -0700
X-CSE-ConnectionGUID: tiLWmR9IROypzZN0IeVY/w==
X-CSE-MsgGUID: QUqYULJsRK+M1Mr/7+CgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="143444590"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2025 11:09:55 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH4vv-000Lko-1i;
	Mon, 19 May 2025 18:09:51 +0000
Date: Tue, 20 May 2025 02:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [mst-vhost:vhost 35/35] drivers/virtio/virtio_ring.c:1281:22:
 sparse: sparse: symbol 'split_in_order_ops' was not declared. Should it be
 static?
Message-ID: <202505200227.usDCH63W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   f640220b1e149add1dff0be2978905c5df628eaf
commit: f640220b1e149add1dff0be2978905c5df628eaf [35/35] virtio_ring: add in order support
config: arc-randconfig-r132-20250519 (https://download.01.org/0day-ci/archive/20250520/202505200227.usDCH63W-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250520/202505200227.usDCH63W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505200227.usDCH63W-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virtio/virtio_ring.c:1281:22: sparse: sparse: symbol 'split_in_order_ops' was not declared. Should it be static?
   drivers/virtio/virtio_ring.c:2510:22: sparse: sparse: symbol 'packed_ops' was not declared. Should it be static?
>> drivers/virtio/virtio_ring.c:2511:22: sparse: sparse: symbol 'packed_in_order_ops' was not declared. Should it be static?

vim +/split_in_order_ops +1281 drivers/virtio/virtio_ring.c

  1279	
> 1280	struct virtqueue_ops split_ops;
> 1281	struct virtqueue_ops split_in_order_ops;
  1282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

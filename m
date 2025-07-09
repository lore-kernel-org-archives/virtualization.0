Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA76283FD3
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Jul 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052871; cv=none; b=j4bVpZQmJAxdTRESwijIwyj2yv+4oRrUdpemVAjPhib4kvPWAgz5IEPuPBV0EOsqLb8qVBYmP9DjDAMQKklAemEKSQjPv2Fm2nvMbIz9rgZicTK8QgbqL2aLdDX2p0lrF8W+NEoFKvN43lwDKoYneMmokHOmwSO7D2I7NyPcans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052871; c=relaxed/simple;
	bh=z3x2Gt1rt8xqTtqo9CeUFY3qwCPecBK5Nelp2o0HyOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hMQYDaQS8LdTN3lsSuv8KyE/hKA48nMxeelNoRLFmDcLTAv5jW5HvXscnwJCIUEmcmFnkAjzEMQd6W5CXl2WhWyYv8BDtMjOOWDiHzJ3K5iueINA485UcmSqJodCPvADm5TQd/QZxxDTI0jxUj7jPKLMeVFF4x+hyYlnP5V9M6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFsydI11; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFsydI11"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 550524061D
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Jul 2025 09:21:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nL1NdVNHMNcY for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jul 2025 09:21:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7840140932
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7840140932
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QFsydI11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7840140932
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Jul 2025 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752052870; x=1783588870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z3x2Gt1rt8xqTtqo9CeUFY3qwCPecBK5Nelp2o0HyOg=;
  b=QFsydI118HvVgWB1Wcd93Wiq80gfIrA1plB22mEh1+hN6BvrmPSmQU8z
   Mil3AZnMV8qfRnTueTD6xMHaJoxMYQIsTNWzI7TP2XZVbHeYz2usFhWia
   MuyTlnhlNnrd8wG3+vmIN2Lxp4J7bKDIL/JLXvJ1mzkeb51ymNfAzz1xi
   3n89RjWbeoARoSqrTigHQJ8X7KiTdVEj/nwuciKPADtINu7y1nHnGVHx2
   eQ6IahRhJozBezHXyOTkI+bf7xO6YgkdXr3RW6aAwWFAZBTdCjpMLR5xu
   n3i2G8MTdgHs3fXujaxDpRiLlz3vZzZd+Psz6Il10/s1cUOScMeEQRmTF
   w==;
X-CSE-ConnectionGUID: lOfk19lRSHOq+1FKZ8Dgpw==
X-CSE-MsgGUID: m/MBl+lTSmugnTFDq6IADQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76853901"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76853901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:21:09 -0700
X-CSE-ConnectionGUID: sw36Ee8kSUeQoStCO4NcvQ==
X-CSE-MsgGUID: hW/y84lhQlyCmjDEid+m6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161374562"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Jul 2025 02:21:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZQzB-0003Ld-17;
	Wed, 09 Jul 2025 09:21:05 +0000
Date: Wed, 9 Jul 2025 17:20:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:vhost 4/8] include/linux/pci.h:2738:14: warning: implicit
 declaration of function 'pci_device_is_present'; did you mean
 'pci_dev_present'?
Message-ID: <202507091726.qKSmDnk7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   97d5f469f45a2312a124376fd6fa368ef8419dff
commit: b7468115b6045e555aa8a8f2fa327c1c073fc6df [4/8] pci: report surprise removal event
config: x86_64-buildonly-randconfig-004-20250709 (https://download.01.org/0day-ci/archive/20250709/202507091726.qKSmDnk7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091726.qKSmDnk7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091726.qKSmDnk7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/efi/libstub/pci.c:10:
   include/linux/pci.h: In function 'pci_set_disconnect_work':
>> include/linux/pci.h:2738:14: warning: implicit declaration of function 'pci_device_is_present'; did you mean 'pci_dev_present'? [-Wimplicit-function-declaration]
    2738 |         if (!pci_device_is_present(pdev))
         |              ^~~~~~~~~~~~~~~~~~~~~
         |              pci_dev_present


vim +2738 include/linux/pci.h

  2722	
  2723	/*
  2724	 * Caller must initialize @pdev->disconnect_work before invoking this.
  2725	 * The work function must run and check pci_test_and_clear_disconnect_enable.
  2726	 * Note that device can go away right after this call.
  2727	 */
  2728	static inline void pci_set_disconnect_work(struct pci_dev *pdev)
  2729	{
  2730		/* Make sure WQ has been initialized already */
  2731		smp_wmb();
  2732	
  2733		WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
  2734	
  2735		/* check the device did not go away meanwhile. */
  2736		mb();
  2737	
> 2738		if (!pci_device_is_present(pdev))
  2739			schedule_work(&pdev->disconnect_work);
  2740	}
  2741	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

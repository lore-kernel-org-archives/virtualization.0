Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D710A1A;
	Tue, 21 May 2024 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259354; cv=none; b=P9gavRuOkbMfhtV9VwGMmREnAfD7mBslRnhnvNsVBKPu6jhIjN3Ea+Su+ebEmcDrBrklY606GmrEvxF/KTj+Yb39/DgRqNhXwMWKv0/wAYeSYzuANLC1MBPiQ6EmI3u5crKjv1C/JzlRCrYdpM29snazISfEgZky5KfQQZa7IWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259354; c=relaxed/simple;
	bh=fGAA8TUZe+oNGXzN8qhMT1zSbd/pP9vuFfVMZnuOxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbWLXKMznI59R0IekmSv0qUO2CiVV6aKdluLoeHzuH4/4jrCi54kVLdsBClyOly/EbigaXE6FXJfBe+SyCxlAT0NwdmKrYxyucsd2ahbD5jlYv7MOVr3l9yTXa8BwrcAs+IZpp57Yz853cFqLP1M+Jo69yHIJVa9STTGSRvVMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keqqgJvR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keqqgJvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716259352; x=1747795352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGAA8TUZe+oNGXzN8qhMT1zSbd/pP9vuFfVMZnuOxrQ=;
  b=keqqgJvRBnOjlSauZoPM4aL0oR3A1bIpmECXcymFjtc5xuMNVFg5cNzl
   3l3H51Z9CshqhaFzXr5h/3/j6llDTamgh01xpjGrVKgj2SlGE50ShVZcz
   mslHkjavWCxz2MDHO8MIBetln31LN8Xnl2q3u8BJ58+gMrVgAFPO8ecoP
   y5nZ7Z7hgq8DEgENqWjN3l9jCY3L6KppWBXcLv53F8Oz/lgM2LBxgZl1r
   DYrbFqUBLPZ3uI0LCEVND3cB6ezxCYKZRakcbpPkoWo0p8QZ35JTvn6w0
   FMeM3zBJ0GGuwEgZZ7nknV2SqzDiq0s0yes3fF213xQyzt/UpCEIBVxs5
   Q==;
X-CSE-ConnectionGUID: dp8kpk6jQeykJKTN/CH09g==
X-CSE-MsgGUID: 8SyctKP2SYGTKYo6DA6Czw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="37802635"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37802635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 19:42:31 -0700
X-CSE-ConnectionGUID: k1THX/lnT4OkERnsbOwhSA==
X-CSE-MsgGUID: QwJMYa7nT7a6LbOH84D2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32787799"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 20 May 2024 19:42:27 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9FSL-0005SL-1t;
	Tue, 21 May 2024 02:42:25 +0000
Date: Tue, 21 May 2024 10:41:51 +0800
From: kernel test robot <lkp@intel.com>
To: Yuanchu Xie <yuanchu@google.com>, Wei Liu <liuwe@microsoft.com>,
	Rob Bradford <rbradford@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH v1 1/2] virt: pvmemcontrol: control guest physical memory
 properties
Message-ID: <202405211027.WMBOgeYF-lkp@intel.com>
References: <20240518072422.771698-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518072422.771698-1-yuanchu@google.com>

Hi Yuanchu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanchu-Xie/virt-pvmemcontrol-add-Yuanchu-and-Pasha-as-maintainers/20240518-152618
base:   linus/master
patch link:    https://lore.kernel.org/r/20240518072422.771698-1-yuanchu%40google.com
patch subject: [PATCH v1 1/2] virt: pvmemcontrol: control guest physical memory properties
config: powerpc-randconfig-r133-20240521 (https://download.01.org/0day-ci/archive/20240521/202405211027.WMBOgeYF-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce: (https://download.01.org/0day-ci/archive/20240521/202405211027.WMBOgeYF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405211027.WMBOgeYF-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

   WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/kcsan/kcsan_test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in mm/dmapool_test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat_test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp860.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp861.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp864.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp874.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp936.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-2.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1255.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-9.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_utf8.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-greek.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-inuit.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/bcachefs/mean_and_variance_test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/minix/minix.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx4/qnx4.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in fs/pstore/pstore.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/curve25519-generic.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-test.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-gw-pld.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-pcf857x.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-common.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/platform_lcd.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/rt4831-backlight.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/lp.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/omap-rng.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/omap3-rom-rng.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/qcom-pm8008.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/scsi_common.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/mISDN/l1oip.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/hfcpci.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/speedfax.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNipac.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNisar.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/vpd-sysfs.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/atmel-sha204a.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-light.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
>> WARNING: modpost: drivers/virt/pvmemcontrol/pvmemcontrol: section mismatch in reference: pvmemcontrol_pci_driver+0xc (section: .data) -> pvmemcontrol_pci_remove (section: .exit.text)
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
>> ERROR: modpost: "per_cpu_ptr_to_phys" [drivers/virt/pvmemcontrol/pvmemcontrol.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]

sparse warnings: (new ones prefixed by >>)
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:94:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/virt/pvmemcontrol/pvmemcontrol.c:94:19: sparse:     expected unsigned int [usertype] value
   drivers/virt/pvmemcontrol/pvmemcontrol.c:94:19: sparse:     got restricted __le32 [usertype]
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:100:16: sparse: sparse: cast to restricted __le32
>> drivers/virt/pvmemcontrol/pvmemcontrol.c:105:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   drivers/virt/pvmemcontrol/pvmemcontrol.c:105:25: sparse:     expected unsigned long long [usertype] val
   drivers/virt/pvmemcontrol/pvmemcontrol.c:105:25: sparse:     got restricted __le64 [usertype]
   drivers/virt/pvmemcontrol/pvmemcontrol.c:111:16: sparse: sparse: cast to restricted __le32

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

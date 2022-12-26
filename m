Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671EC46467
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 16:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A4BF80D1B;
	Mon, 26 Dec 2022 16:55:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A4BF80D1B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IfbEUfng
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzYrXpsB5sMC; Mon, 26 Dec 2022 16:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7428380D20;
	Mon, 26 Dec 2022 16:55:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7428380D20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF03C0035;
	Mon, 26 Dec 2022 16:55:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18F13C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 16:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA62880D20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 16:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA62880D20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NHEiBXX35IHG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 16:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C8A880D1B
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C8A880D1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672073702; x=1703609702;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=SfZzdNV19bg9UmQpe6KYIZYymHxtUypJH/O7nO8s6g4=;
 b=IfbEUfngANzZUlBFCHkZQ7VLDTItcvnWfLylVON1zW6/ynexypkKcZn5
 FtXJnLA2x7Ad2WnSCyio1N7SZYCXUBHbypFQHgZKehKWm+gGKYd+dQ3Gb
 Fqo0wXG/KZ4OraqAARtRIAubEa2c1A9qgwrgW87l+nxiqyGf7P/vQp9IO
 55Tgw5CzkUT/kNcAbNEKpXv+AyHlUoemvpnrcqeHKfsKt+kxhdozEDEG8
 J/JWkl9aRX4/53Vmnqv6Acl3j0IDFv7zACY++Aef0UH7IsuRWG8SRDWx2
 2ZlqV8Y0pSda4XHSX8fUVM8WOKlX7DAnieJyFh1qWWSKr6kx7SySkftCg Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="308338536"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; d="scan'208";a="308338536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2022 08:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="646205184"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; d="scan'208";a="646205184"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 26 Dec 2022 08:54:55 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1p9qkZ-000EZN-0D;
 Mon, 26 Dec 2022 16:54:55 +0000
Date: Tue, 27 Dec 2022 00:54:10 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
Message-ID: <63a9d1b2.869GAwHafmAB6R7M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org, speakup@linux-speakup.org,
 linux-cxl@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>,
 linux-mtd@lists.infradead.org, loongarch@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5  Add linux-next specific files for 20221226

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202212020520.0OkMIno3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212041528.4TbQL9ys-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212051759.cEv6fyHy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212061455.6GE7y0jg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212080938.RHVtvwt0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212090509.NjAl9tbo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212242239.hWUlGmm0-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212250859.uLjFpJy3-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-betopff.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-logitech.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-megaworld.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/hid/hid-mf.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/drv260x.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/drv2665.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/gpio-vibra.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/regulator-haptic.ko] undefined!
ERROR: modpost: "input_ff_create_memless" [drivers/input/misc/sc27xx-vibra.ko] undefined!
aarch64-linux-ld: ID map text too big or misaligned
arch/arm/kernel/entry-armv.S:485:5: warning: "CONFIG_ARM_THUMB" is not defined, evaluates to 0 [-Wundef]
arch/arm64/include/asm/pgtable-hwdef.h:82:64: warning: "PMD_SHIFT" is not defined, evaluates to 0 [-Wundef]
arch/loongarch/kernel/asm-offsets.c:265:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
drivers/regulator/tps65219-regulator.c:310:32: warning: parameter 'dev' set but not used [-Wunused-but-set-parameter]
drivers/regulator/tps65219-regulator.c:310:60: warning: parameter 'dev' set but not used [-Wunused-but-set-parameter]
drivers/regulator/tps65219-regulator.c:370:26: sparse:    int
drivers/regulator/tps65219-regulator.c:370:26: sparse:    struct regulator_dev *[assigned] rdev
drivers/regulator/tps65219-regulator.c:370:26: warning: ordered comparison of pointer with integer zero [-Wextra]
loongarch64-linux-ld: sleep.c:(.text+0x22c): undefined reference to `loongarch_wakeup_start'
sleep.c:(.text+0x228): undefined reference to `loongarch_wakeup_start'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/accessibility/speakup/main.c:1290:26: sparse: sparse: obsolete array initializer, use C99 syntax
drivers/block/null_blk/zoned.c:769 zone_cond_store() warn: potential spectre issue 'dev->zones' [w] (local cap)
drivers/block/virtio_blk.c:721:9: sparse:    bad type *
drivers/block/virtio_blk.c:721:9: sparse:    unsigned int *
drivers/block/virtio_blk.c:721:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 [addressable] virtio_cread_v'
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 virtio_cread_v'
drivers/cxl/core/mbox.c:832:18: sparse: sparse: cast from non-scalar
drivers/cxl/core/mbox.c:832:18: sparse: sparse: cast to non-scalar
drivers/i2c/busses/i2c-qcom-geni.c:1028:28: sparse: sparse: symbol 'i2c_master_hub' was not declared. Should it be static?
drivers/iio/adc/twl6030-gpadc.c:955:16-23: duplicated argument to & or |
drivers/iio/light/tsl2563.c:751:8-33: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)
drivers/media/platform/ti/davinci/vpif.c:483:20: sparse: sparse: cast from non-scalar
drivers/media/platform/ti/davinci/vpif.c:483:20: sparse: sparse: cast to non-scalar
drivers/media/test-drivers/visl/visl-video.c:690:22: sparse: sparse: symbol 'visl_qops' was not declared. Should it be static?
fs/exfat/dir.c:862 exfat_get_dentry_set() warn: missing unwind goto?
fs/xfs/xfs_iomap.c:86:29: sparse: sparse: symbol 'xfs_iomap_page_ops' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- arc-randconfig-r024-20221225
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- arc-randconfig-s041-20221225
|   `-- fs-xfs-xfs_iomap.c:sparse:sparse:symbol-xfs_iomap_page_ops-was-not-declared.-Should-it-be-static
|-- arm-allyesconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- arm-badge4_defconfig
|   `-- arch-arm-kernel-entry-armv.S:warning:CONFIG_ARM_THUMB-is-not-defined-evaluates-to
|-- arm64-allyesconfig
|   |-- aarch64-linux-ld:ID-map-text-too-big-or-misaligned
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- arm64-randconfig-c034-20221225
|   `-- arch-arm64-include-asm-pgtable-hwdef.h:warning:PMD_SHIFT-is-not-defined-evaluates-to
|-- csky-randconfig-c033-20221225
|   |-- drivers-iio-light-tsl2563.c:WARNING:Threaded-IRQ-with-no-primary-handler-requested-without-IRQF_ONESHOT-(unless-it-is-nested-IRQ)
|   `-- drivers-mtd-ubi-build.c:WARNING:conversion-to-bool-not-needed-here
|-- i386-allyesconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- i386-randconfig-c021-20221226
|   `-- drivers-iio-light-tsl2563.c:WARNING:Threaded-IRQ-with-no-primary-handler-requested-without-IRQF_ONESHOT-(unless-it-is-nested-IRQ)
|-- i386-randconfig-m021-20221226
|   `-- fs-exfat-dir.c-exfat_get_dentry_set()-warn:missing-unwind-goto
|-- i386-randconfig-s002
|   `-- fs-xfs-xfs_iomap.c:sparse:sparse:symbol-xfs_iomap_page_ops-was-not-declared.-Should-it-be-static
|-- ia64-allmodconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- loongarch-allyesconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_pbe_defines
|-- loongarch-randconfig-s043-20221225
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_pbe_defines
|   |-- drivers-cxl-core-mbox.c:sparse:sparse:cast-from-non-scalar
|   |-- drivers-cxl-core-mbox.c:sparse:sparse:cast-to-non-scalar
|   |-- drivers-i2c-busses-i2c-qcom-geni.c:sparse:sparse:symbol-i2c_master_hub-was-not-declared.-Should-it-be-static
|   |-- fs-xfs-xfs_iomap.c:sparse:sparse:symbol-xfs_iomap_page_ops-was-not-declared.-Should-it-be-static
|   |-- loongarch64-linux-ld:sleep.c:(.text):undefined-reference-to-loongarch_wakeup_start
|   `-- sleep.c:(.text):undefined-reference-to-loongarch_wakeup_start
|-- m68k-allmodconfig
|   |-- drivers-regulator-tps65219-regulator.c:warning:ordered-comparison-of-pointer-with-integer-zero
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
clang_recent_errors
|-- hexagon-buildonly-randconfig-r003-20221225
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- hexagon-randconfig-r002-20221225
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- riscv-randconfig-r021-20221225
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-regulator-tps65219-regulator.c:warning:parameter-dev-set-but-not-used
`-- x86_64-randconfig-a003-20221226
    `-- vmlinux.o:warning:objtool:___ksymtab_gpl-_RNvNtCsfATHBUcknU9_6kernel5print16call_printk_cont:data-relocation-to-ENDBR:_RNvNtCsfATHBUcknU9_6kernel5print16call_printk_cont

elapsed time: 720m

configs tested: 89
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
i386                 randconfig-a012-20221226
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                 randconfig-a011-20221226
x86_64                          rhel-8.3-func
i386                                defconfig
i386                 randconfig-a013-20221226
x86_64                           rhel-8.3-bpf
s390                             allmodconfig
s390                                defconfig
ia64                             allmodconfig
i386                 randconfig-a014-20221226
x86_64                           rhel-8.3-syz
x86_64                              defconfig
i386                 randconfig-a016-20221226
s390                             allyesconfig
i386                 randconfig-a015-20221226
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                            allnoconfig
x86_64               randconfig-a014-20221226
powerpc                           allnoconfig
x86_64               randconfig-a013-20221226
x86_64                               rhel-8.3
arm64                            allyesconfig
x86_64               randconfig-a011-20221226
arm                              allyesconfig
x86_64               randconfig-a012-20221226
i386                             allyesconfig
x86_64               randconfig-a015-20221226
x86_64               randconfig-a016-20221226
sh                               allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                  randconfig-r046-20221225
arc                  randconfig-r043-20221225
arc                  randconfig-r043-20221226
riscv                randconfig-r042-20221226
s390                 randconfig-r044-20221226
x86_64                           alldefconfig
sh                          lboxre2_defconfig
arc                               allnoconfig
sh                             shx3_defconfig
arm                           tegra_defconfig
microblaze                          defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
xtensa                              defconfig
mips                      maltasmvp_defconfig
parisc                           alldefconfig
arm                          badge4_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7201_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    klondike_defconfig
sh                  sh7785lcr_32bit_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
x86_64               randconfig-a002-20221226
i386                 randconfig-a003-20221226
i386                 randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a006-20221226
i386                 randconfig-a005-20221226
i386                 randconfig-a006-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
hexagon              randconfig-r045-20221225
hexagon              randconfig-r041-20221225
hexagon              randconfig-r041-20221226
arm                  randconfig-r046-20221226
s390                 randconfig-r044-20221225
hexagon              randconfig-r045-20221226
riscv                randconfig-r042-20221225
powerpc                     tqm5200_defconfig
arm                         shannon_defconfig
arm                         orion5x_defconfig
arm                           sama7_defconfig
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

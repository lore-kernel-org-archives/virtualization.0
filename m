Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3F3C001DB
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 17:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E48E60B31;
	Tue,  4 Jul 2023 17:23:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E48E60B31
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TWKXtrI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SC7dBCHsEpRr; Tue,  4 Jul 2023 17:23:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C85A60739;
	Tue,  4 Jul 2023 17:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C85A60739
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36697C0072;
	Tue,  4 Jul 2023 17:23:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E636AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 17:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5059B400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 17:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5059B400EF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TWKXtrI+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsdJevNK0x_C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 17:23:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69929408FF
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69929408FF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688491385; x=1720027385;
 h=date:from:to:cc:subject:message-id;
 bh=pn7pmITVLM7sFJDh3HU77nok6p6G73xphXt8S5mtBPA=;
 b=TWKXtrI+WzbUNA/ZkQBvVloN9SMhdRoYvdX6KUpy1LSeIL3o/5aoZcrO
 LW2+wPcBEcTYfl4kQhbJF0S44Vmc2J8aqwaZ64vP0fC8XBzjyLSD4qhR7
 j4x8aL8Cl8QwEkDXA9/e3853qdmTR/J4ooC1qy2JhCnP9DjkQDfx73sX3
 pht/IIvRkeRM4eTAsr+kEyElIy836otty2qyJbmTm9ezNWSOWWaw6Ia57
 fdJ/5ofQblEakEfrNXKx4ksyexx0/EEA00G58t1z6iKpOEaidHOrVUmAr
 B+fYlhYeVpnUCd8P5ug+YYAP1eKV4CoZPmc79ROiBWYF/5H1dFrL+sRgi w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="365731475"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; d="scan'208";a="365731475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2023 10:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="748470953"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; d="scan'208";a="748470953"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 04 Jul 2023 10:23:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qGjjw-000IP9-3C;
 Tue, 04 Jul 2023 17:23:00 +0000
Date: Wed, 05 Jul 2023 01:22:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 1c6f93977947dbba1fc4d250c4eb8a7d4cfdecf1
Message-ID: <202307050151.c3vyrIHs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Cc: kvm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 1c6f93977947dbba1fc4d250c4eb8a7d4cfdecf1  Add linux-next specific files for 20230704

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306301709.lvrxzyCj-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306301756.x8dgyYnL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bluetooth/btmtk.c:386:32: error: no member named 'dump' in 'struct hci_dev'
drivers/bluetooth/btmtk.c:386:44: error: 'struct hci_dev' has no member named 'dump'
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'? [-Werror=implicit-function-declaration]
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/vhost/vhost.c:1654 vhost_vring_ioctl() error: uninitialized symbol 'vq'.
drivers/vhost/vhost.c:1685 vhost_vring_ioctl() error: uninitialized symbol 'idx'.
drivers/vhost/vhost.c:763 vhost_worker_ioctl() error: uninitialized symbol 'vq'.
drivers/vhost/vhost.c:774 vhost_worker_ioctl() error: uninitialized symbol 'idx'.
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r002-20230704
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- loongarch-randconfig-r022-20230704
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- m68k-randconfig-r016-20230704
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- microblaze-randconfig-r073-20230703
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- nios2-randconfig-r034-20230704
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- riscv-randconfig-m031-20230703
|   |-- drivers-vhost-vhost.c-vhost_vring_ioctl()-error:uninitialized-symbol-idx-.
|   |-- drivers-vhost-vhost.c-vhost_vring_ioctl()-error:uninitialized-symbol-vq-.
|   |-- drivers-vhost-vhost.c-vhost_worker_ioctl()-error:uninitialized-symbol-idx-.
|   `-- drivers-vhost-vhost.c-vhost_worker_ioctl()-error:uninitialized-symbol-vq-.
|-- sh-allmodconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|   `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
|-- sh-randconfig-r015-20230704
|   |-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-sh7710voipgw_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sparc-randconfig-r005-20230704
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
`-- x86_64-buildonly-randconfig-r003-20230703
    `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
clang_recent_errors
|-- arm64-randconfig-r033-20230704
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- hexagon-randconfig-r041-20230703
|   |-- drivers-bluetooth-btmtk.c:error:no-member-named-dump-in-struct-hci_dev
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r045-20230703
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- i386-randconfig-i011-20230703
|   `-- drivers-bluetooth-btmtk.c:error:no-member-named-dump-in-struct-hci_dev
`-- s390-randconfig-r006-20230704
    |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
    `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type

elapsed time: 734m

configs tested: 148
configs skipped: 9

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230704   gcc  
alpha                randconfig-r003-20230704   gcc  
alpha                randconfig-r004-20230704   gcc  
alpha                randconfig-r023-20230703   gcc  
alpha                randconfig-r035-20230704   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r021-20230704   gcc  
arc                  randconfig-r043-20230703   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230704   gcc  
arm                  randconfig-r014-20230704   clang
arm                  randconfig-r026-20230703   gcc  
arm                  randconfig-r032-20230704   gcc  
arm                  randconfig-r046-20230703   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         s5pv210_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230704   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230703   gcc  
hexagon              randconfig-r033-20230704   clang
hexagon              randconfig-r041-20230703   clang
hexagon              randconfig-r045-20230703   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230703   gcc  
i386         buildonly-randconfig-r005-20230703   gcc  
i386         buildonly-randconfig-r006-20230703   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230704   clang
i386                 randconfig-i002-20230704   clang
i386                 randconfig-i003-20230704   clang
i386                 randconfig-i004-20230704   clang
i386                 randconfig-i005-20230704   clang
i386                 randconfig-i006-20230704   clang
i386                 randconfig-i011-20230703   clang
i386                 randconfig-i012-20230703   clang
i386                 randconfig-i013-20230703   clang
i386                 randconfig-i014-20230703   clang
i386                 randconfig-i015-20230703   clang
i386                 randconfig-i016-20230703   clang
i386                 randconfig-r005-20230704   clang
i386                 randconfig-r032-20230704   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230704   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230704   gcc  
microblaze           randconfig-r011-20230704   gcc  
microblaze           randconfig-r015-20230704   gcc  
microblaze           randconfig-r023-20230704   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                           mtx1_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r013-20230704   clang
mips                 randconfig-r031-20230704   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230704   gcc  
nios2                randconfig-r006-20230704   gcc  
nios2                randconfig-r012-20230704   gcc  
nios2                randconfig-r034-20230704   gcc  
openrisc                         alldefconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r014-20230704   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230704   gcc  
parisc               randconfig-r012-20230704   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc              randconfig-r001-20230704   clang
powerpc              randconfig-r011-20230704   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230704   gcc  
riscv                randconfig-r042-20230703   clang
riscv                          rv32_defconfig   gcc  
s390                 randconfig-r006-20230704   clang
s390                 randconfig-r044-20230703   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230704   gcc  
sh                   randconfig-r026-20230704   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230704   gcc  
sparc                randconfig-r036-20230704   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r016-20230704   gcc  
sparc64              randconfig-r024-20230703   gcc  
sparc64              randconfig-r035-20230704   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r025-20230704   clang
um                   randconfig-r031-20230704   gcc  
um                   randconfig-r034-20230704   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230703   gcc  
x86_64       buildonly-randconfig-r002-20230703   gcc  
x86_64       buildonly-randconfig-r003-20230703   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230703   clang
x86_64               randconfig-x002-20230703   clang
x86_64               randconfig-x003-20230703   clang
x86_64               randconfig-x004-20230703   clang
x86_64               randconfig-x005-20230703   clang
x86_64               randconfig-x006-20230703   clang
x86_64               randconfig-x011-20230703   gcc  
x86_64               randconfig-x012-20230703   gcc  
x86_64               randconfig-x013-20230703   gcc  
x86_64               randconfig-x014-20230703   gcc  
x86_64               randconfig-x015-20230703   gcc  
x86_64               randconfig-x016-20230703   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

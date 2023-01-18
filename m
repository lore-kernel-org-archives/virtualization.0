Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A840AC38147
	for <virtualization@archiver.kernel.org>; Wed, 18 Jan 2023 16:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E98C820A4;
	Wed, 18 Jan 2023 16:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E98C820A4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kdTSXI40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EaoaRsL9877Z; Wed, 18 Jan 2023 16:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E04A820A3;
	Wed, 18 Jan 2023 16:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E04A820A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C711C0032;
	Wed, 18 Jan 2023 16:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B87C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 16:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C05F41852
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 16:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C05F41852
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kdTSXI40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ODDGTpwJetFd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 16:51:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 778ED4187A
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 778ED4187A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674060670; x=1705596670;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=qBq10ouxVtiB3/iqe3X4Tyh7yKptJbnRSeCrgUrFlZY=;
 b=kdTSXI400Jw0GIpnqQbZqMdwG8/Ct7WbFKiH+w6w1EGQGG2b+xJo6Rlg
 4GSqFMhZFnuE90BvN8Upj+R3UhMzrN8T677ps29LgrslTI8uEeCd6MdBS
 9yOvhlsrN5QEi8xNsxbHmeaOuZxMujTgsoLWKKEcugnIUEDVfGAIhRSO3
 HfMjA+JEr8evf5hJdzgr2844YzTkbmv9y5TqZMp38GZqZdF0661jZVaz+
 bm4uh0QUMpoNrsLGJUO7FhXnF0jUK3IKKjU1mkrLyV2qKS6wVvm1xpmlp
 HkMIqdTeI4iAL2w8itihx5bLfec/8PAXyRVmiZQgnOhSFyaY9UCYsHd1g Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323715980"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; d="scan'208";a="323715980"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2023 08:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767824583"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; d="scan'208";a="767824583"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 08:51:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pIBeK-0000X9-2U;
 Wed, 18 Jan 2023 16:50:56 +0000
Date: Thu, 19 Jan 2023 00:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [linux-next:master] BUILD REGRESSION
 f3381a7baf5ccbd091eb2c4fd2afd84266fcef24
Message-ID: <63c82355.kCFspGLcQ170XMRT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-fscrypt@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
branch HEAD: f3381a7baf5ccbd091eb2c4fd2afd84266fcef24  Add linux-next specific files for 20230118

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301171511.4ZszviYP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Documentation/mm/unevictable-lru.rst:186: WARNING: Title underline too short.
Error: failed to load BTF from vmlinux: No data available
drivers/scsi/qla2xxx/qla_mid.c:1094:51: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]
drivers/scsi/qla2xxx/qla_mid.c:1189:6: warning: no previous prototype for 'qla_trim_buf' [-Wmissing-prototypes]
drivers/scsi/qla2xxx/qla_mid.c:1221:6: warning: no previous prototype for '__qla_adjust_buf' [-Wmissing-prototypes]
libbpf: failed to find '.BTF' ELF section in vmlinux

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/block/virtio_blk.c:721:9: sparse:    bad type *
drivers/block/virtio_blk.c:721:9: sparse:    unsigned int *
drivers/block/virtio_blk.c:721:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 [addressable] virtio_cread_v'
drivers/block/virtio_blk.c:721:9: sparse: sparse: no generic selection for 'restricted __le32 virtio_cread_v'
drivers/nvmem/imx-ocotp.c:599:21: sparse: sparse: symbol 'imx_ocotp_layout' was not declared. Should it be static?
fs/verity/enable.c:29:2: warning: Null pointer passed as 1st argument to memory set function [clang-analyzer-unix.cstring.NullArg]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- arc-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-unsigned-int
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- arm-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-unsigned-int
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- arm64-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- csky-randconfig-s051-20230115
|   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
|-- i386-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-unsigned-int
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- ia64-allmodconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- ia64-buildonly-randconfig-r002-20230117
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- loongarch-randconfig-r035-20230116
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- mips-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-unsigned-int
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- powerpc-allmodconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-unsigned-int
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- s390-allyesconfig
|   |-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-__qla_adjust_buf
|   `-- drivers-scsi-qla2xxx-qla_mid.c:warning:no-previous-prototype-for-qla_trim_buf
|-- s390-randconfig-s052-20230115
|   |-- drivers-block-virtio_blk.c:sparse:bad-type
|   |-- drivers-block-virtio_blk.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-base-types):
|   |-- drivers-block-virtio_blk.c:sparse:sparse:no-generic-selection-for-restricted-__le32-addressable-virtio_cread_v
|   |-- drivers-block-virtio_blk.c:sparse:sparse:no-generic-selection-for-restricted-__le32-virtio_cread_v
|   |-- drivers-block-virtio_blk.c:sparse:unsigned-int
|   `-- drivers-nvmem-imx-ocotp.c:sparse:sparse:symbol-imx_ocotp_layout-was-not-declared.-Should-it-be-static
|-- x86_64-allnoconfig
|   `-- Documentation-mm-unevictable-lru.rst:WARNING:Title-underline-too-short.
|-- x86_64-allyesconfig
clang_recent_errors
`-- i386-randconfig-c001
    `-- fs-verity-enable.c:warning:Null-pointer-passed-as-1st-argument-to-memory-set-function-clang-analyzer-unix.cstring.NullArg

elapsed time: 728m

configs tested: 63
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                                defconfig
arc                                 defconfig
m68k                             allyesconfig
alpha                               defconfig
m68k                             allmodconfig
arm                                 defconfig
s390                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
s390                                defconfig
x86_64                            allnoconfig
x86_64                               rhel-8.3
s390                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a011-20230116
x86_64               randconfig-a013-20230116
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a012-20230116
x86_64               randconfig-a015-20230116
x86_64                           rhel-8.3-bpf
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230118
x86_64               randconfig-a014-20230116
mips                             allyesconfig
x86_64               randconfig-a016-20230116
i386                          randconfig-a014
riscv                randconfig-r042-20230118
i386                          randconfig-a012
s390                 randconfig-r044-20230118
i386                          randconfig-a016
x86_64               randconfig-k001-20230116

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230118
x86_64               randconfig-a001-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
x86_64               randconfig-a002-20230116
i386                          randconfig-a013
x86_64               randconfig-a004-20230116
i386                          randconfig-a015
hexagon              randconfig-r041-20230118
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
arm                  randconfig-r046-20230118
x86_64               randconfig-a003-20230116
i386                          randconfig-a011
i386                 randconfig-a003-20230116
i386                 randconfig-a006-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

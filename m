Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614173B71A5
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jul 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490879; cv=none; b=C2fOZGS/s74edpI7eJ3A41fz1d1RNazmbhJZrEEQCoOxYGLkfWJc4g367lz/4qNFEyZ1/Yd94D8hrZ1XehqFf9qyfxd1LFy228FQ6Pcx5jnr1zBQ3gCDDwHWjulDtvl7Mw0tQfJ/1xRaDVCkOuUXLCpJlYZqars05BiA3B7f9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490879; c=relaxed/simple;
	bh=zpMWS0lWEZKswGbL8Rg9YIb+gH0JEhhO8L8RjB/52Ng=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kjvc8C+a5WsFmTYuAdl7Zelh4WSGNToroMDkKTdrlygL5qFqS0r8Zm+C1A73HYB7hDW6Xg0zhAWkCQMb5s39f7wdRb+u2ud5pcQOpY6lA2mCWdp6O7juCmUAdn5nxXep8A5v2XBrdSR7MvlTqdFZx/+ZFiMDinoHNesxafE73rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEzotiE6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEzotiE6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF236083A
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jul 2026 09:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.09
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1drVGV4g_fqr for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2026 09:41:15 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 62481607AC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62481607AC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MEzotiE6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62481607AC
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jul 2026 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785490876; x=1817026876;
  h=date:from:to:cc:subject:message-id;
  bh=zpMWS0lWEZKswGbL8Rg9YIb+gH0JEhhO8L8RjB/52Ng=;
  b=MEzotiE6zlINDmR/XWCeYPD+w+MuvP5CjqY8hVy9n/eqFWIGcYC9GazI
   h1gS3NKpxQtRqd8aJsWtFdu9782yohmtgc4r4x6PKmibJcfAZXOhXfQGO
   1+CKixPFTMU0MRfU4LbaazicFTlpsAJshB+4c3yPlsh2lmqBED6VFIwny
   PhgrvKsd6uakG2Nmm5ghCCxBUfRWEGB35A/BYUuFkWMI7UdhqZdzNYX+u
   NAYDcXu3xu5S4XroZrEWEIIB1EvRhFTh9AWGWY75laa6smzjmA5a0h9aC
   hxpULuLaTR2rOz0E0ud2rMDg1CyL2i17Ls2vs0D80LODs3S7e5nIdYwhx
   g==;
X-CSE-ConnectionGUID: EgkUE2D4RKaJdiDQO+SgDg==
X-CSE-MsgGUID: F1R5MBoESA22EfJAvU0mwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96473624"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="96473624"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 02:41:14 -0700
X-CSE-ConnectionGUID: /HdLCivGTIelcrDvxQsvgA==
X-CSE-MsgGUID: /F3aW5znRP2mlS9q9NEsUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="259295178"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2026 02:41:11 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpjjp-000000002iO-24ZS;
	Fri, 31 Jul 2026 09:41:09 +0000
Date: Fri, 31 Jul 2026 11:41:02 +0200
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Brian Daniels <briandaniels@google.com>
Subject: [mst-vhost:linux-next 16/73]
 tools/include/linux/types.h:13:10: fatal error: asm/types.h: No such file or
 directory
Message-ID: <202607311151.aaQcykcR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
head:   a8a2a266a5d6d5a9e839422eea6ba3986e25801b
commit: cbd7147ab405921843903c72ff7b7e2066d9ba78 [16/73] media: virtio: Add skeleton virtio-media driver
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260731/202607311151.aaQcykcR-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260731/202607311151.aaQcykcR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607311151.aaQcykcR-lkp@intel.com/

All errors (new ones prefixed by >>):

   testcases/testcases.c: In function 'validate_reserved':
>> testcases/testcases.c:201:22: error: 'GCS_MAGIC' undeclared (first use in this function); did you mean 'ZT_MAGIC'?
     201 |                 case GCS_MAGIC:
         |                      ^~~~~~~~~
         |                      ZT_MAGIC
   testcases/testcases.c:201:22: note: each undeclared identifier is reported only once for each function it appears in
>> testcases/testcases.c:204:50: error: invalid application of 'sizeof' to incomplete type 'struct gcs_context'
     204 |                         if (head->size != sizeof(struct gcs_context))
         |                                                  ^~~~~~
--
   testcases/gcs_frame.c: In function 'gcs_regs':
>> testcases/gcs_frame.c:53:33: error: 'GCS_MAGIC' undeclared (first use in this function); did you mean 'ZA_MAGIC'?
      53 |         head = get_header(head, GCS_MAGIC, GET_BUF_RESV_SIZE(context),
         |                                 ^~~~~~~~~
         |                                 ZA_MAGIC
   testcases/gcs_frame.c:53:33: note: each undeclared identifier is reported only once for each function it appears in
>> testcases/gcs_frame.c:64:16: error: invalid use of undefined type 'struct gcs_context'
      64 |         if (gcs->features_enabled != expected) {
         |                ^~
   testcases/gcs_frame.c:66:28: error: invalid use of undefined type 'struct gcs_context'
      66 |                         gcs->features_enabled, expected);
         |                            ^~
   testcases/gcs_frame.c:70:16: error: invalid use of undefined type 'struct gcs_context'
      70 |         if (gcs->gcspr != gcspr) {
         |                ^~
   testcases/gcs_frame.c:72:28: error: invalid use of undefined type 'struct gcs_context'
      72 |                         gcs->gcspr, gcspr);
         |                            ^~
   testcases/testcases.c: In function 'validate_reserved':
>> testcases/testcases.c:201:22: error: 'GCS_MAGIC' undeclared (first use in this function); did you mean 'ZT_MAGIC'?
     201 |                 case GCS_MAGIC:
         |                      ^~~~~~~~~
         |                      ZT_MAGIC
   testcases/testcases.c:201:22: note: each undeclared identifier is reported only once for each function it appears in
>> testcases/testcases.c:204:50: error: invalid application of 'sizeof' to incomplete type 'struct gcs_context'
     204 |                         if (head->size != sizeof(struct gcs_context))
         |                                                  ^~~~~~
--
   mte_common_util.c: In function 'mte_default_setup':
>> mte_common_util.c:376:39: error: 'HWCAP3_MTE_FAR' undeclared (first use in this function); did you mean 'HWCAP2_MTE'?
     376 |         mtefar_support = !!(hwcaps3 & HWCAP3_MTE_FAR);
         |                                       ^~~~~~~~~~~~~~
         |                                       HWCAP2_MTE
   mte_common_util.c:376:39: note: each undeclared identifier is reported only once for each function it appears in
>> mte_common_util.c:378:23: error: 'HWCAP3_MTE_STORE_ONLY' undeclared (first use in this function); did you mean 'PR_MTE_STORE_ONLY'?
     378 |         if (hwcaps3 & HWCAP3_MTE_STORE_ONLY)
         |                       ^~~~~~~~~~~~~~~~~~~~~
         |                       PR_MTE_STORE_ONLY
--
>> check_prctl.c:112:79: error: 'HWCAP3_MTE_STORE_ONLY' undeclared here (not in a function); did you mean 'PR_MTE_STORE_ONLY'?
     112 |         { PR_MTE_TCF_SYNC | PR_MTE_STORE_ONLY,                    HWCAP2_MTE, HWCAP3_MTE_STORE_ONLY, "SYNC+STONLY" },
         |                                                                               ^~~~~~~~~~~~~~~~~~~~~
         |                                                                               PR_MTE_STORE_ONLY
   mte_common_util.c: In function 'mte_default_setup':
>> mte_common_util.c:376:39: error: 'HWCAP3_MTE_FAR' undeclared (first use in this function); did you mean 'HWCAP2_MTE'?
     376 |         mtefar_support = !!(hwcaps3 & HWCAP3_MTE_FAR);
         |                                       ^~~~~~~~~~~~~~
         |                                       HWCAP2_MTE
   mte_common_util.c:376:39: note: each undeclared identifier is reported only once for each function it appears in
>> mte_common_util.c:378:23: error: 'HWCAP3_MTE_STORE_ONLY' undeclared (first use in this function); did you mean 'PR_MTE_STORE_ONLY'?
     378 |         if (hwcaps3 & HWCAP3_MTE_STORE_ONLY)
         |                       ^~~~~~~~~~~~~~~~~~~~~
         |                       PR_MTE_STORE_ONLY
--
>> hwcap.c:720:30: error: 'HWCAP_CMPBR' undeclared here (not in a function)
     720 |                 .hwcap_bit = HWCAP_CMPBR,
         |                              ^~~~~~~~~~~
>> hwcap.c:781:30: error: 'HWCAP_F8MM8' undeclared here (not in a function); did you mean 'HWCAP_FCMA'?
     781 |                 .hwcap_bit = HWCAP_F8MM8,
         |                              ^~~~~~~~~~~
         |                              HWCAP_FCMA
>> hwcap.c:788:30: error: 'HWCAP_F8MM4' undeclared here (not in a function); did you mean 'HWCAP2_F8DP4'?
     788 |                 .hwcap_bit = HWCAP_F8MM4,
         |                              ^~~~~~~~~~~
         |                              HWCAP2_F8DP4
>> hwcap.c:795:30: error: 'HWCAP3_F16MM' undeclared here (not in a function); did you mean 'HWCAP_FCMA'?
     795 |                 .hwcap_bit = HWCAP3_F16MM,
         |                              ^~~~~~~~~~~~
         |                              HWCAP_FCMA
>> hwcap.c:802:30: error: 'HWCAP3_F16F32DOT' undeclared here (not in a function)
     802 |                 .hwcap_bit = HWCAP3_F16F32DOT,
         |                              ^~~~~~~~~~~~~~~~
>> hwcap.c:809:30: error: 'HWCAP3_F16F32MM' undeclared here (not in a function); did you mean 'HWCAP2_SVEF32MM'?
     809 |                 .hwcap_bit = HWCAP3_F16F32MM,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SVEF32MM
>> hwcap.c:838:30: error: 'HWCAP_FPRCVT' undeclared here (not in a function); did you mean 'HWCAP_JSCVT'?
     838 |                 .hwcap_bit = HWCAP_FPRCVT,
         |                              ^~~~~~~~~~~~
         |                              HWCAP_JSCVT
>> hwcap.c:904:30: error: 'HWCAP3_LSFE' undeclared here (not in a function); did you mean 'HWCAP_SVE'?
     904 |                 .hwcap_bit = HWCAP3_LSFE,
         |                              ^~~~~~~~~~~
         |                              HWCAP_SVE
>> hwcap.c:998:30: error: 'HWCAP_SME2P2' undeclared here (not in a function); did you mean 'HWCAP2_SME2P1'?
     998 |                 .hwcap_bit = HWCAP_SME2P2,
         |                              ^~~~~~~~~~~~
         |                              HWCAP2_SME2P1
>> hwcap.c:1005:30: error: 'HWCAP3_SME2P3' undeclared here (not in a function); did you mean 'HWCAP2_SME2P1'?
    1005 |                 .hwcap_bit = HWCAP3_SME2P3,
         |                              ^~~~~~~~~~~~~
         |                              HWCAP2_SME2P1
>> hwcap.c:1012:30: error: 'HWCAP_SME_AES' undeclared here (not in a function); did you mean 'HWCAP2_SVEAES'?
    1012 |                 .hwcap_bit = HWCAP_SME_AES,
         |                              ^~~~~~~~~~~~~
         |                              HWCAP2_SVEAES
>> hwcap.c:1061:30: error: 'HWCAP3_SME_LUT6' undeclared here (not in a function); did you mean 'HWCAP2_SME_LUTV2'?
    1061 |                 .hwcap_bit = HWCAP3_SME_LUT6,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SME_LUTV2
>> hwcap.c:1075:30: error: 'HWCAP_SME_SBITPERM' undeclared here (not in a function); did you mean 'HWCAP2_SVEBITPERM'?
    1075 |                 .hwcap_bit = HWCAP_SME_SBITPERM,
         |                              ^~~~~~~~~~~~~~~~~~
         |                              HWCAP2_SVEBITPERM
>> hwcap.c:1103:30: error: 'HWCAP_SME_SFEXPA' undeclared here (not in a function); did you mean 'HWCAP2_SME_SF8FMA'?
    1103 |                 .hwcap_bit = HWCAP_SME_SFEXPA,
         |                              ^~~~~~~~~~~~~~~~
         |                              HWCAP2_SME_SF8FMA
>> hwcap.c:1110:30: error: 'HWCAP_SME_SMOP4' undeclared here (not in a function); did you mean 'HWCAP2_SME_SF8DP4'?
    1110 |                 .hwcap_bit = HWCAP_SME_SMOP4,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SME_SF8DP4
>> hwcap.c:1117:30: error: 'HWCAP_SME_STMOP' undeclared here (not in a function); did you mean 'HWCAP2_SME_SF8DP2'?
    1117 |                 .hwcap_bit = HWCAP_SME_STMOP,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SME_SF8DP2
>> hwcap.c:1146:30: error: 'HWCAP_SVE2P2' undeclared here (not in a function); did you mean 'HWCAP2_SVE2P1'?
    1146 |                 .hwcap_bit = HWCAP_SVE2P2,
         |                              ^~~~~~~~~~~~
         |                              HWCAP2_SVE2P1
>> hwcap.c:1153:30: error: 'HWCAP3_SVE2P3' undeclared here (not in a function); did you mean 'HWCAP2_SVE2P1'?
    1153 |                 .hwcap_bit = HWCAP3_SVE2P3,
         |                              ^~~~~~~~~~~~~
         |                              HWCAP2_SVE2P1
>> hwcap.c:1167:30: error: 'HWCAP_SVE_AES2' undeclared here (not in a function); did you mean 'HWCAP2_SVEAES'?
    1167 |                 .hwcap_bit = HWCAP_SVE_AES2,
         |                              ^~~~~~~~~~~~~~
         |                              HWCAP2_SVEAES
>> hwcap.c:1174:30: error: 'HWCAP3_SVE_B16MM' undeclared here (not in a function); did you mean 'HWCAP2_SVE_B16B16'?
    1174 |                 .hwcap_bit = HWCAP3_SVE_B16MM,
         |                              ^~~~~~~~~~~~~~~~
         |                              HWCAP2_SVE_B16B16
   hwcap.c:1181:30: error: 'HWCAP_SVE_BFSCALE' undeclared here (not in a function)
    1181 |                 .hwcap_bit = HWCAP_SVE_BFSCALE,
         |                              ^~~~~~~~~~~~~~~~~
   hwcap.c:1188:30: error: 'HWCAP_SVE_ELTPERM' undeclared here (not in a function); did you mean 'HWCAP2_SVEBITPERM'?
    1188 |                 .hwcap_bit = HWCAP_SVE_ELTPERM,
         |                              ^~~~~~~~~~~~~~~~~
         |                              HWCAP2_SVEBITPERM
   hwcap.c:1195:30: error: 'HWCAP_SVE_F16MM' undeclared here (not in a function); did you mean 'HWCAP2_SVEF32MM'?
    1195 |                 .hwcap_bit = HWCAP_SVE_F16MM,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SVEF32MM
   hwcap.c:1202:30: error: 'HWCAP3_SVE_LUT6' undeclared here (not in a function); did you mean 'HWCAP2_SME_LUTV2'?
    1202 |                 .hwcap_bit = HWCAP3_SVE_LUT6,
         |                              ^~~~~~~~~~~~~~~
         |                              HWCAP2_SME_LUTV2
   hwcap.c:1286:30: error: 'HWCAP3_MTE_FAR' undeclared here (not in a function); did you mean 'HWCAP2_MTE'?
    1286 |                 .hwcap_bit = HWCAP3_MTE_FAR,
         |                              ^~~~~~~~~~~~~~
         |                              HWCAP2_MTE
   hwcap.c:1292:30: error: 'HWCAP3_MTE_STORE_ONLY' undeclared here (not in a function); did you mean 'PR_MTE_STORE_ONLY'?
    1292 |                 .hwcap_bit = HWCAP3_MTE_STORE_ONLY,
         |                              ^~~~~~~~~~~~~~~~~~~~~
         |                              PR_MTE_STORE_ONLY
   hwcap.c:1298:30: error: 'HWCAP3_LS64' undeclared here (not in a function); did you mean 'HWCAP_SM4'?
    1298 |                 .hwcap_bit = HWCAP3_LS64,
         |                              ^~~~~~~~~~~
         |                              HWCAP_SM4
--
   In file included from ./../../../../include/nolibc/std.h:19,
                    from ./../../../../include/nolibc/nolibc.h:95,
                    from <command-line>:
>> tools/include/linux/types.h:13:10: fatal error: asm/types.h: No such file or directory
      13 | #include <asm/types.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.
--
   libc-gcs.c: In function 'ptrace_read_write':
>> libc-gcs.c:143:25: error: storage size of 'child_gcs' isn't known
     143 |         struct user_gcs child_gcs;
         |                         ^~~~~~~~~
   libc-gcs.c:143:25: warning: unused variable 'child_gcs' [-Wunused-variable]
--
>> arm64/hypercalls.c:48:21: error: 'KVM_REG_ARM_VENDOR_HYP_BMAP_2' undeclared here (not in a function); did you mean 'KVM_REG_ARM_VENDOR_HYP_BMAP'?
      48 |         FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP_BMAP_2),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arm64/hypercalls.c:39:24: note: in definition of macro 'FW_REG_INFO'
      39 |                 .reg = r,                       \
         |                        ^
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics
--
   In file included from include/kvm_util.h:8,
                    from arm64/psci_test.c:18:
   arm64/psci_test.c: In function 'host_test_system_off2':
>> arm64/psci_test.c:264:57: error: 'KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2' undeclared (first use in this function); did you mean 'KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2'?
     264 |                 TEST_ASSERT(run->system_event.data[0] & KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2,
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/test_util.h:60:22: note: in definition of macro 'TEST_ASSERT'
      60 |         test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
         |                      ^
   arm64/psci_test.c:264:57: note: each undeclared identifier is reported only once for each function it appears in
     264 |                 TEST_ASSERT(run->system_event.data[0] & KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2,
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/test_util.h:60:22: note: in definition of macro 'TEST_ASSERT'
      60 |         test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
         |                      ^
   At top level:
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics
--
   arm64/vgic_v5.c: In function 'test_vgic_v5_ppis':
>> arm64/vgic_v5.c:124:29: error: 'KVM_DEV_ARM_VGIC_USERSPACE_PPIS' undeclared (first use in this function); did you mean 'KVM_DEV_ARM_VGIC_GRP_CPU_REGS'?
     124 |                             KVM_DEV_ARM_VGIC_USERSPACE_PPIS, &user_ppis);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                             KVM_DEV_ARM_VGIC_GRP_CPU_REGS
   arm64/vgic_v5.c:124:29: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics
--
   arm64/vpmu_counter_access.c: In function 'test_create_vpmu_vm_with_nr_counters':
>> arm64/vpmu_counter_access.c:476:38: error: 'KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS' undeclared (first use in this function); did you mean 'KVM_ARM_VCPU_PMU_V3_SET_PMU'?
     476 |                                      KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS, &nr_counters);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      KVM_ARM_VCPU_PMU_V3_SET_PMU
   arm64/vpmu_counter_access.c:476:38: note: each undeclared identifier is reported only once for each function it appears in
   arm64/vpmu_counter_access.c: In function 'kvm_supports_nr_counters_attr':
   arm64/vpmu_counter_access.c:619:45: error: 'KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS' undeclared (first use in this function); did you mean 'KVM_ARM_VCPU_PMU_V3_SET_PMU'?
     619 |                                             KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             KVM_ARM_VCPU_PMU_V3_SET_PMU
   At top level:
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics
..


vim +13 tools/include/linux/types.h

190d1c921ad086 tools/include/linux/types.h              Tiezhu Yang              2021-01-25  12  
5634bd7d2ab14f tools/lib/lockdep/uinclude/linux/types.h Sasha Levin              2013-06-13 @13  #include <asm/types.h>
67ef28794d7e30 tools/include/linux/types.h              Arnaldo Carvalho de Melo 2017-03-30  14  #include <asm/posix_types.h>
5634bd7d2ab14f tools/lib/lockdep/uinclude/linux/types.h Sasha Levin              2013-06-13  15  

:::::: The code at line 13 was first introduced by commit
:::::: 5634bd7d2ab14fbf736b62b0788fb68e2cb0fde2 liblockdep: Wrap kernel/locking/lockdep.c to allow usage from userspace

:::::: TO: Sasha Levin <sasha.levin@oracle.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA6C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179C22339D
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179C22339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 45BCC2094C;
	Wed, 20 Jan 2021 13:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcFKrWKG4J4y; Wed, 20 Jan 2021 13:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38BCC20778;
	Wed, 20 Jan 2021 13:26:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D440C0FA8;
	Wed, 20 Jan 2021 13:26:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63144C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A2D585F35
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7xYFgvZhDH7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3A6EA85F33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:16 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611149174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CpmyovsicWRsraKS/oNts+zojxJvItjt3KCZ7hy85ig=;
 b=YoQQYyi997NN0sL65a0YYcDujYywf5i4Ag7KpzfJ88RqXywvxFU4fjjUrkFdBLLs+2EdEe
 FmwSt0fjJPJqEsQNSSKHl7g8Q0WLZeDQLdTCe9dgWo8A2HWnLWPkj1p1QYY+Qctq5Ar+lD
 Wn2hf5TRnZUn4VzS1ZuroHV9nujUBC0=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0F7E4AAAE;
 Wed, 20 Jan 2021 13:26:14 +0000 (UTC)
To: bpetkov@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v4 00/15] x86: major paravirt cleanup
Date: Wed, 20 Jan 2021 14:25:58 +0100
Message-Id: <20210120132613.31487-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a major cleanup of the paravirt infrastructure aiming at
eliminating all custom code patching via paravirt patching.

This is achieved by using ALTERNATIVE instead, leading to the ability
to give objtool access to the patched in instructions.

In order to remove most of the 32-bit special handling from pvops the
time related operations are switched to use static_call() instead.

At the end of this series all paravirt patching has to do is to
replace indirect calls with direct ones. In a further step this could
be switched to static_call(), too, but that would require a major
header file disentangling.

For a clean build without any objtool warnings a modified objtool is
required. Currently this is available in the "tip" tree in the
objtool/core branch.

Changes in V4:
- fixed several build failures
- removed objtool patch, as objtool patches are in tip now
- added patch 1 for making usage of static_call easier
- even more cleanup

Changes in V3:
- added patches 7 and 12
- addressed all comments

Changes in V2:
- added patches 5-12

Juergen Gross (14):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call
  x86: rework arch_local_irq_restore() to not use popf
  x86/paravirt: switch time pvops functions to use static_call()
  x86/alternative: support "not feature" and ALTERNATIVE_TERNARY
  x86: add new features for paravirt patching
  x86/paravirt: remove no longer needed 32-bit pvops cruft
  x86/paravirt: simplify paravirt macros
  x86/paravirt: switch iret pvops to ALTERNATIVE
  x86/paravirt: add new macros PVOP_ALT* supporting pvops in
    ALTERNATIVEs
  x86/paravirt: switch functions with custom code to ALTERNATIVE
  x86/paravirt: have only one paravirt patch function

Peter Zijlstra (1):
  static_call: Pull some static_call declarations to the type headers

 arch/x86/Kconfig                        |   1 +
 arch/x86/entry/entry_32.S               |   4 +-
 arch/x86/entry/entry_64.S               |  28 ++-
 arch/x86/include/asm/alternative-asm.h  |   4 +
 arch/x86/include/asm/alternative.h      |   7 +
 arch/x86/include/asm/cpufeatures.h      |   2 +
 arch/x86/include/asm/idtentry.h         |   6 +
 arch/x86/include/asm/irqflags.h         |  53 ++----
 arch/x86/include/asm/mshyperv.h         |   2 +-
 arch/x86/include/asm/paravirt.h         | 197 ++++++++------------
 arch/x86/include/asm/paravirt_types.h   | 227 +++++++++---------------
 arch/x86/kernel/Makefile                |   3 +-
 arch/x86/kernel/alternative.c           |  49 ++++-
 arch/x86/kernel/asm-offsets.c           |   7 -
 arch/x86/kernel/asm-offsets_64.c        |   3 -
 arch/x86/kernel/cpu/vmware.c            |   5 +-
 arch/x86/kernel/irqflags.S              |  11 --
 arch/x86/kernel/kvm.c                   |   2 +-
 arch/x86/kernel/kvmclock.c              |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c    |   9 +
 arch/x86/kernel/paravirt.c              |  83 +++------
 arch/x86/kernel/paravirt_patch.c        | 109 ------------
 arch/x86/kernel/tsc.c                   |   2 +-
 arch/x86/xen/enlighten_pv.c             |  36 ++--
 arch/x86/xen/irq.c                      |  23 ---
 arch/x86/xen/time.c                     |  11 +-
 arch/x86/xen/xen-asm.S                  |  52 +-----
 arch/x86/xen/xen-ops.h                  |   3 -
 drivers/clocksource/hyperv_timer.c      |   5 +-
 drivers/xen/time.c                      |   2 +-
 include/linux/static_call.h             |  20 ---
 include/linux/static_call_types.h       |  27 +++
 tools/include/linux/static_call_types.h |  27 +++
 33 files changed, 376 insertions(+), 646 deletions(-)
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

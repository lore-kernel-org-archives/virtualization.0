Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0EBC2BB40
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:31:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30912388E
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30912388E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBFBB87A76;
	Thu, 17 Dec 2020 09:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ODLE-00QLxz; Thu, 17 Dec 2020 09:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85CD487A5A;
	Thu, 17 Dec 2020 09:31:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69FE3C1DA3;
	Thu, 17 Dec 2020 09:31:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2545EC088E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 002122E28C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ty5mEf4R5am
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id E6E782E289
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1608197506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E7FpqkqnD5unmDeE4sjWFYeLFL2ZgXDe6/5+3YmBT64=;
 b=a9yFTfK79u+NFXUZ4zWV8aHPpDUcRPDVvBCcSa9sHMiOYeRnwQj4sILTaezMzm4EYJQG+K
 gWtQy41s+pv/TtoyNIh8/P2b5G/eZiIFhJyS9RJs098dCw6tqaN2AHvfO5MUEHUwEaUz34
 +nKJxIVkWwafsJ2frUmJ4ePnkcxTR4M=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 44FF5B1A1;
 Thu, 17 Dec 2020 09:31:46 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v3 00/15] x86: major paravirt cleanup
Date: Thu, 17 Dec 2020 10:31:18 +0100
Message-Id: <20201217093133.1507-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Juri Lelli <juri.lelli@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 Juergen Gross <jgross@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
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
  objtool: Alternatives vs ORC, the hard way

 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/entry_32.S              |   4 +-
 arch/x86/entry/entry_64.S              |  26 ++-
 arch/x86/include/asm/alternative-asm.h |   3 +
 arch/x86/include/asm/alternative.h     |   7 +
 arch/x86/include/asm/cpufeatures.h     |   2 +
 arch/x86/include/asm/idtentry.h        |   6 +
 arch/x86/include/asm/irqflags.h        |  51 ++----
 arch/x86/include/asm/mshyperv.h        |  11 --
 arch/x86/include/asm/paravirt.h        | 157 ++++++------------
 arch/x86/include/asm/paravirt_time.h   |  38 +++++
 arch/x86/include/asm/paravirt_types.h  | 220 +++++++++----------------
 arch/x86/kernel/Makefile               |   3 +-
 arch/x86/kernel/alternative.c          |  59 ++++++-
 arch/x86/kernel/asm-offsets.c          |   7 -
 arch/x86/kernel/asm-offsets_64.c       |   3 -
 arch/x86/kernel/cpu/vmware.c           |   5 +-
 arch/x86/kernel/irqflags.S             |  11 --
 arch/x86/kernel/kvm.c                  |   3 +-
 arch/x86/kernel/kvmclock.c             |   3 +-
 arch/x86/kernel/paravirt.c             |  83 +++-------
 arch/x86/kernel/paravirt_patch.c       | 109 ------------
 arch/x86/kernel/tsc.c                  |   3 +-
 arch/x86/xen/enlighten_pv.c            |  36 ++--
 arch/x86/xen/irq.c                     |  23 ---
 arch/x86/xen/time.c                    |  12 +-
 arch/x86/xen/xen-asm.S                 |  52 +-----
 arch/x86/xen/xen-ops.h                 |   3 -
 drivers/clocksource/hyperv_timer.c     |   5 +-
 drivers/xen/time.c                     |   3 +-
 kernel/sched/sched.h                   |   1 +
 tools/objtool/check.c                  | 180 ++++++++++++++++++--
 tools/objtool/check.h                  |   5 +
 tools/objtool/orc_gen.c                | 178 +++++++++++++-------
 34 files changed, 627 insertions(+), 686 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt_time.h
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

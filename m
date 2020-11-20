Return-Path: <SRS0=8XPq=E2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED483C56202
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 11:46:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3536422253
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rHmTXjwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3536422253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79672870C8;
	Fri, 20 Nov 2020 11:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SnZ+alfa7BXN; Fri, 20 Nov 2020 11:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D373870AC;
	Fri, 20 Nov 2020 11:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA8DC1825;
	Fri, 20 Nov 2020 11:46:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 650E3C0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 11:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4943A870AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 11:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vcCCLwNxJzc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 11:46:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 372E2870AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 11:46:36 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1605872794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fjHe3+rmjY5cASW1XAPrcDHWzGbizvpE61ZYWB4j3cw=;
 b=rHmTXjwVBmFJKyhCEqOmhgg9FGZswY8WJdm/UueRf8DddoT49obCKWkkpulXZkEmbMyr53
 +tF6wEHiJQUjLKUN11yRtxzw2OPKHPWiM+6wvnAdRmBLFldnpbyUuBKOY+QFrHkVnZVwFO
 BIZuxt25L9jBmyI/EuK0mKwTZgHx17c=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C23BCAD57;
 Fri, 20 Nov 2020 11:46:33 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2 00/12] x86: major paravirt cleanup
Date: Fri, 20 Nov 2020 12:46:18 +0100
Message-Id: <20201120114630.13552-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Juri Lelli <juri.lelli@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 peterz@infradead.org, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 luto@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 Juergen Gross <jgross@suse.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
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

Note that an updated objtool is needed for this series, as otherwise
lots of warnings due to alternative instructions modifying the stack
will be issued during the build.

Changes in V2:
- added patches 5-12

Juergen Gross (12):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call
  x86: rework arch_local_irq_restore() to not use popf
  x86/paravirt: switch time pvops functions to use static_call()
  x86: add new features for paravirt patching
  x86/paravirt: remove no longer needed 32-bit pvops cruft
  x86/paravirt: switch iret pvops to ALTERNATIVE
  x86/paravirt: add new macros PVOP_ALT* supporting pvops in
    ALTERNATIVEs
  x86/paravirt: switch functions with custom code to ALTERNATIVE
  x86/paravirt: have only one paravirt patch function

 arch/x86/Kconfig                      |   1 +
 arch/x86/entry/entry_32.S             |   4 +-
 arch/x86/entry/entry_64.S             |  32 ++--
 arch/x86/include/asm/cpufeatures.h    |   3 +
 arch/x86/include/asm/idtentry.h       |   6 +
 arch/x86/include/asm/irqflags.h       |  51 ++----
 arch/x86/include/asm/mshyperv.h       |  11 --
 arch/x86/include/asm/paravirt.h       | 170 ++++++--------------
 arch/x86/include/asm/paravirt_time.h  |  38 +++++
 arch/x86/include/asm/paravirt_types.h | 222 ++++++++++++--------------
 arch/x86/kernel/Makefile              |   3 +-
 arch/x86/kernel/alternative.c         |  30 +++-
 arch/x86/kernel/asm-offsets.c         |   8 -
 arch/x86/kernel/asm-offsets_64.c      |   3 -
 arch/x86/kernel/cpu/vmware.c          |   5 +-
 arch/x86/kernel/head_64.S             |   2 -
 arch/x86/kernel/irqflags.S            |  11 --
 arch/x86/kernel/kvm.c                 |   3 +-
 arch/x86/kernel/kvmclock.c            |   3 +-
 arch/x86/kernel/paravirt.c            |  70 +++-----
 arch/x86/kernel/paravirt_patch.c      | 109 -------------
 arch/x86/kernel/tsc.c                 |   3 +-
 arch/x86/xen/enlighten_pv.c           |  36 +++--
 arch/x86/xen/irq.c                    |  23 ---
 arch/x86/xen/time.c                   |  12 +-
 arch/x86/xen/xen-asm.S                |  52 +-----
 arch/x86/xen/xen-ops.h                |   3 -
 drivers/clocksource/hyperv_timer.c    |   5 +-
 drivers/xen/time.c                    |   3 +-
 kernel/sched/sched.h                  |   1 +
 30 files changed, 325 insertions(+), 598 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt_time.h
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

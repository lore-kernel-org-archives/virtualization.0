Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA455C433E6
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 12:29:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5796651D1
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 12:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5796651D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4585F606F4;
	Mon,  8 Mar 2021 12:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YB93WuHZb6eg; Mon,  8 Mar 2021 12:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB67B60672;
	Mon,  8 Mar 2021 12:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C150CC0013;
	Mon,  8 Mar 2021 12:28:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CCE2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8524C605D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZDvfHdwOHamr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99A9260672
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615206531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pj0+lsoXMYSDviFMNu3CfGDulAqhBZd0duxurV0jt/k=;
 b=ullbjypHk4a2OSdXRZBXV7LzXx1wRPq0P3DUkuf3g00TxnX2Kvmikn2mvZgT5yu1bK+GT9
 Pb18L02feaPu+UmwjPoQNvBkbpJDORl8H6ArZ/XWAobYvxZmsd1kHtOeWcA3mN+bVvHI/I
 evXt2ltyGZ054ZgETkOoGM4IjjxGEog=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EE520ADCD;
 Mon,  8 Mar 2021 12:28:50 +0000 (UTC)
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v5 00/12] x86: major paravirt cleanup
Date: Mon,  8 Mar 2021 13:28:32 +0100
Message-Id: <20210308122844.30488-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Wanpeng Li <wanpengli@tencent.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 Russell King <linux@armlinux.org.uk>, "VMware, Inc." <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Nathan Chancellor <nathan@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jim Mattson <jmattson@google.com>,
 Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Sean Christopherson <seanjc@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
be switched to static_call(), too.

Changes in V5:
- patches 1-5 of V4 dropped, as already applied
- new patches 1+3
- fixed patch 2
- split V4 patch 8 into patches 4+5
- use flag byte instead of negative feature bit for "not feature"

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

Juergen Gross (12):
  staticcall: move struct static_call_key definition to
    static_call_types.h
  x86/paravirt: switch time pvops functions to use static_call()
  x86/alternative: drop feature parameter from ALTINSTR_REPLACEMENT()
  x86/alternative: support not-feature
  x86/alternative: support ALTERNATIVE_TERNARY
  x86: add new features for paravirt patching
  x86/paravirt: remove no longer needed 32-bit pvops cruft
  x86/paravirt: simplify paravirt macros
  x86/paravirt: switch iret pvops to ALTERNATIVE
  x86/paravirt: add new macros PVOP_ALT* supporting pvops in
    ALTERNATIVEs
  x86/paravirt: switch functions with custom code to ALTERNATIVE
  x86/paravirt: have only one paravirt patch function

 arch/arm/include/asm/paravirt.h               |  14 +-
 arch/arm/kernel/paravirt.c                    |   9 +-
 arch/arm64/include/asm/paravirt.h             |  14 +-
 arch/arm64/kernel/paravirt.c                  |  13 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/entry_32.S                     |   4 +-
 arch/x86/entry/entry_64.S                     |   2 +-
 arch/x86/include/asm/alternative-asm.h        |  10 +
 arch/x86/include/asm/alternative.h            |  28 ++-
 arch/x86/include/asm/cpufeature.h             |   2 +
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/irqflags.h               |   7 +-
 arch/x86/include/asm/mshyperv.h               |   2 +-
 arch/x86/include/asm/paravirt.h               | 167 +++++++-------
 arch/x86/include/asm/paravirt_types.h         | 210 +++++++-----------
 arch/x86/kernel/Makefile                      |   3 +-
 arch/x86/kernel/alternative.c                 |  37 ++-
 arch/x86/kernel/asm-offsets.c                 |   7 -
 arch/x86/kernel/cpu/vmware.c                  |   5 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/kvmclock.c                    |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c          |   9 +
 arch/x86/kernel/paravirt.c                    |  78 ++-----
 arch/x86/kernel/paravirt_patch.c              |  99 ---------
 arch/x86/kernel/tsc.c                         |   2 +-
 arch/x86/xen/enlighten_pv.c                   |   4 +-
 arch/x86/xen/time.c                           |  11 +-
 drivers/xen/time.c                            |   3 +-
 include/linux/static_call.h                   |  18 --
 include/linux/static_call_types.h             |  18 ++
 tools/include/linux/static_call_types.h       |  18 ++
 tools/objtool/arch/x86/include/arch/special.h |   6 +-
 32 files changed, 339 insertions(+), 468 deletions(-)
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

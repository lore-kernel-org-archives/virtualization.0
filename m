Return-Path: <SRS0=mL0J=HW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDFC433E0
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 23:22:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE5B64E44
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 23:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5B64E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10B8D83440
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 23:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id klFjN2j0Q0yi for <virtualization@archiver.kernel.org>;
	Sat, 20 Feb 2021 23:22:29 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 476DB8343E; Sat, 20 Feb 2021 23:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEAAF8341E;
	Sat, 20 Feb 2021 23:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FBA1C000A;
	Sat, 20 Feb 2021 23:22:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C038CC0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 23:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA6B785E51
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 23:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ojeKpO4vHFrD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 23:22:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C64F085E2B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 23:22:22 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id z68so7779949pgz.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ep1/hKudadrnwSmy7i9Qe1zqNMv0dz/lqPo/OEzQBLY=;
 b=Y5+H14gHGZgi0CNqllBjsnLBOhgoLpbYiHYC+nT+ktigN+4Fl8meG6ozXsst06ueyg
 FvbGHjyqEVyTHPB3Zp/v5zJBgju0J3MTawqo26iPtMIljoyQw5J1tDi3JCN/LxouS/67
 klSfhyjA0WlAiqToMlFX0eaeULuKmwtYr35j93DM4SArIGeRTKUvjtZCTmu8pQtz95mc
 zKlmH9HYQzFlX11KOMI08PJmn+exU7ZbXRN94aN7hiSJOXTCbgGEPd/DA5A9MX4Ou19E
 nctzTNhjKFOM2GpCZEVJiLc58qMaRY5BfZIfIevPc9WwHjjM/vaTFeQkkKNfQuiwZ549
 HuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ep1/hKudadrnwSmy7i9Qe1zqNMv0dz/lqPo/OEzQBLY=;
 b=p+fghn7XO7FFRhHjmc9uWJuIklqog4IeqwNNYsLff8h/5Lfj18ZEvFzXwdwBZlr3Wx
 l/4HthFInJCKZ212MK+lHlDQlISHjse/7KY4LMtztgNKPmmyT2CmP/czxXcxBOa/GmY/
 XTBukAaZJ7kL1ySq8b68eeYs8eH2R+8kBPX872J11xzM6gBM1LcNcH8LMO34TwWJPymr
 aFr3hGB1iOfn6bbHK98XgYrVa4ho4jUyky1pohlPzbsjnoEGprl6+zk9we/SJwoGITWf
 3Hz2PbFx+7M6H1uMh7rfv4s9RGh9nHp/eb1NrNwuqpY+f7tXka/Sg1ndKhxuVK/alGTH
 rLAQ==
X-Gm-Message-State: AOAM533G8ci1T75oGwhEmTGh3odd30wqeltQZWAl5OChXTT9zXrquT9D
 T4EUkFUKShBG/PA0gIwYwYU=
X-Google-Smtp-Source: ABdhPJxpOmWYOapxv+6DBYdb/cvr1/vWkG8h2RXX9Og2ITBxnK+Xono/2zD2+h9CTxu3Wx35RZTQdA==
X-Received: by 2002:a63:1648:: with SMTP id 8mr14414133pgw.392.1613863342154; 
 Sat, 20 Feb 2021 15:22:22 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Feb 2021 15:22:21 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] x86/tlb: Concurrent TLB flushes
Date: Sat, 20 Feb 2021 15:17:03 -0800
Message-Id: <20210220231712.2475218-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@surriel.com>,
 Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

From: Nadav Amit <namit@vmware.com>

The series improves TLB shootdown by flushing the local TLB concurrently
with remote TLBs, overlapping the IPI delivery time with the local
flush. Performance numbers can be found in the previous version [1].

v5 was rebased on 5.11 (long time after v4), and had some bugs and
embarrassing build errors. Peter Zijlstra and Christoph Hellwig had some
comments as well. These issues were addressed (excluding one 82-chars
line that I left). Based on their feedback, an additional patch was also
added to reuse on_each_cpu_cond_mask() code and avoid unnecessary calls
by inlining.

KernelCI showed RCU stalls on arm64, which I could not figure out from
the kernel splat. If this issue persists, I would appreciate it someone
can assist in debugging or at least provide the output when running the
kernel with CONFIG_CSD_LOCK_WAIT_DEBUG=Y.

[1] https://lore.kernel.org/lkml/20190823224153.15223-1-namit@vmware.com/

v5 -> v6:
* Address build warnings due to rebase mistakes
* Reuse code from on_each_cpu_cond_mask() and inline [PeterZ]
* Fix some style issues [Hellwig]

v4 -> v5:
* Rebase on 5.11
* Move concurrent smp logic to smp_call_function_many_cond() 
* Remove SGI-UV patch which is not needed anymore

v3 -> v4:
* Merge flush_tlb_func_local and flush_tlb_func_remote() [Peter]
* Prevent preemption on_each_cpu(). It is not needed, but it prevents
  concerns. [Peter/tglx]
* Adding acked-, review-by tags

v2 -> v3:
* Open-code the remote/local-flush decision code [Andy]
* Fix hyper-v, Xen implementations [Andrew]
* Fix redundant TLB flushes.

v1 -> v2:
* Removing the patches that Thomas took [tglx]
* Adding hyper-v, Xen compile-tested implementations [Dave]
* Removing UV [Andy]
* Adding lazy optimization, removing inline keyword [Dave]
* Restructuring patch-set

RFCv2 -> v1:
* Fix comment on flush_tlb_multi [Juergen]
* Removing async invalidation optimizations [Andy]
* Adding KVM support [Paolo]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org

Nadav Amit (9):
  smp: Run functions concurrently in smp_call_function_many_cond()
  x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
  x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Privatize cpu_tlbstate
  x86/mm/tlb: Do not make is_lazy dirty for no reason
  cpumask: Mark functions as pure
  x86/mm/tlb: Remove unnecessary uses of the inline keyword
  smp: inline on_each_cpu_cond() and on_each_cpu()

 arch/x86/hyperv/mmu.c                 |  10 +-
 arch/x86/include/asm/paravirt.h       |   6 +-
 arch/x86/include/asm/paravirt_types.h |   4 +-
 arch/x86/include/asm/tlbflush.h       |  48 ++++---
 arch/x86/include/asm/trace/hyperv.h   |   2 +-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/kernel/paravirt.c            |   2 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 176 +++++++++++++----------
 arch/x86/xen/mmu_pv.c                 |  11 +-
 include/linux/cpumask.h               |   6 +-
 include/linux/smp.h                   |  50 +++++--
 include/trace/events/xen.h            |   2 +-
 kernel/smp.c                          | 196 +++++++++++---------------
 15 files changed, 278 insertions(+), 250 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

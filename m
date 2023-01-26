Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C57C54E94
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 15:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B268841709;
	Thu, 26 Jan 2023 15:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B268841709
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HfMc4m9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EAUmhpS4WxWM; Thu, 26 Jan 2023 15:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38E53416FF;
	Thu, 26 Jan 2023 15:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38E53416FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E080C0077;
	Thu, 26 Jan 2023 15:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D243CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FEC1418EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FEC1418EA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=HfMc4m9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRiQxefHW31u
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 308AA4174F
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 308AA4174F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=eLqO1bA1ovJ6Tk3ye++iUoffczzuE9Es9NByP+7cFt8=; b=HfMc4m9Dr3GMuzid7iRyiLIvSz
 KcWcjJ+vXqxvH6l4bMC0kYM4TLvxE13XKgeiFngLSP/9uC2SCwPcg0yX6vwgoGJNssEBiRhX6b67J
 s2y50+62if5VJtHpjGNbnlB/vParYaoxFizVfooe0/2eCYroVVPDjeJiqh0oXqc7r910QLWj5uv29
 epzcJo21rMRwpLOlWQoHp6XaQ//OS128hlgMfSFFOa/9TdMxMDklWWJ1VQVOael72XRin5mgKFJeE
 r6qDmiz1TuhnJXPRWVYEMnfT49mFKRH0Gplmij47FlLlEIhTfnv+FfdZ8O3J3kDgGqggjpjB/Gouw
 I2INHJng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pL3xH-002U1e-2W; Thu, 26 Jan 2023 15:14:23 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26A49300577;
 Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 064C52084C4A7; Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Message-ID: <20230126150829.087606759@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 26 Jan 2023 16:08:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH v2 0/9] A few more cpuidle vs rcu fixes
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, lpieralisi@kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mingo@redhat.com,
 mgorman@suse.de, longman@redhat.com, frederic@kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org,
 linux-pm@vger.kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 bp@alien8.de, vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, pbonzini@redhat.com,
 bristot@redhat.com
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

0-day robot reported graph-tracing made the cpuidle-vs-rcu rework go splat.

These patches appear to cure this, the ftrace selftest now runs to completion
without spamming scary messages to dmesg.

Since v1:

 - fixed recursive RCU splats
 - fixed psci thingies for arm (null)
 - improved the tracing WARN (rostedt)
 - fixed TRACE_PREEMPT_TOGGLE (null)

---
 arch/x86/include/asm/atomic64_32.h | 44 +++++++++++++++++++-------------------
 arch/x86/include/asm/atomic64_64.h | 36 +++++++++++++++----------------
 arch/x86/include/asm/kvmclock.h    |  2 +-
 arch/x86/include/asm/paravirt.h    |  2 +-
 arch/x86/include/asm/pvclock.h     |  3 ++-
 arch/x86/kernel/cpu/vmware.c       |  2 +-
 arch/x86/kernel/kvmclock.c         |  6 +++---
 arch/x86/kernel/pvclock.c          | 22 +++++++++++++------
 arch/x86/kernel/tsc.c              |  7 +++---
 arch/x86/xen/time.c                | 12 +++++++++--
 drivers/cpuidle/cpuidle.c          |  2 +-
 drivers/cpuidle/poll_state.c       |  2 --
 drivers/firmware/psci/psci.c       | 31 ++++++++++++++++-----------
 include/linux/context_tracking.h   | 27 +++++++++++++++++++++++
 include/linux/math64.h             |  4 ++--
 include/linux/sched/clock.h        |  8 +++----
 include/linux/trace_recursion.h    | 18 ++++++++++++++++
 kernel/locking/lockdep.c           |  3 +++
 kernel/panic.c                     |  5 +++++
 kernel/sched/clock.c               | 27 +++++++++++++++++------
 kernel/trace/trace_preemptirq.c    |  6 ++----
 lib/bug.c                          | 15 ++++++++++++-
 22 files changed, 192 insertions(+), 92 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

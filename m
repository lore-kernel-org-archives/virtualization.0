Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F310CC05027
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 20:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 903348202F;
	Mon, 23 Jan 2023 20:58:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 903348202F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=beZJPCIE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9kqN-wK0KVs; Mon, 23 Jan 2023 20:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0CA658201B;
	Mon, 23 Jan 2023 20:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CA658201B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCEEEC0032;
	Mon, 23 Jan 2023 20:58:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01642C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D13C18201B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D13C18201B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2QYApsQA5ET
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9138182002
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9138182002
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=uxgezMurEELpCVJJhX20ZUHEfgwrZWcqXDjzle4mol8=; b=beZJPCIEffSubL1uEDVNCpWWAv
 P0dQItdbWMXkLzvxqxN2izB1koNs5fAWWajHR2whTbqKJ6BCHjRsJxhiPEu78EZrEYO9VnUzNs1jV
 ISCv4kk2PMiS1y+R0god9Q2UshUhc3v+9E1D8c/KhMmjB3VcrO2lD+rGXzF9ErdSbJeUfypKgj/gA
 uGlpDbbAacQ59wsPz0YUScLGqeC92KD9yrgIa+OQNAEnr9+y9dkwjhEcoMbSrLGc9te1y5cfctcbZ
 UiRYbMe0Uh7uSmNQAD5X0ax22AZZpnQSUguxrDFywdb9EDSq/d75ve4YkvjKrlhktiiG/LSojvFy3
 ULB3MkPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pK3sA-001dtn-07; Mon, 23 Jan 2023 20:57:02 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6266B300673;
 Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id BEE12207579DF; Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Message-ID: <20230123205009.790550642@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 23 Jan 2023 21:50:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH 0/6] A few cpuidle vs rcu fixes
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, bp@alien8.de,
 vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
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

---
 arch/x86/include/asm/atomic64_32.h | 44 +++++++++++++++++++-------------------
 arch/x86/include/asm/atomic64_64.h | 36 +++++++++++++++----------------
 arch/x86/include/asm/kvmclock.h    |  2 +-
 arch/x86/include/asm/paravirt.h    |  2 +-
 arch/x86/include/asm/pvclock.h     |  3 ++-
 arch/x86/kernel/cpu/vmware.c       |  2 +-
 arch/x86/kernel/ftrace.c           |  3 +++
 arch/x86/kernel/kvmclock.c         |  6 +++---
 arch/x86/kernel/pvclock.c          | 22 +++++++++++++------
 arch/x86/kernel/tsc.c              |  7 +++---
 arch/x86/xen/time.c                | 12 +++++++++--
 drivers/cpuidle/cpuidle.c          |  2 +-
 drivers/cpuidle/poll_state.c       |  2 --
 include/linux/math64.h             |  4 ++--
 include/linux/sched/clock.h        |  8 +++----
 kernel/sched/clock.c               | 27 +++++++++++++++++------
 16 files changed, 107 insertions(+), 75 deletions(-)


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

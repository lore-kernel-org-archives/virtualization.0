Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ECBC25B4E
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 16:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0635A40C87;
	Tue, 24 Jan 2023 16:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0635A40C87
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CeGKhKjfCJhZ; Tue, 24 Jan 2023 16:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 70C5B40591;
	Tue, 24 Jan 2023 16:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70C5B40591
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52649C0033;
	Tue, 24 Jan 2023 16:34:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2EDAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 16:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ED8A40C38
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 16:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ED8A40C38
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vh37EgI3LxWp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 16:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EA9C40591
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EA9C40591
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 16:34:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF014B3;
 Tue, 24 Jan 2023 08:35:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8FC83F5A1;
 Tue, 24 Jan 2023 08:34:25 -0800 (PST)
Date: Tue, 24 Jan 2023 16:34:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] A few cpuidle vs rcu fixes
Message-ID: <Y9AIj1s5iPPki3dK@FVFF77S0Q05N>
References: <20230123205009.790550642@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230123205009.790550642@infradead.org>
Cc: juri.lelli@redhat.com, daniel.lezcano@linaro.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, rafael@kernel.org, pv-drivers@vmware.com,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 bsegall@google.com, amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, bp@alien8.de,
 vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mhiramat@kernel.org,
 pbonzini@redhat.com, bristot@redhat.com
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

Hi Peter,

On Mon, Jan 23, 2023 at 09:50:09PM +0100, Peter Zijlstra wrote:
> 0-day robot reported graph-tracing made the cpuidle-vs-rcu rework go splat.

Do you have a link toe the splat somewhere?

I'm assuming that this is partially generic, and I'd like to make sure I test
the right thing on arm64. I'll throw my usual lockdep options at the ftrace
selftests...

Thanks,
Mark.

> 
> These patches appear to cure this, the ftrace selftest now runs to completion
> without spamming scary messages to dmesg.
> 
> ---
>  arch/x86/include/asm/atomic64_32.h | 44 +++++++++++++++++++-------------------
>  arch/x86/include/asm/atomic64_64.h | 36 +++++++++++++++----------------
>  arch/x86/include/asm/kvmclock.h    |  2 +-
>  arch/x86/include/asm/paravirt.h    |  2 +-
>  arch/x86/include/asm/pvclock.h     |  3 ++-
>  arch/x86/kernel/cpu/vmware.c       |  2 +-
>  arch/x86/kernel/ftrace.c           |  3 +++
>  arch/x86/kernel/kvmclock.c         |  6 +++---
>  arch/x86/kernel/pvclock.c          | 22 +++++++++++++------
>  arch/x86/kernel/tsc.c              |  7 +++---
>  arch/x86/xen/time.c                | 12 +++++++++--
>  drivers/cpuidle/cpuidle.c          |  2 +-
>  drivers/cpuidle/poll_state.c       |  2 --
>  include/linux/math64.h             |  4 ++--
>  include/linux/sched/clock.h        |  8 +++----
>  kernel/sched/clock.c               | 27 +++++++++++++++++------
>  16 files changed, 107 insertions(+), 75 deletions(-)
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

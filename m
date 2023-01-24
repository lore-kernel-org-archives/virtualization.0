Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB3EC54EB4
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 17:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD8B60D4F;
	Tue, 24 Jan 2023 17:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBD8B60D4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDkQW16i-TOe; Tue, 24 Jan 2023 17:12:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54B3960D60;
	Tue, 24 Jan 2023 17:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54B3960D60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B28AC0032;
	Tue, 24 Jan 2023 17:12:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCF1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 17:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 705E44181D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 17:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 705E44181D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LO2yGAUXTaMT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 17:12:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78ECE41797
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78ECE41797
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 17:12:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122154B3;
 Tue, 24 Jan 2023 09:13:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.85])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119773F64C;
 Tue, 24 Jan 2023 09:12:16 -0800 (PST)
Date: Tue, 24 Jan 2023 17:12:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
 <20230123165304.370121e7@gandalf.local.home>
 <20230123170753.7ac9419e@gandalf.local.home>
 <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
Cc: juri.lelli@redhat.com, daniel.lezcano@linaro.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, rafael@kernel.org, pv-drivers@vmware.com,
 dave.hansen@linux.intel.com, virtualization@lists.linux-foundation.org,
 bsegall@google.com, amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, Steven Rostedt <rostedt@goodmis.org>, bp@alien8.de,
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

On Tue, Jan 24, 2023 at 03:44:35PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 23, 2023 at 05:07:53PM -0500, Steven Rostedt wrote:
> 
> > Actually, perhaps we can just add this, and all you need to do is create
> > and set CONFIG_NO_RCU_TRACING (or some other name).
> 
> Elsewhere I've used CONFIG_ARCH_WANTS_NO_INSTR for this.

Yes please; if we use CONFIG_ARCH_WANTS_NO_INSTR then arm64 will get this "for
free" once we add the missing checks (which I assume we need) in our ftrace_prepare_return().

> Anyway, I took it for a spin and it .... doesn't seems to do the job.
> 
> With my patch the first splat is
> 
>   "RCU not on for: cpuidle_poll_time+0x0/0x70"
> 
> While with yours I seems to get the endless:
> 
>   "WARNING: suspicious RCU usage"
> 
> thing. Let me see if I can figure out where it goes side-ways.

Hmmm... for WARN_ONCE() don't we need to wake RCU first also? I thought we
needed that at least for the printk machinery?

Thanks,
Mark.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

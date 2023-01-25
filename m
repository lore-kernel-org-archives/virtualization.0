Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381CC54E94
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 09:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A416D405AB;
	Wed, 25 Jan 2023 09:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A416D405AB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=VjGhy5k2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fej57BrV0RkZ; Wed, 25 Jan 2023 09:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E687B403CA;
	Wed, 25 Jan 2023 09:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E687B403CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8316C0033;
	Wed, 25 Jan 2023 09:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBABC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2655E6112B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2655E6112B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=VjGhy5k2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vkguti9xVlpW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C5E661122
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C5E661122
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZUwU0WfkKuo04fSMmIA984hyf8mGmOMaibahgi/MR9o=; b=VjGhy5k2GGPJtyEAcXhtVe1y86
 YWkKQl2Dj9L5P8Bop7IG+5350+plG+8Yt9TqP4lJ/9AfCFbWi7xMhyicDB1SQHl5gRoQ0QKz6XO0s
 Ui98kZYYu090lV1JgqytIPzdA4qH+PdegoNvxmwB/Wi8MKeJ8rJmwKgh/E6kaMTyryv+Ete23mmCW
 lZmY1xIdXKXVwGhdRpOSVuzfNMWoTqc2PporOHz67C2dvoKVcNodvHZjpBgImidwaiMvFbEqXvOy1
 boagX1cr+WFtT34yyhHqvTZ2mQ2WF7yOM+/gRoZFispOjoh7wYvJWQFfpqCbOEavg0/xtYpe5KcxV
 GZV7RTAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pKcDF-005odN-75; Wed, 25 Jan 2023 09:37:01 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8C37300137;
 Wed, 25 Jan 2023 10:37:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 91F8820774388; Wed, 25 Jan 2023 10:37:00 +0100 (CET)
Date: Wed, 25 Jan 2023 10:37:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <Y9D4PIZacXgWapWX@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
 <20230123165304.370121e7@gandalf.local.home>
 <20230123170753.7ac9419e@gandalf.local.home>
 <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
 <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9ARbgtYhxSuOIlZ@FVFF77S0Q05N>
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

On Tue, Jan 24, 2023 at 05:12:14PM +0000, Mark Rutland wrote:
> On Tue, Jan 24, 2023 at 03:44:35PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 23, 2023 at 05:07:53PM -0500, Steven Rostedt wrote:
> > 
> > > Actually, perhaps we can just add this, and all you need to do is create
> > > and set CONFIG_NO_RCU_TRACING (or some other name).
> > 
> > Elsewhere I've used CONFIG_ARCH_WANTS_NO_INSTR for this.
> 
> Yes please; if we use CONFIG_ARCH_WANTS_NO_INSTR then arm64 will get this "for
> free" once we add the missing checks (which I assume we need) in our ftrace_prepare_return().

Aye.

> > Anyway, I took it for a spin and it .... doesn't seems to do the job.
> > 
> > With my patch the first splat is
> > 
> >   "RCU not on for: cpuidle_poll_time+0x0/0x70"
> > 
> > While with yours I seems to get the endless:
> > 
> >   "WARNING: suspicious RCU usage"
> > 
> > thing. Let me see if I can figure out where it goes side-ways.
> 
> Hmmm... for WARN_ONCE() don't we need to wake RCU first also? I thought we
> needed that at least for the printk machinery?

Yeah, I'm currently running with a hacked up printk that redirects
everything into early_printk() but it still trips up lots.

I was just about to go stick on RCU magic into WARN itself, this isn't
going to be the only site triggering this fail-cascade.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

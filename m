Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F03C54E94
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 09:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ECC5417A9;
	Wed, 25 Jan 2023 09:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ECC5417A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q2Pmhn3hcwSe; Wed, 25 Jan 2023 09:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82D1D4173A;
	Wed, 25 Jan 2023 09:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82D1D4173A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69888C0033;
	Wed, 25 Jan 2023 09:36:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F63C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 256166112B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 256166112B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CU7KkOfLFl4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 053D661122
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 053D661122
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 09:36:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E4D4B3;
 Wed, 25 Jan 2023 01:36:57 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.209])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0903F5A1;
 Wed, 25 Jan 2023 01:36:11 -0800 (PST)
Date: Wed, 25 Jan 2023 09:36:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] A few cpuidle vs rcu fixes
Message-ID: <Y9D4CJMvV4Jv3iMs@FVFF77S0Q05N>
References: <20230123205009.790550642@infradead.org>
 <Y9AIj1s5iPPki3dK@FVFF77S0Q05N>
 <Y9D2/TcAJUPVWasU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9D2/TcAJUPVWasU@hirez.programming.kicks-ass.net>
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

On Wed, Jan 25, 2023 at 10:31:41AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 24, 2023 at 04:34:23PM +0000, Mark Rutland wrote:
> > Hi Peter,
> > 
> > On Mon, Jan 23, 2023 at 09:50:09PM +0100, Peter Zijlstra wrote:
> > > 0-day robot reported graph-tracing made the cpuidle-vs-rcu rework go splat.
> > 
> > Do you have a link toe the splat somewhere?
> > 
> > I'm assuming that this is partially generic, and I'd like to make sure I test
> > the right thing on arm64. I'll throw my usual lockdep options at the ftrace
> > selftests...
> 
> 0-day triggered this by running tools/testing/selftests/ftrace/ftracetest,
> which is what I've been using to reproduce.
> 
> If that don't work for you I can try and dig out the 0day email to see
> if it has more details on.

I had a go running those on arm64, but got different splats (as per my other
replies), so I just wanted to see the backtraces and/or config to check I
wasn't missing something due to CONFIG_* or arch differences.

If you have the email to hand, that'd be great, but don't worry too much about
it!

Thanks,
Mark.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

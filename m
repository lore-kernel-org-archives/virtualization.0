Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E4C433FE
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 23:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDEE860F3C;
	Wed, 27 Apr 2022 23:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZqaYne9brTU; Wed, 27 Apr 2022 23:10:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62C4360C26;
	Wed, 27 Apr 2022 23:10:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42FDEC0032;
	Wed, 27 Apr 2022 23:10:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE80C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4454D832AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="hQC4wdHr";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="GNkovCpO"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOM9ncc-59i3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23C8C826FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 23:10:27 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651101023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0f+m2Dqb3x2CVJe4DM+W9cwvXPiNqPC/6H9asGUciw=;
 b=hQC4wdHr3uIvFPLUK37KcFVlQVbuVrdB2JhO9mWr032woo0CTs1XzrrJ9w8d51QXkif9AL
 iqq/CtSS3SAVCOsErIZhntagIalkjek2CKzYlZKbY+1yquvkEQ+SYGxLFEeOfB9K8/iuiJ
 sJTeeJ3hD6Z+Wnv3S4GSGuF5a9lTEeyQcTKwL6ILvd79BejzkSsxSC6T5rE5aZP3TBP/n3
 +jg4S8nbkCWy5yCMu6ql/RNoji2O4gWL9/3jqEHHpACl6ssvK5LjT19uU9SgW5SHZbttuD
 IIpdWuU+v3ZLfrZlGAvsGInIufO9oQU50N6f2e5WaZw6mwwzzdp4oghy6QGLww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651101023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0f+m2Dqb3x2CVJe4DM+W9cwvXPiNqPC/6H9asGUciw=;
 b=GNkovCpOnyHDDop7r43RmNJOWpj1X6I0zE9A0pAj3SrYiDPcex+a91CWpFL9fN5aLfGBcx
 y5Us2rg+kicvELDA==
To: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds
 as a perf event clock
In-Reply-To: <c8033229-97a0-3e4c-66d5-74c0d1d4e15c@intel.com>
References: <20220214110914.268126-1-adrian.hunter@intel.com>
 <20220214110914.268126-4-adrian.hunter@intel.com>
 <YiIXFmA4vpcTSk2L@hirez.programming.kicks-ass.net>
 <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
 <YiXVgEk/1UClkygX@hirez.programming.kicks-ass.net>
 <30383f92-59cb-2875-1e1b-ff1a0eacd235@intel.com>
 <YiYZv+LOmjzi5wcm@hirez.programming.kicks-ass.net>
 <013b5425-2a60-e4d4-b846-444a576f2b28@intel.com>
 <6f07a7d4e1ad4440bf6c502c8cb6c2ed@intel.com>
 <c3e1842b-79c3-634a-3121-938b5160ca4c@intel.com>
 <50fd2671-6070-0eba-ea68-9df9b79ccac3@intel.com> <87ilqx33vk.ffs@tglx>
 <ff1e190a-95e6-e2a6-dc01-a46f7ffd2162@intel.com> <87fsm114ax.ffs@tglx>
 <c8033229-97a0-3e4c-66d5-74c0d1d4e15c@intel.com>
Date: Thu, 28 Apr 2022 01:10:23 +0200
Message-ID: <87ee1iw2ao.ffs@tglx>
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, H Peter Anvin <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, "Hall,
 Christopher S" <christopher.s.hall@intel.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Leo Yan <leo.yan@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Borislav Petkov <bp@alien8.de>, "jgross@suse.com" <jgross@suse.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "seanjc@google.com" <seanjc@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Andrew.Cooper3@citrix.com" <Andrew.Cooper3@citrix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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

On Tue, Apr 26 2022 at 09:51, Adrian Hunter wrote:
> On 25/04/22 20:05, Thomas Gleixner wrote:
>> On Mon, Apr 25 2022 at 16:15, Adrian Hunter wrote:
>>> On 25/04/22 12:32, Thomas Gleixner wrote:
>>>> It's hillarious, that we still cling to this pvclock abomination, while
>>>> we happily expose TSC deadline timer to the guest. TSC virt scaling was
>>>> implemented in hardware for a reason.
>>>
>>> So you are talking about changing VMX TCS Offset on every VM-Entry to try to hide
>>> the time jumps when the VM is scheduled out?  Or neglect that and just let the time
>>> jumps happen?
>>>
>>> If changing VMX TCS Offset, how can TSC be kept consistent between each VCPU i.e.
>>> wouldn't that mean each VCPU has to have the same VMX TSC Offset?
>> 
>> Obviously so. That's the only thing which makes sense, no?
>
> [ Sending this again, because I notice I messed up the email "From" ]
>
> But wouldn't that mean changing all the VCPUs VMX TSC Offset at the same time,
> which means when none are currently executing?  How could that be done?

Why would you change TSC offset after the point where a VM is started
and why would it be different per vCPU?

Time is global and time moves on when a vCPU is scheduled out. Anything
else is bonkers, really. If the hypervisor tries to screw with that then
how does the guest do timekeeping in a consistent way?

    CLOCK_REALTIME = CLOCK_MONOTONIC + offset

That offset changes when something sets the clock, i.e. clock_settime(),
settimeofday() or adjtimex() in case that NTP cannot compensate or for
the beloved leap seconds adjustment. At any other time the offset is
constant.

CLOCK_MONOTONIC is derived from the underlying clocksource which is
expected to increment with constant frequency and that has to be
consistent accross _all_ vCPUs of a particular VM.

So how would a hypervisor 'hide' scheduled out time w/o screwing up
timekeeping completely?

The guest TSC which is based on the host TSC is:

    guestTSC = offset + hostTSC * factor;

If you make offset different between guest vCPUs then timekeeping in the
guest is screwed.

The whole point of that paravirt clock was to handle migration between
hosts which did not have the VMCS TSC scaling/offset mechanism. The CPUs
which did not have that went EOL at least 10 years ago.

So what are you concerned about?

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

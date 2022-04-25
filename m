Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17684C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 09:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C38B4095F;
	Mon, 25 Apr 2022 09:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ0oZn_zyndF; Mon, 25 Apr 2022 09:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CABA840943;
	Mon, 25 Apr 2022 09:32:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9395FC0039;
	Mon, 25 Apr 2022 09:32:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09495C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB91E817B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="vHXQxaUe";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="kUMwfiHv"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BDbtr7FpCubY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27A9D817AD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:32:19 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1650879136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuS0+eUzG5BtLo3Moko/17XZLrJRu9fvWmqLPOFEyN8=;
 b=vHXQxaUeaHvw4Xiz9T9MB1+1qh9heHJPy5Tp0CxvFSUhFNU5qp75M1qmmCTZjp7fcr03Mc
 DjknOq742hHhWHCgVaUqMV5QYSrIp6361DJQhPOALiJckLkC991h1Mr+42ApMWH56Vfh0F
 7mJgACdr44D8eYg66nI9zAzAHbIRuN0HHI7/UlQdX3VS2B+Oxyebso3Qtgag9Mt6iViyab
 tDG0GB7ENzwrMSP5r4Wy5a7tNw9Jkkj9NVzO1e9h5xHJNjukYDva81fOLEsZmohq7W4tqx
 xUNit134OoWKy6uGvAEiiM4f36FVlZMnbhZSJ7iGgnU26PD+j+n99dbSgNUjng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1650879136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuS0+eUzG5BtLo3Moko/17XZLrJRu9fvWmqLPOFEyN8=;
 b=kUMwfiHvNx/7GQIpsSk2x/vGiCdnpXgig/ECozp+dMy2shcP4mvjucEJMnNWIM28e3948x
 PtvRHTt5Spu12GCw==
To: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds
 as a perf event clock
In-Reply-To: <50fd2671-6070-0eba-ea68-9df9b79ccac3@intel.com>
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
 <50fd2671-6070-0eba-ea68-9df9b79ccac3@intel.com>
Date: Mon, 25 Apr 2022 11:32:15 +0200
Message-ID: <87ilqx33vk.ffs@tglx>
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

On Mon, Apr 25 2022 at 08:30, Adrian Hunter wrote:
> On 14/03/22 13:50, Adrian Hunter wrote:
>>> TSC offsetting may also be a problem. The VMCS TSC offset must be discoverable by the
>>> guest. This can be done via TSC_ADJUST MSR. The offset in the VMCS and the guest
>>> TSC_ADJUST MSR must always be equivalent, i.e. a write to TSC_ADJUST in the guest
>>> must be reflected in the VMCS and any changes to the offset in the VMCS must be
>>> reflected in the TSC_ADJUST MSR. Otherwise a para-virtualized method must
>>> be invented to communicate an arbitrary VMCS TSC offset to the guest.
>>>
>> 
>> In my view it is reasonable for perf to support TSC as a perf clock in any case
>> because:
>> 	a) it allows users to work entirely with TSC if they wish
>> 	b) other kernel performance / debug facilities like ftrace already support TSC
>> 	c) the patches to add TSC support are relatively small and straight-forward
>> 
>> May we have support for TSC as a perf event clock?
>
> Any update on this?

If TSC is reliable on the host, then there is absolutely no reason not
to use it in the guest all over the place. And that is independent of
exposing ART to the guest.

So why do we need extra solutions for PT and perf, ftrace and whatever?

Can we just fix the underlying problem and make the hypervisor tell the
guest that TSC is stable, reliable and good to use?

Then everything else just falls into place and using TSC is a
substantial performance gain in general. Just look at the VDSO
implementation of __arch_get_hw_counter() -> vread_pvclock():

Instead of just reading the TSC, this needs to take a nested seqcount,
read TSC and do yet another mult/shift, which makes clock_gettime() ~20%
slower than necessary.

It's hillarious, that we still cling to this pvclock abomination, while
we happily expose TSC deadline timer to the guest. TSC virt scaling was
implemented in hardware for a reason.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

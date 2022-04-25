Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D78CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 17:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9540402DC;
	Mon, 25 Apr 2022 17:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sobXBfpWChaH; Mon, 25 Apr 2022 17:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53D51400D1;
	Mon, 25 Apr 2022 17:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09BF1C0032;
	Mon, 25 Apr 2022 17:06:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D98C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 17:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20CB14087D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 17:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="kOy/628P";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="rWgCcD6e"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eh-CzXIw8Hwm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 17:06:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B802240876
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 17:06:02 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1650906359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUDdu1OQnuiL9GvFQHLzieqdApEYcfcerAmFX1ae7Fo=;
 b=kOy/628PH7EV8vd8Bt7kZYGVV4HH2pzB4IOTaqLluAxvnHwNnpQgoIs22zk31UBsLyiO+g
 pawUq2PFZuAhwQYxXo2cs7jipQTA4E3eFOYp8u3t/RoivhkrCf5YorU/t3tH5W4NX/IpTm
 TKM/NYt8SjOfKI3TzCEp1ds+AU0Iw8xTIbAI4UfR0iawo9YEe4k+ML9D4Z8QR+Ylv2KQM2
 o5tkv5qW+yvlsjcCEu/7ahiIBuqOyLV83Mxe1aXMquFFyuYKauKIey7Gb0RkvSeywP3pZD
 6+F5lyl9VUiubCZbFwfoOUZ/ZEpARHDC4VKKOw6F/pPiB10jkkCjW4jC2oyG5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1650906359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZUDdu1OQnuiL9GvFQHLzieqdApEYcfcerAmFX1ae7Fo=;
 b=rWgCcD6eod8vPhzNBba08C1rj2XHbFC5P7XdDbrtkk5CwN0PDscGntrk8gXPB4CyWzdoyQ
 YnRFHLfe4Mhyn7AQ==
To: Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds
 as a perf event clock
In-Reply-To: <ff1e190a-95e6-e2a6-dc01-a46f7ffd2162@intel.com>
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
 <ff1e190a-95e6-e2a6-dc01-a46f7ffd2162@intel.com>
Date: Mon, 25 Apr 2022 19:05:58 +0200
Message-ID: <87fsm114ax.ffs@tglx>
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

On Mon, Apr 25 2022 at 16:15, Adrian Hunter wrote:
> On 25/04/22 12:32, Thomas Gleixner wrote:
>> It's hillarious, that we still cling to this pvclock abomination, while
>> we happily expose TSC deadline timer to the guest. TSC virt scaling was
>> implemented in hardware for a reason.
>
> So you are talking about changing VMX TCS Offset on every VM-Entry to try to hide
> the time jumps when the VM is scheduled out?  Or neglect that and just let the time
> jumps happen?
>
> If changing VMX TCS Offset, how can TSC be kept consistent between each VCPU i.e.
> wouldn't that mean each VCPU has to have the same VMX TSC Offset?

Obviously so. That's the only thing which makes sense, no?

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

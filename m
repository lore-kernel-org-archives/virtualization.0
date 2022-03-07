Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5592DC433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 14:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14EA660E74;
	Mon,  7 Mar 2022 14:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80KNNXivy45T; Mon,  7 Mar 2022 14:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AFE5460E5F;
	Mon,  7 Mar 2022 14:42:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77CCFC0012;
	Mon,  7 Mar 2022 14:42:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA279C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 14:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A07EA409E3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 14:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzA7cSF_OC_2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 14:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D40EA4092D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dAZkd94tzcRdvRieKkWfcBkJvTkJnK9zBdITPJgPy6s=; b=mO9oSmUesbbSZM3vVK9HyTDYQq
 cK133canotMxKAZ16MzaSlEApH4hnCI5CtCI6hsR7A6tEwzzsv4IUQX/bl6HD1kjRWY8887uvn+2T
 6NUL7IIKV2it7/I+weTmFjEISS2i+GL1jllaCYFkdDROh+x3SM/j3u7m+tqv/+FnetomUX4A/TD5d
 RZonGU9B6SYDqGlYKFlkw77GZX99AJNEzK3XSLH0Io9vhxjZ8fdzQtQuh9Zf2X+C0UPRfn1u5d6WU
 xjS+BbZau/KIePTW8IudpNYy23HvK5oMyvndoV6Ov7JQBcwckuExbphCZQ6DwAiYLY67gF7wrnebe
 NbU6hTmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nREYr-00FIlv-LY; Mon, 07 Mar 2022 14:42:09 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 462BC300169;
 Mon,  7 Mar 2022 15:42:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 30A5B203C59BB; Mon,  7 Mar 2022 15:42:07 +0100 (CET)
Date: Mon, 7 Mar 2022 15:42:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds as
 a perf event clock
Message-ID: <YiYZv+LOmjzi5wcm@hirez.programming.kicks-ass.net>
References: <20220214110914.268126-1-adrian.hunter@intel.com>
 <20220214110914.268126-4-adrian.hunter@intel.com>
 <YiIXFmA4vpcTSk2L@hirez.programming.kicks-ass.net>
 <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
 <YiXVgEk/1UClkygX@hirez.programming.kicks-ass.net>
 <30383f92-59cb-2875-1e1b-ff1a0eacd235@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30383f92-59cb-2875-1e1b-ff1a0eacd235@intel.com>
Cc: kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, H Peter Anvin <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, christopher.s.hall@intel.com,
 sthemmin@microsoft.com, x86@kernel.org, pv-drivers@vmware.com,
 Ingo Molnar <mingo@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew.Cooper3@citrix.com,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 jgross@suse.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
 seanjc@google.com, linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
 pbonzini@redhat.com
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

On Mon, Mar 07, 2022 at 02:36:03PM +0200, Adrian Hunter wrote:

> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index 4420499f7bb4..a1f179ed39bf 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -145,6 +145,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
> >  
> >  void paravirt_set_sched_clock(u64 (*func)(void))
> >  {
> > +	/*
> > +	 * Anything with ART on promises to have sane TSC, otherwise the whole
> > +	 * ART thing is useless. In order to make ART useful for guests, we
> > +	 * should continue to use the TSC. As such, ignore any paravirt
> > +	 * muckery.
> > +	 */
> > +	if (cpu_feature_enabled(X86_FEATURE_ART))
> 
> Does not seem to work because the feature X86_FEATURE_ART does not seem to get set.
> Possibly because detect_art() excludes anything running on a hypervisor.

Simple enough to delete that clause I suppose. Christopher, what is
needed to make that go away? I suppose the guest needs to be aware of
the active TSC scaling parameters to make it work ?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

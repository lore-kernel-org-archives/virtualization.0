Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA078C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 09:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5531360AC0;
	Mon,  7 Mar 2022 09:51:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTvTeQcflB8Y; Mon,  7 Mar 2022 09:51:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1C7560B17;
	Mon,  7 Mar 2022 09:51:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C62ADC001D;
	Mon,  7 Mar 2022 09:51:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81F17C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C27740991
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3U-YDl10WOea
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:51:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F6CB4047D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=F33OJew4f+X9EGyrX9UFDzNmD+8SJD5GlTnGdBvVako=; b=l29VVU0vNjudQfmRlD//2Ai5r4
 Rb+GvW9iJclOfRU4GCvEkvP37BglXQGkWNdbR9UtqNDH7Bd7uNMQTzk6GQO/3RrgBAK92YJPN+Gxz
 hmdhnmemQGbjdAakq68Sl3xDp2W7oSx7yoYDF+U55QRcn1hqpaDZX/h1Zyw3Sv7rLP/+rdGyTBYZA
 irmfqZgm8l2HmkKiZZ31K7VhEMil+fheol+qvc06hlmbEo4d8FiIGMLtmGd3lA47z7T/HYJz48Sge
 QILp/zYvt2fLhpl9YQcEH7SYyGRpLEYHP4sDoMdMnAg5VRIOhIN4hykzWAtmP/fB3VicXW0j1V6fh
 ioJsNaJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRA16-00F53J-8g; Mon, 07 Mar 2022 09:51:00 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 513993002BE;
 Mon,  7 Mar 2022 10:50:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id EC3C92BA7BE19; Mon,  7 Mar 2022 10:50:56 +0100 (CET)
Date: Mon, 7 Mar 2022 10:50:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds as
 a perf event clock
Message-ID: <YiXVgEk/1UClkygX@hirez.programming.kicks-ass.net>
References: <20220214110914.268126-1-adrian.hunter@intel.com>
 <20220214110914.268126-4-adrian.hunter@intel.com>
 <YiIXFmA4vpcTSk2L@hirez.programming.kicks-ass.net>
 <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
Cc: kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, H Peter Anvin <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, sthemmin@microsoft.com, x86@kernel.org,
 pv-drivers@vmware.com, Ingo Molnar <mingo@redhat.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
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

On Fri, Mar 04, 2022 at 08:27:45PM +0200, Adrian Hunter wrote:
> On 04/03/2022 15:41, Peter Zijlstra wrote:
> > On Mon, Feb 14, 2022 at 01:09:06PM +0200, Adrian Hunter wrote:
> >> Currently, when Intel PT is used within a VM guest, it is not possible to
> >> make use of TSC because perf clock is subject to paravirtualization.
> > 
> > Yeah, so how much of that still makes sense, or ever did? AFAIK the
> > whole pv_clock thing is utter crazy. Should we not fix that instead?
> 
> Presumably pv_clock must work with different host operating systems.
> Similarly, KVM must work with different guest operating systems.
> Perhaps I'm wrong, but I imagine re-engineering time virtualization
> might be a pretty big deal,  far exceeding the scope of these patches.

I think not; on both counts. That is, I don't think it's going to be
hard, and even it if were, it would still be the right thing to do.

We're not going to add interface just to work around a known broken
piece of crap just because we don't want to fix it.

So I'm thinking we should do the below and simply ignore any paravirt
sched clock offered when there's ART on.

---
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4420499f7bb4..a1f179ed39bf 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -145,6 +145,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void))
 {
+	/*
+	 * Anything with ART on promises to have sane TSC, otherwise the whole
+	 * ART thing is useless. In order to make ART useful for guests, we
+	 * should continue to use the TSC. As such, ignore any paravirt
+	 * muckery.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_ART))
+		return;
+
 	static_call_update(pv_sched_clock, func);
 }
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

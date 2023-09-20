Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8378AC00E86
	for <virtualization@archiver.kernel.org>; Wed, 20 Sep 2023 15:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18CEC83AA3;
	Wed, 20 Sep 2023 15:28:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18CEC83AA3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=oK8vRjz6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2lsIoh-gzMYx; Wed, 20 Sep 2023 15:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9AD2883A67;
	Wed, 20 Sep 2023 15:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AD2883A67
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 701A7C0071;
	Wed, 20 Sep 2023 15:28:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C589BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BDFB418B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BDFB418B0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=oK8vRjz6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-yHRh2zDgxc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:28:45 +0000 (UTC)
X-Greylist: delayed 2149 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 20 Sep 2023 15:28:45 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3293441830
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3293441830
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZerJcnOhEvUGAjVvFDnt+ED8Lu+58HuQE4rkQfwGHOA=; b=oK8vRjz6Cd8f7av9WAZ5MrtvDW
 ibgh94KLBV8bt3XT/9afi1rlEMXon7JYGg022FAXhUQZjpxFY0xwx6vKCjVnzWjaj1Wf05zIekyP+
 7Tdo8to/IC62m6luX7US+MvBnpB5L+C5sRZGxmzkbD1eLLHMxatdmUuwEwjYb1jgWR+CK6y35zJk/
 Jqpg71tlE334dkhfQmcvC+yZTUBqEThAiih5oPlNhMoCKZFNJgWxLQFXYYZItL9o229FD8LorfdgL
 PQsAN960x2p15PJgxMjFr6zjsjVxfLazY91uScz7lkmL9lJrXIg3ghzbHk6i7YEspFdVx8Fq2lCyU
 ooWAy3kA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qiyYv-00EfZI-0q; Wed, 20 Sep 2023 14:52:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5EBD4300348; Wed, 20 Sep 2023 16:52:22 +0200 (CEST)
Date: Wed, 20 Sep 2023 16:52:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 3/3] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20230920145222.GB6687@noisy.programming.kicks-ass.net>
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-4-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230608140333.4083-4-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Jun 08, 2023 at 04:03:33PM +0200, Juergen Gross wrote:
> Instead of stacking alternative and paravirt patching, use the new
> ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> handling.
> 
> This eliminates the need to be careful regarding the sequence of
> alternative and paravirt patching.
> 
> For call depth tracking callthunks_setup() needs to be adapted to patch
> calls at alternative patching sites instead of paravirt calls.
> 
> Remove the no longer needed paravirt patching and related code.

I think this becomes easier if you first convert the paravirt sites to
alternatives, such that .parainstructions is empty, and then in a
subsequent patch remove all the paravirt infrastructure that is unused.


> +#define SAVE_FLAGS	ALTERNATIVE_2 "PARA_IRQ_save_fl;", ALT_CALL_INSTR, \
> +				      ALT_CALL_ALWAYS, "pushf; pop %rax;", \
> +				      ALT_NOT(X86_FEATURE_XENPV)

I find this more readable when written as:

#define SAVE_FLAGS	ALTERNATIVE_2 "PARA_IRQ_save_fl;",		\
				      ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
				      "pushf; pop %rax;", ALT_NOT(X86_FEATURE_XENPV)

(and perhaps ALT_NOT_XEN is in order, there's a ton of those)

If you base this on top of the nested alternative patches, another
helper might be:

#define __PV_ALTERNATIVE(old) __ALTERNATIVE(old, ALT_CALL_INSTR, ALT_CALL_ALWAYS)

So that you can then write:

#define SAVE_FLAGS	__ALTERNATIVE(__PV_ALTERNATIVE("PARA_IRQ_save_fl;"),
				      "pushf; pop %rax;", ALT_NOT_XEN)

But perhaps I'm over-cooking things now..

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

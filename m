Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54575CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 14:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8D3161152;
	Mon, 16 Oct 2023 14:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8D3161152
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LrTFuBbd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32gjEXmckAGv; Mon, 16 Oct 2023 14:29:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D50DF60804;
	Mon, 16 Oct 2023 14:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D50DF60804
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5955C0039;
	Mon, 16 Oct 2023 14:29:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E25CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C94160A5E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C94160A5E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8xh8PKxa5mp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:29:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE6B760804
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE6B760804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=B/JtpSz8CEkmRWnZdqd1OQD4JeY2o/nJxZnD6jFtD5k=; b=LrTFuBbdE5IjuU1lZ/JnjiSAOK
 vAifrVSR8wcZtnJ3q8249rp+3LjtarQIJvV1EJwPZMMuKyXz95KOH4/Cic8L8Fr5iOw/814PXQKVB
 Mnh3DAEDMscwj+00gC1w4wDa1OqNj+Fq/Lw8EVCd2YWoc2kJHbpeS9JFvjSAiD6QmdR6yIIueE0Up
 suCBe6lp5qxZkX+E5UJIZJCRoc4oy5uaYFWhV5B2epDO3j+m7hVydzduAxckPofRg59aXuAKhTsqj
 NvjkBgPgC4Fo5+1RSFqD8OK4rbMn38W+0HHlPaLE2bh7P2kNfQSKpemB8/pGIz2Wpmj+qZsLOR/go
 jL0P7fZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qsOb3-0066HR-18; Mon, 16 Oct 2023 14:29:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 740E9300513; Mon, 16 Oct 2023 16:29:30 +0200 (CEST)
Date: Mon, 16 Oct 2023 16:29:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20231016142930.GE33217@noisy.programming.kicks-ass.net>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231016123933.17284-4-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Oct 16, 2023 at 02:39:32PM +0200, Juergen Gross wrote:
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
> Signed-off-by: Juergen Gross <jgross@suse.com>

I cannot help but feel this would've been better as two patches, one
introducing ALT_NOT_XEN and then a second with the rest.

Regardless,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

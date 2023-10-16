Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB4ECDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 14:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B33394086A;
	Mon, 16 Oct 2023 14:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B33394086A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=O31yErO/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2FTCSMfMwXB; Mon, 16 Oct 2023 14:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1068F4058C;
	Mon, 16 Oct 2023 14:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1068F4058C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD50C0039;
	Mon, 16 Oct 2023 14:30:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ED5DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 561C640609
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 561C640609
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=O31yErO/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVdvM-H8qGDm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:30:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BBB0400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 14:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BBB0400C8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zarD/HuhsSVSqIGKf90N63+KfWcfgRI/tr5iKpowNVc=; b=O31yErO/+COk+OBHNtinP52gCk
 og8hkHJPGKWLTcgcbxxSQPnyQiyF6t0QrKFzc8FfgrEEPFWTJxKAl7tVKHzr1RD6HAimWz0kc09Dp
 C4V40cEFswAMnfHgKnJAIpN/M80N1bOi1qVHxmr4wA/Z1iKTxGYBDWPQt4yg2sJHnmBmLIXaJsf2B
 iNPxx8NT9U6ZT/LcwHzoQs/kt5hXhkPI0Drj+gJh4rCYwPBE8B85QutV5nXruYEwRZYPijTKg6YQy
 8jlaOq1cFlzuKl1rtutA9LWPZ/1lVft5pUDjEhYZrbhahTnp9cE5g+3aQ9n6FzTeeCsbiLoz/q+Ar
 jbwbwXCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qsObn-0066IZ-0P; Mon, 16 Oct 2023 14:30:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 380FB300513; Mon, 16 Oct 2023 16:30:16 +0200 (CEST)
Date: Mon, 16 Oct 2023 16:30:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 4/4] x86/paravirt: remove no longer needed paravirt
 patching code
Message-ID: <20231016143016.GF33217@noisy.programming.kicks-ass.net>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-5-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231016123933.17284-5-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alexey Makhalov <amakhalov@vmware.com>,
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

On Mon, Oct 16, 2023 at 02:39:33PM +0200, Juergen Gross wrote:
> Now that paravirt is using the alternatives patching infrastructure,
> remove the paravirt patching code.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt.h       | 18 --------
>  arch/x86/include/asm/paravirt_types.h | 40 ----------------
>  arch/x86/include/asm/text-patching.h  | 12 -----
>  arch/x86/kernel/alternative.c         | 66 +--------------------------
>  arch/x86/kernel/paravirt.c            | 30 ------------
>  arch/x86/kernel/vmlinux.lds.S         | 13 ------
>  arch/x86/tools/relocs.c               |  2 +-
>  7 files changed, 3 insertions(+), 178 deletions(-)

More - more better! :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

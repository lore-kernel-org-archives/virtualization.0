Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7CC47082
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5586124C
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5586124C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 885984044B;
	Tue,  8 Jun 2021 12:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4h74DLGRs6D; Tue,  8 Jun 2021 12:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF09540441;
	Tue,  8 Jun 2021 12:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D64EAC000B;
	Tue,  8 Jun 2021 12:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2112C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1BB9834E8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98QDrUsB91IF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:00:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAB3383BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DycXleRZZakhNiWk5mkor9tyBuVnVqL3f4nz52Lyagk=; b=irluC+5RhkL+SPw7n56VFsnUa3
 A6KF3/s55ZYxA0h5WQdhlc9VxpnlqkRu8nOP51S/dNz3A31rBJK6S9oxeXGYaBp6omXkVTaJtnaPw
 sA1CuBszTSMZ3el0Og5AtmMUvXw9lHXRA54lx5KW7ZWSbHHNWG26SdVzjtdysBJ8qwWorblycsHxN
 KhZg4ubvQ5PehEEmgLmsFlvxhCaqrZc9CbL+PnsrR/1+U96Fd3vRr5MZ1qfG9jrGeGPfTFHGnjecO
 zmVJFh+nFBQ4uPBzaNuwZQj30AOVpu0rSVoXC11jIOWeScueEcUp1GtrrMROKzQ31brpts3R0AhuL
 +n5P3vXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lqaNc-00Gu7t-CN; Tue, 08 Jun 2021 11:58:53 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34544300258;
 Tue,  8 Jun 2021 13:58:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1DF2722B9AE15; Tue,  8 Jun 2021 13:58:47 +0200 (CEST)
Date: Tue, 8 Jun 2021 13:58:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 4/7] x86/sev-es: Run #VC handler in plain IRQ state
Message-ID: <YL9bd2hx/y9oD6x/@hirez.programming.kicks-ass.net>
References: <20210608095439.12668-1-joro@8bytes.org>
 <20210608095439.12668-5-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608095439.12668-5-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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

On Tue, Jun 08, 2021 at 11:54:36AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use irqentry_enter() and irqentry_exit() to track the runtime state of
> the #VC handler. The reason it ran in NMI mode was solely to make sure
> nothing interrupts the handler while the GHCB is in use.
> 
> This is handled now in sev_es_get/put_ghcb() directly, so there is no
> reason the #VC handler can not run in normal IRQ mode and enjoy the
> benefits like being able to send signals.

You sure?

So #VC cannot happen with IRQs disabled?

	raw_spin_lock_irq(&my_lock);
	<#VC>
		raw_spin_lock_irqsave(&my_lock); // whoopsie

Every exception that can happen with IRQs disabled must be NMI like.

Again, what you seem to want is to split the handler in a from-user and
from-kernel way, just like we did with #DB and MCE. See how
exc_debug_user() is IRQ-like and can send signals, while
exc_debug_kernel() is NMI like and can not.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

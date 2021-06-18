Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061AAC48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:55:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7B360FF0
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7B360FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6395E414B9;
	Fri, 18 Jun 2021 10:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cODFFuS8yRI; Fri, 18 Jun 2021 10:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6B8A40235;
	Fri, 18 Jun 2021 10:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 898DDC000D;
	Fri, 18 Jun 2021 10:55:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07048C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0164A414B9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9T_Oz0toZ47T
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:54:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F324540535
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WXE8AGIvrigHAr3bWkiTQ8lrgYlIfDElqocU4mw+Hqk=; b=DBRrSrmnwX8IhMiypDyD/kXhC7
 +boU6L8ETBEcjztGRQxBjSlCAbA0dNg+PYtDCa9zkXGFl9+6xm7LV524fQHHUqQnkDWzrM8FqdDjk
 JdRZJ7WUVY76TE1Kz5ykIqdg1rDwG0YFzK0qwfj7hpejRnN0r+WC/tEcTo8MzAEfkzgtuS0Q5kxU6
 jrgt0fnGeAbRQhWAQ6AGQsnErqOtDZNrPkzdcC0CJlqp2fZyh5pOzrj5Y689ksfCS33EhcPTfJBLl
 kS3udIaHPKp7tXH3iYPKg/nhK/ix+2GMxD3rQ/AvsSAawuMlYlzL5+kCvt5gefxG79tasJ4B+EblB
 2bdHZdbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luC7v-00AAwD-3g; Fri, 18 Jun 2021 10:53:46 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21546300204;
 Fri, 18 Jun 2021 12:53:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 063ED21BD53A7; Fri, 18 Jun 2021 12:53:29 +0200 (CEST)
Date: Fri, 18 Jun 2021 12:53:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 1/2] x86/sev: Make sure IRQs are disabled while GHCB
 is active
Message-ID: <YMx7KDtf7S0W8oxy@hirez.programming.kicks-ass.net>
References: <20210616184913.13064-1-joro@8bytes.org>
 <20210616184913.13064-2-joro@8bytes.org>
 <YMtshtgEbiQ993Zk@hirez.programming.kicks-ass.net>
 <YMxWsjZcudaorPgV@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMxWsjZcudaorPgV@8bytes.org>
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

On Fri, Jun 18, 2021 at 10:17:54AM +0200, Joerg Roedel wrote:
> On Thu, Jun 17, 2021 at 05:38:46PM +0200, Peter Zijlstra wrote:
> > I'm getting (with all of v6.1 applied):
> > 
> > vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x1bf: call to panic() leaves .noinstr.text section
> > 
> > $ ./scripts/faddr2line defconfig-build/vmlinux __sev_es_nmi_complete+0x1bf
> > __sev_es_nmi_complete+0x1bf/0x1d0:
> > __sev_get_ghcb at arch/x86/kernel/sev.c:223
> > (inlined by) __sev_es_nmi_complete at arch/x86/kernel/sev.c:519
> 
> I see where this is coming from, but can't create the same warning. I
> did run 'objtool check -n vmlinux'. Is there more to do to get the full
> check?

You get those when you enable CONFIG_DEBUG_ENTRY=y (make sure to have
PARAVIRT=n, I so need to go fix that :/).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

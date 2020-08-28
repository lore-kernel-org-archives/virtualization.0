Return-Path: <SRS0=Pzcc=CG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F0C433E6
	for <virtualization@archiver.kernel.org>; Fri, 28 Aug 2020 12:33:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78C52078A
	for <virtualization@archiver.kernel.org>; Fri, 28 Aug 2020 12:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78C52078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC1D7203CA;
	Fri, 28 Aug 2020 12:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqJ+-RP7Ha5v; Fri, 28 Aug 2020 12:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F36A0203AF;
	Fri, 28 Aug 2020 12:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3CFFC07FF;
	Fri, 28 Aug 2020 12:33:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D58A4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 12:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B9DF18815D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 12:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wdy9mtNoNEB0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 12:33:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CC5BD88165
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 12:33:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1F45E2E1; Fri, 28 Aug 2020 14:33:07 +0200 (CEST)
Date: Fri, 28 Aug 2020 14:33:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v6 27/76] x86/sev-es: Add CPUID handling to #VC handler
Message-ID: <20200828123304.GD13881@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-28-joro@8bytes.org>
 <20200827224810.GA986963@rani.riverdale.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827224810.GA986963@rani.riverdale.lan>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
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

On Thu, Aug 27, 2020 at 06:48:10PM -0400, Arvind Sankar wrote:
> On Mon, Aug 24, 2020 at 10:54:22AM +0200, Joerg Roedel wrote:
> > From: Tom Lendacky <thomas.lendacky@amd.com>
> > 
> > Handle #VC exceptions caused by CPUID instructions. These happen in
> > early boot code when the KASLR code checks for RDTSC.
> > 
> > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> > [ jroedel@suse.de: Adapt to #VC handling framework ]
> > Co-developed-by: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > Link: https://lore.kernel.org/r/20200724160336.5435-27-joro@8bytes.org
> > ---
> > +
> > +static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
> > +				      struct es_em_ctxt *ctxt)
> > +{
> > +	struct pt_regs *regs = ctxt->regs;
> > +	u32 cr4 = native_read_cr4();
> > +	enum es_result ret;
> > +
> > +	ghcb_set_rax(ghcb, regs->ax);
> > +	ghcb_set_rcx(ghcb, regs->cx);
> > +
> > +	if (cr4 & X86_CR4_OSXSAVE)
> 
> Will this ever happen? trampoline_32bit_src will clear CR4 except for
> PAE and possibly LA57, no?

This same code is later re-used in the runtime handler and there the
check is needed :)

Regards,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

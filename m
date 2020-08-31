Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19027C433E6
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 08:58:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A62206F0
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 08:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A62206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA13686174;
	Mon, 31 Aug 2020 08:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4MCJax9QNXy; Mon, 31 Aug 2020 08:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF3928601E;
	Mon, 31 Aug 2020 08:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89F3CC07FF;
	Mon, 31 Aug 2020 08:58:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28638C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 08:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 120DF87648
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 08:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EmYcSq5wmHqi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 08:58:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 577ED87532
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 08:58:16 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4F673310; Mon, 31 Aug 2020 10:58:13 +0200 (CEST)
Date: Mon, 31 Aug 2020 10:58:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 38/76] x86/head/64: Set CR4.FSGSBASE early
Message-ID: <20200831085810.GA13507@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-39-joro@8bytes.org>
 <20200829155525.GB29091@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200829155525.GB29091@zn.tnic>
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

On Sat, Aug 29, 2020 at 05:55:25PM +0200, Borislav Petkov wrote:
> On Mon, Aug 24, 2020 at 10:54:33AM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Early exception handling will use rd/wrgsbase in paranoid_entry/exit.
> > Enable the feature to avoid #UD exceptions on boot APs.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > Link: https://lore.kernel.org/r/20200724160336.5435-38-joro@8bytes.org
> > ---
> >  arch/x86/kernel/head_64.S | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index 08412f308de3..4622940134a5 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -153,6 +153,13 @@ SYM_CODE_START(secondary_startup_64)
> >  	orl	$X86_CR4_LA57, %ecx
> >  1:
> >  #endif
> > +
> > +	ALTERNATIVE "jmp .Lstartup_write_cr4", "", X86_FEATURE_FSGSBASE
> > +
> > +	/* Early exception handling uses FSGSBASE on APs */
> > +	orl	$X86_CR4_FSGSBASE, %ecx
> 
> How is this supposed to work?
> 
> Alternatives haven't run that early yet and that piece of code looks
> like this:
> 
> ffffffff81000067:       eb 06                   jmp    ffffffff8100006f <secondary_startup_64+0x1f>
> ffffffff81000069:       81 c9 00 00 01 00       or     $0x10000,%ecx
> ffffffff8100006f:       0f 22 e1                mov    %rcx,%cr4
> 
> so we'll never set X86_CR4_FSGSBASE during early boot.

This is not needed on the boot CPU, but only on secondary CPUs. When
those are brought up the alternatives have been patches already. The
commit message should probably be more clear about that, I will fix
that.

The CR4 bit also can't be set unconditionally here on the boot CPU,
because at that point the kernel does not know whether the CPU has
support for the fsgsbase instructions.


Regards,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

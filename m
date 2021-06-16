Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655FC48BE8
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:01:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD2361245
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD2361245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 809BE83B97;
	Wed, 16 Jun 2021 19:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbLtaHtCD3oZ; Wed, 16 Jun 2021 19:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DBF883B43;
	Wed, 16 Jun 2021 19:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2500C000E;
	Wed, 16 Jun 2021 19:01:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 316D6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 170C983B97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1qhxZvBxAvx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:01:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A05A83B43
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:01:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5BDFA387; Wed, 16 Jun 2021 21:01:31 +0200 (CEST)
Date: Wed, 16 Jun 2021 21:01:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/6] x86/sev-es: Split up runtime #VC handler for
 correct state tracking
Message-ID: <YMpKim/3Dc41xvF7@8bytes.org>
References: <20210614135327.9921-1-joro@8bytes.org>
 <20210614135327.9921-4-joro@8bytes.org>
 <YMohCkW/mChNpkqi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMohCkW/mChNpkqi@hirez.programming.kicks-ass.net>
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

Hi Peter,

sorry, missed this email before sending out v6.

On Wed, Jun 16, 2021 at 06:04:26PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 14, 2021 at 03:53:24PM +0200, Joerg Roedel wrote:
> >  _ASM_NOKPROBE(\asmsym)
> >  SYM_CODE_END(\asmsym)
> 
> Consistency with idtentry_mce_db would seem to suggest using \cfunc and
> noist_\cfunc.
> 
> amluto, tglx: do we have strong feelings on consistency?

Yeah, but this distinction does not make sense here, as none of the #VC
handlers C functions run on the actual #VC IST stack. The from-kernel
function might run on the fall-back stack (not really possible today
unless the hypervisor does something nasty). And the difference between
the fall-back stack and the actual IST stack is, that on the fall-back
stack nesting #VC exceptions is still supported.

> > +	vc_handle_trap_db(regs);
> 
> It's a bit sad this does user_mode(regs) again.

Okay, I will change this according your comments.

Thanks,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

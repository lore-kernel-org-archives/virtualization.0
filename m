Return-Path: <SRS0=mw42=CF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5101C433E4
	for <virtualization@archiver.kernel.org>; Thu, 27 Aug 2020 09:37:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782F620738
	for <virtualization@archiver.kernel.org>; Thu, 27 Aug 2020 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a4ec/EYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782F620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6518F8823B;
	Thu, 27 Aug 2020 09:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQBX6j-qj1xt; Thu, 27 Aug 2020 09:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F97E883E1;
	Thu, 27 Aug 2020 09:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 587D8C016F;
	Thu, 27 Aug 2020 09:37:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA92EC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B94758651C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wXNuJtzXBSe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:36:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 952E686651
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:36:55 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1045007cf9313b25892ea2.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:4500:7cf9:313b:2589:2ea2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CB081EC037C;
 Thu, 27 Aug 2020 11:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598521012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=rwtDHHfiouipWty6o59Fe2PscF08QBczZyo5miFFKr0=;
 b=a4ec/EYCvKRS1JSxVRYSp3Flhd6Q/yeMEqdmJJAMUCy1FA0FEVUUjztCgyK6EI0QIhMUvf
 CLVOCKWZp+oON7tq2VvCNybGGPw+Ie0Ax+fXiRPLJ9CB03ogfq3iYPxDtBBaeuyUVXK56Z
 aL3jV/cI3fI3+mNYBD7acUKehQL1utw=
Date: Thu, 27 Aug 2020 11:36:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 20/76] x86/boot/compressed/64: Call
 set_sev_encryption_mask earlier
Message-ID: <20200827093649.GA30897@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-21-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-21-joro@8bytes.org>
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

On Mon, Aug 24, 2020 at 10:54:15AM +0200, Joerg Roedel wrote:

Just minor style issues to be fixed by committer or in case you have to
send a new version:

Subject: Re: [PATCH v6 20/76] x86/boot/compressed/64: Call set_sev_encryption_mask earlier

set_sev_encryption_mask() <- it is a function.

> From: Joerg Roedel <jroedel@suse.de>
> 
> Call set_sev_encryption_mask() while still on the stage 1 #VC-handler,
> because the stage 2 handler needs our own page-tables to be set up, to

"... needs the kernel's own page tables to be set up... "

"we" is almost always ambiguous and should be avoided by formulating the
commit message in passive voice.

> which calling set_sev_encryption_mask() is a prerequisite.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Link: https://lore.kernel.org/r/20200724160336.5435-20-joro@8bytes.org
> ---
>  arch/x86/boot/compressed/head_64.S      | 8 +++++++-
>  arch/x86/boot/compressed/ident_map_64.c | 3 ---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 013b29921836..c7fcf60cbd08 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -533,9 +533,15 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  	rep	stosq
>  
>  /*
> - * Load stage2 IDT and switch to our own page-table
> + * If running as an SEV guest, the encryption mask is required in the
> + * page-table setup code below. When the guest also has SEV-ES enabled
> + * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
> + * handler can't map its GHCB because the page-table is not set up yet.
> + * So set up the encryption mask here while still on the stage1 #VC
> + * handler. Then load stage2 IDT and switch to our own page-table.

	... to the kernel's own page table."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

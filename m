Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EF8C6FD1F
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 13:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8952A4198F;
	Thu,  9 Mar 2023 13:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8952A4198F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=Xvvea0lD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwxT2ZAjRGhJ; Thu,  9 Mar 2023 13:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD6E541960;
	Thu,  9 Mar 2023 13:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD6E541960
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D644C0071;
	Thu,  9 Mar 2023 13:46:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBE8AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 13:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A850160D65
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 13:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A850160D65
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=dkim header.b=Xvvea0lD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXR9mkDIJDv8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 13:46:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30A5360BD9
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30A5360BD9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 13:46:36 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D91A1EC018C;
 Thu,  9 Mar 2023 14:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1678369194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=VLc25eAd2+rDBm5cmMoscmu24c7mmoaCQZea5e70buI=;
 b=Xvvea0lDwN+ZaGnmHcFGpTJ22O7VfIQNHD9CMhTzUCT6N54b8zjlQHaxCOgIY4h+YTKmTP
 z6sIgqCqU4r07P6HoSjfqVHNvAj33tqb3afOt0yczXeSQJj4XyDhmrhOdl2+XTctx/24f4
 exk4r/wrDTpZu9CRAJThU532fjnOFc0=
Date: Thu, 9 Mar 2023 14:39:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230309133950.GDZAnhpnon5fk4Fg/X@fat_crate.local>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Alexey Makhalov <amakhalov@vmware.com>,
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

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:
> All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
> functions, as those functions calls are hidden from gcc. In case the
> kernel is compiled with "-fzero-call-used-regs" the compiler will
> clobber caller-saved registers at the end of C functions, which will
> result in unexpectedly zeroed registers at the call site of the
> related paravirt functions.
> 
> Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
> the same instructions as the related paravirt calls in the
> PVOP_ALT_[V]CALLEE*() macros.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt_types.h |  8 +++++++-
>  arch/x86/kernel/paravirt.c            | 27 ++++++---------------------
>  2 files changed, 13 insertions(+), 22 deletions(-)

Right, works with my particular reproducer.

Turning them into asm prevents the compiler from doing the
callee-clobbered zeroing and that's fine as this whole paravirt gunk is
hiding the "CALL" insn from it and you putting them in asm is in line
with this.

And a negative diffstat..

So yeah, I'll queue it soon unless someone objects.

Long term, I think we should continue switching all that pv stuff to
using the alternatives.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

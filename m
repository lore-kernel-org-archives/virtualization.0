Return-Path: <SRS0=QmqV=FB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E501C2D0E4
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 11:32:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7CD20674
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H3DZCuzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7CD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E4482E305;
	Fri, 27 Nov 2020 11:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyA0uuNzCFLU; Fri, 27 Nov 2020 11:32:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 93A2D2E2F9;
	Fri, 27 Nov 2020 11:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 757FFC163C;
	Fri, 27 Nov 2020 11:32:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2109C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 11:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 883582E2F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 11:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6Mt3La9tjcV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 11:32:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id A14762E301
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 11:32:06 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0ffb00d5ac34a4508c2f14.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:fb00:d5ac:34a4:508c:2f14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8BD21EC0323;
 Fri, 27 Nov 2020 12:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606476722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ugdjThtrhUGuPIVjsesMvfGYF6EvCSTLiEMoM1kV7p0=;
 b=H3DZCuzv0GbI72+5hcncMOCBvU3bwbQjV3Xg05BJXfrUY9iAwMey2+iadrW0uv0ZNz8JVW
 H5tHbow1z7hsKPg3aLpNWsikw0IR8bez7Yd35BVVGZVFqwLMPfDKicMg1TIF3sq/9OMGYs
 yNNdq7lFily/ytxwflNIuveYBKeRHuc=
Date: Fri, 27 Nov 2020 12:31:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 03/12] x86/pv: switch SWAPGS to ALTERNATIVE
Message-ID: <20201127113156.GB13163@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-4-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120114630.13552-4-jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>, luto@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

On Fri, Nov 20, 2020 at 12:46:21PM +0100, Juergen Gross wrote:
> SWAPGS is used only for interrupts coming from user mode or for
> returning to user mode. So there is no reason to use the PARAVIRT
> framework, as it can easily be replaced by an ALTERNATIVE depending
> on X86_FEATURE_XENPV.
> 
> There are several instances using the PV-aware SWAPGS macro in paths
> which are never executed in a Xen PV guest. Replace those with the
> plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S             | 10 +++++-----
>  arch/x86/include/asm/irqflags.h       | 20 ++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 --------------------
>  arch/x86/include/asm/paravirt_types.h |  2 --
>  arch/x86/kernel/asm-offsets_64.c      |  1 -
>  arch/x86/kernel/paravirt.c            |  1 -
>  arch/x86/kernel/paravirt_patch.c      |  3 ---
>  arch/x86/xen/enlighten_pv.c           |  3 ---
>  8 files changed, 13 insertions(+), 47 deletions(-)

I love patches like this one! Give me more...

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

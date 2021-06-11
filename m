Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9287C48BD1
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 14:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6247461403
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 14:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6247461403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BFCE83E01;
	Fri, 11 Jun 2021 14:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qGbAw6CwosXb; Fri, 11 Jun 2021 14:05:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E0D5B83DF5;
	Fri, 11 Jun 2021 14:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E61C000E;
	Fri, 11 Jun 2021 14:05:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6761CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52289414B2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9YizE_IBHJ3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:05:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C6815406AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 14:05:26 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0aec00c954d2edeb094cfc.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0a:ec00:c954:d2ed:eb09:4cfc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17BCC1EC053C;
 Fri, 11 Jun 2021 16:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1623420323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=jjSbtHxfmAfGqMirhGR6ZtzrOk/6dDWM66vpfU14tVE=;
 b=H7E8yAP84yciTlUXqurgT+uzQ8Jh3nsdJ2rmPMVBRLA8UcEs3g67Rg3SeS7mW5IaAAYxuH
 Dzedmq7mXio6AZo7zjHw3oneDcZRubs3Q0xDV7FdVLYDDwwVVSHiUALCmvPluchMv2uh0N
 sqBFsV1ziNuq79mr3wsF1RgQRHNE3OA=
Date: Fri, 11 Jun 2021 16:05:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 2/6] x86/sev-es: Disable IRQs while GHCB is active
Message-ID: <YMNtmz6W1apXL5q+@zn.tnic>
References: <20210610091141.30322-1-joro@8bytes.org>
 <20210610091141.30322-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610091141.30322-3-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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

On Thu, Jun 10, 2021 at 11:11:37AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The #VC handler only cares about IRQs being disabled while the GHCB is
> active, as it must not be interrupted by something which could cause
> another #VC while it holds the GHCB (NMI is the exception for which the
> backup GHCB is there).
> 
> Make sure nothing interrupts the code path while the GHCB is active by
> disabling IRQs in sev_es_get_ghcb() and restoring the previous irq state
> in sev_es_put_ghcb().

Why this unnecessarily complicated passing of flags back and forth?

Why not simply "sandwich" them:

	local_irq_save()
	sev_es_get_ghcb()

	...blablabla

	sev_es_put_ghcb()
	local_irq_restore();

in every call site?

What's the difference in passing *flags in and have the
get_ghcb/put_ghcb save/restore flags instead of the callers?

> -static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
> +static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state,
> +						    unsigned long *flags)
>  {
>  	struct sev_es_runtime_data *data;
>  	struct ghcb *ghcb;
>  
> +	/*
> +	 * Nothing shall interrupt this code path while holding the per-cpu
> +	 * GHCB. The backup GHCB is only for NMIs interrupting this path.

Hmm, so why aren't you accessing/setting data->ghcb_active and
data->backup_ghcb_active safely using cmpxchg() if this path can be
interrupted by an NMI?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

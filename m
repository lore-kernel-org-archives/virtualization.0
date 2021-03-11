Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF21C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 12:50:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141E64FC3
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 12:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D141E64FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A53947A19;
	Thu, 11 Mar 2021 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7YTwoK1-fvgF; Thu, 11 Mar 2021 12:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B252E44A94;
	Thu, 11 Mar 2021 12:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89219C000C;
	Thu, 11 Mar 2021 12:50:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98658C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 12:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77C5247A19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 12:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uT1vUrmPsaRR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 12:50:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D523944A94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 12:50:33 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0e1f0084acfb80b2ea2480.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:1f00:84ac:fb80:b2ea:2480])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 570341EC04C0;
 Thu, 11 Mar 2021 13:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1615467030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=YQoMnM+JalduchtvnnRdDi537/sQjYe69dpZBUUIePI=;
 b=oOGUaSre4XzUs+lxkz7FD2kSZBN8NksBkfckW/+qTHl8JbaxYlJ6NN8Mbc1R2n11m55CFf
 P73fj+xpCfOCQDtCPXJIYK1D6MwZPiXIwvgaAfFGUGzDJZaZCXkLGAHUC5DtKeJD/Osqtp
 IAS+CcgMs7OmmLqg6Q3uUtquB4Svgws=
Date: Thu, 11 Mar 2021 13:50:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/12] x86: major paravirt cleanup
Message-ID: <20210311125026.GB5829@zn.tnic>
References: <20210309134813.23912-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309134813.23912-1-jgross@suse.com>
Cc: linux-hyperv@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, clang-built-linux@googlegroups.com,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, "VMware, Inc." <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Steven Rostedt <rostedt@goodmis.org>,
 Nathan Chancellor <nathan@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Sean Christopherson <seanjc@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Mar 09, 2021 at 02:48:01PM +0100, Juergen Gross wrote:
> This is a major cleanup of the paravirt infrastructure aiming at
> eliminating all custom code patching via paravirt patching.
> 
> This is achieved by using ALTERNATIVE instead, leading to the ability
> to give objtool access to the patched in instructions.
> 
> In order to remove most of the 32-bit special handling from pvops the
> time related operations are switched to use static_call() instead.
> 
> At the end of this series all paravirt patching has to do is to
> replace indirect calls with direct ones. In a further step this could
> be switched to static_call(), too.
> 
> Changes in V6:
> - switched back to "not" bit in feature value for "not feature"
> - other minor comments addressed

Ok, looks real good, the simplification is amazing! :)

Can you please redo with the minor nits addressed ontop of the
tip:x86/alternatives branch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/alternatives

and move the cleanups patches 13 and 14 to the beginning of the set?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

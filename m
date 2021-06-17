Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB960C48BE5
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 15:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A03613FA
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 15:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A03613FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E33D60592;
	Thu, 17 Jun 2021 15:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1zlr-ufoVegC; Thu, 17 Jun 2021 15:39:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8F486071E;
	Thu, 17 Jun 2021 15:39:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A40EC000E;
	Thu, 17 Jun 2021 15:39:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E3ACC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 15:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AB956071E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 15:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxhKxTNEahaL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 15:39:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C692360592
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=G0Lvdln11fuzanH5JBFVlU89DGk/WHJ/h+sQJcOIMZU=; b=m7f6DrxmOSFDPVRUrGpIsGKH8Y
 op5BLM2WKhd7ygxhD3X0aHUzETlJSrlwr7/P/yfoFKMdozL/0d5O397EfTc38tiyV36wDc/GrLItj
 j3y4WNP8y7pzxl8QhhWTs1FFd/sOto1FhIztdYCLZmY8k/sx4Nt6xLZkJ4lBOvf7+1qGKUCqbmQuX
 dQuOIJIfh7+G9FQaqZaDXTJr6uVHbSLpkVBn2xlK6EorB9xvM4kd2oAdIGlb+wlgI4iv2+IzypgQ9
 U5kw22QCb9fbRG8m7MULJK+ojiB/vzmyc3YBVmmSmI7Vym47sFXo/ejWQV9DDb8WLDA2OHf+9U0dR
 C2sscMfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltu6S-009I32-Dg; Thu, 17 Jun 2021 15:38:55 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0A95300252;
 Thu, 17 Jun 2021 17:38:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id D9E1C234E5383; Thu, 17 Jun 2021 17:38:46 +0200 (CEST)
Date: Thu, 17 Jun 2021 17:38:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 1/2] x86/sev: Make sure IRQs are disabled while GHCB
 is active
Message-ID: <YMtshtgEbiQ993Zk@hirez.programming.kicks-ass.net>
References: <20210616184913.13064-1-joro@8bytes.org>
 <20210616184913.13064-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616184913.13064-2-joro@8bytes.org>
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


On Wed, Jun 16, 2021 at 08:49:12PM +0200, Joerg Roedel wrote:
> @@ -514,7 +523,7 @@ void noinstr __sev_es_nmi_complete(void)
>  	struct ghcb_state state;
>  	struct ghcb *ghcb;
>  
> -	ghcb = sev_es_get_ghcb(&state);
> +	ghcb = __sev_get_ghcb(&state);
>  
>  	vc_ghcb_invalidate(ghcb);
>  	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
> @@ -524,7 +533,7 @@ void noinstr __sev_es_nmi_complete(void)
>  	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
>  	VMGEXIT();
>  
> -	sev_es_put_ghcb(&state);
> +	__sev_put_ghcb(&state);
>  }

I'm getting (with all of v6.1 applied):

vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x1bf: call to panic() leaves .noinstr.text section

$ ./scripts/faddr2line defconfig-build/vmlinux __sev_es_nmi_complete+0x1bf
__sev_es_nmi_complete+0x1bf/0x1d0:
__sev_get_ghcb at arch/x86/kernel/sev.c:223
(inlined by) __sev_es_nmi_complete at arch/x86/kernel/sev.c:519


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

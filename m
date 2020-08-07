Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2078C433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 10:22:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BE42075D
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 10:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJSka808"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BE42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B42088528;
	Fri,  7 Aug 2020 10:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JuM1sJgWQqkm; Fri,  7 Aug 2020 10:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8139F88367;
	Fri,  7 Aug 2020 10:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59661C0050;
	Fri,  7 Aug 2020 10:22:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B928C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 10:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC3D22561C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 10:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Znp9PngQOujD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 10:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id 300FE254B8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=4/VCHM/wzhSgd4qyRAmAC4AWdDxulH6gS0+92poTPxI=; b=XJSka808E+4ltstGU3BqwdVOtZ
 hXkd+8kwG+mMF3YBC9gYdFKqQ0shdnwEeGlVgLK2rKX9zQM0cV+cX2kJ4LmaDy9pbGemoN/OFohKt
 qnuXOPc82zBE1eZRt+Hlbu7DoTyuXW9ud2aYWjPMUx5Dw/3JDO4mQ3YCdTM4HEoCeY/awHrW5ttq7
 yGPXiF6gmAUlT3tKwYWzxUSDGRDD8KGANnAswpVZO8evJINZiqIYWUR2sglBnT5anAp66EWDa3CPF
 1DOFDSa4vUFlAE+qdQ+8lQ3yc5sir2LRPdpMuROK+/SSyWXy9+HBgPYjDo4knnSw2IjRdxZeDX7ZH
 TrODYMfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3zVg-0002mK-4n; Fri, 07 Aug 2020 10:22:00 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A12A33012DC;
 Fri,  7 Aug 2020 12:21:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 89ED32B84E245; Fri,  7 Aug 2020 12:21:58 +0200 (CEST)
Date: Fri, 7 Aug 2020 12:21:58 +0200
From: peterz@infradead.org
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Subject: Re: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
Message-ID: <20200807102158.GG2674@hirez.programming.kicks-ass.net>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-5-jgross@suse.com>
 <20200807093916.GF2674@hirez.programming.kicks-ass.net>
 <3a0712ee-efca-5684-d321-3b789e01fc16@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a0712ee-efca-5684-d321-3b789e01fc16@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Aug 07, 2020 at 12:02:59PM +0200, J=FCrgen Gro=DF wrote:
> On 07.08.20 11:39, peterz@infradead.org wrote:
> > On Fri, Aug 07, 2020 at 10:38:23AM +0200, Juergen Gross wrote:
> > =

> > > -# else
> > > -	const unsigned char	cpu_iret[1];
> > > -# endif
> > >   };
> > >   static const struct patch_xxl patch_data_xxl =3D {
> > > @@ -42,7 +38,6 @@ static const struct patch_xxl patch_data_xxl =3D {
> > >   	.irq_save_fl		=3D { 0x9c, 0x58 },	// pushf; pop %[re]ax
> > >   	.mmu_read_cr2		=3D { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
> > >   	.mmu_read_cr3		=3D { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
> > > -# ifdef CONFIG_X86_64
> > >   	.mmu_write_cr3		=3D { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
> > >   	.irq_restore_fl		=3D { 0x57, 0x9d },	// push %rdi; popfq
> > >   	.cpu_wbinvd		=3D { 0x0f, 0x09 },	// wbinvd
> > > @@ -50,19 +45,11 @@ static const struct patch_xxl patch_data_xxl =3D {
> > >   				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
> > >   	.cpu_swapgs		=3D { 0x0f, 0x01, 0xf8 },	// swapgs
> > >   	.mov64			=3D { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
> > > -# else
> > > -	.mmu_write_cr3		=3D { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> > > -	.irq_restore_fl		=3D { 0x50, 0x9d },	// push %eax; popf
> > > -	.cpu_iret		=3D { 0xcf },		// iret
> > > -# endif
> > =

> > I was looking at x86_64 paravirt the other day and found we actually
> > have pv_ops.cpu.iret users there..
> =

> On x86_64 we have (without PARAVIRT_XXL):
> =

> #define INTERRUPT_RETURN        jmp native_iret
> =

> and with PARAVIRT_XXL this is basically a jmp *pv_ops.cpu.iret which
> will then be patched to either jmp native_iret or jmp xen_iret.

Ah, okay. Clearly I didn't look hard enough. Thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

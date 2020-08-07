Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC7DC433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8F5206B5
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlCBun+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8F5206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C5DC6888D3;
	Fri,  7 Aug 2020 09:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2eNpLHaqpktG; Fri,  7 Aug 2020 09:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED39F888C8;
	Fri,  7 Aug 2020 09:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C45CDC0051;
	Fri,  7 Aug 2020 09:39:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91BD9C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 09:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8DED6253D4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 09:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QjmqjXeX7pCX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 09:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 8B63F20439
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+m1NmxTmerVA7hYyNCbbSvji27rWMrnyKtnC8SpXeuw=; b=qlCBun+hYZ3NXDb+jynUBPF5jC
 h9Q8p+P3btJMKnRDYbi2BAa/sQ74mPob6WiFPQE7IgnqvAvjrylnmYcrWJF9imSnSE5vuAFnJW6mc
 /y/aeZjjYDdFSGbNOSq2ne5dZoxfVeJSJGt1evL6K7pnXkBi+cEGjvymLKMqvmrbfThHYTlmX1cKW
 Io2IvfmaI+W/P6SHIXiDMP87UdS6e+JDN+LOCBA1KZFBQ34DxczGekQV+vaYBzHAOYqOYYkcnRbly
 B7oGexBlDV3M4ABknh2jvnraRpH0zOmNsZphbhXmzYDft4HfoPllAJsfVSOHfTQFQbje2Cz2bPhXY
 Zk297Ehw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yqO-0001GI-HQ; Fri, 07 Aug 2020 09:39:24 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC842300446;
 Fri,  7 Aug 2020 11:39:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8E2DC23EA04DA; Fri,  7 Aug 2020 11:39:16 +0200 (CEST)
Date: Fri, 7 Aug 2020 11:39:16 +0200
From: peterz@infradead.org
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
Message-ID: <20200807093916.GF2674@hirez.programming.kicks-ass.net>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-5-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807083826.16794-5-jgross@suse.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Aug 07, 2020 at 10:38:23AM +0200, Juergen Gross wrote:

> -# else
> -	const unsigned char	cpu_iret[1];
> -# endif
>  };
>  
>  static const struct patch_xxl patch_data_xxl = {
> @@ -42,7 +38,6 @@ static const struct patch_xxl patch_data_xxl = {
>  	.irq_save_fl		= { 0x9c, 0x58 },	// pushf; pop %[re]ax
>  	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
>  	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
> -# ifdef CONFIG_X86_64
>  	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
>  	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
>  	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
> @@ -50,19 +45,11 @@ static const struct patch_xxl patch_data_xxl = {
>  				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
>  	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
>  	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
> -# else
> -	.mmu_write_cr3		= { 0x0f, 0x22, 0xd8 },	// mov %eax, %cr3
> -	.irq_restore_fl		= { 0x50, 0x9d },	// push %eax; popf
> -	.cpu_iret		= { 0xcf },		// iret
> -# endif

I was looking at x86_64 paravirt the other day and found we actually
have pv_ops.cpu.iret users there..

So we want to change the above to also patch iret on x86_64 or do we
need to fix x86_64 to not have pv-iret?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

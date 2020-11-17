Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C6C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 10:00:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B66222EC
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LF6k8N4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B66222EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A327185D9B;
	Tue, 17 Nov 2020 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CMqlrJ0RMhc; Tue, 17 Nov 2020 10:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F389185C9D;
	Tue, 17 Nov 2020 10:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E014DC0800;
	Tue, 17 Nov 2020 10:00:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7390C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E315D85C88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2-aY-eZqw9Y9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AD61285218
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sJWlIJf2Pt4tnjPJDlQRhe8ivTuZU0+s+pSU+BozkHA=; b=LF6k8N4mzA0pTMgRv3lmY/Ey4q
 AGIrti2W6EZ9Uy/Qt5md9YKM/pY5rkk5ivFVLGW3dqReurUueIwJeA9izUsXi1IwnoEn/5y0GppPG
 dzynQ78PZNzlaQngN3CCD9ZEqH36H8rzlB3fG4cSR5sooxnvpgmMM2IHiye6QUEfpaGcOW9LKrwLr
 PK7fJHkoOHmdFOfgQOr8zPy+AWok1Gew/v/l3iZZ9Gp8hRJFAj8tgf5viV2D+HMFN4NaC3dQfea7h
 SHrMi4DsoYgQcvM7zhfetHXMfHZGeyMQQdzV0h6OLNb6RswkPQOpsA4GGQK7r2ucGXhQ1CuPh260X
 49H5mmIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kexmd-0003xs-EN; Tue, 17 Nov 2020 10:00:19 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B795C3012DC;
 Tue, 17 Nov 2020 11:00:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9ECDB20116732; Tue, 17 Nov 2020 11:00:17 +0100 (CET)
Date: Tue, 17 Nov 2020 11:00:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/4] x86/xen: do some paravirt cleanup
Message-ID: <20201117100017.GB3121406@hirez.programming.kicks-ass.net>
References: <20201116152301.24558-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116152301.24558-1-jgross@suse.com>
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

On Mon, Nov 16, 2020 at 04:22:57PM +0100, Juergen Gross wrote:
> Eliminate the usergs_sysret64 paravirt call completely and switch
> the swapgs one to use ALTERNATIVE instead. This requires to fix the
> IST based exception entries for Xen PV to use the same mechanism as
> NMI and debug exception already do.
> 
> Juergen Gross (4):
>   x86/xen: use specific Xen pv interrupt entry for MCE
>   x86/xen: use specific Xen pv interrupt entry for DF
>   x86/pv: switch SWAPGS to ALTERNATIVE
>   x86/xen: drop USERGS_SYSRET64 paravirt call

Looks 'sane' :-))

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

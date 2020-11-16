Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEEC6369E
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:30:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3FA221F8
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqOsYI+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3FA221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07DD086650;
	Mon, 16 Nov 2020 16:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPC2-xjvWDNg; Mon, 16 Nov 2020 16:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 84529865D0;
	Mon, 16 Nov 2020 16:30:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D495C0800;
	Mon, 16 Nov 2020 16:30:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96483C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8BD46870B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g43IrwOfAT2Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60C98870A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:30:54 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3D8921527
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605544254;
 bh=2O3LBp1HPw0KQ1G2spNpvOUgelxUM0n8eKWWsC7ds30=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dqOsYI+0YGbb9NsAnIzVJVzN0+ZCeTcljVXkHY3Ca9c9X+hnuCJH8G2FUn67vfd9U
 obw74aqxw/UPBefBUp/bAQMVgF7JOQ9WyTuYSFtDMR4oweOAreMWzRFjeNPN566/DC
 MYCetQ39nn4CSqfi8ZhF3wCBDvpGh7bvgBDqVpPc=
Received: by mail-wr1-f49.google.com with SMTP id j7so19347231wrp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:30:53 -0800 (PST)
X-Gm-Message-State: AOAM530Sr7N3zOviGIj+mqdmSxj6pvUuUauspvxjCWIYnQW9TIw6enn4
 56DIWRUzqhrrjrGsXsySNKfBrxST1a70mLsj40ByUg==
X-Google-Smtp-Source: ABdhPJxRrSLHlH4ScZov5CaCHz95dre2M6ViQYOjxHY5oh3r9MUJXokIlLxakAYO4Hpet3isswmFWL/5m9Ab6jgvvwU=
X-Received: by 2002:a5d:5482:: with SMTP id h2mr9404192wrv.18.1605544252224;
 Mon, 16 Nov 2020 08:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com>
 <20201116152301.24558-5-jgross@suse.com>
In-Reply-To: <20201116152301.24558-5-jgross@suse.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 16 Nov 2020 08:30:38 -0800
X-Gmail-Original-Message-ID: <CALCETrVMX+D1fv3bbb7F_Cp2SfrFBudUqJk=uR3AJkgQ_KCniQ@mail.gmail.com>
Message-ID: <CALCETrVMX+D1fv3bbb7F_Cp2SfrFBudUqJk=uR3AJkgQ_KCniQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/xen: drop USERGS_SYSRET64 paravirt call
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
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

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> USERGS_SYSRET64 is used to return from a syscall via sysret, but
> a Xen PV guest will nevertheless use the iret hypercall, as there
> is no sysret PV hypercall defined.
>
> So instead of testing all the prerequisites for doing a sysret and
> then mangling the stack for Xen PV again for doing an iret just use
> the iret exit from the beginning.
>
> This can easily be done via an ALTERNATIVE like it is done for the
> sysenter compat case already.
>
> While at it remove to stale sysret32 remnants.

s/to/the/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

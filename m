Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68EC2BB48
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:19:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACE02250F
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACE02250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C4F720798;
	Tue, 15 Dec 2020 14:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtz11+b00ej5; Tue, 15 Dec 2020 14:19:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 13A182076E;
	Tue, 15 Dec 2020 14:19:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E835EC0893;
	Tue, 15 Dec 2020 14:19:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01B8AC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB4C686B96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMKA-sSxEN-1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0D2B886B67
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=n3MIZt3/znb4uRxmCaPyGVKsSFg4njtwCHLsmpqHHtc=; b=j5aJJbiLj/qdgQPvO1H9cZO69S
 cghj1tVt1MmeFUvrTyb7sI8SjpJMY/zf9c3AF09ZpaS3kpNRMq7Qcza+a+4SVPftUg92+de3j06ij
 TpvnEmE1F1M9N0xpaIyBwLxOwyzPMjM1Fuu/184ceVPJZHJ8yc8/CxeiHpKLfHNVY2JdoHHrZrv/6
 52/R56RdCA7sZvOvf5pukk87Nrmwsfm/qV5Ymb9hkIGZ805z6H/EQBg+eqwMVq1zBU/Ekh8ZN0Wyq
 bkHOj3MQ8RLBs8mNaGQ8LQey8vYZ+0uPL6pOynf1wFmF5Sb2xwez3kwxSkQndlTWxEbDpMaIXx+2n
 SfEy17IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpB9x-0007Qz-Vq; Tue, 15 Dec 2020 14:18:38 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C214A300446;
 Tue, 15 Dec 2020 15:18:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id A8CE3200CFB30; Tue, 15 Dec 2020 15:18:34 +0100 (CET)
Date: Tue, 15 Dec 2020 15:18:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Subject: Re: [PATCH v2 00/12] x86: major paravirt cleanup
Message-ID: <20201215141834.GG3040@hirez.programming.kicks-ass.net>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120125342.GC3040@hirez.programming.kicks-ass.net>
 <20201123134317.GE3092@hirez.programming.kicks-ass.net>
 <6771a12c-051d-1655-fb3a-cc45a3c82e29@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6771a12c-051d-1655-fb3a-cc45a3c82e29@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-hyperv@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, "VMware, Inc." <pv-drivers@vmware.com>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 xen-devel@lists.xenproject.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 luto@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
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

On Tue, Dec 15, 2020 at 12:42:45PM +0100, J=FCrgen Gro=DF wrote:
> Peter,
> =

> On 23.11.20 14:43, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2020 at 01:53:42PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 20, 2020 at 12:46:18PM +0100, Juergen Gross wrote:
> > > >   30 files changed, 325 insertions(+), 598 deletions(-)
> > > =

> > > Much awesome ! I'll try and get that objtool thing sorted.
> > =

> > This seems to work for me. It isn't 100% accurate, because it doesn't
> > know about the direct call instruction, but I can either fudge that or
> > switching to static_call() will cure that.
> > =

> > It's not exactly pretty, but it should be straight forward.
> =

> Are you planning to send this out as an "official" patch, or should I
> include it in my series (in this case I'd need a variant with a proper
> commit message)?

Ah, I was waiting for Josh to have an opinion (and then sorta forgot
about the whole thing again). Let me refresh and provide at least a
Changelog.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139ACC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 16:56:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F9C225A9
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 16:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F9C225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AF77322FEE;
	Wed, 16 Dec 2020 16:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2I4br6CZGKP; Wed, 16 Dec 2020 16:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B8BFA227F8;
	Wed, 16 Dec 2020 16:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84214C088E;
	Wed, 16 Dec 2020 16:56:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33101C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1968887271
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 95alpKJL3mvM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:56:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6590787270
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608137787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFK8uelp0EfnpwVsJ+unzlDIADvPHcDnDcvCpIi/i5Q=;
 b=f9ulRqQUFsUC14Oxu/JvjLS5ZdS4uyHeHQeS8gifCA1Su2Al10J99fdUdE/UP7lKwQI92d
 htjp6Jg0Pm1RC43rEiTgWRbl7kC2se+evh/O6P4UJ9JPjZyi7NpW1ASfaeKMwiY2KRT10x
 bQgJzJgKeRLEtlriKBppTnNn51saX4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-crZqldqkO2O1uPxUIhu4fA-1; Wed, 16 Dec 2020 11:56:25 -0500
X-MC-Unique: crZqldqkO2O1uPxUIhu4fA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59FF580400F;
 Wed, 16 Dec 2020 16:56:20 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 860D160CD0;
 Wed, 16 Dec 2020 16:56:07 +0000 (UTC)
Date: Wed, 16 Dec 2020 10:56:05 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/12] x86: major paravirt cleanup
Message-ID: <20201216165605.4h5q7os5dutjgdqi@treble>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120125342.GC3040@hirez.programming.kicks-ass.net>
 <20201123134317.GE3092@hirez.programming.kicks-ass.net>
 <6771a12c-051d-1655-fb3a-cc45a3c82e29@suse.com>
 <20201215141834.GG3040@hirez.programming.kicks-ass.net>
 <20201215145408.GR3092@hirez.programming.kicks-ass.net>
 <20201216003802.5fpklvx37yuiufrt@treble>
 <20201216084059.GL3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216084059.GL3040@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 luto@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 16, 2020 at 09:40:59AM +0100, Peter Zijlstra wrote:
> > So much algorithm.
> 
> :-)
> 
> It's not really hard, but it has a few pesky details (as always).

It really hurt my brain to look at it.

> > Could we make it easier by caching the shared
> > per-alt-group CFI state somewhere along the way?
> 
> Yes, but when I tried it grew the code required. Runtime costs would be
> less, but I figured that since alternatives are typically few and small,
> that wasn't a real consideration.

Aren't alternatives going to be everywhere now with paravirt using them?

> That is, it would basically cache the results of find_alt_unwind(), but
> you still need find_alt_unwind() to generate that data, and so you gain
> the code for filling and using the extra data structure.
> 
> Yes, computing it 3 times is naf, but meh.

Haha, I loved this sentence.

> > Thoughts?  This is all theoretical of course, I could try to do a patch
> > tomorrow.
> 
> No real objection, I just didn't do it because 1) it works, and 2) even
> moar lines.

I'm kind of surprised it would need moar lines.  Let me play around with
it and maybe I'll come around ;-)

-- 
Josh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65467C32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 12:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF87605EA;
	Mon, 26 Sep 2022 12:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DF87605EA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XAuv0lr+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nitmk3ywK5tI; Mon, 26 Sep 2022 12:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 772DB605D6;
	Mon, 26 Sep 2022 12:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 772DB605D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51D30C0032;
	Mon, 26 Sep 2022 12:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20546C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CB7740BA0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:14:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CB7740BA0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=XAuv0lr+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ixM74G1QRMjI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:14:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E92840B97
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E92840B97
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1ejE6IXHMsmMDdxnD5959e9TnKubLT7CerN02Zwf5J4=; b=XAuv0lr+RMSckyM/dkw/5MaDON
 FMJCrB6/V+FQ3BqSRYEqeeVy8wdHqGIOxPoVKxbX0Z6/6uoY0cH60CZIlzhhsLrg5gJr8jC2Em9Jr
 eM8UJlBgmVKtEuo4C8z9FrXz26NPzz8CGlxcQx5wHc/PDFP7q3vgdCasd/Tf5cPFA0AKxkG0Jb1lM
 egkGw8v+3tKOvL/gSlHwmrynTxfGPc4/E4nJcrv6AE7udvyvB13zXxZ6JR2AWB6RTJ8RgY+v2rbep
 wdMPpSf7YH+J7QGhsjFvM0UGCR3Z6KxQTIzj/GvzaqJlvsqhoMbO4a9Z+N2Ke/I2sqVmyd3JenIbg
 s3VZPxaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ocmzj-00G1GD-7d; Mon, 26 Sep 2022 12:13:55 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C9813002F1;
 Mon, 26 Sep 2022 14:13:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8261D29A13691; Mon, 26 Sep 2022 14:13:53 +0200 (CEST)
Date: Mon, 26 Sep 2022 14:13:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzGXgbfRngNfDhoC@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
Cc: vincent.guittot@linaro.org, linux-pm@vger.kernel.org, bigeasy@linutronix.de,
 amit@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@kernel.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 mgorman@suse.de, oleg@redhat.com, tj@kernel.org,
 virtualization@lists.linux-foundation.org, will@kernel.org,
 dietmar.eggemann@arm.com, ebiederm@xmission.com
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

On Mon, Sep 26, 2022 at 12:55:21PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 26.09.22 um 10:06 schrieb Christian Borntraeger:
> > 
> > 
> > Am 23.09.22 um 09:53 schrieb Christian Borntraeger:
> > > Am 23.09.22 um 09:21 schrieb Christian Borntraeger:
> > > > Peter,
> > > > 
> > > > as a heads-up. This commit (bisected and verified) triggers a
> > > > regression in our KVM on s390x CI. The symptom is that a specific
> > > > testcase (start a guest with next kernel and a poky ramdisk,
> > > > then ssh via vsock into the guest and run the reboot command) now
> > > > takes much longer (300 instead of 20 seconds). From a first look
> > > > it seems that the sshd takes very long to end during shutdown
> > > > but I have not looked into that yet.
> > > > Any quick idea?
> > > > 
> > > > Christian
> > > 
> > > the sshd seems to hang in virtio-serial (not vsock).
> > 
> > FWIW, sshd does not seem to hang, instead it seems to busy loop in
> > wait_port_writable calling into the scheduler over and over again.
> 
> -#define TASK_FREEZABLE                 0x00002000
> +#define TASK_FREEZABLE                 0x00000000
> 
> "Fixes" the issue. Just have to find out which of users is responsible.

Since it's not the wait_port_writable() one -- we already tested that by
virtue of 's/wait_event_freezable/wait_event/' there, it must be on the
producing side of that port. But I'm having a wee bit of trouble
following that code.

Is there a task stuck in FROZEN state? -- then again, I thought you said
there was no actual suspend involved, so that should not be it either.

I'm curious though -- how far does it get into the scheduler? It should
call schedule() with __state == TASK_INTERRUPTIBLE|TASK_FREEZABLE, which
is quite sufficient to get it off the runqueue, who then puts it back?
Or is it bailing early in the wait_event loop?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

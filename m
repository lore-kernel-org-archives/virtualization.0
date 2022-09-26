Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CBEC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 13:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1333082690;
	Mon, 26 Sep 2022 13:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1333082690
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M27OC6mb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lxrqruMvTx2; Mon, 26 Sep 2022 13:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3635D823AA;
	Mon, 26 Sep 2022 13:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3635D823AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1CAFC0033;
	Mon, 26 Sep 2022 13:38:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1D5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E926C408AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E926C408AC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=M27OC6mb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TCjyracFrf3G
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:37:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8BE440881
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8BE440881
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nITPYkhiQSASd/MBANOu6ZY1JaJ2D7mfRTlbFizAq1Q=; b=M27OC6mbY14hs43Q+3USZW4mwQ
 tfYCHnPW0UGV5ubIcF91Ihyzgh6P0XtjDrQuNlKn+1tfvks/bzQr3+/CHLvyJrfgsoUkJ3gG2teHu
 2JTPR/RONDBbFlm608/9434IZF0nT35NB55R3z++eDVgf6R+JC1i7qacPeDtx9HPh7bU9O7zp6jUx
 gk/i+qUbd/lVfEXX3gG2obaRAQoMZNgS3uvvwbJNPfMsPByzZ37xHMv9nXqZ88JAU6sV39eezKF9Z
 rULZl2hbDuz7wywOd9l5tTLSBl14DraCgoPMplYK9mHQpw7gBOaX43ETvqbROTs9ocRGIo3R8lMki
 iK8uknYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ocoIp-00G25A-Ni; Mon, 26 Sep 2022 13:37:43 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 674353001D6;
 Mon, 26 Sep 2022 15:37:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1F6A9205B02A9; Mon, 26 Sep 2022 15:37:42 +0200 (CEST)
Date: Mon, 26 Sep 2022 15:37:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
Cc: vincent.guittot@linaro.org, linux-pm@vger.kernel.org, bigeasy@linutronix.de,
 Amit Shah <amit@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@kernel.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 mgorman@suse.de, oleg@redhat.com, tj@kernel.org,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, will@kernel.org,
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

On Mon, Sep 26, 2022 at 03:23:10PM +0200, Christian Borntraeger wrote:
> Am 26.09.22 um 14:55 schrieb Peter Zijlstra:
> 
> > Could you please test with something like the below on? I can boot that
> > with KVM, but obviously I didn't suffer any weirdness to begin with :/
> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4e6a6417211f..ef9ccfc3a8c0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >   	unsigned long flags;
> >   	int cpu, success = 0;
> > +	WARN_ON_ONCE(state & TASK_FREEZABLE);
> > +
> >   	preempt_disable();
> >   	if (p == current) {
> >   		/*
> 
> Does not seem to trigger.

Moo -- quite the puzzle this :/ I'll go stare at it more then.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

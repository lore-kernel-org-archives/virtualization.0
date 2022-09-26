Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6310DC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 12:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD1D660F90;
	Mon, 26 Sep 2022 12:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD1D660F90
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MyO0V+ZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9RE9ZiNjWQ1; Mon, 26 Sep 2022 12:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A5D360A7E;
	Mon, 26 Sep 2022 12:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A5D360A7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 277BEC0032;
	Mon, 26 Sep 2022 12:56:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2B78C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C65A60F6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C65A60F6F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBVUhaG0BmNg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:55:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6B6960A7E
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6B6960A7E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9e5ZsFmEwqFgQJJWTznPDZKlyACAw4+tFf2Fsk0YUI4=; b=MyO0V+ZRwmf429N2b3uG/HRVUh
 FT5vAkpKajidvb0yBrBvav/7E/0A20CN8bVWgICAaTqQtNX3M8w2++EEM1w+AV8V4KZpD3u5LETB8
 wHHldUhL/DnmDs4jn8B64LZwWM8EnRZ2ehf6HeYgcZhMCeqAyRkJrUekYf6IMyC4SWSYA3xaQo3BS
 Flvo4KDvCNoigiGhtR7SgmyP+Enhx5IsagftIHKfY3Faeb5y4Ip31VVGCFZGq1FHanbOtjXgodBFY
 Cv+ChVWrwug/70b3LpgCiWq8NzRA3G3iiy85a7UTGOKTvgDNf0AajL0tFUixgqu9L0sPdfwSJZcYx
 QIfupF4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ocneF-00G1fp-8A; Mon, 26 Sep 2022 12:55:47 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 306A7300A72;
 Mon, 26 Sep 2022 14:55:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 11B5D201E09E7; Mon, 26 Sep 2022 14:55:46 +0200 (CEST)
Date: Mon, 26 Sep 2022 14:55:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
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

On Mon, Sep 26, 2022 at 02:32:24PM +0200, Christian Borntraeger wrote:
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9fa3c76a267f..e93df4f735fe 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -790,7 +790,7 @@ static int wait_port_writable(struct port *port, bool nonblock)
>                 if (nonblock)
>                         return -EAGAIN;
> -               ret = wait_event_freezable(port->waitqueue,
> +               ret = wait_event_interruptible(port->waitqueue,
>                                            !will_write_block(port));
>                 if (ret < 0)
>                         return ret;
> 
> Does fix the problem.

It's almost as if someone does try_to_wake_up(.state = TASK_FREEZABLE)
-- which would be quite insane.

Could you please test with something like the below on? I can boot that
with KVM, but obviously I didn't suffer any weirdness to begin with :/

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4e6a6417211f..ef9ccfc3a8c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	WARN_ON_ONCE(state & TASK_FREEZABLE);
+
 	preempt_disable();
 	if (p == current) {
 		/*
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

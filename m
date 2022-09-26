Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA34C32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 18:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9395F40C0B;
	Mon, 26 Sep 2022 18:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9395F40C0B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UpWOL/Sa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 74dKHVL_Hkjz; Mon, 26 Sep 2022 18:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29DBB4023F;
	Mon, 26 Sep 2022 18:07:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29DBB4023F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D092C0033;
	Mon, 26 Sep 2022 18:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C4A540526
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C4A540526
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DQXeE-7AxeCW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:07:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BA4C4023F
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BA4C4023F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ta2fqcORnTPhm6SqYBRMkwwfMiYClGmt06JcabgqfpQ=; b=UpWOL/SaSMuiNnVO3YXv9vgiwU
 QEZCudfajDBURy71rTA2XbtSEKCmGMx783wOqvc1ASC8/hdHv0TZI4uVCkP7oJhgHxpXxgpPa6+13
 j0LebLryLy8t7VlKmkPKi47xFSzpQOuhIeVUzNWBMwRjOr88nOuVLzRSua/nz8WZY8JfiLlh983de
 TEr95we4+wkK8tMKUGmtKlCR1BF4XS+MxCimif8AYhPDaLvePCcGTl1Yb5Wp/IbhiT7mUdfrhUjky
 RbA/b5V6s+kpGsnTX8jZ7MA8srLjzJCY0M6rG/qAPysoNyjAFuPTW46W2UZ3delHOVqcqM+izQyDM
 rgCDAklw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ocsVH-00Aigs-UN; Mon, 26 Sep 2022 18:06:52 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98A2430007E;
 Mon, 26 Sep 2022 20:06:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 742262B6B2F7B; Mon, 26 Sep 2022 20:06:46 +0200 (CEST)
Date: Mon, 26 Sep 2022 20:06:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
 <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
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

On Mon, Sep 26, 2022 at 05:49:16PM +0200, Christian Borntraeger wrote:

> Hmm,
> 
> #define ___wait_is_interruptible(state)                                         \
>         (!__builtin_constant_p(state) ||                                        \
>                 state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)          \
> 
> That would not trigger when state is also TASK_FREEZABLE, no?

Spot on!

signal_pending_state() writes that as:

	state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)

which is the correct form.

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 14ad8a0e9fac..7f5a51aae0a7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -281,7 +281,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 
 #define ___wait_is_interruptible(state)						\
 	(!__builtin_constant_p(state) ||					\
-		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)		\
+	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 

Let me go git-grep some to see if there's more similar fail.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

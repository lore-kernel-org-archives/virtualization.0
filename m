Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6225FC6FA92
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 18:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7DB882E1A;
	Mon, 26 Sep 2022 18:22:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7DB882E1A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=hoGUiHOC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWLwtAD2KKBA; Mon, 26 Sep 2022 18:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5FA2382D0F;
	Mon, 26 Sep 2022 18:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FA2382D0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FCA7C0032;
	Mon, 26 Sep 2022 18:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C33C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DAFA60FDC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DAFA60FDC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=hoGUiHOC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6i_NVjbiJP5m
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:22:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8DD3605EC
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8DD3605EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MWYFxbe3wzFoZ0mxwRrcCalNF6gTjbmRt3HqAYvT5I8=; b=hoGUiHOCMuaus9O2rKHpbNA99R
 qw2Nyg8YDAm1FkArR8BGVkiF+VazAjl5vfO5wPLpcaUK2oWZiu7SKKr6ZcRAcyTxA2OKfDw1jJ52X
 X3AFxmrY3gOtghd0gh2JfXQAkD0B8JwKRb5LkZCNcyxyfa8n1RYe4cIG4h2cevAKK31mB8VGlDWi3
 oandx0jGog+b6S+nwaDdQPDhY1+Y2d/09sX03h6Lv/PDTgIqtXgpHcjx34OtcdP/t9v9XCSKX159u
 WTeCeErXTK3ZwRCGRsPcnYufPIsuVrMUjeFzVezfcFFdgDNih1gyfSqxrYdvt9XIKngtihGwxbije
 Nls7j6Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ocskG-00G5DZ-25; Mon, 26 Sep 2022 18:22:20 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09D7C3001D6;
 Mon, 26 Sep 2022 20:22:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B86FC2B6B2F7B; Mon, 26 Sep 2022 20:22:18 +0200 (CEST)
Date: Mon, 26 Sep 2022 20:22:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzHt2nG0Hb7xLlNj@hirez.programming.kicks-ass.net>
References: <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
 <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
 <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
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

On Mon, Sep 26, 2022 at 08:06:46PM +0200, Peter Zijlstra wrote:

> Let me go git-grep some to see if there's more similar fail.

I've ended up with the below...

---
 include/linux/wait.h | 2 +-
 kernel/hung_task.c   | 8 ++++++--
 kernel/sched/core.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

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
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f1321c03c32a..4a8a713fd67b 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -191,6 +191,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
+		unsigned int state;
+
 		if (!max_count--)
 			goto unlock;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
@@ -198,8 +200,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
-		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
+		/* skip the TASK_KILLABLE tasks -- these can be killed */
+		state == READ_ONCE(t->__state);
+		if ((state & TASK_UNINTERRUPTIBLE) &&
+		    !(state & TASK_WAKEKILL))
 			check_hung_task(t, timeout);
 	}
  unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1095917ed048..12ee5b98e2c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8885,7 +8885,7 @@ state_filter_match(unsigned long state_filter, struct task_struct *p)
 	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
 	 * TASK_KILLABLE).
 	 */
-	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
+	if (state_filter == TASK_UNINTERRUPTIBLE && state & TASK_NOLOAD)
 		return false;
 
 	return true;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

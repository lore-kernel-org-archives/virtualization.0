Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE028C4167B
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 16:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CA3E812AC;
	Wed, 28 Dec 2022 16:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CA3E812AC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jWLyIprN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5VLQtIL8IOhm; Wed, 28 Dec 2022 16:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B22A680F2C;
	Wed, 28 Dec 2022 16:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B22A680F2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F1EC0033;
	Wed, 28 Dec 2022 16:39:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A42CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 16:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BA1E60BC7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 16:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA1E60BC7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=jWLyIprN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gK3J3dwM2BJz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 16:39:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3431360B8C
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3431360B8C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 16:39:54 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DD317B8172A;
 Wed, 28 Dec 2022 16:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7C8C433D2;
 Wed, 28 Dec 2022 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1672245590;
 bh=xzJNGysGIYQo1e07OGvZGwjIVhL5ZmwTqtcjh6+Z8TU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jWLyIprN0U6GT6f3pKyPK7Bh4HyD4Q6PNBreMztV086THKFyuCYcdV/z8Ca3/xxPn
 CAs+cniFSAyU4y/d/kh3kELb/3RZ6m+M4cRuRZ16cJLcWI6kjrGYs0QXI5ZwyYyBkG
 HSRUzdGKYw7G7XIcpYczdbazPWPsN/c9fW9s+Ns4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.0 0919/1073] blk-mq: avoid double ->queue_rq() because of
 early timeout
Date: Wed, 28 Dec 2022 15:41:47 +0100
Message-Id: <20221228144352.990402652@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
References: <20221228144328.162723588@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 David Jeffery <djeffery@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>
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

From: David Jeffery <djeffery@redhat.com>

[ Upstream commit 82c229476b8f6afd7e09bc4dc77d89dc19ff7688 ]

David Jeffery found one double ->queue_rq() issue, so far it can
be triggered in VM use case because of long vmexit latency or preempt
latency of vCPU pthread or long page fault in vCPU pthread, then block
IO req could be timed out before queuing the request to hardware but after
calling blk_mq_start_request() during ->queue_rq(), then timeout handler
may handle it by requeue, then double ->queue_rq() is caused, and kernel
panic.

So far, it is driver's responsibility to cover the race between timeout
and completion, so it seems supposed to be solved in driver in theory,
given driver has enough knowledge.

But it is really one common problem, lots of driver could have similar
issue, and could be hard to fix all affected drivers, even it isn't easy
for driver to handle the race. So David suggests this patch by draining
in-progress ->queue_rq() for solving this issue.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221026051957.358818-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 56 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 88975170cc32..05e33c51702d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1442,7 +1442,13 @@ static void blk_mq_rq_timed_out(struct request *req)
 	blk_add_timer(req);
 }
 
-static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
+struct blk_expired_data {
+	bool has_timedout_rq;
+	unsigned long next;
+	unsigned long timeout_start;
+};
+
+static bool blk_mq_req_expired(struct request *rq, struct blk_expired_data *expired)
 {
 	unsigned long deadline;
 
@@ -1452,13 +1458,13 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
-	if (time_after_eq(jiffies, deadline))
+	if (time_after_eq(expired->timeout_start, deadline))
 		return true;
 
-	if (*next == 0)
-		*next = deadline;
-	else if (time_after(*next, deadline))
-		*next = deadline;
+	if (expired->next == 0)
+		expired->next = deadline;
+	else if (time_after(expired->next, deadline))
+		expired->next = deadline;
 	return false;
 }
 
@@ -1472,7 +1478,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 
 static bool blk_mq_check_expired(struct request *rq, void *priv)
 {
-	unsigned long *next = priv;
+	struct blk_expired_data *expired = priv;
 
 	/*
 	 * blk_mq_queue_tag_busy_iter() has locked the request, so it cannot
@@ -1481,7 +1487,18 @@ static bool blk_mq_check_expired(struct request *rq, void *priv)
 	 * it was completed and reallocated as a new request after returning
 	 * from blk_mq_check_expired().
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_req_expired(rq, expired)) {
+		expired->has_timedout_rq = true;
+		return false;
+	}
+	return true;
+}
+
+static bool blk_mq_handle_expired(struct request *rq, void *priv)
+{
+	struct blk_expired_data *expired = priv;
+
+	if (blk_mq_req_expired(rq, expired))
 		blk_mq_rq_timed_out(rq);
 	return true;
 }
@@ -1490,7 +1507,9 @@ static void blk_mq_timeout_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, timeout_work);
-	unsigned long next = 0;
+	struct blk_expired_data expired = {
+		.timeout_start = jiffies,
+	};
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
@@ -1510,10 +1529,23 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	/* check if there is any timed-out request */
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
+	if (expired.has_timedout_rq) {
+		/*
+		 * Before walking tags, we must ensure any submit started
+		 * before the current time has finished. Since the submit
+		 * uses srcu or rcu, wait for a synchronization point to
+		 * ensure all running submits have finished
+		 */
+		blk_mq_wait_quiesce_done(q);
+
+		expired.next = 0;
+		blk_mq_queue_tag_busy_iter(q, blk_mq_handle_expired, &expired);
+	}
 
-	if (next != 0) {
-		mod_timer(&q->timeout, next);
+	if (expired.next != 0) {
+		mod_timer(&q->timeout, expired.next);
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
-- 
2.35.1



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

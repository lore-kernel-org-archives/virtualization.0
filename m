Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EAEC4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 09:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27A74842A6;
	Thu, 20 Oct 2022 09:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27A74842A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVGyb65/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0rf9Pds-CvI; Thu, 20 Oct 2022 09:10:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 925CF833C9;
	Thu, 20 Oct 2022 09:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 925CF833C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48D3BC0033;
	Thu, 20 Oct 2022 09:10:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7176C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 09:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C96F2842A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 09:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C96F2842A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_EbOzvzjj7X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 09:10:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8479833C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8479833C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666257045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6+CtSbpb8TXPeuZhxpRWK/BpD94ovFhE0lP0MjSv61M=;
 b=OVGyb65/dFj6GzlYWYXzQOJxV7jbgXkNUTDLS6V1BvungAYWBw4cEGGXWC1uDYK1bPbRB7
 9La0ovZqgmNv9HICs8Np2q/qhJOgfK/m+912xtPkWq47m3iahVv4mFY26bkSe7H+ojEAHP
 xUv1MdHqCA4fsVz8W2CNyKT9JIn7czQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-X3_1_fH6N6uHI1xTV2JJjA-1; Thu, 20 Oct 2022 05:10:42 -0400
X-MC-Unique: X3_1_fH6N6uHI1xTV2JJjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 192C129324B0;
 Thu, 20 Oct 2022 09:10:36 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC1E40C6EC2;
 Thu, 20 Oct 2022 09:10:19 +0000 (UTC)
Date: Thu, 20 Oct 2022 17:10:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, djeffery@redhat.com,
 stefanha@redhat.com
Subject: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1EQdafQlKNAsutk@T590>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-scsi@vger.kernel.org, ming.lei@redhat.com
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

Hi,

David Jeffery found one double ->queue_rq() issue, so far it can
be triggered in the following two cases:

1) scsi driver in guest kernel

- the story could be long vmexit latency or long preempt latency of
vCPU pthread, then IO req is timed out before queuing the request
to hardware but after calling blk_mq_start_request() during ->queue_rq(),
then timeout handler handles it by requeue, then double ->queue_rq() is
caused, and kernel panic

2) burst of kernel messages from irq handler 

For 1), I think it is one reasonable case, given latency from host side
can come anytime in theory because vCPU is emulated by one normal host
pthread which can be preempted anywhere. For 2), I guess kernel message is
supposed to be rate limited.

Firstly, is this kind of so long(30sec) random latency when running kernel
code something normal? Or do we need to take care of it? IMO, it looks
reasonable in case of VM, but our VM experts may have better idea about this
situation. Also the default 30sec timeout could be reduced via sysfs or
drivers.

Suppose it is one reasonable report to fix, what is the preferred solution?

So far, it is driver's responsibility to cover the race between timeout
and completion, so it is supposed to be solved in driver in theory, given
driver has enough knowledge.

But it is really one common problem, lots of driver could have similar
issue, and could be hard to fix all affected drivers, so David suggests
the following patch by draining in-progress ->queue_rq() for this issue.
And the patch looks reasonable too.

Any comments for this issue and the solution?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..ca57c060bb65 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1523,7 +1523,12 @@ static void blk_mq_rq_timed_out(struct request *req)
 	blk_add_timer(req);
 }
 
-static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
+struct blk_expired_data {
+	unsigned long next;
+	unsigned long now;
+};
+
+static bool blk_mq_req_expired(struct request *rq, struct blk_expired_data *expired)
 {
 	unsigned long deadline;
 
@@ -1533,13 +1538,13 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
-	if (time_after_eq(jiffies, deadline))
+	if (time_after_eq(expired->now, deadline))
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
 
@@ -1555,7 +1560,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 
 static bool blk_mq_check_expired(struct request *rq, void *priv)
 {
-	unsigned long *next = priv;
+	struct blk_expired_data *expired = priv;
 
 	/*
 	 * blk_mq_queue_tag_busy_iter() has locked the request, so it cannot
@@ -1564,7 +1569,7 @@ static bool blk_mq_check_expired(struct request *rq, void *priv)
 	 * it was completed and reallocated as a new request after returning
 	 * from blk_mq_check_expired().
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_req_expired(rq, expired))
 		blk_mq_rq_timed_out(rq);
 	return true;
 }
@@ -1573,7 +1578,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, timeout_work);
-	unsigned long next = 0;
+	struct blk_expired_data expired = {.next = 0, .now = jiffies};
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
@@ -1593,10 +1598,17 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	/* Before walking tags, we must ensure any submit started before the
+	 * current time has finished. Since the submit uses srcu or rcu, wait
+	 * for a synchronization point to ensure all running submits have
+	 * finished
+	 */
+	blk_mq_wait_quiesce_done(q);
+
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &expired);
 
-	if (next != 0) {
-		mod_timer(&q->timeout, next);
+	if (expired.next != 0) {
+		mod_timer(&q->timeout, expired.next);
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If



Thanks, 
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

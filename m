Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B882CC7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 13:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4617B42445;
	Fri,  2 Jun 2023 13:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4617B42445
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=tOSlSUw8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5EIqxM0JgQuu; Fri,  2 Jun 2023 13:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24ED64245C;
	Fri,  2 Jun 2023 13:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24ED64245C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E969FC0037;
	Fri,  2 Jun 2023 13:39:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D081BC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97843843E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:39:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97843843E9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=tOSlSUw8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8scfZ6Zjz81V
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:39:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D81B843D7
Received: from arg-plspam-c1n1.mailshover.nl (arg-plspam-c1n1.mailshover.nl
 [145.131.15.41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D81B843D7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:39:41 +0000 (UTC)
Received: from [5.100.226.105] (helo=arg-plsmtp-c1n1.argewebhosting.nl)
 by arg-plspam-c1n1.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1q550C-002THi-OC; Fri, 02 Jun 2023 15:39:38 +0200
Received: from flex01.zurich.ibm.com (pat.zurich.ibm.com [195.176.20.45])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n1.argewebhosting.nl (Postfix) with ESMTPA id 5BE1F20747E5;
 Fri,  2 Jun 2023 15:39:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n1.argewebhosting.nl
 5BE1F20747E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1685713176;
 bh=l5V/Ni+CNv13JDYkIyNi5AxITIfU7nV7XgCUp5EBtnQ=;
 h=From:To:Cc:Subject:Date:From;
 b=tOSlSUw8Fpc/SkwNFIb5qu2FzdWMmjDVOpidE116gHm5oSTleWdeF63sUbmy0T5yQ
 34MNiHUNefG2kG3ZoFSe0FyApIV6WPy23mU0do2oVTYhp15z1QZDpegrB1PvvDs/gI
 SjWIpZpgc9RnOORQA6/lnaAMYwR0k0cIu8s77zEEsaQwvQnVS16e+hzYEONGVKA2Kc
 J/7Hw0tuihMwK+rd5Nd/BWGNi+yd9nkUf2soFrFWJVqYEycOKouBBIylktvlyV2RFf
 9pGPwzAiORLEJvnndeh96Xi24Ajz3vfD5+MeXTwQq3f2emBfFufIzFGgNmn/uv22cR
 17RkBChUYkhDA==
To: virtualization@lists.linux-foundation.org
Subject: [PATCH V3] virtio-fs: Improved request latencies when Virtio queue is
 full
Date: Fri,  2 Jun 2023 15:32:26 +0200
Message-Id: <20230602133224.1445655-1-peter-jan@gootzen.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: 5.100.226.105
X-SpamExperts-Domain: out.mailshover.nl
X-SpamExperts-Username: 5.100.226.105
Authentication-Results: mailshover.nl;
 auth=pass smtp.auth=5.100.226.105@out.mailshover.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000834937912286)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/31vTCmg9XFO4Z13/W1uFQPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzOoHxWscew68UvLJqW/V1opzyoDuAP4C0aaz3STa5zA+i
 +LgxjoYkXCbk6qYg3TLiBCq0YCJmjpNMbRTU3wgrC0Y3u/qphs34dTesYrpa6tiW8BKfyIS6EHTV
 hG8std+lEPHKAzuJoUDzV774tvkniFloh3x3CR4Jb2gWRrpPKH/kiyogkboSzK6mS04K9D2ouJYi
 QWxaMB85XLIGw32ggM1FjTV5UXzaWZFiY/IuWRLx/Du65BKz/oEcyvz1uhV1UWVvvdkzh9/Seh7h
 SLJU1ktV7ekmGpxaAJ/k28IIq/fPjylt/HZ8k1j7Ut/7PLb7521/uy4r4RP2U/suYnM07Ogv5mRk
 S/8bWrZGatZmbaRBZTprHzkFMzwAzmAh7tTKPGi8jp8jsUjzKct0i2ODM0F9oOOr1xI6jl9Hi9P1
 DKmAwTrzmCHomMs24PzTKAo9gK7/ebDoJ006fIc/+3LKW50gw74ge2pR5Dl9Oxy663zHNkoKwUL9
 WpKjkCojOcsWB9DKkolz7mz7R/5+TR/mb1HgElnnwmI9eQkYzxF3C5agY6v8FjBDhSdJTcfh+/jl
 gTl6fJxyntEfhZCKje4ZDU2/WT5nRIUO3uYch+hAG+TJt6lvqTFBPeozbCkFbqtQLgVqEDmqiK0l
 c17lHF9hQdumSwX5R/88G6ikH5H4tYHVHhzxKltKX/MiaOmx+aXxYXZV7IIcbpaDH/GiU/HytjIG
 7LKzPRPEQUu/PvFeiA8a8+GuZalPmdWaN1GHD8yKosLnOPWr3tKGDtMbofv37Sv6vaDLqb+8rWNF
 lVuma3lO5oiuoEf7U6gHIJvzJ8AN/2oiLQnPnhxk6tgp0mib5Q50akIN2ZeFlRJmkbJ0ZW+LCVGu
 IEr2yIyCJFCW5qd9VOPqfD+8rAFdu99ilLIpctgzcDoFd+96Xw4QUNtTncp2Qc83zSxytKTt0K+z
 +io3AXshNIiU06DxMhZL4stXCElo9fMv4vD4V+O21R0NgQuqW1aFb2oviXHQqJbNNi0zWgQESVrY
 xKPfHopgdidcYIjrL3lpTJvQHIv/znG8DGgQIoAcTXG84PsRSeM/8MDAyAyO4Oh498/JE76rMvq0
 Gxr0D6eYR3txFV/LGulnVammGulH/N9Orm0K761f8wsUF6Pa8StFgmwtrwMBe0ED
X-Report-Abuse-To: spam@arg-plspam-c1n0.mailshover.nl
Cc: stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu
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
From: Peter-Jan Gootzen via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

When the Virtio queue is full, a work item is scheduled
to execute in 1ms that retries adding the request to the queue.
This is a large amount of time on the scale on which a
virtio-fs device can operate. When using a DPU this is around
40us baseline without going to a remote server (4k, QD=1).
This patch queues requests when the Virtio queue is full,
and when a completed request is taken off, immediately fills
it back up with queued requests.

This reduces the 99.9th percentile latencies in our tests by
60x and slightly increases the overall throughput, when using a
queue depth 2x the size of the Virtio queue size, with a
DPU-powered virtio-fs device.

Furthermore, the virtio-fs driver now also always lets -ENOMEM
errors go to userspace instead of retrying the request in the
driver.

Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
---
V3: Fixed requests falling into the void when -ENOMEM and no new
incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
userspace. Also made queue full condition more explicit with
-ENOSPC in `send_forget_request`.
V2: Not scheduling dispatch work anymore when not needed
and changed delayed_work structs to work_struct structs

 fs/fuse/virtio_fs.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..3a3231ddb9e7 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -45,7 +45,7 @@ struct virtio_fs_vq {
 	struct work_struct done_work;
 	struct list_head queued_reqs;
 	struct list_head end_reqs;	/* End these requests */
-	struct delayed_work dispatch_work;
+	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
 	long in_flight;
@@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
 	}
 
 	flush_work(&fsvq->done_work);
-	flush_delayed_work(&fsvq->dispatch_work);
+	flush_work(&fsvq->dispatch_work);
 }
 
 static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
@@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 			dec_in_flight_req(fsvq);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+
+	if (!list_empty(&fsvq->queued_reqs))
+		schedule_work(&fsvq->dispatch_work);
 	spin_unlock(&fsvq->lock);
 }
 
@@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
-						 dispatch_work.work);
+						 dispatch_work);
 	int ret;
 
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
@@ -385,11 +388,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 		ret = virtio_fs_enqueue_req(fsvq, req, true);
 		if (ret < 0) {
-			if (ret == -ENOMEM || ret == -ENOSPC) {
+			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
-				schedule_delayed_work(&fsvq->dispatch_work,
-						      msecs_to_jiffies(1));
 				spin_unlock(&fsvq->lock);
 				return;
 			}
@@ -405,8 +406,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 }
 
 /*
- * Returns 1 if queue is full and sender should wait a bit before sending
- * next request, 0 otherwise.
+ * Returns 0 if request has been successfully sent, otherwise -ENOSPC
+ * when the queue is full.
  */
 static int send_forget_request(struct virtio_fs_vq *fsvq,
 			       struct virtio_fs_forget *forget,
@@ -432,16 +433,12 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 
 	ret = virtqueue_add_outbuf(vq, &sg, 1, forget, GFP_ATOMIC);
 	if (ret < 0) {
-		if (ret == -ENOMEM || ret == -ENOSPC) {
+		if (ret == -ENOSPC) {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
-			schedule_delayed_work(&fsvq->dispatch_work,
-					      msecs_to_jiffies(1));
 			if (!in_flight)
 				inc_in_flight_req(fsvq);
-			/* Queue is full */
-			ret = 1;
 		} else {
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Dropping it.\n",
 				 ret);
@@ -469,7 +466,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 {
 	struct virtio_fs_forget *forget;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
-						 dispatch_work.work);
+						 dispatch_work);
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
 	while (1) {
 		spin_lock(&fsvq->lock);
@@ -482,7 +479,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 
 		list_del(&forget->list);
 		spin_unlock(&fsvq->lock);
-		if (send_forget_request(fsvq, forget, true))
+		if (send_forget_request(fsvq, forget, true) == -ENOSPC)
 			return;
 	}
 }
@@ -647,6 +644,11 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 			virtio_fs_request_complete(req, fsvq);
 		}
 	}
+
+	spin_lock(&fsvq->lock);
+	if (!list_empty(&fsvq->queued_reqs))
+		schedule_work(&fsvq->dispatch_work);
+	spin_unlock(&fsvq->lock);
 }
 
 /* Virtqueue interrupt handler */
@@ -670,12 +672,12 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
 
 	if (vq_type == VQ_REQUEST) {
 		INIT_WORK(&fsvq->done_work, virtio_fs_requests_done_work);
-		INIT_DELAYED_WORK(&fsvq->dispatch_work,
-				  virtio_fs_request_dispatch_work);
+		INIT_WORK(&fsvq->dispatch_work,
+			  virtio_fs_request_dispatch_work);
 	} else {
 		INIT_WORK(&fsvq->done_work, virtio_fs_hiprio_done_work);
-		INIT_DELAYED_WORK(&fsvq->dispatch_work,
-				  virtio_fs_hiprio_dispatch_work);
+		INIT_WORK(&fsvq->dispatch_work,
+			  virtio_fs_hiprio_dispatch_work);
 	}
 }
 
@@ -1246,7 +1248,7 @@ __releases(fiq->lock)
 	fsvq = &fs->vqs[queue_id];
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
-		if (ret == -ENOMEM || ret == -ENOSPC) {
+		if (ret == -ENOSPC) {
 			/*
 			 * Virtqueue full. Retry submission from worker
 			 * context as we might be holding fc->bg_lock.
@@ -1254,8 +1256,6 @@ __releases(fiq->lock)
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
 			inc_in_flight_req(fsvq);
-			schedule_delayed_work(&fsvq->dispatch_work,
-						msecs_to_jiffies(1));
 			spin_unlock(&fsvq->lock);
 			return;
 		}
@@ -1265,7 +1265,7 @@ __releases(fiq->lock)
 		/* Can't end request in submission context. Use a worker */
 		spin_lock(&fsvq->lock);
 		list_add_tail(&req->list, &fsvq->end_reqs);
-		schedule_delayed_work(&fsvq->dispatch_work, 0);
+		schedule_work(&fsvq->dispatch_work);
 		spin_unlock(&fsvq->lock);
 		return;
 	}
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A166C001B0
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 19:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC79A819B4;
	Mon,  3 Jul 2023 19:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC79A819B4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=evOm1OT2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwT3eCNN19Iu; Mon,  3 Jul 2023 19:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2214481882;
	Mon,  3 Jul 2023 19:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2214481882
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAE4BC0071;
	Mon,  3 Jul 2023 19:24:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D42FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 19:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A7D840420
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 19:24:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A7D840420
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=evOm1OT2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0w7OtZ_U1YEG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 19:24:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5026400CB
Received: from arg-plspam-c1n1.mailshover.nl (arg-plspam-c1n1.mailshover.nl
 [145.131.15.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5026400CB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 19:24:41 +0000 (UTC)
Received: from gw.mailshover.nl ([2001:678:76c:1:3996::58]
 helo=arg-plsmtp-c1n1.argewebhosting.nl)
 by arg-plspam-c1n1.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1qGPA5-005ChG-ER; Mon, 03 Jul 2023 21:24:38 +0200
Received: from flex01.zurich.ibm.com (pat.zurich.ibm.com [195.176.20.45])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n1.argewebhosting.nl (Postfix) with ESMTPA id EC60B20731A2;
 Mon,  3 Jul 2023 21:24:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n1.argewebhosting.nl
 EC60B20731A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1688412277;
 bh=HwEKO7k0mQZlR0rlqgDVRgwpfKNWPl1+2SWbZCtt1LU=;
 h=From:To:Cc:Subject:Date:From;
 b=evOm1OT2Ex5h5wjc+DT8qgQ2R8OKrCgR3k2QA7nXFQNEj2EZPwJptl9CCdvv8468B
 kKkFySUMlSjhMzZRr+UDR3uii5byvN/szpXLntAYWIJFmBH192vt4C5cTFB3lFl8OP
 piGxhZdGfj0PfZxr09xcmjcIFMyjgdm6Yr/Qae16T7IGkkjKEnbfmz6uUqtZQLh8Yz
 sr5IkDQn4t6iLFm9c2/4M/k3vJSNnpXOEKroQJKoXgWTNCl01EzTsYooPM8x9fciY7
 9ILnDC/WmAs7RnQTKO3Iz/PTFheDE+1gjwHUc4A7FYLb5ha3jUWz03vjnAAnyjdZOZ
 MczOo4rMTDbhg==
To: virtualization@lists.linux-foundation.org
Subject: [PATCH V4] virtio-fs: Improved request latencies when Virtio queue is
 full
Date: Mon,  3 Jul 2023 21:14:59 +0200
Message-Id: <20230703191457.1847740-1-peter-jan@gootzen.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: 2001:678:76c:1:3996::58
X-SpamExperts-Domain: out.mailshover.nl
X-SpamExperts-Username: 2001:678:76c:1:3996::58
Authentication-Results: mailshover.nl; auth=pass
 smtp.auth=2001:678:76c:1:3996::58@out.mailshover.nl
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT90jVzTLJt3vj6cAu5S4eQ0PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzOoHxWscew68UvLJqW/V1opzyoDuAP4C0aaz3STa5zA+i
 +LgxjoYkXCbk6qYg3TLiBCq0YCJmjpNMbRTU3wgrC0Y3u/qphs34dTesYrpa6tiW8BKfyIS6EHTV
 hG8std+lEPHKAzuJoUDzV774tvkniFloh3x3CR4Jb2gWRrpPKOgtmufHeAaAMOAgSJ0r0OmouJYi
 QWxaMB85XLIGw32ggM1FjTV5UXzaWZFiY/IuWRLx/Du65BKz/oEcyvz1uhV1UWVvvdkzh9/Seh7h
 SLJU/jpU+HEu7P+MmVRDaSRl7/fPjylt/HZ8k1j7Ut/7PLb7521/uy4r4RP2U/suYnM07Ogv5mRk
 S/8bWrZGatZmbSSp6wqBiWgCUvpQC7hp792Kjeyl92hTDJK+4O0vOmkQc1UkGqjsciyILerEw8FX
 FnC9J8Tfx0FDPUDJU5K58QZrH/iEgzfzmnMXBIwMoePog2OkM5zMbrn2rUwXJSugd8VmzzAQ6gJW
 hVbNViZCOWKRNtlfJySsZ2eS9qGTagUdlCnL4IjEaJi/Te03jgZkrrEp5+1QCuHCTUw0ggLUf54P
 bqpDL7OvFc18bWQRihVmn+UCB3F67PeP7Iep2w5lJ/gPneWh5kublaxZVQoA47wpOMQJvQ/Ck3ii
 U+4DQAj3DhYpgwxEDQuH7GNpv2Hu1lWbvKBSWz9JL+ncH+8owBXh81G7jrpdN7mVSzj08dE/+rZs
 znzhce8qQDHibzsRn4GAzhxhCuY6rzElkl6kBCGRq3oTg7MWD+ZQoaUmN03jRfRyWTWs40tiYHh/
 OVIkQNEvdUolNl0YNdMUajomuQYN/2oiLQnPnhxk6tgp0mibbPhjo3exrvNYlwUjtixib2avL+YD
 c2YHUzAZPzd03ld+uhcl3Gs5gKqK3VAu3+DFOOi3DORNnsq5K5Vt5MJeblz1pRXWhjh9fdbl44I0
 Df3UANye5mij+Mqql8NZoGGE1H07YtaUHC2h22rHSV+m0L6jX0Is2t8eEL3ZqG06ZzoMifa29zXh
 hznXry6IqJne0pFEQgsi+0blRqBey5t6k5sK3TexxWxyube0LJjGSj+jnQa75Jum1feMIVfUDmU/
 w0m9OyPDekvkd3BNWiTFSFOlxsY77ASAZB1sLAji3Opi4pBglvBqtTQxJduSkSzRv5CQHId5vY1x
 DTpc1F/nsvY4ocfmWv3Fe9Iziczdq+A=
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

Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
---
V4: Removed return value on error changes to simplify patch,
that should be changed in another patch.
V3: Fixed requests falling into the void when -ENOMEM and no new
incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
userspace. Also made queue full condition more explicit with
-ENOSPC in `send_forget_request`.
V2: Not scheduling dispatch work anymore when not needed
and changed delayed_work structs to work_struct structs

 fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..a676297db09b 100644
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
@@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 			if (ret == -ENOMEM || ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
-				schedule_delayed_work(&fsvq->dispatch_work,
-						      msecs_to_jiffies(1));
 				spin_unlock(&fsvq->lock);
 				return;
 			}
@@ -436,8 +437,6 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
-			schedule_delayed_work(&fsvq->dispatch_work,
-					      msecs_to_jiffies(1));
 			if (!in_flight)
 				inc_in_flight_req(fsvq);
 			/* Queue is full */
@@ -469,7 +468,7 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 {
 	struct virtio_fs_forget *forget;
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
-						 dispatch_work.work);
+						 dispatch_work);
 	pr_debug("virtio-fs: worker %s called.\n", __func__);
 	while (1) {
 		spin_lock(&fsvq->lock);
@@ -647,6 +646,11 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
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
@@ -670,12 +674,12 @@ static void virtio_fs_init_vq(struct virtio_fs_vq *fsvq, char *name,
 
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
 
@@ -1254,8 +1258,6 @@ __releases(fiq->lock)
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
 			inc_in_flight_req(fsvq);
-			schedule_delayed_work(&fsvq->dispatch_work,
-						msecs_to_jiffies(1));
 			spin_unlock(&fsvq->lock);
 			return;
 		}
@@ -1265,7 +1267,7 @@ __releases(fiq->lock)
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

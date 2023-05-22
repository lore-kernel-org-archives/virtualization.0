Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16E6C77B73
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 13:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD4261401;
	Mon, 22 May 2023 13:40:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CD4261401
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=pabDGQ1u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3jfMRamsDpb; Mon, 22 May 2023 13:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4224F611D0;
	Mon, 22 May 2023 13:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4224F611D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2722BC0035;
	Mon, 22 May 2023 13:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 662AFC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EDD0415E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:40:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EDD0415E9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=pabDGQ1u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtyJ0gDmw8Bc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:40:00 +0000 (UTC)
X-Greylist: delayed 00:20:25 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12FFE415E7
Received: from arg-plspam-c1n2.mailshover.nl (arg-plspam-c1n2.mailshover.nl
 [145.131.15.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12FFE415E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:39:59 +0000 (UTC)
Received: from [5.100.226.106] (helo=arg-plsmtp-c1n2.argewebhosting.nl)
 by arg-plspam-c1n2.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1q15Ri-00AcCp-Mx; Mon, 22 May 2023 15:19:32 +0200
Received: from flex21.zurich.ibm.com (pat1.zurich.ibm.com [195.176.20.46])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n2.argewebhosting.nl (Postfix) with ESMTPA id 14B0D2107058;
 Mon, 22 May 2023 15:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n2.argewebhosting.nl
 14B0D2107058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1684761569;
 bh=P6bcrPun70ZgxGtzACRLRUcE5lkV3AUh/NO9iDbdx1c=;
 h=From:To:Cc:Subject:Date:From;
 b=pabDGQ1uSNVzLjL646QuIUpU1EHsVO1fxgHNmPdBDTS45TMqW8+ew5puXiy5ktnMf
 W+6iymKmOYWLX1vje798VRMJuKOPCPVQXzhi1Qv5WmwT/HjW6qZc6TiNZWJSQssL+7
 6nifcxXYgo5ywjnFX7xXZ51Ic9+PIPko1cWJ8Eu7kxDuPUMK0cSxkp+snj7wHrRPUf
 BvVHh4IEgk1NP2zP9pX92ppvN2qVZxHIve1Rv7jq/HLegq5xdSTrz4bJJ9SHFIbyfS
 VkzOLYaNNc9kCoXaasAZGy1DtVb8Dlw4iAtUeGuL+iqF7bwbS3ZqKLENtae+J394GB
 ajYGRdCYc5g7g==
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio-fs: Improved request latencies when Virtio queue is
 full
Date: Mon, 22 May 2023 15:19:15 +0200
Message-Id: <20230522131915.114534-1-peter-jan@gootzen.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: 5.100.226.106
X-SpamExperts-Domain: out.mailshover.nl
X-SpamExperts-Username: 5.100.226.106
Authentication-Results: mailshover.nl;
 auth=pass smtp.auth=5.100.226.106@out.mailshover.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00482720233308)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9WC7uSP5L3Jzsx+5CwJj1KPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5x7ehOK3L/nnyGmOYSpyDVNdx5A4UrtZinqlN7ZZoUm0adB
 Z1rrq9RWC6QICKLRu519BF5uW54vPvvBVV3ifzD/3BAjRSYg145YtgRevusGI9dQHzdqJX2m5XgO
 2C/DN15/dftBCJei89+NPbmXGYhuWFp4FP9vpsPUjp4/KWVyVO1SevSwcJ9R9pFS3UI+ivVQdlkb
 w3crb0cLOCfkg92q8XMDNGgxMYuTJb3gku0dejf9snPm8NwFaZU7PNFMR6vgq+Dqm83yBD6XPV1s
 pCAg9bnDmXRzJCKv07htVQ5r05FycAnEjC+mE9RnYmZPPu2wiyMdf2nkAB8bRb09VXylNV3mel1u
 jVmLarDPJSJftjmQ9slYi0xvFmdw3ZT/WJm1YfO2qUIrSiIQCVmAULZEj54Ukia1ptoZhGhZ1wC2
 ML0/eL1aNkYkAjNhm2oxT6y69jD+iorG63yfbYSZhfI72ZPHOigPkCGvwEZFV0i6WkQMF99VlWOZ
 Vo1sbhkkbsUzv9iRfu1Z52aYkS25L4yXexf3/pn8eTvzFmUnDyd5x2XXOLITE27jIGF+FEBMunLc
 W16QoG4igbAPg3YupmsHfJyanFK0n799WuZeOadMUyv5K5CF4L/Dm+y9a8gbFqY3ktNcz2hbGXZV
 Sq37dmEm9gOEXpz6psTzQ5f1B6u6IpruJy2dPRg+YFKLviVJavtYmCcUlGwaFuXURGtE65/CA2l7
 3KwvJAkr9FWaWV+iOh4bL4UccAVr4Y0myo1HnapNpbhS7cN3oAQD4T+aP24eGhVFr+ef8nG3x05v
 VkyOMKMmG01VZBdb7+J1tS3t44kZRWzUghNc2smFAMddKssKY1W0wRctB5me4+eI+Z208NBdlQIr
 S8hbLS01RsHaKPpIO+FyBsmlFuMPthm/17smNN+gLCBne2NxysTO2Ls5vjazjXsvmWEQQ9I3HM6l
 TWobAcAhZ5v4OFmDa0qzSFBuE0k1zjUArxWmKMj6dLS5vPUf9oDBqtClgM5jH/om1Q5bmECieAur
 5twaHOueHrJ9iNptPPZJI3RQ30RXP7weyio2M9sn8yjpTdCvFYMJvavj4hZB9ApebjPLlXln+ml+
 OWsV707JFBv/bXW7OE2b7+/uZGKfwf/aJbq1ne44KFh11NNWbtlTMl4lXRDnULke/aeo117jyt9D
 KOrjw5Me7g==
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
 fs/fuse/virtio_fs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4d8d4f16c727..8af9d3dc61d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -347,6 +347,8 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
 	spin_unlock(&fsvq->lock);
+
+	schedule_delayed_work(&fsvq->dispatch_work, 0);
 }
 
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
@@ -388,8 +390,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 			if (ret == -ENOMEM || ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
-				schedule_delayed_work(&fsvq->dispatch_work,
-						      msecs_to_jiffies(1));
 				spin_unlock(&fsvq->lock);
 				return;
 			}
@@ -436,8 +436,6 @@ static int send_forget_request(struct virtio_fs_vq *fsvq,
 			pr_debug("virtio-fs: Could not queue FORGET: err=%d. Will try later\n",
 				 ret);
 			list_add_tail(&forget->list, &fsvq->queued_reqs);
-			schedule_delayed_work(&fsvq->dispatch_work,
-					      msecs_to_jiffies(1));
 			if (!in_flight)
 				inc_in_flight_req(fsvq);
 			/* Queue is full */
@@ -647,6 +645,8 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 			virtio_fs_request_complete(req, fsvq);
 		}
 	}
+
+	schedule_delayed_work(&fsvq->dispatch_work, 0);
 }
 
 /* Virtqueue interrupt handler */
@@ -1254,8 +1254,6 @@ __releases(fiq->lock)
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
 			inc_in_flight_req(fsvq);
-			schedule_delayed_work(&fsvq->dispatch_work,
-						msecs_to_jiffies(1));
 			spin_unlock(&fsvq->lock);
 			return;
 		}
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

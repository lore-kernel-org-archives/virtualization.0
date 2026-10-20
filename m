Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468680;
	b=ypYr/88S6bLIocqdSwWHX/vM6xB+8YH4chiYY7Rl09+Dm53k+pV2dHl2+9lHJ4e/7zYU
	 gObYS3EndO18eXbS6Pun5MCnzZkQ8kCzKFC+q0cJzqa1u+EQrlq2r5baqZxFDQ8rRPnmK
	 cHrPEVINmRPjaWp90ZCWFyQ0Al5FjkxDEFfY8gNPek875pMczciDUakwjb61PVMQ1BCvx
	 diqgJIMl6H3bBtIt9SXdThbfkZSihg5dCZHPxZGU3rn6V1vNFWatUL7BLhnku37s4T39u
	 sQqFzXYt+ux3wJ/1CzFEJpyN9+PWUGBTRRdgcrVmxpELU7irgFMfjHrtd0NYlNzB8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468680;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tw36DOY+NKJEc0tW3hOU3drFnK2hugBKcc7rXv1MyG8=;
	b=tKLuTLQm9N8kRxHayg8V6xJuzfib7nBmMwZPdcbJU1ywdpuLpciPnQjczJ2JvMETrKtZ
	 JjBOMozyjJB3FFbYaSUfFBIQpJG29ifK3YpXWR6BmyAQi7OUtsc76iCmbdxa3mkD6Eq7a
	 z2uTOqiEb4VlseYMPSUoF7E2STDtwbNoZjpUAXWDjR5YXe1bILMASC60GhYcq2qqonv5L
	 5bzeoGHCmtaNbTdKEUhvNHZNf0c5SaOkZ6dKAODfDhYW9hKfJxz0wkYkEI+WL3dz1Uodw
	 +9HHzBmjlPvZc3N0rAgjtEfydCbMLfmer7jOOXZVUBK5NDIOZp2s7gWBcdT6dNI5Fng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SjvJ10Z9;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C762B606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 03:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C762B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SjvJ10Z9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=SjvJ10Z9TRJuxyjxnxI9tShev4l58jQEhpLWfibiT56CdUf2f5Szw3nt6x3hj9Xm+Z7+fTLD97AOn
	 5E9hOwy1Ji7vSS87sEBQgRbNhEeWl+tIt7HcybUv3rFGWiEXzL0oUvQA75af3NbPsZa387JSni/0+b
	 nLBc6U/u6Do7HqZ8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76ad6e6bba4d-19330;
	Tue, 20 Oct 2026 11:57:49 +0800 (CST)
X-RM-TRANSID:2ee76ad6e6bba4d-19330
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ad6e6ba206-bef8f;
	Tue, 20 Oct 2026 11:57:49 +0800 (CST)
X-RM-TRANSID:2ee26ad6e6ba206-bef8f
From: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
To: mst@redhat.com,
	david@kernel.org
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH v2] virtio_balloon: drain update works on probe error paths
Date: Tue, 20 Oct 2026 11:57:44 +0800
Message-ID: <20261020035744.1131-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
References: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_vqs() arms the stats virtqueue callback, so an update work can
already be queued on the system freezable workqueue while
virtballoon_probe() is still running.  If a later probe step fails, the
error unwind deletes the virtqueues and frees vb without stopping the
works, and the queued work runs after the balloon struct is gone:

  BUG: KFENCE: use-after-free read in virtqueue_get_buf_ctx
   update_balloon_stats_func+0x121/0x300
   Workqueue: events_freezable update_balloon_stats_func

remove() already handles this via virtballoon_quiesce().  Factor the
stopping of the update works out of it and run it on the probe error
path as well, before the queues and vb go away.

The same hole exists when init_vqs() itself fails after
virtio_find_vqs() succeeded: the stats priming can fail with the queues
up and the callback armed, yet probe jumps straight to out_free_vb and
leaks the virtqueues while the queued work still references vb.  Unwind
inside init_vqs() in that case, stopping the works before the queues
are deleted.

The drained work takes vb->wakeup_lock in process_wakeup_event() and
finish_wakeup_event(), so this depends on "virtio_balloon: initialize
wakeup_lock before virtqueues are set up", which moves that
spin_lock_init() to the top of probe.

Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon stats")
Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---

Changes in v2 (from sashiko review):
- unwind inside init_vqs() when the stats priming fails after
  virtio_find_vqs() succeeded, instead of leaking the virtqueues on the
  out_free_vb path with the callback still armed.
- spell out the dependency on the wakeup_lock initialization patch:
  the drained work takes that lock.

 drivers/virtio/virtio_balloon.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c1b47ec1..dd2056882 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -554,6 +554,17 @@ static void update_balloon_stats_func(struct work_struct *work)
 	finish_wakeup_event(vb);
 }
 
+/* Stop queueing of and drain any pending balloon update works. */
+static void virtballoon_stop_updates(struct virtio_balloon *vb)
+{
+	spin_lock_irq(&vb->stop_update_lock);
+	vb->stop_update = true;
+	spin_unlock_irq(&vb->stop_update_lock);
+
+	cancel_work_sync(&vb->update_balloon_size_work);
+	cancel_work_sync(&vb->update_balloon_stats_work);
+}
+
 static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
@@ -633,6 +644,12 @@ static int init_vqs(struct virtio_balloon *vb)
 		if (err) {
 			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
 				 __func__);
+			/*
+			 * The virtqueues are up and the stats callback is
+			 * armed: stop the works and unwind the queues.
+			 */
+			virtballoon_stop_updates(vb);
+			vb->vdev->config->del_vqs(vb->vdev);
 			return err;
 		}
 		virtqueue_kick(vb->stats_vq);
@@ -1075,6 +1092,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
 out_del_vqs:
+	/*
+	 * init_vqs() arms the stats virtqueue callback and primes the
+	 * queue, so an update work may already be pending: stop queueing
+	 * and drain it before the virtqueues and vb go away.
+	 */
+	virtballoon_stop_updates(vb);
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	mutex_destroy(&vb->balloon_lock);
@@ -1115,11 +1138,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
 
-	spin_lock_irq(&vb->stop_update_lock);
-	vb->stop_update = true;
-	spin_unlock_irq(&vb->stop_update_lock);
-	cancel_work_sync(&vb->update_balloon_size_work);
-	cancel_work_sync(&vb->update_balloon_stats_work);
+	virtballoon_stop_updates(vb);
 
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
-- 
2.43.0




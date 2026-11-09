Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209218;
	b=W+OtFPkC4htw9M8VDOHCihz4NjBaLvzV6LJ4idmegrby/mLCYTVllxUouMSj6T5i9YwO
	 FipKXq6gYBZjU+dovPT8i6adMbHHD7HVQEFvGbnDIM8tLovc6n78C5SdiCoL6H6up0i/+
	 C1g5sRGRi6FAD0MWDmNYa514wpK1wMpSUqeC4pjh9Xn/ip3kGYS94/5vnsMdPR7P9WlpV
	 pvm6mjc3pyXk3ZLHYMuTcX0qvVf0Ci4/Xlp8Jubs6DFRb8Ae61R4zY8HpqRGui05iI+8t
	 coBIzTiUnqGgp+3HG3Xf6Y9kPJd4V0/BmQFhrzOunAfgwHYzstsGU/Zb6ltiQTg4bsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209218;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1T+08rTJfrm9dutHrGzux/n8hlEo7XuTHhoTpuuF2y8=;
	b=kOz/5xmnPaEcSM/YPgCj+myeD96DD2Wda69mSMsLl7A43XKg9+XaL/o/FvEY1XRC3Avw
	 eqAtuC6Ozhtby5S6Rq9gqQwRPP+1mEw0tlu4RqyNZTLA0QCvMbi7g1BM4YLlyqQHO09Ev
	 XkwbRzhWrAr/WHiqbhjPYxjq6Y7+VJZN/FcT1F714coNyAjh7albdrg7eQeD/jj4r3F7l
	 +f0Qb2ixG6fLeGtTTFaRmvrD1XwJfyHofZPgX8f5cWA8AD7h8E4ujjijGewrrCkyuTmvp
	 KucLR1ZaMM5Ued6sF5n3wgntPI5LKGqmV29uGLmBE3JY2CoLG2wgUsMtRA+ZBN5BXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NQh17WGw;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7C606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 07:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NQh17WGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NQh17WGwMydVuEiQCRAP8+sip4P9YaWzBaLj7U7NkMrbszJlK00t3tf7LpyZhozU2WPSy7JBvCjok
	 tqXJ3HZ7wdN9DQMSmrVo7UKsn3i/FPy8xPX2x9Bxys+GEhfHnUtAo5clf6LPIQtf//ddDRuPhxcPBq
	 VjwMYtz+j3JZo2Qw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af175bdcbe-9e05d;
	Mon, 09 Nov 2026 15:26:54 +0800 (CST)
X-RM-TRANSID:2ee16af175bdcbe-9e05d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af175bbbdb-866cd;
	Mon, 09 Nov 2026 15:26:54 +0800 (CST)
X-RM-TRANSID:2ee96af175bbbdb-866cd
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
Subject: [PATCH v5] virtio_balloon: drain update works on probe error paths
Date: Mon,  9 Nov 2026 15:26:51 +0800
Message-ID: <20261109072651.1410-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
References: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
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

Also reset the device before del_vqs() on these paths, like
remove_common() and the virtio_net/virtio_scsi error unwinds do:
without the reset the queues stay enabled on the device and the next
probe fails in setup_vq() with -ENOENT.

The drained work takes vb->wakeup_lock in process_wakeup_event() and
finish_wakeup_event(), so this depends on "virtio_balloon: initialize
wakeup_lock before virtqueues are set up", which moves that
spin_lock_init() to the top of probe.

Fixes: fad7b7b27b6a ("virtio_balloon: Use a workqueue instead of "vballoon" kthread")
Fixes: 74cf5b169c4c ("virtio-balloon: remove BUG() in init_vqs")
Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---

The wakeup_lock dependency is now in mainline (161aa708b02c).

Changes in v5 (from sashiko review):
- point the Fixes tags at the commits that actually introduced the two
  hazards: the workqueue conversion (fad7b7b27b6a) for the undrained
  works, and the BUG() removal (74cf5b169c4c) for the uncleaned early
  return in init_vqs().

 drivers/virtio/virtio_balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c1b47ec17a2..b30a0ca26292 100644
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
@@ -633,6 +644,9 @@ static int init_vqs(struct virtio_balloon *vb)
 		if (err) {
 			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
 				 __func__);
+			virtballoon_stop_updates(vb);
+			virtio_reset_device(vb->vdev);
+			vb->vdev->config->del_vqs(vb->vdev);
 			return err;
 		}
 		virtqueue_kick(vb->stats_vq);
@@ -1075,6 +1089,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
 out_del_vqs:
+	virtballoon_stop_updates(vb);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	mutex_destroy(&vb->balloon_lock);
@@ -1115,11 +1131,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
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
2.53.0.windows.1




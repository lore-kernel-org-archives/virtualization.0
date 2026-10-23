Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722206;
	b=hLjn6Jjb3khsW3Xz8NNSOe8ofKBGFf6MIQYhCwfsSw/CydXqDwX6Tjs8xIv/gw+KNALO
	 W+O8VanR1NknopxDAp8NmuUflDXD2HIt9rTdgrzon+OOGrv00BCkVatJUT5THKvJ0i7m2
	 KJ9vramfwprtxMY8JzK4BvLXXNNzWPXJpMfKBQjuL4rcHYkL+bXFXHk7tIJ710gW4OYu0
	 DJdUdjFA18RZNnlwJwkH+4kalRrvBMQFYjRsHC/nGbjnc7eG1WdxtNzyC6VwBlN2b/E9T
	 rgW4mUwC4nIo2XraSRjNB2PPuQZdCAtmCrm6bxw2iY181gNVbTVJ3uI6cmwO0eFd3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722206;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8aR471eyUThLQZ47HPLYqJ5jhcDVu3gnhYgQS0O/yDk=;
	b=Vzp1DaeryD8yZLjfgwtI6T0lIV44P3eW7zd7mlxm7XPvBOkIg5fTp/fUmH9LA59/2KY3
	 TK4CIUTvdVQiqfGDdlhiIMoW1P5iDTM7JAQBK4KhQdtIYi3HBKXlxYEKXfrPwSGg+AAgb
	 qVJlvSxk29pMGMVMVriNn1+3NV0Fn4HWGDoZN6Q7vP7S2pMSxqxGjR0q0ClL5ZHkZlAbs
	 Zj9fmzNUx5giO4E2ftOEYyXyIoUvOVdUdX9laY0p9NCDkBhkKg1sGyhz71Mcz5sa62Y9C
	 CeywV5/kU8jB6lQ6HdQBbM9UHibxtajt4/bO0HMhXLoh8i21uEjpvetLaSpnDWbtmlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=byDcUQ8b;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EB606A326
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 02:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B37EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=byDcUQ8b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=byDcUQ8bLcaFJkqjv81W1xI6HfPUk7fwZQKn0w14fcvJ5TsoBkD5glTqZM+MXn0U689Vuzt6NoCMX
	 btgxb4L+JOOALbbdjk5nrGrVhI9D2ZdaJuFOuAJWVcYh9t+29bsxHaOsMTWPgA6fHBrG7tkcjvCnSe
	 SHOrWZ7ztgTQS8ng=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86adac5136fa-d39e6;
	Fri, 23 Oct 2026 10:23:16 +0800 (CST)
X-RM-TRANSID:2ee86adac5136fa-d39e6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-c950f82eaac8410e-20260515094303939 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16adac511d3b-3046d;
	Fri, 23 Oct 2026 10:23:16 +0800 (CST)
X-RM-TRANSID:2ee16adac511d3b-3046d
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
Subject: [PATCH v3] virtio_balloon: drain update works on probe error paths
Date: Fri, 23 Oct 2026 10:23:10 +0800
Message-ID: <20261023022311.1577-1-zhaimingbing@cmss.chinamobile.com>
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

The drained work takes vb->wakeup_lock in process_wakeup_event() and
finish_wakeup_event(), so this depends on "virtio_balloon: initialize
wakeup_lock before virtqueues are set up", which moves that
spin_lock_init() to the top of probe.

Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon stats")
Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
---

Hi David,

> Did you manage to reproduce this? How? (forcing the probe to fail?)

Yes -- KASAN, injection right after init_vqs(): queue both works,
mdelay() to hold the window open, then err = -ENOMEM; goto
out_del_vqs, driven by bind/unbind loops. Unpatched: KASAN
use-after-free with both stacks in virtballoon_probe().

> Does this require the device to trigger us even before
> virtio_device_ready(vdev)?

Yes -- the callback is armed and the stats buffer primed/kicked in
init_vqs(), and ready() is only reached at the end of a successful
probe.

> I guess this path is very hard to trigger.

Agreed. That one came from the sashiko bot's review of v1 for the vq
leak -- it does look at least theoretically reachable, though.

> Do we really need this comment?

Dropped both in v3.

Thanks,
Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

 drivers/virtio/virtio_balloon.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c1b47ec1..cb53acdf7 100644
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
@@ -633,6 +644,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		if (err) {
 			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
 				 __func__);
+			virtballoon_stop_updates(vb);
+			vb->vdev->config->del_vqs(vb->vdev);
 			return err;
 		}
 		virtqueue_kick(vb->stats_vq);
@@ -1075,6 +1088,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
 out_del_vqs:
+	virtballoon_stop_updates(vb);
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	mutex_destroy(&vb->balloon_lock);
@@ -1115,11 +1129,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
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




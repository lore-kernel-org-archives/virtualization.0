Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF43ACF0C
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637017; cv=none; b=SLMH5l7H/ENtRqc6yfGpQeNDCint9olHm4/WpW1mAHhzt0umUsouF/62Jbes4w4pkHn3/4viFg6XAvhX6k3ea4udDCptxE1jQSyGLFba6TW1TAmw+jom9CaQYBsjyAm1k9n4gN32J7jmreOyy98k7P9l2NEbQhCu0Z5SEKYavgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637017; c=relaxed/simple;
	bh=6BE50PGYfcOzHfiZFXGJg6UpG1dZIU8pbR5ePtZrrEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TQpW3ul1qRpLk1BwM5x5cEaNkCzfhFhkZnuaRgQ+mdf2wfzCJ2jW21vY0YQ4gPTFkgzGP8NdWNhyXDXA3JLdkFgr7TUgHOXe1eeMNXa1Cymy92Q4crSqF1wAY8g0zsq92g5QFsaaA4vTv5ejslr0RcBhOYJvzWcXE+wotlaIMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dawtmVCY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dawtmVCY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3811279d51aso789382a91.1
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783637015; x=1784241815; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJx78Z8LFnN8gG9u1+4qNl1x5zV0JVCwAKu/BmzTVP8=;
        b=dawtmVCYaIvFgYXyxDzFEkDm/pJsGCiqIIbkfuQHfr9CrdMvar+gj8/4ALDj31ejxS
         JobmCK7/j6yjA+d7zFg6eD4cILM7riW5kjMK8vVLbhPEagH4RSQgy1s3YsEGIdV9CxNr
         M6YUx/sUAVgSFmUx5TncOcRIyfaKnUJqGEKCsfZRaMS5o2HzMMWO+4koJKtXDpd8vm4C
         nrxpsuh8SP+sDaZkp8rAQyH828LvNYORRYQc0V3qqPrgZgF+ov/99n43xWxoMt244jdx
         RLGYm3PnxqRmoH+Uz78qU2iNwbupY1/3y+ZgTr4c/PkmfDD4sRg3T0xGZ/e6utgutiEX
         m4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783637015; x=1784241815;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJx78Z8LFnN8gG9u1+4qNl1x5zV0JVCwAKu/BmzTVP8=;
        b=WsMQkBV5corywJprqiUkMfIZD9jd7H7bAn5LCv/C5F+jJBBEy2UOLvlu0qGONKGyMO
         YVKxzytMwX54BWZlWp+6eA3UkLzU+/fgs7BW98gPAljsrFPcTKU3RDVbAtRtrBaioCgY
         xUp8qXwO5ahk5GQ1QvPScddWVvv0zs3mmJcuUCr2RJ7clhcqIIqwukWqNahIuIHx9dIW
         RPeZo4zfckQWe/+Og3lpU8BvKAfOmU4/pb4dqP89qUEgCRtEpFN7819i9419RQq48ucp
         klZpsFhf49/Gf6Aq/VP3y9fbShBCO/BX28/8mUIWfECzR0eKT5WplHJo2Jp94dcw05/I
         35cg==
X-Gm-Message-State: AOJu0YwzgnrAczpCdP0ZqKCpENcLemr2y0ZPleYhpQtCYsf5UbD8Iw7P
	UURuS+aHU7ibvkCS4NdkqE6/nm0oT34K7yw4aOpXPhgXQPH9jtdx1YGIU0ySBfW4yMTrZfRaUko
	r6Q==
X-Received: from pluo8.prod.google.com ([2002:a17:903:4b08:b0:2ce:6df9:bda5])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4f:b0:387:e0db:3fad
 with SMTP id 98e67ed59e1d1-38942799755mr9097424a91.38.1783637014957; Thu, 09
 Jul 2026 15:43:34 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:43:30 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709224330.946683-1-linkl@google.com>
Subject: [RFC] virtio_balloon: fix Use-After-Free in page reporting during PM freeze
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	Link Lin <linkl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During system power management freeze (e.g. ACPI S3 suspend or S4
hibernation), virtballoon_freeze() calls remove_common() to reset the
virtio device and delete all virtqueues via vdev->config->del_vqs().
However, unlike virtballoon_remove(), virtballoon_freeze() fails to call
page_reporting_unregister(&vb->pr_dev_info).

The comment in virtballoon_freeze() states:
    /*
     * The workqueue is already frozen by the PM core before this
     * function is called.
     */

While this comment was accurate in 2011 for balloon-internal workqueues
(such as balloon_wq, which was created with WQ_FREEZABLE and is paused
by the PM freezer), it is invalid for Free Page Reporting.

Free Page Reporting (mm/page_reporting.c) schedules its delayed work
(prdev->work) on the global system_wq. Because system_wq lacks the
WQ_FREEZABLE flag, the PM freezer (freeze_workqueues_busy()) explicitly
skips it. Consequently, page_reporting_process() on system_wq remains
active and unfrozen throughout device suspend.

If memory is freed into the buddy allocator or a delayed work timer
expires while the device is being frozen, page_reporting_process() fires
on system_wq and calls virtballoon_free_page_report(). This function
passes vb->reporting_vq into virtqueue_add_inbuf() / virtqueue_add_split().
Because the virtqueues were already destroyed by del_vqs(), this results
in a Use-After-Free / General Protection Fault:

    [  250.709271] general protection fault, probably for non-canonical address 0x7f728084daf08d5e: 0000 [#1] SMP PTI
    [  250.732967] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 5.10.0-44-cloud-amd64 #1 Debian 5.10.257-1
    [  250.751575] Workqueue: events page_reporting_process
    [  250.756665] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
    ...
    [  250.867678] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
    [  250.883446] page_reporting_process+0x225/0x4f0

(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
from an identical lifecycle flaw and are also vulnerable to UAFs during
S4 hibernation when memory pressure spikes. This patch focuses on Free
Page Reporting, which runs periodically, to ensure clean backports to
stable kernels).

Fix this by:
1. Unregistering page reporting in virtballoon_freeze() prior to calling
   remove_common(). This clears the RCU pr_dev_info pointer and flushes/
   cancels prdev->work on system_wq via cancel_delayed_work_sync().
2. Re-registering page reporting in virtballoon_restore() after the
   virtqueues are re-initialized and virtio_device_ready() has been called.
3. Unwinding virtqueue initialization via remove_common() in 
   virtballoon_restore() if page_reporting_register() fails.

Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
Cc: stable@vger.kernel.org
Cc: jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com
Cc: Ammar Faizi <ammarfaizi2@openresty.com>
Cc: jiaqiyan@google.com
Cc: ahwilkins@google.com
Cc: Greg Thelen <gthelen@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Link Lin <linkl@google.com>
---
 drivers/virtio/virtio_balloon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index a1b2c3d4e5f6..45a90fb3abf8 100640
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
 	 * The workqueue is already frozen by the PM core before this
 	 * function is called.
 	 */
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+		page_reporting_unregister(&vb->pr_dev_info);
+
 	remove_common(vb);
 	return 0;
 }
 
 static int virtballoon_restore(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 	int ret;
 
 	ret = init_vqs(vdev->priv);
 	if (ret)
 		return ret;
 
 	virtio_device_ready(vdev);
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
+		ret = page_reporting_register(&vb->pr_dev_info);
+		if (ret)
+			goto out_remove_vqs;
+	}
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
 	return 0;
+
+out_remove_vqs:
+	remove_common(vb);
+	return ret;
 }
-- 
2.45.0

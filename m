Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF55126C03;
	Mon, 22 Jun 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136373; cv=none; b=U+Dtn6/swqfVFPS5pihRi7ddTNbR6QdZGHgjphAO4lHRxKBFkUiSrtt/8eikKT5z50hlLuyW+tOZuCNI2gWLVCokAbWBW3bwFC97OGH+vUkVYl+PXadeIwyo8Xs5VyBlSS4gCb2Yk6PK0O97U9fTg6W431aeuCkh9HCDaKO7OXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136373; c=relaxed/simple;
	bh=xqw+Ltv0NK+PjorAzSM5UFN9Dv1kLsYar47vJWcEzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRYKcJxsR+Pq0G860iUa+hCk5ZldbiFGUMOpJLOhaDfaogMuMi9wdJkJq0g6VdhDuOEMgNee1q0llz/XOYPLP2eTmQx7Yy+bY60tzBDH+8DKUKuJn+SeQ7AbC3UwJ2AawIpjL9V/78lmMACvzsPfxtKOuCgrKFWFJ1Y9//bPCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org; spf=fail smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=eKwCAapz; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eKwCAapz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=jiMVlU2iiq+RGw5HJ9eGDxxDIHcXec2SI+DnMj/Et+U=; b=eKwCAapzyP7p
	2w1Y6UkMf53lqNhAIYGcKQXzFRqLJ7uwn21+W2qp/zlxmh9RStABwnhlN497lHAlp7yOTX64PFRsX
	e2b+d/905LrnCHEvCbD6kLtQD9m+iEgpbG+WDbLBxOwnCqmV4YeYSG8aaQoS+JqM1L4WeIw+1emmR
	+ryI12KYcaqCM1qYbKR4IvKNf0rbAdK0yBHypMxwCHhw6Fqss3iQN+/ldlRUc6EiUki2zgkcpud1S
	5EuUpBAfqDR6rAgnL6FDbgVhAvNSR/SEvdfDDLy3OsWIz6xhNOHThSgjw12/lZUxlobwn7yKUmIQI
	vWkFPVjRBij9ujMrd49iFQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <den@openvz.org>)
	id 1wbepI-00FfsX-1b;
	Mon, 22 Jun 2026 15:37:08 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/2] virtio_balloon: factor out virtballoon_quiesce()
Date: Mon, 22 Jun 2026 15:37:14 +0200
Message-ID: <20260622133715.3707707-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622133715.3707707-1-den@openvz.org>
References: <20260622133715.3707707-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtballoon_remove() stops all of the balloon's asynchronous work (the
free page reporting worker, the inflate/deflate and stats workers, the
OOM notifier and the free page shrinker) before tearing the device
down. A following change needs the same teardown from a .shutdown
handler, so move it into a virtballoon_quiesce() helper.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio_balloon.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..5b02d9191ac6 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1098,26 +1098,39 @@ static void remove_common(struct virtio_balloon *vb)
 	vb->vdev->config->del_vqs(vb->vdev);
 }
 
-static void virtballoon_remove(struct virtio_device *vdev)
+/*
+ * Stop all asynchronous balloon work. The device must still be alive so that
+ * in-flight requests can drain via the host before it is reset or freed.
+ */
+static void virtballoon_quiesce(struct virtio_balloon *vb)
 {
-	struct virtio_balloon *vb = vdev->priv;
+	struct virtio_device *vdev = vb->vdev;
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
 
-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
+}
+
+static void virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	virtballoon_quiesce(vb);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
-	}
 
 	remove_common(vb);
 	mutex_destroy(&vb->balloon_lock);
-- 
2.53.0


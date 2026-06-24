Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B23B583B
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310134; cv=none; b=POHklLPeG2IYc0xGbOEMEcoea63xMNzDwUa9FJMeiYzCa7SmS6N5NW4o3UvXC0sqrnuGpSgqZ3W2NA0rlmJUMijXDc/JHSZxvGn1SPoyzu9WMf6lOomI3qwVcbkczlE4HN8G51CrekhQuFFTbfFIwe+hkuGcwwmPzyF9Ez3pG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310134; c=relaxed/simple;
	bh=xqw+Ltv0NK+PjorAzSM5UFN9Dv1kLsYar47vJWcEzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKMhp5S/k/QbZ9iW+mRxHg41FWWICyp8d13z0L4UGpUnKp6zBaIEqIltDU/qtw9f0rdHygkjp5XU2bxBG5YmsggUnnJfhJixIdZS1DIrV4TGN6SB/mrhnPcnzDdz5W9jF8sFHS4OweLnuP2NRtjW9b3XWadvNDUAvoDcE0VFk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=Hih0yPUD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="Hih0yPUD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49241896317so4956345e9.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782310132; x=1782914932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiMVlU2iiq+RGw5HJ9eGDxxDIHcXec2SI+DnMj/Et+U=;
        b=Hih0yPUDDbRCEGNbnIWX+g6iX1hDBh3gfdVn1GqBh+Ti+JjoDnt2WIxbWJu8/ZlvbA
         ywbKRL9XHLcFfCSIUBddrvelFNCEZMEVgEJ2CwTk213eqfOUBuAsCsLqE0dxJM/qYi42
         /pY9hK9wek9B6gjIIRmYnGec03dHJNRQhofCot+04HEBxYuQ28y9h1nP/4duVDYMBdLp
         63Jx7lJu0Ak+QQcibuwUNqgYOI/nQ0uZcf5Ft6NLVpRNvwHrH3esmXr1IPtcAIXLi4/q
         RvaQ+9kKcUBucT9ByMQhMzFjcGt4RXLRh6n0EuYbJXHF6l/S/Ix8365HMBCo5+MSMemI
         iysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310132; x=1782914932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiMVlU2iiq+RGw5HJ9eGDxxDIHcXec2SI+DnMj/Et+U=;
        b=nhnciRsnBtdGYPCCEy6LcU1+Zm2b1t6eFJjkV/KGZnuolGR2Vd/n8tE9Im8TNSF1Rl
         WiBAVwEnATk+9uTG7umg3aADi5gmyJiw2EBfDgTDCpOfiGvZ11YuamEI7s36v1TWkzsD
         y3542xIsmpzJO2j/tGLg6NIG1f2amoIBJ9xpaRPgar1eArGv3jcjUFCNOFAT+dRXMOMg
         h8BHr9XO/JDMD3ixGmZgpZ+kgJs+6VMRhskLW/PbueQxKbnMmN5+Bcu3zRvLWrFHzm+a
         kzMGY1l+KiDIJ0fHNdPexj37di7LS60sAfPfnoFrhUr3H6a2Eex+T5goW/02nF3tplOY
         aRfA==
X-Gm-Message-State: AOJu0Yyps7Lt+EVlxtjROJaJtqb2m+fhK+y9duUgnz1QP2YomLRVQS0a
	ycVUDCPq2Q1phj5oQLj5r5KTbsjp5fYVpMYbvXVT5CyfFjM8vfi4ovaHEhbm4O82kgA=
X-Gm-Gg: AfdE7cnjEFfUYgZOKbHrFp8zAqUJu87k1+W/ol8uZPfvMXza9Yc1isroq7vRwgzj9M8
	MPOVBk4om25u11FISTUrAX+tMyCvOGyef3oaqzE0e2trTAE+MsGVLR2cgFzKj57gnLbBGH8nFEo
	UtJV724godQkJ+VhjHKytMII/EQTRi3b/GnSXKhhcHHL4fR+dUiY8QGWfgChOgfF9QK1jhvztE8
	IaNuSb4qKcxw5v59KxIAREumaGhEdCGKDinr1SnloJ/jtSyOjIic2KJdG329dfBzKBeWS+aeOde
	9fdaaUd3+Uz4E3l/GTVaiN8X1oOjYDKM+wolOY6FSh/+a88/XF4RFgNC0CpIqbZYAQrXwNBWQCh
	JqxbMGnoEkEnV7hTI/MIgsTD8ArnKxBxPxfgw+52MwGkiY2zmvLDU23ca07p9/B6nQlu5Ow==
X-Received: by 2002:a05:600c:e547:10b0:492:1e36:bb04 with SMTP id 5b1f17b1804b1-4926087b5d6mr35199605e9.37.1782310131847;
        Wed, 24 Jun 2026 07:08:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm519680275e9.5.2026.06.24.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:08:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 2/4] virtio_balloon: factor out virtballoon_quiesce()
Date: Wed, 24 Jun 2026 16:08:44 +0200
Message-ID: <20260624140846.2616797-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140846.2616797-1-den@openvz.org>
References: <20260624140846.2616797-1-den@openvz.org>
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


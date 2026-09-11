Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB25AEC46
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161624; cv=none; b=uiE26AwYqwusitoElo/FE6I/lGXx3plGU/LAIEbWtVVkaVeX+hmZndmOZrg99yj3ji5s8yLXZlXqBhwP7oNx9AKK7noG0QrkBwuRkQeDv1JJFgD9Z+KEML9k+ATQW/fwKKifIyqaQOX5EOztNz92jx1lpZWAiBrmYz9bUvoSTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161624; c=relaxed/simple;
	bh=YIhVHD4J9cX7TfLPkP4rQmfA+W2I7rkNagORAyvwZGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m1QM83SYj5bLxftPybnHUb0+afkOCt9nE2RGSULFEdBW8H2XrW6/VGzbfrWtlfBKcC0Ff9uJhg48vRKC048fURLRhjaxN1YOTVQw+XpIFzVCiNHfRJm3W/KGE1qh7A7ZFCjqQEZfy0H3GXghZbMf5DoLBwu5Svbv4iG9MMkqXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/DwZaps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/DwZaps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789161621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QBDntR8Kc7kI1G0eQPnEmLghdHGikSjpgJr/Az0xYE=;
	b=R/DwZapsqNwBo3u5GPqVuaeLpcxPtXKCOa5H0+SPTaDqOUmlrz9hwSVMOK4iDI9ve5/DSz
	pyTtAz9CVYENYJr8xjg/+fcus5fpwsk+UD9fUiefRz9Ffj62YVYyaK8a/o5kQJu5IDWdkZ
	DrkzmisVJfL876qAIycy60xg9pVfZFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-OMD2g6LdMwygHRDRWhmF5A-1; Fri, 11 Sep 2026 17:20:20 -0400
X-MC-Unique: OMD2g6LdMwygHRDRWhmF5A-1
X-Mimecast-MFC-AGG-ID: OMD2g6LdMwygHRDRWhmF5A_1789161619
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso7539885e9.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161619; x=1789766419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QBDntR8Kc7kI1G0eQPnEmLghdHGikSjpgJr/Az0xYE=;
        b=rr5B3W2VS3M+oXBohzPfiL9Rgf8FDc3IE64X6u70p2axOLcT+c6xCMY9cvIrwl87yl
         jWKzIIOKp38pKDXxwuK28pt9PNlE6lRv/A9KGX4sfTtFb1asezpFqFkRpqDhZr7i7vOO
         dYfH2WH9PCWcqshlgqsKEIFkxqoUQl6SNTv4KNYXV/RzRS0tHU6hKtYs3q0TjjpidprF
         9xjz8hSDEq6Tm34liZgbHiOvRvlqLjsNnZF5LMZA7F67GtNBj3szstqAbfudNWuL+8QB
         TolvOBNZw/c0vu1LXXirHBXHdd9bKFucayzPNCs8PriAJv1S1+JPjvrAjssdx2B81kXu
         4PNg==
X-Gm-Message-State: AFuF++nAKUkT1qYa3PyO70Ar4HduuPLDBCk4iL0qPExwWR5htdMtJu6l
	ggmITZ8du2YiTZSYRrJF7edscGCCO+97lUgdG3y7sXf4vuq1ndOkEFyBKnJPXKP427PknbCprZd
	T7kzNg9OOH7wuCcambyFi8un7asT/KtkUBRKtHhLNubF0fuvEP8ojiqZ3SQD2TBw4USviaeCbIa
	MfF6rTkYMoipVX1fhhUwmbXbyGIpu7Huizl2iAels5yANT4A==
X-Gm-Gg: AYBFou1imcSJulCcb0oddLe9JhnqEs+ljF26FVsc4E4pzVp/LG9b9HtloqUiLfeCMcl
	MdbrxI0cIE4S4SkrJYQ/EZ5TESKTw5HGTqFvqYPYFCudfAffgH3C4UVI9kEwI9t1RJg25goZS/a
	P/snE3/rbSn4Wv6xnlMWNcnX3NMUTU5SzLAJG3yjVvuiHVDCaMnzRKyZi3nQcrT8w2199gTdO+j
	D8tZvkK33hUFrvJhDFB/3jB0qMONgjW/qA5MGN3zEOT9bYdlGm0ADjiyzWMUzE10eWR03oEhGtD
	74uCqKXa/UWNDft3BnYA2d4T7j0oBbzcp8xFYQ5+gm9P/2NGyL0UPEiqwtBDt6kQyxQ=
X-Received: by 2002:a05:600c:354a:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49e61a005b6mr74224385e9.30.1789161619196;
        Fri, 11 Sep 2026 14:20:19 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49e61a005b6mr74224155e9.30.1789161618697;
        Fri, 11 Sep 2026 14:20:18 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6aac22bbsm17560275e9.0.2026.09.11.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:20:17 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:20:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] virtio_pci_modern: move avq cleanup from reset to
 del_vqs
Message-ID: <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789160982.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xQgqkcREL5hAeLOJuu-qJ7wFZpV8gbRTm-FZIzzFZfk_1789161619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

vp_modern_avq_cleanup() detaches unused buffers from the admin
virtqueue and completes pending commands with -EIO. Calling it
from vp_reset() is incorrect: virtqueue_get_buf in the avq
interrupt handler can race with virtqueue_detach_unused_buf in
cleanup, and get_buf after detach is not documented as valid.

The root cause is that detaching buffers does not belong in
reset at all - reset quiesces the device, while cleanup belongs
where the virtqueue is about to be destroyed, in del_vqs.

Move the call to vp_del_vqs(), which runs after
virtio_synchronize_cbs() has already guaranteed that no
interrupt handler is in progress, eliminating the race.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/virtualization/20260911125745.E0A2F1F00899@smtp.kernel.org/
Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
New in v3. v2 dropped sync from modern vp_reset in one combined
patch, leaving avq_cleanup in vp_reset. v3 moves avq_cleanup out
of vp_reset entirely into vp_del_vqs, fixing the race. Adds NULL
check for admin_vq.info for find_vqs error paths.

 drivers/virtio/virtio_pci_common.c |  2 ++
 drivers/virtio/virtio_pci_common.h |  1 +
 drivers/virtio/virtio_pci_modern.c | 10 ++++------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b90c174450b2..28b254ee4726 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -270,6 +270,8 @@ void vp_del_vqs(struct virtio_device *vdev)
 	struct virtqueue *vq, *n;
 	int i;
 
+	vp_modern_avq_cleanup(vdev);
+
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
 		info = vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :
 						    vp_dev->vqs[vq->index];
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..a4ff6ec903a3 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -194,6 +194,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 #endif
 
 bool vp_is_avq(struct virtio_device *vdev, unsigned int index);
+void vp_modern_avq_cleanup(struct virtio_device *vdev);
 void vp_modern_avq_done(struct virtqueue *vq);
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 			     struct virtio_admin_cmd *cmd);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..ef76f35c6b2c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -345,7 +345,7 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
 	virtio_pci_admin_cmd_cap_init(vdev);
 }
 
-static void vp_modern_avq_cleanup(struct virtio_device *vdev)
+void vp_modern_avq_cleanup(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_admin_cmd *cmd;
@@ -354,6 +354,9 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
 		return;
 
+	if (!vp_dev->admin_vq.info)
+		return;
+
 	vq = vp_dev->admin_vq.info->vq;
 	if (!vq)
 		return;
@@ -557,11 +560,6 @@ static void vp_reset(struct virtio_device *vdev)
 	 */
 	while (vp_modern_get_status(mdev))
 		msleep(1);
-
-	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
-- 
MST


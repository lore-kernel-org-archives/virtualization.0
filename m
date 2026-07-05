Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2F1BC08F
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254567; cv=none; b=SmRG7SlXz00YyaU88HJFJpz0WLPQOqCPNFyFHqgmca9kCXtAHeoB8K3SgotDpsvwHgtnzPgXvs7+lGm2bSFLB+GbF5kqKpjyNBt6uxpX0DqbsxQb9Jp6qbM6qLOUC6QW/C4j5iEHR1OZPU+z6+v4HknSAy6LzSTzjJQEY4uPDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254567; c=relaxed/simple;
	bh=sUPCZFKVZYSZizVcGO8QyWU2iHqrqWwwrlX0gFFhwqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozco5Vk1sewM1zXQo0vGZbUDQUWw13L8QMV44I4FtoWSeKOL3CW5KwP6bXv52JFFnFBZirUe3ErDA1eIvCVGufz++/UQNN3mmR4GGC9xMjOBi/ulp27UzyE9V42cLvQ0Zz5mmbZOkav+a+Wx2RSMM9q/MZCtikiFzdQiuCRWeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJ+Nvw+x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJ+Nvw+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783254565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0SDswT7cmCrS58i6/zKEqMM796iAsVOO0HY0mY45cAc=;
	b=gJ+Nvw+xANts5DExP1RlGhBWuA5nbkXcxGwSUlwqsWdYapcW+3GPzNI/aKBnKOPiTQMqbL
	KR0IgoQP+FSUXFYtcNAt5JxYT3iNNPQSNXPZnTgz0pqWzP7x0dC7pDP1nGA7CVccJFwMrj
	vIVDnivJaxyrfo+ld3idljCGPkDcBqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-MsP4fML1PmK1YL41WN8jGA-1; Sun, 05 Jul 2026 08:29:23 -0400
X-MC-Unique: MsP4fML1PmK1YL41WN8jGA-1
X-Mimecast-MFC-AGG-ID: MsP4fML1PmK1YL41WN8jGA_1783254563
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4926d371224so12302035e9.1
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 05:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254562; x=1783859362;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SDswT7cmCrS58i6/zKEqMM796iAsVOO0HY0mY45cAc=;
        b=RVa2L2B/PDp/oMrs79eIZ/x6kMgt5kP42ZzL8Ax8jg7AIDXm9WKDtNZRvGUX4lt4kI
         La3Atn5Tje7tya4adxxj739ioXvv62jrV0MGt7Al7Ut5sOfkUcNS+/TAj6ky49izdKO0
         M8OF2Mum4xD9w9dCxG11lBgyCYpopRWQRTZJaK5IR1xcgxWAoZ3UFKreKUNCe4590hBC
         ZG5QoH/qZSsKuhUbdjyPSdmA9LtBvAt5nAVlE+Rb7/D3MUqUiWoddeUpQWz6Ak26pXdr
         /eSoFNVbNQNa6IYmMHf29s66nUiUPzeg75Zm2qK9Z9dDeZz3Dz+nVnQu/y80WyXF7mSB
         IaHg==
X-Forwarded-Encrypted: i=1; AFNElJ+PVHZK2fmeY0pPIycKxYq1Y1WgYlhejx4jyL/TPPCmX6wOcBsILgl7GvwSy8ROhd1IDJ7pw/cYrbXCebDE0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmmmeXHVqb5bOZ0njSmC4umxAiqqw/1/oDFFpFnisFEMzTonX+
	lA8dcE0XdUhjNLgTk1sqDy8NTpWVQRtPi3fF7PlHmEd2gB6m8wIsPLPguw3nNhNpO5UFY/NWLk4
	eNK19VWlM1DxriHyyo0FeEwl/iM2Mv1uYkKRouOdUhnPOkYRCV6iYt1wtE5hOEG5njIt5nVL7gv
	qQ
X-Gm-Gg: AfdE7ckHyq1qQLEmlWefpwpHidv8Hpljyoju2wkzAXOM1gaOovX5gfDRcOdnrRGz6oT
	QQfZtr9hh2Uc+m65ORdJCeVHkXeXgerNrdCkbZNFtthlMGY1W5f02GSZRFQAd0Y7LmgspVcfrNw
	FFde14TyfMbiusBL0Qx7W7HgfTGerbvQm+NYPVp6Cp3kV0URRPuUf2+m3+l2oKqOjjjczvTaj2w
	4wcH4P+d9qM/u5NVsqo806ykWLr63fmHyFClRNqTQ3qZlg8otdzyXo3wq3208OJZlnaNmsvzBck
	VENYn9bR1RJhMfdCLKb3JUS3OKAhTkc/PiU2l+1ePK9pELJnNtnYanhqDZJ0LJeivA7WvSNwe29
	pWuKjYyYEVmu6jTBgHcjEsHv1UhqumKLA
X-Received: by 2002:a05:600c:8b76:b0:493:d21f:8f98 with SMTP id 5b1f17b1804b1-493d21f9075mr61386055e9.36.1783254562423;
        Sun, 05 Jul 2026 05:29:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b76:b0:493:d21f:8f98 with SMTP id 5b1f17b1804b1-493d21f9075mr61385775e9.36.1783254561979;
        Sun, 05 Jul 2026 05:29:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef11338sm324763105e9.1.2026.07.05.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 05:29:21 -0700 (PDT)
Date: Sun, 5 Jul 2026 08:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Adam Litke <agl@us.ibm.com>, David Hildenbrand <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] virtio_balloon: prime stats vq after virtio_device_ready()
Message-ID: <224c6b25160642c1b66f55d90fa6828e19bf307d.1783254472.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YXj-J99dwUjbJsnieSMhz9437JR3AHRq1Jhc8QP9cf8_1783254563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The virtio spec requires the driver not to kick the device before
DRIVER_OK is set.  init_vqs() primes the stats virtqueue with a buffer
and kicks the device before virtio_device_ready() is called in
virtballoon_probe(), violating this requirement.

Further, if the device responds to the early kick by processing the
buffer before DRIVER_OK, stats_request() fires and queues
update_balloon_stats_work.  Should probe then fail and free vb, the work
runs against freed memory.

To fix, move buffer setup to after DRIVER_OK. Be careful to
disable update_balloon_stats_work while this is going on,
to make sure it does not race with the setup.

Testing: tested that stats still work after the change.

Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: Adam Litke <agl@us.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Fixes a bug reported by Sashiko and pointed out to me by Andrew.
I guess I'll queue this myself.

 drivers/virtio/virtio_balloon.c | 39 ++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..d4cd2dd388e9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -611,25 +611,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		struct scatterlist sg;
-		unsigned int num_stats;
 		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
-
-		/*
-		 * Prime this virtqueue with one buffer so the hypervisor can
-		 * use it to signal us later (it can't be broken yet!).
-		 */
-		num_stats = update_balloon_stats(vb);
-
-		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
-		err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
-					   GFP_KERNEL);
-		if (err) {
-			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
-				 __func__);
-			return err;
-		}
-		virtqueue_kick(vb->stats_vq);
+		disable_work(&vb->update_balloon_stats_work);
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -916,6 +899,22 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 	return 0;
 }
 
+static void setup_vqs(struct virtio_balloon *vb)
+{
+	struct scatterlist sg;
+	unsigned int num_stats;
+
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
+		return;
+
+	num_stats = update_balloon_stats(vb);
+	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
+	if (!virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL))
+		virtqueue_kick(vb->stats_vq);
+	enable_and_queue_work(system_freezable_wq,
+			      &vb->update_balloon_stats_work);
+}
+
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
@@ -1059,6 +1058,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
@@ -1148,6 +1149,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
-- 
MST


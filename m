Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F866258EE9
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278784; cv=none; b=GVDUCoptbk18Zg4EXOrdg0+hRZ9IHAK3dBjzUiS23hWyouGNeI4lL405CIrnhwIOy4mud/Is6CokwffZ4SWUSEkri2+kDlax+93JFAGEQ6lmBzpsu4ZnOjygLLQb0UsBZoT7XDLFVYZlQ4bJaIOCsOgcc2i7LexgVhGn1Ln2V7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278784; c=relaxed/simple;
	bh=bxZuprF1sYCFOSFNfYLjeOb8S+aS3zOpK6MAxVL/xHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HP/W8x3C5+C5BIxAsKJQL0EpPw2bvKy6xUpi4CcTjpR6KZ/6e6cvkHYdY4OHCuxSpYvphiD/znEwfxY/UmCP1hwg5m5fAa1Jx0Zc1S3jJSJ38/0XA61ZQTefsL8aut0LGveszPdxAqwg6HdmoiH4CSHJKggoa+uRTLxs3LRFiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVA6VhIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVA6VhIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783278780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0lF1I4MmcKv/IoVfeZbzTgrU3xgP0uy4UImjIzL59PI=;
	b=bVA6VhIe2Bzt32GUoa67x1RSu4nEK2itzAUZwVxVS/V/P0OenFuqiwRTQq9WOq1SqchY4Z
	oXTY5v/nJcHSgp0ev+xZXAMurGQ9T0ne2uNkxgBBUFnn/yrct6/tppclLUxY3D38AsiOgW
	F9PPIr+SsTCQtcCszEIW3EAj9C58Th8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-4czRh5AROtm0tgfnfKiJow-1; Sun, 05 Jul 2026 15:12:58 -0400
X-MC-Unique: 4czRh5AROtm0tgfnfKiJow-1
X-Mimecast-MFC-AGG-ID: 4czRh5AROtm0tgfnfKiJow_1783278778
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so22005275e9.3
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 12:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278778; x=1783883578;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lF1I4MmcKv/IoVfeZbzTgrU3xgP0uy4UImjIzL59PI=;
        b=c9XMcTsPPRteTh2MVCCDnDurNwhr0d3YyeJu2ijFXBVFMwRTPfthsfUXRqt9M3lWPS
         CP24F9GK2nrpjNsTU0Z/VPaqDO0ub9TTsnTdSorwgI1WDl6NBcmlS+wp/wImCKRdA8ih
         0goGVTHN+uzReH0quv9O+pGFdZrXdimd+vXAEGH+E92PtBvZHfK8Kg/Z47L+9VCSDINb
         Xrr24zsTa/5g/hGtmb13E8c1pikhY93r/s/rC76l5zCmVylAQQXpEpJVPnMwIIOD98u9
         lF4LauAAba/UAsAeGSNFrQMZEZax5B3FKO7Qk+Hm1E6JwZVdLdmbe4L4iqfU1qs/7qOI
         H0Qw==
X-Forwarded-Encrypted: i=1; AHgh+Rqz5aTZgIzXiiE5X3G+TXF5WwaXu7MMLII97ct7ZnfrUdaM5REpgz771F+ELOB7sLPtKO1ibigmKajm+eXGjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS4xFjCjpQFJzz+1t9j0rcsrUTh0hddqmTIHjMmIil5ZEqIXiw
	YQtCjZSicZyzlDgXaBuN8ARaWu5D93XA6itYtFsCcSwVDNumKvrgx+5EUuPXsCdkLt6cKswuHUo
	KJqW2DQIHUYOGx/AIZfqpCXDeLHiZ0Wu3VjN3Il4apsg74vB5FgpFbYgN/+/6YFJf5jlT
X-Gm-Gg: AfdE7cmloNuNctjn2ECiZ3UfsNq/oHVL9rv4CXX95PztJNzlZjviSxX0D30vwU+OILt
	WgXD0akA1XMf7ImM7uYvg//5MfCFR9czfH8v8jopNJ9HCwab2tsXxivUtlGCuf0f4f6SAlw8T78
	yfDUbJ7erdFR44OIlyBc2CwBVB5syI+85bd2bSb6UKltBSVJc4UQ6ieWVMA5zo2TCX+5sR/Wc4a
	EqAYKP+LyRzaRMm1clSmHhIHJ02tIvegtLS2nF+v2GYFCWMfqJCty2zRDfOMMKP+tsL0J8I8BC2
	xcajj2qDtK3DySpbHb7wCfkkIsfTEosmGaTKFNBiuLCzbDIhM3UdEW64NSVY4uqL0+QKPrxNbMb
	WEKBl76Dzg/jJNidJrELujf5OvkKM3nPA
X-Received: by 2002:a05:600c:3484:b0:493:bd73:c77a with SMTP id 5b1f17b1804b1-493d11f6d05mr90533105e9.29.1783278777532;
        Sun, 05 Jul 2026 12:12:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:493:bd73:c77a with SMTP id 5b1f17b1804b1-493d11f6d05mr90532895e9.29.1783278776999;
        Sun, 05 Jul 2026 12:12:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccb4cafesm212002865e9.0.2026.07.05.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 12:12:55 -0700 (PDT)
Date: Sun, 5 Jul 2026 15:12:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH v2] virtio_balloon: prime stats vq after virtio_device_ready()
Message-ID: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Q23PZmW89mb-NPCWjV7Ob7q5OBI6vB9kAClqCTt8F4_1783278778
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

setup_vqs() warns but does not fail probe or restore if
virtqueue_add_outbuf() fails; the call never actually fails in these
contexts since the queue is freshly initialized and empty.

Testing: tested that stats still work after the change.

Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: David Hildenbrand <david@kernel.org>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	check that work enable/disable is balanced
	explain how add buf never fails in probe/restore

 drivers/virtio/virtio_balloon.c | 50 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..bc0a2b19ca7d 100644
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
@@ -916,6 +899,33 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 	return 0;
 }
 
+static void setup_vqs(struct virtio_balloon *vb)
+{
+	struct scatterlist sg;
+	unsigned int num_stats;
+	bool ret;
+
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
+		return;
+
+	/*
+	 * Prime this virtqueue with one buffer so the hypervisor can
+	 * use it to signal us later (it can't be broken yet!).
+	 */
+	num_stats = update_balloon_stats(vb);
+	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
+	if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)) {
+		dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n", __func__);
+		return;
+	}
+	virtqueue_kick(vb->stats_vq);
+
+	ret = enable_and_queue_work(system_freezable_wq,
+				    &vb->update_balloon_stats_work);
+	/* Make sure we balanced enable/disable, or we won't report stats. */
+	BUG_ON(!ret);
+}
+
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
@@ -1059,6 +1069,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
@@ -1148,6 +1160,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
-- 
MST


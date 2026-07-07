Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2C1EB5C2
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783458029; cv=none; b=H6fIGn0NlxznyvDlct6e2ufOyLnTpFQFvPaS+ar5C+gQCgp3ED0xg5I32uPAkxKhcBkg8SanBZOiBcDSXc+z/kuH6zKbRgGnRbcYyMWR8HxwzqTJcetlSk+omH3M4Icw5V/nWFe2kqv3Uss2BCoe656kxKQDGt6B54LF4+QQKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783458029; c=relaxed/simple;
	bh=0mBsGbgBTeVM/eW4enC7aj4kXxmBKZJh8tBWxys9SbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lN6lZZlc33KaW/RkIDuoZ63VqbqxcnRumMViOxEJSgLB3ePimfQbVcuGavumRIZVaTDseWWrg1Aq6L2ZtWre+OhwU2h5Zl0jY8FlBnFZk9NR7Ubc9nE8jQI21XWYUOGE1JcNpNWfKP9d3M3PICfoa35Jr5dB+b7SDIoNqrffX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgKeG76Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgKeG76Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783458027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kKewETw3VUxgZoi1+l0iiO2wkszqPLLirEDaQBs0im8=;
	b=CgKeG76YhRNJTc2i89TrGif0dzs70UZXBoNw99xFeLXPcpEWTfbFGwHaruoy2l2lFRdcmc
	aFbyXrSKsnVMcluROaI1WAmLM8iz7iA0WN+d5ZPTvtT2gatc1qWB6Inyyl/Evm6PC1lpji
	3N39Mh6sLknRILYSLqs7XlHveB2nyvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-bVM8jeqpPYGvv16M3B1WBQ-1; Tue, 07 Jul 2026 17:00:26 -0400
X-MC-Unique: bVM8jeqpPYGvv16M3B1WBQ-1
X-Mimecast-MFC-AGG-ID: bVM8jeqpPYGvv16M3B1WBQ_1783458024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bf840a69so33629105e9.3
        for <virtualization@lists.linux.dev>; Tue, 07 Jul 2026 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783458024; x=1784062824;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKewETw3VUxgZoi1+l0iiO2wkszqPLLirEDaQBs0im8=;
        b=cwP56+9SQgocwD5VLz/JGES3bQms0T2CctAXisNWiM29+sV2eV06gld8GBYqJHrjdQ
         cgMcJ9+62n94AzpbiL32muWybGMV9Ye4KdXWEp1wT6nd+oA4lo62x2WEaVXZW9R0YvEY
         XkstzUx+9Ts9GbzuPa+OiZPf6JkXS+bSaj74C/f5kR55CdNvhqOXyWj5EcE4cbNpL46r
         Ewkkg0Q87wedNZ9KaMxbMt919pQ3ySSHHoI1Oxd1IkQgj1MKSOR5G1QBusN7C30Xpq4O
         UZSWenInNGqHKr1q1THyn9Cy9aa0eodiv5fMVRtp5AMVr3I+DfbESObOBphwMICw7wSl
         AxcA==
X-Forwarded-Encrypted: i=1; AHgh+RouTMXf9FtMJ2z7KQnYPVTORhZMX+3CEkPAkmUvOdvG+g8hJt85Ts4MsZZXaGoEQD0a3jlPSWnE59WHP8SkLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3ka6McvvaqOg0K6V+NAieX01Yu2Yu3i3Q8QjQCIsruUP5jDgW
	StYvjDFBEexvyc55/gbM/PqMopyKqqEHN+EFC/IFVAZ1AYZW0YQpOPSiTk1d8M8hJBgDetLLi17
	//wpeyK332t3RH7spp/Q0hchYBuwTD1kwDpOhblZTfFgvmv7yd9ctxypo0ST/2sjnYeqhMsQjxc
	0A
X-Gm-Gg: AfdE7cmaDYly/PnLbN/Qg0PNi98dY/LCeaw/WvlU9P3mlST3hNjKxrJpV+1Kc8k+Bkc
	BOlAnZPqOGZdTsSOsZTQcWhaYGdaMkWcJx6YAnECOLm11RqURV/2AL6Zz5zLPUtbfC303Sni2Lz
	fXfmTmdP2skBHf+Sj29pYO0LuXlUqvT/FF0SqgUO+guOafM7jOB9e2TwWQpaCHnmdwHvmEnKSnk
	aBINZ4nQXU/SlrlXo2QH1gQEVfpDOqe6UZBpRNZbDr4tTGgPTUi2e2eEWu7zjvz8Bx73ldlgov0
	bUDfhTNNx5REy76BhGdoYS4Xz+X2O/1NWyTNlA4FiW2z9GD74K6b0cDTxYwJ03F/RO+22JVAGZA
	ipN11PXFfz6M+qSqHPB1n94kL479m+JEC
X-Received: by 2002:a05:600c:15d2:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493df06cfdamr51675805e9.30.1783458023760;
        Tue, 07 Jul 2026 14:00:23 -0700 (PDT)
X-Received: by 2002:a05:600c:15d2:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493df06cfdamr51675435e9.30.1783458023000;
        Tue, 07 Jul 2026 14:00:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d7801sm37233013f8f.16.2026.07.07.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:00:22 -0700 (PDT)
Date: Tue, 7 Jul 2026 17:00:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH v4] virtio_balloon: prime stats vq after virtio_device_ready()
Message-ID: <135278ef075f563ca5b0f3a40e2afcfeb7454f99.1783457622.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wIBl-OKAGpuVhirFh0rw6wDY2mM2_4mLIJCxIcm5gzE_1783458024
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
Cc: David Hildenbrand <david@kernel.org>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---
v4: extract stats_update_and_send() helper; call get_buf() before
    updating stats buffer in stats_handle_request().
    also ignore add bug failures (never trigger anyway) (reported by sashiko)
v3: add disable_work comment and BUG_ON -> WARN_ON_ONCE (David Hildenbrand)
v2: check that work enable/disable is balanced; explain how add_outbuf
    never fails in probe/restore
 drivers/virtio/virtio_balloon.c | 67 +++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..4c4b9bea4356 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -417,6 +417,17 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	return idx;
 }
 
+static void stats_update_and_send(struct virtio_balloon *vb)
+{
+	struct scatterlist sg;
+	unsigned int num_stats;
+
+	num_stats = update_balloon_stats(vb);
+	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
+	virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL);
+	virtqueue_kick(vb->stats_vq);
+}
+
 /*
  * While most virtqueues communicate guest-initiated requests to the hypervisor,
  * the stats queue operates in reverse.  The driver initializes the virtqueue
@@ -440,18 +451,11 @@ static void stats_request(struct virtqueue *vq)
 
 static void stats_handle_request(struct virtio_balloon *vb)
 {
-	struct virtqueue *vq;
-	struct scatterlist sg;
-	unsigned int len, num_stats;
+	unsigned int len;
 
-	num_stats = update_balloon_stats(vb);
-
-	vq = vb->stats_vq;
-	if (!virtqueue_get_buf(vq, &len))
+	if (!virtqueue_get_buf(vb->stats_vq, &len))
 		return;
-	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
-	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
-	virtqueue_kick(vq);
+	stats_update_and_send(vb);
 }
 
 static inline s64 towards_target(struct virtio_balloon *vb)
@@ -611,25 +615,9 @@ static int init_vqs(struct virtio_balloon *vb)
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
+		/* Prevent update_balloon_stats_work from accessing the stats vq. */
+		disable_work(&vb->update_balloon_stats_work);
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -916,6 +904,25 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 	return 0;
 }
 
+static void setup_vqs(struct virtio_balloon *vb)
+{
+	bool ret;
+
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
+		return;
+
+	/*
+	 * Prime this virtqueue with one buffer so the hypervisor can
+	 * use it to signal us later (it can't be broken yet!).
+	 */
+	stats_update_and_send(vb);
+
+	ret = enable_and_queue_work(system_freezable_wq,
+				    &vb->update_balloon_stats_work);
+	/* Make sure we balanced enable/disable, or we won't report stats. */
+	WARN_ON_ONCE(!ret);
+}
+
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
@@ -1059,6 +1066,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
@@ -1148,6 +1157,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
-- 
MST


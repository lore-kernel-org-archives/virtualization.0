Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEA30B509
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346200; cv=none; b=BDResc+If3PTV7MVr8TsZ6/VFEfLwpjOjPPko4LOGZX6eloSKFKe31plRECAKr8d4SD0qjl9ewm1LckINYSmwBybziB8THuFkKP946bSPBpceYJEX50H8n+T2Dj2uwSZdtogqhf5dvudSeoedvc8vx+QOw+C3kT2Fr5mCzeBblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346200; c=relaxed/simple;
	bh=oHpP9KLe/a8VAHGTWmHz6/nGD8e/95nl0MezaM5bdlU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qcwEKEO3rYSw6Bi07q/hpbvNIKUaWVcrSsVptOtGo8geOMJiIt5IL3fdxqV7S09lI37OAujrmottknrl47O5Nzp7znVetIg8ZXpZ08SXR0Gm1SsckVuRbldvZa1h6VkzQjE16EhAM4yfZsYg4hC107z4FFkPXCJQ/y4URbplDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwYZm+Ca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwYZm+Ca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783346197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Rm6w+k855BbWTfcfW9Li8LPIPg6gw4XTE0RbL1Kwijs=;
	b=AwYZm+CaXde5Edl9Xez7xgOSpXyhSli7RFWKBf14OjSC7x2DlPovq5UZ6Nuec9IBuVYSNu
	9jPggBO2AyFt0Z669hv/VzDnPyWqe+6GpS2eo2g88rDGYk5a4qZsNn86r7Qh+genOn6U04
	u5xzUSpV5IHdDRA+qfOMi13VejecArY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-0b0IEq_JMqmI10aO5SBukQ-1; Mon, 06 Jul 2026 09:56:36 -0400
X-MC-Unique: 0b0IEq_JMqmI10aO5SBukQ-1
X-Mimecast-MFC-AGG-ID: 0b0IEq_JMqmI10aO5SBukQ_1783346195
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473941177b0so2783764f8f.1
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 06:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346195; x=1783950995;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rm6w+k855BbWTfcfW9Li8LPIPg6gw4XTE0RbL1Kwijs=;
        b=nNv5gnMAKLjxEkDN0ruJXkb9zeFjmEPV7D8tc7hDYO3AHao+6KXQW4cV6g7dwBaJnw
         IVsdvVPGKRtXulXvZIqg0BkU1B81itP6Q6nwRDl6d/yrXPxb4L8A4GtvpfqGbSlAgj78
         bQzkGdhXkQEY6x6Wk6kZPzxo1fVsw5+65PP3Ky7O/X+ohq4P2pNIYy2BuTfr3CNfJwoS
         TSWdnon8ReR/Y7a413zsQl/0Bv8MuA++vbadW9KEaQ8zcfhjWIks3GDsgmANdOt9ASXs
         NjRRrSCPElk2NogdMDwaCa6+o/z+3qJctEUuk1g2O1VgbLJIB6J/6CxMNmko7YxwW30w
         kIvw==
X-Forwarded-Encrypted: i=1; AHgh+RpRxo3nGdoDp2JI6tMqCBy9HoVT88P+r3XwmCyHZia9T1GWLXXcBlr86hmmZImQJKDxGTXl9GrLdW+lOqK/hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTTw3hQDV5w3sss0ZqXtyPb/Qfoj6lY3khmMW30SXaVzothsYs
	qBr8DYpDzVgOxj/pBKKenqC6EVTzFKmfSz/Y2EGmiKXhS7xZDsTKt/tG+/RR0Ge7HA0TsgZJvaR
	312KnTqdOZZ5ARCyK1CPlxepo2UQ5ehpGFTD0QiRraaFEZolQVTy0Cwy8htGJU5PPUI9W
X-Gm-Gg: AfdE7clsUq5XyKKAO2Lsj2lyCWxJe0JnO8Xq4VYHcQgwmPRPvD2esdTaU4bH19p3S6Z
	QqyIOGePVi2oR+IqLWrwEHkIRm+Rfwq+ccC6Jpzimt5WkNOBYcyy3QPhgnrTu8vfQ3QUttBE8hy
	yB7UlejJr/DDoCUF9p04kyXbS6fTYg7UjPQBDGNgRTv8+oM2V71pM/GOilsU2hwACdXxohP+Hih
	ALE59vrKcnd7jzWD1M1vD1SfaqDitCEvVHomY347loZP3bauhSN45ViLEdTHIfBA5/802RvQOv1
	W4lAIVLXrey6CzA9oHy0kKS5/fssnWkrfpZUm0d3JeJlSNyWHQmQVuQKYjdGowQ0xMwRTfoh+ID
	75P6OcIvq9LzUTFPCh04RfrO9s1zXPiIA
X-Received: by 2002:a05:6000:46c8:b0:475:f0c2:75a9 with SMTP id ffacd0b85a97d-47de66f7156mr210249f8f.58.1783346194747;
        Mon, 06 Jul 2026 06:56:34 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:475:f0c2:75a9 with SMTP id ffacd0b85a97d-47de66f7156mr210217f8f.58.1783346194064;
        Mon, 06 Jul 2026 06:56:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm25595382f8f.5.2026.07.06.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:56:33 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:56:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev
Subject: [PATCH v3] virtio_balloon: prime stats vq after virtio_device_ready()
Message-ID: <e44dbd5010b20983f16ab6ec0512dba3190adcaf.1783346070.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xxIPrvLj_rSoLDyd1lGHfIwfRyRx3PJZt32nvk6j37Y_1783346195
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
v2->v3: add disable_work comment and BUG_ON -> WARN_ON_ONCE (David Hildenbrand)
v1->v2: check that work enable/disable is balanced;
    explain how add buf never fails in probe/restore,
    add back a warning if it somehow does

 drivers/virtio/virtio_balloon.c | 51 +++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6ce6..83ae1f3cd460 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -611,25 +611,9 @@ static int init_vqs(struct virtio_balloon *vb)
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
@@ -916,6 +900,33 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
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
+	WARN_ON_ONCE(!ret);
+}
+
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
@@ -1059,6 +1070,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
@@ -1148,6 +1161,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	setup_vqs(vb);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
-- 
MST


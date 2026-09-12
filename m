Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B4427F89
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209028; cv=none; b=ndeWx3bgqxybjx0EtX8Hvb42PNMUxrPho+SjHTxuQgYND6u13oYQ7RqsY8HZWsN2ZWkhJT8Ktgu4APO5rDQ3SG9otIfHrAB4TTQVShbt/cV2GztYgvC2TfmZK7WV0Iwf1yGOUxYFUAALvRQytHknfXsHupxlkkoZnLCWPh3J4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209028; c=relaxed/simple;
	bh=Ge1VSD4EhR+T+5baxH5LTs4UbrdDzHY/oZOBNhGf8WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FGco+UU9NxOaLHjdqw37rgy8e3xv15zXPI6k9Mn+GzVhjjh6paXYNHGPzpbeJzMC17UhXbNxdyBQZV2rw+DJ/myxJpapS2rs1zNo/f2zPGmmBvgPpKkxEdJPUiT+ClETGap/bbIUzem/pTlKC7f6t2wibsIL5/I0r8ea+BH/uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNbLpBVS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNbLpBVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789209026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSEKt8b2T5ZUq53xnc5HGHRh5k/gLB6VjqYwxmbeHAA=;
	b=jNbLpBVSSDjz/7AYXSyYriFNbCay8wYrxmlaYcSTmoQLlKSyeTtrZUzX6JeS3YSUDesg3B
	W2R/1tjWLuthZcqFSZnJT2Fxq72yWxlWl8wTbkp/oqZVPWlKfN0dMwthIJMMJppUcZ/apP
	dwC6wr1svxGc35KYCtKGP1NXCWPaKmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-PUy2wOF9PkaUVban5VPL5Q-1; Sat, 12 Sep 2026 06:30:23 -0400
X-MC-Unique: PUy2wOF9PkaUVban5VPL5Q-1
X-Mimecast-MFC-AGG-ID: PUy2wOF9PkaUVban5VPL5Q_1789209022
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso10492485e9.0
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 03:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209022; x=1789813822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSEKt8b2T5ZUq53xnc5HGHRh5k/gLB6VjqYwxmbeHAA=;
        b=kvFNQ37vDJ2PcBOmRp1pB+OjpvrVWn0qrr1Wn7wDv0n+r/q/FTEhG++zs3YGeqkAwW
         4dARmcwNQZQZOoVwQtet+q+CHAT5bXPW1bIldRc0rCldjFChm4N2kxrUUPCJJzw2a0F0
         6LvVR4YC94J3ZsVFrFz3249ZtxGA/oJn1TzsgRFQb7I7kR3rw87v11QCegk9uuVhxXSS
         PSlC7uih4hSSC42aewFqq3UW7u76/suY5p93gj/Og5+uVVsrF/zsI7yXNAdflD1yHIwU
         owq/cXrA+hff4a6qsdcj9G0+gICzPCCTDCeNi1geYtMdwYUaGNuCN2tkLkA08izHZbJm
         /Alw==
X-Gm-Message-State: AFuF++nMiTneYDY4B+fyw62EHwx6JZJsTYJ7LYahu8Th7giqMLWlawtb
	KEyDg1ismRLjjfSwyV9kpbWUuMCNWqU8pmDu6FEjF9VecYAHf2uGjI7MBUb0jkOJ0/5E3n2G5mf
	BJ3WD/goOurnpDG5hqz4Hr4LKMVeQCU1E2PwPAM7Ujt6V8FWUAVdKLSXfitw93qhrjh5HjTOmvr
	sw+9XYvO14+RYjDk1jdkSyonH481ZZ5rDuZD6tbXtIxpQu2w==
X-Gm-Gg: AYBFou1AhF+AsTviOz5LBcWKoo38EUwuUjdeyutOb2kjqoAfLGYMUEQ0wwe5tdKfdQS
	kG2NOuxhIvfdGxT52KmORpwwrRdo//3QGBQpAjEjgUfpVLPA3qqr9E4s0yjlAZpPluKgri4u3N4
	Y+9iwIfF5SNIHHGeqkVoeyiF38asa7fcZ6fLQcNXE4wDAHlsf3ihoFBBF3vayXYuORJdnnqWi2S
	gG51OjLKGyDF8YAy5x6lGJ68ImkuD2LHfYXAE+D0EKswSllbgv7fKs6vPohaEc7JgmFzv0LGzqL
	9JuuT7KrVAARn/6cJ18J7GG8FimVH2NyZW+XH4SJqE3y58YA+OlFuwTeZxI63nNv10g=
X-Received: by 2002:a05:600c:4f88:b0:49c:fa21:e742 with SMTP id 5b1f17b1804b1-49e619ce757mr85771525e9.24.1789209021690;
        Sat, 12 Sep 2026 03:30:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4f88:b0:49c:fa21:e742 with SMTP id 5b1f17b1804b1-49e619ce757mr85771065e9.24.1789209021198;
        Sat, 12 Sep 2026 03:30:21 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71e300f3sm18291545e9.7.2026.09.12.03.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:30:20 -0700 (PDT)
Date: Sat, 12 Sep 2026 06:30:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] virtio_pci_modern: move avq cleanup from reset to
 del_vqs
Message-ID: <21fe35ad7b66e2c30dbdba6fe4df4824d1c0db66.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789204858.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EM97BDr10zNp3q4TgtpfvitQCxtGcgb92nmzsbajNLc_1789209022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

vp_modern_avq_cleanup() detaches unused buffers from the admin
virtqueue. Calling it from vp_reset() is incorrect:
virtqueue_get_buf in the avq interrupt handler can race with
virtqueue_detach_unused_buf in cleanup, and get_buf after
detach is not documented as valid.

The root cause is that detaching buffers does not belong in
reset at all - reset quiesces the device, while cleanup belongs
where the virtqueue is about to be destroyed, from del_vqs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/virtualization/20260911125745.E0A2F1F00899@smtp.kernel.org/
Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: Jiri Pirko <jiri@resnulli.us>
Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v3->v4:
        split patch 3: avq cleanup move is now a separate
        patch from callback sync removal. Callback sync
        removal (previously modern-only in patch 3) merged
        with legacy removal into a single patch.
    
    v2->v3:
        new in v3

 drivers/virtio/virtio_pci_modern.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..b4249afd7f58 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -364,6 +364,12 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	}
 }
 
+static void vp_modern_del_vqs(struct virtio_device *vdev)
+{
+	vp_modern_avq_cleanup(vdev);
+	vp_del_vqs(vdev);
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -558,8 +564,6 @@ static void vp_reset(struct virtio_device *vdev)
 	while (vp_modern_get_status(mdev))
 		msleep(1);
 
-	vp_modern_avq_cleanup(vdev);
-
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -1232,7 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
-	.del_vqs	= vp_del_vqs,
+	.del_vqs	= vp_modern_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_extended_features = vp_get_features,
 	.finalize_features = vp_finalize_features,
@@ -1252,7 +1256,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
-	.del_vqs	= vp_del_vqs,
+	.del_vqs	= vp_modern_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_extended_features = vp_get_features,
 	.finalize_features = vp_finalize_features,
-- 
MST


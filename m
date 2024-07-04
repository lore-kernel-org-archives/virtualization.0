Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AE1A08D1
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075458; cv=none; b=Bgqt5vvt/JPJGYFCPzGwADCl00B0HmEBjd4BxCKwwG1lVeG3noMCrQBphjxR26ECLWqwr4YF23OxIr/oGejQzW/tDL03X/SL6Kfa/NxJLPPO7DRVVHJOzkc2tLpVQ9Uq3aaV2W4bzefAct+O4kShCyq0jPWHNiS0PnZYvfjQebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075458; c=relaxed/simple;
	bh=F0OuKn4rJqtDnc21q6Yrvu0Bv4H3KwyCrJIm8R+N3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMOvgm2Elxl9Rt1RVHwT5WBGdZix54IeHzy5Jx0LXI8A7jT6CzxbqQ6WFX1uIAOpOrkIKBjRE1C4AzDOi1TriQ7AbIZbi3T4J/SndbsTEtyo9PxEOTC+jXV8fTHGlPdQX7zStNIqX1HdTt5qSVuS8ozdaTYNJILfVexEs5H2+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=k6Ug2d1w; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k6Ug2d1w"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9944764fso255018e87.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075455; x=1720680255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P69xOuM8jM+TMtAfL7EW09aj56loRNkHMid0xLl1LY0=;
        b=k6Ug2d1wFOolYnVHmHcFLWkrVQ++Cf5s1qtY0RbemhKfInNgwPs3yhAL20QF3O0PQY
         HDbjMhSRpzydWTPcJJnP955UV5J3dtyQMkIy9MmRYdCtgucCGbUmjWji/fq6yqYAixhQ
         j4WNOc9JFF8Bxe5r8CUWlVKUPgsnFnRV+4wO8FexaYnQ/SNGvYJtg4MHc6dBDnKAlPUp
         iWDY+xhG0m6/rhBMcB8CcNcMdv1bevRoyZgiLYrUumHNx50poVu/Zj27tRB9g9KAT/rZ
         8tWmP+xCurfbW06cjZqgQWeJZyizkJeYTCBD5St5bXcNHuciduQylIMQQKYFbQ3Et1j0
         FAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075455; x=1720680255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P69xOuM8jM+TMtAfL7EW09aj56loRNkHMid0xLl1LY0=;
        b=P6Mjd2f4xB1YD/O02nn9Xjb54udWereJkUEKgl7fpbcIu2JDpEK7FgwxtN4pTf2WWf
         4KTdWLHS/zs2GhH567gbNAmkOS0v/AyXyVi3/Amq/d2jr9Clm51rNa00nxaP7Yeyy8MN
         cScuKRl+j95J4JqNVx0aEVqCQwy9S/EmR1FL705SSF+CUIp2oX+Nblx/9WXFvo1fCrdS
         8mvsbWYqubjWWLTzwvYuNLnxC8W6o+Y17W8ZWArb/jClVjM6L5m3ERzYEs114v/tcLhZ
         Tr/8yKyVuokQitHwcd4XPIIi8eV4CJQ6KFdXfpfExgAx8nr9rETIRqNzk1Qrq6smlxIX
         39Jw==
X-Gm-Message-State: AOJu0Ywddob/QU+s/GwPFwzsoUWhQYtD42Ulnwj3EpWCeIYr8zShJe45
	0L2GlSiM0BEYhrZCsCAlmFBUF6jiak3VKqN0qUhLqIwf8vA96CtvpkDSILibe1el9btbB9tJYD3
	m
X-Google-Smtp-Source: AGHT+IG3Y/h95HVAkY+hQkTTCTh7P4MKgx6jtoypAYs+6a5Nqki0cQrU4Am9R/XPknZJcfwL4pe+FQ==
X-Received: by 2002:a19:a40e:0:b0:52c:d13e:3785 with SMTP id 2adb3069b0e04-52ea063672dmr401152e87.30.1720075454868;
        Wed, 03 Jul 2024 23:44:14 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21d2adsm10964295e9.29.2024.07.03.23.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 10/19] virtio_blk: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:41 +0200
Message-ID: <20240704064350.1097716-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/block/virtio_blk.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..ca3446503e82 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -964,8 +964,7 @@ static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
 	unsigned short i;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
@@ -1002,28 +1001,26 @@ static int init_vq(struct virtio_blk *vblk)
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
-	callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
+	vqs_info = kcalloc(num_vqs, sizeof(*vqs_info), GFP_KERNEL);
 	vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
-	if (!names || !callbacks || !vqs) {
+	if (!vqs_info || !vqs) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
-		callbacks[i] = virtblk_done;
+		vqs_info[i].callback = virtblk_done;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
-		callbacks[i] = NULL;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -1035,8 +1032,7 @@ static int init_vq(struct virtio_blk *vblk)
 
 out:
 	kfree(vqs);
-	kfree(callbacks);
-	kfree(names);
+	kfree(vqs_info);
 	if (err)
 		kfree(vblk->vqs);
 	return err;
-- 
2.45.2


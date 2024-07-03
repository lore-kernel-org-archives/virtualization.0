Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24680177983
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010385; cv=none; b=BBXyJ/HOPsIBYWCJy2Ss9c9Q7cP8xgrDepMoOFF5Ct4gGs/feY5ZPTWG9s1VyIdJCOlQLoyAEAMqJSoJuGyD3uHhiAlb5OCNRGZ4Is6w5zQmN0hGfwfreZE5m4m1883w1pBdTqTPL4GU3a4ry2PsW+2pnkVg+0iypeNyAL5wr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010385; c=relaxed/simple;
	bh=lNFi+/o9g0GsteULQU95UN/9nCvdcopZ07gf0qCioDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DprGeq06Nll+zjiR9wDPUNEtOOEiF2VHNzz+R9FW74w+If4IWjfSrZ0HA6k8AFXW0tcrUNYpxVutwttfFPLZbel6eyAVrh2sFLe2lkzbd9RrVB50lQaMpZl8E1uyIStAIdkgWhrkRK8Ju6r/IssBVAwmksuXGl/ejbBY2m/7TDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EaiUgKFb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EaiUgKFb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so31367795e9.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010382; x=1720615182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K7ZhcfeH3GqEXG/tbw/E4OlcD7lZSYkp+eYR2BwVLU=;
        b=EaiUgKFbkdtBiPfbb48tmwr3G7MSrazXVEye3LJsWGzTHSLjf5Mpbr0SsP4uYPB+Tf
         hMOAFzR1jvpwQoqn6VnCrJFdCQt6JArq/tzPmNcsM1xcB+o+kQCiYVzqtUn5yzFq1Wjv
         tCv5Vb2m6CZmaEOf6Sob7sMhJMOOXMBxhFfgVWzcz22QxKDb22XPJHLhd6hIi9yUGnau
         Aayxt8mkFxT8u9Sru2c1wqV5QJwVnUenlAtr24c0dMH3mEKPbq0Bsr/FW2oh7lEVgjF3
         aCR6dOJwVigMtQLObIJiQIodOjczfR6KJsMSZdndhg3E32iVypq4rP+0JAlEFaonThGp
         aCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010382; x=1720615182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0K7ZhcfeH3GqEXG/tbw/E4OlcD7lZSYkp+eYR2BwVLU=;
        b=tpO+88aKkqjJWk0D1CIJ97fJbV4AmDEXgH8Rpm91BlHkPe+lXJz4Y7rLGg51ptT3kB
         ENBrUIC7AHs/p+lPr7m1kD2eFTi7xUSZ/cPzAVyDRAlyllCqObVC8uSJQ55ug68snINz
         Jvwr6SPxknnrMr0NJ+rhIWFSW5Xe2fw0micAAO0BlxicF26zMl+pXWl0RliR2zMSBghV
         8gXcelNclNL/K5UVv1r2W+Ln0dX+IEB8mW8kzBYxUfspGUekIdMW+TVLeKM56LtucdfR
         7mBXolv5aSskN7zXoqg1HF7o7ZTMY+ea0zy7bnt4ZPp1gyr0w2LgfAiwJPfFhGTXY423
         rtww==
X-Gm-Message-State: AOJu0YzLQGw+fQmz9p11UXm1DUwyuCVuKVfYP6VaY2wrAZo9oq3g6dQp
	pgqHesW7mSS+l9H3fMPXmSnelm0kJCMcVKLnLYtujiwIslZ44sLAKJq+M8Slalw5GnFWt6tOgNB
	Y
X-Google-Smtp-Source: AGHT+IELd7u49UeKFPVuoIICGoMu8/Nti40ebur4B7OrPgzTXydxGom2PZk7wUAXPcqDKX1Xx/IZdA==
X-Received: by 2002:a05:600c:22cb:b0:424:ad83:ffb3 with SMTP id 5b1f17b1804b1-42579ffcd75mr92252165e9.4.1720010382666;
        Wed, 03 Jul 2024 05:39:42 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389efsm239995935e9.7.2024.07.03.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:42 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 08/19] virtio: remove the original find_vqs() op
Date: Wed,  3 Jul 2024 14:39:02 +0200
Message-ID: <20240703123913.969202-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As it is no longer used, remove it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 76bf74a985f6..48edb88a998d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -59,15 +59,6 @@ struct virtio_queue_info {
  *	After this, status and feature negotiation must be done again
  *	Device must not be reset from its vq/config callbacks, or in
  *	parallel with being added/removed.
- * @find_vqs: find virtqueues and instantiate them.
- *	vdev: the virtio_device
- *	nvqs: the number of virtqueues to find
- *	vqs: on success, includes new virtqueues
- *	callbacks: array of callbacks, for each virtqueue
- *		include a NULL entry for vqs that do not need a callback
- *	names: array of virtqueue names (mainly for debugging)
- *		include a NULL entry for vqs unused by driver
- *	Returns 0 on success or error status
  * @find_vqs_info: find virtqueues and instantiate them.
  *	vdev: the virtio_device
  *	nvqs: the number of virtqueues to find
@@ -121,10 +112,6 @@ struct virtio_config_ops {
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc);
 	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
 			     struct virtqueue *vqs[],
 			     struct virtio_queue_info vqs_info[],
@@ -248,10 +235,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 	struct virtio_queue_info *vqs_info;
 	int err, i;
 
-	if (!vdev->config->find_vqs_info)
-		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
-					      names, ctx, desc);
-
 	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
 	if (!vqs_info)
 		return -ENOMEM;
-- 
2.45.2


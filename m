Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D70446B4
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424902; cv=none; b=t+DTH5kPF1E6ZIiO2BCjqpMhnxLAqX8EAPhiK5vGtaHrgU7LOl/gqaIKQfoEBz41FS1cg+DNZgnMKg0c2gsLg8Y4zCtCc51YG5zojvSlUC6u+UdJicJ3h4jfLX5NiR/QJIPDqIhtC3KOHWRNQafFhVVK9Brjfths+2NlgeEw/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424902; c=relaxed/simple;
	bh=7XOPLSoeUCMBrLUDBatTfCcj6RIpLM8/52ujc7LXvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC7a7+ClmWoSnH57Pcn8IkzQ0SxpZ1ThCN2Fqnip7OOJCPyQKRNisjRGuexBIc6vz5L7R1GNM0yi6d3xgUVWvYbWwnQrYpqogSomfZVjKaREGRYQfudlmqxuDZ9PxaprJRHSq+rpWEeiHAEdEU9fakF8nXlkchLSCFDhOk4QNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZgZA3PGC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZgZA3PGC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426640582f4so7127405e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424898; x=1721029698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=ZgZA3PGCesnaBHQo5tPP+1hl2HMA9CoEoVWRn47ozY6SBYbJZUec9Fr7cDgxUYz6pa
         G+QVppbszbA1oIeziph3wpw//ZXQpugFHClC3zkpiPoxUUtvk9i29pYNegv2wD/MRviP
         H2oFpO4G9kJxpShgKU0gSGUCigd126KwyOXcDZCfhJgBcW0Di0p/U6Yo4vTc4t8ZbxkJ
         UEyxFGuT6JXexrlYMngEX2t3uAMOoHS3Ae7AfMzmlf6ApO+wd0K5d32EPooB7TonnM8y
         eCRQGieNWrnujmDQndiG0enWFCtQHcZAQfjGGdMnM3t/11aP5nDq63tCWzf5RMMHKSee
         6LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424898; x=1721029698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=nLq5UdTwr5F1un+21LixJN8D/Ne17PSOdhBo8RWSaUJr8KstGXwRhP54qimcj9hWwX
         k/yM7EkZVY7+f43+el6Vq86adlEXXRQBZDzj04gD8Cc7ZDecn9onXzPy2famyLhkOj5i
         QTaJiZSv1f6L2KlzB+ivO/7OjDrEq1d6k8RU2Ol5usMTbZEg5eiDMQj9rq55SD9yNL0p
         gTa0yfpS2t7ssUpEaLi3Jt8iazSRkupDa8YoXzsA+iWkcfm8bza6cOOiXZLaaD6ACuHM
         71vWhErh3qED3n5DzK3cZn8vkzy6Ps0HeJwumFoB70eDlzRxtx6ogZ9NghiStjyf05rL
         Rhmg==
X-Gm-Message-State: AOJu0YyVyeSRygGOWiT6SD2edTgC8CmzsdJzCrlo9qppMfMgYwquaUv7
	OAn56p4wYWvcC9OusF+9ndRemOUA1PA8KLwnOYMhunTlD2OTe1btfeLTlzQ5DMUqXJUv7SpgQFc
	Qc0I=
X-Google-Smtp-Source: AGHT+IH5aeKDC74ldzdEAqqOmRGH4E95iR0X3ym/bnA/e8Iv6K+8CuD+/IEIq3JkcG88xV88L0FX2w==
X-Received: by 2002:a05:600c:3ba0:b0:426:6004:cc97 with SMTP id 5b1f17b1804b1-4266004cd86mr39552915e9.38.1720424897978;
        Mon, 08 Jul 2024 00:48:17 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25181asm156010055e9.30.2024.07.08.00.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 01/19] caif_virtio: use virtio_find_single_vq() for single virtqueue finding
Date: Mon,  8 Jul 2024 09:47:56 +0200
Message-ID: <20240708074814.1739223-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since caif uses only one queue, convert to virtio_find_single_vq()
helper which is made for this purpose.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/caif/caif_virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 99d984851fef..7fea00c7ca8a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -646,9 +646,7 @@ static inline void debugfs_init(struct cfv_info *cfv)
 /* Setup CAIF for the a virtio device */
 static int cfv_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *vq_cbs = cfv_release_cb;
 	vrh_callback_t *vrh_cbs = cfv_recv;
-	const char *names =  "output";
 	const char *cfv_netdev_name = "cfvrt";
 	struct net_device *netdev;
 	struct cfv_info *cfv;
@@ -675,9 +673,11 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the TX virtio ring. This is a "guest side vring". */
-	err = virtio_find_vqs(vdev, 1, &cfv->vq_tx, &vq_cbs, &names, NULL);
-	if (err)
+	cfv->vq_tx = virtio_find_single_vq(vdev, cfv_release_cb, "output");
+	if (IS_ERR(cfv->vq_tx)) {
+		err = PTR_ERR(cfv->vq_tx);
 		goto err;
+	}
 
 	/* Get the CAIF configuration from virtio config space, if available */
 	if (vdev->config->get) {
-- 
2.45.2


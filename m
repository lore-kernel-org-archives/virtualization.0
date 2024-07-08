Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFE3A1AC
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424914; cv=none; b=rlqi0WjhJ0Z4mfYlXxW3shSHd0CM5ZxUGfIHinDP9jWe9ArRPy4Fa9E43+/Xd/XUihwNDWE86WipmnPW5rPWssz+DR/8oRv42Er2ncyvTEl+4jTOvluy6aBSSCMocdY51d7aTWdzT7EpU2j1yiIalRc0pb32EQBG0BRCg0/APkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424914; c=relaxed/simple;
	bh=OsHOSjbBetalG8WJg5DDuNnP20MALt3FUFZpwboDrp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd8ChbQE0TvDTnnwwiFkD6yB1bTVf5qRoq0IdtZEAJzZ36NSgS6riyvNmFZSgeN2NjW8bwnLC6flKHvu5x8bI8g/k6kOrcNd5BQUZlWj3OaNuzW/PhOHGfjuNf52JGNg2DRIs/xOV/km05E5tRSoSxhCyw9z/4vgQeW6RJxzkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kWP2bAon; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kWP2bAon"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367b6e5ffbfso969109f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424910; x=1721029710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPT5Hgo9SLTsM1shRXhn6Lbcy8HuJsLRl1eK9IiELb4=;
        b=kWP2bAongnIwriLW66XXuRsHzDuGqEaAyystONKF/CYodsoa9Wp4yX+g5LbTyoLycH
         cLTX1TdhtKtLgn7Eh1gx22J9JJ9xebEbYcbWxAIF1bEujFMT8uR72TDuc6DC7CWcv32e
         1XRJlLGN1Z9czg5gwtqpi72SvNROemwUlNvceAxVPHqHIsVNYmGWqRc8UWCQQXHBuO+W
         tpvr6TZE3seD5msVTXCPfTJ4Kl6OQ+wfYxMOk8jkoqrOReESbCHG9qo6JF+JwXJBQOe7
         CH92Um18O968u5J/HDaeh+Fs+beUc0hWTvLouhOXffe0D3uf4F7hKMe3C9g9zgt2riLY
         zXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424910; x=1721029710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPT5Hgo9SLTsM1shRXhn6Lbcy8HuJsLRl1eK9IiELb4=;
        b=VFu62uOXkiTVMS7Y+6NZAILHaXqypoXIR6iNOSKMnivvO2N7gEtbBAGQJkCqYhfeAm
         /L1aDZeHMd6KFVJAOBTZEvHCGjQ+FTYJ2Xla48nSPHOrbFfDVBvs+P4HwPssqPhN0bE8
         KDYnbIEvzYdzeHGoA1rvh+CWB8RTYvlXL4+KiAejs9vNC4Xx4uQ828oYfNF6YwgrFDG+
         3Kz4b6Qjcin2Clkl8UR5FIZhtdvN+vSikoZksG2j9mhD8+jlVHfRenntnFewfncUz4wN
         3ueo04oVszDO198H7gi6OC9JKUOctEpn6AedUpsguhJymZ2JOE0X0+OvE6S6u/cIZu10
         DnFw==
X-Gm-Message-State: AOJu0Yzj1CR/bUgvO6SnwKVA8n4xNbi7YnRx6Muk10yjNcDMTzenu/77
	GlPDzPHZRaun6PrCrcW2K7cxvgIAM8tOi85SU3bgu7S9sPG8hbtZICeK7eFwxI83uGLgH/uqrbd
	qgw4=
X-Google-Smtp-Source: AGHT+IFB6uoflE1LY5iHTIEbSyYDB+ok7urMrxRQEXAzzN/QetvP/imb5lsRHeOwZZ9hRALeGFPRkg==
X-Received: by 2002:adf:ef50:0:b0:367:96ae:5b1d with SMTP id ffacd0b85a97d-3679dd8040amr6743037f8f.69.1720424910591;
        Mon, 08 Jul 2024 00:48:30 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a648dd3sm15026667f8f.89.2024.07.08.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 08/19] virtio: remove the original find_vqs() op
Date: Mon,  8 Jul 2024 09:48:03 +0200
Message-ID: <20240708074814.1739223-9-jiri@resnulli.us>
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

As it is no longer used, remove it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 23ce1aec54e8..1ae346bd2dbd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -63,15 +63,6 @@ struct virtqueue_info {
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
@@ -125,10 +116,6 @@ struct virtio_config_ops {
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc);
 	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
 			     struct virtqueue *vqs[],
 			     struct virtqueue_info vqs_info[],
@@ -252,10 +239,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 	struct virtqueue_info *vqs_info;
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


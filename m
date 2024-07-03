Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36013176AA4
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010406; cv=none; b=P1TFGE1F0H4UdCilbn5hG46XUlEFeXv6YHZgwxRcPu7sZKnEcmLe2ZddWP0Avl9TjH6hC+9eoT/VVKK+jLkwPY1OCSNsPGwJh+vvhYwQRVmBhPz9zp8Jsha9/eefzfKP0RWsMUO9uUotWCBM54ra9oHkc58Po5bcorkn8UGAjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010406; c=relaxed/simple;
	bh=NsKTWHpgkPssL5XNrJuoiUCKJIPT0Lu+kvlXr/j0fkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLei3sVt36dkLzTAvXPVBzKuqajbMiKbbe6iPzuQfN0FB89hsv9f7KzHd804uqDfLlY8VS5zYXOZdIOo2k7lKNAW9ts+teIZoUegc0yHj2UAMFghDZNcbZ7YVkFSwwlr6zWUmLpiNyA0iExXHs2sgmBw43VHsRNLqk3w/b5yKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VMglv8Tk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VMglv8Tk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3636c572257so3823131f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010404; x=1720615204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7G1JBb1vwjvp4pR9h3erjCJeKzl0/fn73w0sQ6zzmE=;
        b=VMglv8TkB817iYAuyjQGq0ucwv1/5D6o6PXr7RTnRStbo5oVNmcEBaEEKCKrQ+bRGa
         6hY0VgXhC0kDN5U244XUx9BQlNG+rVW4trgizcmQyI+/PhiMAcXIEstGoR551Jn2Z4s1
         5hgPBtygIXDp9ujaDvpwtxc8IMRtwdFqGSB0FtSAXMeefX0B9638pNIaaGp7DcXBujle
         WymqvCm/LTOIDNk/eU9ec9cAo79Up+SnmFJp/PNUOMZ3CChSwa4xe/N7VqxKIWddnNuc
         BOfbJQKlN/2bZ8DIAi94pU2weeGUj4DMZTBHePnT/mdK8qjX/3yoH9ZZxdt7ZPk1Es28
         66GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010404; x=1720615204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7G1JBb1vwjvp4pR9h3erjCJeKzl0/fn73w0sQ6zzmE=;
        b=lNHrA0W5LLb5IyvnAIYSbUJ7yJE6mgGPYh2WdmmsxKQMC3Y7+RZGAiv4AaSVjoYcSZ
         yKFjDNvONvoHFKafcrWEsuBJ9jGSaw0GmmBjh08D0STaEP/W8R74y/ytpRlcU2GtegVh
         Eq1VCEbVLD9Dz++WlNYCY0nIpz1/cujDTqGHwOvRxj7SF0im6scnXtagi0WTwCHQw/l+
         7sVPILBEtpmTqt/JYT+rKNV5SlDYfLIr1ECXQmZssyKCzZmhFnKIQnaKCoshqlH8WzT5
         YJqg/ik/RF1uNqhUI1ro6lAGyyZy4e79tnlxLo+kzChXe/F3sM0vgPuHUNXlDBqjLEpc
         7sag==
X-Gm-Message-State: AOJu0YyDF/uru9tJlW96+RntGFrCb3GOli0eTe+8XyG6F20LcH6uJRWR
	orQUDmHqgJkUf63K6IEnZimU4mwZglMAn1iiMz8hnzxa0TKaPX2GpMuY75whpPqk3vtvupclUFJ
	n
X-Google-Smtp-Source: AGHT+IGjCwpx4cP3pDD8+tFVSmqkngbdzCkmLJskm7phV9zkbd9P2t+bv4NpZveG/WgZJbML/YJ2xA==
X-Received: by 2002:a5d:66c2:0:b0:35f:3189:ddd2 with SMTP id ffacd0b85a97d-367756bc4d8mr8549169f8f.35.1720010403772;
        Wed, 03 Jul 2024 05:40:03 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm16024198f8f.0.2024.07.03.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:40:03 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 18/19] virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx() helpers
Date: Wed,  3 Jul 2024 14:39:12 +0200
Message-ID: <20240703123913.969202-19-jiri@resnulli.us>
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

All callers of virtio_find_vqs() and virtio_find_vqs_ctx() were
converted to use virtio_find_vqs_info(). Remove no longer used helpers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 24bbb1805b80..639d68e95580 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -226,38 +226,6 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
 	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
 
-static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc)
-{
-	struct virtio_queue_info *vqs_info;
-	int err, i;
-
-	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
-	if (!vqs_info)
-		return -ENOMEM;
-	for (i = 0; i < nvqs; i++) {
-		vqs_info[i].name = names[i];
-		vqs_info[i].callback = callbacks[i];
-		vqs_info[i].ctx = ctx ? ctx[i] : false;
-	}
-	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
-	kfree(vqs_info);
-	return err;
-}
-
-static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
-			struct irq_affinity *desc)
-{
-	return virtio_find_vqs_ctx(vdev, nvqs, vqs, callbacks,
-				   names, NULL, desc);
-}
-
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
-- 
2.45.2


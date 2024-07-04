Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E381A0AED
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075475; cv=none; b=Z3Gf7pA7qZfCMBptam0IgTfZI+vSG97Y1BUPMIoecy6RnKOG9pATWrlyTyoFNK+8wtuDU3Mpjvh90iyAfhSsWDCxMCAEFLW592oMfoizuSiLgZ8h1F1wR3EpvbITS+E8RBimZI5s8b0LNqUKl6MFFsu81iHOvSFdniSJ9cwYTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075475; c=relaxed/simple;
	bh=U5kmx1VZmoqsRBxX0ACq1hCxNG46jwEdoCZLBxWmvhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzqV7x7AUdhGLoYC5oPDcZlfqKeMwKyjbfJ4NIfEtTdDIEe1cm++2GYfd4Yao/0TfMgz1ZM3xiy3K9aOMCo4LspRNlGwG4lxKQ4EWPSP8OkIFr7j2GO83pyE2EFnaHgVdmBewxLeSivez4UqcYsEq+fRrfKOw9laodPLMCUjfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SvGiBqV+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SvGiBqV+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36794da7c96so193161f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075472; x=1720680272; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rMKQvTbIAidaGdxZH1b/iYryuQvqzEyDpYp/TxCyj8=;
        b=SvGiBqV+oyqegLe8ZAqYfFSANA69SjJCQc+MiVmOoTwwqR+kJPgjrQ4BTaNn0Nps71
         f8KRyGSHUWDAYrPbW1WcbHxQlYJ5vthefZJivZlhHkY0Eq5fdoWk8OdEiKyC89pDRIN2
         LS99mweVQtun3z096of1d3QQM/MAkZv5tCb3domsTray5yFj/Zst2dAzVeWjJWTFHkOD
         DP57G1iGJKFORkGYcofBmTujt5DtjC9cNvm3B8jBNTNwSTQ1qpPNFcNV11ymsEbh7qnT
         tt4trTytk5l/3qIL0lzrUp8MjZSmUNgJMxLlyZCTgsw+qzjFw46hcbHy7H/UCOZZCLpx
         3m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075472; x=1720680272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMKQvTbIAidaGdxZH1b/iYryuQvqzEyDpYp/TxCyj8=;
        b=MW3YMj/LJ89DIw/Wcx7sQYoFWTxbpJ+p0yJQbu8x7vtdhAXMlPai4FhVLwUbv135Ko
         teJXsfjUONdFTAOrxXPBL5bBnbD4sUME6UqUQl041ABYItn1mILqOUC4OPmpGbNB8iFV
         9k37KjgJBlZyETJBb3UdtPJBholJPif/juZ56XRt12BOV3q4rhc96+9QxhuRPSPP4xz6
         Ct5/Jr9wfTl9yy05D40h00qVcacOx9E1+0y/FcRzKHtgxH/DAbtHa522hYb6IgJ52Eln
         7sTv0ZUVi84D61ZJdAObzj3nIkLJCVzqGQCKM8J+yBasB2PM2y5ilkHXa6oq4w3mBoMH
         81QQ==
X-Gm-Message-State: AOJu0YyuJsETb+ruL2RjvzxOPMAVtNJ3k41ObXyo6B9ZkQo+6UeT2eAg
	x1AAlSG2qKy7UkK4Ev/4E5TfBDspkijXSZTulVpw7Nq/2f8eFxUO2a8FY2jbYXidiepztfPgh+o
	A
X-Google-Smtp-Source: AGHT+IFjkdm7vpKXTkcvGYPVLccrVLnsC4N+uwZrhlJ3cvl6mFkkFd31M7P9TI0rCJoWTbXwYcnpbA==
X-Received: by 2002:a5d:4411:0:b0:367:91d8:a1d2 with SMTP id ffacd0b85a97d-3679dd3632amr448392f8f.30.1720075472255;
        Wed, 03 Jul 2024 23:44:32 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc4c9sm17551235f8f.86.2024.07.03.23.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 18/19] virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx() helpers
Date: Thu,  4 Jul 2024 08:43:49 +0200
Message-ID: <20240704064350.1097716-19-jiri@resnulli.us>
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

All callers of virtio_find_vqs() and virtio_find_vqs_ctx() were
converted to use virtio_find_vqs_info(). Remove no longer used helpers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d325af057d1a..939c8dc909a5 100644
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
-	struct virtqueue_info *vqs_info;
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


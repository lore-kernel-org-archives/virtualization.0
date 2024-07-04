Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FD1AC247
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103640; cv=none; b=W5KgMRFMikEOQkRl9swjiED68kugXxUHkKUdI7uRJUMhW0tqYf0raAGyLvBj4UP0ZHe3QBmb05jrHHMVm023dWZ58sHAjSkVsPdfBL3do0UxiZyU5EuVHY4QzBk2VkTGJ+RQwJ6w200XJ/hR2jBVFNtC8DVtcBj1GAqAN/9k8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103640; c=relaxed/simple;
	bh=KDJXh9e3WU0Zv7ucm/SgmNrWud9rFBRTIQcGFItBTIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIzYrSsk3tTJSSt69uRoB1CpWBjjwhnpkTuQQQRxbKI7aMSBBJrZEElwGDIvp2i6ANRMI/Etdux1RTIdhc4dxDvIcX0emPl7sMwHHT8KG7ympKefyL+192AjYEyyi1cQB/6+hLIRB0QdjJiU3RpOHJIMZF8sOJjjq93cyouAW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BsaQspK6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BsaQspK6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so7022661fa.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103637; x=1720708437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaTR1gr+CpvS2YKU1ODSW8IiA5tSN7Dcu2f5+3b0xUA=;
        b=BsaQspK6dvAtCepIdPGUK0ET+jN/uX5Ead1DdRVNtuhkforFscKReGtfSPltj7nUgG
         HTMG7/2BXk6JRGCiapsv35yTldZPoBJs4Yu0owL1z5nY+k2q8g8WAXKSZHCDW8YagLYs
         jXs/OhTzIMxdr0y2iqU0VYrzYYwyrIuts0eIomIw0NQzy9AujiEJ6/c+EdcPDaMgLNly
         7IHkgID2yUaV9bVRLS3NtSIOFX46MMsYx0bCbq8IQo/9h4ddKmFiNYsGw/ZO+m9p9ft7
         1SuESTiH2d0qvAMXDu1OXMv3eIXZSg0uEHZusmSO319GtyC93MmxK2LIRZFAC0n36eZc
         duSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103637; x=1720708437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaTR1gr+CpvS2YKU1ODSW8IiA5tSN7Dcu2f5+3b0xUA=;
        b=V1hSGywBqdEUse6MY3GIbsjYs9kbalGs3VZM0ruWfYPGcQR7o/V+21KoNDvcEB+/Uo
         KhVC9GrSvyYak93IRnmoWTt/miiQ6+8EjATmM1RiPOmyr53lrjREewhKrY2q6ITqgfL3
         xhBuISW2hv3daS8gXVNTIINRKHtQc/RL0YwRCLrZUV7eqhn0dZ7fw4bmrL+WU7gkJ8gS
         jTm7ffLEQKezyXxUZkuAipRUdxK9CemN81Bq4q6uekU4jd/NmgWbORuNPHPpZzY+DOkL
         J5TqDcoJZkAl2q/F/MkNUIEDP9BnElJEs4fc2DfoxD6d4lXaKHe2IWYwIBrXP/dSOB+j
         fQyw==
X-Gm-Message-State: AOJu0YwyWnvxo+3MWj4N00uCQjA4hwHJAeX8VLQEATcC5qmvOg8A/QuS
	Aydhtcfs799sdK0XVPdo8Xv9QNzJyOJWACWoGGjitJ1bkQo3S99nS4lB3kI7DyoddHcjBknBfs0
	0KKw=
X-Google-Smtp-Source: AGHT+IEtN7f9/27nY6DuIMrKpmUa6gMdLUXQm9+pK+6PJltuPoHppJwFdBw4ydBV8PqKwEuGSSuH3A==
X-Received: by 2002:a19:e04f:0:b0:52e:969c:db8a with SMTP id 2adb3069b0e04-52ea06b2d32mr1279947e87.44.1720103637252;
        Thu, 04 Jul 2024 07:33:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm18895157f8f.0.2024.07.04.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:56 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 07/19] virtio: call virtio_find_vqs_info() from virtio_find_single_vq() directly
Date: Thu,  4 Jul 2024 16:32:55 +0200
Message-ID: <20240704143307.1212454-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since there are no more implementations of find_vqs() op, call
virtio_find_vqs_info() from virtio_find_single_vq() directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 include/linux/virtio_config.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index fb7a1fd00ee5..23ce1aec54e8 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -283,10 +283,11 @@ static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
 {
-	vq_callback_t *callbacks[] = { c };
-	const char *names[] = { n };
+	struct virtqueue_info vqs_info[] = {
+		{ n, c },
+	};
 	struct virtqueue *vq;
-	int err = virtio_find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+	int err = virtio_find_vqs_info(vdev, 1, &vq, vqs_info, NULL);
 
 	if (err < 0)
 		return ERR_PTR(err);
-- 
2.45.2


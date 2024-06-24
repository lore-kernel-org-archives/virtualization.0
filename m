Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F71805E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219915; cv=none; b=pfPmAx1f2GjLkjtMDggCm7athl9f4PA73W0KcOFYgIHSFOyCxBw0dXI4Cgba4erxw44M2Y3l4SkOR7xOVd/eVeCAwgBUKE+WZvZLVZ4BBX/L1ExeWlfkp6/2v09xoOBq+YqANqpZ8+HsV1T4mWEGBhf2tRqsvf9EIEZnNCoxjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219915; c=relaxed/simple;
	bh=ttKlQj9e83WHmOr/KgqVCLtLBbQyABlmLbKteimGewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVoZZDojdaroAv8IV9JPYPB1NvbhBGs/OipO3vBBp6X2z79/Cl61UcfWcJEWvDsIQ63Uzw44xSehXQ5BH+X6eT2EOKdb0nJSalTFFQEUZnQvU+hGEn2a6lXEFgOlTOS6NK9+1nxeDa5O/fA0+8/ZK2jDkDYwKlaAAeUVe/hlDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mDxPi0cX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mDxPi0cX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4247f36f689so28390575e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219912; x=1719824712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUAMqaIVwbvGzGoTMKA84LlFhJh0fnpEJTqYoEKMkSY=;
        b=mDxPi0cX717afGupXNDoM1iSv869cLitw5stHXocDM6aTws6RdagLutD2eXiPudUBt
         Qt2ww9KOEUS/9sff79DRy4q5myc+qf6dH35n6OOqXTeq8oWd99Za+5+SaO8ExHDCAwKX
         MQ7JQL7jeSaAl6KLqZM0xi2Ke+T6uMft0rI9RFdKcpb0cyN4JPV6q7RAvspHIOshx8Yd
         IUe0iYXuB6Nl9SFgea5kGdm1vAb5T4ljuo+x91tDH7EehPhMaVwfc1BN9SSgcFppUZXI
         hXOjmbCp2W9hTmG80vSE7Gjxt1pmWcEjNhHNguW0c7OOFuc4sOPaNG7xSbKSXK34d2hX
         vh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219912; x=1719824712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUAMqaIVwbvGzGoTMKA84LlFhJh0fnpEJTqYoEKMkSY=;
        b=aeDfc6uNbVW50pubJOeJ5FVij9mc2ueJsgnBoDR0cEQwsmI6DJ9qxr3ZqLwP/Yg/a1
         sGOpvUHqtpKa1lK3luFpaifRF4g7z1pGmjN/SjF0icF1zha6Gq0tQdY3qHIbRz2EXWYF
         UCYYFLpbXc0Ssaik60Wb1oy42RDRTZKxaqiy0Z9h79TPRekeGW3XQ4R6NxMGrN4fi/il
         PjDSOvWBDweBhCBUbBDgcxyJynfb2LI2yVPpQY19twyg9EkI1p8nWWDZN2ZUlo+3Tcg9
         c8z1s0som07ty/FxXsz71JE3YYc2h96ucJgIJK6ik3pp9xWhCU4svf9ABYbGCGQ0GHKx
         25wA==
X-Gm-Message-State: AOJu0Yy+pQn5GlXanIiJMDSN7SfNzUd33EcqB/mwaoKcuVg21BEzKkIW
	xju4GFsmvAyBCR9axG/RMSVdLFH590m3wVPY4RIbB7C1a091H7k3kn+e8hu0eOqHGZOchXWZ2f4
	2/pk=
X-Google-Smtp-Source: AGHT+IGV8YLbAGk11u3s89SZEqNybZUWbyhU/3JB6fNhdfZtcKKv6+a6l83Vgamsr3AxQsWkER3Unw==
X-Received: by 2002:a05:600c:22d6:b0:424:7876:b6f2 with SMTP id 5b1f17b1804b1-4248b9cfa8emr34830715e9.26.1719219911725;
        Mon, 24 Jun 2024 02:05:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54d9sm170397955e9.28.2024.06.24.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 5/8] virtio_pci_modern: create admin queue of queried size
Date: Mon, 24 Jun 2024 11:04:48 +0200
Message-ID: <20240624090451.2683976-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
on the queried queue size.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index adbaf1ac168e..41aa97e338ac 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -551,8 +551,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
 		return ERR_PTR(-EINVAL);
 
-	num = is_avq ?
-		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev, index);
+	num = vp_modern_get_queue_size(mdev, index);
 	/* Check if queue is either not available or already active. */
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
-- 
2.45.1


Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D839FC6
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424911; cv=none; b=aQ1qTHFUT0qeccjFQ39CCYmHO7o6lVBbld7cyD6plqPeNajdEAF9l2k9L9cSLTaplF+rzs1IbQ7H7onRBaZOa0GeSR06+FHb6fmVcKJpxbwmn5wLkIAylnO3ts0eBaPYErQzmzheA5TYWDxRXQiCT9OW2jvVolhD4jcvLwrb4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424911; c=relaxed/simple;
	bh=KDJXh9e3WU0Zv7ucm/SgmNrWud9rFBRTIQcGFItBTIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcbATstoE/MdXBE9/p2vNwosicELNzcz3wJJR3dz8N4kz3vq8WO1S8dgxAW5l7CdMi4Sht1UpMZzQjyR7Acrd5MmcSeTbXe5yb1EIt1ntHUJ7QORW4bXz4MLnuXAtABaN2z0Fk8AZivCWmDp9R2Q0VPka/0HU6RJ0iPLRUpScbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=it7H5dEm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="it7H5dEm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367a183df54so2136853f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424908; x=1721029708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaTR1gr+CpvS2YKU1ODSW8IiA5tSN7Dcu2f5+3b0xUA=;
        b=it7H5dEmTa/jsOcNXSC+iBXax4upg7d2HCxQsufb4cZQMpfONDjGvVPPtm7fjfhxrp
         Z1oi7LTRt+/rwLdT0ERx6st1WmaQit+B3q2zHdT79S5UBVzidgSMO4kfaGjLcYpvkY26
         VjV25hHZXTKtaqxfa96eZeYExp8KY7UadwNbDdV7GHJUCTS6zu412ORnnRt0Kl4kXNcR
         6C2Yza2Jltiz3MDG5g7hmIW+hlsQqqufea7aSJbqojpSt4WY/Cycpr50s20WbNwwoyb/
         oCfZ+hoMXN2lHl3GLO5olGWdB1SicKmZ5czJyTBKFM/ahUg77iM6XZdildGEIdhd2xP5
         CUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424909; x=1721029709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaTR1gr+CpvS2YKU1ODSW8IiA5tSN7Dcu2f5+3b0xUA=;
        b=gffgeYv4mR7to92bLT001ILoTMDQd5UTqr7Uq75/TJh2iqf+t+n81b64RUranWkyGH
         drrTGb2b4rEVwKkJANhuWUQYMK3/Y4BkhGqSQhbUA7PwEBiMEM2/IZK0W2eRjFCWdjBW
         B6C9b+YWkuA4j/YeRaRRAs/fD8CdqrOOMWhEQHQcEx1vpEVOlHnXsIe972pAzgLi4Ijd
         7rStZudpobnWSsLk7yN7dlpFfw4QEHoW+HBcvMFjQGQ+u5CKkBS4E5GwLvwD77l54z8u
         DqMQ3aVF0rUHvjt5+QDi6WtsfbaHlTV5iA01xswy0efjFcl1jU40STZfk/SbMiyAorjj
         XHeg==
X-Gm-Message-State: AOJu0YxXPNzCgy3RHVIvJ5sml51OGChSHWYH7h7gXx8mcEnu+a0Y1EiW
	0jrbj3SsOO/ELFhj9jQySfn9ZHg5DzCOwEDI8RoYsduUTGuQVHd7/XZghJQWRktMr3eNkYAns21
	D788=
X-Google-Smtp-Source: AGHT+IESw9eKE9Ao9IavHTMKTVkawODvxncIS0AcCHi6tZJsHrmvbDqmInTP5ydlu3jLhBPVRKM5Tw==
X-Received: by 2002:a5d:5906:0:b0:367:96bd:127e with SMTP id ffacd0b85a97d-3679dd66ad4mr7389518f8f.46.1720424908754;
        Mon, 08 Jul 2024 00:48:28 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fe13ef4sm13805777f8f.117.2024.07.08.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 07/19] virtio: call virtio_find_vqs_info() from virtio_find_single_vq() directly
Date: Mon,  8 Jul 2024 09:48:02 +0200
Message-ID: <20240708074814.1739223-8-jiri@resnulli.us>
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


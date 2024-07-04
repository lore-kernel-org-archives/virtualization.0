Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3B1AEFCF
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103701; cv=none; b=npRyG0xOwCGRqRyjOaWl1yDyRlcNobQDM6XXLoxpuEd5b38qi95xnUBGp6sDTmtwrGMUq+z8QZFnwxJzpcP2ZVNQdbazRVskBLHEvtj6E3MpQ/kQQDlUh/6ldopZgL5VWSi8caqfVX+y6XTXLFnfX7kmBRq7UFqs8XQkzeyO10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103701; c=relaxed/simple;
	bh=TYVv5tlIK+hEtgFpV8xIUZUEQ/LE3nXC16vHrbiM9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPneuaUGIE0cHU1RPMANaT2YHPgQcpIW+TrmpnOGnXImTxzPXxP8LkhCV+Ugf2RSmWpK/EZoxoyLDCHtSfKUWdXve7joT44t9oC32L/CI9J42lqizMzOVsaYJGWCQnmRs5fAQE0bx/dH6VX04lD62OhuSFfrPRFJ8A32Ho6KTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zN3wkSo4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zN3wkSo4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36799a67d9cso618035f8f.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103699; x=1720708499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SENFWRXvo+L3/xzPkroVW8rzpC5/DZKXhsaOup3Za/c=;
        b=zN3wkSo41L1vSMrthr0BHYfHbr1XhqxX31wXJKeybwBuFK5lXV/gLyUTZcUqhh9HXf
         QcLRqs/VfCTzr8adijLNgcT8+igw3XiHaIj4cQjfMl+cKOxjjjYTrue+g2zVC/0ZXDqq
         r2O7mnvs3zVfRtNnRmRM+S4Y6nbSOGrNxVCP6JT7x+Aig5czTuUDxtqmAo1C1CJCy+fo
         gMU2dR3o6rkzZKnDlvp3DmbgGMS44I8l4JBtJIuOZcd4Cf66CYovNJd3OFKABm+im55S
         KaFfK+1CiieZw6VnEvyQryH7rD7ABu5EesoF8L+SZvfR1B72kQ2Lr8CFBX5Kktj83qTB
         2tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103699; x=1720708499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SENFWRXvo+L3/xzPkroVW8rzpC5/DZKXhsaOup3Za/c=;
        b=R9h7E0PvvddKLmfxCY/5IdEVa6BOjkiqz19OBRqpcdryMOY25cygConw9evaLts1ZK
         GiDR0uMGNgnBSpxSEsk+G5LZEXl1lUmARXRuw4Uhfw7IPRwV/f7IXYCm7u68R0xpp+xf
         86haTN6reXPECucXcjEMIiufxU5M0jbavKEcCsDG6qDY/PdwzAnmioP4ZKm8dgxliXAr
         EYYE/MKF8a99vAKiMU7UnlWGn5U2zqxKxcZ5V+e65GuVPhCdgpKM2DPfrmVHf1YGWs9m
         cp+J9W88EM9YwxKPfZiK8keFsjlHTUqTb3ZuVqMyi2tmQu8LNIFIo76gSXuuIUOc+NqK
         fB1w==
X-Gm-Message-State: AOJu0Yzre6PWXEmPpw5VsbkHJzf4qk+JlTbR/6e2q+pClgZ7nL/NB6N4
	X6J4XP97gCCaUIOE/B43CEV3HMKXOCNWn/dNQgt5wajS7WVlzt7uhaEDNLzqfY4ywblxId17LWT
	slv0=
X-Google-Smtp-Source: AGHT+IExEy6RTKbVdctusGAMOPhThuEsrtMpF1Zzs6zcOlOQmVmMfrQceVSvhZVcNV5smE0MD58CAw==
X-Received: by 2002:a05:6000:1b86:b0:367:900c:c098 with SMTP id ffacd0b85a97d-3679dd31a6emr1548140f8f.39.1720103698721;
        Thu, 04 Jul 2024 07:34:58 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cf55sm27008925e9.27.2024.07.04.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:58 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 18/19] virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx() helpers
Date: Thu,  4 Jul 2024 16:33:06 +0200
Message-ID: <20240704143307.1212454-19-jiri@resnulli.us>
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

All callers of virtio_find_vqs() and virtio_find_vqs_ctx() were
converted to use virtio_find_vqs_info(). Remove no longer used helpers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7848fba7f48a..b6b615c3e21d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -230,38 +230,6 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
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


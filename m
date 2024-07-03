Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B63178384
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010384; cv=none; b=NR0U2CFe0i5wSiI1Z0WLt5rP55+9Up0STzXkxi/VrEe+pcDpLCMPK0VM7rixJ03S77eO4PiCaQ8kYr+TUirgsnXzbW4ESJhQ+3GuicarXbcjbwafQd6RCAjLWwLHbYl7dJYmHP9Tepmrop7lYkjU9WU/oF8h5UGHJWj0aOfMaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010384; c=relaxed/simple;
	bh=QCYPsM2pIkfz4LiJ1aPkfqR2732bodLUH8AUsxIuHZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCkHBCjOcO2giSOVcisJ/a9INIsf07gKjM9LGCmn8362C7wOPtrwOQIZIqhiS0gOBECYmRbsE/5RXNPoCBvQkc3YoQM/hW/x5WxlNNGN1HSpTupMaMHIzNxswaeZKV0xfwbFq1wvAingpfrsGpoSuPno3aqOAAI7x0hreBBBcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e88WRVRw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e88WRVRw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3676447928bso3106048f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010381; x=1720615181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXLS/JPrtsrwnQj3fxW1Fvfr/XnqNNTYWy1aWRkajPU=;
        b=e88WRVRwiNxAJWatBHa+ZtXFv+BHHquJ9fr7Ze6pSPXbJiefMYbzfzhXsNWhfy0//1
         yabXQVRFSravcA8HMCFzXdIP1ct6GKbv9sgc+eDuNAe6hKhD3eI5XM9sAzP8ayeP6ZRF
         f2vvBcyt4XCRJW0cdbnjB5aD+1VaSHqlhdy+v3HV5+3oMgYXOQAqK2k33YbslC6ZGr2i
         WPpr8W9GGr3FZ3z3QCd43G4vSDbTYe1Ut1KJ4dA8eqBFKbokB/6b1RDrhKujDNxLsdUZ
         1Z6Z8S9aJGymO0YfxtIOUrkH9fJbI0N91mFXbX44Z0W4KKS/CYYR8EzuhAA4g+64ckGK
         m80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010381; x=1720615181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXLS/JPrtsrwnQj3fxW1Fvfr/XnqNNTYWy1aWRkajPU=;
        b=Nzb07Y/raBPGLVWcmVlNK8fiQAuKbkHkd8e/qSwaJX2Sx6BcaQYXico51AqNndFko4
         ALfb9Zqpw+oQoc40+C6+y/JodkBJ8QgGSx2RC3vX/qFCUlCx04RICF+szakXYjyF/6sW
         ilgPKwsfrVed7J7nJLG1QXYP5bi+tPo8ILZxQE2tibhiZ8KwOJ9y2FXHhE9QazipaBcs
         +E/VysXEe7BOVktb6y4BCwTIQf88cfh7FRaC0p1frN1czXD8VeeR1rhZ6nFzE4DMYuq1
         raT3e0NSxIVBzbAY3NNwPva4Jvaip/FTgyIq7oedamImqX6AM2nLog29ufsvYkCmigAR
         QEcw==
X-Gm-Message-State: AOJu0YzpO22JJendQTEeIKJuBH7Drd/trbJwaGWfsOu5GxzBmZhysN69
	8dzUjZaES0GpfZgo0NuQ6s2gS5r8ASvoJQGRziRXxwee3Zc3aV7dlmG00iugYPAs829lSZZZXiI
	q
X-Google-Smtp-Source: AGHT+IH9zqRzd14hBBaWBwMdKgngKS+w1Khg0yTNeZjoLGGzFgTL4KIUqStosQbEsw4eOlR1ZkHQsw==
X-Received: by 2002:a5d:5507:0:b0:35f:2b1d:433 with SMTP id ffacd0b85a97d-367756ae519mr7250864f8f.26.1720010380867;
        Wed, 03 Jul 2024 05:39:40 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd562sm15862125f8f.15.2024.07.03.05.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:40 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 07/19] virtio: call virtio_find_vqs_info() from virtio_find_single_vq() directly
Date: Wed,  3 Jul 2024 14:39:01 +0200
Message-ID: <20240703123913.969202-8-jiri@resnulli.us>
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

Since there are no more implementations of find_vqs() op, call
virtio_find_vqs_info() from virtio_find_single_vq() directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 21029afeede1..76bf74a985f6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -279,10 +279,11 @@ static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
 {
-	vq_callback_t *callbacks[] = { c };
-	const char *names[] = { n };
+	struct virtio_queue_info vqs_info[] = {
+		{ n, c },
+	};
 	struct virtqueue *vq;
-	int err = virtio_find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+	int err = virtio_find_vqs_info(vdev, 1, &vq, vqs_info, NULL);
 
 	if (err < 0)
 		return ERR_PTR(err);
-- 
2.45.2


Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B1A070E
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075441; cv=none; b=hOI6Wu6CEwLvz6kxaxCownLaH2wpJyJ440c77rsLDUVH2UtMXxtO9xGkB09vAu2h2/eLdxqU4IXzwdqyUEvsbqgNPl0DQC/5cVe7kPc5OWfNcKq8GdXGUX/JGLKZzMF/bNsJNFQGAbx9z6XlC2khYziYNwdqXd1EAIqwqaVDkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075441; c=relaxed/simple;
	bh=F1IcreTe4McxAC8/b/Zfr2kSHzGbyrXxRXQZT1N+gnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx/1nq7BhqCsmvQyjnni8RChptNU4FSYxDUXTP1ecaWOlnM8TwqyPSPJE7rMnNtV71cRKALtK/YtH23Ws22WQDWd+sQehk1PxXy2AG6sb/yPZrticFInLTPQFYo2YAZos44tnMJYq/eGhBn2olkoCW1925DRiS/LwLO4/ZPDw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uu/zzafl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uu/zzafl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36799fb93baso234013f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075438; x=1720680238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=uu/zzafl0GnUfwQKIdwH2xWtCxyxXCpdQ9F6DSMiz0V1rc4VSbue1QwuIlJMd0greh
         tPfh4GMWEHMvyuHxDCLcSduteSMOaeACTbbtBupUX/O2FQQPqwQmdgooh8AxNVF4r8TI
         Hhu1rZX3p8RkDuhapiL6oM2xWizC3x363yfnR3m8DoNDm5O6MO99mix1c1qxNQVIYOPV
         7ZRnBYFqK7BGEvXXcPN+SVyRpoV0ok+W0qZ2CcPdSisayHoSHsodjnVx91DXWTpNd+lj
         5jWt09S8712D3v3EW96vAavREZsGBHpdCabMBkjE8sWcBwRIwzvX6KoRjbuUvFS6Dhu1
         /KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075438; x=1720680238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=Y5KvO/eSjD8N5NsF1dG5xF7+3/ROfVFrt3mGEKstwyWRuRozLPJeOfCPLEZFsQawvu
         h9TuJcWtRqrYJpdfVUkNLfcgFxlV1U698ltdm7uefksvQblKxoGKa1v8gvmY5MGeYF3i
         ullfpo1h0CU9DanpbDa4pAMR2xi9WIYhEXcRD604LbXRq9Fzyh6bFMHImxIzwgTPK80X
         TkwLA6CrCHilxjerrcwccNoitHFUyb2I8Fxv8chbR93kHrvibUcaDCzlf2ODRgI9N3N/
         MDl0YNBD3U9E8xXrSX5o3AxfxOgiApB70Ox554SruShHw7UpFlX4DDQB7HBYTLiNKRxB
         uL1Q==
X-Gm-Message-State: AOJu0YzSRCr+EWQR8h+W69ci2tlssUKmblWff5Hd/jQ6XYNDNZqbEE2n
	9bzMYhbtoONlK2khKAEdWE72ZiFrM9lm7fZ5UFS142hJd0eCXTizj+P3U5LD4UI/+0h7trjUJ7E
	O
X-Google-Smtp-Source: AGHT+IF/BGf7XKfA/ovcOLv4Ba2MNCfIGQG2bxXTvZUctlbcERUILQGLFAl4zHwGcchTjOOMSXxIbQ==
X-Received: by 2002:adf:ff83:0:b0:367:4d9d:568b with SMTP id ffacd0b85a97d-3679de96b24mr536419f8f.68.1720075437520;
        Wed, 03 Jul 2024 23:43:57 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9ef3sm17636180f8f.46.2024.07.03.23.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:43:57 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 02/19] virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
Date: Thu,  4 Jul 2024 08:43:33 +0200
Message-ID: <20240704064350.1097716-3-jiri@resnulli.us>
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

In order to prepare for conversion of virtio_find_vqs*() arguments, make
virtio_find_vqs() to call virtio_find_vqs_ctx() instead of op directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..d19eaf6bafbf 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -225,22 +225,23 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 }
 
 static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
+			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
+				      desc);
 }
 
 static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
+			const char * const names[],
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
-				      desc);
+	return virtio_find_vqs_ctx(vdev, nvqs, vqs, callbacks,
+				   names, NULL, desc);
 }
 
 /**
-- 
2.45.2


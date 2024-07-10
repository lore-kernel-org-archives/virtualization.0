Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4C6F30D
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593384; cv=none; b=RkA55b8QKT8bLh4MXC2ZkEjfrZI/MijiSHAsb3RSjvnD1Gc2E7y/XHnGT6IJ8SdKs7+ZaifldF5Lg8cebJE6SSMxueRICHeJKAaSAG4CtCuazwbn5/G7riOUBZ7aaZ7lGHcPEUT5nAhXGTP7txARUTZoFrwwbVTYvAcMDG8y718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593384; c=relaxed/simple;
	bh=LWDlMEL3q2CLkvkRbc3DzDqtIlr5TYSnTN5v6PupEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY8kVSFUb768BcF1mDBOYWu10OcsOPg5xqR/oJobFF6X08fl55wG5Zb3UzPYMfhsTJm1kD960gb5elVdVVZBHPvuw45OhicclRSp4uEq52cCMSBJxHQ410T/DWnjDN/O9TNTH7suVkbWIYTEZ0o9io4cxEbvFwVUnqaf6yW/MGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=v02UrzFu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="v02UrzFu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4267345e746so10287995e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593380; x=1721198180; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZgAFN2J7v1Ck1e8Ny+UEVR7J9wkZJeG+enVi8Hy13Y=;
        b=v02UrzFuydUZkZ+nzdFwmsdqux5zHoa1QJb1O2sHvVhK89iUNkzUkiPNxkPZk8dJGb
         NHuR/MbVvfMfV09rEouqrWX3b593EzMXsRwziGjNGSKqhIeNe6afpaqKG8Q5yr6zXBze
         mjfol4oyIQFvCxcMBC4Opnoh9JoUkhfdDvofx4T7JZ4Q2ZQnIs6hnzV0ekNQ0nrtkBVb
         IFVGU9kx+lSvcHZ+iiNlaiMFcdNOD9Thb6JnYrYI/7hhP6C8O3U33zVJeBizV68BCSO+
         3pG5Q8Q1vZPlRwYENW2ic/IYdx5UPYQ5mfRf+ERHUro1Jd14xoYjH7BygZiBtdORLdm7
         uzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593380; x=1721198180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZgAFN2J7v1Ck1e8Ny+UEVR7J9wkZJeG+enVi8Hy13Y=;
        b=Lrkl9SzcUIcbGzZgv7CY8qIScXg6dQT2+3chwBKf8xR7rCR9eS+fMvl9vErD5BAHQk
         /BMpEMkPgtFq/zLVRK+iSSJNRtyU4iu/AW4Cr7OWNuAI9tSMI/qVqv7OuxI/wrKoDLMH
         jkkXbTAUG9ommPHbgDH1kgFxaGOngRiHpozHaMYd+wUREvrruTauhslgg+K/iD/bk+mF
         RhU1z7Pd8FTacw7F7wkj3tNBk8hD6X2FC7oTbMoQzJiJYs4LO3b3QrhcF99+aCsd1TzF
         swnGfl9Oy5uADIOX774uMAr8BuA9IMHL0aTpYA17yIu4/o+nPHHyjcPnvtBlGj5Hq/Au
         ID1Q==
X-Gm-Message-State: AOJu0YxzWFdz8VFHTCR2B7JegvhJNnY9b+lXPPvnH5hEl7RApDPqnNNz
	IUMLYvYvt6ZOUmuh8XdHw/Gd4vNSdgLtChCgFlxdffwnnpHwWWP/M15++Sqj0kPPPVVeAO13dP5
	e
X-Google-Smtp-Source: AGHT+IG8HqUPtzhvO4QQz2xI/emcX9dP0G6iTAVPNc56HKYHtj7wppMq+SL79Sw/vT//L7uOOR0STg==
X-Received: by 2002:adf:fdc3:0:b0:366:ec2c:8646 with SMTP id ffacd0b85a97d-367cead10b1mr3041183f8f.43.1720593380621;
        Tue, 09 Jul 2024 23:36:20 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde456f5sm4436013f8f.0.2024.07.09.23.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of queried size
Date: Wed, 10 Jul 2024 08:35:58 +0200
Message-ID: <20240710063601.2000149-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710063601.2000149-1-jiri@resnulli.us>
References: <20240710063601.2000149-1-jiri@resnulli.us>
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
index 5ceb4b2c18df..a649c9dc436d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
 		return ERR_PTR(-EINVAL);
 
-	num = is_avq ?
-		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev, index);
+	num = vp_modern_get_queue_size(mdev, index);
 	/* Check if queue is either not available or already active. */
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
-- 
2.45.2


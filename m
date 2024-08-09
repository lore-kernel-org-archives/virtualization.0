Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4E18EFC1
	for <virtualization@lists.linux.dev>; Fri,  9 Aug 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192566; cv=none; b=f1M+9Ftx1PDHv389MmwX71ak+F8bMnrimiOzIZO7Bcco8fWyYPDCGwJ5jtF2x5Svg5YGwqgx6TLwTrvZ48QKdAfCVI3Elnxhq8I1AGjdfKn9kSdAU+8igCopaoouOtYe/m2gMn4/qq8GSpkUTGT0/8UYjo5bI4BFDLGlYeaIp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192566; c=relaxed/simple;
	bh=GKQQtsFL2PgY3xuVgpyzjfrC0VvamH3LJrB71twQ2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QM+ZbAx0tr546QPmsYBiwRWJxDLDSt8QPHlTVTaGPTysN5/p4uf1IuWft0nKxVTAwQgl5Sq5uR5nH/9qntOOStbsArccOF6Pq9XOoKQkTtlp1QwS8oqKPUsZKrwlcC+9rHZObhIBkyFAkQb2xOQ0EFpWU39/5D1QstNALcFQtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1QI2nUs; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1QI2nUs"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1eb76702so1353165b6e.0
        for <virtualization@lists.linux.dev>; Fri, 09 Aug 2024 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723192563; x=1723797363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80oxDpYXT5yDEJcp87RTrO4EEEJMglSs2GHmb0pGD5M=;
        b=X1QI2nUsQSpmZS1K8x9Na+qls5YverLCe/OFz3m3HbwgK31BhKjx+8sK9AKMnKrm9K
         fuj54za3q7uZnUGk+9tjRaoO2V6pcy9u7RUWTXzqEDkxnsELyUZqDdD4k5jW9soKuygj
         ojL/uzedCLDfGT5tlk2wPxUqoEczbKAJ1ZLPfQS3bOtI+NJwb1vpsD2DwBYrrsxGXE4V
         v/VhUSOY1EooKxSDYlTzPgP/F3vC47gowhzXyehtEnxhkl4Dbl+oK4PepiUqhaQ3z/58
         7I8wapt5dFq3uiIlzss7F4YXAhczDqvEc4E6KKBrgAvTfMsP/+HQTTKJfz/GD0XuJ8ti
         SGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192563; x=1723797363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80oxDpYXT5yDEJcp87RTrO4EEEJMglSs2GHmb0pGD5M=;
        b=w1x1/IVIaJMmZv/3PzPYTeB699I4Pb8pRxPgvH98bYFFpLB6xdH/0QxA08ay5wuGzv
         JvUZ/rfKcnAkBaNPa1wFYwjWTbhdfbuBpQgiUEbAa2wWbS+25PterbaNuDFejlVqcmIl
         N7AWNGt1QTn36I6ez4McOqnaBkkfb8gk5jQk60Yi2+J5Z0pSHsRGEiK/4yXWIF+g0jK4
         vL3MeckrlHX9IhkgSmf9LVKixPBlAODwqBIcV/ONmWfREUEhJ/szs+FL6uOViGepAA72
         7sBFFCm2tKNHK7bvD9iMUurwXnqhNbEXeWd7PaV1jNTDE5f3Fg1+cFpCdB33QyFF0MG0
         KNDA==
X-Forwarded-Encrypted: i=1; AJvYcCWynD7Q8mEbsvlG7HZYNum+cAk8AOuUGtkyYA/qKcaNPJWgwaW3PyAvzg0SmMKDrz4Bs/tDjXKjE97bk6u29uAEsqwhUy+gREdwJTUQJ9Q=
X-Gm-Message-State: AOJu0YycZCSUEEnyoi9KivQJqJUZiDXK+BMqhtM2vAfYCvbBMnslOjGK
	KLWqmAFnibb0vC8/jshJS/5FwrLPTlZ8EUyGApznDjIMv5LLaPWgc/3w3zEDJA==
X-Google-Smtp-Source: AGHT+IGAjkW+uKRVgS0A2qZjCMrQlVacvJIMwL58pCLnbX91NVR6ty16gaYboymknPlamERU+ctmYQ==
X-Received: by 2002:a05:6808:4497:b0:3d9:28d0:fcd4 with SMTP id 5614622812f47-3dc4166b455mr748264b6e.5.1723192563482;
        Fri, 09 Aug 2024 01:36:03 -0700 (PDT)
Received: from localhost.localdomain ([117.213.100.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22971fsm2207254b3a.51.2024.08.09.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:36:03 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] virtio: Remove redundant 'virtio:' prefix in error messages
Date: Fri,  9 Aug 2024 14:05:47 +0530
Message-Id: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_err() already prefixes the virtio device name which is enough for users
to know that the error is coming from the virtio driver. Adding one more
'virtio:' prefix is redundant. It results in error logs as below:

virtio_net virtio0: virtio: device uses modern interface but does not have
VIRTIO_F_VERSION_1

So remove the 'virtio:' prefix which is redundant.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio.c            | 3 +--
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..0e06aae8071b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -194,8 +194,7 @@ static int virtio_features_ok(struct virtio_device *dev)
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 	status = dev->config->get_status(dev);
 	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
-		dev_err(&dev->dev, "virtio: device refuses features: %x\n",
-			status);
+		dev_err(&dev->dev, "device refuses features: %x\n", status);
 		return -ENODEV;
 	}
 	return 0;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..e34ed4870af4 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -237,7 +237,7 @@ static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fb
 		return 0;
 
 	dev_err(&vdev->dev,
-		"virtio: common cfg size(%zu) does not match the feature %s\n",
+		"common cfg size(%zu) does not match the feature %s\n",
 		vp_dev->mdev.common_len, fname);
 
 	return -EINVAL;
@@ -274,7 +274,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 	vp_transport_features(vdev, features);
 
 	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "virtio: device uses modern interface "
+		dev_err(&vdev->dev, "device uses modern interface "
 			"but does not have VIRTIO_F_VERSION_1\n");
 		return -EINVAL;
 	}
-- 
2.25.1


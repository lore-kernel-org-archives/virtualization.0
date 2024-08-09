Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0944190067
	for <virtualization@lists.linux.dev>; Fri,  9 Aug 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192568; cv=none; b=fxbKkTZ39a12F9Vv3n+1NGzis5B1CpXx4JiTtEzum77YwE9xdCBdlc7DKG9+xvze/qAhJhHwPiQ5S5hGvV+a7Nnf7yQoKaWOKEjhz9n76lzGfjjlhxxBZkW/SRobjvyWvetdzRw8aSf0UnyS2Yd74HKcrJtmhMXvsJceIUJfZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192568; c=relaxed/simple;
	bh=fxzAAnyjhajstMY7ILsQe6gw/ivTul+Ck8i7HDnuODs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fk23xTPc9gU/TuK1UEWrpzdBFBqpWEcLWkCHHwM7OovU5yoNPthz9QDFYxGtid7KqhVTTX7ar9WcPNALhYmS/pxOezp9lRXv5yI3isYv/B7o7OW63pr3ctPe8CgpMbPkXVxAtFeu4dPRBGN44nITVlGnYN1JZIxb1Cbqt8epYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrfXzutG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrfXzutG"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db35ec5688so1100136b6e.3
        for <virtualization@lists.linux.dev>; Fri, 09 Aug 2024 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723192566; x=1723797366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX0owJGjTUZGW1ZSw8u/h2+6HycvjGlnJbGmlknVqK8=;
        b=VrfXzutGoWfq8su47d2N+73NCoGGVwX1JmDMYPSGOnYHJDlnISqr2Hswm7TnXDWV/c
         +2nbGYkokm0keTr8hIPtrwV7PQZG+vGu/xnxHt5Bdu7T2Gw+EUscge6tflusu/ZfVlLt
         8pP2HmgrCiOkY+TjFIQvxknuh6wp5re1/B1TNwKqX34XZgcyyQ7pD2J1JrOIkoANnZhX
         yr0+nwGfcROfMh4s+FrBsVLFVQ1RwSSuZHQtnBOJsBCwVd2F4y3nJrgCbkkJoaaVa2A4
         ezQPn5g5jUj12O9uGuWo6Jp9SW/4gFIGazrwXS57uCxXMzQTy327rGdA95+RqZUsYrKn
         7G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192566; x=1723797366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YX0owJGjTUZGW1ZSw8u/h2+6HycvjGlnJbGmlknVqK8=;
        b=uq+8w2bL0nsRHmJ+XWgPbQzwCZrwsjNbghZjdzVBFKz3LgtAvR9UxszuMAG1UYI0i0
         5dxAa9F54Fvud+al5JUGzDYD7w1IEyu4xjI923SWEQE9XcZq1t6gMsJpMfVYAuOa9ksh
         VVcHk7JRrC4Do0s3gvTc8B052wDE4kfI7Fr2y/RIgqdoNaPXYl+F2hFK3mWrw6ptTHsJ
         KA3d979DzboM7lnZnad4QHl9Cp6/GvnskZoVWBV39DIpGJcZYHrdJ9R+P+lte2hj2TFj
         KQftGnEJHNyKK61XH2szCwdpEFyoW/PkDUtBPkw3BawhXpzvaCkDgdx2HIhFXKWJr0Xw
         HC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo7+FXcB+nVA4XqmJnh6kYNMlGHMwK4+VfpYdEo180z4RzA0ZDNcxmkL5AET7DgStRRb96ZWsDUGhJR3HXjHzHU6RHVnWOac8/CA16/tk=
X-Gm-Message-State: AOJu0YxrMfoZ1Irv91o5HFqzmi4tdlPrlPgukpAt1GYIk8pLfHE0mI37
	P9boo5v+EBVczOjDLhsTCmrSFaz6rYL6/TN35l4vt7FlntlkVmkle+n/wK4pRg==
X-Google-Smtp-Source: AGHT+IFQVkg6ZtSfIaU+uod33S25nOMqpwS+RsKZODiyjnqKnTlSOE1Vz+YL/yyYCs3UpYV31uiAqQ==
X-Received: by 2002:a05:6808:38c5:b0:3d9:3a00:cc8f with SMTP id 5614622812f47-3dc41676675mr728490b6e.7.1723192566111;
        Fri, 09 Aug 2024 01:36:06 -0700 (PDT)
Received: from localhost.localdomain ([117.213.100.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22971fsm2207254b3a.51.2024.08.09.01.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:36:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] virtio-pci: Do not break the error message for VIRTIO_F_VERSION_1
Date: Fri,  9 Aug 2024 14:05:48 +0530
Message-Id: <20240809083549.14772-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
References: <20240809083549.14772-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Breaking the error message will make it harder to grep for it in the
driver. So let's put the error message in a single line.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e34ed4870af4..1bb55a3167a5 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -274,8 +274,8 @@ static int vp_finalize_features(struct virtio_device *vdev)
 	vp_transport_features(vdev, features);
 
 	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
-		dev_err(&vdev->dev, "device uses modern interface "
-			"but does not have VIRTIO_F_VERSION_1\n");
+		dev_err(&vdev->dev,
+			"device uses modern interface but does not have VIRTIO_F_VERSION_1\n");
 		return -EINVAL;
 	}
 
-- 
2.25.1


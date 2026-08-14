Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB043EFFD6
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692563; cv=none; b=HzwJhLF5+j/EVLABFFKZYF7sFcCFWR4BXVC1Ge32h04N/qzhMZ+pLCS1+i0vgTmcxVA+haf76auA7n6zkKzQYf7uw5uBN3P5GSUH7ERFcNdAWRWjeIxQszIruP0xM5LNJtprfltopTXkR5yb6qsIYZNWOVPwwHtyDs9DOyoMXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692563; c=relaxed/simple;
	bh=A2c/1UfoUVZwjPKT93Tz38x84LdjXaLsxnnPNTXjSOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbLluVH0ekX75elbB+G+OKHLl68GUOlaqC8IHWcmvJjL+HxGiJx37f+gDgmo+1JqrnAC6Z2xds6vLUHDGXOHVUP1sY4lmos/r3K6HcSk104aPo2NwF+8kYtl7UmAhsojFS9FgO93UWgdMVYDgWPgSWGPyxooMfCkpKqdse6KH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0ix6h/y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0ix6h/y"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1343119a12.0
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692557; x=1787297357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=W0ix6h/yN9EkEvUshMKx+V8JCRajPH/JMtM3sXwOdPQamVJrWUSbamSIVNcCwDiFdA
         L/OrDep3rY9rsVs+kKYoI29g1HRlySsg29L6/tEz8xmveG5UDqP1YuOn6b2C57n6G8ZY
         C3vhh71SyGMBoBpDDMco64IMdRTR4caN6Nfd9ofWZciWXcbUTkSr0vqQFGJP9gvhT/jh
         0aFW3hu1SW3V2/SUT4R5PJYsmEZ0tEMdvDIdtm5/jY/wwGDUAXw5fn8bhU/QQhn7uLk6
         FW57nueqQ/JZQi5DJ21rf0ydvgb0mBZ90Ugo57YnwpkTL0j2ikflhPwmJlTQf6HXOwPv
         /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692557; x=1787297357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=juum24fi/sHlz9XDDPbcxMN5hHeWrk6X2VNnccaKYp2WvdpuwIiXsE9zjSz67FrVbH
         sCtMxR0lmYoJyvTkdH75RLUy23ureneuO3958EhqOz3oFdP3bKW8QkkTAgd/RxaAkz61
         jyIg5Hau865imzch+ysYq7A5QOzmFt/PNU7/dJiG49QL7vTsqbkHIpxeEUzMaEqo1HRD
         1obPwIXtl+793wylYpLdaDBBMP8T9yQTNV4hd5Wr0xn7gzu5eFodM2JctCM8G1HSyiEM
         iPRwVd8mLKF0tbC7RYGd9yJI778n1WeDDy4PyI5MX87QY0xWMNE2gwjsipaFzupDuHgm
         gS+g==
X-Forwarded-Encrypted: i=1; AHgh+RobPqfmBv7mzSgatMcSTg+vM7Z23IZHsSHdXQSKp+Hmm7lCArG3rx99ZmIz/rjBkzTqsItspS2X6dlYovrKsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk1E39lvRDiixm48RhzxOi8ufj5oeU9Jz5pDCDJ6s+EWARC9AX
	v9rxyCcJITZ0cictDMGKmOzOu9OI8BVDxipiWVzPQ/sMVzJMf9JUXlRq
X-Gm-Gg: AR+sD132k87IxxyWmfZC2JR87UaH3Cs1UDKWLg9jKOk1Sa36GS0q7lpgU+4nVwa/08B
	qjdTzoyWWftO4+r15A6+0X5razuxMIndDZLplm4uf+3op4h62MuersPl75HZAffVJ9Dm0TCV969
	7SaYiwcXN12z3soqXyKfCfkRHZaX91FlMdWnRcPwO1tCk+czsxj2uWKK2q5vZp01pJXGm/dz1SY
	mzNxQg6lM0jxIjYDO2kIKaua4nZaIfQKA8uKycHfyY9jfUiEwZYJKNYmOopkIdegsHZcNIq9hUR
	VNBzVDspFedE56N6XsPPup88BefWudyxz0QGK+7Buo78TblRXdbTRTSIc8pXeGzPcxBSCpp/kBt
	0sgEKG3FKwhyAOCwQACOB3B/Sy4JnrYBLOW9ukGu91vYaNajM9Uu/0OoUAmUNh5sgb3xiblxjO9
	Bqni8Yvxds+twYv3Rn5M472EOHP/dKxub7mQCW1kJyV17YXSTUCnV7wJWqfEK5+ZfiwNkeNkVRz
	A==
X-Received: by 2002:a17:90b:33c1:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-3933b0d5d31mr2565281a91.17.1786692556330;
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm1460185a91.0.2026.08.14.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Date: Fri, 14 Aug 2026 15:29:01 +0800
Message-Id: <20260814072903.124991-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device IOTLB is shared by vhost backends, but clearing it requires
dropping each virtqueue's IOTLB pointer and metadata cache before the
old table is freed. Add a common helper for this teardown sequence so
backend-specific feature code only needs to decide when the table must
be cleared.

The caller must hold the device mutex. The helper does not update
acked_features; backends continue to update that state in their own
virtqueue loops.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 269efad90369..7eaa61d9ceeb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		__vhost_vq_meta_reset(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
-- 
2.34.1

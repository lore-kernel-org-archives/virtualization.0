Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAB2D77F7
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534797; cv=none; b=C3bqsQd2C4l9JpHB11yvcQEM3KYTYinpkLqp/9fHi6Xn1E0NJ1b0x9iaiGbpGLfLmx7YBAtJGpw2uqtX4p4fLvw6VHcnGkLNzOZDgBjSeCzT/kqgRlJf+hOLe0Q9/RlPlTursJwaX86cMPLG4jUssYypDqF+skivf5EJAfHg5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534797; c=relaxed/simple;
	bh=fM0VFuiMREMNY+584mngGa0LdaJ7mBTcKY8yQT4Zb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DUuPs+JDYmV4QC2OQpJ8+kOY5C/MsgP5wlRelXxT0JI2Gl4oIWVNzjZsyDWczsxc3PIF4mABDNz3GyJkcK1oemhUoVzHP0L5EJe4kJGChaWf/VS3WbwpYiN9SuejzDE+oCBCYu9DA5TtHTAOFfOEwxgyFsXyogPyUhw773YWxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEmw5i1b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEmw5i1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
	b=EEmw5i1bf1yCVadQ7dLkgk/hU6VYwmGYePsG3SL5cx5B/UQR2dsYjVgqClqslMPixLwbJl
	8nK6ZzocJWesWPHQO6/mHWPVbvgH5oSGDdf3MSOoXV3ukqh0H/jHvCU9lEIxIAr8+3ru0d
	mBjcV3ngPIdFGX2SGrJkj9xOifQxMZc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-_mDjs44bOzSeNy04Bu4EQQ-1; Thu, 03 Jul 2025 05:26:34 -0400
X-MC-Unique: _mDjs44bOzSeNy04Bu4EQQ-1
X-Mimecast-MFC-AGG-ID: _mDjs44bOzSeNy04Bu4EQQ_1751534793
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso3591616f8f.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534792; x=1752139592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
        b=e1lfNNvaTgktq54voRffxllEXGq9CjLNJgu+3hzFstFwegdRO3yfamRK7HHZN7oUYT
         /vGG4D7KdRd5m3njB7EAzou9hmwqGjd0XMpQnQ24ojBBDbpmEuYwN38BmQJTrFCbACpa
         wp1G33JxlOBD/Sst/SV0u/ex81RNQnPTsjczTsdt/fz+M6lPz2m0KDf/+fI917OCzZzc
         pnElEb53D5N2W0eMhs91zN6LfalRkGdQNJ/J5rC4jMb5t0cHFoHoxDN8cvlVtphh2kOz
         GZRDDkb7DLcTx03a+0mEv5wcKeMAzmWo5Rs0lAa9SAq0W3lVHuyPNsPohFLbZ9cEytis
         AgqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCg61Wkv9CwFD6KhmTggWCwbOkicvdHH2efQhbb9G12U9K/NVX36rpaxcKlpot1EBcJDCjAp3AVMl0Q/RnYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWOOq93jlbGitD5cD3ZdPC4y2vC5mqGTPMPZiZK1REmFXRsSN0
	Lb+KSIffR1ptEre+zJ+CqERGB92z8m3iRxauUL93O4VQtY2K/hCybcOTBc3gNlTGYqvGj2keAVT
	2y+PVKdYT5IqmBqr9yCkmL/UZGusW9NF7X8qovn3X3I6qtSM5qFUceOoQmhX7+2CcGc/q0TKV82
	Sq
X-Gm-Gg: ASbGnctvdYmdbHCICqplWpLEPZ/LPmNny47TUTh20So1IEN4T/YUu9csfNP2OBWhShm
	1ZP9g/uf1ACi+KBHKyes6pudaY7m1Z+QdjDICxRARCpPwlf05W7VSZu+ZOJ1JAzzNrNnxFiGctx
	4zRdwDRGYUhR7QMCxuT2U9JGvSO1CPJcWu4jG2jfsqR5YaZVDT88q88HaGVmKM1eDl7qKYHiLVN
	WichQ7mRuGnlrrOYxQdOniHk1W8l5qjgoNcxdq1nT+1DWOvpGwXt+iQbEy6Bk0a7QsFeB8Uhd6v
	HELaaHRS3tTgaGHA
X-Received: by 2002:a05:6000:491a:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3b32da93488mr1960764f8f.40.1751534792389;
        Thu, 03 Jul 2025 02:26:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8b1TQBfjA4pFNMI59PREmCgzTYZIOsLlPCQGGaGlAM2M5yrv0rTLLaT3Od8ohCZ61d5wRvQ==
X-Received: by 2002:a05:6000:491a:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3b32da93488mr1960735f8f.40.1751534791959;
        Thu, 03 Jul 2025 02:26:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8fasm18050453f8f.28.2025.07.03.02.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:31 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 2/5] virtio: fix comments, readability
Message-ID: <5cc87ae71e8a61f53e4534bab92f7ad19fc3524a.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v6bRmOWdqd--Upu7didN4meKTwtNUQHj6x3rSEbMDWA_1751534793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix a couple of comments to match reality.
Initialize config_driver_disabled to be consistent with
other fields (note: the structure is already zero initialized,
so this is not a bugfix as such).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..c441c8cc71ef 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
 
 /**
  * virtio_config_driver_disable - disable config change reporting by drivers
- * @dev: the device to reset
+ * @dev: the device to disable
  *
  * This is only allowed to be called by a driver and disabling can't
  * be nested.
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(virtio_config_driver_disable);
 
 /**
  * virtio_config_driver_enable - enable config change reporting by drivers
- * @dev: the device to reset
+ * @dev: the device to enable
  *
  * This is only allowed to be called by a driver and enabling can't
  * be nested.
@@ -530,6 +530,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
+	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
 
-- 
MST


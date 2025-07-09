Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EA23FC41
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094537; cv=none; b=GDQ+5dKKOUjUun8KsC+Q0vvxrlUtYepIB7nvDkN2Sw0IHDj4lsjOs2fItH/dMmKtMTqMoC/qLLKw6zv871QykDDiWLCv1EQuLi/ArC5aKxfCXLaQZeuRX9ejXxIaMPl/zf7dQ3vocIiTYQxJ0JcqsG/KXKLDm9t6E9++U5k+H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094537; c=relaxed/simple;
	bh=fM0VFuiMREMNY+584mngGa0LdaJ7mBTcKY8yQT4Zb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N1R7RBcuCMdua6GzCGNyJVYCco4bJw+QMPyrimR8vz2ipV5rNv0HY3tDPH1oPF7GRhHOpnlJJ8rlOcj3BYZQkGyE0N+BOH8t6DGQwautucHc+i3CnZsvs82SE62BXG8jBpJTeBiJYzPBW/itWP/JKUezm7gSRFmnebAcslOHiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKZZ/7WV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKZZ/7WV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
	b=cKZZ/7WVut/lrD8/7j4TRUR+KCt9nse13+/ROXjv5n25oDTBwUpK9qgY4a1ToP4c4LoDFT
	z6amiwiqfIm1iiwCsUxDoZcOhPn+1TjPh0uijrboiup3wK3bJlIFrObTjJhlbntUQpA+wX
	v3m4rmUxAJf+4eRoanm2SyFfvNAdJCI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-WNYdLICeNb2kloeUT4fCDg-1; Wed, 09 Jul 2025 16:55:33 -0400
X-MC-Unique: WNYdLICeNb2kloeUT4fCDg-1
X-Mimecast-MFC-AGG-ID: WNYdLICeNb2kloeUT4fCDg_1752094532
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5780e8137so748532f8f.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094532; x=1752699332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
        b=lf/GoF8VSW7S2+mIKz92dkjOH5FPNVKubpwg09uO9lkrMAmQLaW2+3p0zuqJR4l0gZ
         /VUUcir0RB6J+7CICaf+BsUcvVdeVfff2lKz8VcIoj2mOPOb/2F7kIbcJFoSMaOjI0eh
         wsFuy47Fji7+JukHTWoijvfJZXo8D6KVWpXFR0Fioc91gLoQqVx0r4RTIOfmM9ontOzY
         nlQYkYmzgInMNguSVmr5D6rPojLuWH+aCFSvD66Q7yjA800yxEGa3f4kauzbJ68bFuPJ
         CDMYPTfzFxfRs+9ZkmKEYK3B48PZ+Dxu0hBJtTyTscjgRKv+ZMUHWqH9Bhy0bHJ1CBKL
         QptQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk99alahux/bqxYw1kzDr7+A/NuroolA84FPoFhXOYjYCmN0qPwR0IgH1ruZ9M2pi4AHfJs2nKartlOmlTIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC4DiREo9FjQwT3nU439TinjkhRx0kMThUDzufF31riLlTaVrk
	1hyW0T7pVfAPPg6O0Ec1NCKKZyIAcLUX8Ra8m4tvdSckwN6zWaTyXW+Oz5hicCMf+BIO08l3fMC
	P88xxsJHLhTxowCgiRdtytGZ4g/k/WJJll3lzcnDh5P55jn4VKpmo4a2blM7i0BQUkjTc
X-Gm-Gg: ASbGncvFeb3NcLRqrXFvG3t6W6P9FIH4HjMPJqsIOpm/m/Ycae0cN6hr18xwOUkZzaN
	Ln/WbluWwVCNld04DlKB46ZP3WB3Plpa23Tk+V4XXIqkCy2RWTgwmvu7fhebI6JIDO9ufNwzMUS
	uo/81yIwnlK2hYdjKsMa9LPEM6WaRaxFHcZ1ia/XbBV2sU3N+cuDaodgnfAe9MItwE9NMMibkg0
	hs/p4e9h+sikJ8RSmGQyM7MRACR+RvDXv71Rz5JoCWxUSGlkKdT3u6eLH6Vya36WUzS9DIWPq+K
	bBVCc9P5RwZYPCQ=
X-Received: by 2002:a05:6000:2c02:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5e7f0fa20mr1068446f8f.1.1752094531880;
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRCPBRiwlO7UWH2UvIq0Agob7X2Ahog6Ap+1+2gzcAlXmS2/uyF9cmiofhMLKAIdBSTyk9A==
X-Received: by 2002:a05:6000:2c02:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5e7f0fa20mr1068418f8f.1.1752094531470;
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966c0sm17407320f8f.52.2025.07.09.13.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 2/5] virtio: fix comments, readability
Message-ID: <7b74a55a5f3dc066d954472f5b68c29022f11b43.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sYcsyfGUfTPc6jjqIUB5zUvme-5ww27Xnvl5JHcoZaM_1752094532
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


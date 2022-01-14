Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96452C4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 20:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D610831CA;
	Fri, 14 Jan 2022 20:09:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tK56bFG_e6uI; Fri, 14 Jan 2022 20:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC2EC831A9;
	Fri, 14 Jan 2022 20:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6471AC0030;
	Fri, 14 Jan 2022 20:09:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 835A8C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A7B94011C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSVh9kE87HWh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F05940118
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642190961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=thU4qAN6AqgkO3iygUwszvm6XkxjVvqIM4JafM153Ro=;
 b=DJtr9zVBPyzVKrZtIPZ7pPYeHyVCk+sUffpWr8saWdQPby/f6q0tSNCDllprErYPxX5Ink
 kviAZzNV/dprrvhJ+/su8G0TACjsgeSmrmfWBExY5NYOZUoHyea7ckY3HcotZIM+2qcV6y
 +9ZODnYdHwowIP5iZiwnICCUy5BRoSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-MRhgPqPhMpOGSyEspNPkkg-1; Fri, 14 Jan 2022 15:09:20 -0500
X-MC-Unique: MRhgPqPhMpOGSyEspNPkkg-1
Received: by mail-wm1-f70.google.com with SMTP id
 b2-20020a7bc242000000b00348639aed88so2794020wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=thU4qAN6AqgkO3iygUwszvm6XkxjVvqIM4JafM153Ro=;
 b=Cfr1Te/QlZdHRI1UWLr5OKDvHUMCwgObAtM4KN2bBLhToEA+SyHvOA6fZSr7SBZSC5
 SfE3v7rZjpoREfChMTsPzbj1tLUW+fMozh8D7BL5gzPopUoh/dXfh6JkfXjykLoSV/nA
 RRK2K6NEvmRMFMK7r8J6sXGqL9DfYHY49E91QOpvXJY5T4Ufg8Xo9mtew69jLk2mPOPX
 +XYPhmOnwSFWo2MLyts4BWZxEWNZrgNs323VvX7cdBcWSBp6+G4FKasvrPCv9i49rIzJ
 zgeNr4WRe1LjPd0dBPnBJ50hvnprRMr+XQuw+RdCqHg9+lH0ebb1VQw3JARXM8nNo2F/
 ejcQ==
X-Gm-Message-State: AOAM532yo4f9sWd0ZmALYtWrz8rWogHsVEQZUQ/663O0wbw7qJKvCqtR
 vXlK1OE7unQy11Nb13nmA9yBVcMZnGyomHLfIYJlc12D3a0owKyL7AZ5X9AAhg3oze8/2xnP5fb
 V8h9daO5FQvy5pYeLJ9SXZxukgM+Jf5AOLEfRu06Q/w==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr9703368wma.17.1642190957898; 
 Fri, 14 Jan 2022 12:09:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEuXU7Zkd1anD16Nt37T1Zc+NsfqyKtrzn9R+BerhveX99jnGTLsev2YBwd+P+dVVUjg2/0A==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr9703360wma.17.1642190957631; 
 Fri, 14 Jan 2022 12:09:17 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id h14sm6071433wrz.31.2022.01.14.12.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 12:09:17 -0800 (PST)
Date: Fri, 14 Jan 2022 15:09:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220114200744.150325-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The feature negotiation was designed in a way that
makes it possible for devices to know which config
fields will be accessed by drivers.

This is broken since commit 404123c2db79 ("virtio: allow drivers to
validate features") with fallout in at least block and net.
We have a partial work-around in commit 2f9a174f918e ("virtio: write
back F_VERSION_1 before validate") which at least lets devices
find out which format should config space have, but this
is a partial fix: guests should not access config space
without acknowledging features since otherwise we'll never
be able to change the config space format.

As a side effect, this also reduces the amount of hypervisor accesses -
we now only acknowledge features once unless we are clearing any
features when validating.

Cc: stable@vger.kernel.org
Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
Cc: "Halil Pasic" <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Halil, I thought hard about our situation with transitional and
today I finally thought of something I am happy with.
Pls let me know what you think. Testing on big endian would
also be much appreciated!

 drivers/virtio/virtio.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index d891b0a354b0..2ed6e2451fd8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -168,12 +168,10 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
 
 static int virtio_finalize_features(struct virtio_device *dev)
 {
-	int ret = dev->config->finalize_features(dev);
 	unsigned status;
+	int ret;
 
 	might_sleep();
-	if (ret)
-		return ret;
 
 	ret = arch_has_restricted_virtio_memory_access();
 	if (ret) {
@@ -244,17 +242,6 @@ static int virtio_dev_probe(struct device *_d)
 		driver_features_legacy = driver_features;
 	}
 
-	/*
-	 * Some devices detect legacy solely via F_VERSION_1. Write
-	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
-	 * these when needed.
-	 */
-	if (drv->validate && !virtio_legacy_is_little_endian()
-			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
-		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
-		dev->config->finalize_features(dev);
-	}
-
 	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
 		dev->features = driver_features & device_features;
 	else
@@ -265,10 +252,22 @@ static int virtio_dev_probe(struct device *_d)
 		if (device_features & (1ULL << i))
 			__virtio_set_bit(dev, i);
 
+	err = dev->config->finalize_features(dev);
+	if (err)
+		goto err;
+
 	if (drv->validate) {
+		u64 features = dev->features;
+
 		err = drv->validate(dev);
 		if (err)
 			goto err;
+
+		if (features != dev->features) {
+			err = dev->config->finalize_features(dev);
+			if (err)
+				goto err;
+		}
 	}
 
 	err = virtio_finalize_features(dev);
@@ -495,6 +494,10 @@ int virtio_device_restore(struct virtio_device *dev)
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
+	ret = dev->config->finalize_features(dev);
+	if (ret)
+		goto err;
+
 	ret = virtio_finalize_features(dev);
 	if (ret)
 		goto err;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

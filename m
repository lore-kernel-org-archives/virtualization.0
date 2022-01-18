Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9FFC433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 17:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26A6C60E49;
	Tue, 18 Jan 2022 17:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMNtg6riEkUt; Tue, 18 Jan 2022 17:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D65160AF4;
	Tue, 18 Jan 2022 17:04:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62AB2C0039;
	Tue, 18 Jan 2022 17:04:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38EC1C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24B8040920
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qjbQpV3aFBwG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47087409AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642525445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gp9KSX6Flr6j6FmwJ5l+iw44DxlO8pNbZWCP2QxAjMw=;
 b=KtztXWBsz+M4pEDkQoSXbZs0Sc5m8hZFInDdgg2c+Ty5rMF4rN2HH56P1yEpOUS3HMgUUU
 E0iJMVo5XN2rQUYKQ+N5rE4X02iakMtMswEuCYuCwQ/KvxYveYtBtjqk93sVNL7C1SwS3l
 mdj/Xfj3g3gTZWXIBRbK+VdJ2vslttg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-GTAS6LW6OHW3lo51JRFfJw-1; Tue, 18 Jan 2022 12:03:58 -0500
X-MC-Unique: GTAS6LW6OHW3lo51JRFfJw-1
Received: by mail-ed1-f70.google.com with SMTP id
 a18-20020aa7d752000000b00403d18712beso551713eds.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gp9KSX6Flr6j6FmwJ5l+iw44DxlO8pNbZWCP2QxAjMw=;
 b=55uzHsszvveTLscX58AXitD2Np4/rASQCmJ0PO6jnuKkc/CpPvPaD9I5rpvlmlAQ9X
 HFdM+smFvgpQcNuIpO+VD2PM2lw+z1yh6OZaxpN6VyAONCMCfnDiZCrO+bxuthgg+Jx3
 xY0SuqfnwHGssTqvu0BB/x6/C36ZaiPujIfEv95d+F9L2IHLbu9jllXaXLrMzVafSeZG
 Xxpw29o2BYHYzmJEiiWMBq1YuAzTIynOjdCm0YMhqkQbJAEgk+quGPpWIFTbxacQvSfg
 GRX/eQa6WFxyRgT8vw3iN5K5NxDCaklmaKffZ4+4Z25exEiI6tcn/7CWwnvKxldGnDNd
 9L5Q==
X-Gm-Message-State: AOAM531sfBt2y/RjIz7+E+n64YUW9FjJTsQKMPznAEMeHGHlFGkTeFRN
 2aejgngLFogwShrs2R5opOR5fGohwEeKogoEHdG2oZDomdtYemVmW2ftNvsiW0xQkcVVDoPyD3E
 OEgxPvmuuRJAnSBhy2d6W8guKmGGEVy52jW7a4r1nKA==
X-Received: by 2002:a05:6402:51c6:: with SMTP id
 r6mr26442195edd.129.1642525436684; 
 Tue, 18 Jan 2022 09:03:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfgfOmVJ8BK0HjVcw/Hr9YnRhWaJmgMtpY0BioTVBV93Ej3a8ugF3NkU9nC+CEupjnMcNFjg==
X-Received: by 2002:a05:6402:51c6:: with SMTP id
 r6mr26442170edd.129.1642525436411; 
 Tue, 18 Jan 2022 09:03:56 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id d8sm117917edz.62.2022.01.18.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 09:03:55 -0800 (PST)
Date: Tue, 18 Jan 2022 12:03:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] virtio: acknowledge all features before access
Message-ID: <20220118170225.30620-2-mst@redhat.com>
References: <20220118170225.30620-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220118170225.30620-1-mst@redhat.com>
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
validate features") with fallout in at least block and net.  We have a
partial work-around in commit 2f9a174f918e ("virtio: write back
F_VERSION_1 before validate") which at least lets devices find out which
format should config space have, but this is a partial fix: guests
should not access config space without acknowledging features since
otherwise we'll never be able to change the config space format.

To fix, split finalize_features from virtio_finalize_features and
call finalize_features with all feature bits before validation,
and then - if validation changed any bits - once again after.

Since virtio_finalize_features no longer writes out features
rename it to virtio_features_ok - since that is what it does:
checks that features are ok with the device.

As a side effect, this also reduces the amount of hypervisor accesses -
we now only acknowledge features once unless we are clearing any
features when validating (which is uncommon).

Cc: stable@vger.kernel.org
Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
Cc: "Halil Pasic" <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

fixup! virtio: acknowledge all features before access
---
 drivers/virtio/virtio.c       | 39 ++++++++++++++++++++---------------
 include/linux/virtio_config.h |  3 ++-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index d891b0a354b0..d6396be0ea83 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,14 +166,13 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-static int virtio_finalize_features(struct virtio_device *dev)
+/* Do some validation, then set FEATURES_OK */
+static int virtio_features_ok(struct virtio_device *dev)
 {
-	int ret = dev->config->finalize_features(dev);
 	unsigned status;
+	int ret;
 
 	might_sleep();
-	if (ret)
-		return ret;
 
 	ret = arch_has_restricted_virtio_memory_access();
 	if (ret) {
@@ -244,17 +243,6 @@ static int virtio_dev_probe(struct device *_d)
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
@@ -265,13 +253,26 @@ static int virtio_dev_probe(struct device *_d)
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
+		/* Did validation change any features? Then write them again. */
+		if (features != dev->features) {
+			err = dev->config->finalize_features(dev);
+			if (err)
+				goto err;
+		}
 	}
 
-	err = virtio_finalize_features(dev);
+	err = virtio_features_ok(dev);
 	if (err)
 		goto err;
 
@@ -495,7 +496,11 @@ int virtio_device_restore(struct virtio_device *dev)
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
-	ret = virtio_finalize_features(dev);
+	ret = dev->config->finalize_features(dev);
+	if (ret)
+		goto err;
+
+	ret = virtio_features_ok(dev);
 	if (ret)
 		goto err;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..dafdc7f48c01 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -64,8 +64,9 @@ struct virtio_shm_region {
  *	Returns the first 64 feature bits (all we currently need).
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
- *	This gives the final feature bits for the device: it can change
+ *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
+ * Note: despite the name this can be called any number of times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
  *	vdev: the virtio_device
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

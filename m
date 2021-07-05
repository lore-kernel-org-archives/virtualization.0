Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21193C07E9E
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:23:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6061968
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6061968
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A0E183AA1;
	Mon,  5 Jul 2021 18:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCNAzQ38NPWD; Mon,  5 Jul 2021 18:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EAB8783576;
	Mon,  5 Jul 2021 18:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C873BC0010;
	Mon,  5 Jul 2021 18:23:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7EA7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A2D6607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xuv4qa0MJhpt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:23:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91ED7605B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625509422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCWQjAFUA2BpSsozjj9zvvBC2+nor9udd0yMEx7PyTM=;
 b=BVu46fB++aju2c9VQIauRaHY7Ejjw5dpg+VTxvd2OPj9TLuSTvZEqoV07/IKh+CaoTYENF
 SQrwrHTAu4rcCFtob15FPXPybrjzpTGXP7My2sivmu3jCSlROwwWPPqWAIh2Adx0rPgLQH
 Oc/scEj6BuHxqFS79EO5uhdjh0N2kCY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-DJc5IZmvPGW5963KWRZD5w-1; Mon, 05 Jul 2021 14:23:40 -0400
X-MC-Unique: DJc5IZmvPGW5963KWRZD5w-1
Received: by mail-ed1-f72.google.com with SMTP id
 df18-20020a05640230b2b0290397ebdc6c03so5365202edb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 11:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZCWQjAFUA2BpSsozjj9zvvBC2+nor9udd0yMEx7PyTM=;
 b=AYSK2u4kj0IaKliF9lsxX68vbKMxVjPLNKV9cf6kEmLaAAwdtzfdq+y6MXsTbZhWFN
 Hxrj+808LoQQBbh94g7HFJOWBZm8VC/GIsqljJSzXHMnql/mAFkPKuK8zXLa4NgRq2Lq
 /gJiSSDEP1dhFOlH9SI8AU2jsWCdHampvLcH6+cF8bMhtatbiE8pWVLbAm8WXky37joG
 zq1KoLd5P1TLbl3AWDriKlFBcSlV3/Siv7oxoF4wwjJ6vNUehN5OS+CNpwc/DgIbCgG2
 Mv1UX1n9qtwbGWaryEPw8VSZko1JkCoNafvfugmnhuLd/nCBy9QgUIFHwW7yDONIZfLE
 hU6Q==
X-Gm-Message-State: AOAM5326RMNCwj/6mh1DCX/M+SedcSCmDBcU3uTJGI7uB6Kw7ciCeHSU
 sOMG+syB3ELD6jfU9rsXcBv4WkTVVAyZCb1WlnsBAKCA2PE+hTM+S3NLYb93krLpLteys1krSUn
 iQ8k4YqI8hSuYhiivSX+v9UZhxQVxWIrWk9NRe1uoow==
X-Received: by 2002:a17:906:2da1:: with SMTP id
 g1mr14311596eji.47.1625509419373; 
 Mon, 05 Jul 2021 11:23:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQS4wuLCqaKViLE93+pqaz97jm1sQ2e86PaWYpUSAAiXhdUO+usQj5ixIO1UPy4slH/t7QDA==
X-Received: by 2002:a17:906:2da1:: with SMTP id
 g1mr14311583eji.47.1625509419191; 
 Mon, 05 Jul 2021 11:23:39 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id z10sm5701020edc.28.2021.07.05.11.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 11:23:38 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:23:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210705141023-mutt-send-email-mst@kernel.org>
References: <20210617051004.146-1-xieyongji@bytedance.com>
 <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Tue, Jun 22, 2021 at 11:11:06AM +0100, Stefan Hajnoczi wrote:
> On Thu, Jun 17, 2021 at 01:10:04PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index b9fa3ef5b57c..bbdae989f1ea 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +	u32 blk_size;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +		return 0;
> > +
> > +	blk_size = virtio_cread32(vdev,
> > +			offsetof(struct virtio_blk_config, blk_size));
> > +
> > +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +	return 0;
> > +}
> 
> I saw Michael asked for .validate() in v2. I would prefer to keep
> everything in virtblk_probe() instead of adding .validate() because:
> 
> - There is a race condition that an untrusted device can exploit since
>   virtblk_probe() fetches the value again.
> 
> - It's more complex now that .validate() takes a first shot at blk_size
>   and then virtblk_probe() deals with it again later on.

This is a valid concern.
But, silently ignoring what hypervisor told us to do is also ungood.
Let's save it somewhere then.
And there are more examples like this, e.g. the virtio net mtu.

So if we worry about this stuff, let's do something along the lines of

(note: incomplete, won't build: you need to update all drivers).
----


virtio: allow passing config data from validate callback

To avoid time of check to time of use races on config changes,
pass config data from validate callback to probe.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..d3657a0127d7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -211,6 +211,7 @@ static int virtio_dev_probe(struct device *_d)
 	u64 device_features;
 	u64 driver_features;
 	u64 driver_features_legacy;
+	void *config = NULL;
 
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
@@ -249,18 +250,20 @@ static int virtio_dev_probe(struct device *_d)
 			__virtio_set_bit(dev, i);
 
 	if (drv->validate) {
-		err = drv->validate(dev);
-		if (err)
+		config = drv->validate(dev);
+		if (IS_ERR(config)) {
+			err = PTR_ERR(config);
 			goto err;
+		}
 	}
 
 	err = virtio_finalize_features(dev);
 	if (err)
 		goto err;
 
-	err = drv->probe(dev);
+	err = drv->probe(dev, config);
 	if (err)
-		goto err;
+		goto probe;
 
 	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
@@ -269,9 +272,12 @@ static int virtio_dev_probe(struct device *_d)
 	if (drv->scan)
 		drv->scan(dev);
 
+	kfree(config);
 	virtio_config_enable(dev);
 
 	return 0;
+probe:
+	kfree(config);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..90750567c0cc 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,8 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @validate: the function to validate feature bits and config.
+ * 		 Returns a valid config or NULL to be passed to probe or ERR_PTR(-errno).
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
@@ -167,8 +169,8 @@ struct virtio_driver {
 	unsigned int feature_table_size;
 	const unsigned int *feature_table_legacy;
 	unsigned int feature_table_size_legacy;
-	int (*validate)(struct virtio_device *dev);
-	int (*probe)(struct virtio_device *dev);
+	void *(*validate)(struct virtio_device *dev);
+	int (*probe)(struct virtio_device *dev, void *config);
 	void (*scan)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
 	void (*config_changed)(struct virtio_device *dev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

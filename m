Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C959EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65FBE40B3E;
	Wed, 30 Mar 2022 06:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_wMJpv4dE7r; Wed, 30 Mar 2022 06:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C13A40C9D;
	Wed, 30 Mar 2022 06:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA28DC002C;
	Wed, 30 Mar 2022 06:23:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA61C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7A0E60A4F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hm1UDScMjadR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCF8A60807
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648621415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5XfMGd9jclB7Y89wnX07DRxpXe9qfoOyLMTpktP1Go=;
 b=ReoDSuD1JX3K85iQausv8SlP7zN9WJchw/n5LJzp2r9rIPbfWcvma28qrqbsCELhjl+IWV
 D+DQg4O2iYjjL68aktbXMBx4Q1FR6rURmyh7E8LF4Svtgc8jeYxSWBb+GmnBPxvW2bEIaQ
 68XGVbW7nwqeD1OVUqzTlkhpygD5WvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-M0T-FBv4P1uOdBsWqOxKRA-1; Wed, 30 Mar 2022 02:23:34 -0400
X-MC-Unique: M0T-FBv4P1uOdBsWqOxKRA-1
Received: by mail-wr1-f71.google.com with SMTP id
 e10-20020adf9bca000000b002059b6ffa18so4226061wrc.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N5XfMGd9jclB7Y89wnX07DRxpXe9qfoOyLMTpktP1Go=;
 b=38U1B9RaNLH7MT6cqnydgq1El0A9XoBfPML6ZGE31UZ5B8+eoIhDJ/AEjUCKWlBofi
 lFSb/a2GheI2dDKnyDoda+FK92UeEw6wx7D0MEjx2+96TmDTT0reOY5utCFkyqKFj8Oq
 tX8VlEeyN8yL9txK1feijZWfIPXcGDpZiAllxBwVafb2nQXNEY5/GQ2tbn1vOUmFKV5U
 G/eLdX/zZI1XEOrwUD8EhkjuZw0PSkd3mw9gcafyUrNNDHaffaYvOsXUaGH/3v1fbgaf
 WvAefX9mnCJrwHbfKGO9FBceDP7z2qNFg0KhnmT1/Y+qrV177RWCFyrJyQqYwH+rjs3l
 wa4w==
X-Gm-Message-State: AOAM5332AbSdPn4qKTRwFnLQjSxgJg38gi21dtbxa5HXD+qnn9yBSrCg
 x3naJJsqUcp6/1/JJACDFrqJX9sbWhEoJlikdLmVJIR743xvJd0MPX31zLeLTqDtfsX0Lu9bU/7
 7QyGki05BtCzsGnViznT+1L8qTe9XIMBh6AlxNUCXuA==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id
 u14-20020a056000038e00b00204101ab2bfmr35760758wrf.308.1648621413065; 
 Tue, 29 Mar 2022 23:23:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISs0u26955cnW/k6f0wGfHnfWVmb1Bxl8fBIKYFV5DYAcUY7i7AIUsaUgjsvbX0suwvm3DA==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id
 u14-20020a056000038e00b00204101ab2bfmr35760748wrf.308.1648621412840; 
 Tue, 29 Mar 2022 23:23:32 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 k5-20020a5d66c5000000b00203fd25f4ecsm15756665wrw.16.2022.03.29.23.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 23:23:32 -0700 (PDT)
Date: Wed, 30 Mar 2022 02:23:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "virtio_config: introduce a new .enable_cbs method"
Message-ID: <20220330062315.125924-2-mst@redhat.com>
References: <20220330062315.125924-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220330062315.125924-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

This reverts commit d50497eb4e554e1f0351e1836ee7241c059592e6.

The new callback ended up not being used, and it's asymmetrical:
just enable, no disable.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index dafdc7f48c01..b341dd62aa4d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -23,8 +23,6 @@ struct virtio_shm_region {
  *       any of @get/@set, @get_status/@set_status, or @get_features/
  *       @finalize_features are NOT safe to be called from an atomic
  *       context.
- * @enable_cbs: enable the callbacks
- *      vdev: the virtio_device
  * @get: read the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
@@ -78,7 +76,6 @@ struct virtio_shm_region {
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
-	void (*enable_cbs)(struct virtio_device *vdev);
 	void (*get)(struct virtio_device *vdev, unsigned offset,
 		    void *buf, unsigned len);
 	void (*set)(struct virtio_device *vdev, unsigned offset,
@@ -233,9 +230,6 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
-	if (dev->config->enable_cbs)
-                  dev->config->enable_cbs(dev);
-
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

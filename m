Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F932C25B0F
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 05:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21E3160E72;
	Tue, 16 Aug 2022 05:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21E3160E72
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPmzOSGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gAvMzpFRzZuV; Tue, 16 Aug 2022 05:36:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADB5D60E64;
	Tue, 16 Aug 2022 05:36:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADB5D60E64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D61CCC007E;
	Tue, 16 Aug 2022 05:36:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C936EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D33F405D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D33F405D9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPmzOSGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wsc1CcMp6eYs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7ABD405D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7ABD405D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660628213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gwPm9xDUr2cS5ofMDcan9qf7hv2F2NrtQxh7A5E41E=;
 b=RPmzOSGqE+Nw83sWBNTmUzL5cRwXWU1DUOm7yBXQitNG0umFhjvsbgVK5PrJwAQs6U6djO
 bq4YyoP5tA/vopGZ1jQVUK7e8L9Y+Ie9yWTD8oanNI/RtrXRqW4u7G9vljk1bxXkQqPlMD
 Zseu+Qc1xebOTljZ7z6L99mQ2vejnDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-_6GeutLBNJ6SRPKAAKiHSQ-1; Tue, 16 Aug 2022 01:36:46 -0400
X-MC-Unique: _6GeutLBNJ6SRPKAAKiHSQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 j22-20020a05600c485600b003a5e4420552so4305071wmo.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=7gwPm9xDUr2cS5ofMDcan9qf7hv2F2NrtQxh7A5E41E=;
 b=53R1c/GNA73HYqHt2WN0zgULMGlII8hq9fx4ADtUg86JPhzSid9WgtNL43q+gFczz8
 Y6hHA8VkY255l+6uIgDloWAGQNsPMUEg+91cXXQfxPjoyvUQ07+ypN6wk7pX2Cv25tzT
 pecURsRZuLWUMO9Xen3XksDHGjWkrllfpMDea15Q0sPWHTPiDkFuawsyJgfhg+y8eXNO
 2IQkYPtG4/ok7R5i9sToMOyc6xc+TaE2oUJNkE0M0RfgAeZTSE1/oDfT/gVxEF+7PvAH
 iBCXDkdhVVYAIPPX4vBMJvQEmfHv5wo2ir+7cczHYhPs3yg07GVRzff48e+GuddexsDZ
 NjEg==
X-Gm-Message-State: ACgBeo3y84kqLnOMNaYIxNb+fmg5ijWkFEZwL1O6UsQo90l5VyX7sXjS
 oaSMaVFHMg6Ps8quoOxd+5Qy7acBaNEuQ82ajpvACjAQ/OqBzka1RftZYYiwfDe5mZsPmPBCCr0
 pxPpkX/EB4vfanAHP/TLOhkjGMtukFpX4IeV1BnOIQw==
X-Received: by 2002:a05:600c:3492:b0:3a5:e1a0:24c9 with SMTP id
 a18-20020a05600c349200b003a5e1a024c9mr7684220wmq.177.1660628205029; 
 Mon, 15 Aug 2022 22:36:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7cl47H6aW+psCSXTD8lf2D+3OkxsNSPvJV6zikekDWgdM77/QiAz5BzR9Prm3rV3l9dztplA==
X-Received: by 2002:a05:600c:3492:b0:3a5:e1a0:24c9 with SMTP id
 a18-20020a05600c349200b003a5e1a024c9mr7684208wmq.177.1660628204830; 
 Mon, 15 Aug 2022 22:36:44 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 q65-20020a1c4344000000b003a327b98c0asm11713634wma.22.2022.08.15.22.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:36:44 -0700 (PDT)
Date: Tue, 16 Aug 2022 01:36:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] virtio: Revert "virtio_vdpa: support the arg sizes of
 find_vqs()"
Message-ID: <20220816053602.173815-6-mst@redhat.com>
References: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220816053602.173815-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Bo Liu <liubo03@inspur.com>,
 Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

This reverts commit 99e8927d8a4da8eb8a8a5904dc13a3156be8e7c0:
proposed API isn't supported on all transports but no
effort was made to address this.

It might not be hard to fix if we want to: maybe just rename size to
size_hint and make sure legacy transports ignore the hint.

But it's not sure what the benefit is in any case, so let's drop it.

Fixes: 99e8927d8a4d ("virtio_vdpa: support the arg sizes of find_vqs()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9bc4d110b800..832d2c5b1b19 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -131,7 +131,7 @@ static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 static struct virtqueue *
 virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		     void (*callback)(struct virtqueue *vq),
-		     const char *name, u32 size, bool ctx)
+		     const char *name, bool ctx)
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
@@ -168,17 +168,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		goto error_new_virtqueue;
 	}
 
-	if (!size || size > max_num)
-		size = max_num;
-
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (size == min_num) ? false : true;
+	may_reduce_num = (max_num == min_num) ? false : true;
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, size, align, vdev,
+	vq = vring_create_virtqueue(index, max_num, align, vdev,
 				    true, may_reduce_num, ctx,
 				    virtio_vdpa_notify, callback, name);
 	if (!vq) {
@@ -288,9 +285,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, callbacks[i],
-						  names[i], sizes ? sizes[i] : 0,
-						  ctx ? ctx[i] : false);
+		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
+					      callbacks[i], names[i], ctx ?
+					      ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

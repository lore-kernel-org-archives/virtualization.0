Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1D5C76196
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F6FF60B9C;
	Fri, 24 Mar 2023 15:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F6FF60B9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUboR778
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXbUUma7KMy9; Fri, 24 Mar 2023 15:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95A1D60BD5;
	Fri, 24 Mar 2023 15:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95A1D60BD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D057C0035;
	Fri, 24 Mar 2023 15:36:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89BCDC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54DAC8420B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54DAC8420B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUboR778
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l17fendDjMHU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8215784235
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8215784235
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MlJ8boSBAN33TyWlK9MdNtuYbz66i2Pl/D7dBKo3iE=;
 b=cUboR778KpKd1GmvNtCHbLGJpDevVFxJ3Ly+6aC1tYwc/ia9GiBPZ8J8JJkWj469kCd5QH
 L3z8MYU9oSZD3jLRxIqz5L2pm2qaK0Gds1dCGHE8flP140/InX358G0KfTMwVWMRLj3oVV
 t9ZJKzetnYRNIhtCXBQw8PoLPlZieCA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-T1SGTzUFPiiJELpDSWu6jQ-1; Fri, 24 Mar 2023 11:36:23 -0400
X-MC-Unique: T1SGTzUFPiiJELpDSWu6jQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i42-20020a0564020f2a00b004fd23c238beso3825412eda.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MlJ8boSBAN33TyWlK9MdNtuYbz66i2Pl/D7dBKo3iE=;
 b=09f6L8vhUvtXVeOzkRTJTLtUT3wAywpgqvBYAI6suBHtQ9AxhK56zKZq3uL9vb3LW1
 QMuVZqTdL0OwiYhfOlYDpx7AqyccZrRUb5b6bCQw1b0vB3rhuKnpyGF0+DWnK+prryPW
 soQpD0AMnChM9dqH1WKPP048xCoiH7UCsXERqkfy5x9czQ9zDnJ3v18m8qKsS9+sevps
 Uc+uhfaGOZ81W6LYFit1W4ypiQRVyMy9GC3uXnpBaMVR/iKlAQ4uK4ypzDnQjI5tbk+g
 qczZ+oexanxF1OhykwJaFbtBUHGG9regV3AMDYkNEF4yOYnLbiToLs8faRWKR5PewySQ
 Q3+Q==
X-Gm-Message-State: AAQBX9edYuiStCxOfDt/QAUQw4DQmPsh8vYhL0yWkU1fXNUyO0INkUP4
 oa+X96LKUaO4rtfKkFKISlhE3gmi/5kaIGMClN+OnorXYkTOK6Wu1keM4+4sWeFpbCxZ9U23PvA
 /DzFw07XEMf1zuuXCSfO4wUSSK/K5ew3YH1yRD41VppyXcGr6XL6eWrRYInkwjbbpuNrx5dHXWD
 avsObC2BIOymFMwFIDePurfhz8pg==
X-Received: by 2002:aa7:c790:0:b0:4fc:d837:2c44 with SMTP id
 n16-20020aa7c790000000b004fcd8372c44mr3252028eds.35.1679672181910; 
 Fri, 24 Mar 2023 08:36:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350aJBTEFkP6aqAHdaeIIvmOP9rVekfmxxI9LgulqMr7BZcxEwnh21R3RMUZwmFE3QIQUAwYc0g==
X-Received: by 2002:aa7:c790:0:b0:4fc:d837:2c44 with SMTP id
 n16-20020aa7c790000000b004fcd8372c44mr3252001eds.35.1679672181598; 
 Fri, 24 Mar 2023 08:36:21 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a509b5b000000b00501dd53dbfbsm5468613edj.75.2023.03.24.08.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:36:20 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 2/9] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Date: Fri, 24 Mar 2023 16:36:00 +0100
Message-Id: <20230324153607.46836-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

When the user call VHOST_SET_OWNER ioctl and the vDPA device
has `use_va` set to true, let's call the bind_mm callback.
In this way we can bind the device to the user address space
and directly use the user VA.

The unbind_mm callback is called during the release after
stopping the device.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - added new switch after vhost_dev_ioctl() [Jason]
    v3:
    - added `case VHOST_SET_OWNER` in vhost_vdpa_unlocked_ioctl() [Jason]
    v2:
    - call the new unbind_mm callback during the release [Jason]
    - avoid to call bind_mm callback after the reset, since the device
      is not detaching it now during the reset

 drivers/vhost/vdpa.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..3824c249612f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -219,6 +219,28 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
 	return vdpa_reset(vdpa);
 }
 
+static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!vdpa->use_va || !ops->bind_mm)
+		return 0;
+
+	return ops->bind_mm(vdpa, v->vdev.mm);
+}
+
+static void vhost_vdpa_unbind_mm(struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!vdpa->use_va || !ops->unbind_mm)
+		return;
+
+	ops->unbind_mm(vdpa);
+}
+
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -716,6 +738,17 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		break;
 	}
 
+	if (r)
+		goto out;
+
+	switch (cmd) {
+	case VHOST_SET_OWNER:
+		r = vhost_vdpa_bind_mm(v);
+		if (r)
+			vhost_dev_reset_owner(d, NULL);
+		break;
+	}
+out:
 	mutex_unlock(&d->mutex);
 	return r;
 }
@@ -1287,6 +1320,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 	vhost_vdpa_clean_irq(v);
 	vhost_vdpa_reset(v);
 	vhost_dev_stop(&v->vdev);
+	vhost_vdpa_unbind_mm(v);
 	vhost_vdpa_config_put(v);
 	vhost_vdpa_cleanup(v);
 	mutex_unlock(&d->mutex);
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

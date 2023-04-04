Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52897C761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBE7B4016F;
	Tue,  4 Apr 2023 13:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBE7B4016F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWkmfrj1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYUClyuRQiRh; Tue,  4 Apr 2023 13:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57C28403A7;
	Tue,  4 Apr 2023 13:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57C28403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A8FC0036;
	Tue,  4 Apr 2023 13:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D2F9C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 089A681766
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 089A681766
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VWkmfrj1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9phherCP5p0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C96B8174F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C96B8174F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MlJ8boSBAN33TyWlK9MdNtuYbz66i2Pl/D7dBKo3iE=;
 b=VWkmfrj1S+kJ3rExN+Wb4/Drv3FFYNnoekHz/4RgM+pXGGNc/EoosmmCvniVVRjphwoyoG
 xbjvAl6LYRLZMfjB4t/X0INCjmLHwl0QnIzbsrt5e2oPP84dAk6wGLCzbr0M/86V7IEJe4
 uZUtI+KW/tM/sqGbRFiWvUHta0pmNn8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-eh38RdmjM1u1DGpl6ebYNw-1; Tue, 04 Apr 2023 09:13:59 -0400
X-MC-Unique: eh38RdmjM1u1DGpl6ebYNw-1
Received: by mail-qk1-f198.google.com with SMTP id
 195-20020a3705cc000000b00746a3ab9426so14640916qkf.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MlJ8boSBAN33TyWlK9MdNtuYbz66i2Pl/D7dBKo3iE=;
 b=nCzqXsKZw/cy9x2p7ZMnl1P+rnPOpNAVmP5MiIHI1eEBS2sPmOyquojR/ebF/L1aqY
 kqiTTr8Aq2UzWqeAIBHM30gdPK5j+okV7PdFRxjOAZroeUnLPNrs5H1gy8he5Ju9V9NN
 y+YAvSzTjoeFCAaUdSXQvz2yH7xo46WVwaqpMp7MuuafA4UlwDtZHNKgIhMWHhEg0/da
 QDZ0GIRaAENKLVPe/vI0GvnI+iKLI/UscmDCXuRk6FYT337GKcnb7/6mN+RnVHcOwbhL
 7Vv/6o429AP7+7K1dcYDmCBY+vqpFNfi8Qm9L71lbLO1WtLOne6T6HpuZlqOfZ393S4T
 d04g==
X-Gm-Message-State: AAQBX9fidtFzmbDUiDgaUtltownAiu0IUivX4MaA1foowXRXG4M8wEOA
 I4E4a4BIEOalLe86yTGDSWVdtKdKfkw7KpcOWmWIItGG7cIXBriFnFgXSqzM21NWBrpRuBdsR4N
 nJEuP1lP2XZ3BvmH7e259KxUdkPD27Ysnve0QhhoXm4GInzrZzVzesEBZM/ARqc+pIA0FQuVtQ+
 tT7waVhdembHBmHyrSnnddErSFDg==
X-Received: by 2002:a05:622a:452:b0:3e2:4280:bc5d with SMTP id
 o18-20020a05622a045200b003e24280bc5dmr2577084qtx.23.1680614038489; 
 Tue, 04 Apr 2023 06:13:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCSJM7sVlkvzpoiu/gc9FXBYw+oU6Dc67qLTb9UimmcbBb5Gh6pKFgktvtOVRk6+HyH/s72g==
X-Received: by 2002:a05:622a:452:b0:3e2:4280:bc5d with SMTP id
 o18-20020a05622a045200b003e24280bc5dmr2577024qtx.23.1680614038001; 
 Tue, 04 Apr 2023 06:13:58 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 z5-20020ac87105000000b003e64303bd2dsm2841837qto.63.2023.04.04.06.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:13:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 2/9] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Date: Tue,  4 Apr 2023 15:13:19 +0200
Message-Id: <20230404131326.44403-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
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

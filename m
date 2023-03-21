Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37686C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BED3B61112;
	Tue, 21 Mar 2023 15:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BED3B61112
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bRpPSBlp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RTRG89jug6Ht; Tue, 21 Mar 2023 15:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D8E56110C;
	Tue, 21 Mar 2023 15:42:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D8E56110C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2639CC0071;
	Tue, 21 Mar 2023 15:42:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7D34C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 714BC6110D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 714BC6110D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hhb3JBeH6Yqk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 418F761104
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 418F761104
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QASJhsJ+hdJk3WLN6OfGqjuqBH1Q3bTytFBvValx858=;
 b=bRpPSBlpXRWBUBRFa8kgCgMpMLo9T0Imx+bPFs/NXLDXe2M7KDeDWzlFMm0PS4V5FD4xak
 xyZyfhJS/ZDwEoxoyya3JexdqGpvN+sAj5zwLQVUNNA8Ao1tQ8aSPyD26dsrO5AiNDpkQ+
 Xv3kRYe2z4VEw6puiMYcR8Po67zu2iI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Aj3HNv2oOzWMDh4z4CXAYw-1; Tue, 21 Mar 2023 11:42:36 -0400
X-MC-Unique: Aj3HNv2oOzWMDh4z4CXAYw-1
Received: by mail-wm1-f70.google.com with SMTP id
 o7-20020a05600c4fc700b003edf85f6bb1so3118240wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QASJhsJ+hdJk3WLN6OfGqjuqBH1Q3bTytFBvValx858=;
 b=OhhguYBYeJEID7EB11wxOEHPUSpw9RvcdFErTNx1FvP9Hr1bXFgno0eTEUKi9EMkVE
 OBNVC4l6lxQeAfYjFWq/yP+O+IFCFq/I7b4zFWWTm/Y6Efp7c9jGd1e/hbsPQm0bJJhn
 kcnU6Oh1OApnNirNYaN+arMaOMBkCu9MNl5Cp6Zvljq7ulTMVOQH9/jvORWTujEJPP7Z
 W6B35eHQ8HiFoN0M+VimvoRFTsYwznFeDa3AGq2DC03rV/j/xr6m6Pfd+QEqsEAIy1nW
 Wuxvy8PnTuFOnqzfwRlO3cT5xaIWSMToPMRmgEsUpexNjyL4b1QgvpXbabwKlg6Txr2W
 cpSQ==
X-Gm-Message-State: AO0yUKVtvcyQ10R++xJz5ygm1j+sotQUyru0IrwgImiTKirj1s0cIPFT
 A/6z7Y1pqkS5RHk2ycN2nK59m9FXpWxKxf4xl0oneKZ1ypu18BeT0Up5UH3J6DyQCG5Cl0+JwKq
 8G/JYvSg/QYxIXTtXmL6yryjiSAOuCcurpEYXaKoVn1VS4k4LkWD51Q9+xHdn6766bk9n2q4TYT
 RBhXtRt/htsjudqNszOfV8qkz7Uw==
X-Received: by 2002:a5d:5382:0:b0:2cf:ed44:693c with SMTP id
 d2-20020a5d5382000000b002cfed44693cmr2551087wrv.31.1679413355492; 
 Tue, 21 Mar 2023 08:42:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set+cPTfHDIMahJYsEyI78yh9D7tSYE1RLi2Gk+kcor46FddUKzpMWH1lQfIFzdB3Llbe5PLtkg==
X-Received: by 2002:a5d:5382:0:b0:2cf:ed44:693c with SMTP id
 d2-20020a5d5382000000b002cfed44693cmr2551068wrv.31.1679413355138; 
 Tue, 21 Mar 2023 08:42:35 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:42:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Date: Tue, 21 Mar 2023 16:42:22 +0100
Message-Id: <20230321154228.182769-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154228.182769-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
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
    v3:
    - added `case VHOST_SET_OWNER` in vhost_vdpa_unlocked_ioctl() [Jason]
    v2:
    - call the new unbind_mm callback during the release [Jason]
    - avoid to call bind_mm callback after the reset, since the device
      is not detaching it now during the reset

 drivers/vhost/vdpa.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..20250c3418b2 100644
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
@@ -709,6 +731,14 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_RESUME:
 		r = vhost_vdpa_resume(v);
 		break;
+	case VHOST_SET_OWNER:
+		r = vhost_dev_set_owner(d);
+		if (r)
+			break;
+		r = vhost_vdpa_bind_mm(v);
+		if (r)
+			vhost_dev_reset_owner(d, NULL);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
@@ -1287,6 +1317,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
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

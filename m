Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F4C7EE33
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA1C9409B2;
	Thu,  2 Mar 2023 11:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA1C9409B2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cz0t9gVr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QacVbllc3B3h; Thu,  2 Mar 2023 11:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EAE0419A8;
	Thu,  2 Mar 2023 11:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EAE0419A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04C05C008A;
	Thu,  2 Mar 2023 11:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA59C0035
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDFD940A8B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDFD940A8B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cz0t9gVr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXA1nZWG8XVA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24799400F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24799400F6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYIRvQhreJmamPTgF10vjkMAMOhZQaOaX6sUzVAfpfw=;
 b=cz0t9gVrSir3WaULhDS0g2vlRgqV/sHPHdxkgXs2gQ2Gyq0/G2bGhd0ERhRIFQOBpDIV6Y
 tydKEhqDNAvTIY+2aRuY2dD1agjes37GdnKRuKklaNP+hXBujHf3LYhtUwbUgkE8Gz/rKS
 hIPde7i130ZW/42pgBjjxIWqHrmUpQQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-4A7e5ofnOtin6MamPDb8AQ-1; Thu, 02 Mar 2023 06:34:36 -0500
X-MC-Unique: 4A7e5ofnOtin6MamPDb8AQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 8-20020a370508000000b00724fd33cb3eso9839655qkf.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYIRvQhreJmamPTgF10vjkMAMOhZQaOaX6sUzVAfpfw=;
 b=6F0DdtQ63iOpXsWUM8BoFHzZgDk2U+w4o+RC7h7lyEl1Goy3fooANhkoqaxaLluZlX
 FKiOD0M6U6Kwd3mhLWGqk3J3iktXNio1WrSFj48eyE1AzY4/EnzccyylJEEfgBNWeckE
 rX6++99Y4XpVfmI8TCbhTP8au4hLsV7O9VGrdBkE38/tvJAkkUU05OINGqBoh+velwqT
 QkcjbIliH9T9BVwrdt7J8dhm6mqamrn1iJf0li6D39mgcqD3TIC8OTIB0xxxSqn2ephu
 ebnSgXXuJv/TDQ9NPc6fK7xsz0Ke1qEN0vhhwR2SiKocMEEbzh7u8flwwMuV1doNm1hS
 iMFw==
X-Gm-Message-State: AO0yUKWo9bjlNoprHQKxvN8lHc1cggiLyez+dqT3fcKGn8eaGXPh1YAX
 dqEecBAYqt1kyxg+NMP7338f7Tw5hwY9vf6BCr7ZsO3V+MiuPwX4srvKV5vopFtRzPLiIcbM0xo
 EG6uadd5fCF0u2FDqKX/ev5DOcNwig+nw+k1X3AOSRiWwdiZGhu9B4JfgAJI+OlXhBhXi398tnx
 gDunHg/B0SLbiITgLR03vT1cM=
X-Received: by 2002:a05:622a:186:b0:3bf:d4c3:365d with SMTP id
 s6-20020a05622a018600b003bfd4c3365dmr17450767qtw.14.1677756875349; 
 Thu, 02 Mar 2023 03:34:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+DEB84vy51k02CcK+JjytuJL+amad7fRxImnJYIv4nCRuUv0xkGiPSLgQZT6Jrlf+7iGe6iA==
X-Received: by 2002:a05:622a:186:b0:3bf:d4c3:365d with SMTP id
 s6-20020a05622a018600b003bfd4c3365dmr17450741qtw.14.1677756875094; 
 Thu, 02 Mar 2023 03:34:35 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 o12-20020ac8698c000000b003ba19e53e43sm10084156qtq.25.2023.03.02.03.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:34:34 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Date: Thu,  2 Mar 2023 12:34:15 +0100
Message-Id: <20230302113421.174582-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
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
    v2:
    - call the new unbind_mm callback during the release [Jason]
    - avoid to call bind_mm callback after the reset, since the device
      is not detaching it now during the reset

 drivers/vhost/vdpa.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index dc12dbd5b43b..1ab89fccd825 100644
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
@@ -711,6 +733,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
+		if (!r && cmd == VHOST_SET_OWNER) {
+			r = vhost_vdpa_bind_mm(v);
+			if (r) {
+				vhost_dev_reset_owner(&v->vdev, NULL);
+				break;
+			}
+		}
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vdpa_vring_ioctl(v, cmd, argp);
 		break;
@@ -1285,6 +1314,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 	vhost_vdpa_clean_irq(v);
 	vhost_vdpa_reset(v);
 	vhost_dev_stop(&v->vdev);
+	vhost_vdpa_unbind_mm(v);
 	vhost_vdpa_free_domain(v);
 	vhost_vdpa_config_put(v);
 	vhost_vdpa_cleanup(v);
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

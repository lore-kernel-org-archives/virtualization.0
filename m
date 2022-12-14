Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA80C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 16:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5FAF80C52;
	Wed, 14 Dec 2022 16:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5FAF80C52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dUQsRdMM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9WGnGsqgu-7c; Wed, 14 Dec 2022 16:30:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6100D81EF7;
	Wed, 14 Dec 2022 16:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6100D81EF7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEF39C007F;
	Wed, 14 Dec 2022 16:30:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4EEFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1AB340BB2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1AB340BB2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dUQsRdMM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCAtJuUC_or0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E305640111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E305640111
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671035434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntjy4bIssvEAdzLttb0Oirdk6ECvBiYBnXEucLTwyX4=;
 b=dUQsRdMMADlTjjGMGYWWBAtbujoM/OUV7BATYHHvudiZY7FiCblexoUB00UOOZNoLffUHZ
 DZViPveJp69iVjuVVXUDUi3cIkzxtRtBYKxVJJ5DbMS5fa11GbazXtOKUjjoVnEkRHFDM8
 d8Cmgd9pO/IhyNktEFtAibtgFQefAqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-0nNFSM55N8qaRrP7wl558Q-1; Wed, 14 Dec 2022 11:30:33 -0500
X-MC-Unique: 0nNFSM55N8qaRrP7wl558Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 21-20020a05600c021500b003d227b209e1so3198883wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntjy4bIssvEAdzLttb0Oirdk6ECvBiYBnXEucLTwyX4=;
 b=YWuowOETTQ0jLsonUR4nauGxoe4JfFjCfostGuhTcklrj3tvmVzf3tBptHoAb4tshs
 U5UeQe1k3WuzNZ5MNb0u4QlV5+PmayMzYV3zHRmFbN4JX8Km3cRuq7ufeKqce300dDbc
 qHUS5o77FuFOVUGeQVpr4C+rflUxrMc0Qzm/LP5E2/XgGCukQE7fdxIR4nHQ6RPVynXZ
 Y/FvWwQhUHh6nvCCdbtGkvHS7MifrzbsQWgaiFnMLy32x16aM4wjeDCmJBvJan7D6VGz
 IAZCaPsnpYCX2ec+3MeCZwij6N6uOKHZ11MBeqQwZMQ01fKZAozgoMABpKHDUtYrKY8K
 PExQ==
X-Gm-Message-State: ANoB5pnUfKdlO7Xxb+sOIPS+cvp+RcQM6MIQ3vSGMzeTjABycTy2CTeV
 Cuqk/Va79BWw6pGWUGt2WwUW/1U6A+xxK4SEwp5DU+P35ah/ncMgWiXW99VTj6OyhEa76g5W0nb
 e1Ff29eY5UlFvhahC91xlhmmxogglhMTERuloxIZX912Jm60QKtzE0rTxEY0nxZyoBOQiFsl618
 /DmswUjlAeUy2dB00XCA==
X-Received: by 2002:a5d:43c8:0:b0:242:659f:9411 with SMTP id
 v8-20020a5d43c8000000b00242659f9411mr18656576wrr.9.1671035432214; 
 Wed, 14 Dec 2022 08:30:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf749Y7E+BT4q6kPhJknMxXoEgk8H6qeSlLUTLbG1hIMjBAx7MTauP5T5GnuPa8o2ZC6K5qBtA==
X-Received: by 2002:a5d:43c8:0:b0:242:659f:9411 with SMTP id
 v8-20020a5d43c8000000b00242659f9411mr18656541wrr.9.1671035431915; 
 Wed, 14 Dec 2022 08:30:31 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 e17-20020adffd11000000b002422816aa25sm3791759wrr.108.2022.12.14.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 08:30:31 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/6] vhost-vdpa: use bind_mm device callback
Date: Wed, 14 Dec 2022 17:30:21 +0100
Message-Id: <20221214163025.103075-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214163025.103075-1-sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b08e07fc7d1f..a775d1a52c77 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -219,6 +219,17 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
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
+	return ops->bind_mm(vdpa, v->vdev.mm, current);
+}
+
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -276,6 +287,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		ret = vdpa_reset(vdpa);
 		if (ret)
 			return ret;
+
+		ret = vhost_vdpa_bind_mm(v);
+		if (ret)
+			return ret;
 	} else
 		vdpa_set_status(vdpa, status);
 
@@ -679,6 +694,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
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
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31000C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B5B2065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4HEHhDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B5B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE72F2152A;
	Wed,  5 Aug 2020 13:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x755Xz6qQFqp; Wed,  5 Aug 2020 13:44:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9FBF420518;
	Wed,  5 Aug 2020 13:44:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A4BC0051;
	Wed,  5 Aug 2020 13:44:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F334C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D60F22091
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cFEip+-lKlMv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id B78BF214FD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2jHnVO0sEztuVrpmrLjXxFZdWdSW7ZIexUpdoeRg8Q=;
 b=I4HEHhDyhXGRArqvx9QjQrGgJS9n+tmRPdyrbAJ0p7Mn5pltp8A8Dd1OFfY26gwbwsE+l2
 4z/KmMQZQS75MWsbXnkl7K7HWkOkbgEoDx1JrDGsQF5Ln39JeMDS67GW0Jk4NtnXmlC9lj
 Hu3SYiQGk/txJldFQrC58Q8bn8rzYZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-53zYDW4POueHw_Glxw7-bw-1; Wed, 05 Aug 2020 09:44:41 -0400
X-MC-Unique: 53zYDW4POueHw_Glxw7-bw-1
Received: by mail-wm1-f72.google.com with SMTP id u68so2479114wmu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e2jHnVO0sEztuVrpmrLjXxFZdWdSW7ZIexUpdoeRg8Q=;
 b=jL0y/8LoLw14iTGcPRDK4UXi8JINAedin/XDHFkbJQ9EMQjM1W14YCXLipHRNQDQ5z
 y3XAgMBfJs9Zsg9vEfH/ouAU8azTOyjvv6uoaGGIVlDifTqmhoAg6uXVl7Og6v2J5PZZ
 DPfsJHpcBcvfDX+au9B4Bjz5jHhGZFnnt6eaV5h+Xb0b/XEh+rl0bi675k4Wq8K9N9sY
 8URpylspk93Z2tBqe2pSVxJgpG0W8UewQ8tTSwpojicZg7uSbLozGp6LuZ0sinoBEsPZ
 QpoKl7pdUPssYCHPlcUJZsYKxDmGzr/tXASkMgkcmyqO/r07EvhPLT4UGnGk9iccuLP0
 OOlg==
X-Gm-Message-State: AOAM53256IJhQYQphccGquMJuqPa9W7E0BYdWsj+ye/LJ3RbJK5Oilvw
 x6QfLOxroULfTGctM89qFNJ9kqB3sudAjYhsKrnNKPoH84ia8Iq63mvG5hjNHbaTKYk+CFLRVDY
 bDDNgSVishD12vUaimbHdknduD12RHj58sZPq9TzqYQ==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2817781wrw.214.1596635079552; 
 Wed, 05 Aug 2020 06:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ib/ImC76XF/Meb2+m6CfoYcJAU9nZg0obXIEdj/4+DzOtUwLHz22KMW3gaDBsLcUTuN9qA==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr2817757wrw.214.1596635079284; 
 Wed, 05 Aug 2020 06:44:39 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id i4sm2825723wrw.26.2020.08.05.06.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:38 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/38] virtio_input: convert to LE accessors
Message-ID: <20200805134226.1106164-31-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
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

Virtio input is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index efaf65b0f42d..877b2ea3ed05 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -113,9 +113,9 @@ static u8 virtinput_cfg_select(struct virtio_input *vi,
 {
 	u8 size;
 
-	virtio_cwrite(vi->vdev, struct virtio_input_config, select, &select);
-	virtio_cwrite(vi->vdev, struct virtio_input_config, subsel, &subsel);
-	virtio_cread(vi->vdev, struct virtio_input_config, size, &size);
+	virtio_cwrite_le(vi->vdev, struct virtio_input_config, select, &select);
+	virtio_cwrite_le(vi->vdev, struct virtio_input_config, subsel, &subsel);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, size, &size);
 	return size;
 }
 
@@ -158,11 +158,11 @@ static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
 	u32 mi, ma, re, fu, fl;
 
 	virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ABS_INFO, abs);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.min, &mi);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.max, &ma);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.res, &re);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.fuzz, &fu);
-	virtio_cread(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.min, &mi);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.max, &ma);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.res, &re);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.fuzz, &fu);
+	virtio_cread_le(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
 	input_set_abs_params(vi->idev, abs, mi, ma, fu, fl);
 	input_abs_set_res(vi->idev, abs, re);
 }
@@ -244,14 +244,14 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 	size = virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ID_DEVIDS, 0);
 	if (size >= sizeof(struct virtio_input_devids)) {
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.bustype, &vi->idev->id.bustype);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.vendor, &vi->idev->id.vendor);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.product, &vi->idev->id.product);
-		virtio_cread(vi->vdev, struct virtio_input_config,
-			     u.ids.version, &vi->idev->id.version);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.bustype, &vi->idev->id.bustype);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.vendor, &vi->idev->id.vendor);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.product, &vi->idev->id.product);
+		virtio_cread_le(vi->vdev, struct virtio_input_config,
+				u.ids.version, &vi->idev->id.version);
 	} else {
 		vi->idev->id.bustype = BUS_VIRTUAL;
 	}
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

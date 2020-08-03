Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3618C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FBB22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8FQaF2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FBB22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70AD0864B8;
	Mon,  3 Aug 2020 21:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E-boyyHc3fkX; Mon,  3 Aug 2020 21:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 82E6E85E12;
	Mon,  3 Aug 2020 21:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F304C0891;
	Mon,  3 Aug 2020 21:00:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3478C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BB3912051A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYjEcMHmVBY8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 480E02050E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NiZB22SeLbsfRSVDlKOFqbTnwVzNTGOJ5/PiHpTfDck=;
 b=C8FQaF2LsGUur+ucVxuLl7m10l5x3uXpRHTdaNCZhWieMJgnhM2jdezUauWD5mZXO0ljTX
 0AoA1Zm5pM+Xs1NJIjY04FyXPTQVTrbuZDmgLY+UhwT6jWZZXZiD1dHeVYrGGPtwXpEoBS
 6EDycJh8IYQkA76KsCT90ZRJd6MROmM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-qVoeBOtdNnCxPaFXAv7Z1g-1; Mon, 03 Aug 2020 17:00:26 -0400
X-MC-Unique: qVoeBOtdNnCxPaFXAv7Z1g-1
Received: by mail-qt1-f199.google.com with SMTP id w30so12260139qte.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NiZB22SeLbsfRSVDlKOFqbTnwVzNTGOJ5/PiHpTfDck=;
 b=Cp37VBLxQmD8gvPOJX0dEO8XVzhq907r2k89FsTAqLvvfHW7orsGOL/Ha7q3mK5U3M
 KhYjG2hZj70Q4e5DYT0Z4S8HIMV9JOYTqP7BAUY1PbG+SU/G1H2joUz4fINPxNG88zfj
 4q2H8bHYe0tfaEXKuUxGOfaXOVWwQISWGTIZzK4X1mexEzpUAmnoC+9/DfsMeSbVYXff
 Y+ynj7tL5m/NKuaaugCxmOyBbI78skkLumRE6x0b8jR4efN1MDyMLzqu5BpUr2xySbre
 NW21WhfbelfS1uOC4JpVaeEF4uSaZoPWWDa6taP/thG+0aCI9i4fntcABLREnJ8Qq9cu
 R0lA==
X-Gm-Message-State: AOAM533J8EnKg8fGyba0cJnJnE7z1jAMih0DcwucxJylZGacchfH72Bt
 3Z46T4senXttbyoBU5ksQF0unNseVfYyaWH/dqDfVKbIDyGfFJ0AVgPr+SI/xHx7MuKL5Ewk5hN
 lDTOu0qHllUewojJkkkAENJi0FZDAgYNWAdWqtZ+Bpw==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr18404669qtn.229.1596488424439; 
 Mon, 03 Aug 2020 14:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpo0f24LeUjpc3FWqSxgI10kipRuf37ecjGkYkh3fCSeCIKIolBKdEfCyIApYIsbUD/tDaLg==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr18404641qtn.229.1596488424194; 
 Mon, 03 Aug 2020 14:00:24 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id h55sm24470268qte.16.2020.08.03.14.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:23 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
Message-ID: <20200803205814.540410-23-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

VDPA sim accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..fa05e065ff69 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -24,6 +24,7 @@
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
+#include <linux/virtio_byteorder.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_net.h>
@@ -72,6 +73,23 @@ struct vdpasim {
 	u64 features;
 };
 
+/* TODO: cross-endian support */
+static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
+{
+	return virtio_legacy_is_little_endian() ||
+		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
+static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
+{
+	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
+{
+	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
+}
+
 static struct vdpasim *vdpasim_dev;
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
@@ -306,7 +324,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops;
 
 static struct vdpasim *vdpasim_create(void)
 {
-	struct virtio_net_config *config;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int ret = -ENOMEM;
@@ -331,10 +348,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	config = &vdpasim->config;
-	config->mtu = 1500;
-	config->status = VIRTIO_NET_S_LINK_UP;
-	eth_random_addr(config->mac);
+	eth_random_addr(vdpasim->config.mac);
 
 	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
 	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
@@ -448,6 +462,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	struct virtio_net_config *config = &vdpasim->config;
 
 	/* DMA mapping must be done by driver */
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
@@ -455,6 +470,12 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	vdpasim->features = features & vdpasim_features;
 
+	/* We only know whether guest is using the legacy interface here, so
+	 * that's the earliest we can set config fields.
+	 */
+
+	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 	return 0;
 }
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

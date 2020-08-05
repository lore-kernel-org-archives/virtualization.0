Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E01C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A40B2065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK3GxxPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A40B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 223F520BF8;
	Wed,  5 Aug 2020 13:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AaQGkdmO55Pj; Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A68082268C;
	Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 856C7C0051;
	Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C26DC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8055F877E1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KxlU43bEQAY6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4ACC875BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HGH8uN/cNB2/6WI5Jdaw/ORCmqNBtzwnAZDFmfA6T4k=;
 b=eK3GxxPZAa3TtbIU4TiajU4KUf1hmQhJBBdUcZZKwja7YoDav/TRuUf4ZFUR7hG1J+LhN8
 TGdEseKGewmB0EpfXAOmfH313DF1gHC7ynhIlrAviAoRR9F4V9cfRK1gVY7OYY+o5Ynx7S
 9qFJVifkFvOJ6XPK997oR9DbH8LvuBs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-mbbNYAqLMDivo9YHwU7Cqw-1; Wed, 05 Aug 2020 09:44:19 -0400
X-MC-Unique: mbbNYAqLMDivo9YHwU7Cqw-1
Received: by mail-wm1-f69.google.com with SMTP id p184so646280wmp.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HGH8uN/cNB2/6WI5Jdaw/ORCmqNBtzwnAZDFmfA6T4k=;
 b=ktDgMOSKCtfl8BCqddKUnWLNwGpkXQ+oZBB8Ch3mtA5x3NasavAERCiF1MRgqP6XMN
 TDAOAh2VLpII46PWBBrVkDHjWMHdysiWemXQ7nssXgddYgUDKdGr1L3PXzjuaQ1GEzqj
 QaviKCfCoxDk0RAslvtlMqSqShT5ucSVjD9Wn/ZLV4CggUT3C4ORnc2Um83fKE5v8mdP
 rqlmiKLSxUo0yFsO4t75YULA+54DfQK6JYaUa6l3Dg4zbg5/Yw5bLJnWjPU4w7WwiYGG
 2iFSyiIAl0/IWz8nZrWnu6ehPKNjTjXKjtdJc5zEiS2dLIvQ6135ksYQ+vF/v230eTMM
 VqaA==
X-Gm-Message-State: AOAM532+/YOajZGgeew4BV2PFDzMJBR9adaNdyqqNAdVKGQ1l3ZFmHgg
 ZEAsqYq2YNwwXcY8N64drOpre8JXMf/Umx6Y4sTiNDe6F7IjSPsmtYoUPG24FFsY3TQbrYgKFVB
 U3Yq0GNSEtmSsu8szNuQ2tE0f5b+JIIeZqXdzqn+utA==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr3312340wme.119.1596635057957; 
 Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC4k9IinKSvhYB2iv/paIM/IOHx4dnXSDebtCSSPL0wngI27bkfM89iBZEVeTyNvldrdyFDQ==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr3312320wme.119.1596635057717; 
 Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 g25sm2755239wmh.35.2020.08.05.06.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:17 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/38] vdpa_sim: fix endian-ness of config space
Message-ID: <20200805134226.1106164-23-mst@redhat.com>
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

VDPA sim accesses config space as native endian - this is
wrong since it's a modern device and actually uses LE.

It only supports modern guests so we could punt and
just force LE, but let's use the full virtio APIs since people
tend to copy/paste code, and this is not data path anyway.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 33 +++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a9bc5e0fb353..b7d5727fde4c 100644
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
@@ -455,6 +470,14 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	vdpasim->features = features & vdpasim_features;
 
+	/* We generally only know whether guest is using the legacy interface
+	 * here, so generally that's the earliest we can set config fields.
+	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
+	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
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

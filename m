Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E226C433FE
	for <virtualization@archiver.kernel.org>; Tue,  4 Oct 2022 12:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A9F440BAB;
	Tue,  4 Oct 2022 12:47:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A9F440BAB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IvWGS7Xm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2wgtdOJxqOG; Tue,  4 Oct 2022 12:47:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E31C3400D8;
	Tue,  4 Oct 2022 12:47:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E31C3400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A151BC0032;
	Tue,  4 Oct 2022 12:47:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 775E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 12:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BAFA60E2B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 12:47:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BAFA60E2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IvWGS7Xm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KkLnlRypyONl
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 12:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E9F860B46
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E9F860B46
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Oct 2022 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664887626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJvrLZKz0phQwFOn8zjOvRDgek7efPzkS0daCUrrFmc=;
 b=IvWGS7Xm5/SVtRKcrWF2j+cXE0MWbk34hqHxCSrmtOhQTiQXSkdhV7mQ9ZVXU8KKsALAPU
 5V8sc8pe9irVOy5/ZhiMHFBXknRhIG/HfiRlIrO3WxGVIarWcmQU76gHMpIA4mwI8P+3KB
 M6rH96qTPfG+KnMZUCpLCbIyvV3NlUY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-C9iWlTZoOd-EmU5m_7nihQ-1; Tue, 04 Oct 2022 08:46:33 -0400
X-MC-Unique: C9iWlTZoOd-EmU5m_7nihQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 e11-20020adfa74b000000b0022e39e5c151so1690384wrd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Oct 2022 05:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=JJvrLZKz0phQwFOn8zjOvRDgek7efPzkS0daCUrrFmc=;
 b=TGPqAMmGofiNbax7IxtVqtWwoihFuk53s1ruH6+Kdd6tEOr0/KKTMAYdaoBiAvBIwX
 mLyF4DsB7AvW/qy+sgiLBKTsvqSwVs+tpnjz0UEeBBRIGozsrirexVUG031bjoXUULuN
 IJYPICoNtEOZTX8ZZ4iay87YbfUxHg7/Onu70GfACECqwLkk8bvU60J0miKle+D4e38h
 NaChjV7EwEiY6CPHzrb/9z+bpUgCY8kIyd8CxjTvVHQ//+wPosmM24oZp2g2URhWzIrT
 R2lpqmZerE5DD09G1Zn1ZqPNhnOHyCTTZ89qhRiw66HC/RDKueqtFdqPF4ZHmRtyQvU1
 pcIw==
X-Gm-Message-State: ACrzQf1nKhxUdYStTlZyreL0uunwbd+wm1wzIauUCjWxERDYfIJUpmnw
 QAN1edNDps084zl/tTjCfSy8VZiyiAMEaJ3djRlnct2Q2wRs+BZ4hEo7O72z66KsJ3jFmlTn25l
 po6OEQSM5kwoBgcqJy6/ZoIsM5l02k5mwzmM+CEKhwA==
X-Received: by 2002:a1c:cc0e:0:b0:3b4:fda3:c808 with SMTP id
 h14-20020a1ccc0e000000b003b4fda3c808mr9618070wmb.146.1664887592204; 
 Tue, 04 Oct 2022 05:46:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51E0gqiu5xGN8S9QHKYQamo7K0r0vQ71EXRG9rAv/r6jmXMF09GeYKvE5nbQP5TWLg+iOPGw==
X-Received: by 2002:a1c:cc0e:0:b0:3b4:fda3:c808 with SMTP id
 h14-20020a1ccc0e000000b003b4fda3c808mr9618057wmb.146.1664887591991; 
 Tue, 04 Oct 2022 05:46:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 n189-20020a1ca4c6000000b003a8434530bbsm569911wme.13.2022.10.04.05.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Oct 2022 05:46:27 -0700 (PDT)
Date: Tue, 4 Oct 2022 14:46:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20221004124622.75w7zt2pfvy5oph3@sgarzare-redhat>
References: <20220927074810.28627-1-jasowang@redhat.com>
 <20220927074810.28627-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220927074810.28627-3-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, mst@redhat.com, xieyongji@bytedance.com,
 linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 wuzongyong@linux.alibaba.com, elic@nvidia.com, lingshan.zhu@intel.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Sep 27, 2022 at 03:48:09PM +0800, Jason Wang wrote:
>This patch implements features provisioning for vdpa_sim_net.
>
>1) validating the provisioned features to be a subset of the parent
>   features.
>2) clearing the features that is not wanted by the userspace
>
>For example:
>
># vdpa mgmtdev show
>vdpasim_net:
>  supported_classes net
>  max_supported_vqs 3
>  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
>1) provision vDPA device with all features that are supported by the
>   net simulator
>
># vdpa dev add name dev1 mgmtdev vdpasim_net
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
>2) provision vDPA device with a subset of the features
>
># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 12 +++++++++++-
> drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  5 +++--
> 4 files changed, 17 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 225b7f5d8be3..b071f0d842fb 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -18,6 +18,7 @@
> #include <linux/vdpa.h>
> #include <linux/vhost_iotlb.h>
> #include <linux/iova.h>
>+#include <uapi/linux/vdpa.h>
>
> #include "vdpa_sim.h"
>
>@@ -245,13 +246,22 @@ static const struct dma_map_ops vdpasim_dma_ops = {
> static const struct vdpa_config_ops vdpasim_config_ops;
> static const struct vdpa_config_ops vdpasim_batch_config_ops;
>
>-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>+			       const struct vdpa_dev_set_config *config)
> {
> 	const struct vdpa_config_ops *ops;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
> 	int i, ret = -ENOMEM;
>
>+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>+		if (config->device_features &
>+		    ~dev_attr->supported_features)
>+			return ERR_PTR(-EINVAL);
>+		dev_attr->supported_features =
>+			config->device_features;
>+	}
>+
> 	if (batch_mapping)
> 		ops = &vdpasim_batch_config_ops;
> 	else
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 061986f30911..0e78737dcc16 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -71,7 +71,8 @@ struct vdpasim {
> 	spinlock_t iommu_lock;
> };
>
>-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
>+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
>+			       const struct vdpa_dev_set_config *config);
>
> /* TODO: cross-endian support */
> static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index c8bfea3b7db2..c6db1a1baf76 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -383,7 +383,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_blk_work;
> 	dev_attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
>
>-	simdev = vdpasim_create(&dev_attr);
>+	simdev = vdpasim_create(&dev_attr, config);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 886449e88502..c3cb225ea469 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -254,7 +254,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_net_work;
> 	dev_attr.buffer_size = PAGE_SIZE;
>
>-	simdev = vdpasim_create(&dev_attr);
>+	simdev = vdpasim_create(&dev_attr, config);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>
>@@ -294,7 +294,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> 	.id_table = id_table,
> 	.ops = &vdpasim_net_mgmtdev_ops,
> 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>+		             1 << VDPA_ATTR_DEV_FEATURES),
> 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> 	.supported_features = VDPASIM_NET_FEATURES,
> };
>-- 
>2.25.1
>

Fine for me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I'll send a followup to enable VDPA_ATTR_DEV_FEATURES in vdpa_sim_blk 
and test it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

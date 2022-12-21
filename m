Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0BC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 13:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B308C402A8;
	Wed, 21 Dec 2022 13:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B308C402A8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGO8QxnV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUcOt_viJXCH; Wed, 21 Dec 2022 13:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E4AD4019E;
	Wed, 21 Dec 2022 13:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E4AD4019E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23A4C0071;
	Wed, 21 Dec 2022 13:30:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0845C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73082410E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73082410E7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGO8QxnV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4LFDMBNMy4OY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75A5D409B4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A5D409B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671629433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p11WT9SHFSvh+pLhF3giJuzfy7F8C5mDBl42ACj58zk=;
 b=YGO8QxnVsNA/b6SSBUYBjmhyCaBL/i2DpXMDebIWPU+a8kbX04A18Fz87/9P+f32IQ3OHy
 iPCgfxluhmk+uaEEcTaZsVohdohZLIajVHPbl8W3+9QfEuS1Bdt6CHmBu11H6SVqfaXred
 X14AG5f2zb9BXNVVh6VbQC+iA1dYaSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-CY5olbetNqWV2OhknFFnlw-1; Wed, 21 Dec 2022 08:30:32 -0500
X-MC-Unique: CY5olbetNqWV2OhknFFnlw-1
Received: by mail-wr1-f69.google.com with SMTP id
 u9-20020adfa189000000b00242121eebe2so1608700wru.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 05:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p11WT9SHFSvh+pLhF3giJuzfy7F8C5mDBl42ACj58zk=;
 b=iibbKVdFHO0rQG62HTvGrCknhwnmYAaobCcu5/4CMq3pqrFmS9Y0lIfq9LQzsQ53At
 KsukA314PL1n8Rez+34bkGL+jMOEmGcMBG2Jn4dqc67XZVGquZS7ddVdUSLwcxoPMIhe
 ll6yHiiGaP48kLu1BGPKwEzDBf2HOviOzWnNgJhk0Wd/stp9wYdZTk3IsJ1mTDxzA6+q
 fQIegRAyDcOzYYeqIzdyRpwvXXa97LnK33R+hPVDaRF5D/+c7UtwQGl7k5pPbcYBq0tb
 ZazFPu6xtlQSLa6we332hhcIMp2kgzgAsrYu1e036MEIAiS0yacpq5HlYga1upISMRZV
 JAUg==
X-Gm-Message-State: AFqh2kq1DhOCyAbHs3GAOPxY3gsIXT3yutJSnJnruFJhAIobkIu+Rhjk
 Rxy15cAG3ZPSXOW9zK3Y0BNyBXtyo7JVxIudLxhatzBIxu1cy/D0zFgAAVFRxM1aCVdPjJra4Y/
 PmHJmFvjfUFfkAor2RoC/5W3+JyL27aqRC2Kg3V/nMA==
X-Received: by 2002:a05:600c:1ca3:b0:3d3:591a:bfda with SMTP id
 k35-20020a05600c1ca300b003d3591abfdamr4424474wms.27.1671629431180; 
 Wed, 21 Dec 2022 05:30:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsULzzA9YymQGBk+iu3JSiAAOfBNlbM51hkbQHaxtaZYduUmpvhXY78qauYUuCi2nQrLl/7Lg==
X-Received: by 2002:a05:600c:1ca3:b0:3d3:591a:bfda with SMTP id
 k35-20020a05600c1ca300b003d3591abfdamr4424463wms.27.1671629430942; 
 Wed, 21 Dec 2022 05:30:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 b19-20020a05600c4e1300b003a3170a7af9sm2437071wmq.4.2022.12.21.05.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 05:30:30 -0800 (PST)
Date: Wed, 21 Dec 2022 14:30:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/4] vdpasim: customize allocation size
Message-ID: <20221221133026.s56fitht7dx4n3lo@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221221061652.15202-3-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Wed, Dec 21, 2022 at 02:16:50PM +0800, Jason Wang wrote:
>Allow individual simulator to customize the allocation size.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
> drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> 4 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 757afef86ba0..55aaa023a6e2 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	struct vdpa_device *vdpa;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
>-	int i, ret = -ENOMEM;
>+	int i, ret = -EINVAL;
>+
>+	if (!dev_attr->alloc_size)
>+		goto err_alloc;
>
> 	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> 		if (config->device_features &
>@@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	else
> 		ops = &vdpasim_config_ops;
>
>+	ret = -ENOMEM;
> 	vdpa = __vdpa_alloc_device(NULL, ops,
> 				   dev_attr->ngroups, dev_attr->nas,
>-				   sizeof(struct vdpasim),
>+				   dev_attr->alloc_size,
> 				   dev_attr->name, false);
> 	if (IS_ERR(vdpa)) {
> 		ret = PTR_ERR(vdpa);
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 0e78737dcc16..51c070a543f1 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
> 	struct vdpa_mgmt_dev *mgmt_dev;
> 	const char *name;
> 	u64 supported_features;
>+	size_t alloc_size;
> 	size_t config_size;
> 	size_t buffer_size;
> 	int nvqs;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index c6db1a1baf76..4f7c35f59aa5 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
> 	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
> 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
>+	dev_attr.alloc_size = sizeof(struct vdpasim);
> 	dev_attr.config_size = sizeof(struct virtio_blk_config);
> 	dev_attr.get_config = vdpasim_blk_get_config;
> 	dev_attr.work_fn = vdpasim_blk_work;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index c3cb225ea469..20cd5cdff919 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
> 	dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
> 	dev_attr.nas = VDPASIM_NET_AS_NUM;
>+	dev_attr.alloc_size = sizeof(struct vdpasim);
> 	dev_attr.config_size = sizeof(struct virtio_net_config);
> 	dev_attr.get_config = vdpasim_net_get_config;
> 	dev_attr.work_fn = vdpasim_net_work;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

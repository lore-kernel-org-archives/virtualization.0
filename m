Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86393C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 08:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF90740448;
	Fri, 23 Dec 2022 08:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF90740448
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Suraavd4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwuE6YUBkwrG; Fri, 23 Dec 2022 08:34:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 328FC4038C;
	Fri, 23 Dec 2022 08:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 328FC4038C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06853C0071;
	Fri, 23 Dec 2022 08:34:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBE58C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCFFE403CC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCFFE403CC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7o4RYdJ01-M2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:34:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE06F4038C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE06F4038C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671784493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=accKtY0Nk1Ttaf4aO5Gw1z4PmDYGpk3kZSawW3XXd1Q=;
 b=Suraavd4FcjtkqT6dNHV5Nnl0qs822zOIZxtKNTtINhJM1Sy2/ztK0Xq2xUyx6PiLCdN/g
 Jz8nq9ln5AwpWnaeCyvKHxs3ZHJCfvidkrF5kWt4WESksE/KWchJeJet4lIyXZor51pdi1
 HhUX2FSifLQ4WLy6QAWcMDAeqoqF9bw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-tlZnY8UlP8-n8982gyonRQ-1; Fri, 23 Dec 2022 03:34:50 -0500
X-MC-Unique: tlZnY8UlP8-n8982gyonRQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 u15-20020a0cec8f000000b004c704e015f7so2207398qvo.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 00:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=accKtY0Nk1Ttaf4aO5Gw1z4PmDYGpk3kZSawW3XXd1Q=;
 b=cVAW5EjF9aRa6LDhJSPhGtj745w/DYBMPR7Sn+KHpkyI4ORhEuZuceSyiKXu/kPsoq
 SfSOgeiFTgQeWoaYRr+QmxMM7deMaBTFafuj+bI1tTBpWH+BNzDaWkhTq7akZIHh46t+
 rA8IxO5WQFAZ8txVkv8VOZs/NSKBHzo2LufYpifM9Bzb5VOkddjJZW8jff6Nm/2X9guA
 NuxPiDElrB96wbfyAexUvuKiOb51ILoy3sbzrsG6h5zZQnHExFGNI/G3jdiYlQdvEW6x
 NTprZQyCABO5nZO58XmWIzeBch/L7LCG+skUYGvC2G09xZFicr9USDwV2gUfOdFK5+2p
 rHWg==
X-Gm-Message-State: AFqh2koouNgu76mhjh4Fe2ztd5W7FEby6ZAdT8xncYMNB3cQtl9aJT3Y
 4xnnD2dhlv5cuEXQ5fFRA9vwku802E3Wq60JEOyxytc1dx2DzNGWZrn4Ky46jpJmmI/YIrXLG5K
 XQ24+RDP430mBTDb9A6U5BUQqXnqz9QDtupNcOoedew==
X-Received: by 2002:ac8:128b:0:b0:3a5:758d:8f5e with SMTP id
 y11-20020ac8128b000000b003a5758d8f5emr10118195qti.19.1671784489761; 
 Fri, 23 Dec 2022 00:34:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjtxBh1bt1R2fuChJ76Ci/Ml0xv4HnrzrtR0IqAjJOWxujwVSOJ2YmUjszjU0SYlzviRkIpw==
X-Received: by 2002:ac8:128b:0:b0:3a5:758d:8f5e with SMTP id
 y11-20020ac8128b000000b003a5758d8f5emr10118180qti.19.1671784489516; 
 Fri, 23 Dec 2022 00:34:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-34-11-215.business.telecomitalia.it.
 [79.34.11.215]) by smtp.gmail.com with ESMTPSA id
 t15-20020ac86a0f000000b003a569a0afcasm1658112qtr.66.2022.12.23.00.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 00:34:49 -0800 (PST)
Date: Fri, 23 Dec 2022 09:34:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 3/4] vdpa_sim: support vendor statistics
Message-ID: <20221223083442.g2uby76ggfupwqyf@sgarzare-redhat>
References: <20221223055548.27810-1-jasowang@redhat.com>
 <20221223055548.27810-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221223055548.27810-4-jasowang@redhat.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 23, 2022 at 01:55:47PM +0800, Jason Wang wrote:
>This patch adds a new config ops callback to allow individual
>simulator to implement the vendor stats callback.
>
>Acked-by: Eugenio P=E9rez <eperezma@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
> 2 files changed, 17 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa=
_sim.c
>index 341da107e7da..45d3f84b7937 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -424,6 +424,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *v=
dpa, u16 idx,
> 	return 0;
> }
>
>+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
>+				struct sk_buff *msg,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>+
>+	if (vdpasim->dev_attr.get_stats)
>+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
>+						   msg, extack);
>+	return -EOPNOTSUPP;
>+}
>+
> static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> {
> 	return VDPASIM_QUEUE_ALIGN;
>@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops=
 =3D {
> 	.set_vq_ready           =3D vdpasim_set_vq_ready,
> 	.get_vq_ready           =3D vdpasim_get_vq_ready,
> 	.set_vq_state           =3D vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    =3D vdpasim_get_vq_stats,
> 	.get_vq_state           =3D vdpasim_get_vq_state,
> 	.get_vq_align           =3D vdpasim_get_vq_align,
> 	.get_vq_group           =3D vdpasim_get_vq_group,
>@@ -743,6 +756,7 @@ static const struct vdpa_config_ops vdpasim_batch_conf=
ig_ops =3D {
> 	.set_vq_ready           =3D vdpasim_set_vq_ready,
> 	.get_vq_ready           =3D vdpasim_get_vq_ready,
> 	.set_vq_state           =3D vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    =3D vdpasim_get_vq_stats,
> 	.get_vq_state           =3D vdpasim_get_vq_state,
> 	.get_vq_align           =3D vdpasim_get_vq_align,
> 	.get_vq_group           =3D vdpasim_get_vq_group,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa=
_sim.h
>index 51c070a543f1..d2a08c0abad7 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
> 	work_func_t work_fn;
> 	void (*get_config)(struct vdpasim *vdpasim, void *config);
> 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
>+	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
>+			 struct sk_buff *msg,
>+			 struct netlink_ext_ack *extack);
> };
>
> /* State of each vdpasim device */
>-- =

>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

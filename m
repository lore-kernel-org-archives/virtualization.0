Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAED9C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 13:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 678E94019E;
	Wed, 21 Dec 2022 13:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 678E94019E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxuPqooZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQFaJWSprpQd; Wed, 21 Dec 2022 13:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F02E7403A7;
	Wed, 21 Dec 2022 13:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F02E7403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B68DCC0071;
	Wed, 21 Dec 2022 13:34:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A6EDC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9386A80BEB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9386A80BEB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxuPqooZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUBJlQSxr2LI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:34:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D064C80BB5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D064C80BB5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671629659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HWvv0yVxWiEaUy/PxGdRu5ElcF4XOZHCSmq8VghIbjU=;
 b=MxuPqooZrJ+X+ulXXQPwktNKyqMK8NOjvBt18RiWnwazPjWTJZN+M1l9o7hmoX/4KfBo9w
 0wF+OSwpJT2rJzYx2moD5axlGVfIk8KCHnisdaXc2QkBSHdKVSrKthpYcv/FcUOpNAC4e+
 g1LblDJnRQnSqG14XAUFMLGvoqMiKbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-u_-uVCT5PIaXA9z7Q2Lhnw-1; Wed, 21 Dec 2022 08:34:18 -0500
X-MC-Unique: u_-uVCT5PIaXA9z7Q2Lhnw-1
Received: by mail-wm1-f72.google.com with SMTP id
 bi19-20020a05600c3d9300b003cf9d6c4016so944980wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 05:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWvv0yVxWiEaUy/PxGdRu5ElcF4XOZHCSmq8VghIbjU=;
 b=M75hfVyA6wVDREXVkIAARm6x6/fcV5L5bKr+ERjmkvooitENTX4sIHXK7JT5y8pE+6
 CmxbYzqE7Az25geM/kUZc3wMub08vKuNLn2PtJpJr6c81Ekv+zos0uUgPCvA+AO87ll8
 L+ltVY++WLJ9JFCa0+Kwk7tOMC8AZ/O8cpXS1Ns816TNqUc07VhWOAzFk4kJhzGBDF/L
 HddexKJBdn/QM8uk1fmJlwfQ3r/UBRlG/QkJH62ghrCHPT3ftEV2YJPFo5fxTeCHYYom
 AiRaIMXrdJ3N0z+nkAM91cLehgCw1OQx2ZfjbSp8zVETyxyKdNSP5NNr1XnZO2Ln2ueO
 CaiA==
X-Gm-Message-State: AFqh2kqG2tgqKFIKPuDNHUEeRZVWutT/JfoUMCv9sDm4cCFp6qbXXLie
 v0nFKsVo+u4M/2MVTCMvKYSkV3Bm2JOFMxzwwFrajkYBePeqhhgcziKI6lT+b3cvj4+/nu97/E9
 u7RcwuYZYCfjABJzLRj2Mft1C91ImJgmCyty/VShz7g==
X-Received: by 2002:adf:d4ca:0:b0:242:1dd6:faa3 with SMTP id
 w10-20020adfd4ca000000b002421dd6faa3mr3206800wrk.23.1671629657455; 
 Wed, 21 Dec 2022 05:34:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt32Wy1vsAsafJ8i+LX0v6mcat5HXfjOVBXGktQWG4rLGZHf1HuDcVnsImxNdMtavFxHzzoxQ==
X-Received: by 2002:adf:d4ca:0:b0:242:1dd6:faa3 with SMTP id
 w10-20020adfd4ca000000b002421dd6faa3mr3206794wrk.23.1671629657255; 
 Wed, 21 Dec 2022 05:34:17 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600016c900b002425dc49024sm15366015wrf.43.2022.12.21.05.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 05:34:16 -0800 (PST)
Date: Wed, 21 Dec 2022 14:34:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] vdpa_sim: support vendor satistics
Message-ID: <20221221133414.teizf56exrf5tqvj@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221221061652.15202-4-jasowang@redhat.com>
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

On Wed, Dec 21, 2022 at 02:16:51PM +0800, Jason Wang wrote:

Little typo in the title s/satistics/statistics

>This patch adds a new config ops callback to allow individual
>simulator to implement the vendor stats callback.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
> 2 files changed, 16 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 55aaa023a6e2..02e892f819e7 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -426,6 +426,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> 	return 0;
> }
>
>+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
>+				struct sk_buff *msg,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+
>+	if (vdpasim->dev_attr.get_stats)
>+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
>+						   msg, extack);
>+	return -EINVAL;

Maybe -EOPNOTSUPP is better when the device doesn't support it.
Like we do in vendor_stats_fill() in drivers/vdpa/vdpa.c

>+}
>+
> static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> {
> 	return VDPASIM_QUEUE_ALIGN;
>@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_vq_ready           = vdpasim_set_vq_ready,
> 	.get_vq_ready           = vdpasim_get_vq_ready,
> 	.set_vq_state           = vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,

Should we add this callback also in vdpasim_batch_config_ops?

Thanks,
Stefano

> 	.get_vq_state           = vdpasim_get_vq_state,
> 	.get_vq_align           = vdpasim_get_vq_align,
> 	.get_vq_group           = vdpasim_get_vq_group,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
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
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

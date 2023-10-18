Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333A6CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 08:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3AF040297;
	Wed, 18 Oct 2023 08:05:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3AF040297
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9qm34hS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0R9_o4sd1BoS; Wed, 18 Oct 2023 08:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD6434016F;
	Wed, 18 Oct 2023 08:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD6434016F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90A56C008C;
	Wed, 18 Oct 2023 08:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC10C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D7BA416B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:05:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D7BA416B5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9qm34hS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CT0s5bMBpfr4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:05:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08D07416A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08D07416A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697616312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oo2WWDvelf9ZpXmn8Aak1z8e708XX+d9Qhv4aD4RB10=;
 b=I9qm34hSchA0KHx01IyJFiOowVODFWFIVFCG0LRkyO33FnvAanMdRRCX8GlBrEJboU9CCg
 rd0LTK6OI/O1wVSRtrsB+q2SIe12lHZLOtipqVBXZ6fbO8xtZ9Dkg2LtskJ9ZSCmeE73U3
 xQonmRbvF01o2jDNhDvEgylrCtZ4xCU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-I7kbWOA9OeifnF-UURA3jw-1; Wed, 18 Oct 2023 04:05:10 -0400
X-MC-Unique: I7kbWOA9OeifnF-UURA3jw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-534543af820so5018353a12.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697616307; x=1698221107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oo2WWDvelf9ZpXmn8Aak1z8e708XX+d9Qhv4aD4RB10=;
 b=NWpzYxRA0loe8PwEqpmoyccH8XtzGJlcEZVnitLtqdvujp0iKrezmwI24yOvdKyfCr
 fzXWe5qm+5eZoHVPa/dCRXwhWyyz4CFMtGY3427K38iAzb9Oh69xH9D+iGGqlAltr1lt
 sdf4P6Hic7FNwePmPwHiQhaxeOZuEG4i30bMwrP9OTgAgX02DgoHW+qWJB1Q5sXHhKs7
 S9HUmvn4SvcieirnouNXhE0R9Pveb0QqREREWTslFdtS9caofABmmw8S1S4149UsR43z
 lYMqa4JU42UkacX6bW4fuZw15+Z3FtuMtTfI/QwOwg4pFuRrM/3ijXlzg/LEHPa13H2w
 CRTQ==
X-Gm-Message-State: AOJu0YwPG5LhRlFn+6CcGK3TOpA+2yLozX6YXdrm/nc/xbUmUJi9wwt8
 8KkouobGJf/e3KD3tFrvwKaDaSY0X9+Uoo7BcWAoOErrSZXsIuE72VGOGaHItxnsXhBAX5feXKX
 gE2QPuiXPp6/ID51ImOclrHPhOiNNnMHP0YO6Jdt9ow==
X-Received: by 2002:a50:8e58:0:b0:53e:72be:2b31 with SMTP id
 24-20020a508e58000000b0053e72be2b31mr2999941edx.42.1697616307572; 
 Wed, 18 Oct 2023 01:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDuei3eKTB65Uz4qXZJ89lMBjiG5Glw5JUyTbr28bRF7oy7Tqap/SHqHaxBWW8wJxzQLQQdw==
X-Received: by 2002:a50:8e58:0:b0:53e:72be:2b31 with SMTP id
 24-20020a508e58000000b0053e72be2b31mr2999928edx.42.1697616307174; 
 Wed, 18 Oct 2023 01:05:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 f19-20020a50d553000000b0053f0e4e0411sm2449088edj.76.2023.10.18.01.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:05:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:05:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Message-ID: <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
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

On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>Works fine with vdpa-sim-net which uses physical address to map.
>
>This patch is based on top of [1].
>
>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>
>Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
>---
>RFC v2:
>  - initialize iotlb to passthrough mode in device add

I tested this version and I didn't see any issue ;-)

Tested-by: Stefano Garzarella <sgarzare@redhat.com>

>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 34 ++++++++++++++++++++++++--------
> 1 file changed, 26 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 76d41058add9..2a0a6042d61d 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -151,13 +151,6 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> 				 &vdpasim->iommu_lock);
> 	}
>
>-	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
>-		vhost_iotlb_reset(&vdpasim->iommu[i]);
>-		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
>-				      0, VHOST_MAP_RW);
>-		vdpasim->iommu_pt[i] = true;
>-	}
>-
> 	vdpasim->running = true;
> 	spin_unlock(&vdpasim->iommu_lock);
>
>@@ -259,8 +252,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	if (!vdpasim->iommu_pt)
> 		goto err_iommu;
>
>-	for (i = 0; i < vdpasim->dev_attr.nas; i++)
>+	for (i = 0; i < vdpasim->dev_attr.nas; i++) {
> 		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
>+		vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
>+				      VHOST_MAP_RW);
>+		vdpasim->iommu_pt[i] = true;
>+	}
>
> 	for (i = 0; i < dev_attr->nvqs; i++)
> 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>@@ -637,6 +634,25 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
> 	return ret;
> }
>
>+static int vdpasim_reset_map(struct vdpa_device *vdpa, unsigned int asid)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+
>+	if (asid >= vdpasim->dev_attr.nas)
>+		return -EINVAL;
>+
>+	spin_lock(&vdpasim->iommu_lock);
>+	if (vdpasim->iommu_pt[asid])
>+		goto out;
>+	vhost_iotlb_reset(&vdpasim->iommu[asid]);
>+	vhost_iotlb_add_range(&vdpasim->iommu[asid], 0, ULONG_MAX,
>+			      0, VHOST_MAP_RW);
>+	vdpasim->iommu_pt[asid] = true;
>+out:
>+	spin_unlock(&vdpasim->iommu_lock);
>+	return 0;
>+}
>+
> static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm)
> {
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>@@ -759,6 +775,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_group_asid         = vdpasim_set_group_asid,
> 	.dma_map                = vdpasim_dma_map,
> 	.dma_unmap              = vdpasim_dma_unmap,
>+	.reset_map              = vdpasim_reset_map,
> 	.bind_mm		= vdpasim_bind_mm,
> 	.unbind_mm		= vdpasim_unbind_mm,
> 	.free                   = vdpasim_free,
>@@ -796,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> 	.get_iova_range         = vdpasim_get_iova_range,
> 	.set_group_asid         = vdpasim_set_group_asid,
> 	.set_map                = vdpasim_set_map,
>+	.reset_map              = vdpasim_reset_map,
> 	.bind_mm		= vdpasim_bind_mm,
> 	.unbind_mm		= vdpasim_unbind_mm,
> 	.free                   = vdpasim_free,
>-- 
>2.39.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

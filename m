Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8BDC7EE22
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 08:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3199E6FFBC;
	Tue,  9 May 2023 08:46:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3199E6FFBC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UD4HB89K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dxXHOLqQRH1y; Tue,  9 May 2023 08:46:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B18F0614CD;
	Tue,  9 May 2023 08:46:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B18F0614CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84ECCC0037;
	Tue,  9 May 2023 08:46:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA8B3C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD50A41E12
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD50A41E12
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UD4HB89K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ZgJAyt3UY8M
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:46:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C732E41E10
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C732E41E10
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683622001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RhKNMItEtTuMdZyhTECnoHKaw93uUHrSGNdFhEj8k08=;
 b=UD4HB89K4Ndg9mDdB/x6RC5MUVLDbhs9B0alW8fIH/UjvyNHC8I54KXaeSrAuFBb3Xb143
 2WHMqE2coESnVN8IwFW+ZKLIpEGZ4P9y13F1kE+IguQ5kDLdhzFYhecmrJOBsHQjUKQe5T
 YBxDRkvcK/bNTuHlXKjWuTcnPAY5PZQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-nvBXMzEaMWyG6_Ck4uelPA-1; Tue, 09 May 2023 04:46:40 -0400
X-MC-Unique: nvBXMzEaMWyG6_Ck4uelPA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3063394ae41so1902072f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 01:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683621999; x=1686213999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhKNMItEtTuMdZyhTECnoHKaw93uUHrSGNdFhEj8k08=;
 b=LyCA+B4NxyOurf7rr0fGF2J6v7jMCZqFxKCzExkMB40L9rwOgUW4C6MXGID7aVo1rl
 uRvHY3WewpER7F3a7bZuCB27Jfj5V/VIU68EIOfGvKhQ98R1L183jRZsiYkL3sfMsIIU
 V/NNUwpihhNVNi9T38tA6LUVbtKKExRn2wnKjejhPGhDh7q/cQHMjtaizrmekY1LzDWp
 eUweghioJYUFeCaozRBnvhyaq2o7wp/x8BHTVMttsCitMcz3HQr5Jr2CLGcBqeKxOP0Q
 0ZoeCjy7bMmRzdyj7+86PbYwNgck53ckvAExJEWfV3vaCALvR4KCyDWcONd3XbvOhLKv
 /oiQ==
X-Gm-Message-State: AC+VfDyHgoA4u0/YPaGIMP847LPj+xOb5xjxLPWU3q0x1VcRPWtiVg/O
 p6NvG+1Lrh/futo3LP/Meq+C1akZG8BPB+ZOvyJ9gcwwCNHjlZKKC6UolY7nP40cBBeg50T6Ues
 Ab4ZXwR4g9+wiK2En5xVd2yAEcTahpVqtRlcHJ0lmdA==
X-Received: by 2002:adf:e84e:0:b0:306:35fa:202b with SMTP id
 d14-20020adfe84e000000b0030635fa202bmr8476851wrn.6.1683621999460; 
 Tue, 09 May 2023 01:46:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QeIIsYICP5JQn9Bwsh3ux/FPY4MjMXCVSOPwBEhiX1wntXGr3vuFJXaFHQTgNUbbqYMzpvA==
X-Received: by 2002:adf:e84e:0:b0:306:35fa:202b with SMTP id
 d14-20020adfe84e000000b0030635fa202bmr8476842wrn.6.1683621999159; 
 Tue, 09 May 2023 01:46:39 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.186.144])
 by smtp.gmail.com with ESMTPSA id
 x10-20020adfffca000000b002e61e002943sm13598710wrs.116.2023.05.09.01.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 01:46:38 -0700 (PDT)
Date: Tue, 9 May 2023 10:46:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230424225031.18947-3-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io,
 mst@redhat.com
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

On Mon, Apr 24, 2023 at 03:50:30PM -0700, Shannon Nelson via Virtualization wrote:
>Use the right structs for PACKED or split vqs when setting and
>getting the vring base.
>
>Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>---
> drivers/vhost/vhost.c | 18 +++++++++++++-----
> drivers/vhost/vhost.h |  8 ++++++--
> 2 files changed, 19 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index f11bdbe4c2c5..f64efda48f21 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1633,17 +1633,25 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> 			r = -EFAULT;
> 			break;
> 		}
>-		if (s.num > 0xffff) {
>-			r = -EINVAL;
>-			break;
>+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>+			vq->last_avail_idx = s.num & 0xffff;
>+			vq->last_used_idx = (s.num >> 16) & 0xffff;
>+		} else {
>+			if (s.num > 0xffff) {
>+				r = -EINVAL;
>+				break;
>+			}
>+			vq->last_avail_idx = s.num;
> 		}
>-		vq->last_avail_idx = s.num;
> 		/* Forget the cached index value. */
> 		vq->avail_idx = vq->last_avail_idx;
> 		break;
> 	case VHOST_GET_VRING_BASE:
> 		s.index = idx;
>-		s.num = vq->last_avail_idx;
>+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>+			s.num = (u32)vq->last_avail_idx | ((u32)vq->last_used_idx << 16);
>+		else
>+			s.num = vq->last_avail_idx;

The changes LGTM, but since we are changing the UAPI, should we
update the documentation of VHOST_SET_VRING_BASE and
VHOST_GET_VRING_BASE in include/uapi/linux/vhost.h?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

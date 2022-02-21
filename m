Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D964C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 16:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D708280AC7;
	Mon, 21 Feb 2022 16:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kz7tJPNA4cGK; Mon, 21 Feb 2022 16:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 62C1881656;
	Mon, 21 Feb 2022 16:48:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35B32C0021;
	Mon, 21 Feb 2022 16:48:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA45AC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C313540353
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGIzR0Zp6EvX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:48:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D08AF4034F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645462105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugkg/6bHK4I9I6rQyjp9bnBEEpgwBXrQHXcejLYuUBI=;
 b=TCt6nLqKZXMUyt3fchC9FTcj+JClyNHq16U2YkbmKPbVrKwkguK/KMqc/FxgoJU5W9ilJh
 0GDQRLizGLBDQVNT/apSUsCPOCGgZ/des/ylaDL/755sid1rq4+zOlvViWzqiH612xXV3d
 4ZqPv6Dhu13Vy7UV7wq1gohOK5OP8Xc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569--uvoVOLrOnmTTv5aJQCxww-1; Mon, 21 Feb 2022 11:48:23 -0500
X-MC-Unique: -uvoVOLrOnmTTv5aJQCxww-1
Received: by mail-qv1-f71.google.com with SMTP id
 hu9-20020a056214234900b0042c4017aeb3so17769116qvb.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 08:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ugkg/6bHK4I9I6rQyjp9bnBEEpgwBXrQHXcejLYuUBI=;
 b=3tqBF6c3bTps8FA7LDoV3SDPhHXN8J9zrOHcLuU9a3iRwIrr7E5od54A79R/U9aqfn
 bJ1vwb61zOD6yL+9oHd+7OhnIALjb+LTPF8MFyR0m9CH+cP0kSF8ye7oBg/vCMFD/dxq
 q9DxQcY2CY6oDZSBcpqz0pIMMqlxhIboosZzMkhX9oTQ/a/2xXWtLb6LhUQ4rvO3FVmB
 U9b7CZeG1FiMvRr25oCN0V2lh2cYdZcCfHHbG2937EB0Wo+hvLB99D3Xf6bUgHrJKHoL
 Wv49g5Sgv7PXti9g8oIH8Baqregfdqx+Ns1SNI70lqDaucCWJNGOyT6b1pTDztlNDt2U
 WGzQ==
X-Gm-Message-State: AOAM530GADWqbwhfE8WX3zaMZNDPOeSiyb23Vu8AkjMJNG8+17+mkO61
 3FGK6Ip+J+u78UvtRtbtueZU+C7kW4WGzXlWko7nUF+fu6bOxBFvmIDzjRmsHg26jXnsKpyqscd
 wtZblhFhWYSuT+tBXeKUzXgI277jYDBargMO7fh0+ew==
X-Received: by 2002:ac8:5e48:0:b0:2dd:aae2:9163 with SMTP id
 i8-20020ac85e48000000b002ddaae29163mr13786996qtx.95.1645462102878; 
 Mon, 21 Feb 2022 08:48:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFv1gdovuCvIHcpiRkTUusMpouueO/kTbQ3gip4zmAzUzlcfKIHRaFuNGZVTP437Hqjr+tcA==
X-Received: by 2002:ac8:5e48:0:b0:2dd:aae2:9163 with SMTP id
 i8-20020ac85e48000000b002ddaae29163mr13786978qtx.95.1645462102586; 
 Mon, 21 Feb 2022 08:48:22 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id e3sm7388100qto.25.2022.02.21.08.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 08:48:21 -0800 (PST)
Date: Mon, 21 Feb 2022 17:48:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost: handle zero regions in vhost_set_memory
Message-ID: <20220221164817.obpw477w74auxlkn@sgarzare-redhat>
References: <20220221072852.31820-1-mail@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <20220221072852.31820-1-mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
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

On Mon, Feb 21, 2022 at 12:58:51PM +0530, Anirudh Rayabharam wrote:
>Return early when userspace sends zero regions in the VHOST_SET_MEM_TABLE
>ioctl.
>
>Otherwise, this causes an erroneous entry to be added to the iotlb. This
>entry has a range size of 0 (due to u64 overflow). This then causes
>iotlb_access_ok() to loop indefinitely resulting in a hung thread.
>Syzbot has reported this here:
>
>https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87

IIUC vhost_iotlb_add_range() in the for loop is never called if 
mem.nregions is 0, so I'm not sure the problem reported by syzbot is 
related.

In any case maybe this patch is fine, but currently I think we're just 
registering an iotlb without any regions, which in theory shouldn't 
cause any problems.

Thanks,
Stefano

>
>Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
>Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>---
> drivers/vhost/vhost.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 59edb5a1ffe2..821aba60eac2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1428,6 +1428,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
> 		return -EFAULT;
> 	if (mem.padding)
> 		return -EOPNOTSUPP;
>+	if (mem.nregions == 0)
>+		return 0;
> 	if (mem.nregions > max_mem_regions)
> 		return -E2BIG;
> 	newmem = kvzalloc(struct_size(newmem, regions, mem.nregions),
>-- 
>2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

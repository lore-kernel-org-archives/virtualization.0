Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49181C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBF1440BFE;
	Wed,  8 Mar 2023 14:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBF1440BFE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P9XLOuMV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JUUn33DUr3aA; Wed,  8 Mar 2023 14:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2968940242;
	Wed,  8 Mar 2023 14:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2968940242
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00813C0071;
	Wed,  8 Mar 2023 14:17:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61B6060C09
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61B6060C09
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P9XLOuMV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUDkFF5xb05S
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7369660A77
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7369660A77
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678285064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttecRVaLcokGkQnpMMD3LNLXwWSTcMNNpaM+wYM2sIQ=;
 b=P9XLOuMVEysruAnCVh63L3K+e+nhI3rwvWYc85VoUXMJfX4U2Xfbjxp1fssNe8LbLJGhdk
 FtwOjuZWfS+9Jd4HYQfHNnxWd/6kOMJClPsLCdcmzljiaSCid0UeCXM+IrOYQV0hgnwNWb
 PSYYUADtwwCOZ7AeiyLpOWftkjl7F0A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-alRPNyHQOtmRqu0yle9yyg-1; Wed, 08 Mar 2023 09:17:43 -0500
X-MC-Unique: alRPNyHQOtmRqu0yle9yyg-1
Received: by mail-qk1-f200.google.com with SMTP id
 8-20020a370508000000b00724fd33cb3eso9416809qkf.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678285062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttecRVaLcokGkQnpMMD3LNLXwWSTcMNNpaM+wYM2sIQ=;
 b=CUtY9YsURekKaKVc01uXSvxlGSSH0Dy0EltpbceeuZ81+A0F7G6byseSAAWw9IcWpe
 TIUo8bfc3XUzt4vrd9Rnu/PH0ga0yfVZob5k6SSA9YUeJFtDt/jJRFs24gjUUXz8Udqj
 +TXN4b6WAn9dRtzWmmAZmjgtVDaxhuD4hzH5AAvrRWL+T6xMTIViTRIE1NvTb6iHh4/S
 3fi55/KG0KYzf6ftXa55/xzd7iFxatEf3oyei2H8lH6qIfuY6A0973pQpQqCADUOaccn
 iZtQtee9NZ2blGAq1cZ172QbNdnFaFtF8AlCpeR2Aho9W3w1GsYvlItEdCnw4zRoSXIe
 fAfQ==
X-Gm-Message-State: AO0yUKX/msMr6pq+GYgSUYbOsk44lYL/jkZM1YxdakHwFyvUFpYVxmDc
 uGr2Ap7xdq007os60fhmHjdEbfdz1RPDkBLKwbXs7JCt84X/MTTN4nLO6L/+K6m/HCUKMuUeFgY
 HQUu9D8mZHXjkIFniz8jUDVpM1mZkNrwV8hd2g2uE7A==
X-Received: by 2002:ac8:5f4f:0:b0:3bb:8a14:badd with SMTP id
 y15-20020ac85f4f000000b003bb8a14baddmr32533620qta.29.1678285062638; 
 Wed, 08 Mar 2023 06:17:42 -0800 (PST)
X-Google-Smtp-Source: AK7set9vFABDqE96MkgXNbZHat3oPZ5tvsXBqvU9/f0sBWiq54XK/Fphhn5yZSGJuDf8rbsfS4nA+g==
X-Received: by 2002:ac8:5f4f:0:b0:3bb:8a14:badd with SMTP id
 y15-20020ac85f4f000000b003bb8a14baddmr32533583qta.29.1678285062353; 
 Wed, 08 Mar 2023 06:17:42 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 a18-20020ac84352000000b003bfaff2a6b9sm11697660qtn.10.2023.03.08.06.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:17:41 -0800 (PST)
Date: Wed, 8 Mar 2023 15:17:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Message-ID: <20230308141737.ioxvifnarhluafmh@sgarzare-redhat>
References: <tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
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

On Fri, Feb 24, 2023 at 10:30:30PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. At the same time, the code indentation issue was fixed
>and virtio-trace/trace-agent was added to .gitignore.

Thanks for this cleanup, but you mentioned 3 independent things that
this patch does, so it would be better to split it into 3 separate
patches.

>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/.gitignore    | 1 +
> tools/virtio/virtio_test.c | 6 +++---
> 2 files changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
>index 075588c4da08..9934d48d9a55 100644
>--- a/tools/virtio/.gitignore
>+++ b/tools/virtio/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> virtio_test
> vringh_test
>+virtio-trace/trace-agent
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..6370cdada396 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -134,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 	dev->buf_size = 1024;
> 	dev->buf = malloc(dev->buf_size);
> 	assert(dev->buf);
>-        dev->control = open("/dev/vhost-test", O_RDWR);
>+	dev->control = open("/dev/vhost-test", O_RDWR);
> 	assert(dev->control >= 0);
> 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
> 	assert(r >= 0);
>@@ -142,7 +142,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> 			  sizeof dev->mem->regions[0]);
> 	assert(dev->mem);
> 	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>-                          sizeof dev->mem->regions[0]);
>+			sizeof dev->mem->regions[0]);

This did not seem to me to be an indentation issue, there are 2 tabs and
1 space to line it up with the opening of the parenthesis of the line
above.

> 	dev->mem->nregions = 1;
> 	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
> 	dev->mem->regions[0].userspace_addr = (long)dev->buf;
>@@ -361,7 +361,7 @@ int main(int argc, char **argv)
> 			break;
> 		case 'h':
> 			help();
>-			goto done;
>+			exit(0);

Maybe we can move the exit() directly into the help() function and 
remove it from case '?'.

I would return a value different from 0 (like in the case '?').

Thanks,
Stefano

> 		case 'i':
> 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

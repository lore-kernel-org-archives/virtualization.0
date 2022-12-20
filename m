Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E97C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 11:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 176C2405F2;
	Tue, 20 Dec 2022 11:32:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 176C2405F2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Afa6aH9w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oYm__zuo6MGn; Tue, 20 Dec 2022 11:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B83B40198;
	Tue, 20 Dec 2022 11:32:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B83B40198
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 718EEC0032;
	Tue, 20 Dec 2022 11:32:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 450BC405F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:32:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 450BC405F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fb2iDXiiZoP9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:32:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5063440198
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5063440198
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671535920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a+5y93f4CEM76hoZILajwanmAtm9yvjPLzZAIqF7iI=;
 b=Afa6aH9wq359acAj7TBklxSdIl2YH430rgt4RMh98kikR0Ew3gnf/QUSpxgd1KmvOE6bD0
 KfsXqRMWGjNgi9apgjnW8vK7ltGkwmHLocSR7Ptu5CjykQ23r4SmhU9VRGPvPKFHSKhUEE
 dD71/+iQ8jw4dG4rbgWkc9B95CPpV1U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-qM_4uZrYPUWHPCxXapYuBA-1; Tue, 20 Dec 2022 06:31:58 -0500
X-MC-Unique: qM_4uZrYPUWHPCxXapYuBA-1
Received: by mail-qt1-f200.google.com with SMTP id
 l11-20020ac8148b000000b003a81fbc3b3bso5370958qtj.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 03:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7a+5y93f4CEM76hoZILajwanmAtm9yvjPLzZAIqF7iI=;
 b=rrsfj0UdkQCy1EQ5e8WL+xCgMc7g/A6FBCaLRyyTwV+4U0qhg3cPIt4IZvF8z8FgGZ
 BbLU+q76YxJhN9lRPcqp3mgDB8RTiSmJxqDbILQq+ulP2XhICv8rBI8HrYCsxC4RHjiu
 iErwhDr3QXdUjVriA42mnDJDaY9ms0HD0NTdGHrT80egX2LKJfHjpPASRbqexSd8GWYI
 Zdeg786Yda9QWi46cRFIdwSJ4T7HprpcS683ymHUksMBOsdRT6G6J2M7ZYXTeBj1fifC
 sF57OssF8VB+Eo6GXyz4DNCyxw98vM/pF1kp0cPnBKEYqSeOQPfv6hki2ap/R70ofLZH
 ogwg==
X-Gm-Message-State: ANoB5pkVlvyBtTXiF9fjGEdyQbTJsH1UQAbBNAEEVHG7R95YeEN/j5D4
 iJEZ8sWeNaU7GQYCM2ym9T08OeoI8yfpXY//Jbhiqu6hZ5r2LCfvBlx/Cei5h22kK13ZsVwp8eP
 AmDrZh/ZtzKddCCm+PQGSR8kPuhMZx+XZL8fLGeTNvg==
X-Received: by 2002:ac8:424e:0:b0:3a8:5d1:aabc with SMTP id
 r14-20020ac8424e000000b003a805d1aabcmr59492059qtm.15.1671535918372; 
 Tue, 20 Dec 2022 03:31:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4a4jDyD3P5OwsykxW14REihYDnY2vGZWD9Tg3lxnTugFQl9sEJVa6wbIZy/GZFfmMP4VKikQ==
X-Received: by 2002:ac8:424e:0:b0:3a8:5d1:aabc with SMTP id
 r14-20020ac8424e000000b003a805d1aabcmr59492035qtm.15.1671535918082; 
 Tue, 20 Dec 2022 03:31:58 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 y23-20020ac87097000000b003a50b9f099esm7358183qto.12.2022.12.20.03.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 03:31:57 -0800 (PST)
Date: Tue, 20 Dec 2022 06:31:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH v3] virtio: fix virtio_config_ops kerneldocs
Message-ID: <20221220063049-mutt-send-email-mst@kernel.org>
References: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 20, 2022 at 12:29:43PM +0100, Ricardo Ca=F1uelo wrote:
> Fixes two warning messages when building htmldocs:
> =

>     warning: duplicate section name 'Note'
>     warning: expecting prototype for virtio_config_ops().
>              Prototype was for vq_callback_t() instead
> =

> Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.auu=
g.org.au/
> Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com> =


I merged v2 already - squashed it in so Fixes isn't necessary.
I dropped Link: as well, probably going overboard for a fixup.

> ---
> Changes in v3:
>   - Added a Fixes tag referencing the commit that revealed the warning
>     messages (suggested by Bagas Sanjaya and Michael S. Tsirkin)
> =

> Changes in v2:
>   - Reword the "Note" comment in the kerneldoc so that it doesn't look
>     like a kerneldoc "Note" section (suggested by AngeloGioacchino Del
>     Regno)
>   - Link, Reported-by and Reviewed-by tags added (suggested by Bagas
>     Sanjaya)
> =

>  include/linux/virtio_config.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4b517649cfe8..2b3438de2c4d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -16,8 +16,10 @@ struct virtio_shm_region {
>  	u64 len;
>  };
>  =

> +typedef void vq_callback_t(struct virtqueue *);
> +
>  /**
> - * virtio_config_ops - operations for configuring a virtio device
> + * struct virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
>   *       getting/setting a value as a simple read/write! Generally speak=
ing,
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
> @@ -69,7 +71,8 @@ struct virtio_shm_region {
>   *	vdev: the virtio_device
>   *	This sends the driver feature bits to the device: it can change
>   *	the dev->feature bits if it wants.
> - * Note: despite the name this can be called any number of times.
> + *	Note that despite the name this	can be called any number of
> + *	times.
>   *	Returns 0 on success or error status
>   * @bus_name: return the bus name associated with the device (optional)
>   *	vdev: the virtio_device
> @@ -91,7 +94,6 @@ struct virtio_shm_region {
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also =
be
>   *	set.
>   */
> -typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);
> -- =

> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

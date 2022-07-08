Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D8AC433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 06:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FAB9845C9;
	Fri,  8 Jul 2022 06:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FAB9845C9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9j2U3Mk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6Zllme2dHAU; Fri,  8 Jul 2022 06:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE1588453C;
	Fri,  8 Jul 2022 06:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE1588453C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD9EFC0035;
	Fri,  8 Jul 2022 06:00:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8137FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54201612EE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54201612EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q9j2U3Mk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TxbYOwOYBAnO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 717D260B55
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 717D260B55
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657260024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VdKKna492ZuNX3D+72shOPOSeJ4spzTkUN1n9gAILF4=;
 b=Q9j2U3MkyGW/sm032uaKhtBM5Hk930wXpnvDoMgHKcRnhXtY1zqaFY4G2d3/BggxSSTvK7
 feM+rOy5lO/3UTDbVfahJRfURQwCdlBzGM31+g/Nt29DLYVWYuy7lkjdn/7dpgHdsuqU89
 3Rq9hIM/oCPo3U74uIA4QtUVGgUYNCw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-nxssWFdEMLecaCzFz3PcTQ-1; Fri, 08 Jul 2022 02:00:22 -0400
X-MC-Unique: nxssWFdEMLecaCzFz3PcTQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 y35-20020a0565123f2300b0047f70612402so7349863lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jul 2022 23:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VdKKna492ZuNX3D+72shOPOSeJ4spzTkUN1n9gAILF4=;
 b=7pV2zR726ky4EouepDORhXXVwnPVtW0rbj7aC9ekHfTFdMR6SRNqTVGzrNnI3A7lmA
 Cq5SMGeVS09kNMrQ64kY96EAgiE6PC1lgATyf3KGHrFEoaykL2uveXjWPkh3QXqIW99a
 FSU7x1jzIT+2o29MDQa0z6WPMVCce4i32WbrEjYoKrXkhCBYIEgEttgNh4LTuLPKgY0a
 swGO83SCRXV1CeERrxeHwLpaaqfqoXKpz0RubdFlD2QY7mgB2KAd7qEd/nGmFRQ8tNrt
 qoxAbNX+nvZM84D9wGo7oYXEhpOUKdu6PsOsDUtRmLGo4rH1o7nvzc4HhZYzy2R2GlsS
 /Tow==
X-Gm-Message-State: AJIora9K0XU1H3jxyR/wTPOQJNSGtEMa4WmUXQuFMiFiEIVLWH2peE5D
 7hkPWI3o+kY7dhY2hg1IK8dDk4Se/lYiUr/BdHbdG9XCNQpxfMeVrzlRC/TrVXziB0MJs9M1uqJ
 /mBmOqaJ7GeYVRUAaKPbV07eS8s7vJw5qixl/n/EHBaT7WHJyw+ROoB3LEQ==
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr1326050lfv.641.1657260021395; 
 Thu, 07 Jul 2022 23:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOMJxokEf+TWe5wm0bW58Mnjk/5eCF7RONI4FfMSWrXOFRWLD7jzXM+KMEOGYRQ6ibDZ1CxMIyr37UhTtOQBA=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr1326040lfv.641.1657260021184; Thu, 07
 Jul 2022 23:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220707031751.4802-1-liubo03@inspur.com>
In-Reply-To: <20220707031751.4802-1-liubo03@inspur.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 14:00:09 +0800
Message-ID: <CACGkMEujMgP=QbQte6Hjv2DXp7TYJXQvu8uK3=h130pcr6eYsg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Check dev_set_name() return value
To: Bo Liu <liubo03@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Thu, Jul 7, 2022 at 11:18 AM Bo Liu <liubo03@inspur.com> wrote:
>
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 7deeed30d1f3..ddd4466da83b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -428,7 +428,9 @@ int register_virtio_device(struct virtio_device *dev)
>                 goto out;
>
>         dev->index = err;
> -       dev_set_name(&dev->dev, "virtio%u", dev->index);
> +       err = dev_set_name(&dev->dev, "virtio%u", dev->index);
> +       if (err)
> +               goto out_ida_remove;
>
>         err = virtio_device_of_init(dev);
>         if (err)
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

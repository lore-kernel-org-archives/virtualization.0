Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DC8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 02:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97382605B3;
	Fri, 29 Apr 2022 02:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dqlWkSHFiQK; Fri, 29 Apr 2022 02:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37A56606CB;
	Fri, 29 Apr 2022 02:46:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01ADEC0032;
	Fri, 29 Apr 2022 02:46:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6438EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D1FC40165
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lboysKKDywCM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:46:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DDE3400A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651200414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2gx7h6NbYu8uuTSJ9N8wCp852RvTqnX9mX9jiXJyBc=;
 b=e6TN7QFmlfQ6b81tLKKQIDoYw2a/kYs6y7Cr1q96xBj4PbaXIJR2SeXKyqmBJ68u1DAnci
 xnnhyXSe2suPMk+mGPH6lZXbTGSVc51Gfab7VO6a1aohjyKsbVqfSosy4O23YgHgUKcTog
 AfPRybVfDJZuPOK4omVQ6KgMSZXR3k4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-x4DTziG4OH-LPi5okrgwqA-1; Thu, 28 Apr 2022 22:46:52 -0400
X-MC-Unique: x4DTziG4OH-LPi5okrgwqA-1
Received: by mail-lf1-f72.google.com with SMTP id
 d4-20020a05651221c400b0046ba0689478so2738359lft.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 19:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L2gx7h6NbYu8uuTSJ9N8wCp852RvTqnX9mX9jiXJyBc=;
 b=BUk2TgHgtiPuOcKU+7YQBL4gry80I5PXZnHBf+fzVKEZ1l3YaZO28eMoZ/E0FT9Kad
 ItcpUb8+vvnsG1YnLFDCn67DgQbBfc0GDcpaakiYj171IQyLAz6iFLCctiV2/15RVjRq
 BfJNsev9vUeBFZkSZ+sCw75au2a//ebMOVjrjq7bv1t51A5kJc/v1dYLdd6ya0DYOywa
 fihhWktxtss2hQgXMnXf9yEiWZizM8Avhp71+IMpaycld/xOMuKnKiWNAv8bJkGQ4LSV
 0W4brC/gilKtxptAVLv1otQoQtVgmJHG39XBmODpAWfFZwq9rEd8EYSjVdypgg8gUZZd
 u0rg==
X-Gm-Message-State: AOAM530saEzQ3AVaIJVlCBEHDelVAzF796PJDSLp3Xk4BXWuJrH2y4dq
 fYlO9HCwZ9s7IWxvSvVtT5BJCmtygU6mEgUYJ0gR0OD/7lGVxYWqT0WBMq6lSmNS3iVFfms2TUX
 prflz7gsLrjO7KWCdXs/eeiNKZgmJ1N9bsMdOPsdfhc/JvRladhuNDecHSw==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22046664lfj.587.1651200411380; 
 Thu, 28 Apr 2022 19:46:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6iPLLBUifBPvjONr1Ab9ze/wQ5cB0TwkyM+p9qr7gp7ho++cFBXhVIBCz1e5TwUXO7O0QeVLJ2MLAvlTw4Ac=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr22046647lfj.587.1651200411210; Thu, 28
 Apr 2022 19:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com>
In-Reply-To: <20220428151242.213824-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Apr 2022 10:46:40 +0800
Message-ID: <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> The simulator behaves like a ramdisk, so we don't have to do
> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> could be useful to test driver behavior.
>
> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> that we support the flush command.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..a6dd1233797c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -25,6 +25,7 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 pushed += bytes;
>                 break;
>
> +       case VIRTIO_BLK_T_FLUSH:
> +               if (sector != 0) {
> +                       dev_err(&vdpasim->vdpa.dev,
> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> +                               sector);

If this is something that could be triggered by userspace/guest, then
we should avoid this.

Thanks

> +                       status = VIRTIO_BLK_S_IOERR;
> +                       break;
> +               }
> +
> +               break;
> +
>         default:
>                 dev_warn(&vdpasim->vdpa.dev,
>                          "Unsupported request type %d\n", type);
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

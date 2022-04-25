Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98417C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 09:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20EF860AC0;
	Mon, 25 Apr 2022 09:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n45ubYGTmtXh; Mon, 25 Apr 2022 09:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3AA360615;
	Mon, 25 Apr 2022 09:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7691AC0032;
	Mon, 25 Apr 2022 09:00:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8D5EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 915508145E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLJhEoHjhSfS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B291881450
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650877200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QoTWwUG44ZKREs24srdlBz4+nuuWL7M2R9CG+RWwjCM=;
 b=AvHd2uJQ/ns7geJALpoa5nSM9lBckk3XaOX0uE6cKBflPEWm7rqvg22AWjbjwAe4qp6hPZ
 SrJ6TnoQR+2xQNfPUaEayPOQRvouBr5opuWpUtapRThoPiotDnPoWm47ULvoXBIwpzU51S
 kJv6PW2kfqS2pxO4edIFrd8/s1MSW8w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-kawgIkBANdeqZM_hcWLRww-1; Mon, 25 Apr 2022 04:59:58 -0400
X-MC-Unique: kawgIkBANdeqZM_hcWLRww-1
Received: by mail-lf1-f72.google.com with SMTP id
 b33-20020a0565120ba100b004720174b354so1374410lfv.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QoTWwUG44ZKREs24srdlBz4+nuuWL7M2R9CG+RWwjCM=;
 b=dCMNaI9xiu5fhETsW4su1ubrOj9xTeyVT71I66NrSf//OfNj05n9xSmP3qJvDZmJes
 k6F/7U35LDiKGLi70zJHDdpEYc9uMEYl4jgWColaFUuuzqBTZr6o5OuhNtjxXzyk6M56
 Zk3mOwYOmDyIQcBDgTVKOdFAhJMziNPNDqinGgQLWSJnUX+nSGx321yGijm53uK65zew
 0ytsm4+mWeV3KeQ18xCa+uvZqzkgJeZa8e3CqJXDURqHgJXymkAFOX+jlPR2cbcXovNP
 YfmfZu8ZmS3VBbF/2VjVUA+MArGBTzLytu9SWs/asE7Ev9dp63ruEJLaKhYDVMhtRtSY
 WS8w==
X-Gm-Message-State: AOAM532bSkzlUmqX/WRVKfJ2NYrIc6ONfPadwqhDkSjo4uahr0A32qv/
 V3+bseDYR7IXx/NGUz43EsdY4hylV1XyVZ19DiWEcjAF3pEQsF23e4jnSujG9FsnwdirHTr7KVf
 oY8w1wCFtVkzPWU7t5YR5qWmIKayt3r49QtYsro6BGsIv7lxShiZ5tgFIFA==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr8263990lfj.587.1650877196647; 
 Mon, 25 Apr 2022 01:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlYpVuOzIkIA+vc2xFy0TnS5ZsUxhcqSLHkTFpvCIBbhfh/tNsQlp8CDlTy9fsTg2OmIpnYGAbNnBRZJXk/LI=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr8263984lfj.587.1650877196461; Mon, 25
 Apr 2022 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com>
In-Reply-To: <20220425062735.172576-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Apr 2022 16:59:45 +0800
Message-ID: <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct
 vdpa_mgmt_dev
To: Cindy Lu <lulu@redhat.com>
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

On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
>
> To support the dynamic ids in vp_vdpa, we need to add the check for
> id table. If the id table is NULL, will not set the device type
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1ea525433a5c..09edd92cede0 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -492,10 +492,13 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>         if (err)
>                 goto msg_err;
>
> -       while (mdev->id_table[i].device) {
> -               if (mdev->id_table[i].device <= 63)
> -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
> -               i++;
> +       if (mdev->id_table != NULL) {
> +               while (mdev->id_table[i].device) {
> +                       if (mdev->id_table[i].device <= 63)
> +                               supported_classes |=
> +                                       BIT_ULL(mdev->id_table[i].device);
> +                       i++;
> +               }
>         }

This will cause 0 to be advertised as the supported classes.

I wonder if we can simply use VIRTIO_DEV_ANY_ID here (and need to
export it to via uAPI probably).

Thanks

>
>         if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

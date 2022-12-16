Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AEBC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 06:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3FE8610A2;
	Fri, 16 Dec 2022 06:38:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3FE8610A2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwR1Ojvh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNZXxy0jFM9y; Fri, 16 Dec 2022 06:38:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5102060ABE;
	Fri, 16 Dec 2022 06:38:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5102060ABE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 254AEC0032;
	Fri, 16 Dec 2022 06:38:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E50EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C304041B63
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C304041B63
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwR1Ojvh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l9jrOBm8AmyX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:38:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B54CC41B62
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B54CC41B62
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 06:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671172686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cW+bMkU3xKEQP1YgUGCBEYHN1PIY0xAoXY4S8XVaLQU=;
 b=AwR1Ojvhu7nInGfWWJslUeIYkQg+SUt8swys4+dBV0LaLGlHnnkuS4h9ESXT4WWyUVxaF0
 I59CRWWk2Ugz18qCfqEr8tV3+oM/0IxdbDNhYdyJ8DgMvgbOe0zPSzuwVF7khMy8eZ9SnB
 3OOHgUHZxKrXNs2nYtGQ9qXSaON6OYo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-k_W9VB76MVGE5xaHQ1O8qQ-1; Fri, 16 Dec 2022 01:37:57 -0500
X-MC-Unique: k_W9VB76MVGE5xaHQ1O8qQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1437fb9949bso886835fac.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 22:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cW+bMkU3xKEQP1YgUGCBEYHN1PIY0xAoXY4S8XVaLQU=;
 b=a8j4x/tajmK0K1oePV1ju8aVbKwX8JNtvVfHRHVDPUM/UH/hHTgSGJwLK418MOT0CA
 qzlgVNrgXw6jrWei5Tl4B9z+mW5sU1nTPDWXnk6GOu2OM73PFMkAAI/IGd4vXLafo51N
 vjMPQWHvcJ2NcqbfJXbMuIcKOXNyOvmdTUvMBiVTmOOkWiLJBGXdQefUbTI6wKYr8RqM
 klIt0OBDBTOaeocyBfUWbdJRrBAkwqWtDbs7EiW3iN23b7xPXkjc8j9VTdZSpcHeAHnO
 7C8FcoYbZGH5K+FNFjjzxq0OyH44zKhrpFkDIhPKluTVgCbhbWRyBC3SAp3rkcy1KTlx
 ZTeg==
X-Gm-Message-State: ANoB5pm/fDiuJHETOP/EH83RJSeUKmXsCD0qewznVWxrF7ab4DoR4NdV
 T+eynPnSxNyxt93RZWWWQPLvmtO58KlIu9u6zqV1x+29/r0Wd0IAUTc9dd+RbkI5DzO1e63SoNj
 Uazwv8fURZPyavoFP65wqb0J738gSo1/KFrOBRj1Z2FcttVyXY48ncdsXYg==
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49193591otb.237.1671172677032; 
 Thu, 15 Dec 2022 22:37:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PhTxuonWvI42K1r5SXMHOGp2WDwmjdYkpdHeokdA1/uGUJSSB1rwFi/vqD7g24urRxtB6k7iCChL5ArMsm2Q=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49193583otb.237.1671172676778; Thu, 15
 Dec 2022 22:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20221214163025.103075-1-sgarzare@redhat.com>
 <20221214163025.103075-2-sgarzare@redhat.com>
In-Reply-To: <20221214163025.103075-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 14:37:45 +0800
Message-ID: <CACGkMEtB6uQ_6fKU5F-D0vG+gQz9mMdYWUQwre-yp1sVpGvKPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] vdpa: add bind_mm callback
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

On Thu, Dec 15, 2022 at 12:30 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This new optional callback is used to bind the device to a specific
> address space so the vDPA framework can use VA when this callback
> is implemented.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vdpa.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..34388e21ef3f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -282,6 +282,12 @@ struct vdpa_map_file {
>   *                             @iova: iova to be unmapped
>   *                             @size: size of the area
>   *                             Returns integer: success (0) or error (< 0)
> + * @bind_mm:                   Bind the device to a specific address space
> + *                             so the vDPA framework can use VA when this
> + *                             callback is implemented. (optional)
> + *                             @vdev: vdpa device
> + *                             @mm: address space to bind

Do we need an unbind or did a NULL mm mean unbind?

> + *                             @owner: process that owns the address space

Any reason we need the task_struct here?

Thanks

>   * @free:                      Free resources that belongs to vDPA (optional)
>   *                             @vdev: vdpa device
>   */
> @@ -341,6 +347,8 @@ struct vdpa_config_ops {
>                          u64 iova, u64 size);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
>                               unsigned int asid);
> +       int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm,
> +                      struct task_struct *owner);
>
>         /* Free device resources */
>         void (*free)(struct vdpa_device *vdev);
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

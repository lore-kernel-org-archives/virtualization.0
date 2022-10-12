Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F950C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 03:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6A5B60AF4;
	Wed, 12 Oct 2022 03:08:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6A5B60AF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iFzTfi/Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLZyWLQhaKJt; Wed, 12 Oct 2022 03:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41058607F0;
	Wed, 12 Oct 2022 03:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41058607F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF59C0032;
	Wed, 12 Oct 2022 03:08:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF87BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 03:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A1B7416E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 03:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A1B7416E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iFzTfi/Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXSCS31IOXHB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 03:08:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1269E414CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1269E414CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 03:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665544083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BgOum/UDHehE92DZqDcEw12xZnODZkBr1fs6UDB1a+M=;
 b=iFzTfi/Q6PnvarJOpjOPiS3PHuZo47m7cruxjv7UcgelObH9auQ7LsjcHrDsmxok6RARyx
 0rafyBeoibwPnoXUAYQ2ohq9X0HdNsIZbXqghj8FcIGYO11XFVShVmDuBwBJl1fbE6+ffY
 K4Moy5YrVI2WIfF+faVaLtdOHFFV4qY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-0cq64qIUPG-YiIDm4vrjWQ-1; Tue, 11 Oct 2022 23:08:01 -0400
X-MC-Unique: 0cq64qIUPG-YiIDm4vrjWQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 j8-20020a056808118800b00354b7e75b46so2038704oil.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 20:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BgOum/UDHehE92DZqDcEw12xZnODZkBr1fs6UDB1a+M=;
 b=Zsnfkd1R7NaB+EhauK2ReFsKgzwDAiBMBSEFojxT3soSWR5ByAchyRtZA7+mRVm7Gu
 Bn1+DQWbuBwB8bccdtB99Pm7LCJlzLtOdk3fd2Tgu6OcVnowkI6BkyjgO93Xs+EfV3A0
 asJ7BXvVwXzNmseh/BAuIqCIymEwOCL9umD3U+K4KZxEjZNDFF/kO2J6OPAGyXFXon28
 Ditjxw39DdL2zhFIOr+UG1fh8+h1tAZwRWorT6P7Eml22+QNQxI92vB/XSSt7xmllxlU
 fghZ8PjUf5UTRKqoe/JOWRX0h2vkiWX0aHDN3lfE8M0PMfpL76chXO9TfgxIrT4hdkPe
 w4tA==
X-Gm-Message-State: ACrzQf04TBmbOiYL4kCvKZ3P5LPmM/kER927AU9QGFwX8FOk6oVjAX6w
 BX88/W5jaPFJir8E44GSI0I7jjY8w66OdZu+OPiAFUYR9rqF8w/rZHAasRD9h9tbCWK7OZc+tGO
 uB2pYb7IFsNgP+RVJ/qYgkpqPandpxgx5qaMsZa3mFomQG/7SMWmnkydo4Q==
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr1228134oab.280.1665544079554; 
 Tue, 11 Oct 2022 20:07:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5dq66SvAlxf7mu4Q2w0EN+PHpuAQh+ivBrOwjxijz5lSw6LuA0SVDb5dfCsMPUvQ3ntliZotjYUlqEkWxvsXY=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr1228128oab.280.1665544079369; Tue, 11
 Oct 2022 20:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Oct 2022 11:07:48 +0800
Message-ID: <CACGkMEvpApmF6TFVi8jD-YTYTcYN=zUyvrsxHL8Rts6vQC9EAQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: merge functionally duplicated dev_features
 attributes
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 11, 2022 at 2:32 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> We can merge VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES with
> VDPA_ATTR_DEV_FEATURES which is functionally equivalent.
> While at it, tweak the comment in header file to make
> user provioned device features distinguished from those
> supported by the parent mgmtdev device: the former of
> which can be inherited as a whole from the latter, or
> can be a subset of the latter if explicitly specified.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c       | 2 +-
>  include/uapi/linux/vdpa.h | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index febdc99..41ed563 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -855,7 +855,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>
>         features_device = vdev->config->get_device_features(vdev);
>
> -       if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
>                               VDPA_ATTR_PAD))
>                 return -EMSGSIZE;
>
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 9bd7923..54b649a 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -53,11 +53,9 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
>         VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>
> +       /* virtio features that are provisioned to the vDPA device */
>         VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>
> -       /* virtio features that are supported by the vDPA device */
> -       VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,  /* u64 */
> -
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

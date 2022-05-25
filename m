Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1027AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 02:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A513E40588;
	Wed, 25 May 2022 02:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10ys3CBMGDAL; Wed, 25 May 2022 02:48:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21C9E40289;
	Wed, 25 May 2022 02:48:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3F4BC0032;
	Wed, 25 May 2022 02:48:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D41BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA542612AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XMw9TMMXpP43
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:48:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24E9260AAC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653446911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moBf3qLUiMaMEuWifwI/xaF6Fz339bQVKF7DFB/eZLg=;
 b=EkmDOMH9W1WB1fyjW6DFQG+4yoR9U8IQdWylrkCw67wPKzVx2JtweXgb0WA3/xFNWA2P2K
 z1+kVdrH0nKNqSTYq98VS2cBzOmVrlSoJNQxUBkEYn15PPb8KYl0u6nc+YhRcUtiKo7Lc6
 IpP/9MLD7hPaiip45J/xPS5Mw5lrIks=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-D1wJzUK8PGeUPTUqj11Hdg-1; Tue, 24 May 2022 22:48:30 -0400
X-MC-Unique: D1wJzUK8PGeUPTUqj11Hdg-1
Received: by mail-lf1-f71.google.com with SMTP id
 n3-20020ac242c3000000b00473d8af3a0cso10025260lfl.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 19:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=moBf3qLUiMaMEuWifwI/xaF6Fz339bQVKF7DFB/eZLg=;
 b=H5ZrSnkGWqVHrr84yIi5V8ZwG43JInYHMaDL8v9XB50sxMxQ3ZGW0iU2gXzd8mtplN
 RnuZo9jsP239TmmkkT2GastNI57/ANF/Zi27m+tQoIgl1yLrW9QzvFJCf9nrX0clt1Z+
 oZJ/yT0nK8CvMnunNVTbwt8FuKsL7mKSF9cbT1Ha9s8Mb1KUV4D2H79AW3gLh52hvXj9
 9KWqTRgQSgBu6ZvAzvC5KVEIUaNEPj3ObI2UL9uTG/ag7ObcmG/G3IOgcNgUnZ6aDcsB
 Dalbeelv3lHy+auH4u9MGWnCu8KMMCAs+UvUCcc71vpjhm9nGaLeGOci4rnznbDlZYsg
 05uA==
X-Gm-Message-State: AOAM532uu5uVtHcQUBokx3yTqQTWRDJHfu2oDlQdob6KRuevfGos97K4
 3D5ioWe+CB8QZVYRpbwKGD9njTHkJlz4VpDIbEbqhYaXI1jdz23VcSttAy+OsDElz/coXru7lbs
 QOGWCpulg5MDwo7PSu0BNOZcpDMx9kkjq5E0M9GVwRRy90fNGFdB3no+7fw==
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr15438133lfu.98.1653446909112; 
 Tue, 24 May 2022 19:48:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPKntxWVkeik8YG79bT89bb1PnCEmh2seS8IqHocQR2ayMN1K7BGtMlWcKYe0uNqLLrzgobuNsS8hEDO0Z7kA=
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr15438126lfu.98.1653446908927; Tue, 24
 May 2022 19:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220524115143.187-1-xieyongji@bytedance.com>
In-Reply-To: <20220524115143.187-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 May 2022 10:48:17 +0800
Message-ID: <CACGkMEuJeU6c1z8+_FqGtovbF+Sq8w_eQUcG8SHm_GXV5q7yNA@mail.gmail.com>
Subject: Re: [PATCH] Docs/ABI/testing: Add VDUSE sysfs interface ABI document
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Tue, May 24, 2022 at 7:51 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This adds missing documentation for VDUSE sysfs interface ABI
> under Documentation/ABI/testing.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  Documentation/ABI/testing/sysfs-class-vduse | 33 +++++++++++++++++++++
>  MAINTAINERS                                 |  1 +
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-vduse
>
> diff --git a/Documentation/ABI/testing/sysfs-class-vduse b/Documentation/ABI/testing/sysfs-class-vduse
> new file mode 100644
> index 000000000000..2f2bc5c8fc48
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-vduse
> @@ -0,0 +1,33 @@
> +What:          /sys/class/vduse/
> +Date:          Oct 2021
> +KernelVersion: 5.15
> +Contact:       Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +               The vduse/ class sub-directory belongs to the VDUSE
> +               framework and provides a sysfs interface for configuring
> +               VDUSE devices.
> +
> +What:          /sys/class/vduse/control/
> +Date:          Oct 2021
> +KernelVersion: 5.15
> +Contact:       Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +               This directory entry is created for the control device
> +               of VDUSE framework.
> +
> +What:          /sys/class/vduse/<device-name>/
> +Date:          Oct 2021
> +KernelVersion: 5.15
> +Contact:       Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +               This directory entry is created when a VDUSE device is
> +               created via the control device.
> +
> +What:          /sys/class/vduse/<device-name>/msg_timeout
> +Date:          Oct 2021
> +KernelVersion: 5.15
> +Contact:       Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +               (RW) The timeout (in seconds) for waiting for the control
> +               message's response from userspace. Default value is 30s.
> +               Writing a '0' to the file means to disable the timeout.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..d9a423de2f4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20842,6 +20842,7 @@ M:      Jason Wang <jasowang@redhat.com>
>  L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-bus-vdpa
> +F:     Documentation/ABI/testing/sysfs-class-vduse
>  F:     Documentation/devicetree/bindings/virtio/
>  F:     drivers/block/virtio_blk.c
>  F:     drivers/crypto/virtio/
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

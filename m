Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 03:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0170881846;
	Mon, 29 Nov 2021 03:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0fR8Y3ekKCi; Mon, 29 Nov 2021 03:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A69348175A;
	Mon, 29 Nov 2021 03:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B9BCC0012;
	Mon, 29 Nov 2021 03:10:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89198C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62769409F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xwQ9D_DVw8Qg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:10:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FD24409E2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 03:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638155451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgE2ogo+Z+orwFC+QIs4bY4xjkMdtyQ0OgT9F9nc+sU=;
 b=SSTjdx+ROmgLXisV+b3NFVkJgmzIyRjZ92OfkCaUy9/CWEJ9bdjIa0R7zC8WglDODVIYSX
 hpM9MVDZm6tJFvmmL16XSpFELJ3ISTkx3UeR6FISU96cI1W4HrO6LFgjFCSgA54aSR//Y6
 LQjFNF5v+kQhUutWiCCnc7BlsTvq73M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-xQU-t-AaPDSJlFJ9HPu7CQ-1; Sun, 28 Nov 2021 22:10:50 -0500
X-MC-Unique: xQU-t-AaPDSJlFJ9HPu7CQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 u20-20020a056512129400b0040373ffc60bso5044012lfs.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 19:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TgE2ogo+Z+orwFC+QIs4bY4xjkMdtyQ0OgT9F9nc+sU=;
 b=A6Af4xvSVJB3kd8l+U+jDSlBhh/7ixAqFGvsYogkzEmBc1KyfZLMM2ibwKGcLe6qv0
 hnwr7Ny1J23OUKM77ex9Z2RlByN+f+yagM4Ozu3vZBSix94QwsEo8vhRzG0TaCZjAf3u
 dmmRtHyFfQoAyl9sM261u2oTgrCH4mHGYLSAVTZsPK0b8RGFsCe/3kv4SNZFi1UmOccB
 qJmZfENHp0zJEi2MS3aG0cbTIq5YpnXk9tUFTfDb0STzfxHtVDM9mONd6y+rNThUQz51
 02WaTAI+Qg5U+tS8d/uKZMydbsTa5rQLQaEojiQt+ahsIo1pOizc0qTVd4naNYNCbpYC
 cJEg==
X-Gm-Message-State: AOAM5335+eBRHWBcc8gcbi+i3wAoEEdfSlSzjFDn0Opxa1XBkulePkrx
 BGyTScFhJSfogtNkAMxMGlJTAF2J2cY6kdORY9FCGiC426TsiDXkRFY9u8UM8bWtyTww0eQ12XJ
 RY5l1PfNz4SOugdPTu23MnA49FXDVvYuBytrlZzJHs8HBufWm5cnmA7kEQw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr46843134lfv.481.1638155449034; 
 Sun, 28 Nov 2021 19:10:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypRBaf690ponP3sUXlnngSW/XjF4vja4g2y2tVNfNRymYfg73oHS3yuu7G+wAYwAtnrWK3hPbzZBV08hR4QVM=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr46843110lfv.481.1638155448790; 
 Sun, 28 Nov 2021 19:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20211126164753.181829-1-sgarzare@redhat.com>
 <20211126164753.181829-2-sgarzare@redhat.com>
In-Reply-To: <20211126164753.181829-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Nov 2021 11:10:38 +0800
Message-ID: <CACGkMEuEONMW3wvPULbL+9U0UkJ43zaq8__FySeZC7J4-ZPb7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: document sysfs ABI for vDPA bus
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Sat, Nov 27, 2021 at 12:48 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Add missing documentation of sysfs ABI for vDPA bus in
> the new Documentation/ABI/testing/sysfs-bus-vdpa file.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-vdpa | 37 ++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
> new file mode 100644
> index 000000000000..4e55761a39df
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-vdpa
> @@ -0,0 +1,37 @@
> +What:          /sys/bus/vdpa/driver_autoprobe
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               This file determines whether new devices are immediately bound
> +               to a driver after the creation. It initially contains 1, which
> +               means the kernel automatically binds devices to a compatible
> +               driver immediately after they are created.
> +
> +               Writing "0" to this file disable this feature, any other string
> +               enable it.
> +
> +What:          /sys/bus/vdpa/driver_probe
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the kernel binds
> +               devices to a compatible driver.
> +
> +               This can be useful when /sys/bus/vdpa/driver_autoprobe is
> +               disabled.
> +
> +What:          /sys/bus/vdpa/drivers/.../bind
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the driver to
> +               attempt to bind to the device. This is useful for overriding
> +               default bindings.
> +
> +What:          /sys/bus/vdpa/drivers/.../unbind
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the driver to
> +               attempt to unbind from the device. This may be useful when
> +               overriding default bindings.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..36ea80b4ba63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20104,6 +20104,7 @@ M:      "Michael S. Tsirkin" <mst@redhat.com>
>  M:     Jason Wang <jasowang@redhat.com>
>  L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-vdpa
>  F:     Documentation/devicetree/bindings/virtio/
>  F:     drivers/block/virtio_blk.c
>  F:     drivers/crypto/virtio/
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

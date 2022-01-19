Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06745C433F5
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 02:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABFB2819F3;
	Wed, 19 Jan 2022 02:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z73MBGMJUyJh; Wed, 19 Jan 2022 02:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4630A81376;
	Wed, 19 Jan 2022 02:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19F45C0039;
	Wed, 19 Jan 2022 02:45:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D63C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE74B60E8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kpyCALeRlUA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D1BE60E80
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642560317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QbQg6mxiZtW68ExHgyVdc/QMifv6KYOVGiXP5EWIls=;
 b=YJoLfA/rvI57FrBPt1NlOJ5OJ8wSWZAuB/cHlxPXyntHblWZJLEip03e0dXgTg9YZyLGoU
 OR0SD74FsHuCioYdkBQq8xJOD8YemvOIajLS2zkMfr0lbDm4AQMgwsIULCFuZAXSEc2pb0
 ro+6vCg6XW4MVgVnqOq971xGfbHnL90=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-hxIEA44dMu2E0x2kdHboQA-1; Tue, 18 Jan 2022 21:45:15 -0500
X-MC-Unique: hxIEA44dMu2E0x2kdHboQA-1
Received: by mail-lf1-f71.google.com with SMTP id
 u26-20020a056512041a00b0042fcdc4f7baso532724lfk.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 18:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2QbQg6mxiZtW68ExHgyVdc/QMifv6KYOVGiXP5EWIls=;
 b=U9mu9ogPAyu1ByqIRLp/AWq8uvJT8c1Qw6NtDYA7f98AD1KhIxyz+T7VWEQtKneCKa
 d8d30ZnpgYmTbMGhJ7lzyt+hi9Z6Una74oMNed4n+HCEhH/ahdiuISf/riKMXwzrRnR/
 2QOYYqtpnPj4NmTNM+Yx1hN2QVJiXuQN45NRiCvAxjnoieU9umExDSTGi2Rx+L/FIE68
 rx61lTIJoDx6vy+7FyiQcnBftFX/H/FapF6PatOqDSHvGTOCrRUjsV4p6ne0HjGOy1gT
 cO0yDSeXZK03j8AcLI2aUxKbTcOlv0AuTtDerFW/mH90sZPo7vav4N+kxUzTSWHYJ/F1
 LOGw==
X-Gm-Message-State: AOAM530daEedDXaA07LeSfTqrVRsoV+h7XIDq56L8Ac94IBfiK/SIN4n
 fw0KGnmzLe2eBXM9VLw30jz3IQMWTQZ2+pA54NdEbe/lgKtukEKdLR/7Uu2OVe3Xcqupm6nuii2
 86zXrp26UhTCDgS6qoybsqxuXTEhIVn3LD3H/zPeReHWV0TKBHtn0OAlBpQ==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr21777391ljj.277.1642560314292; 
 Tue, 18 Jan 2022 18:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzB9BW6WWCim9vDYU4kum1F16AkR869KEeJaKkIEYwrn5RQkE5MqxGYI12cabpygmhempbvUOpSdSvSn6zf90Q=
X-Received: by 2002:a2e:9843:: with SMTP id e3mr21777377ljj.277.1642560314113; 
 Tue, 18 Jan 2022 18:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20220118150631.167015-1-sgarzare@redhat.com>
In-Reply-To: <20220118150631.167015-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jan 2022 10:45:03 +0800
Message-ID: <CACGkMEtrH5dy7WxqEg7vNARUu3tsYZBtP8MX7a60VR+ZyWvVrw@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: fix virtio_test execution
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

On Tue, Jan 18, 2022 at 11:06 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> virtio_test hangs on __vring_new_virtqueue() because `vqs_list_lock`
> is not initialized.
>
> Let's initialize it in vdev_info_init().
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  tools/virtio/virtio_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index cb3f29c09aff..23f142af544a 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -130,6 +130,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>         memset(dev, 0, sizeof *dev);
>         dev->vdev.features = features;
>         INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
>         dev->buf_size = 1024;
>         dev->buf = malloc(dev->buf_size);
>         assert(dev->buf);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

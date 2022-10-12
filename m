Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E79C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 02:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C09D403A9;
	Wed, 12 Oct 2022 02:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C09D403A9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOAiBq/C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1tXZPkHCLp0; Wed, 12 Oct 2022 02:31:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 752E2400E5;
	Wed, 12 Oct 2022 02:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 752E2400E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4879DC0033;
	Wed, 12 Oct 2022 02:31:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A82C9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 02:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BBD182779
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 02:31:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BBD182779
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOAiBq/C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sC3KpXuFJeJn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 02:31:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B97C98272C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B97C98272C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 02:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665541877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWHqsdrdeOUECP7iiSQMbg1019god1/+rH/feXS+ZMo=;
 b=MOAiBq/CCwLymuOctqyy/GMKH2QIiX2L4YS8TfjmR4SqYr3xSdh2QDROewvOUfiwLpYCbX
 z8RghguB0ETdxfieezsbi0ER+77cbBUU14jGb0FEAqSfOpvG4MjzDOyE+A3mJ62UrrwZ0K
 m1pt5O4d8zc/sepLWVFMy2hzaeyejrg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-C086zsgPPre2ZZRoBtnJDA-1; Tue, 11 Oct 2022 22:31:16 -0400
X-MC-Unique: C086zsgPPre2ZZRoBtnJDA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-132693a4072so7719906fac.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 19:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWHqsdrdeOUECP7iiSQMbg1019god1/+rH/feXS+ZMo=;
 b=p0F6+1yiJ42xzBEQTPI4mnL7oR0E3KOus+/oK8tpfoh+Yon/jYpTiKF/L1mSCzqPsw
 OJLDzet9Og2xokFM14KUlJpD1EhDbn3/YSoWTM/ydl2NOTajBiq5IKRHivzkAoKJkaP+
 xZEwRll7ckuLXaNB5vJ9OV5XY/jSG48yTmg4dgzOUkGhX3VKWoP4QUCfyfbx86hHe5M7
 UrcEOnxHAYPAUjaIQXdwn6tP908XaJwZwaLXaDz9vFxb9VF7fuddVkJrk6sHNPOXHZUk
 MNHSLzr5F20lJZXlAyt7E8BrfVpOWfHRkoij1Kw5qNoh1JlhaD2FZyMsUNsouZxxoUWw
 VPpg==
X-Gm-Message-State: ACrzQf121otaJcRAUsaa/Ru2JfCkj5IUHQty2zPvSp0fMEWyZwIYK0/0
 s+FtjWffbdTfY7zp2+TG3RYlHi8J9FBEgMTmJrVk7L6VJHrkmFy3Df5MsX6jQeieTxF5OY7r1bB
 mOEjucEs+0mg/ZTmn/kiESYOsjOdN4wUGT338MPkqpi4iqgRp6EF5LPOHbQ==
X-Received: by 2002:a05:6830:4387:b0:661:8d25:2c95 with SMTP id
 s7-20020a056830438700b006618d252c95mr8786160otv.201.1665541875829; 
 Tue, 11 Oct 2022 19:31:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64wOhjhRqsyVIZiDQrcHkTTgscLTPNc5Vz2BbwcUYAMAPP7wJwY8RgzN/KjKOtdYXPnk8GQUsp1qFYCd73vDM=
X-Received: by 2002:a05:6830:4387:b0:661:8d25:2c95 with SMTP id
 s7-20020a056830438700b006618d252c95mr8786153otv.201.1665541875611; Tue, 11
 Oct 2022 19:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
In-Reply-To: <20220928234008.30302-1-mgurtovoy@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Oct 2022 10:31:04 +0800
Message-ID: <CACGkMEvfivRAwZ1OT13ujChvrJ_=_d8tY6Fg83WP6+kdO4cOGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
To: Max Gurtovoy <mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

On Thu, Sep 29, 2022 at 7:40 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> This is instead of re-writing the same logic in virtio driver.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Acked-by: Jason Wang <Jasowang@redhat.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..67d3970e57f2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>  {
>         struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct virtio_device *vdev = &vp_dev->vdev;
> -       int ret;
>
>         if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>                 return -EBUSY;
> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>         if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>                 return -EINVAL;
>
> -       if (pci_vfs_assigned(pci_dev))
> -               return -EPERM;
> -
> -       if (num_vfs == 0) {
> -               pci_disable_sriov(pci_dev);
> -               return 0;
> -       }
> -
> -       ret = pci_enable_sriov(pci_dev, num_vfs);
> -       if (ret < 0)
> -               return ret;
> -
> -       return num_vfs;
> +       return pci_sriov_configure_simple(pci_dev, num_vfs);
>  }
>
>  static struct pci_driver virtio_pci_driver = {
> --
> 2.18.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

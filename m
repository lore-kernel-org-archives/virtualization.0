Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0F1C61DA4
	for <virtualization@archiver.kernel.org>; Fri, 24 Feb 2023 03:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F06D160AEC;
	Fri, 24 Feb 2023 03:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F06D160AEC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bq2S3V4d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ALgNikPUh-O; Fri, 24 Feb 2023 03:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC499600D1;
	Fri, 24 Feb 2023 03:11:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC499600D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA98C0032;
	Fri, 24 Feb 2023 03:11:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C887C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F163960A71
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:11:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F163960A71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4GJkBy1TnUh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EBCD600D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EBCD600D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Feb 2023 03:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677208311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ce5tfl2n/EssbKt11AP0PiIJ95ywSk+f7JnIMaHI1Wk=;
 b=Bq2S3V4dzEu83xOgYWzZr+zlld+eFtAlNrMtccxw4QQSt9bTCR9/UYBTrJtlo6Ovau8sr2
 unWoMfbOYlDDU7vdejsOV5NCWe0akXUgtiaZMyNdjC1rAvqi8Y+NzNSGfMAq2bjGgv6SBe
 Sm3ArBiFSk5xiRE3i5PXBGjzPJD610Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-LnKqYlFGPx6Y58W1x99GuA-1; Thu, 23 Feb 2023 22:11:49 -0500
X-MC-Unique: LnKqYlFGPx6Y58W1x99GuA-1
Received: by mail-oi1-f199.google.com with SMTP id
 q25-20020a056808201900b0037fcc209e73so5595639oiw.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 19:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ce5tfl2n/EssbKt11AP0PiIJ95ywSk+f7JnIMaHI1Wk=;
 b=grENF95a93Hq8PgfIiuYUXd/bGmv2PnX0xhuQuWyXfP2RaNoumtEIRV4hKrGsucrHv
 +KGzDIa46I4PZML2UaTVPHSbh87yoVw2WuWMHI0DtdVIPQn5X6/ffZTFdpTa25MPKiQw
 3ZPXdsTpYedngb3k3jI+MmVusUrwm/OKkVC4CYQcAZyOe6cZhfvRzhiot8d8flby1DP7
 +hifFKivdQBlquzLJufybfilm2uSvGZB4DvPnUkQ11zRg7l9BtgIghA6yn22vIC7/nb5
 0+bDi/YPaiFnFiHV5F30rZSy3Vv9qOCyH0SwnJIRWdDW0B6iolVvfBl/EW78MHCZ9hSG
 szuQ==
X-Gm-Message-State: AO0yUKW2EzMBDrHBjY2iggE9KO4cZ1pNogUrDTOrGtwe2PT5rYvcShcE
 Bs2LZlCJ6LBddvLe8VwNXugkwqXSOaqQ0vyoD0EuzhoOIH/Oten+hBEzM0DxjUIzmOGT7mxrD+v
 Cs++xp3P0NMZlR/lwbtgWSK+tuFL7oEiw0cQBchlbCofrpqMRZ+EFPY5zew==
X-Received: by 2002:a05:6808:6c9:b0:383:c688:a8e0 with SMTP id
 m9-20020a05680806c900b00383c688a8e0mr725792oih.9.1677208309041; 
 Thu, 23 Feb 2023 19:11:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+gu9v2kcBbZccH/ZaJz3PndJ8R+g8ZrRudTxgfmD3x81zCiyAktZ0EKcq2Yuereo2Z41aHL/7pYEkRPXgsh0s=
X-Received: by 2002:a05:6808:6c9:b0:383:c688:a8e0 with SMTP id
 m9-20020a05680806c900b00383c688a8e0mr725779oih.9.1677208308153; Thu, 23 Feb
 2023 19:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
In-Reply-To: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Feb 2023 11:11:37 +0800
Message-ID: <CACGkMEu8JtT9_0YcbmfWCGxbrB1GHnesnspFYgaeVrb2x3o3oQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
To: rbradford@rivosinc.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Feb 24, 2023 at 3:38 AM Rob Bradford via B4 Relay
<devnull+rbradford.rivosinc.com@kernel.org> wrote:
>
> From: Rob Bradford <rbradford@rivosinc.com>
>
> kvmtool does not support the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature
> but does advertise the VIRTIO_NET_F_GUEST_TSO{4,6} features. Check that
> the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is present before setting
> the NETIF_F_GRO_HW feature bit as otherwise an attempt will be made to
> program the virtio-net device using the ctrl queue which will fail.
>
> This resolves the following error when running on kvmtool:
>
> [    1.865992] net eth0: Fail to set guest offload.
> [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wanted 0x0000000000134829, left 0x0080000000134829
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
> Changes in v2:
> - Use parentheses to group logical OR of features
> - Link to v1:
>   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d7a@rivosinc.com
> ---
>  drivers/net/virtio_net.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61e33e4dd0cd..f8341d1a4ccd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3780,10 +3780,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>         }
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
>                 dev->features |= NETIF_F_RXCSUM;
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> -               dev->features |= NETIF_F_GRO_HW;
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +       if ((virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)) &&
> +           virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
>                 dev->hw_features |= NETIF_F_GRO_HW;

Does this mean we won't have NETIF_F_GRO_HW when only TSO4/TSO6 are
supported but not GUEST_OFFLOADS?

Is this intended?

Thanks

>
>         dev->vlan_features = dev->features;
>
> ---
> base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> change-id: 20230223-virtio-net-kvmtool-87f37515be22
>
> Best regards,
> --
> Rob Bradford <rbradford@rivosinc.com>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

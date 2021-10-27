Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E66C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:45:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F000610A1
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F000610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34442400E6;
	Wed, 27 Oct 2021 02:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzS-FkZc83N5; Wed, 27 Oct 2021 02:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 934DE400C1;
	Wed, 27 Oct 2021 02:45:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4372CC0012;
	Wed, 27 Oct 2021 02:45:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA8C0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B680C401FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5gO47k8miuMl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FA61401FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635302732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9muq5ZSeJhvEW0ZLoiZHIrlbDuVWUKDsCoalzlqdM5A=;
 b=L5qkEK3TZLw97F41TDywZJC9bqbaFenEnHow6/BWqUIkG6HBPVzoyMh8DfArpgzN0ARPD7
 D/fg/4S1M+/GGxE3fBqmFHSlYiMNf3rswZEQmEPQb7Bl0JZj/W17Rkg7SS5UNeFGtFaBY/
 dU9z1MmoVTfzhIpSTLpU9rjG5AKdZsw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Ks-tNr09MNGMtRUhs1PwGw-1; Tue, 26 Oct 2021 22:45:31 -0400
X-MC-Unique: Ks-tNr09MNGMtRUhs1PwGw-1
Received: by mail-lf1-f72.google.com with SMTP id
 x17-20020a0565123f9100b003ff593b7c65so665357lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 19:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9muq5ZSeJhvEW0ZLoiZHIrlbDuVWUKDsCoalzlqdM5A=;
 b=kk6O367JL2CPf+A0JZ/5KbjPAm0fZG6mJwkfXHFefH6jP7vFQj4KC1XSSrZXuI8cii
 HaPMkPZFhh3GELE3xByST2+CwXYws+B11h+p/fXrKJvUNjxwIy4blFyox/pMuklHi1eb
 4sPULIa6k7TgBTp2s2AJV1JZOdh+BjexdUOR78odF6KX9mcxmjwuz6fW0ei5Gf9dasCP
 3twYZlE5N2Ym0tRF7HOVFvQhTx7lRj8clGZU7DznP52J81/YQTa7ekHb1AGmxUbsgUVS
 BNy6D7JerouhQTtm50jrZ6CYU06H8W8Hmq9j2LE09D+yIDGGpoO0Rjl1HoC+JdCIJ9he
 fDQQ==
X-Gm-Message-State: AOAM530siN5lzPeTsvAlFP6PFp+x9ZMxhDOZlaAU+1cXHZLjuiecyivc
 e8bYQq/uXfgcvJewpFWZC8YrmqeI4UtqTmfn65LXBt53xen3sut+Wqv9mzT5691PYLFyZ7+bhx3
 wyrZBdUOGJWia+svpBvFAo+OPQSgpVWLXzXe7h/mxIzbFnHJC7vS4MAR4Yw==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr8569203ljj.277.1635302729851; 
 Tue, 26 Oct 2021 19:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwitG53CURCkAynKzlzA1GM5af5iJeQG5F8KL26fH3RBWG/gNDMvl4rD5ruG1VHbCwlszT8J9sPX2R+YcJ0kb4=
X-Received: by 2002:a2e:8846:: with SMTP id z6mr8569181ljj.277.1635302729680; 
 Tue, 26 Oct 2021 19:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211026175634.3198477-1-kuba@kernel.org>
In-Reply-To: <20211026175634.3198477-1-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 10:45:18 +0800
Message-ID: <CACGkMEu6ZnyJF2nKS-GURc2Fz8BqUY6OGFEa71fNKPfGA0Wp7g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: virtio: use eth_hw_addr_set()
To: Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 davem <davem@davemloft.net>, mst <mst@redhat.com>
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

On Wed, Oct 27, 2021 at 1:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it go through appropriate helpers.

I think the title should be "net: virtio: use eth_hw_addr_set()"

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/virtio_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c501b5974aee..b7f35aff8e82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3177,12 +3177,16 @@ static int virtnet_probe(struct virtio_device *vdev)
>         dev->max_mtu = MAX_MTU;
>
>         /* Configuration may specify what MAC to use.  Otherwise random. */
> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> +               u8 addr[MAX_ADDR_LEN];
> +
>                 virtio_cread_bytes(vdev,
>                                    offsetof(struct virtio_net_config, mac),
> -                                  dev->dev_addr, dev->addr_len);
> -       else
> +                                  addr, dev->addr_len);
> +               dev_addr_set(dev, addr);
> +       } else {
>                 eth_hw_addr_random(dev);
> +       }

Do we need to change virtnet_set_mac_address() as well?

Thanks

>
>         /* Set up our device-specific information */
>         vi = netdev_priv(dev);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

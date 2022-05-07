Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3709DC433EF
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 03:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2C0140598;
	Sat,  7 May 2022 03:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JgGu9-fJHyDN; Sat,  7 May 2022 03:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A51640025;
	Sat,  7 May 2022 03:08:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A7B2C0032;
	Sat,  7 May 2022 03:08:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB60EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 03:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A23BE60BD0
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 03:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1tPrzWYqBH2
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 03:08:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A64BF607FF
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651892914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+3bFC46isrTR6zfpg+LqSuag/89ZCJ8zvzZLnx6hwg=;
 b=Nt5UWkHtDyO1aFL2FhmUa1Tnq1epLVvLuAquJtEdjvZ8sHti700lf4hSamVSZpoaPDNeHI
 us1WSatD54WXVdbmksn5QRaRLghJZneeexAvyooTnrLY9of916oR3PWX2WG09D4eUZePVm
 SPusAvSCTt5UDeDQ/UeH0G6PQ0+rOMs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-VAhRb-HaOSiRWx9AC-UbkA-1; Fri, 06 May 2022 23:08:14 -0400
X-MC-Unique: VAhRb-HaOSiRWx9AC-UbkA-1
Received: by mail-lf1-f72.google.com with SMTP id
 w34-20020a0565120b2200b0044adfdd1570so3957617lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 20:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/+3bFC46isrTR6zfpg+LqSuag/89ZCJ8zvzZLnx6hwg=;
 b=G6SUfg+9mX+JbicxX/NAPwHK4nS1iVSWVhewgGZ5o/GLmq/RU4xSTpArsyNdqEEqz9
 NIDSYCpIVRAx2kkQLzHFDAHMzvtMRAX7KtHKsmujtbTGqn0HvU4PmInXI3af212pprKD
 8e8ICqUs6zhk17vSQ5cloZItZLaVt0gju3lYkri0EnoaSRhq7t+Ort8GqTIYknt1K9yD
 wHSn/86ZPwfa7QQgwrlI+cBHB/cAr0WUBFFKOab84VQKlDdPzDFwfgW6C6VuD1h5D5dr
 F8r+qESUf0itEaInCu/3y7ydcPdyZ6V/aZ2LmZ0/cU7ttAgzevd9rEVFkyaE4HcfEw/e
 H0cw==
X-Gm-Message-State: AOAM532zFmZvbzITEhwWHkWCayXKPZLil3nDi7hxfMAptGeqVQ0droIC
 X8Weo2d11V37XW4C+1xlV83JQrzLeB/xcN/NXThE5P2muA3EB6xBOlzoAhwJnfIChFGmkkp0Sie
 rzWlJ7n83tW8PahR0OGxsnVExAX5nEMFmjP0m48UpVp7z6vNwPVs7ypXouw==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr4550648lfj.587.1651892892825; 
 Fri, 06 May 2022 20:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQwCiiiucbpZkb6D8tG4eL5848+nS4cvx3pLhvoJLouxsCa8uQPKeY6G+rYj+4Rrbtodz/8fknlPZIMYtA++Q=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr4550634lfj.587.1651892892569; Fri, 06
 May 2022 20:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220506170751.822862-1-kuba@kernel.org>
 <20220506170751.822862-6-kuba@kernel.org>
In-Reply-To: <20220506170751.822862-6-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 7 May 2022 11:08:01 +0800
Message-ID: <CACGkMEv7frdwDZdib_J4i-V5sVrqwNb=-pu5uXvjr0dfv9H5Fw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: virtio: switch to
 netif_napi_add_weight()
To: Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

On Sat, May 7, 2022 at 1:08 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> virtio netdev driver uses a custom napi weight, switch to the new
> API for setting custom weight.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: virtualization@lists.linux-foundation.org
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ebb98b796352..db05b5e930be 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3313,8 +3313,8 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>         INIT_DELAYED_WORK(&vi->refill, refill_work);
>         for (i = 0; i < vi->max_queue_pairs; i++) {
>                 vi->rq[i].pages = NULL;
> -               netif_napi_add(vi->dev, &vi->rq[i].napi, virtnet_poll,
> -                              napi_weight);
> +               netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
> +                                     napi_weight);
>                 netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>                                          virtnet_poll_tx,
>                                          napi_tx ? napi_weight : 0);
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

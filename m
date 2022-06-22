Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61F8C43334
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 08:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81B326126D;
	Wed, 22 Jun 2022 08:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81B326126D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfFbxj7H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iTCqNaRhA1_w; Wed, 22 Jun 2022 08:06:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D536A60B0D;
	Wed, 22 Jun 2022 08:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D536A60B0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE29C0032;
	Wed, 22 Jun 2022 08:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B90A5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D83E84295
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D83E84295
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfFbxj7H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QqaiyfKqTEiT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C448384271
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C448384271
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655885192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5FesIEJNUAYWwzRo/YOZ1QtVKtqRp3mnHCOXbnUhhM=;
 b=LfFbxj7HPcmtsxrvUXYlqraRTMYJwSfwpaFOk0QAoU4jubBYJI2YtYWmXAG3/sSsJiZf79
 NBEX6jGqgrhbSVuGWEArtfQM9eon9ozqBmUKi9aaijspbTUF7Wni1uRy67LJnfN3Us/06S
 TpHsnGwOKqWOnj+r++IP/5yXUhy2E64=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-bi9Ba9QhNN-UZzyY0OvGAw-1; Wed, 22 Jun 2022 04:06:30 -0400
X-MC-Unique: bi9Ba9QhNN-UZzyY0OvGAw-1
Received: by mail-lf1-f69.google.com with SMTP id
 u7-20020a05651206c700b00479723664a9so8170453lff.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J5FesIEJNUAYWwzRo/YOZ1QtVKtqRp3mnHCOXbnUhhM=;
 b=Np+kvCNeeG+5SOiK/boOBak0gmDfAUBIbn6g56qPTNdsokOvhOCaN1LWYlOzDmYMRM
 /P85FPfEf9Dy7fM4+Sdo+h+cJiUJfOLZPfzFl7pnYvi7+d/8ywMTEmYFj8z2Vt/w9dev
 q621Wo2cji9YJRymmRoa5QNTXuMI9Amqg2kFFhtOaXbFtlYQzI/7qfVWMVoRpDc4yfgz
 6oV4o5szPt2lmwCPjjz7Y1jSN6k6M1HvJ+DKMY8C0JZxtHP1wnWdCamnVoP82NEmnpz6
 w1lMacI+CjWl+bmWWArMWmiqnHG6mt7V+TraEwyH/OP66ei5xmmnW57uG8CU21sWoXja
 1NEg==
X-Gm-Message-State: AJIora8wuUzqxWHtRCmyx/4UOz23P3bUV7WCn6xIJNmq0u6yHwLhUe5Y
 3C7BwqQN+giqOCh8rgLwwin2qJ/XIDgKd9/RdsqVus3CGr8MJJ6jXFHLQvHj2gkYI12Bb+p/A5P
 huhPlfmfTfDtwEayvZY4DSvUY1yxadeBpwlZwUhH0aL8BVkigZYbSJqgt/g==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr1420548lfa.442.1655885189240; 
 Wed, 22 Jun 2022 01:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkxcyuPKm08huxiqWuTWt7AWd6nEXg9wjIHlQsqNsaLpWQeLuiYvLUwu9t7gVY0n8kDnn3TbP+HM4y52lv6qk=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr1420532lfa.442.1655885188954; Wed, 22
 Jun 2022 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220621114845.3650258-1-stephan.gerhold@kernkonzept.com>
In-Reply-To: <20220621114845.3650258-1-stephan.gerhold@kernkonzept.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jun 2022 16:06:17 +0800
Message-ID: <CACGkMEskKF4O7_Dz5=JxB2noVV5qJQusN9DLLzUFc4d149kS7g@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix xdp_rxq_info bug after suspend/resume
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Jun 21, 2022 at 7:50 PM Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> The following sequence currently causes a driver bug warning
> when using virtio_net:
>
>   # ip link set eth0 up
>   # echo mem > /sys/power/state (or e.g. # rtcwake -s 10 -m mem)
>   <resume>
>   # ip link set eth0 down
>
>   Missing register, driver bug
>   WARNING: CPU: 0 PID: 375 at net/core/xdp.c:138 xdp_rxq_info_unreg+0x58/0x60
>   Call trace:
>    xdp_rxq_info_unreg+0x58/0x60
>    virtnet_close+0x58/0xac
>    __dev_close_many+0xac/0x140
>    __dev_change_flags+0xd8/0x210
>    dev_change_flags+0x24/0x64
>    do_setlink+0x230/0xdd0
>    ...
>
> This happens because virtnet_freeze() frees the receive_queue
> completely (including struct xdp_rxq_info) but does not call
> xdp_rxq_info_unreg(). Similarly, virtnet_restore() sets up the
> receive_queue again but does not call xdp_rxq_info_reg().
>
> Actually, parts of virtnet_freeze_down() and virtnet_restore_up()
> are almost identical to virtnet_close() and virtnet_open(): only
> the calls to xdp_rxq_info_(un)reg() are missing. This means that
> we can fix this easily and avoid such problems in the future by
> just calling virtnet_close()/open() from the freeze/restore handlers.
>
> Aside from adding the missing xdp_rxq_info calls the only difference
> is that the refill work is only cancelled if netif_running(). However,
> this should not make any functional difference since the refill work
> should only be active if the network interface is actually up.
>
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/net/virtio_net.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..969a67970e71 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2768,7 +2768,6 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  static void virtnet_freeze_down(struct virtio_device *vdev)
>  {
>         struct virtnet_info *vi = vdev->priv;
> -       int i;
>
>         /* Make sure no work handler is accessing the device */
>         flush_work(&vi->config_work);
> @@ -2776,14 +2775,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>         netif_tx_lock_bh(vi->dev);
>         netif_device_detach(vi->dev);
>         netif_tx_unlock_bh(vi->dev);
> -       cancel_delayed_work_sync(&vi->refill);
> -
> -       if (netif_running(vi->dev)) {
> -               for (i = 0; i < vi->max_queue_pairs; i++) {
> -                       napi_disable(&vi->rq[i].napi);
> -                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> -               }
> -       }
> +       if (netif_running(vi->dev))
> +               virtnet_close(vi->dev);
>  }
>
>  static int init_vqs(struct virtnet_info *vi);
> @@ -2791,7 +2784,7 @@ static int init_vqs(struct virtnet_info *vi);
>  static int virtnet_restore_up(struct virtio_device *vdev)
>  {
>         struct virtnet_info *vi = vdev->priv;
> -       int err, i;
> +       int err;
>
>         err = init_vqs(vi);
>         if (err)
> @@ -2800,15 +2793,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>         virtio_device_ready(vdev);
>
>         if (netif_running(vi->dev)) {
> -               for (i = 0; i < vi->curr_queue_pairs; i++)
> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                               schedule_delayed_work(&vi->refill, 0);
> -
> -               for (i = 0; i < vi->max_queue_pairs; i++) {
> -                       virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
> -                       virtnet_napi_tx_enable(vi, vi->sq[i].vq,
> -                                              &vi->sq[i].napi);
> -               }
> +               err = virtnet_open(vi->dev);
> +               if (err)
> +                       return err;
>         }
>
>         netif_tx_lock_bh(vi->dev);
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

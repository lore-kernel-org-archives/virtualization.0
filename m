Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F8264010E;
	Wed, 16 Feb 2022 04:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cxVG4g3btVCq; Wed, 16 Feb 2022 04:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BA4D40576;
	Wed, 16 Feb 2022 04:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1167CC001A;
	Wed, 16 Feb 2022 04:14:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A003C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26DC24163D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1HvAFuHzvRA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBEDD415F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkH+Fw1g25wmzz0motWkGyLx4yyB/LCgVvvS7rJG570=;
 b=A/N9hrY97BYkdFzmOIem7M0N8t/DWte4repdWcIlDQlSrmkggEqvAYYUMEXQTRg92cO2kO
 RPnA+2K4oRtf3tkoCt0d/Rr2zvexcy0RPFt5t6X2PY2J7YCkwqkSEXsJYcRbyCwHov9N1r
 Lz/z4xPxOPWqDYMCac5BNuk/wq5oswc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-gD-IRdiSPpyKrupFOlFKEw-1; Tue, 15 Feb 2022 23:14:24 -0500
X-MC-Unique: gD-IRdiSPpyKrupFOlFKEw-1
Received: by mail-lj1-f199.google.com with SMTP id
 m7-20020a2ea587000000b00244e2faf769so463714ljp.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkH+Fw1g25wmzz0motWkGyLx4yyB/LCgVvvS7rJG570=;
 b=c++Z/msdiZAS7ss8nAzpK53swNu+/6wEjd+PnFZFYc9S+WiFsX57nVwBlX6KIqq9dK
 Hn/HM5jWY11Kk5GEAO1mkBibAm9TaK8MyGMenXxGnWFyThFaQ1pKW8nIKM5wmdr70tB/
 Yr8fTfqCBmbrfpJrO3xCJSYIZ+fhQo30ZhsO/fTJ7oXHEVISFoI/R7ZEaGibDuSB65xY
 XisFUpTrygEMBP/F5XPVRIWIhcDUaPjM+o3sEi1zeRJNXIcxiEQdOcROlx9v/Z7BjWLd
 fEKN10dtYiLHL4APass2DfTETCYzzS3L41UstivhPfbfKZerJtyL6WuXRb+igyzth2vB
 p3kg==
X-Gm-Message-State: AOAM530vggyIVQiUKr0fgbf2IYaNrIwzsV3KmYnAgiqbMcgV3qXZ16N8
 AKKxeg+HFTMG8JISxY6WqTDfNRe4MgASx/drinqKfw8xQi+iJXh6TMZUsrD3Xx08/UOz3KkiWan
 DyiP5sTSHjbQfIGzHjCf8SHrJouvHumpCR9y62ZmKYlnSHadZ1Cg3lKrWfg==
X-Received: by 2002:a05:6512:3a81:b0:443:3ae7:33af with SMTP id
 q1-20020a0565123a8100b004433ae733afmr668254lfu.481.1644984862655; 
 Tue, 15 Feb 2022 20:14:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRVo50AruHxXqmY/yLBFDcf8ggmkJHeya3tApjNJhB/lsnGsPXpb51U/jfAQJfPXdJI1xKxTM3cZK1zkLozI0=
X-Received: by 2002:a05:6512:3a81:b0:443:3ae7:33af with SMTP id
 q1-20020a0565123a8100b004433ae733afmr668246lfu.481.1644984862461; Tue, 15 Feb
 2022 20:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-18-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:11 +0800
Message-ID: <CACGkMEszV_sUt+7gpLJ=6S1Spa0RmY=Ck0_duEkGf6xKOPG+oQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/22] virtio_net: support rx/tx queue reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> This patch implements the reset function of the rx, tx queues.
>
> Based on this function, it is possible to modify the ring num of the
> queue. And quickly recycle the buffer in the queue.
>
> In the process of the queue disable, in theory, as long as virtio
> supports queue reset, there will be no exceptions.
>
> However, in the process of the queue enable, there may be exceptions due to
> memory allocation.  In this case, vq is not available, but we still have
> to execute napi_enable(). Because napi_disable is similar to a lock,
> napi_enable must be called after calling napi_disable.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9a1445236e23..a4ffd7cdf623 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -251,6 +251,11 @@ struct padded_vnet_hdr {
>         char padding[4];
>  };
>
> +static void virtnet_sq_free_unused_bufs(struct virtnet_info *vi,
> +                                       struct send_queue *sq);
> +static void virtnet_rq_free_unused_bufs(struct virtnet_info *vi,
> +                                       struct receive_queue *rq);
> +
>  static bool is_xdp_frame(void *ptr)
>  {
>         return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> @@ -1369,6 +1374,9 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
>  {
>         napi_enable(napi);
>
> +       if (vq->reset)
> +               return;
> +
>         /* If all buffers were filled by other side before we napi_enabled, we
>          * won't get another interrupt, so process any outstanding packets now.
>          * Call local_bh_enable after to trigger softIRQ processing.
> @@ -1413,6 +1421,10 @@ static void refill_work(struct work_struct *work)
>                 struct receive_queue *rq = &vi->rq[i];
>
>                 napi_disable(&rq->napi);
> +               if (rq->vq->reset) {
> +                       virtnet_napi_enable(rq->vq, &rq->napi);
> +                       continue;
> +               }
>                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>                 virtnet_napi_enable(rq->vq, &rq->napi);
>
> @@ -1523,6 +1535,9 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>         if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
>                 return;
>
> +       if (sq->vq->reset)
> +               return;
> +
>         if (__netif_tx_trylock(txq)) {
>                 do {
>                         virtqueue_disable_cb(sq->vq);
> @@ -1769,6 +1784,114 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>         return NETDEV_TX_OK;
>  }
>
> +static int virtnet_rx_vq_disable(struct virtnet_info *vi,
> +                                struct receive_queue *rq)
> +{
> +       int err;
> +
> +       napi_disable(&rq->napi);
> +
> +       err = virtio_reset_vq(rq->vq);
> +       if (err)
> +               goto err;
> +
> +       virtnet_rq_free_unused_bufs(vi, rq);
> +
> +       vring_release_virtqueue(rq->vq);
> +
> +       return 0;
> +
> +err:
> +       virtnet_napi_enable(rq->vq, &rq->napi);
> +       return err;
> +}
> +
> +static int virtnet_tx_vq_disable(struct virtnet_info *vi,
> +                                struct send_queue *sq)
> +{
> +       struct netdev_queue *txq;
> +       int err, qindex;
> +
> +       qindex = sq - vi->sq;
> +
> +       txq = netdev_get_tx_queue(vi->dev, qindex);
> +       __netif_tx_lock_bh(txq);
> +
> +       netif_stop_subqueue(vi->dev, qindex);
> +       virtnet_napi_tx_disable(&sq->napi);
> +
> +       err = virtio_reset_vq(sq->vq);
> +       if (err) {
> +               virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> +               netif_start_subqueue(vi->dev, qindex);
> +
> +               __netif_tx_unlock_bh(txq);
> +               return err;
> +       }
> +       __netif_tx_unlock_bh(txq);
> +
> +       virtnet_sq_free_unused_bufs(vi, sq);
> +
> +       vring_release_virtqueue(sq->vq);
> +
> +       return 0;
> +}
> +
> +static int virtnet_tx_vq_enable(struct virtnet_info *vi, struct send_queue *sq)
> +{
> +       int err;
> +
> +       err = virtio_enable_resetq(sq->vq);
> +       if (!err)
> +               netif_start_subqueue(vi->dev, sq - vi->sq);
> +
> +       virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> +
> +       return err;
> +}
> +
> +static int virtnet_rx_vq_enable(struct virtnet_info *vi,
> +                               struct receive_queue *rq)
> +{
> +       int err;

So the API should be design in a consistent way.

In rx_vq_disable() we do:

reset()
detach_unused_bufs()
vring_release_virtqueue()

here it's better to exactly the reverse

vring_attach_virtqueue() // this is the helper I guess in patch 5,
reverse of the vring_release_virtqueue()
try_refill_recv() // reverse of the detach_unused_bufs()
enable_reset() // reverse of the reset

So did for the tx (no need for refill in that case).

> +
> +       err = virtio_enable_resetq(rq->vq);
> +
> +       virtnet_napi_enable(rq->vq, &rq->napi);
> +
> +       return err;
> +}
> +
> +static int virtnet_rx_vq_reset(struct virtnet_info *vi, int i)
> +{
> +       int err;
> +
> +       err = virtnet_rx_vq_disable(vi, vi->rq + i);
> +       if (err)
> +               return err;
> +
> +       err = virtnet_rx_vq_enable(vi, vi->rq + i);
> +       if (err)
> +               netdev_err(vi->dev,
> +                          "enable rx reset vq fail: rx queue index: %d err: %d\n", i, err);
> +       return err;
> +}
> +
> +static int virtnet_tx_vq_reset(struct virtnet_info *vi, int i)
> +{
> +       int err;
> +
> +       err = virtnet_tx_vq_disable(vi, vi->sq + i);
> +       if (err)
> +               return err;
> +
> +       err = virtnet_tx_vq_enable(vi, vi->sq + i);
> +       if (err)
> +               netdev_err(vi->dev,
> +                          "enable tx reset vq fail: tx queue index: %d err: %d\n", i, err);
> +       return err;
> +}
> +
>  /*
>   * Send command via the control virtqueue and check status.  Commands
>   * supported by the hypervisor, as indicated by feature bits, should
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F261C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0FF38329D;
	Wed, 16 Feb 2022 04:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRxlxnBHT158; Wed, 16 Feb 2022 04:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7BD2282F99;
	Wed, 16 Feb 2022 04:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57D8DC001A;
	Wed, 16 Feb 2022 04:14:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 327A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B67841671
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tC_KIYBXW17h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F72441649
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8MTfL3kzhS2e/wtfvfkaRaYdGxaNdzWBHJ20dictyk=;
 b=Z4sBmeh7VPNXdbHyaUh5Tuta/AKvrSIksloiEfS1uhFA5iBYM55HpwwEmSrnjqsgs6bFeO
 8ZqHLko+E9S9sPoGHF/JhJwH17A9KEIRNVHE/48TmVhhc22UyGM3UcOBVc6ToILjGeKBDi
 aZhTnJgkHDcN1gErHUslnzapDpCtgfQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-XyYlmUXjN_elv98tD8Dd0Q-1; Tue, 15 Feb 2022 23:14:51 -0500
X-MC-Unique: XyYlmUXjN_elv98tD8Dd0Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 q17-20020a2e7511000000b0023c95987502so446633ljc.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M8MTfL3kzhS2e/wtfvfkaRaYdGxaNdzWBHJ20dictyk=;
 b=fL8KfmOfhsptg+if1PCu0uiVB/HjfDdAr5kkRIsOJoULUsdIaS/lZIIzjwR4M9ylS3
 XhYrchT8GsTPHr7cfUskZaozvtS4XFFcwlGNkPxW+Ir0vCxfpdba322Ahj9dypcCeqCB
 hjnM5fWTqZU4/61SNFeLFCZFpOjS6lniVf56m5EZvjUSx5z7KqtpiTMnp4wba4RCsPkj
 IZzN0reebDzwl08aMcf6O+TdRDBVVLCz+5+0ulV0L/fmQ4EWcBBDrLiFvfg99ULeNdbz
 Rv2Q4MLDtNqPYqBLNpGULOFSchFSt4F6sJYkEn2GfOVIwkRb7LFDqWg98XERusBA/42e
 U1SA==
X-Gm-Message-State: AOAM533wBit0qRChWadnyPpRB1wU3qSY4qWWiRjqL7leMy06/DDygoPm
 2Cei9dPMg2EsDqf3v/MFgia0cktMgAJgqH7kadN3QMNBcyLrubyMNiRlCtv6dbw1MnqB+6NKP7s
 zRvoVO7vW8lA2eE/lt6H83e1VHPp7iQSPuqiJJEklGqYil3tnkgVQVr+Fdw==
X-Received: by 2002:a2e:bd03:0:b0:244:d446:27dc with SMTP id
 n3-20020a2ebd03000000b00244d44627dcmr653233ljq.307.1644984890106; 
 Tue, 15 Feb 2022 20:14:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIwQDLTLmesj7I7mqh58WPdKsiWqCpL4QKOR+Hkpz63Lh50HmsX1HyFv+emKZYY3EDS4Va/5Qfoi2ktDcaOC4=
X-Received: by 2002:a2e:bd03:0:b0:244:d446:27dc with SMTP id
 n3-20020a2ebd03000000b00244d44627dcmr653217ljq.307.1644984889914; Tue, 15 Feb
 2022 20:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-23-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-23-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:39 +0800
Message-ID: <CACGkMEsQB0XCZb39QVsv9VM0qJpc__jucgUCGV9LU5kPTze6Hg@mail.gmail.com>
Subject: Re: [PATCH v5 22/22] virtio_net: support set_ringparam
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

On Mon, Feb 14, 2022 at 4:15 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Support set_ringparam based on virtio queue reset.
>
> The rx,tx_pending required to be passed must be power of 2.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f9bb760c6dbd..bf460ea87354 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2308,6 +2308,55 @@ static void virtnet_get_ringparam(struct net_device *dev,
>         ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
>  }
>
> +static int virtnet_set_ringparam(struct net_device *dev,
> +                                struct ethtool_ringparam *ring,
> +                                struct kernel_ethtool_ringparam *kernel_ring,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +       u32 rx_pending, tx_pending;
> +       int i, err;
> +
> +       if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> +               return -EINVAL;
> +
> +       rx_pending = virtqueue_get_vring_size(vi->rq[0].vq);
> +       tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
> +
> +       if (ring->rx_pending == rx_pending &&
> +           ring->tx_pending == tx_pending)
> +               return 0;
> +
> +       if (ring->rx_pending > virtqueue_get_vring_max_size(vi->rq[0].vq))
> +               return -EINVAL;
> +
> +       if (ring->tx_pending > virtqueue_get_vring_max_size(vi->sq[0].vq))
> +               return -EINVAL;
> +
> +       if (!is_power_of_2(ring->rx_pending))
> +               return -EINVAL;
> +
> +       if (!is_power_of_2(ring->tx_pending))
> +               return -EINVAL;

We'd better leave those checks to the virtio core where it knows
packed virtqueue doesn't have this limitation.

> +
> +       for (i = 0; i < vi->max_queue_pairs; i++) {
> +               if (ring->tx_pending != tx_pending) {
> +                       virtio_set_max_ring_num(vi->vdev, ring->tx_pending);

The name is kind of confusing, I guess it should not be the maximum
ring. And this needs to be done after the reset, and it would be even
better to disallow such change when virtqueue is not resetted.

> +                       err = virtnet_tx_vq_reset(vi, i);
> +                       if (err)
> +                               return err;
> +               }
> +
> +               if (ring->rx_pending != rx_pending) {
> +                       virtio_set_max_ring_num(vi->vdev, ring->rx_pending);
> +                       err = virtnet_rx_vq_reset(vi, i);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return 0;
> +}
>
>  static void virtnet_get_drvinfo(struct net_device *dev,
>                                 struct ethtool_drvinfo *info)
> @@ -2541,6 +2590,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>         .get_drvinfo = virtnet_get_drvinfo,
>         .get_link = ethtool_op_get_link,
>         .get_ringparam = virtnet_get_ringparam,
> +       .set_ringparam = virtnet_set_ringparam,
>         .get_strings = virtnet_get_strings,
>         .get_sset_count = virtnet_get_sset_count,
>         .get_ethtool_stats = virtnet_get_ethtool_stats,
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93002C433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 07:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18CEF6F4CC;
	Thu, 17 Feb 2022 07:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ya6UfE03OBiR; Thu, 17 Feb 2022 07:21:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 915036EE12;
	Thu, 17 Feb 2022 07:21:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71722C002D;
	Thu, 17 Feb 2022 07:21:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C621C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1896C83EA6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIj836brQfx9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:21:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0659283E9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645082501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MK/w5CaqVN2WaOvoDgze1gKvnvxbRCEDpuTeg5VSM88=;
 b=C04arsOX0E9aF5ztCZOaR8fKXJNp2cEUt9GUJG86++LEP17Ljrge1GxiJKvtjFmdob4O1+
 BoeFtUZLB7e7hmwXLWHWWEcjsFSSs+8/zElZvrU5z2vNG7HjSq98CHMxE+YqkdJGjTwTej
 LwylsQsjV46DtzbU1HwikzrOavcUPGA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-lWK8zVt8OdeYlZnM-YguWg-1; Thu, 17 Feb 2022 02:21:38 -0500
X-MC-Unique: lWK8zVt8OdeYlZnM-YguWg-1
Received: by mail-lj1-f198.google.com with SMTP id
 bn10-20020a05651c178a00b00244baa268b6so1875946ljb.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 23:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MK/w5CaqVN2WaOvoDgze1gKvnvxbRCEDpuTeg5VSM88=;
 b=pEnD6BMLY5FOAVpgpz2sfwJyNgIfbw1Ts8XFzfu8kJaWIJhih137emDI53JwSx9Ldl
 j09gQesdjzFNe2rngDzititbjugg/THgMhSW3WM3wxHmQezE1qZ/yth7nwLLpk8HaQ15
 aZO1kTu3zf+aIzkvbm9VGehaXa5mZFwOYJiWKZhsNLZ997y6EdcquVVkGTm0pGWu5QJj
 T/sqyd8mfjMS7QfPg1eznL6fXCivLSJ+3QLk/MGufJQOhYVBcZZOsDy4S/jWUbrHTaHb
 hIcwYlH3CVj5w9kuSm1dnskCg9AZ6GNKSOeHQEylR4f1blqQ7dexGyCRwmse1uIVd4Pg
 Oijw==
X-Gm-Message-State: AOAM532Gu9OsXIAX7flW8mkRM2S7sRKkSkUreJrOmnKNUxPe1a6lUAcL
 vSqpQblRR0TUdUp2hBqRlx5VVs7aDAFSVHyO+xz2oxIU/nA7vZ9uMGg613papKo5RKUiJXwLUXX
 p7B2PQfNBiYViBZw3NAuZZ6i1tcuocY9ApJW8wqhzZ92FlphIm6c/P1hbSw==
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr1234544lfq.84.1645082497394; 
 Wed, 16 Feb 2022 23:21:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbfpKRrqedpKyeZauCLg5Kmr+HPSiEonm1qoPRESgaCwlyrbWvcenrKeaJ0wCQuxOVhIznhGs2jYN71FJfjD0=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr1234535lfq.84.1645082497203; Wed, 16 Feb
 2022 23:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
 <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
 <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Feb 2022 15:21:26 +0800
Message-ID: <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
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

On Wed, Feb 16, 2022 at 3:52 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 16 Feb 2022 12:14:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Sets the default maximum ring num based on virtio_set_max_ring_num().
> > >
> > > The default maximum ring num is 1024.
> >
> > Having a default value is pretty useful, I see 32K is used by default for IFCVF.
> >
> > Rethink this, how about having a different default value based on the speed?
> >
> > Without SPEED_DUPLEX, we use 1024. Otherwise
> >
> > 10g 4096
> > 40g 8192
>
> We can define different default values of tx and rx by the way. This way I can
> just use it in the new interface of find_vqs().
>
> without SPEED_DUPLEX:  tx 512 rx 1024
>

Any reason that TX is smaller than RX?

Thanks

> Thanks.
>
>
> >
> > etc.
> >
> > (The number are just copied from the 10g/40g default parameter from
> > other vendors)
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index a4ffd7cdf623..77e61fe0b2ce 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
> > >  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> > >  #define GOOD_COPY_LEN  128
> > >
> > > +#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
> > > +
> > >  #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
> > >
> > >  /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
> > > @@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >                         ctx[rxq2vq(i)] = true;
> > >         }
> > >
> > > +       virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
> > > +
> > >         ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> > >                                   names, ctx, NULL);
> > >         if (ret)
> > > --
> > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

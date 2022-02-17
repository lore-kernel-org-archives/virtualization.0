Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B4C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 09:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0171C83EDE;
	Thu, 17 Feb 2022 09:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LY2YmQD2Slhg; Thu, 17 Feb 2022 09:38:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9702E81336;
	Thu, 17 Feb 2022 09:38:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DDFEC0021;
	Thu, 17 Feb 2022 09:38:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D70FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE2B240289
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZbAZxDAobMwK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:38:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D959C40242
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:38:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4iqipY_1645090685; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4iqipY_1645090685) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Feb 2022 17:38:06 +0800
Message-ID: <1645090228.2917905-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
Date: Thu, 17 Feb 2022 17:30:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
 <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
 <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
In-Reply-To: <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 17 Feb 2022 15:21:26 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Feb 16, 2022 at 3:52 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Wed, 16 Feb 2022 12:14:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > Sets the default maximum ring num based on virtio_set_max_ring_num().
> > > >
> > > > The default maximum ring num is 1024.
> > >
> > > Having a default value is pretty useful, I see 32K is used by default for IFCVF.
> > >
> > > Rethink this, how about having a different default value based on the speed?
> > >
> > > Without SPEED_DUPLEX, we use 1024. Otherwise
> > >
> > > 10g 4096
> > > 40g 8192
> >
> > We can define different default values of tx and rx by the way. This way I can
> > just use it in the new interface of find_vqs().
> >
> > without SPEED_DUPLEX:  tx 512 rx 1024
> >
>
> Any reason that TX is smaller than RX?
>

I've seen some NIC drivers with default tx smaller than rx.

One problem I have now is that inside virtnet_probe, init_vqs is before getting
speed/duplex. I'm not sure, can the logic to get speed/duplex be put before
init_vqs? Is there any risk?

Can you help me?

Thanks.

> Thanks
>
> > Thanks.
> >
> >
> > >
> > > etc.
> > >
> > > (The number are just copied from the 10g/40g default parameter from
> > > other vendors)
> > >
> > > Thanks
> > >
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index a4ffd7cdf623..77e61fe0b2ce 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
> > > >  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> > > >  #define GOOD_COPY_LEN  128
> > > >
> > > > +#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
> > > > +
> > > >  #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
> > > >
> > > >  /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
> > > > @@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > >                         ctx[rxq2vq(i)] = true;
> > > >         }
> > > >
> > > > +       virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
> > > > +
> > > >         ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> > > >                                   names, ctx, NULL);
> > > >         if (ret)
> > > > --
> > > > 2.31.0
> > > >
> > >
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

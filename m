Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6841C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:44:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FC764E30
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FC764E30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB430866AC;
	Tue,  2 Feb 2021 23:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tQBaB25iOaZ; Tue,  2 Feb 2021 23:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 20F5486691;
	Tue,  2 Feb 2021 23:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01131C0174;
	Tue,  2 Feb 2021 23:44:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFCD6C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8DE8420412
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxSS53fCPcyF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by silver.osuosl.org (Postfix) with ESMTPS id 27451203CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:44:40 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id g17so5234038vkk.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HV6jn1Mj+6Q0GVXqO0XZPb8NAVpZ2ZPSr94NS/JzLes=;
 b=hgl0BfteTIjSdaDHtoRThNG0Lmysvudip/dcs8yV5lA53PBUx4otbyLr6lSBZHS7+a
 DG5UJI20ccOenJmrtIDhJr2RBOEXmcgif0f83ms0H4uf1eOzRUARnZV6kpUBaGBr95WM
 jcDj/guJ8bnj5ROQAqlMB2uFzQzRHh8y4Md12s6fW8Vt4lfwnJEufIFX2a2fHTbkEVMa
 6Cz7RIne8kfb02OaEJsoqaFeko9TR/9oiIEjqss2/vS27M/IgLcBCA6KCHEHDp+E1lLS
 oMgWRiT3DYq7hPNfuK6F/qm3ViNEvr4usbtkJJI3yYUp3edp7eXl2bIe/5TWO0rMSz+0
 3Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HV6jn1Mj+6Q0GVXqO0XZPb8NAVpZ2ZPSr94NS/JzLes=;
 b=UEK/yxaqM34KZioK1HoBT4sV9ViqlTaGsA8cLVPjwQqhtGGQTj84bRJGNOy+AoJy7d
 Urhe63g4+Cca90FznnB88PSL+WjDDY0vJDeP+CPxqYikwq0AF9O/ZHKt2g/duTYpA7ic
 T//ng4hYQbc22yFHMzPAPdBBYJmuEFpAZDFObd3rs/JmTo2Q6YswDfyNVxb4IsNtcrdI
 0P+8rDrMhAhOMfN5j1iWSRC1Wp65PcRBHaWJT7rA0fF2CYz6o/ysNozSnJsHImv9gEb3
 MrcHaDl3CifqQD6ZEHpdELjyRQdcJeizPDpQv6Yw6Qboxo37J0GWfP0quvcdjMxH0htr
 et4A==
X-Gm-Message-State: AOAM530JMm6npuQaR2LKNShBgfp+hHDosyeSLcMn26wIFAJGnV2ltxdn
 4zlDhJzK99MgZrOMk7apKwZiuKatUsY=
X-Google-Smtp-Source: ABdhPJw4RAYvF2NRXS7NGR4BxmEoQ0iKfFk8vt/XBXZdsYbJcZac7LV7uU5bo8u6eZwYnuSi8MneGw==
X-Received: by 2002:a1f:4ec7:: with SMTP id c190mr125880vkb.11.1612309478714; 
 Tue, 02 Feb 2021 15:44:38 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id j8sm15838vsj.29.2021.02.02.15.44.37
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Feb 2021 15:44:37 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id p20so12178200vsq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 15:44:37 -0800 (PST)
X-Received: by 2002:a67:cb1a:: with SMTP id b26mr225567vsl.22.1612309476560;
 Tue, 02 Feb 2021 15:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20210202090724-mutt-send-email-mst@kernel.org>
 <CA+FuTSeEVvtmmQ2HioTUrA6nX9s6yLEvNXfg=fLKw6X+E9wWow@mail.gmail.com>
 <20210202175934-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210202175934-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 2 Feb 2021 18:43:59 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfRHMDd-Q4UB4vVsdbs=YpP-WzUMtNGiKwLpEQaAR2Xdg@mail.gmail.com>
Message-ID: <CA+FuTSfRHMDd-Q4UB4vVsdbs=YpP-WzUMtNGiKwLpEQaAR2Xdg@mail.gmail.com>
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Feb 2, 2021 at 6:06 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 02, 2021 at 05:17:13PM -0500, Willem de Bruijn wrote:
> > On Tue, Feb 2, 2021 at 9:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 11:22:32AM -0500, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > Add optional PTP hardware timestamp offload for virtio-net.
> > > >
> > > > Accurate RTT measurement requires timestamps close to the wire.
> > > > Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> > > > virtio-net header is expanded with room for a timestamp. A host may
> > > > pass receive timestamps for all or some packets. A timestamp is valid
> > > > if non-zero.
> > > >
> > > > The timestamp straddles (virtual) hardware domains. Like PTP, use
> > > > international atomic time (CLOCK_TAI) as global clock base. It is
> > > > guest responsibility to sync with host, e.g., through kvm-clock.
> > > >
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > ---
> > > >  drivers/net/virtio_net.c        | 20 +++++++++++++++++++-
> > > >  include/uapi/linux/virtio_net.h | 12 ++++++++++++
> > > >  2 files changed, 31 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index b917b7333928..57744bb6a141 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -204,6 +204,9 @@ struct virtnet_info {
> > > >       /* Guest will pass tx path info to the host */
> > > >       bool has_tx_hash;
> > > >
> > > > +     /* Host will pass CLOCK_TAI receive time to the guest */
> > > > +     bool has_rx_tstamp;
> > > > +
> > > >       /* Has control virtqueue */
> > > >       bool has_cvq;
> > > >
> > > > @@ -292,6 +295,13 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> > > >       return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> > > >  }
> > > >
> > > > +static inline struct virtio_net_hdr_v12 *skb_vnet_hdr_12(struct sk_buff *skb)
> > > > +{
> > > > +     BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v12) > sizeof(skb->cb));
> > > > +
> > > > +     return (void *)skb->cb;
> > > > +}
> > > > +
> > > >  /*
> > > >   * private is used to chain pages for big packets, put the whole
> > > >   * most recent used list in the beginning for reuse
> > > > @@ -1082,6 +1092,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > >               goto frame_err;
> > > >       }
> > > >
> > > > +     if (vi->has_rx_tstamp)
> > > > +             skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(skb_vnet_hdr_12(skb)->tstamp);
> > > > +
> > > >       skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > > >       skb->protocol = eth_type_trans(skb, dev);
> > > >       pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> > > > @@ -3071,6 +3084,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >               vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> > > >       }
> > > >
> > > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
> > > > +             vi->has_rx_tstamp = true;
> > > > +             vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
> > > > +     }
> > > > +
> > > >       if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
> > > >           virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > > >               vi->any_header_sg = true;
> > > > @@ -3261,7 +3279,7 @@ static struct virtio_device_id id_table[] = {
> > > >       VIRTIO_NET_F_CTRL_MAC_ADDR, \
> > > >       VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> > > >       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> > > > -     VIRTIO_NET_F_TX_HASH
> > > > +     VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
> > > >
> > > >  static unsigned int features[] = {
> > > >       VIRTNET_FEATURES,
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > > index f6881b5b77ee..0ffe2eeebd4a 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -57,6 +57,7 @@
> > > >                                        * Steering */
> > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > >
> > > > +#define VIRTIO_NET_F_RX_TSTAMP         55    /* Host sends TAI receive time */
> > > >  #define VIRTIO_NET_F_TX_HASH   56    /* Guest sends hash report */
> > > >  #define VIRTIO_NET_F_HASH_REPORT  57 /* Supports hash report */
> > > >  #define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > > > @@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
> > > >       };
> > > >  };
> > > >
> > > > +struct virtio_net_hdr_v12 {
> > > > +     struct virtio_net_hdr_v1 hdr;
> > > > +     struct {
> > > > +             __le32 value;
> > > > +             __le16 report;
> > > > +             __le16 flow_state;
> > > > +     } hash;
> > > > +     __virtio32 reserved;
> > >
> > >
> > > Does endian-ness matter? If not - just u32?
> >
> > I suppose it does not matter as long as this is reserved. Should it be
> > __le32, at least?
>
> One can safely assign 0 to any value.

Ack.

>
> > > > +     __virtio64 tstamp;
> > > > +};
> > > > +
> > >
> > > Given it's only available in modern devices, I think we
> > > can make this __le64 tstamp.
> >
> > Actually, would it be possible to make new features available on
> > legacy devices? There is nothing in the features bits precluding it.
>
> I think it won't be possible: you are using feature bit 55,
> legacy devices have up to 32 feature bits. And of course the
> header looks a bit differently for legacy, you would have to add special
> code to handle that when mergeable buffers are off.

I think I can make the latter work. I did start without a dependency
on the v1 header initially.

Feature bit array length I had not considered. Good point. Need to
think about that. It would be very appealing if in particular the
tx-hash feature could work in legacy mode.

> >
> > I have a revised patchset almost ready. I suppose I should send it as
> > RFC again, and simultaneously file an OASIS ballot for each feature?
>
> that would be great.

Will do, thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

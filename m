Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595BC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:02:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49E0601FB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 23:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E0601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81C9E870D1;
	Tue,  2 Feb 2021 23:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpD+BIDhu+lc; Tue,  2 Feb 2021 23:02:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AFA998706C;
	Tue,  2 Feb 2021 23:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88227C0FA7;
	Tue,  2 Feb 2021 23:02:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B77FFC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A865F85E77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gP_u2w48NDdA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:02:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BEBF5854CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 23:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612306961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDg4iKymZ53hNxtNIr/W8exxkDX1y1fBofy+s8scyQM=;
 b=Se4zi40Wuv+ykkkndtF0v4fvxMOfDWLgIFUcy8305ZXfM7IMedn3ayxaeRXPsT/AovjkLr
 GPUDDxonlWWnERy8sg+Hibt1ESEaMSwGwY6ynDvROU22txhmNsql3581zR8DVIVUDMA01x
 jHeoS/YYJ/TEjgU+isUrZ1HOmvbexsM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-P0LRx04_NEuGd16Rm0DPoA-1; Tue, 02 Feb 2021 18:02:40 -0500
X-MC-Unique: P0LRx04_NEuGd16Rm0DPoA-1
Received: by mail-wm1-f70.google.com with SMTP id z67so2149476wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 15:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LDg4iKymZ53hNxtNIr/W8exxkDX1y1fBofy+s8scyQM=;
 b=r+gobQ8wVd6+M7Tt6Xu+0289KpRP1dSwW1p4xyEUu06tMNpKnYorZKtdc3t2pRZI79
 LuxuvDRtv8OMkvzp1SrfEWxKv1EnHuQzCNrEH4sGKKvEHjKopcPcXLxusyBI8S9+K/rf
 cOsdolazhRYcprtXb2tSDM6Tbd9Lr6R89iEb0y2ooZDPxm+GOdfChESfMj+UnSiWH00B
 /ZwozeBfaIA+UWkeVVLjSKxsZoPKH4ADCAfU8rrZRu9EtLqOkOjbR5YWIGzAFvvFn7ox
 bAt38sJxLeEdCbaHugWhj3PM5PUuoCKr2r9YynE1HfueOc1hg30y0Mqvds6B8I/ScRwz
 x9/g==
X-Gm-Message-State: AOAM532Ax6Hfdckqhpj759EhA1KJ2gV+zHDAr4aHirkMe2DHZRMJRQcr
 MYxYPxZKNZT0jvxb3D9htGcrJlxQwnHje6Q1DzqkybkE7MpWv5x/NYvWsAskwAnwmOR0FbVRxj5
 hpGMLx2/z8W0dhSg/gBXaeygDIiJbzqh3iPdrGoX9Tg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr317045wrj.225.1612306958848;
 Tue, 02 Feb 2021 15:02:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7ozq2UgBjdAGg7+Fmg2ziWMUdJw6kuyXQQMlyA3fQ392T9ZIlR5Tv21sW6hC+KMtJGHELFg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr317029wrj.225.1612306958663;
 Tue, 02 Feb 2021 15:02:38 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id s4sm89994wrt.85.2021.02.02.15.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 15:02:37 -0800 (PST)
Date: Tue, 2 Feb 2021 18:02:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
Message-ID: <20210202175934-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20210202090724-mutt-send-email-mst@kernel.org>
 <CA+FuTSeEVvtmmQ2HioTUrA6nX9s6yLEvNXfg=fLKw6X+E9wWow@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSeEVvtmmQ2HioTUrA6nX9s6yLEvNXfg=fLKw6X+E9wWow@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
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

On Tue, Feb 02, 2021 at 05:17:13PM -0500, Willem de Bruijn wrote:
> On Tue, Feb 2, 2021 at 9:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 11:22:32AM -0500, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Add optional PTP hardware timestamp offload for virtio-net.
> > >
> > > Accurate RTT measurement requires timestamps close to the wire.
> > > Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> > > virtio-net header is expanded with room for a timestamp. A host may
> > > pass receive timestamps for all or some packets. A timestamp is valid
> > > if non-zero.
> > >
> > > The timestamp straddles (virtual) hardware domains. Like PTP, use
> > > international atomic time (CLOCK_TAI) as global clock base. It is
> > > guest responsibility to sync with host, e.g., through kvm-clock.
> > >
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  drivers/net/virtio_net.c        | 20 +++++++++++++++++++-
> > >  include/uapi/linux/virtio_net.h | 12 ++++++++++++
> > >  2 files changed, 31 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index b917b7333928..57744bb6a141 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -204,6 +204,9 @@ struct virtnet_info {
> > >       /* Guest will pass tx path info to the host */
> > >       bool has_tx_hash;
> > >
> > > +     /* Host will pass CLOCK_TAI receive time to the guest */
> > > +     bool has_rx_tstamp;
> > > +
> > >       /* Has control virtqueue */
> > >       bool has_cvq;
> > >
> > > @@ -292,6 +295,13 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> > >       return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> > >  }
> > >
> > > +static inline struct virtio_net_hdr_v12 *skb_vnet_hdr_12(struct sk_buff *skb)
> > > +{
> > > +     BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v12) > sizeof(skb->cb));
> > > +
> > > +     return (void *)skb->cb;
> > > +}
> > > +
> > >  /*
> > >   * private is used to chain pages for big packets, put the whole
> > >   * most recent used list in the beginning for reuse
> > > @@ -1082,6 +1092,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >               goto frame_err;
> > >       }
> > >
> > > +     if (vi->has_rx_tstamp)
> > > +             skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(skb_vnet_hdr_12(skb)->tstamp);
> > > +
> > >       skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > >       skb->protocol = eth_type_trans(skb, dev);
> > >       pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> > > @@ -3071,6 +3084,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> > >       }
> > >
> > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_RX_TSTAMP)) {
> > > +             vi->has_rx_tstamp = true;
> > > +             vi->hdr_len = sizeof(struct virtio_net_hdr_v12);
> > > +     }
> > > +
> > >       if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
> > >           virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > >               vi->any_header_sg = true;
> > > @@ -3261,7 +3279,7 @@ static struct virtio_device_id id_table[] = {
> > >       VIRTIO_NET_F_CTRL_MAC_ADDR, \
> > >       VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> > >       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> > > -     VIRTIO_NET_F_TX_HASH
> > > +     VIRTIO_NET_F_TX_HASH, VIRTIO_NET_F_RX_TSTAMP
> > >
> > >  static unsigned int features[] = {
> > >       VIRTNET_FEATURES,
> > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > index f6881b5b77ee..0ffe2eeebd4a 100644
> > > --- a/include/uapi/linux/virtio_net.h
> > > +++ b/include/uapi/linux/virtio_net.h
> > > @@ -57,6 +57,7 @@
> > >                                        * Steering */
> > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > >
> > > +#define VIRTIO_NET_F_RX_TSTAMP         55    /* Host sends TAI receive time */
> > >  #define VIRTIO_NET_F_TX_HASH   56    /* Guest sends hash report */
> > >  #define VIRTIO_NET_F_HASH_REPORT  57 /* Supports hash report */
> > >  #define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > > @@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
> > >       };
> > >  };
> > >
> > > +struct virtio_net_hdr_v12 {
> > > +     struct virtio_net_hdr_v1 hdr;
> > > +     struct {
> > > +             __le32 value;
> > > +             __le16 report;
> > > +             __le16 flow_state;
> > > +     } hash;
> > > +     __virtio32 reserved;
> >
> >
> > Does endian-ness matter? If not - just u32?
> 
> I suppose it does not matter as long as this is reserved. Should it be
> __le32, at least?

One can safely assign 0 to any value.


> > > +     __virtio64 tstamp;
> > > +};
> > > +
> >
> > Given it's only available in modern devices, I think we
> > can make this __le64 tstamp.
> 
> Actually, would it be possible to make new features available on
> legacy devices? There is nothing in the features bits precluding it.

I think it won't be possible: you are using feature bit 55,
legacy devices have up to 32 feature bits. And of course the
header looks a bit differently for legacy, you would have to add special
code to handle that when mergeable buffers are off.

> 
> I have a revised patchset almost ready. I suppose I should send it as
> RFC again, and simultaneously file an OASIS ballot for each feature?

that would be great.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

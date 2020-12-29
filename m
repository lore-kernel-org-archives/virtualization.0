Return-Path: <SRS0=Ae13=GB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89627C433E0
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:06:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA68207FB
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA68207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F21B86DDC;
	Tue, 29 Dec 2020 01:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ny+2uBTCZSlg; Tue, 29 Dec 2020 01:06:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FBC686DDA;
	Tue, 29 Dec 2020 01:06:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 211ECC1DA5;
	Tue, 29 Dec 2020 01:06:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E82F9C1DA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB5862043E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4v+W4lufa+2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:06:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by silver.osuosl.org (Postfix) with ESMTPS id 9EA34203E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:06:09 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id p128so2668049vkf.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a5G4RQwBAVLyGfpmJVJyrosEMrC9BH0a7AK+9laY72M=;
 b=FXCJ4vOf0CaYtPxaTlOoON9DcPx5aOZzOjBK2Y3wyULwgEm+2UWoXc8EUBSzWEG4O4
 7lIe3rTSfIzWFmT+9Pjv/QQN9SI2mgUg4fvnod8TiX/o0+/2yLE0aVD903FNpJrLb4dP
 lor0aMXO37hLDjwXboNMLaAPAY+iow6bWfVvzMHItNq8CEJCgVuqblyO49YtXTJD73WZ
 h3rPsjcw80tzHorSNW6caG9lLyZgvqVZ69wU+RD5d4Vz1kA9WfQj83sx6ePaGa27cg4O
 +u17glZG8py0GQ66eGDxQ8QiIvtebnqLyUsIK24gloF36ySILNPoeFlhAZxbzw7eVrCy
 2Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a5G4RQwBAVLyGfpmJVJyrosEMrC9BH0a7AK+9laY72M=;
 b=DgHCTlLMdDMdf47v8/HWO64Bi+I7auZ8PuHbq/4Mmdkun4E1psqUeXJRhJkYRU3jen
 wFMOnlMjCR320pzYQln+7YPPRgFq/tbobijZSpTKl8rwlDNqoudaye4LmdSTLfXupscL
 vkHSDderP4/BemcyXb3QpNlES21Zoo6c73rmbujivkm/grsySCZZYLKYeHJN8d1WE+AJ
 CetWfZVitee9UR4U8AaIgWNd0yy9ccnsvxiCv2VWaP6KV3zHzJsvgCBfTe+Y5jidiQu7
 uSknUxz7ysJh5C2nsqyWF1u5rXdLBcuMJQDti6yC2jUEKR2HWP15j4GULJUAQmEbXqGf
 +g7A==
X-Gm-Message-State: AOAM533k7QrV64g5IwLfm+DGWOfa2u99UULy+JXxQnG0i/gNWRjBYJw/
 affQUzuIWfUWWM5pSvSPIpek4l9kQb8=
X-Google-Smtp-Source: ABdhPJzr+gIz659EiJnpzBAAUqrU2ZEck+MxfHPTeC/UVOoXOg3uJzHENFQWe+drF+czBkQWzy0NAQ==
X-Received: by 2002:a1f:72c6:: with SMTP id n189mr30633342vkc.13.1609203967936; 
 Mon, 28 Dec 2020 17:06:07 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id g4sm6656931uah.10.2020.12.28.17.06.07
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 17:06:07 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id e20so6344924vsr.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:06:07 -0800 (PST)
X-Received: by 2002:a67:bd0a:: with SMTP id y10mr28348842vsq.28.1609203966578; 
 Mon, 28 Dec 2020 17:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228122253-mutt-send-email-mst@kernel.org>
 <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
 <20201228162903-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228162903-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 20:05:29 -0500
X-Gmail-Original-Message-ID: <CA+FuTSffjFZGGwpMkpnTBbHHwnJN7if=0cVf0Des7Db5UFe0bw@mail.gmail.com>
Message-ID: <CA+FuTSffjFZGGwpMkpnTBbHHwnJN7if=0cVf0Des7Db5UFe0bw@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 7:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 02:30:31PM -0500, Willem de Bruijn wrote:
> > On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
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
> > > > +     __virtio64 tstamp;
> > > > +};
> > > > +
> > > >  #ifndef VIRTIO_NET_NO_LEGACY
> > > >  /* This header comes first in the scatter-gather list.
> > > >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> > >
> > >
> > > So it looks like VIRTIO_NET_F_RX_TSTAMP should depend on both
> > > VIRTIO_NET_F_RX_TSTAMP and VIRTIO_NET_F_HASH_REPORT then?
> >
> > Do you mean VIRTIO_NET_F_TX_TSTAMP depends on VIRTIO_NET_F_RX_TSTAMP?
> >
> > I think if either is enabled we need to enable the extended layout.
> > Regardless of whether TX_HASH or HASH_REPORT are enabled. If they are
> > not, then those fields are ignored.
>
> I mean do we waste the 8 bytes for hash if TSTAMP is set but HASH is not?
> If TSTAMP depends on HASH then point is moot.

True, but the two features really are independent.

I did consider using configurable metadata layout depending on
features negotiated. If there are tons of optional extensions, that
makes sense. But it is more complex and parsing error prone. With a
handful of options each of a few bytes, that did not seem worth the
cost to me at this point.

And importantly, such a mode can always be added later as a separate
VIRTIO_NET_F_PACKED_HEADER option.

If anything, perhaps if we increase the virtio_net_hdr_* allocation,
we should allocate some additional reserved space now? As each new
size introduces quite a bit of boilerplate. Also, e.g., in qemu just
to pass the sizes between virtio-net driver and vhost-net device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

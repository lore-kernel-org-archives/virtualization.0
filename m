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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D6C433DB
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 14:20:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853E7207C9
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 14:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853E7207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32FB586C50;
	Tue, 29 Dec 2020 14:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+raWOwnSg88; Tue, 29 Dec 2020 14:20:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A0D486C47;
	Tue, 29 Dec 2020 14:20:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C068C0893;
	Tue, 29 Dec 2020 14:20:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBD6C0174
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 14:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5B7FF203AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 14:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1HWvyQIAGU1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 14:20:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by silver.osuosl.org (Postfix) with ESMTPS id 38DF020368
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 14:20:54 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id p2so4364138uac.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 06:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BI7YG4D/264hD48pBSTZ/cy9Mm52S+GHG7c9KEI8pu0=;
 b=e81ECpwp2xvN7FDpxWZQqIl3/z89VLROaeHh9a+okFWDolCAek/dh8YpVolJ6Tjip/
 0hdwcqTKFd/nLcDajbtrs8pf3w/5Ms+ee+tgUn+0xaxYB52Bpy9BhFknAWBvlYbYZ0SI
 kz4izi51Xe5Xx4A5Azll9kChtXimwHc2eQ4viGcsJcN+qMIAtkLuPoFb+bdY8RTT02Yj
 QUkcnue03cIpYiT6jnixkVyTwdEbRaOkgjzR7j7bR3UxDx6pgHxqhieyEQfpyRuamkht
 qxK3Ixwy1TyZPCBCSw7eO7bC6YfQY4QUstQBn0n0d8sff2PzZpn6Q05XMVJ0tZ7U3xaU
 rg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BI7YG4D/264hD48pBSTZ/cy9Mm52S+GHG7c9KEI8pu0=;
 b=T/q0qkGuquy7B3iEcF2VkejwqZ1wZbhDESmcx4/qgodELP4gjkN0WxysruEZAHVsB5
 lN1ouE+gR1AHFkVzteCfv1H/eHAs+VTD7MweIj9jcR/r1ijm4zBibBSbLHJvAvy38b3u
 q7V3wEMuVDDMAol9z2IfcwjefQXEGxy1l8YIN7DY41Znz1HjdgVzusEd8/ooMCrXAx4P
 he5SKYti5h8yl1Wfd/Yxijj/HiqDuioNWfgMp/+mEJLAlGXdazxdiZy++APCHyPClq/F
 QFqs5PGXfL5aRz0wCTk/CGK1bbIWT8zLegk0ORMFeDgdowCWX5oxDlduIIwE+LS4NTQ0
 avMg==
X-Gm-Message-State: AOAM533e5bkaX885JHN8uCrLl3wnnjJfecbnlWhtwIVFbOxdqUqx8Eij
 1K+d81QTsQ4mETa2dtu4rLTp+YKAAmI=
X-Google-Smtp-Source: ABdhPJxnr9UYLAZNlqffxUgI5oXMrGw82/Sc8EcHbS3YTyq8EqBgeV09AcC/vum6Bcs7uwT9f0T8bQ==
X-Received: by 2002:ab0:e14:: with SMTP id g20mr23800473uak.112.1609251652605; 
 Tue, 29 Dec 2020 06:20:52 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com.
 [209.85.222.46])
 by smtp.gmail.com with ESMTPSA id g23sm9326018uan.7.2020.12.29.06.20.51
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Dec 2020 06:20:51 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a31so1921206uae.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 06:20:51 -0800 (PST)
X-Received: by 2002:ab0:2:: with SMTP id 2mr19938128uai.108.1609251650821;
 Tue, 29 Dec 2020 06:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228122253-mutt-send-email-mst@kernel.org>
 <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
 <20201228162903-mutt-send-email-mst@kernel.org>
 <CA+FuTSffjFZGGwpMkpnTBbHHwnJN7if=0cVf0Des7Db5UFe0bw@mail.gmail.com>
 <1881606476.40780520.1609233449300.JavaMail.zimbra@redhat.com>
In-Reply-To: <1881606476.40780520.1609233449300.JavaMail.zimbra@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 29 Dec 2020 09:20:14 -0500
X-Gmail-Original-Message-ID: <CA+FuTScycxSHqxvZZRjK9+tpXVV2iTv8vqeFc5U_m2CGDR3jog@mail.gmail.com>
Message-ID: <CA+FuTScycxSHqxvZZRjK9+tpXVV2iTv8vqeFc5U_m2CGDR3jog@mail.gmail.com>
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Dec 29, 2020 at 4:23 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > On Mon, Dec 28, 2020 at 7:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 02:30:31PM -0500, Willem de Bruijn wrote:
> > > > On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com>
> > > > wrote:
> > > > >
> > > > > On Mon, Dec 28, 2020 at 11:22:32AM -0500, Willem de Bruijn wrote:
> > > > > > From: Willem de Bruijn <willemb@google.com>
> > > > > >
> > > > > > Add optional PTP hardware timestamp offload for virtio-net.
> > > > > >
> > > > > > Accurate RTT measurement requires timestamps close to the wire.
> > > > > > Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> > > > > > virtio-net header is expanded with room for a timestamp. A host may
> > > > > > pass receive timestamps for all or some packets. A timestamp is valid
> > > > > > if non-zero.
> > > > > >
> > > > > > The timestamp straddles (virtual) hardware domains. Like PTP, use
> > > > > > international atomic time (CLOCK_TAI) as global clock base. It is
> > > > > > guest responsibility to sync with host, e.g., through kvm-clock.
> > > > > >
> > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > diff --git a/include/uapi/linux/virtio_net.h
> > > > > > b/include/uapi/linux/virtio_net.h
> > > > > > index f6881b5b77ee..0ffe2eeebd4a 100644
> > > > > > --- a/include/uapi/linux/virtio_net.h
> > > > > > +++ b/include/uapi/linux/virtio_net.h
> > > > > > @@ -57,6 +57,7 @@
> > > > > >                                        * Steering */
> > > > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > > > >
> > > > > > +#define VIRTIO_NET_F_RX_TSTAMP         55    /* Host sends TAI
> > > > > > receive time */
> > > > > >  #define VIRTIO_NET_F_TX_HASH   56    /* Guest sends hash report */
> > > > > >  #define VIRTIO_NET_F_HASH_REPORT  57 /* Supports hash report */
> > > > > >  #define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > > > > > @@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
> > > > > >       };
> > > > > >  };
> > > > > >
> > > > > > +struct virtio_net_hdr_v12 {
> > > > > > +     struct virtio_net_hdr_v1 hdr;
> > > > > > +     struct {
> > > > > > +             __le32 value;
> > > > > > +             __le16 report;
> > > > > > +             __le16 flow_state;
> > > > > > +     } hash;
> > > > > > +     __virtio32 reserved;
> > > > > > +     __virtio64 tstamp;
> > > > > > +};
> > > > > > +
> > > > > >  #ifndef VIRTIO_NET_NO_LEGACY
> > > > > >  /* This header comes first in the scatter-gather list.
> > > > > >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it
> > > > > >   must
> > > > >
> > > > >
> > > > > So it looks like VIRTIO_NET_F_RX_TSTAMP should depend on both
> > > > > VIRTIO_NET_F_RX_TSTAMP and VIRTIO_NET_F_HASH_REPORT then?
> > > >
> > > > Do you mean VIRTIO_NET_F_TX_TSTAMP depends on VIRTIO_NET_F_RX_TSTAMP?
> > > >
> > > > I think if either is enabled we need to enable the extended layout.
> > > > Regardless of whether TX_HASH or HASH_REPORT are enabled. If they are
> > > > not, then those fields are ignored.
> > >
> > > I mean do we waste the 8 bytes for hash if TSTAMP is set but HASH is not?
> > > If TSTAMP depends on HASH then point is moot.
> >
> > True, but the two features really are independent.
> >
> > I did consider using configurable metadata layout depending on
> > features negotiated. If there are tons of optional extensions, that
> > makes sense. But it is more complex and parsing error prone. With a
> > handful of options each of a few bytes, that did not seem worth the
> > cost to me at this point.
>
> Consider NFV workloads(64B) packet. Most fields of current vnet header
> is even a burdern.

Such workloads will not negotiate these features, I imagine.

I think this could only become an issue if a small packet workload
would want to negotiate one optional feature, without the others.

Even then, the actual cost of a few untouched bytes is negligible, as
long as the headers don't span cache-lines. I expect it to be cheaper
than having to parse a dynamic layout.

> It might be the time to introduce configurable or
> self-descriptive vnet header.

I did briefly toy with a type-val encoding. Not type-val-len, as all
options have fixed length (so far), so length can be left implicit.
But as each feature is negotiated before hand, the type can be left
implicit too. Leaving just the data elements tightly packed. As long
as order is defined.

> > And importantly, such a mode can always be added later as a separate
> > VIRTIO_NET_F_PACKED_HEADER option.
>
> What will do feature provide?

The tightly packed data elements. Strip out the elements for non
negotiated features. So if either tstamp option is negotiated, but
hash is not, exclude the 64b of hash fields. Note that I'm not
actually arguing for this (at this point).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

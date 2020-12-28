Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC3C433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:33:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0EA21534
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 21:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0EA21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D279886DCE;
	Mon, 28 Dec 2020 21:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RxqP4JSIItS; Mon, 28 Dec 2020 21:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE9DE81414;
	Mon, 28 Dec 2020 21:32:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A058DC0893;
	Mon, 28 Dec 2020 21:32:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59B16C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3AC6A871ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1iR0ZPgBn2E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:32:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ADBE8871EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 21:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609191175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kky13YYeGMwwJq8+sgfQqrY11M1VAYKqZAzG0e5Oygw=;
 b=cwjy8fTuKVAZPD70BW/HMpJNRJ/nzbtZuhXTquFaVVMStqREMPBd6cn9mJPFg3ni68c0ba
 mGBHHfsrdD7zwV84clzzNKF3mzL9NYzEYxUj3OgqMCSeiRnU2ylnhq48U1aKLUpSMhswxw
 1K9LkZvoxs3UAYc6U3GWZzfNUCtgXwk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-sZN0FeIcPPWtvxNegZmU8w-1; Mon, 28 Dec 2020 16:32:53 -0500
X-MC-Unique: sZN0FeIcPPWtvxNegZmU8w-1
Received: by mail-wm1-f71.google.com with SMTP id w204so245689wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 13:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kky13YYeGMwwJq8+sgfQqrY11M1VAYKqZAzG0e5Oygw=;
 b=dsBTz9hc5kkHRf1ZiWh5IWnhRxejA8KHe98OVoOHPoUXfJx137HPbV86PMzp1Aszka
 jX+GeMyS6Xi41iyJCADnUr+7/XExmQs0AiHioOtyLyu6bBtNZg6mPnXHtLQnxnBHjjOa
 ZS+GXj+QmqQSFvgNEWHlZJ3gf7EMUdia4Dmj1rQhuUesGEBEOzgp3BnwnZ9FCv3YpNoO
 ljIVdASOnQkZ5PsMT+bqSJTsviN3acOmqp+TYueeUwUjAaOBrlgRCIVRlGlj4qEi3NrV
 8enfuXMC9X/QTQRT+Fo4mzs/cWKNef5RBL+/yTnRU3yHw72PkNmrDpuT3SOKL8vcjPiN
 1hxA==
X-Gm-Message-State: AOAM5316Iwqf2/MyIfY1kZeDtDjTFO+WpHY1rRqhCPqn+of8WcXvOS4K
 RiTmNKHCIwnkJaCiwXqw4aTG7yKsoAUCm4dcwJKkJtanhoYVdHyDR8jKa2GI/kM56pUWWggoxDs
 8fov4azPKgYjYpKaLxbccmZrHV4MsEbJ9D8PqvTgTJw==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr54347190wro.97.1609191172394; 
 Mon, 28 Dec 2020 13:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlzIRThR3mCdWiZJqKQ1c7BH9fh0IsVBW/4vumudyEYrxI50Ukp5ubWsWCpdQyJq+bQyBQIw==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr54347180wro.97.1609191172185; 
 Mon, 28 Dec 2020 13:32:52 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id n8sm56352037wrs.34.2020.12.28.13.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 13:32:51 -0800 (PST)
Date: Mon, 28 Dec 2020 16:32:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
Message-ID: <20201228162903-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228122253-mutt-send-email-mst@kernel.org>
 <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 02:30:31PM -0500, Willem de Bruijn wrote:
> On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
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
> > > +     __virtio64 tstamp;
> > > +};
> > > +
> > >  #ifndef VIRTIO_NET_NO_LEGACY
> > >  /* This header comes first in the scatter-gather list.
> > >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> >
> >
> > So it looks like VIRTIO_NET_F_RX_TSTAMP should depend on both
> > VIRTIO_NET_F_RX_TSTAMP and VIRTIO_NET_F_HASH_REPORT then?
> 
> Do you mean VIRTIO_NET_F_TX_TSTAMP depends on VIRTIO_NET_F_RX_TSTAMP?
> 
> I think if either is enabled we need to enable the extended layout.
> Regardless of whether TX_HASH or HASH_REPORT are enabled. If they are
> not, then those fields are ignored.

I mean do we waste the 8 bytes for hash if TSTAMP is set but HASH is not?
If TSTAMP depends on HASH then point is moot.



> > I am not sure what does v12 mean here.
> >
> > virtio_net_hdr_v1 is just with VIRTIO_F_VERSION_1,
> > virtio_net_hdr_v1_hash is with VIRTIO_F_VERSION_1 and
> > VIRTIO_NET_F_HASH_REPORT.
> >
> > So this one is virtio_net_hdr_hash_tstamp I guess?
> 
> Sounds better, yes, will change that.
> 
> This was an attempt at identifying the layout with the likely next
> generation of the spec, 1.2. Similar to virtio_net_hdr_v1. But that is
> both premature and not very helpful.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

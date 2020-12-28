Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C315AC433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 19:31:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476CF22B2A
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 19:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476CF22B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C364C863E1;
	Mon, 28 Dec 2020 19:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJIN-_x9t1_u; Mon, 28 Dec 2020 19:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4127E85F46;
	Mon, 28 Dec 2020 19:31:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 289DAC0893;
	Mon, 28 Dec 2020 19:31:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 090B6C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC41F86E18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sfuCVofs2Tm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26EBB86E17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:31:11 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id q66so2522414vke.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3BJ5esnFQukEGJPUA6O1ADA24la79M+/XQkO2LPRNkc=;
 b=X+XV3552fBBK1tjz6k7cY5dwoNjbSrjXQc3RWSQdXdcf0dfgE9zyb5x1nX6/LMsK60
 rL17SN/dFQQ7K33yH9hwaZBWI7V3aEGm5l5802qrTv09DHOEcoUdDw20uFNyB0PSDJj9
 2NMnbeaQ/rBrZAMDg09MisaS6oTW/ulCMeMIP3T7lDBjdZOuwR7sIZQXzCCiDOIfqgYj
 TJbtPEZnhiGCcWOIIBjYG1Cba0Sf64Pfr2qn2F81VSChxVuOsPNqWcssLEbUdzeeEinp
 9j2guH6TQhNsx4COPZaJ2NHnFLEMFqOp4SzMc4geWkcmvefs4XhnGoETeFkb0LBRqvRz
 f3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3BJ5esnFQukEGJPUA6O1ADA24la79M+/XQkO2LPRNkc=;
 b=iltZLdiltr6MeBW8P+ED5ntsvaXvywK7Rsvs2pUL5L+JGgkldETt7bxIrlQjk2kM9k
 f7leJiHGfqIXA5uPUuXnloundQ8S+mmc8D7RrjiKCm+7Xc7vGKddxmgeuQ/x4QYqBfzM
 sAC+RZeL9x/RKXUnEX6Ub0cJA7gtV8VRYKPY+Xs0WKsLE+FQt+VK12jOTUrOnembXyrn
 /6c/KHk0Z0QUE39Cn25qLPkgtjtrsiw51N23ul3umx8BhK15d1uJhm3n1Q75+zyafcnh
 nYMJzzeDyIOkbALr3WrSUWpVI+lfwiaKqLl4nWB6rc5x9zyYZIbjAo75fXF32UA27Jvr
 BvZQ==
X-Gm-Message-State: AOAM533Sf/jbVuyxddwwly34dgyolB/M8LO8xxFZDmUl6jclY8PK5UPb
 N3MqXWUjFMBZg/NUs5v/d8pwHaG2Nzw=
X-Google-Smtp-Source: ABdhPJwmlZ9OH8iZG8e7E0otclKKCXEZ2RLol01quN3yOhfOFRO1uEhILBjEHTznZgbIQKye1A9aUw==
X-Received: by 2002:a1f:9156:: with SMTP id t83mr30109656vkd.3.1609183869767; 
 Mon, 28 Dec 2020 11:31:09 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177])
 by smtp.gmail.com with ESMTPSA id i18sm5499963vkp.48.2020.12.28.11.31.08
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 11:31:08 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id q66so2522397vke.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 11:31:08 -0800 (PST)
X-Received: by 2002:a1f:9ed4:: with SMTP id h203mr29461301vke.1.1609183868110; 
 Mon, 28 Dec 2020 11:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228122253-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228122253-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 14:30:31 -0500
X-Gmail-Original-Message-ID: <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
Message-ID: <CA+FuTScguDWkvk=Lc+GzP=UCK2wjRFNJ_GEn_bniHpCDWdkfjg@mail.gmail.com>
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

On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 11:22:32AM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Add optional PTP hardware timestamp offload for virtio-net.
> >
> > Accurate RTT measurement requires timestamps close to the wire.
> > Introduce virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> > virtio-net header is expanded with room for a timestamp. A host may
> > pass receive timestamps for all or some packets. A timestamp is valid
> > if non-zero.
> >
> > The timestamp straddles (virtual) hardware domains. Like PTP, use
> > international atomic time (CLOCK_TAI) as global clock base. It is
> > guest responsibility to sync with host, e.g., through kvm-clock.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index f6881b5b77ee..0ffe2eeebd4a 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -57,6 +57,7 @@
> >                                        * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> >
> > +#define VIRTIO_NET_F_RX_TSTAMP         55    /* Host sends TAI receive time */
> >  #define VIRTIO_NET_F_TX_HASH   56    /* Guest sends hash report */
> >  #define VIRTIO_NET_F_HASH_REPORT  57 /* Supports hash report */
> >  #define VIRTIO_NET_F_RSS       60    /* Supports RSS RX steering */
> > @@ -182,6 +183,17 @@ struct virtio_net_hdr_v1_hash {
> >       };
> >  };
> >
> > +struct virtio_net_hdr_v12 {
> > +     struct virtio_net_hdr_v1 hdr;
> > +     struct {
> > +             __le32 value;
> > +             __le16 report;
> > +             __le16 flow_state;
> > +     } hash;
> > +     __virtio32 reserved;
> > +     __virtio64 tstamp;
> > +};
> > +
> >  #ifndef VIRTIO_NET_NO_LEGACY
> >  /* This header comes first in the scatter-gather list.
> >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
>
>
> So it looks like VIRTIO_NET_F_RX_TSTAMP should depend on both
> VIRTIO_NET_F_RX_TSTAMP and VIRTIO_NET_F_HASH_REPORT then?

Do you mean VIRTIO_NET_F_TX_TSTAMP depends on VIRTIO_NET_F_RX_TSTAMP?

I think if either is enabled we need to enable the extended layout.
Regardless of whether TX_HASH or HASH_REPORT are enabled. If they are
not, then those fields are ignored.

> I am not sure what does v12 mean here.
>
> virtio_net_hdr_v1 is just with VIRTIO_F_VERSION_1,
> virtio_net_hdr_v1_hash is with VIRTIO_F_VERSION_1 and
> VIRTIO_NET_F_HASH_REPORT.
>
> So this one is virtio_net_hdr_hash_tstamp I guess?

Sounds better, yes, will change that.

This was an attempt at identifying the layout with the likely next
generation of the spec, 1.2. Similar to virtio_net_hdr_v1. But that is
both premature and not very helpful.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

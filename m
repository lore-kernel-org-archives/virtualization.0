Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05682C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:03:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718E2650EC
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718E2650EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0AA2940196;
	Tue,  9 Mar 2021 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwhwMzqdtn4B; Tue,  9 Mar 2021 14:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79A5042FBE;
	Tue,  9 Mar 2021 14:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FFB4C000B;
	Tue,  9 Mar 2021 14:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D81A1C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B37CC6F521
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0tE_rGsupWt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:03:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D392B6F5B6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 14:03:35 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id c10so27896398ejx.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ft5rd560a0W9wxTzYwRNovTAUDlXaQrOqyKdLfMHLs=;
 b=gUJlyg/5pLeWaXd2N9NNQZ8NbrIXx8As9ZuRUg03D0jpMX1dggNIiX81+CrM0dvfqV
 bETGkoHFu0y2s4uJr/WA/HDXUhVapWWNEIUrv71y8RnvHYt/ICGyDwlTeZ1CIIo6oOgf
 fbGwCWvn2RGvBtFKMRJIOga4IzaEWmx3GYa/VrBQCV2+EJdRrFPVU3FBHgAjZOOXMxNp
 P28+xHRk2mbnUGGro5CC4U5AvAjRz9sjseiZxvMA9cTsjnULKebfvYlAS6ChIaFPqTNC
 FVqUFtOIUUJoMrVQreOP7k5rAgliJ737LyGM/ozq6GVnx1qF9hBMlNDuw7ikpxEGbayK
 vT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ft5rd560a0W9wxTzYwRNovTAUDlXaQrOqyKdLfMHLs=;
 b=alCbtG905iZ3b7/GUDm41wMFIJK6gEnghNhtAz/HCSIH64XX5b0VzXz0SGzJ8HLfmn
 sT2sUJSk/SN7l0cHLTU+otgXeVPTfsRxNFpiv6g2uTiH53MErAux3Hxwi8RZdHCjrxGV
 ldz7VxYXfTBbcbpaQitOWbqzxsNMXf6T2HqypcAPbPvZHeZ6gL1iTfkhL59nGC2jAl3a
 ykjJzfYjtk/f6epyXFSoCR406aA3V0zgoIyQeyyRqsetF8AB0aTjojkWeZoVXWWPU8MH
 bi6cCcNhBgH2yUMMSXipmfTjH7hOP1L/Dt+8763XnnCFzG3enoa/3CGo6AXHij5Ef2xt
 egBw==
X-Gm-Message-State: AOAM533oDSysLQN9dQV0e08hmGNJZs82DGAiYgIiFtA02Ql/rcW3Ohh2
 1dY3FTx6Ybw6HP2Wx3Gs1gBvdHA1IMk=
X-Google-Smtp-Source: ABdhPJy45PGxKLwZP2BmK+2um03rSPplOTHd6nVEP8IhtpHYejHP6zi0l8TsdyFYwrK0XG5qpvNA/g==
X-Received: by 2002:a17:906:81d5:: with SMTP id
 e21mr19967434ejx.102.1615298613847; 
 Tue, 09 Mar 2021 06:03:33 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id kj3sm8481555ejc.117.2021.03.09.06.03.33
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 06:03:33 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id
 b2-20020a7bc2420000b029010be1081172so6421121wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 06:03:33 -0800 (PST)
X-Received: by 2002:a05:600c:2053:: with SMTP id
 p19mr4202330wmg.87.1615298612543; 
 Tue, 09 Mar 2021 06:03:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615199056.git.bnemeth@redhat.com>
 <8f2cb8f8614d86bba02df73c1a0665179583f1c3.1615199056.git.bnemeth@redhat.com>
 <20210309062116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210309062116-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 9 Mar 2021 09:02:52 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdXP-nOMWjw0hML3eOhFpApZLZhgENub7fLAUn3DMHmBg@mail.gmail.com>
Message-ID: <CA+FuTSdXP-nOMWjw0hML3eOhFpApZLZhgENub7fLAUn3DMHmBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Balazs Nemeth <bnemeth@redhat.com>,
 David Miller <davem@davemloft.net>
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

On Tue, Mar 9, 2021 at 6:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 08, 2021 at 11:31:25AM +0100, Balazs Nemeth wrote:
> > For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> > set) based on the type in the virtio net hdr, but the skb could contain
> > anything since it could come from packet_snd through a raw socket. If
> > there is a mismatch between what virtio_net_hdr_set_proto sets and
> > the actual protocol, then the skb could be handled incorrectly later
> > on.
> >
> > An example where this poses an issue is with the subsequent call to
> > skb_flow_dissect_flow_keys_basic which relies on skb->protocol being set
> > correctly. A specially crafted packet could fool
> > skb_flow_dissect_flow_keys_basic preventing EINVAL to be returned.
> >
> > Avoid blindly trusting the information provided by the virtio net header
> > by checking that the protocol in the packet actually matches the
> > protocol set by virtio_net_hdr_set_proto. Note that since the protocol
> > is only checked if skb->dev implements header_ops->parse_protocol,
> > packets from devices without the implementation are not checked at this
> > stage.
> >
> > Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> > Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>
> > ---
> >  include/linux/virtio_net.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index e8a924eeea3d..6c478eee0452 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -79,8 +79,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >               if (gso_type && skb->network_header) {
> >                       struct flow_keys_basic keys;
> >
> > -                     if (!skb->protocol)
> > +                     if (!skb->protocol) {
> > +                             const struct ethhdr *eth = skb_eth_hdr(skb);
> > +                             __be16 etype = dev_parse_header_protocol(skb);
> > +
> >                               virtio_net_hdr_set_proto(skb, hdr);
> > +                             if (etype && etype != skb->protocol)
> > +                                     return -EINVAL;
> > +                     }
>
>
> Well the protocol in the header is an attempt at an optimization to
> remove need to parse the packet ... any data on whether this
> affecs performance?

This adds a branch and reading a cacheline that is inevitably read not
much later. It shouldn't be significant.

And this branch is only taken if skb->protocol is not set. So the cost
can easily be avoided by passing the information.

But you raise a good point, because TUNTAP does set it, but only after
the call to virtio_net_hdr_to_skb.

That should perhaps be inverted (in a separate net-next patch).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

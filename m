Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F42C43461
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:41:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37CE613E9
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37CE613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FB2583E0D;
	Fri, 14 May 2021 12:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNYdoMMWjTnw; Fri, 14 May 2021 12:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092C08397F;
	Fri, 14 May 2021 12:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D55DEC000E;
	Fri, 14 May 2021 12:41:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A331C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38D6F404B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UBG3vVbKY2ax
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:41:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2155402EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:41:46 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id k10so13241552ejj.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHv2uj1+b6Ls/HccEvEXRYAb530bVVnX88BdEJ3onyc=;
 b=JlbCbr+YSBBjvbbbmMPif0StXP8x9Sxq9ELa6SgM1G0kYcX/aIh4JSE6TkY1gvFPZC
 oPISoTLPEx5aGEjpM+0bT0wKgwoB3HbE0vAcOj8RK2WFaInrRRWm/u5MorFhdML5hbNG
 746ZpknFLLN8aghQRMLmsdXwSaBNImQxakLzLtlqPJVERgHXcndGg4SOXwNQYsDlRi2g
 wHH1XtlRo99XtFWmsCiA5ApAAAgdM0sOT1s7vJR7bJMMvU+5nhh+oA5Q1PdNRUz05/mT
 7TlOTQRLY8OsQBfvRG6JH3jbd0GiLN+sZWK/aUoPMgMZdgRj7mp639G32eFGVPj4DjKf
 lOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHv2uj1+b6Ls/HccEvEXRYAb530bVVnX88BdEJ3onyc=;
 b=CUfBecu2qZLWeVqx6rS+fcYLE9gmxXuAf6UojhfUQ2iYS/yU6S7R8i8homLaz9RgES
 DSeWfNZgktjrocuHhXj7k6mB68uvlCmWKH5JyD9m65PpnXilc3L4POvzVGh/CSyg+gYE
 /pYp8DUBdmVW1jAPMB97w2nqdRssY5UAlWGFxB5ciMVVKN0pthk0zpFtvqyNV6VBmmGp
 K2WcnlSUvlq/Hhi4b7lZJAffKyI2oVnSjQ+caWfPUIY8j02xvHXXdQA8nCtyjsPCEWfT
 kQ1IOfLYV5bdTo5+ZplWSnSbCyfp8bJ4EcgLlDU9I1EK2vYFJKbPuifp09HsxWJ/nPqM
 Vc7Q==
X-Gm-Message-State: AOAM532Lhl6AlP4qZ60Dq2j5sOrAoLYdzfPWViU6ge0rTfQDAyikH9mA
 C8fn1jTzxyA6d8+lHuf40eDi5obL4nOsUQ==
X-Google-Smtp-Source: ABdhPJxSpJW9lWaBfRG18hTQs4WXOMZteMv/HB3QSFBgofWfk7TjuaRamK8nowcR0RZzBPDv2lZNgA==
X-Received: by 2002:a17:906:3544:: with SMTP id
 s4mr49502924eja.73.1620996104666; 
 Fri, 14 May 2021 05:41:44 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id p5sm3577644ejm.115.2021.05.14.05.41.43
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 05:41:43 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v12so29880933wrq.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:41:43 -0700 (PDT)
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr56760401wri.327.1620996102914; 
 Fri, 14 May 2021 05:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
 <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
 <CACGkMEsZBCzV+d_eLj1aYT+pkS5m1QAy7q8rUkNsdV0C8aL8tQ@mail.gmail.com>
 <CAOEp5OeSankfA6urXLW_fquSMrZ+WYXDtKNacort1UwR=WgxqA@mail.gmail.com>
 <CACGkMEt3bZrdqbWtWjSkXvv5v8iCHiN8hkD3T602RZnb6nPd9A@mail.gmail.com>
 <CAOEp5Odw=eaQWZCXr+U8PipPtO1Avjw-t3gEdKyvNYxuNa5TfQ@mail.gmail.com>
 <CACGkMEuqXaJxGqC+CLoq7k4XDu+W3E3Kk3WvG-D6tnn2K4ZPNA@mail.gmail.com>
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com>
 <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com>
 <CA+FuTScV+AJ+O3shOMLjUcy+PjBE8uWqCNt0FXWnq9L3gzrvaw@mail.gmail.com>
 <CACGkMEuUF1vDNWbL9dRr1ZM4vFTLwc3j9uB-66451U1NvQ+2EA@mail.gmail.com>
 <CAOEp5OcozfSWszTm9VArOAH+wm2Fo8tH1QJDsLPZD8ieBLtg-g@mail.gmail.com>
In-Reply-To: <CAOEp5OcozfSWszTm9VArOAH+wm2Fo8tH1QJDsLPZD8ieBLtg-g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 May 2021 08:41:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeqzN0SPKNEyD=ZntYb6q4u0u_p=VsPfux4mFpPBZzCxQ@mail.gmail.com>
Message-ID: <CA+FuTSeqzN0SPKNEyD=ZntYb6q4u0u_p=VsPfux4mFpPBZzCxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 davem <davem@davemloft.net>
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

On Fri, May 14, 2021 at 3:39 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Fri, May 14, 2021 at 10:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, May 14, 2021 at 4:35 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > But surprisingly when TUN receives TUN_F_UFO it does not propagate it
> > > > > anywhere, there is no corresponding NETIF flag.
> > > >
> > > > (It looks like I drop the community and other ccs accidentally, adding
> > > > them back and sorry)
> > > >
> > > > Actually, there is one, NETIF_F_GSO_UDP.
> > > >
> > > > Kernel used to have NETIF_F_UFO, but it was removed due to bugs and
> > > > the lack of real hardware support. Then we found it breaks uABI, so
> > > > Willem tries to make it appear for userspace again, and then it was
> > > > renamed to NETIF_F_GSO_UDP.
> > > >
> > > > But I think it's a bug that we don't proporate TUN_F_UFO to NETIF
> > > > flag, this is a must for the driver that doesn't support
> > > > VIRTIO_NET_F_GUEST_UFO. I just try to disable all offloads and
> > > > mrg_rxbuf, then netperf UDP_STREAM from host to guest gives me bad
> > > > length packet in the guest.
> > > >
> > > > Willem, I think we probably need to fix this.
> > >
> > > We had to add back support for the kernel to accept UFO packets from
> > > userspace over tuntap.
> > >
> > > The kernel does not generate such packets, so a guest should never be
> > > concerned of receiving UFO packets.
> >
> > That's my feeling as well.
> >
> > But when I:
> >
> > 1) turn off all guest gso feature and mrg rx buffers, in this case
> > virtio-net will only allocate 1500 bytes for each packet
> > 2) doing netperf (UDP_STREAM) from local host to guest, I see packet
> > were truncated in the guest
>
> Is it possible that the virtio-net does not disable UFO offload?
> IMO it sets NETIF_F_LRO too bravely.

After we removed UFO completely, we found that guests may be migrated
from old hosts with UFO support to newer without. And that they do not
renegotiate features, so will continue to send UFO packets.

I added back the absolute minimum support for UFO: for a host to be
able to accept such UFO packets from userspace. But no device can
advertise or negotiate the NETIF_F_USO feature again. If these packets
arrive on the egress path, they will be immediately software segmented
(or fragmented) in skb_segment. So the host will not forward such
packets to another guest.

The behavior that Jason is experiencing, truncated packets received in
a guest from the host, sound unrelated to this feature to me. Can you
see what the original UDP datagram length is? Are these packets just
marginally larger, or indeed clearly U[SF]O packets well beyond any
reasonable MTU size?

Another option is that this is related to the host stack support for
UDP_GRO. The stack can now build large packets, segments these on
demand if needed (e.g., if such a packet arrives at a local socket
that does not advertise UDP_GRO). Perhaps somehow such packets escape
un-segmented to a guest. Do any devices where these packets may
originate have features NETIF_F_GRO_UDP_FWD or NETIF_F_GRO_FRAGLIST
enabled?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

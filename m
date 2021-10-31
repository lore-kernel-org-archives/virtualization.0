Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070BC433F5
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 15:38:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C35360F0F
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 15:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C35360F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BFEF4021E;
	Sun, 31 Oct 2021 15:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1qH5ymoKffL; Sun, 31 Oct 2021 15:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88A1440182;
	Sun, 31 Oct 2021 15:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67BBCC0019;
	Sun, 31 Oct 2021 15:38:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B463C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 15:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1F8D4014D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 15:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id reMdRl4Q9ZlY
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 15:38:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 32EA44014C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 15:38:29 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id e5so27472881uam.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/DMyohOWdXPyhg1wQ6EXkgg16+mKidkiCYKLquXwk3o=;
 b=iOSJ3zT4CzRoNn5efFa/M784mUmjitd1sxBCleHNmGY1VnNmg8MRCjTel14ollf2+c
 aJE14EtUsvImlxR/QznTnF2DxiQkaz2TEwlD/WHF2uP69spnzHiJGPv7NGbqTsjktQDT
 0U4Rm3t1t56p9fx5UM94ifmlhvnewPasV3fbi0iiWklDQ4XHzlnOHpiKlXYeb7vt0571
 6LkGX2b/AxV49vp5TBxp8DJZa8fwLxvQIgfyTSNl11PESGgAnDUGUiaynA9vF9ytcLKH
 2qTK5XvcC7u185IyKcMEJceJPmxppBTZcRUSnk8yEQKPfLrrmHzgWgASlD45wvOjoQJ/
 L1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/DMyohOWdXPyhg1wQ6EXkgg16+mKidkiCYKLquXwk3o=;
 b=YUV7vIWcQ4LOtjbZLtvNglBa1FQoR9MkIQon8GmedmnPzt9B228dS4FkF9sJTLlHYX
 hP/x0KXZUI94FEvOtuEJ7CE5MCusWzQoMTCmyseSX1onnZ36nH49wADe0gyLf6eanXPg
 zOU5RdWf68aDEuW+6fpV9E+Dx7oQjy/CwcxSUkmtKmIgFD7o1KLvrc4UEl8kZKUTrWh3
 18eu1+BRD01xfSoK8O36tMlqnZRBsKGWJyTbm3yxjOjn48Sho9BDhCLGGhaeN/9B+gTw
 rZjcrTY0jWIC2p/0X2Cx8ohqObkiiqWtIDctM3izewf5+3iTr28NwhZAGWzP2NHFoHZo
 deXA==
X-Gm-Message-State: AOAM530lO2/7Ekjbp+NUyatuwipKhq2sQjrTq4/NjdK6Gkxj+Bz0Yq1A
 9Smsqva/pJSYz8jPwMdaMXb+Dksnx/A=
X-Google-Smtp-Source: ABdhPJwpsho7vpRPKxg85lML9X1/nrXC7UrjJ0N8Ma30yQEwwEvF4v3CbmYbxV+/xertS42qCh0dTw==
X-Received: by 2002:ab0:5a30:: with SMTP id l45mr22985191uad.8.1635694708110; 
 Sun, 31 Oct 2021 08:38:28 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com.
 [209.85.222.47])
 by smtp.gmail.com with ESMTPSA id m34sm1867832uad.5.2021.10.31.08.38.27
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Oct 2021 08:38:27 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id ay21so7041650uab.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 08:38:27 -0700 (PDT)
X-Received: by 2002:a67:facc:: with SMTP id g12mr2351426vsq.22.1635694707053; 
 Sun, 31 Oct 2021 08:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-4-andrew@daynix.com>
 <CA+FuTScq-B9tXjV8qO5oBpFGObhGGZDSXC+iRMxwH89TvEhexw@mail.gmail.com>
In-Reply-To: <CA+FuTScq-B9tXjV8qO5oBpFGObhGGZDSXC+iRMxwH89TvEhexw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 31 Oct 2021 11:37:51 -0400
X-Gmail-Original-Message-ID: <CA+FuTScP-LcRO5PXjohzDS8NXmF6j6u5nxprtnj89q6Cucmgbw@mail.gmail.com>
Message-ID: <CA+FuTScP-LcRO5PXjohzDS8NXmF6j6u5nxprtnj89q6Cucmgbw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] drivers/net/virtio_net: Added basic RSS support.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
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

> > +               hdr_hash = (struct virtio_net_hdr_v1_hash *)(hdr);
> > +
> > +               switch (hdr_hash->hash_report) {
> > +               case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +               case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +               case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +               case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                       rss_hash_type = PKT_HASH_TYPE_L4;
> > +                       break;
> > +               case VIRTIO_NET_HASH_REPORT_IPv4:
> > +               case VIRTIO_NET_HASH_REPORT_IPv6:
> > +               case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                       rss_hash_type = PKT_HASH_TYPE_L3;
> > +                       break;
> > +               case VIRTIO_NET_HASH_REPORT_NONE:
> > +               default:
> > +                       rss_hash_type = PKT_HASH_TYPE_NONE;
> > +               }
>
> Is this detailed protocol typing necessary? Most devices only pass a bit is_l4.
> > +static void virtnet_init_default_rss(struct virtnet_info *vi)
> > +{
> > +       u32 indir_val = 0;
> > +       int i = 0;
> > +
> > +       vi->ctrl->rss.table_info.hash_types = vi->rss_hash_types_supported;
>
> Similar to above, and related to the next patch: is this very detailed
> specification of supported hash types needed? When is this useful? It
> is not customary to specify RSS to that degree.

My bad. This is also implemented by bnxt, for one. I was unaware of
this feature.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

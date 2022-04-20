Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078C4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 13:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9660682B21;
	Wed, 20 Apr 2022 13:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzTMPDd54DTK; Wed, 20 Apr 2022 13:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58A2182B24;
	Wed, 20 Apr 2022 13:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE5BC002F;
	Wed, 20 Apr 2022 13:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBD5EC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8BE761107
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 761uWBZwbLGG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:13:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 680F0610C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 13:13:32 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id d9so877125qty.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EBpAB6FDbZK4zE5ed/nvxGtuXnn9kJ3DTB27o6boGrA=;
 b=AAoC49XgCBYwRBkrug5A93BfpSzwnQ2QHz5ADG0+GiiOROP4ryHDBT40BHJNx2DRpi
 FPmkM0rFi1kUDUbBXKJhLI7gvWIldjfT17sU38UFTuvGNbd7GA5M/2ALIFsEsFAOEtRW
 92RZAMOukvGoszrxxXrmOkNmN0wvR+/Lt2gNi/AXvuncfrNvsa9cUmIrMOfxDG8Us3yF
 EMJiC0i+yiO9+yJGF5Agf2+WPmqwpbybOCwxnjhl/wBmM9zEKyyeZ/IW4oeflKm2R06p
 J93ryrZQVS/iPlo51erMrOY3R252amSBMiCEYwHi409wR8BYTd7kM8qbBi9uf9azmNvR
 MSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EBpAB6FDbZK4zE5ed/nvxGtuXnn9kJ3DTB27o6boGrA=;
 b=pfxYX90yhtwoUo7uhKqCkh2XHwxFUVnTks1zOc7vFu+3nr0iycvs7dRArh9Ua6Liz1
 R9lrfqAHYPt4Z6hjjFoJZpZelYy4YGboDVN9UNyRd4aIIhhLrdlre3pIZvI5xC6c0oXS
 yIeHTdQptShT0GoyvxGZGr7SVu4IsY71P5/gsg1ec4A41Uk3cq4LHK4ITho3to4UZnj9
 bkeeHwR6T/5JRoD/QzUPHcdwrq35Wme2VzD+IvQl69dL4lgCs+9vgT0Q6y9K47zTDYJt
 FRplCwVJXKodS1+rz0JEzMy6GevOxcncwnHBrm+pAvr0NLjeK7cvE6SMxGVa7ytNHm4S
 dkBQ==
X-Gm-Message-State: AOAM531gBGtreDC8bx1gDhYB/BF9kAyM1I7rvD1B6z9/s5Ayg4qkqwCz
 NU4QkJVdjHruuTCa8aAPxQ1FI7rDdzc=
X-Google-Smtp-Source: ABdhPJzpJdqPwGrg5cC7VLJ6VMSEzVJdXow38flVoAnd+Ppw9THD8CNami8pP4e0O/ZzCbUmR7Jdvw==
X-Received: by 2002:ac8:5907:0:b0:2f1:fbe9:e802 with SMTP id
 7-20020ac85907000000b002f1fbe9e802mr10529273qty.570.1650460411191; 
 Wed, 20 Apr 2022 06:13:31 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05620a409300b00680c933fb1csm1744919qko.20.2022.04.20.06.13.30
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 06:13:30 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id s33so2719285ybi.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 06:13:30 -0700 (PDT)
X-Received: by 2002:a05:6902:1202:b0:641:e3c5:f989 with SMTP id
 s2-20020a056902120200b00641e3c5f989mr19463989ybu.532.1650460409740; Wed, 20
 Apr 2022 06:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-3-liuhangbin@gmail.com>
 <CA+FuTSdTbpYGJo6ec2Ti+djXCj=gBAQpv9ZVaTtaJA-QUNNgYQ@mail.gmail.com>
 <Yl4pG8MN7jxVybPB@Laptop-X1>
 <CA+FuTSdLGUgbkP3U+zmqoFzrewnUUN3pci8q8oNfHzo11ZhRZg@mail.gmail.com>
 <Yl9d2L39BzUiLINN@Laptop-X1>
In-Reply-To: <Yl9d2L39BzUiLINN@Laptop-X1>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 20 Apr 2022 09:12:53 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdrramQiwoUQ7bn+US+CDFWXKr8-Bzb8X1JzJbyMNcK8A@mail.gmail.com>
Message-ID: <CA+FuTSdrramQiwoUQ7bn+US+CDFWXKr8-Bzb8X1JzJbyMNcK8A@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio_net: check L3 protocol for VLAN packets
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Balazs Nemeth <bnemeth@redhat.com>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mike Pattrick <mpattric@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

On Tue, Apr 19, 2022 at 9:16 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Hi Willem,
>
> On Tue, Apr 19, 2022 at 09:52:46AM -0400, Willem de Bruijn wrote:
> > Segmentation offload requires checksum offload. Packets that request
>
> OK, makes sense.
>
> > GSO but not NEEDS_CSUM are an aberration. We had to go out of our way
> > to handle them because the original implementation did not explicitly
> > flag and drop these. But we should not extend that to new types.
>
> So do you mean, the current gso types are enough, we should not extend to
> handle VLAN headers if no NEEDS_CSUM flag. This patch can be dropped, right?

That's right.

> Although I don't understand why we should not extend to support VLAN GSO.
> I'm OK if you think this patch should be dropped when I re-post patch 1/2 to
> net-next.
>
> Thanks
> Hangbin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

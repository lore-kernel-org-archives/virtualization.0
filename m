Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1336C433EF
	for <virtualization@archiver.kernel.org>; Sun, 13 Feb 2022 22:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 583F8403F7;
	Sun, 13 Feb 2022 22:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9gqjE4c50sn; Sun, 13 Feb 2022 22:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A16E40176;
	Sun, 13 Feb 2022 22:09:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51F23C001A;
	Sun, 13 Feb 2022 22:09:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1068C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A16F040330
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPo00uiz_MSG
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:09:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F424402FB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:09:54 +0000 (UTC)
Received: by mail-vs1-xe2a.google.com with SMTP id p7so5691424vsg.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=655hBZv76V+mrSinPrNjP8l8aP2PjNxTSfwFsXq8kKw=;
 b=EgsyC3C3wfNT+ZC4PsLdvJGD1LBMmBNknllDyLdwe8wxW8zD7WvXDvGw0HfEvaGVx6
 hkAb3D4NTB9S36yWBvho1x9xYu/4/hFoZZUV76+pRybqJ4xJTuv2aAaLOh/1m71Sx+pU
 GDt+figOp2KoDp26N4fHxIBisEKNSnXZ6AkdTuo6+SQPNRbqixnLxP1vdt2+uE57eumk
 xZx0PfC8asPnragQw54IKS+1WPhNEMKgGQsE1m27+zP7LZm2T0CLCyMhoLWKFJrWmVaX
 dK2kETWlDXQXyiWlRrQ6kBLR73U5zfhsZmaceF4ppBvN1zNYSqYkjQj4AdUh2Ccfkpfb
 TU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=655hBZv76V+mrSinPrNjP8l8aP2PjNxTSfwFsXq8kKw=;
 b=wya2GokIUDBoE1mYhNkp5R7lQVDkGzrOR4dLXdeUAeab2FFkxR8eZ1q3m6YTQ+7z9p
 Z+lq3pGCcciMZ54X6U0wjwfoq46Nk1xJGdsKmdDPlIFNUj2nPW1P/oLw2pmw8H1sOtfK
 Xr0lDgtaMtcDp5yQFThysQY27f1tvpX4wOfKjCgelCnDrCeevYZMp1OqpUA8mh3omQMZ
 SOmksT94nGqhfqjjF/yp4gqKHGisr4O+siebgenh8xUwTvc1DoGZTIB3T2p165JWd8mA
 0hQxYcR3+MmtG3v41E3dlyWvW5lQHxTrQkyrpQsboIBOtl+piDfSZb3FUAPVU2QnCcd/
 zCGg==
X-Gm-Message-State: AOAM531o04izbYcXxcvHn8f5PI/Us7wHw+Qxtr/gc/PrMTGODfMPv00K
 wHMk7AqxCzmqYPGVestPlhqjdBoiqbw=
X-Google-Smtp-Source: ABdhPJzLpaCyww/EIBakix67mSTQXbnRft8zUmggbILn4V9qo3CJgwCQgox7GKR2qr+j/bIZlTZRmw==
X-Received: by 2002:a67:d098:: with SMTP id s24mr379503vsi.70.1644790193267;
 Sun, 13 Feb 2022 14:09:53 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id y22sm667806vsi.25.2022.02.13.14.09.52
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Feb 2022 14:09:52 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id e18so15667221vsq.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 14:09:52 -0800 (PST)
X-Received: by 2002:a67:cc14:: with SMTP id q20mr487373vsl.74.1644790191828;
 Sun, 13 Feb 2022 14:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-3-andrew@daynix.com>
 <CA+FuTSfPq-052=D3GzibMjUNXEcHTz=p87vW_3qU0OH9dDHSPQ@mail.gmail.com>
 <CABcq3pFLXUMi3ctr6WyJMaXbPjKregTzQ2fG1fwDU7tvk2uRFg@mail.gmail.com>
In-Reply-To: <CABcq3pFLXUMi3ctr6WyJMaXbPjKregTzQ2fG1fwDU7tvk2uRFg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 13 Feb 2022 17:09:15 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
Message-ID: <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drivers/net/virtio_net: Added basic RSS support.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

> > > @@ -3113,13 +3270,14 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         u16 max_queue_pairs;
> > >         int mtu;
> > >
> > > -       /* Find if host supports multiqueue virtio_net device */
> > > -       err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
> > > -                                  struct virtio_net_config,
> > > -                                  max_virtqueue_pairs, &max_queue_pairs);
> > > +       /* Find if host supports multiqueue/rss virtio_net device */
> > > +       max_queue_pairs = 1;
> > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> > > +               max_queue_pairs =
> > > +                    virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));
> >
> > Instead of testing either feature and treating them as somewhat equal,
> > shouldn't RSS be dependent on MQ?
>
> No, RSS is dependent on CTRL_VQ. Technically RSS and MQ are similar features.

RSS depends on having multiple queues.

What would enabling VIRTIO_NET_F_RSS without VIRTIO_NET_F_MQ do?

> >
> > >
> > >         /* We need at least 2 queue's */
> > > -       if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > > +       if (max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > >             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
> > >             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> > >                 max_queue_pairs = 1;
> > > @@ -3207,6 +3365,23 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> > >                 vi->mergeable_rx_bufs = true;
> > >
> > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> > > +               vi->has_rss = true;
> > > +               vi->rss_indir_table_size =
> > > +                       virtio_cread16(vdev, offsetof(struct virtio_net_config,
> > > +                               rss_max_indirection_table_length));
> > > +               vi->rss_key_size =
> > > +                       virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> > > +
> > > +               vi->rss_hash_types_supported =
> > > +                   virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> > > +               vi->rss_hash_types_supported &=
> > > +                               ~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> > > +                                 VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> > > +                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> > > +
> > > +               dev->hw_features |= NETIF_F_RXHASH;
> >
> > Only make the feature visible when the hash is actually reported in
> > the skb, patch 3.
>
> VirtioNET has two features: RSS(steering only) and hash(hash report in
> vnet header)
> Both features may be enabled/disabled separately:
> 1. rss on and hash off - packets steered to the corresponding vqs
> 2. rss off and hash on - packets steered by tap(like mq) but headers
> have properly calculated hash.
> 3. rss on and hash on - packets steered to corresponding vqs and hash
> is present in the header.
>
> RXHASH feature allows the user to enable/disable the rss/hash(any combination).

I find that confusing, but.. I see that there is prior art where some
drivers enable/disable entire RSS load balancing based on this flag.
So ok.

> I think it's a good idea to leave RXHASH in patch 2/4 to give the user
> ability to manipulate the rss only feature.
> But, if you think that it requires to move it to the 3/4, I'll do it.
>
> >
> > Also, clearly separate the feature patches (2) rss, (3) rxhash, (4)
> > rxhash config.
>
> Currently:
> Patch 2/4 - adds VirtioNet rss feature.
> Patch 3/4 - adds VirtioNet hash report feature.
> Patch 4/4 - adds the ability to manipulate supported hash types.
>
> Can you provide more detailed suggestions on how to move hunks?

I gave one in the follow-on patch, to which you responded. That's probably it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

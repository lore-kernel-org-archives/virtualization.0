Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A35C433FE
	for <virtualization@archiver.kernel.org>; Sun, 20 Feb 2022 13:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 853A840875;
	Sun, 20 Feb 2022 13:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY0kiG-a-Xck; Sun, 20 Feb 2022 13:17:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 220E7403D0;
	Sun, 20 Feb 2022 13:17:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8A37C0036;
	Sun, 20 Feb 2022 13:17:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FAD9C0033
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 13:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F58F81450
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 13:17:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TjNm1svUnLe6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 13:17:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3478144C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645363057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5OIMKdTq6zuYT7HitHGg42HGDVHH4hXpFV6GEUd+nw=;
 b=BaSygaw84CrfomW6MHPAhoTTQ/f/IGoVwX+I8QLdxDA6naI5yi0wRwddq/gAhIppfBc3YM
 cGdc6Z/G+PbWYS2Bdkw8KXfpcUihnhS+JBBBhojsq5C4c+PF/EBR3nc748UXgPYS+bkzqT
 fDzyGblXIcc9Mn2V/GEiNQxD6n0Hz38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-cZU93SKePVmiId7VyM8dfQ-1; Sun, 20 Feb 2022 08:17:36 -0500
X-MC-Unique: cZU93SKePVmiId7VyM8dfQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 q21-20020adfab15000000b001e57c9a342aso5900072wrc.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 05:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O5OIMKdTq6zuYT7HitHGg42HGDVHH4hXpFV6GEUd+nw=;
 b=qYLPCF4taeUHGab3HJTBYQnN4wRPFwaNP2oXuABlvfNWg819t8bJEkdtgA54ANCaRx
 9YgmaSeEzJA5gcKw0Mc7Habx69DdgNSww56owqFOjWPgS1XpgzXJU62vpMUfctC0jwWd
 XG2/WhwdzzlM2Pgex3MQ1YqOIP4iP6pUrGBXYG8KGITy9U5UdOLhdFmbV5TBfTY8oRf/
 cx8ai7e40QFPLaz4ru/vvIr6JR3pnU8j1TfPSfkfo+Ioin1Xw4uV78gFmgw2lqX00Bmj
 oohhJ7Tx99lNnCh8Pcq6FL8s4uT7cvjqCd3fKavN+ETDw3GOv0yoVb3b1aTw9XOZitmu
 pPVw==
X-Gm-Message-State: AOAM530aG8Y3gx16Z95bbf8a2Bj+9XLfIPsbWPXGm0K7TyGRANg25M3C
 ZYLF7jXYitsoFQ+uHbQPBnGZmKVaaLXpP3yNXLACtOFF2bJQMt0x7BFQNqKbTRF6NTVZqbGxQcG
 e51KQM4oFnzJxcEqdGCwM118YZM81G0TQEodC4lDe2w==
X-Received: by 2002:a05:600c:3589:b0:37b:b9fb:f939 with SMTP id
 p9-20020a05600c358900b0037bb9fbf939mr14066343wmq.188.1645363054811; 
 Sun, 20 Feb 2022 05:17:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRmBi0QqJHpGmr884+AKGXtd32q6T6Jl+XK/2txKtcCMuV8XOo/I4FCP2NMDb3NuN5veN+Vg==
X-Received: by 2002:a05:600c:3589:b0:37b:b9fb:f939 with SMTP id
 p9-20020a05600c358900b0037bb9fbf939mr14066329wmq.188.1645363054599; 
 Sun, 20 Feb 2022 05:17:34 -0800 (PST)
Received: from redhat.com ([2.55.134.183])
 by smtp.gmail.com with ESMTPSA id x7sm39644133wro.21.2022.02.20.05.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Feb 2022 05:17:33 -0800 (PST)
Date: Sun, 20 Feb 2022 08:17:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 2/4] drivers/net/virtio_net: Added basic RSS support.
Message-ID: <20220220081148-mutt-send-email-mst@kernel.org>
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-3-andrew@daynix.com>
 <CA+FuTSfPq-052=D3GzibMjUNXEcHTz=p87vW_3qU0OH9dDHSPQ@mail.gmail.com>
 <CABcq3pFLXUMi3ctr6WyJMaXbPjKregTzQ2fG1fwDU7tvk2uRFg@mail.gmail.com>
 <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
 <CABcq3pE9ewELP0xW-BxFCjTUPBf9LFzmde4tMf1Szivb8nMp7g@mail.gmail.com>
 <CA+FuTScisEyVdMcK2LJHnT8TTmduPqs20_7SzukkP_OYDEQpwA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTScisEyVdMcK2LJHnT8TTmduPqs20_7SzukkP_OYDEQpwA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrew Melnichenko <andrew@daynix.com>,
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

On Fri, Feb 18, 2022 at 08:43:20AM -0700, Willem de Bruijn wrote:
> On Thu, Feb 17, 2022 at 12:05 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> >
> > Hi all,
> >
> > On Mon, Feb 14, 2022 at 12:09 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > > > > @@ -3113,13 +3270,14 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > >         u16 max_queue_pairs;
> > > > > >         int mtu;
> > > > > >
> > > > > > -       /* Find if host supports multiqueue virtio_net device */
> > > > > > -       err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
> > > > > > -                                  struct virtio_net_config,
> > > > > > -                                  max_virtqueue_pairs, &max_queue_pairs);
> > > > > > +       /* Find if host supports multiqueue/rss virtio_net device */
> > > > > > +       max_queue_pairs = 1;
> > > > > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> > > > > > +               max_queue_pairs =
> > > > > > +                    virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));
> > > > >
> > > > > Instead of testing either feature and treating them as somewhat equal,
> > > > > shouldn't RSS be dependent on MQ?
> > > >
> > > > No, RSS is dependent on CTRL_VQ. Technically RSS and MQ are similar features.
> > >
> > > RSS depends on having multiple queues.
> > >
> > > What would enabling VIRTIO_NET_F_RSS without VIRTIO_NET_F_MQ do?
> >
> > RSS would work.
> 
> What does that mean, exactly? RSS is load balancing, does that not
> require multi-queue?

It does, but VIRTIO_NET_F_MQ is a misnomer.
\item[VIRTIO_NET_F_MQ(22)] Device supports multiqueue with automatic
    receive steering.

VIRTIO_NET_F_RSS implies multi queue and does not depend on VIRTIO_NET_F_MQ.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

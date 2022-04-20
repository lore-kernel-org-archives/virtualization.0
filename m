Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5581DC433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 02:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC1D341737;
	Wed, 20 Apr 2022 02:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXv488HcjtCg; Wed, 20 Apr 2022 02:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F760415C8;
	Wed, 20 Apr 2022 02:47:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11E83C002F;
	Wed, 20 Apr 2022 02:47:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBE59C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 02:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6FAB401D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 02:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3QpLuObcmfX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 02:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC15E400A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650422837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FdYUVfV61WLVDVI9kuj+7fCK1y/uDwzu1x8ghdoN8Y=;
 b=NKPUgoBQp8XJsQe/f5OAqs3SytegUQeA/x6KZj7azHBtuHcgdqpCOnTnbmDK57GvOqryIH
 fXjXk8OF1KOIWP8HnLhQXXmC0SKqJX+PptCBoFxvoTazQCZ12fnwyN+F8uhuomsyA4buD7
 PqycW+pwQ2V5RO060wGRZkmFuxREz0s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-4lzTbJ2-Oo2NmKR0h7XqZA-1; Tue, 19 Apr 2022 22:47:16 -0400
X-MC-Unique: 4lzTbJ2-Oo2NmKR0h7XqZA-1
Received: by mail-lf1-f72.google.com with SMTP id
 w34-20020a0565120b2200b0044adfdd1570so115384lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 19:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4FdYUVfV61WLVDVI9kuj+7fCK1y/uDwzu1x8ghdoN8Y=;
 b=qWvcEHAbg0p+9iPmCxP1qnfI3csR9ye6rIFzoCe83l0dPmvN/G6t3RcEf4XAnf3q5j
 lZr9KJz0j2i89kmXxK0xtJcoEp2XZ3q47ewRN+rT3r9rXypU8vO3CILVMp44/siqvBsU
 L3lX3aMEOP4slAKbrTkGcSIfjTwHadDFGynCqWIEOLNLqzL2tbMUDQ0ZKzQX4jiWStEB
 +USlIGRoMMtST2MezOSpjGjy9Tsu/gDCNGD0/vim1Bk/i4Tf4JfLFPuXQUt+IdEPy9Di
 AofV0IoN8+2Wv6A9W7kQ2oklfY1HyxPpN/iiX0xe+btS1GdrIwY6QyN3jxfDdPfD0szs
 eG3g==
X-Gm-Message-State: AOAM533w5Q0ErQYmbXOm+tOuzEmNu9QO9uCbaE3wlflLH7dYS7iafNQ6
 Mgi0oOkz1aha9vo3n3BZjzcnhk1XSxidGTE6gRzRdCq9SfrpSofDC7UtRRlxtC2b+t7ebCzmzkX
 +8l9dFwK39recpOWgcxQb3pvcQzgVq6+eyDrKfU4EEEtl5JejD+M4N9nqdA==
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id
 d16-20020a05651233d000b00471a625fdc0mr4736054lfg.98.1650422834658; 
 Tue, 19 Apr 2022 19:47:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo5vRdEN2eelrx3uNE6z+vLcL5KiIhfKbTD1ONUHhWXYF2pykhV84CLmlMkE9rEGRzWsJtROrkSrpmQ8GB0Ts=
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id
 d16-20020a05651233d000b00471a625fdc0mr4736033lfg.98.1650422834446; Tue, 19
 Apr 2022 19:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220418044339.127545-1-liuhangbin@gmail.com>
 <20220418044339.127545-2-liuhangbin@gmail.com>
 <CA+FuTScQ=tP=cr5f2S97Z7ex1HMX5R-C0W6JE2Bx5UWgiGknZA@mail.gmail.com>
 <Yl4mU0XLmPukG0WO@Laptop-X1>
 <CA+FuTSfBU7ck91ayf_t9=7eRGJZHuWSeXzX2SxFAQMPSitY9SA@mail.gmail.com>
 <20220419101325-mutt-send-email-mst@kernel.org> <Yl9bDrDFZhc04MiY@Laptop-X1>
In-Reply-To: <Yl9bDrDFZhc04MiY@Laptop-X1>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Apr 2022 10:47:03 +0800
Message-ID: <CACGkMEvV1kOye=iVsURa8PR6mtXH8cwuYZ8hWoxcJAHs8kREew@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/af_packet: adjust network header position for
 VLAN tagged packets
To: Hangbin Liu <liuhangbin@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Maxim Mikityanskiy <maximmi@mellanox.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Balazs Nemeth <bnemeth@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Flavio Leitner <fbl@redhat.com>, Mike Pattrick <mpattric@redhat.com>,
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

On Wed, Apr 20, 2022 at 9:00 AM Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Tue, Apr 19, 2022 at 10:26:09AM -0400, Michael S. Tsirkin wrote:
> > > > There are also some duplicated codes in these *_snd functions.
> > > > I think we can move them out to one single function.
> > >
> > > Please don't refactor this code. It will complicate future backports
> > > of stable fixes.
> >
> > Hmm I don't know offhand which duplication this refers to specifically
> > so maybe it's not worth addressing specifically but generally not
> > cleaning up code just because of backports seems wrong ...
>
> Yes, packet_snd() and tpacket_snd() share same addr/msg checking logic that
> I think we can clean up.
>
> > > > > stretching the definition of the flags to include VLAN is acceptable
> > > > > (unlike outright tunnels), but even then I would suggest for net-next.
> > > >
> > > > As I asked, I'm not familiar with virtio code. Do you think if I should
> > > > add a new VIRTIO_NET_HDR_GSO_VLAN flag? It's only a L2 flag without any L3
> > > > info. If I add something like VIRTIO_NET_HDR_GSO_VLAN_TCPV4/TCPV6/UDP. That
> > > > would add more combinations. Which doesn't like a good idea.
> > >
> > > I would prefer a new flag to denote this type, so that we can be
> > > strict and only change the datapath for packets that have this flag
> > > set (and thus express the intent).
> > >
> > > But the VIRTIO_NET_HDR types are defined in the virtio spec. The
> > > maintainers should probably chime in.
> >
> > Yes, it's a UAPI extension, not to be done lightly. In this case IIUC
> > gso_type in the header is only u8 - 8 bits and 5 of these are already
> > used.  So I don't think the virtio TC will be all that happy to burn up
> > a bit unless a clear benefit can be demonstrated.
> >
> > I agree with the net-next proposal, I think it's more a feature than a
> > bugfix. In particular I think a Fixes tag can also be dropped in that
> > IIUC GSO for vlan packets didn't work even before that commit - right?

It should work, we initialize vlan_features since ("4fda830263c5
virtio-net: initialize vlan_features").

What we don't support is vlan offload.

>
> Right. virtio_net_hdr GSO with vlan doesn't work before.

It doesn't work since we don't support that feature.

> I will post this to net-next.

If you want to do that, you need a spec patch as well.

Thanks

>
> Thanks
> Hangbin
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

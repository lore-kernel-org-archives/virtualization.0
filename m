Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F104FC64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 10:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A2B041849;
	Tue, 28 Feb 2023 10:13:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A2B041849
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ksuyb87aZnQh; Tue, 28 Feb 2023 10:13:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F90841824;
	Tue, 28 Feb 2023 10:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F90841824
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33ED1C0032;
	Tue, 28 Feb 2023 10:13:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 180B8C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7BC981C18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:13:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7BC981C18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9npVRtkmssU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1292381B53
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1292381B53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:13:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0Vcj3VcW_1677579207; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vcj3VcW_1677579207) by smtp.aliyun-inc.com;
 Tue, 28 Feb 2023 18:13:27 +0800
Message-ID: <1677579113.5159256-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
Date: Tue, 28 Feb 2023 18:11:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com>
 <CACGkMEu8JtT9_0YcbmfWCGxbrB1GHnesnspFYgaeVrb2x3o3oQ@mail.gmail.com>
 <1677578798.8465447-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1677578798.8465447-1-xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, rbradford@rivosinc.com,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 28 Feb 2023 18:06:38 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Fri, 24 Feb 2023 11:11:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Feb 24, 2023 at 3:38 AM Rob Bradford via B4 Relay
> > <devnull+rbradford.rivosinc.com@kernel.org> wrote:
> > >
> > > From: Rob Bradford <rbradford@rivosinc.com>
> > >
> > > kvmtool does not support the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature
> > > but does advertise the VIRTIO_NET_F_GUEST_TSO{4,6} features. Check that
> > > the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is present before setting
> > > the NETIF_F_GRO_HW feature bit as otherwise
>
> Here are settings for dev->features and dev->hw_features.

What I want to say is that in normal circumstances, ethtool will identify it and
will not directly modify the backend, if there is no VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.

Thanks.

>
>
> > > an attempt will be made to
> > > program the virtio-net device using the ctrl queue which will fail.
> > >
> > > This resolves the following error when running on kvmtool:
>
> Can you talk about it in detail what it did?
>
> Thanks.
>
> > >
> > > [    1.865992] net eth0: Fail to set guest offload.
> > > [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wanted 0x0000000000134829, left 0x0080000000134829
> > >
> > > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > > ---
> > > Changes in v2:
> > > - Use parentheses to group logical OR of features
> > > - Link to v1:
> > >   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d7a@rivosinc.com
> > > ---
> > >  drivers/net/virtio_net.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 61e33e4dd0cd..f8341d1a4ccd 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3780,10 +3780,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         }
> > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> > >                 dev->features |= NETIF_F_RXCSUM;
> > > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > -           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > -               dev->features |= NETIF_F_GRO_HW;
> > > -       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > +       if ((virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > +           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)) &&
> > > +           virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > >                 dev->hw_features |= NETIF_F_GRO_HW;
> >
> > Does this mean we won't have NETIF_F_GRO_HW when only TSO4/TSO6 are
> > supported but not GUEST_OFFLOADS?
> >
> > Is this intended?
> >
> > Thanks
> >
> > >
> > >         dev->vlan_features = dev->features;
> > >
> > > ---
> > > base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> > > change-id: 20230223-virtio-net-kvmtool-87f37515be22
> > >
> > > Best regards,
> > > --
> > > Rob Bradford <rbradford@rivosinc.com>
> > >
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

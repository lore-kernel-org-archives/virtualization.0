Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33312C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 770334150E;
	Wed,  7 Sep 2022 14:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 770334150E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/nDLghI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czduUYT8ixG8; Wed,  7 Sep 2022 14:30:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6614E408DD;
	Wed,  7 Sep 2022 14:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6614E408DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25471C0033;
	Wed,  7 Sep 2022 14:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe58:3b77])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F098C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 094C760D52
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 094C760D52
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/nDLghI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xZb2IwUHC3iT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:30:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B23660D50
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B23660D50
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662560998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MoUHys1NJY1cE4G48Sz0iIP7SXECYYGzs4Ze1KZp2/s=;
 b=L/nDLghIMXIqfogiwsLRJFXQhr1VrUl7EkVh5SbbMyIhQz3oo2eeSaMwDY/dnu1xeJh6GQ
 FtTBPFYNO7SwoYuSVZr3SofFH7NAbrXsNIN1Yf7Y29FAQlQ7bIu0Pyzw1En8Xbnb4Gctww
 rZFnfw/9XppSZ1hOOuOS8HgP9X0+4Y4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-kQY_S4LnNPGGoYxpHn-FUg-1; Wed, 07 Sep 2022 10:29:57 -0400
X-MC-Unique: kQY_S4LnNPGGoYxpHn-FUg-1
Received: by mail-wr1-f69.google.com with SMTP id
 e15-20020adf9bcf000000b002285faa9bd4so3132028wrc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 07:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=MoUHys1NJY1cE4G48Sz0iIP7SXECYYGzs4Ze1KZp2/s=;
 b=0jQBXHLWd7QLZyARD9SY2+IEkPCQIho1hBrKVRSuA1qhZawoNTEhavUFGDXPu99mbA
 NBBWiqHP2MNfNngT61enzl6wHNZ35fQAo9JX7uTEAbyxWdDmrVC5p6UIlp2V+nz8bM/T
 GGctu3nyEJjLBV04s4inOZPV0tHjPecEPuD0d8pBcmtsXASmObbZ2ZCHTNCpz8daE3YU
 gpFA9pKuXaDPnVh+9+ODhfL620Gbbgm5h7rNVedZuJzRnP9x5nDLPaBQ/Cy4AgQo8JIT
 +F/iX7vnNJEhdQCUjr3fO/ysEka47rOYVxRIbkHk/8ZJDuGIz0JezJPDnSLTcWxooF3f
 m4ew==
X-Gm-Message-State: ACgBeo0Aem+5GV8+kuecxf2RSY80yU+cuCNBTTBspNnRZNFdOhcDNRNG
 b9DOyP5pJ9D17KWpK08vX6wkOyX7wn18wApMFBJl4ET+I1Y3fc4rALChQnbGb5b4paa3GhLzyQy
 6HOgU7xy7pLK+QC/LO3laxJUdLXcaI6KhDmM1F1aRGw==
X-Received: by 2002:a05:6000:1245:b0:228:6aa7:dbb2 with SMTP id
 j5-20020a056000124500b002286aa7dbb2mr2429216wrx.77.1662560996460; 
 Wed, 07 Sep 2022 07:29:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uBFNaKZ8WzHJqqF93TRlwkGSRikP4atFIcAqZemkXVub+w1K7DukaThEBIPlHPmnmzeKp+g==
X-Received: by 2002:a05:6000:1245:b0:228:6aa7:dbb2 with SMTP id
 j5-20020a056000124500b002286aa7dbb2mr2429195wrx.77.1662560996203; 
 Wed, 07 Sep 2022 07:29:56 -0700 (PDT)
Received: from redhat.com ([2.52.135.118]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a056000081800b0022377df817fsm18034503wrb.58.2022.09.07.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 07:29:55 -0700 (PDT)
Date: Wed, 7 Sep 2022 10:29:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Message-ID: <20220907101335-mutt-send-email-mst@kernel.org>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 07, 2022 at 02:08:18PM +0000, Parav Pandit wrote:
> =

> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 5:27 AM
> > =

> > On Wed, Sep 07, 2022 at 04:08:54PM +0800, Gavin Li wrote:
> > >
> > > On 9/7/2022 1:31 PM, Michael S. Tsirkin wrote:
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
> > > > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for
> > > > > big packets even when GUEST_* offloads are not present on the
> > device.
> > > > > However, if guest GSO is not supported, it would be sufficient to
> > > > > allocate segments to cover just up the MTU size and no further.
> > > > > Allocating the maximum amount of segments results in a large waste
> > > > > of buffer space in the queue, which limits the number of packets
> > > > > that can be buffered and can result in reduced performance.
> > =

> > actually how does this waste space? Is this because your device does not
> > have INDIRECT?
> VQ is 256 entries deep.
> Driver posted total of 256 descriptors.
> Each descriptor points to a page of 4K.
> These descriptors are chained as 4K * 16.

So without indirect then? with indirect each descriptor can
point to 16 entries.

> So total packets that can be serviced are 256/16 =3D 16.
> So effective queue depth =3D 16.
> =

> So, when GSO is off, for 9K mtu, packet buffer needed =3D 3 pages. (12k).
> So, 13 descriptors (=3D 13 x 4K =3D52K) per packet buffer is wasted.
> =

> After this improvement, these 13 descriptors are available, increasing th=
e effective queue depth =3D 256/3 =3D 85.
> =

> [..]
> > > > >
> > > > > MTU(Bytes)/Bandwidth (Gbit/s)
> > > > >               Before   After
> > > > >    1500        22.5     22.4
> > > > >    9000        12.8     25.9
> > =

> > =

> > is this buffer space?
> Above performance numbers are showing improvement in bandwidth. In Gbps/s=
ec.
> =

> > just the overhead of allocating/freeing the buffers?
> > of using INDIRECT?
> The effective queue depth is so small, device cannot receive all the pack=
ets at given bw-delay product.
> =

> > > >
> > > > Which configurations were tested?
> > > I tested it with DPDK vDPA + qemu vhost. Do you mean the feature set
> > > of the VM?
> > =

> The configuration of interest is mtu, not the backend.
> Which is different mtu as shown in above perf numbers.
> =

> > > > Did you test devices without VIRTIO_NET_F_MTU ?
> > > No.=A0 It will need code changes.
> No. It doesn't need any code changes. This is misleading/vague.
> =

> This patch doesn't have any relation to a device which doesn't offer VIRT=
IO_NET_F_MTU.
> Just the code restructuring is touching this area, that may require some =
existing tests.
> I assume virtio tree will have some automation tests for such a device?

I have some automated tests but I also expect developer to do testing.

> > > > >
> > > > > @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct
> > > > > virtio_device *vdev)
> > > > >
> > > > >                dev->mtu =3D mtu;
> > > > >                dev->max_mtu =3D mtu;
> > > > > -
> > > > > -             /* TODO: size buffers correctly in this case. */
> > > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > > -                     vi->big_packets =3D true;
> > > > >        }
> > > > >
> > > > > +     virtnet_set_big_packets_fields(vi, mtu);
> > > > > +
> > > > If VIRTIO_NET_F_MTU is off, then mtu is uninitialized.
> > > > You should move it to within if () above to fix.
> > > mtu was initialized to 0 at the beginning of probe if VIRTIO_NET_F_MTU
> > > is off.
> > >
> > > In this case,=A0 big_packets_num_skbfrags will be set according to gu=
est gso.
> > >
> > > If guest gso is supported, it will be set to MAX_SKB_FRAGS else
> > > zero---- do you
> > >
> > > think this is a bug to be fixed?
> > =

> > =

> > yes I think with no mtu this should behave as it did historically.
> > =

> Michael is right.
> It should behave as today. There is no new bug introduced by this patch.
> dev->mtu and dev->max_mtu is set only when VIRTIO_NET_F_MTU is offered wi=
th/without this patch.
> =

> Please have mtu related fix/change in different patch.
> =

> > > >
> > > > >        if (vi->any_header_sg)
> > > > >                dev->needed_headroom =3D vi->hdr_len;
> > > > >
> > > > > --
> > > > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

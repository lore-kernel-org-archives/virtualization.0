Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD6C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 03:39:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7EC60EB9
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 03:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C7EC60EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB3306085B;
	Wed, 11 Aug 2021 03:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JL22IZeS5Al7; Wed, 11 Aug 2021 03:39:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68AD160855;
	Wed, 11 Aug 2021 03:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38796C001A;
	Wed, 11 Aug 2021 03:39:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ACC0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 03:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19E7E818E8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 03:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQYhgbiXe3Gt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 03:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 058E78102F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 03:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628653157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rpVjH9yFtALMHy8DJ2O5+aTPdkpQ3/3escdtLPYP/Ys=;
 b=eA4aCscuKK3ifr3gdCiZ3iZaDJEll3LRxHejWl0DNEc2lORFOCQxAegQYKhYDlUKYd/Tcp
 Ybj6WDPnOeDlYHWnGB4Oypm4xe13NpfOG1m2hw85t9DGpVvRvJ/Xb6bht9a3mP3bwQ0Qgo
 oo+CjQP4Uc57mq2ZrSSubc8dsI0FvlU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-9UNYvByAMaieWwhXyRaD3w-1; Tue, 10 Aug 2021 23:39:13 -0400
X-MC-Unique: 9UNYvByAMaieWwhXyRaD3w-1
Received: by mail-lf1-f70.google.com with SMTP id
 x33-20020a0565121321b02903ac51262781so400755lfu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 20:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rpVjH9yFtALMHy8DJ2O5+aTPdkpQ3/3escdtLPYP/Ys=;
 b=Vc5FW7ybuxKdx9jG5QcrJv4lnBwo7dQaEOrUeMoYdSEzuGDUL+/sOiurRbmwIxe2ez
 IHHOZAr+a3UDBZlGYEem8ntGXapaXPK7vbNyg9ktOjW3d5ULTkrkEVyCPgCHZwTMZXjY
 uU//rz2kwHJnpnsHUqTw2Yv1Y8a4PGDs44BYs+yg1xRZJQ4rt4R6FCypauNvC9+oEyTs
 f3mHORKcJO01ebTUF89mIm0RJoQwzelXRA+E5NHJExyK5Br3he4irSBijsDoED3zXaJM
 JEmP/YrxvH+UPi18TbNOhjbdfX9wvxafOAl4cwGb6mV6CmWU+avTRthKWMkr8dwrrwmv
 NoPA==
X-Gm-Message-State: AOAM532KgLYS7ZGsfyqWMWYZK7e9+8dxEy8K9//F48so70uY3EGgwqAp
 RUHhZt60IDVRAU9n/MTt80oE4F2JSa8cDv4uCT6yhplDGHGN3p4ssF6rSHBXughFxRUdmxj/syX
 iLcFOvgr5odel8SFJKqjUnmoGMYWmR9G/1CVix3rZxXuGbxA3XasNMfpT1Q==
X-Received: by 2002:a05:6512:20d9:: with SMTP id
 u25mr24269597lfr.463.1628653151562; 
 Tue, 10 Aug 2021 20:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg9N/e+sVvg4WgCYTEX11OtkFZYpenrEbk4AQxWW4LKIeF0k799z1UmMXrxsQxU7R/sl7kMt3t+Lgpz3b1hWE=
X-Received: by 2002:a05:6512:20d9:: with SMTP id
 u25mr24269580lfr.463.1628653151311; 
 Tue, 10 Aug 2021 20:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
 <20210723080924-mutt-send-email-mst@kernel.org>
 <CACFia2en0JJDFyz3Umk-JTnMT=kjvRogt4PudED4kiLeMjcHFg@mail.gmail.com>
 <CACFia2fx7Lt-4o_uqDznvk-VgdsMtD64qv6RYkrCjKLu2yt8bg@mail.gmail.com>
 <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
 <20210727050944-mutt-send-email-mst@kernel.org>
 <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
 <20210802154901-mutt-send-email-mst@kernel.org>
 <CACFia2f8xmOwB69Cj+OUNobNSurVnrLrJFdrxnmurww9aSzJMw@mail.gmail.com>
 <20210810112147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210810112147-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Aug 2021 11:38:59 +0800
Message-ID: <CACGkMEt94bNsM6e+U6a+H4ZGp5Ss+y=1_fBDUKto5BJXcG_47w@mail.gmail.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="0000000000008c0f0105c9405c2b"
Cc: Willem de Bruijn <willemb@google.com>,
 Ivan <ivan@prestigetransportation.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--0000000000008c0f0105c9405c2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2021 at 11:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 02, 2021 at 04:23:12PM -0500, Ivan wrote:
> > On Mon, Aug 2, 2021 at 2:52 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Mon, Aug 02, 2021 at 01:32:05PM -0500, Ivan wrote:
> > > > On Tue, Jul 27, 2021 at 4:11 AM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > >
> > > > > On Mon, Jul 26, 2021 at 07:44:43PM -0500, Ivan wrote:
> > > > > > On Sat, Jul 24, 2021 at 11:18 PM Ivan <ivan@prestigetransportat=
ion.com> wrote:
> > > > > > >
> > > > > > > On Sat, Jul 24, 2021 at 7:17 PM Ivan <ivan@prestigetransporta=
tion.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jul 23, 2021 at 7:33 AM Ivan <ivan@prestigetranspor=
tation.com> wrote:
> > > > > > > >>
> > > > > > > >> On Fri, Jul 23, 2021 at 7:10 AM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > > > > >>>
> > > > > > > >>> On Fri, Jul 23, 2021 at 03:06:04AM -0500, Ivan wrote:
> > > > > > > >>> > On Fri, Jul 23, 2021 at 2:59 AM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > > >>> > >
> > > > > > > >>> > > On Thu, Jul 22, 2021 at 11:50:11PM -0500, Ivan wrote:
> > > > > > > >>> > > > On Thu, Jul 22, 2021 at 11:25 PM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > >>> > > > > =E5=9C=A8 2021/7/23 =E4=B8=8A=E5=8D=8810:54, Ivan=
 =E5=86=99=E9=81=93:
> > > > > > > >>> > > > > > On Thu, Jul 22, 2021 at 9:37 PM Jason Wang <jas=
owang@redhat.com> wrote:
> > > > > > > >>> > > > > >> Does it work if you turn off lro before enabli=
ng the forwarding?
> > > > > > > >>> > > > > > 0 root@NuRaid:~# ethtool -K eth0 lro off
> > > > > > > >>> > > > > > Actual changes:
> > > > > > > >>> > > > > > rx-lro: on [requested off]
> > > > > > > >>> > > > > > Could not change any device features
> > > > > > > >>> > > > >
> > > > > > > >>> > > > > Ok, it looks like the device misses the VIRTIO_NE=
T_F_CTRL_GUEST_OFFLOADS
> > > > > > > >>> > > > > which makes it impossible to change the LRO setti=
ng.
> > > > > > > >>> > > > >
> > > > > > > >>> > > > > Did you use qemu? If yes, what's the qemu version=
 you've used?
> > > > > > > >>> > > >
> > > > > > > >>> > > > These are VirtualBox machines, which I've been usin=
g for years with
> > > > > > > >>> > > > longterm kernels 4.19, and I never had such a probl=
em.  But now that I
> > > > > > > >>> > > > tried upgrading to kernels 5.10 or 5.13 -- the pani=
cs started.  These
> > > > > > > >>> > > > are just generic kernel builds, and a minimalistic =
userspace.
> > > > > > > >>> > >
> > > > > > > >>> > > I would be useful to see the features your virtualbox=
 instance provides
> > > > > > > >>> > >
> > > > > > > >>> > > cat /sys/class/net/eth0/device/features
> > > > > > > >>> >
> > > > > > > >>> > # cat /sys/class/net/eth0/device/features
> > > > > > > >>> > 1100010110111011111100000000000000000000000000000000000=
000000000
> > > > > > > >>>
> > > > > > > >>> I was able to reproduce the warning but not the panic.
> > > > > > > >>> OTOH if LRO stays on when enabling forwarding that
> > > > > > > >>> is already a problem. Any chance you can bisect to
> > > > > > > >>> find out which change introduced the panic?
> > > > > > > >>
> > > > > > > >>
> > > > > > > >> Any kernels up to 4.19.198 don't panic.
> > > > > > > >> Any kernels 5.10+ panic immediately upon starting forwardi=
ng.
> > > > > > > >> I have not tested any kernels between 4.19 and 5.10.
> > > > > > > >> I guess I can build a few kernels inbetween, and try pinpo=
int where it starts.
> > > > > > > >> That may take a day or so.  I'll get on with it now, and r=
eport my findings.
> > > > > > > >
> > > > > > > > So, I narrowed  it down: the panics start with kernel 5.0-r=
c.
> > > > > > >
> > > > > > > More narowly, the problem seems be coming from commit
> > > > > > > a02e8964eaf9271a8a5fcc0c55bd13f933bafc56.
> > > > > > > Just to test my suspicion, I deleted a few lines from that co=
de,
> > > > > > > and the panic went away.  Hope that helps you guys figure out
> > > > > > > what the problem might be.
> > > > >
> > > > > Well it disables LRO but we knew this :( I'd help if we knew
> > > > > where does it panic, all we see it the warning which is
> > > > > related for sure but not the immediate rootcause ...
> > > > >
> > > > > > >
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -2978,11 +2978,6 @@
> > > > > > >   }
> > > > > > >   if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> > > > > > >      dev->features |=3D NETIF_F_RXCSUM;
> > > > > > > - if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > > -    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > > -    dev->features |=3D NETIF_F_LRO;
> > > > > > > - if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOA=
DS))
> > > > > > > -    dev->hw_features |=3D NETIF_F_LRO;
> > > > > > >
> > > > > > >   dev->vlan_features =3D dev->features;
> > > > > >
> > > > > > Just FYI, Google turned up two similar bug reposts...
> > > > > > Apr 14, 2020 -- https://github.com/containers/podman/issues/581=
5
> > > > > > Oct 09. 2020 -- https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
09593
> > > > > >
> > > > > > Is there any sensible thing I could do, temporarily, until this
> > > > > > problem is sorted out?
> > > > > > Or am I simply stuck to kernels 4.19 on these machines for now?
> > > > >
> > > > >
> > > > > Something like this I guess:
> > > > >
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8a58a2f013af..cc5982193a40 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3063,6 +3063,8 @@ static int virtnet_validate(struct virtio_d=
evice *vdev)
> > > > >                         __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU=
);
> > > > >         }
> > > > >
> > > > > +       __virtio_clear_bit(vdev, VIRTIO_NET_F_GUEST_TSO4);
> > > > > +       __virtio_clear_bit(vdev, VIRTIO_NET_F_GUEST_TSO6);
> > > > >         return 0;
> > > > >  }
> > > >
> > > > When I apply your patch, then I see drastic (more than half)
> > > > reductions in speed. (confirmed with iperf).
> > > >
> > > > But if instead I just remove a few lines from commit
> > > > a02e8964eaf9271a8a5fcc0c55bd13f933bafc56
> > > > as in my earlier post, then I'm back to full speed
> > > >
> > > > I understand that this is just temporary workaround, until we figur=
e this out.
> > >
> > >
> > > Oh weird. So it's not about getting some weird LRO packet. We will ge=
t it with
> > > VIRTIO_NET_F_GUEST_TSO4 anyway. It's about the LRO flag being set in
> > > features.
> > >
> > > How about this then? Just pretend to Linux that we disabled LRO.
> > >
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 8a58a2f013af..8e7e4cea176b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2651,8 +2651,9 @@ static int virtnet_set_features(struct net_devi=
ce *dev,
> > >                                    ~GUEST_OFFLOAD_LRO_MASK;
> > >
> > >                 err =3D virtnet_set_guest_offloads(vi, offloads);
> > > -               if (err)
> > > -                       return err;
> > > +               WARN_ON(err);
> > > +               //if (err)
> > > +               //      return err;
> > >                 vi->guest_offloads =3D offloads;
> > >         }
> >
> > No. With this applied, the problem persists:
> >
> > # echo "1" > /proc/sys/net/ipv4/ip_forward
> >
> > kernel: ------------[ cut here ]------------
> > kernel: netdevice: eth0: failed to disable LRO!
> > kernel: WARNING: CPU: 0 PID: 452 at net/core/dev.c:1768
> > dev_disable_lro+0x108/0x150
> > kernel: Modules linked in: sg nls_iso8859_1 nls_cp437 vfat fat
> > hid_generic usbhid hid virtio_net net_failover failover aesni_intel
> > libaes crypto_simd ohci_pci ahci libahci cryptd rapl ehci_pci ohci_hcd
> > ehci_hcd usbcore usb_common libata evdev lpc_ich mfd_core rng_core
> > i2c_piix4 i2c_core virtio_pci virtio_pci_modern_dev virtio_ring virtio
> > rtc_cmos atkbd libps2 i8042 serio battery ac button loop unix
> > kernel: CPU: 0 PID: 452 Comm: bash Not tainted 5.13.7-gnu.1-NuMini #1
> > kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> > VirtualBox 12/01/2006
> > kernel: RIP: 0010:dev_disable_lro+0x108/0x150
>
> Again the warning isn't a big deal. I agree we should address - Jason
> any update?

I still think using NETIF_F_LRO might not be correct. Since we're
basically receiving GSO packets.

And it might cause a lot of issues if the device doesn't have
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.

I see two possible fixes:

1) using NETIF_F_GRO_HW instead (the patch is attached)

or

2) set NETIF_F_LRO only if the device has CTRL_GUEST_OFFLOADS

Thanks

> But the main issue is you lose connectivity. That still
> persists with this? Can't you get a serial connection
> out? I know qemu Did the kernel oops afterwards?
>
> --
> MST
>

--0000000000008c0f0105c9405c2b
Content-Type: application/octet-stream; 
	name="0001-virtio-net-use-NETIF_F_GRO_HW-instead-of-NETIF_F_LRO.patch"
Content-Disposition: attachment; 
	filename="0001-virtio-net-use-NETIF_F_GRO_HW-instead-of-NETIF_F_LRO.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ks6y0yqh0>
X-Attachment-Id: f_ks6y0yqh0

RnJvbSAzZmNmMzAyNjg2YmM1ZmMwODBhNTgzMzhlYzg0ZmIyMWYzOTczMDcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDExIEF1ZyAyMDIxIDEwOjQ4OjIwICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmlydGlv
LW5ldDogdXNlIE5FVElGX0ZfR1JPX0hXIGluc3RlYWQgb2YgTkVUSUZfRl9MUk8KClNpZ25lZC1v
ZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIHwgMTQgKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCmluZGV4IDA0MTZhN2UwMDkxNC4uMTBj
MzgyYjA4YmNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCkBAIC02Myw3ICs2Myw3IEBAIHN0YXRpYyBjb25zdCB1bnNp
Z25lZCBsb25nIGd1ZXN0X29mZmxvYWRzW10gPSB7CiAJVklSVElPX05FVF9GX0dVRVNUX0NTVU0K
IH07CiAKLSNkZWZpbmUgR1VFU1RfT0ZGTE9BRF9MUk9fTUFTSyAoKDFVTEwgPDwgVklSVElPX05F
VF9GX0dVRVNUX1RTTzQpIHwgXAorI2RlZmluZSBHVUVTVF9PRkZMT0FEX0dST19IV19NQVNLICgo
MVVMTCA8PCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfCBcCiAJCQkJKDFVTEwgPDwgVklSVElP
X05FVF9GX0dVRVNUX1RTTzYpIHwgXAogCQkJCSgxVUxMIDw8IFZJUlRJT19ORVRfRl9HVUVTVF9F
Q04pICB8IFwKIAkJCQkoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKSkKQEAgLTI0ODEs
NyArMjQ4MSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfc2V0KHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsIHN0cnVjdCBicGZfcHJvZyAqcHJvZywKIAkgICAgICAgIHZpcnRpb19oYXNfZmVhdHVy
ZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0dVRVNUX0VDTikgfHwKIAkJdmlydGlvX2hhc19mZWF0
dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKSB8fAogCQl2aXJ0aW9faGFzX2Zl
YXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNKSkpIHsKLQkJTkxfU0VUX0VS
Ul9NU0dfTU9EKGV4dGFjaywgIkNhbid0IHNldCBYRFAgd2hpbGUgaG9zdCBpcyBpbXBsZW1lbnRp
bmcgTFJPL0NTVU0sIGRpc2FibGUgTFJPL0NTVU0gZmlyc3QiKTsKKwkJTkxfU0VUX0VSUl9NU0df
TU9EKGV4dGFjaywgIkNhbid0IHNldCBYRFAgd2hpbGUgaG9zdCBpcyBpbXBsZW1lbnRpbmcgR1JP
X0hXL0NTVU0sIGRpc2FibGUgR1JPX0hXL0NTVU0gZmlyc3QiKTsKIAkJcmV0dXJuIC1FT1BOT1RT
VVBQOwogCX0KIApAQCAtMjYxMiwxNSArMjYxMiwxNSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfc2V0
X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJdTY0IG9mZmxvYWRzOwogCWludCBl
cnI7CiAKLQlpZiAoKGRldi0+ZmVhdHVyZXMgXiBmZWF0dXJlcykgJiBORVRJRl9GX0xSTykgewor
CWlmICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0ZfR1JPX0hXKSB7CiAJCWlm
ICh2aS0+eGRwX2VuYWJsZWQpCiAJCQlyZXR1cm4gLUVCVVNZOwogCi0JCWlmIChmZWF0dXJlcyAm
IE5FVElGX0ZfTFJPKQorCQlpZiAoZmVhdHVyZXMgJiBORVRJRl9GX0dST19IVykKIAkJCW9mZmxv
YWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGU7CiAJCWVsc2UKIAkJCW9mZmxvYWRzID0g
dmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgotCQkJCSAgIH5HVUVTVF9PRkZMT0FEX0xST19N
QVNLOworCQkJCSAgIH5HVUVTVF9PRkZMT0FEX0dST19IV19NQVNLOwogCiAJCWVyciA9IHZpcnRu
ZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7CiAJCWlmIChlcnIpCkBAIC0zMTAw
LDkgKzMxMDAsOSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpCiAJCWRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9SWENTVU07CiAJaWYgKHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKIAkgICAgdmly
dGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSkKLQkJZGV2LT5m
ZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKKwkJZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0dST19I
VzsKIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNU
X09GRkxPQURTKSkKLQkJZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKKwkJZGV2LT5o
d19mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKIAogCWRldi0+dmxhbl9mZWF0dXJlcyA9IGRl
di0+ZmVhdHVyZXM7CiAKLS0gCjIuMjUuMQoK
--0000000000008c0f0105c9405c2b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--0000000000008c0f0105c9405c2b--


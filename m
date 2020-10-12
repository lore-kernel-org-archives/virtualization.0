Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0683C433E7
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 05:14:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314B72076E
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 05:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWFPYdoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314B72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ABD2F20763;
	Mon, 12 Oct 2020 05:14:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xaEwxUsSroOc; Mon, 12 Oct 2020 05:14:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 17BE02075B;
	Mon, 12 Oct 2020 05:14:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1195C07FF;
	Mon, 12 Oct 2020 05:14:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9E9C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 710FE86970
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jaugb+laV+cg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:14:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C548D8696B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 05:14:08 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id t25so21321147ejd.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 22:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Big7bGvu87t26z1KpFdcJ6WxeOkTwXFiiXOiuJHzbg=;
 b=pWFPYdoJzjyBb1RsWUzSNQagSrG8lJRv9TU2Gld0Od6jRGc0fKojXgkVN66uDvipNH
 Vi2diSFUStav5idjyfSil6M0WQ3RKSN0yW0FleXoLZczBIX0+kDyGgndptGXATpsnESS
 d0cRrKtgtNBAdf2+Aqk+PPmhIWF9rawoa1/8V/cLztx3i3sgl5gZ9VXL8E+CzSHWNBFR
 tnT8N/dsX04aPEfVDNcI8I8n0wMziW3MyY/yppq5tbwAA0+a5bNVOaTFmx195JB3sRwd
 ttIf7W6fyqgbLzMqk6gc/fAIuYO5o3WXKiRe0ksKFssK4kWAKFmnrmTdSdRx8Sm73mXQ
 Hmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Big7bGvu87t26z1KpFdcJ6WxeOkTwXFiiXOiuJHzbg=;
 b=RxHc7CvFtOy8vIHYT+wISNH8FCXd7jFYlPvccTt6fvIrnXjUlVzUJ2evnyfY4P3Rhe
 bURx6RGA7Aau57bvDYdeiQElV2XzH7wtnXJtfIdFwgoFrnC272TsyY0N1ArWLf/v6+Om
 wODLPLmbTITl0qU5l31o9CqCcqgcUi6ilcfdLa6JC7Yvbjxugr1Go9jrvUXVzq7YgAji
 KfkIE4TP9ZMRwg/Gr/OGpPekpd7rEGkqUTeD6ilsLf7+gMRom/RsC9WRwemImLYjIdBg
 cTOTb+/UK9KooKJyPRWIHYNjkdYhXcg3Pq157F8X93nPvfW8U9ztVaXgBB2TPeNjRXJ6
 aI3g==
X-Gm-Message-State: AOAM531TDOSWRF4pwDSaFhtZqoQ1iOX2m7PjUJbSriYVrIBTm6s8ci2I
 Dre6K5P77xcNTbSxll0enJ2tjmdXt9BLGHe7clU=
X-Google-Smtp-Source: ABdhPJwbVdGqJ4p6CXcaAiTuhD/NAnZO8/qA1hqU5THVs+5nkxEu+8MXaK6Jeq9zEcKZsWataAgCGQGt0r1L3KF7lYY=
X-Received: by 2002:a17:906:490d:: with SMTP id
 b13mr25901183ejq.122.1602479647081; 
 Sun, 11 Oct 2020 22:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
 <CA+FuTSed1GsGp8a=GnHqV-HUcsOSZ0tb0NCe8360S8Md3MbS3g@mail.gmail.com>
 <CAMDZJNWX=3ikS5f0H+xD-dByW2=JHXjvk1=R=CkDLt0TW-orTg@mail.gmail.com>
 <CA+FuTSeVRhM+q_WuWvBDMk+Ao61y+iJWTukpoLzNCHGfYG9=UA@mail.gmail.com>
 <CAMDZJNUY-F47m0aQ0wqG_O-ttauS0_dciBTrL=DU=Z_h-w+-Kw@mail.gmail.com>
 <CA+FuTSeOa1Xh4XtrKd2F2hJa5cn-+UA3-E3BKxe66oTJbxH3Vw@mail.gmail.com>
In-Reply-To: <CA+FuTSeOa1Xh4XtrKd2F2hJa5cn-+UA3-E3BKxe66oTJbxH3Vw@mail.gmail.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Mon, 12 Oct 2020 13:13:55 +0800
Message-ID: <CAMDZJNX62Kext4+FRKVKo5OuO3=drSGYj0Dt0W2OK+u3sr=3AA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio-net: ethtool configurable RXCSUM
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8984606702849589840=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8984606702849589840==
Content-Type: multipart/alternative; boundary="0000000000001fca9c05b1725ee5"

--0000000000001fca9c05b1725ee5
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 11, 2020 at 2:58 AM Willem de Bruijn <
willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 10:10 PM Tonghao Zhang <xiangxia.m.yue@gmail.com>
wrote:
> >
> > On Fri, Oct 9, 2020 at 9:49 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Thu, Oct 8, 2020 at 9:19 PM Tonghao Zhang <xiangxia.m.yue@gmail.com>
wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 6:05 PM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 30, 2020 at 4:05 AM <xiangxia.m.yue@gmail.com> wrote:
> > > > > >
> > > > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > > >
> > > > > > Allow user configuring RXCSUM separately with ethtool -K,
> > > > > > reusing the existing virtnet_set_guest_offloads helper
> > > > > > that configures RXCSUM for XDP. This is conditional on
> > > > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > > > >
> > > > > > If Rx checksum is disabled, LRO should also be disabled.
> > > > > >
> > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > >
> > > > > The first patch was merged into net.
> > > > >
> > > > > Please wait until that is merged into net-next, as this depends
on the
> > > > > other patch.
> > > > >
> > > > > > ---
> > > > > > v2:
> > > > > > * LRO depends the rx csum
> > > > > > * remove the unnecessary check
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 49
++++++++++++++++++++++++++++++----------
> > > > > >  1 file changed, 37 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 21b71148c532..5407a0106771 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] =
{
> > > > > >                                 (1ULL <<
VIRTIO_NET_F_GUEST_ECN)  | \
> > > > > >                                 (1ULL <<
VIRTIO_NET_F_GUEST_UFO))
> > > > > >
> > > > > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL <<
VIRTIO_NET_F_GUEST_CSUM)
> > > > > > +
> > > > > >  struct virtnet_stat_desc {
> > > > > >         char desc[ETH_GSTRING_LEN];
> > > > > >         size_t offset;
> > > > > > @@ -2522,29 +2524,49 @@ static int
virtnet_get_phys_port_name(struct net_device *dev, char *buf,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +static netdev_features_t virtnet_fix_features(struct
net_device *netdev,
> > > > > > +                                             netdev_features_t
features)
> > > > > > +{
> > > > > > +       /* If Rx checksum is disabled, LRO should also be
disabled.
> > > > > > +        * That is life. :)
> > > > >
> > > > > Please remove this second line.
> > > > OK
> > > > > > +        */
> > > > > > +       if (!(features & NETIF_F_RXCSUM))
> > > > > > +               features &= ~NETIF_F_LRO;
> > > > > > +
> > > > > > +       return features;
> > > > > > +}
> > > > > > +
> > > > > >  static int virtnet_set_features(struct net_device *dev,
> > > > > >                                 netdev_features_t features)
> > > > > >  {
> > > > > >         struct virtnet_info *vi = netdev_priv(dev);
> > > > > > -       u64 offloads;
> > > > > > +       u64 offloads = vi->guest_offloads &
> > > > > > +                      vi->guest_offloads_capable;
> > > > >
> > > > > When can vi->guest_offloads have bits set outside the mask of
> > > > > vi->guest_offloads_capable?
> > > > In this case, we can use only vi->guest_offloads. and
> > > > guest_offloads_capable will not be used any more.
> > > > so should we remove guest_offloads_capable ?
> > >
> > > That bitmap stores the capabilities of the device as learned at
> > > initial device probe. I don't see how it can be removed.
> > Hi Willem
> > guest_offloads_capable was introduced by
> > a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > and used only for LRO. Now we don't use it anymore, right ?
> > because this patch (virtio-net: ethtool configurable RXCSUM)
> > doesn't use it.
>
> It is needed, because it serves as an upper bound on configurable options.
>
> virtnet_set_features cannot enable LRO unless the LRO flags are
> captured by the feature negotiation at probe time.
>
> I think on enable you need something like
>
> -                       offloads = vi->guest_offloads_capable;
> +                       offloads |= vi->guest_offloads_capable &
> GUEST_OFFLOAD_LRO_MASK;
>
> instead of unconditional
>
> +                       offloads |= GUEST_OFFLOAD_LRO_MASK;
Thanks, I send v3 with your suggestion. please review.
http://patchwork.ozlabs.org/project/netdev/patch/20201012015820.62042-1-xiangxia.m.yue@gmail.com/



--
Best regards, Tonghao
-- 
Best regards, Tonghao

--0000000000001fca9c05b1725ee5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br>
<br>
On Sun, Oct 11, 2020 at 2:58 AM Willem de Bruijn &lt;<a href=3D"mailto:will=
emdebruijn.kernel@gmail.com" target=3D"_blank">willemdebruijn.kernel@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Oct 9, 2020 at 10:10 PM Tonghao Zhang &lt;<a href=3D"mailto:xi=
angxia.m.yue@gmail.com" target=3D"_blank">xiangxia.m.yue@gmail.com</a>&gt; =
wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Oct 9, 2020 at 9:49 PM Willem de Bruijn<br>
&gt; &gt; &lt;<a href=3D"mailto:willemdebruijn.kernel@gmail.com" target=3D"=
_blank">willemdebruijn.kernel@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Thu, Oct 8, 2020 at 9:19 PM Tonghao Zhang &lt;<a href=3D"=
mailto:xiangxia.m.yue@gmail.com" target=3D"_blank">xiangxia.m.yue@gmail.com=
</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, Sep 30, 2020 at 6:05 PM Willem de Bruijn<br>
&gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:willemdebruijn.kernel@gmail.com" =
target=3D"_blank">willemdebruijn.kernel@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Wed, Sep 30, 2020 at 4:05 AM &lt;<a href=3D"mai=
lto:xiangxia.m.yue@gmail.com" target=3D"_blank">xiangxia.m.yue@gmail.com</a=
>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; From: Tonghao Zhang &lt;<a href=3D"mailto:xia=
ngxia.m.yue@gmail.com" target=3D"_blank">xiangxia.m.yue@gmail.com</a>&gt;<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Allow user configuring RXCSUM separately with=
 ethtool -K,<br>
&gt; &gt; &gt; &gt; &gt; &gt; reusing the existing virtnet_set_guest_offloa=
ds helper<br>
&gt; &gt; &gt; &gt; &gt; &gt; that configures RXCSUM for XDP. This is condi=
tional on<br>
&gt; &gt; &gt; &gt; &gt; &gt; VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; If Rx checksum is disabled, LRO should also b=
e disabled.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Cc: Michael S. Tsirkin &lt;<a href=3D"mailto:=
mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Cc: Jason Wang &lt;<a href=3D"mailto:jasowang=
@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Tonghao Zhang &lt;<a href=3D"m=
ailto:xiangxia.m.yue@gmail.com" target=3D"_blank">xiangxia.m.yue@gmail.com<=
/a>&gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The first patch was merged into net.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Please wait until that is merged into net-next, as=
 this depends on the<br>
&gt; &gt; &gt; &gt; &gt; other patch.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt; &gt; v2:<br>
&gt; &gt; &gt; &gt; &gt; &gt; * LRO depends the rx csum<br>
&gt; &gt; &gt; &gt; &gt; &gt; * remove the unnecessary check<br>
&gt; &gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 drivers/net/virtio_net.c | 49 +++++++++=
+++++++++++++++++++++----------<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 37 insertions(+), 12 de=
letions(-)<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; diff --git a/drivers/net/virtio_net.c b/drive=
rs/net/virtio_net.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; index 21b71148c532..5407a0106771 100644<br>
&gt; &gt; &gt; &gt; &gt; &gt; --- a/drivers/net/virtio_net.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; +++ b/drivers/net/virtio_net.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; @@ -68,6 +68,8 @@ static const unsigned long =
guest_offloads[] =3D {<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VIRTIO_NET_F_GUEST_ECN)=C2=A0 | \<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
ULL &lt;&lt; VIRTIO_NET_F_GUEST_UFO))<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +#define GUEST_OFFLOAD_CSUM_MASK (1ULL &lt;&l=
t; VIRTIO_NET_F_GUEST_CSUM)<br>
&gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 struct virtnet_stat_desc {<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char desc[ET=
H_GSTRING_LEN];<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t offse=
t;<br>
&gt; &gt; &gt; &gt; &gt; &gt; @@ -2522,29 +2524,49 @@ static int virtnet_ge=
t_phys_port_name(struct net_device *dev, char *buf,<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br=
>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +static netdev_features_t virtnet_fix_feature=
s(struct net_device *netdev,<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netdev_features_t features)<br=
>
&gt; &gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If Rx checksum=
 is disabled, LRO should also be disabled.<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * That is life. =
:)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Please remove this second line.<br>
&gt; &gt; &gt; &gt; OK<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(features &a=
mp; NETIF_F_RXCSUM))<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0features &amp;=3D ~NETIF_F_LRO;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return features;<=
br>
&gt; &gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 static int virtnet_set_features(struct =
net_device *dev,<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ne=
tdev_features_t features)<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtn=
et_info *vi =3D netdev_priv(dev);<br>
&gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 offloads;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 offloads =3D =
vi-&gt;guest_offloads &amp;<br>
&gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi-&gt;guest_offloads_capable;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; When can vi-&gt;guest_offloads have bits set outsi=
de the mask of<br>
&gt; &gt; &gt; &gt; &gt; vi-&gt;guest_offloads_capable?<br>
&gt; &gt; &gt; &gt; In this case, we can use only vi-&gt;guest_offloads. an=
d<br>
&gt; &gt; &gt; &gt; guest_offloads_capable will not be used any more.<br>
&gt; &gt; &gt; &gt; so should we remove guest_offloads_capable ?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; That bitmap stores the capabilities of the device as learned=
 at<br>
&gt; &gt; &gt; initial device probe. I don&#39;t see how it can be removed.=
<br>
&gt; &gt; Hi Willem<br>
&gt; &gt; guest_offloads_capable was introduced by<br>
&gt; &gt; a02e8964eaf9 (&quot;virtio-net: ethtool configurable LRO&quot;)<b=
r>
&gt; &gt; and used only for LRO. Now we don&#39;t use it anymore, right ?<b=
r>
&gt; &gt; because this patch (virtio-net: ethtool configurable RXCSUM)<br>
&gt; &gt; doesn&#39;t use it.<br>
&gt;<br>
&gt; It is needed, because it serves as an upper bound on configurable opti=
ons.<br>
&gt;<br>
&gt; virtnet_set_features cannot enable LRO unless the LRO flags are<br>
&gt; captured by the feature negotiation at probe time.<br>
&gt;<br>
&gt; I think on enable you need something like<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0offloads =3D vi-&gt;guest_offloads_capable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0offloads |=3D vi-&gt;guest_offloads_capable &amp;<br>
&gt; GUEST_OFFLOAD_LRO_MASK;<br>
&gt;<br>
&gt; instead of unconditional<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0offloads |=3D GUEST_OFFLOAD_LRO_MASK;<br></div><div>
Thanks, I send v3 with your suggestion. please review.<br>
<a href=3D"http://patchwork.ozlabs.org/project/netdev/patch/20201012015820.=
62042-1-xiangxia.m.yue@gmail.com/" rel=3D"noreferrer" target=3D"_blank">htt=
p://patchwork.ozlabs.org/project/netdev/patch/20201012015820.62042-1-xiangx=
ia.m.yue@gmail.com/</a><br>
<br>
<br>
<br>
--<br>
Best regards, Tonghao<br>
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature">Best regards, Tonghao</div>

--0000000000001fca9c05b1725ee5--

--===============8984606702849589840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8984606702849589840==--

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9551C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FA0E40901;
	Tue,  8 Mar 2022 12:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJq9cSTPYJcB; Tue,  8 Mar 2022 12:31:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46151400D7;
	Tue,  8 Mar 2022 12:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF1CC001D;
	Tue,  8 Mar 2022 12:31:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ACABC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1966360F48
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SX-MNmqP34Am
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE12560F40
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646742690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/P3PdEGMtAdlx43Los4YDklBaFHjW3R+UsopxMvSM0=;
 b=gOQ4U05trCPjxlV/rJRKt8ECNjv+DZEJ7FUPfxzaK07+EY161MR+LPAwz2pkhvv/FPYDKJ
 OckzU+HwBzcRy1RXFe9rYvjNNbPVQss+0W8B8d9Enl9Oa46wnKwxDy3gE0PY7H6COvhlXp
 shnGsPqvzqCpZbQKqDkGoAsdWG8M0Io=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-eCechV5YP3i6hLDRP4V3kw-1; Tue, 08 Mar 2022 07:31:29 -0500
X-MC-Unique: eCechV5YP3i6hLDRP4V3kw-1
Received: by mail-ej1-f70.google.com with SMTP id
 r18-20020a17090609d200b006a6e943d09eso8573721eje.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 04:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=n/P3PdEGMtAdlx43Los4YDklBaFHjW3R+UsopxMvSM0=;
 b=DfpzK8BMxQZupyuypyHM8yYuWQYRG6zA7Z+61fs15iplNUNeLab9itpiYmt++Mo3Tg
 h03g0LYXL3wHYdvIsZY5MNgtJG0YCdoNIs73tiHCVkQuiw4JfdesdLLfY4zAa5n9v9ph
 q8+GNhTxU6+TOqi9We0foG/IZuxyg/ployCcLtk7XgS3V0JZxb4RGmPaSaCEhLasSGDh
 e7YCzaLsDMiW5OSDXJbgj394h/zX3fzLPih2XaPKmEt4i6ooZ/pr8yV4u0yxnhLkG/K6
 lWUV/tAcr4wSFaCRWwdMAUlwj10cMzAxdVJHUPsjJ93xmFcJmA1Bf+ZuD5Cpkd29/n+z
 xS3g==
X-Gm-Message-State: AOAM530mgzJq3R/6zIV/y1Q+lP488I99Cf7k7LvFBVJQtQmyWB9Urwfp
 bGtVzoebM2wo3lPPVJphwmZXG0o+PAnzRRu7HFugqxG7A8Pwgg3LlGNzYRbF0a/UF38owyW4R93
 KPYmz6z8/Ipmp89hiX+1oKKJ0uJzlC29EooE2B0aIHw==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id
 mu6-20020a1709068a8600b006ae9c3535c7mr13432912ejc.494.1646742688239; 
 Tue, 08 Mar 2022 04:31:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7MBlQpyflDvuMTfi6TSriqIE584JJbz7r1h/80sKMcJMhvbBOe6nZE7WIOxbOgpvWJiKHJA==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id
 mu6-20020a1709068a8600b006ae9c3535c7mr13432874ejc.494.1646742687944; 
 Tue, 08 Mar 2022 04:31:27 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 re27-20020a170906d8db00b006d76251f4e7sm5808407ejb.109.2022.03.08.04.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 04:31:27 -0800 (PST)
Date: Tue, 8 Mar 2022 07:31:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v5 15/15] vdpa: Add x-svq to NetdevVhostVDPAOptions
Message-ID: <20220308072914-mutt-send-email-mst@kernel.org>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <20220307153334.3854134-16-eperezma@redhat.com>
 <20220308021116-mutt-send-email-mst@kernel.org>
 <CAJaqyWewPYVPDOYTgKs03-LyfMHWkE+OR6tBEQ25rZ3YZmTrsw@mail.gmail.com>
 <20220308030140-mutt-send-email-mst@kernel.org>
 <CAJaqyWeAxjOtvtAD2Ow2MUXQpaBUbP21=CZ4g-S0pPizq_Az-g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeAxjOtvtAD2Ow2MUXQpaBUbP21=CZ4g-S0pPizq_Az-g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 08, 2022 at 09:24:05AM +0100, Eugenio Perez Martin wrote:
> On Tue, Mar 8, 2022 at 9:02 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:32:07AM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Mar 8, 2022 at 8:11 AM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > >
> > > > On Mon, Mar 07, 2022 at 04:33:34PM +0100, Eugenio P=E9rez wrote:
> > > > > Finally offering the possibility to enable SVQ from the command l=
ine.
> > > > >
> > > > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  qapi/net.json    |  8 +++++++-
> > > > >  net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++--=
------
> > > > >  2 files changed, 47 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/qapi/net.json b/qapi/net.json
> > > > > index 7fab2e7cd8..d626fa441c 100644
> > > > > --- a/qapi/net.json
> > > > > +++ b/qapi/net.json
> > > > > @@ -445,12 +445,18 @@
> > > > >  # @queues: number of queues to be created for multiqueue vhost-v=
dpa
> > > > >  #          (default: 1)
> > > > >  #
> > > > > +# @svq: Start device with (experimental) shadow virtqueue. (Sinc=
e 7.0)
> > > > > +#
> > > > > +# Features:
> > > > > +# @unstable: Member @svq is experimental.
> > > > > +#
> > > > >  # Since: 5.1
> > > > >  ##
> > > > >  { 'struct': 'NetdevVhostVDPAOptions',
> > > > >    'data': {
> > > > >      '*vhostdev':     'str',
> > > > > -    '*queues':       'int' } }
> > > > > +    '*queues':       'int',
> > > > > +    '*svq':          {'type': 'bool', 'features' : [ 'unstable']=
 } } }
> > > > >
> > > > >  ##
> > > > >  # @NetClientDriver:
> > > >
> > > > I think this should be x-svq same as other unstable features.
> > > >
> > >
> > > I'm fine with both, but I was pointed to the other direction at [1] a=
nd [2].
> > >
> > > Thanks!
> > >
> > > [1] https://patchwork.kernel.org/project/qemu-devel/patch/20220302203=
012.3476835-15-eperezma@redhat.com/
> > > [2] https://lore.kernel.org/qemu-devel/20220303185147.3605350-15-eper=
ezma@redhat.com/
> >
> >
> > I think what Markus didn't know is that a bunch of changes in
> > behaviour will occur before we rename it to "svq".
> > The rename is thus less of a bother more of a bonus.
> >
> =

> I'm totally fine with going back to x-svq. I'm not sure if it's more
> appropriate to do different modes of different parameters (svq=3Doff,
> dynamic-svq=3Don) or different modes of the same parameter (svq=3Don vs
> svq=3Don_migration). Or something totally different.
> =

> My impression is that all of the changes are covered with @unstable
> but I can see the advantage of x- prefix since we have not come to an
> agreement on it. I think it's the first time it is mentioned in the
> mail list.
> =

> Do you want me to send a new series with x- prefix?
> =

> Thanks!

Sure, I think it's a prudent thing to do simply because as you say the
semantics of the flag are likely to change yet.


> > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > index 1e9fe47c03..c827921654 100644
> > > > > --- a/net/vhost-vdpa.c
> > > > > +++ b/net/vhost-vdpa.c
> > > > > @@ -127,7 +127,11 @@ err_init:
> > > > >  static void vhost_vdpa_cleanup(NetClientState *nc)
> > > > >  {
> > > > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > > > +    struct vhost_dev *dev =3D s->vhost_vdpa.dev;
> > > > >
> > > > > +    if (dev && dev->vq_index + dev->nvqs =3D=3D dev->vq_index_en=
d) {
> > > > > +        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tre=
e_delete);
> > > > > +    }
> > > > >      if (s->vhost_net) {
> > > > >          vhost_net_cleanup(s->vhost_net);
> > > > >          g_free(s->vhost_net);
> > > > > @@ -187,13 +191,23 @@ static NetClientInfo net_vhost_vdpa_info =
=3D {
> > > > >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> > > > >  };
> > > > >
> > > > > +static int vhost_vdpa_get_iova_range(int fd,
> > > > > +                                     struct vhost_vdpa_iova_rang=
e *iova_range)
> > > > > +{
> > > > > +    int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range);
> > > > > +
> > > > > +    return ret < 0 ? -errno : 0;
> > > > > +}
> > > > > +
> > > > >  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> > > > > -                                           const char *device,
> > > > > -                                           const char *name,
> > > > > -                                           int vdpa_device_fd,
> > > > > -                                           int queue_pair_index,
> > > > > -                                           int nvqs,
> > > > > -                                           bool is_datapath)
> > > > > +                                       const char *device,
> > > > > +                                       const char *name,
> > > > > +                                       int vdpa_device_fd,
> > > > > +                                       int queue_pair_index,
> > > > > +                                       int nvqs,
> > > > > +                                       bool is_datapath,
> > > > > +                                       bool svq,
> > > > > +                                       VhostIOVATree *iova_tree)
> > > > >  {
> > > > >      NetClientState *nc =3D NULL;
> > > > >      VhostVDPAState *s;
> > > > > @@ -211,6 +225,8 @@ static NetClientState *net_vhost_vdpa_init(Ne=
tClientState *peer,
> > > > >
> > > > >      s->vhost_vdpa.device_fd =3D vdpa_device_fd;
> > > > >      s->vhost_vdpa.index =3D queue_pair_index;
> > > > > +    s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> > > > > +    s->vhost_vdpa.iova_tree =3D iova_tree;
> > > > >      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pai=
r_index, nvqs);
> > > > >      if (ret) {
> > > > >          qemu_del_net_client(nc);
> > > > > @@ -266,6 +282,7 @@ int net_init_vhost_vdpa(const Netdev *netdev,=
 const char *name,
> > > > >      g_autofree NetClientState **ncs =3D NULL;
> > > > >      NetClientState *nc;
> > > > >      int queue_pairs, i, has_cvq =3D 0;
> > > > > +    g_autoptr(VhostIOVATree) iova_tree =3D NULL;
> > > > >
> > > > >      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > > > >      opts =3D &netdev->u.vhost_vdpa;
> > > > > @@ -285,29 +302,44 @@ int net_init_vhost_vdpa(const Netdev *netde=
v, const char *name,
> > > > >          qemu_close(vdpa_device_fd);
> > > > >          return queue_pairs;
> > > > >      }
> > > > > +    if (opts->svq) {
> > > > > +        struct vhost_vdpa_iova_range iova_range;
> > > > > +
> > > > > +        if (has_cvq) {
> > > > > +            error_setg(errp, "vdpa svq does not work with cvq");
> > > > > +            goto err_svq;
> > > > > +        }
> > > > > +        vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> > > > > +        iova_tree =3D vhost_iova_tree_new(iova_range.first, iova=
_range.last);
> > > > > +    }
> > > > >
> > > > >      ncs =3D g_malloc0(sizeof(*ncs) * queue_pairs);
> > > > >
> > > > >      for (i =3D 0; i < queue_pairs; i++) {
> > > > >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, na=
me,
> > > > > -                                     vdpa_device_fd, i, 2, true);
> > > > > +                                     vdpa_device_fd, i, 2, true,=
 opts->svq,
> > > > > +                                     iova_tree);
> > > > >          if (!ncs[i])
> > > > >              goto err;
> > > > >      }
> > > > >
> > > > >      if (has_cvq) {
> > > > >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > > > > -                                 vdpa_device_fd, i, 1, false);
> > > > > +                                 vdpa_device_fd, i, 1, false, op=
ts->svq,
> > > > > +                                 iova_tree);
> > > > >          if (!nc)
> > > > >              goto err;
> > > > >      }
> > > > >
> > > > > +    iova_tree =3D NULL;
> > > > >      return 0;
> > > > >
> > > > >  err:
> > > > >      if (i) {
> > > > >          qemu_del_net_client(ncs[0]);
> > > > >      }
> > > > > +
> > > > > +err_svq:
> > > > >      qemu_close(vdpa_device_fd);
> > > > >
> > > > >      return -1;
> > > > > --
> > > > > 2.27.0
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

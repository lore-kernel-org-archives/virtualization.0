Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6632C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 11:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12FCE40AFA;
	Wed, 21 Dec 2022 11:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12FCE40AFA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XE13NZWZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a9CcWrHxAZJt; Wed, 21 Dec 2022 11:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79BE24011C;
	Wed, 21 Dec 2022 11:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79BE24011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01AD2C0071;
	Wed, 21 Dec 2022 11:47:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD049C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 11:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F38EF60760
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 11:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F38EF60760
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XE13NZWZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoiuUN9gsgO0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 11:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3D5B60093
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3D5B60093
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671623236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtRxOgX0TZOayu+PRuST1sFSCcBr/Ov+tY3NROTlMbQ=;
 b=XE13NZWZo/759InrZSJDctvy6LfdNcccCFH1QJ8huIe37OW0tKPgWvj63XtvbhXyexoCC1
 tsve1trrp2bESbJKueY+TT+8tKAeQRCvvXaCrRkI1N/Ra/pr7HsYVISM4VaRkGGAd9ys6a
 m40IVUhAHmdtLeb0AGqwlAsBEVIEF2M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-SV2x3NhuPquzs4nJ5vh6BQ-1; Wed, 21 Dec 2022 06:47:12 -0500
X-MC-Unique: SV2x3NhuPquzs4nJ5vh6BQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 e18-20020ac84912000000b003a96d6f436fso6861196qtq.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtRxOgX0TZOayu+PRuST1sFSCcBr/Ov+tY3NROTlMbQ=;
 b=q4SDFOvJ/cxf+h366D9WEoq2kWYwqrrIpHR5qlUKn+G90Dy2HwFEPedcbUDcUV4DGt
 TiSKRn+ZugLlm1VnAY8eOkBE+GiExh4yHiDxyt7ItbprcqZVnlx+lTsQvgRZdwuSGBQ4
 sIEPF4jiloFgwTltOmwWq0HLkMyJCwtwvFOQmFZRPca3g5sTI2aub9NMc1Bd7NYkzB2d
 02CKHyV57mOeObYqhS29fIvSCXXTRldeu8dJEP/y0LqvzJ3KyaAMEf0nsJiFOJGHIzEI
 HqM3xYZAhJNq7cr79NlZMvBEr9VjowAvfCma1NTD7ZEdNmbMwHedSE0ottHeYUW3Yfyu
 2HeA==
X-Gm-Message-State: AFqh2kraSoCdefp5kezj38Eg8GMGk1+vMkQGVC4iDx2NCFc34o8UG9JU
 +hhAzM2IwdcdVg4CtI/TCb3vXNwNIHafVA2v9l14xnDnO5kG78J6iFHGyG9ApiDtUP6nXP7QyUj
 xNjIsiawdkhf6rwr/L2I33bMscRJbnQEzfsqNpxtCTA==
X-Received: by 2002:a05:6214:5443:b0:4c7:80fa:755c with SMTP id
 kz3-20020a056214544300b004c780fa755cmr1379820qvb.45.1671623232262; 
 Wed, 21 Dec 2022 03:47:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtCgdSPiFJ0Kc3hCB+/E4fHjzkyrWfeDKkFFyw04R0HX5of4NBMeHt0cwR58dN52CLO78Pcjw==
X-Received: by 2002:a05:6214:5443:b0:4c7:80fa:755c with SMTP id
 kz3-20020a056214544300b004c780fa755cmr1379794qvb.45.1671623231982; 
 Wed, 21 Dec 2022 03:47:11 -0800 (PST)
Received: from redhat.com ([37.19.199.117]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05620a290900b006fa8299b4d5sm11066079qkp.100.2022.12.21.03.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 03:47:11 -0800 (PST)
Date: Wed, 21 Dec 2022 06:47:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v9 06/12] vdpa: request iova_range only once
Message-ID: <20221221064619-mutt-send-email-mst@kernel.org>
References: <20221215113144.322011-1-eperezma@redhat.com>
 <20221215113144.322011-7-eperezma@redhat.com>
 <CACGkMEtE_6nci5zwQZbOMbu3e9gh4aa_88WjTgkWkjKqQBB3Zw@mail.gmail.com>
 <CAJaqyWcxeuOiHYBb_ftedSrJpNpN9vQJ2sZZ_5cZh4RsQSdgVQ@mail.gmail.com>
 <CACGkMEtkWJQVrnuG7CKJ+zFcMFhhZs3=iFPjv85U7KAjkpd=EA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtkWJQVrnuG7CKJ+zFcMFhhZs3=iFPjv85U7KAjkpd=EA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 Longpeng <longpeng2@huawei.com>
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

On Wed, Dec 21, 2022 at 04:21:52PM +0800, Jason Wang wrote:
> On Fri, Dec 16, 2022 at 5:53 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 8:29 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Dec 15, 2022 at 7:32 PM Eugenio P=E9rez <eperezma@redhat.com>=
 wrote:
> > > >
> > > > Currently iova range is requested once per queue pair in the case of
> > > > net. Reduce the number of ioctls asking it once at initialization a=
nd
> > > > reusing that value for each vhost_vdpa.
> > > >
> > > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-vdpa.c | 15 ---------------
> > > >  net/vhost-vdpa.c       | 27 ++++++++++++++-------------
> > > >  2 files changed, 14 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > > index 691bcc811a..9b7f4ef083 100644
> > > > --- a/hw/virtio/vhost-vdpa.c
> > > > +++ b/hw/virtio/vhost-vdpa.c
> > > > @@ -365,19 +365,6 @@ static int vhost_vdpa_add_status(struct vhost_=
dev *dev, uint8_t status)
> > > >      return 0;
> > > >  }
> > > >
> > > > -static void vhost_vdpa_get_iova_range(struct vhost_vdpa *v)
> > > > -{
> > > > -    int ret =3D vhost_vdpa_call(v->dev, VHOST_VDPA_GET_IOVA_RANGE,
> > > > -                              &v->iova_range);
> > > > -    if (ret !=3D 0) {
> > > > -        v->iova_range.first =3D 0;
> > > > -        v->iova_range.last =3D UINT64_MAX;
> > > > -    }
> > > > -
> > > > -    trace_vhost_vdpa_get_iova_range(v->dev, v->iova_range.first,
> > > > -                                    v->iova_range.last);
> > > > -}
> > > > -
> > > >  /*
> > > >   * The use of this function is for requests that only need to be
> > > >   * applied once. Typically such request occurs at the beginning
> > > > @@ -465,8 +452,6 @@ static int vhost_vdpa_init(struct vhost_dev *de=
v, void *opaque, Error **errp)
> > > >          goto err;
> > > >      }
> > > >
> > > > -    vhost_vdpa_get_iova_range(v);
> > > > -
> > > >      if (!vhost_vdpa_first_dev(dev)) {
> > > >          return 0;
> > > >      }
> > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > index 2c0ff6d7b0..b6462f0192 100644
> > > > --- a/net/vhost-vdpa.c
> > > > +++ b/net/vhost-vdpa.c
> > > > @@ -541,14 +541,15 @@ static const VhostShadowVirtqueueOps vhost_vd=
pa_net_svq_ops =3D {
> > > >  };
> > > >
> > > >  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> > > > -                                           const char *device,
> > > > -                                           const char *name,
> > > > -                                           int vdpa_device_fd,
> > > > -                                           int queue_pair_index,
> > > > -                                           int nvqs,
> > > > -                                           bool is_datapath,
> > > > -                                           bool svq,
> > > > -                                           VhostIOVATree *iova_tre=
e)
> > > > +                                       const char *device,
> > > > +                                       const char *name,
> > > > +                                       int vdpa_device_fd,
> > > > +                                       int queue_pair_index,
> > > > +                                       int nvqs,
> > > > +                                       bool is_datapath,
> > > > +                                       bool svq,
> > > > +                                       struct vhost_vdpa_iova_rang=
e iova_range,
> > > > +                                       VhostIOVATree *iova_tree)
> > >
> > > Nit: it's better not mix style changes.
> > >
> >
> > The style changes are because the new parameter is longer than 80
> > characters, do you prefer me to send a previous patch reducing
> > indentation?
> >
> =

> Michale, what's your preference? I'm fine with both.
> =

> Thanks

I think it doesn't matter much, but generally 80 char limit is
not a hard limit. We can just let it be.

> > Thanks!
> >
> > > Other than this:
> > >
> > > Acked-by: Jason Wang <jasonwang@redhat.com>
> > >
> > > Thanks
> > >
> > > >  {
> > > >      NetClientState *nc =3D NULL;
> > > >      VhostVDPAState *s;
> > > > @@ -567,6 +568,7 @@ static NetClientState *net_vhost_vdpa_init(NetC=
lientState *peer,
> > > >      s->vhost_vdpa.device_fd =3D vdpa_device_fd;
> > > >      s->vhost_vdpa.index =3D queue_pair_index;
> > > >      s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> > > > +    s->vhost_vdpa.iova_range =3D iova_range;
> > > >      s->vhost_vdpa.iova_tree =3D iova_tree;
> > > >      if (!is_datapath) {
> > > >          s->cvq_cmd_out_buffer =3D qemu_memalign(qemu_real_host_pag=
e_size(),
> > > > @@ -646,6 +648,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, c=
onst char *name,
> > > >      int vdpa_device_fd;
> > > >      g_autofree NetClientState **ncs =3D NULL;
> > > >      g_autoptr(VhostIOVATree) iova_tree =3D NULL;
> > > > +    struct vhost_vdpa_iova_range iova_range;
> > > >      NetClientState *nc;
> > > >      int queue_pairs, r, i =3D 0, has_cvq =3D 0;
> > > >
> > > > @@ -689,14 +692,12 @@ int net_init_vhost_vdpa(const Netdev *netdev,=
 const char *name,
> > > >          return queue_pairs;
> > > >      }
> > > >
> > > > +    vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> > > >      if (opts->x_svq) {
> > > > -        struct vhost_vdpa_iova_range iova_range;
> > > > -
> > > >          if (!vhost_vdpa_net_valid_svq_features(features, errp)) {
> > > >              goto err_svq;
> > > >          }
> > > >
> > > > -        vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> > > >          iova_tree =3D vhost_iova_tree_new(iova_range.first, iova_r=
ange.last);
> > > >      }
> > > >
> > > > @@ -705,7 +706,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, c=
onst char *name,
> > > >      for (i =3D 0; i < queue_pairs; i++) {
> > > >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > > >                                       vdpa_device_fd, i, 2, true, o=
pts->x_svq,
> > > > -                                     iova_tree);
> > > > +                                     iova_range, iova_tree);
> > > >          if (!ncs[i])
> > > >              goto err;
> > > >      }
> > > > @@ -713,7 +714,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, c=
onst char *name,
> > > >      if (has_cvq) {
> > > >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > > >                                   vdpa_device_fd, i, 1, false,
> > > > -                                 opts->x_svq, iova_tree);
> > > > +                                 opts->x_svq, iova_range, iova_tre=
e);
> > > >          if (!nc)
> > > >              goto err;
> > > >      }
> > > > --
> > > > 2.31.1
> > > >
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

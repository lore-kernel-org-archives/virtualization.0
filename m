Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DCC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 08:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C725960F1D;
	Tue,  8 Mar 2022 08:02:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rt3wA0U96aW8; Tue,  8 Mar 2022 08:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2465960F1A;
	Tue,  8 Mar 2022 08:02:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB712C0012;
	Tue,  8 Mar 2022 08:02:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73782C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52C5284113
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wb527Sr3r1un
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:02:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C24F82437
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646726565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W35QJgjsnBHR4lcD0q02yu0x8qnsa92tFu5QyCbwiWw=;
 b=c2Heoa8QfK6yWkqjsr4aMw1lUhNdjIjGJJdfWcj8b8aRHA7b6S59Wcqtgp03bPiCV30sZN
 8eA9Ott2D0zfhnne2+4LpKqfVabdnFfeZ4zVIkso54fwRIAKrWjfwlC54nyx2qGlcqb4aZ
 42nyHbPXgYwpvvx5yRVYBR4Z5Mvv6Xw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-VXUCcGbVPweztd4wX73tkg-1; Tue, 08 Mar 2022 03:02:42 -0500
X-MC-Unique: VXUCcGbVPweztd4wX73tkg-1
Received: by mail-ej1-f69.google.com with SMTP id
 og24-20020a1709071dd800b006dab87bec4fso4791218ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 00:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=W35QJgjsnBHR4lcD0q02yu0x8qnsa92tFu5QyCbwiWw=;
 b=bid1pqWQfWlAH+5XG4BEqK/lnptMc7KxuAHW6rFlq0l9bpFAarNOP/LOvstsC1qtHc
 cKF37dD5ZBOkjerWi8tr+gUZTOVuViTkTwGbILy9Mxt4voJg+40LKDaWJrtBNtFLkz5i
 z9MBEOd2NdGiA5ZsO1lGCITQyt4QFGHjlH1neuWjUoxVgV0huS9t+FIXI1Evp2l7AyR1
 2hjhbhcuOKzgIN15WM3qb0cKsXoiYGJaRKBB8YUQ3Zpe2mP2KWNV1bnM29TvD4GQou5h
 iZoDM7/vxQdJ2HVQ/Vn06GRcVwBApBEg5pznI7d5UeGzTpJrZ+hav2HFXaa09bw6cX2Z
 wlig==
X-Gm-Message-State: AOAM532l63NoXVd065zPjXis6ai2HV8JPR6QlOt0pVwUyY4e5DgqufVa
 dDXkOfye9hL3VsqIGc3fszH5snair120mlCwlODCWwwyuyWV2Uu3EiygQdZyYn2/JNOkPgn3WxX
 tvxb4926Ble7rXXdpv+4XLrFs6fIGG8kpbr7zA2tMsA==
X-Received: by 2002:a17:907:7656:b0:6d0:1f5a:2bec with SMTP id
 kj22-20020a170907765600b006d01f5a2becmr12125049ejc.164.1646726560862; 
 Tue, 08 Mar 2022 00:02:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmwd0vSgr2Yp7qTawkALOqV2wMVU79g/QbkLzI4V+jzZqTxBuiMYnhayZgrg1/rRXY4x2tKg==
X-Received: by 2002:a17:907:7656:b0:6d0:1f5a:2bec with SMTP id
 kj22-20020a170907765600b006d01f5a2becmr12125014ejc.164.1646726560550; 
 Tue, 08 Mar 2022 00:02:40 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 k18-20020a50ce52000000b0040f75ad0e60sm7417963edj.83.2022.03.08.00.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 00:02:40 -0800 (PST)
Date: Tue, 8 Mar 2022 03:02:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v5 15/15] vdpa: Add x-svq to NetdevVhostVDPAOptions
Message-ID: <20220308030140-mutt-send-email-mst@kernel.org>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <20220307153334.3854134-16-eperezma@redhat.com>
 <20220308021116-mutt-send-email-mst@kernel.org>
 <CAJaqyWewPYVPDOYTgKs03-LyfMHWkE+OR6tBEQ25rZ3YZmTrsw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWewPYVPDOYTgKs03-LyfMHWkE+OR6tBEQ25rZ3YZmTrsw@mail.gmail.com>
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

On Tue, Mar 08, 2022 at 08:32:07AM +0100, Eugenio Perez Martin wrote:
> On Tue, Mar 8, 2022 at 8:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Mar 07, 2022 at 04:33:34PM +0100, Eugenio P=E9rez wrote:
> > > Finally offering the possibility to enable SVQ from the command line.
> > >
> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > ---
> > >  qapi/net.json    |  8 +++++++-
> > >  net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++------=
--
> > >  2 files changed, 47 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/qapi/net.json b/qapi/net.json
> > > index 7fab2e7cd8..d626fa441c 100644
> > > --- a/qapi/net.json
> > > +++ b/qapi/net.json
> > > @@ -445,12 +445,18 @@
> > >  # @queues: number of queues to be created for multiqueue vhost-vdpa
> > >  #          (default: 1)
> > >  #
> > > +# @svq: Start device with (experimental) shadow virtqueue. (Since 7.=
0)
> > > +#
> > > +# Features:
> > > +# @unstable: Member @svq is experimental.
> > > +#
> > >  # Since: 5.1
> > >  ##
> > >  { 'struct': 'NetdevVhostVDPAOptions',
> > >    'data': {
> > >      '*vhostdev':     'str',
> > > -    '*queues':       'int' } }
> > > +    '*queues':       'int',
> > > +    '*svq':          {'type': 'bool', 'features' : [ 'unstable'] } }=
 }
> > >
> > >  ##
> > >  # @NetClientDriver:
> >
> > I think this should be x-svq same as other unstable features.
> >
> =

> I'm fine with both, but I was pointed to the other direction at [1] and [=
2].
> =

> Thanks!
> =

> [1] https://patchwork.kernel.org/project/qemu-devel/patch/20220302203012.=
3476835-15-eperezma@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/20220303185147.3605350-15-eperezma=
@redhat.com/


I think what Markus didn't know is that a bunch of changes in
behaviour will occur before we rename it to "svq".
The rename is thus less of a bother more of a bonus.

> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 1e9fe47c03..c827921654 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -127,7 +127,11 @@ err_init:
> > >  static void vhost_vdpa_cleanup(NetClientState *nc)
> > >  {
> > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > +    struct vhost_dev *dev =3D s->vhost_vdpa.dev;
> > >
> > > +    if (dev && dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
> > > +        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_de=
lete);
> > > +    }
> > >      if (s->vhost_net) {
> > >          vhost_net_cleanup(s->vhost_net);
> > >          g_free(s->vhost_net);
> > > @@ -187,13 +191,23 @@ static NetClientInfo net_vhost_vdpa_info =3D {
> > >          .check_peer_type =3D vhost_vdpa_check_peer_type,
> > >  };
> > >
> > > +static int vhost_vdpa_get_iova_range(int fd,
> > > +                                     struct vhost_vdpa_iova_range *i=
ova_range)
> > > +{
> > > +    int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range);
> > > +
> > > +    return ret < 0 ? -errno : 0;
> > > +}
> > > +
> > >  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> > > -                                           const char *device,
> > > -                                           const char *name,
> > > -                                           int vdpa_device_fd,
> > > -                                           int queue_pair_index,
> > > -                                           int nvqs,
> > > -                                           bool is_datapath)
> > > +                                       const char *device,
> > > +                                       const char *name,
> > > +                                       int vdpa_device_fd,
> > > +                                       int queue_pair_index,
> > > +                                       int nvqs,
> > > +                                       bool is_datapath,
> > > +                                       bool svq,
> > > +                                       VhostIOVATree *iova_tree)
> > >  {
> > >      NetClientState *nc =3D NULL;
> > >      VhostVDPAState *s;
> > > @@ -211,6 +225,8 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> > >
> > >      s->vhost_vdpa.device_fd =3D vdpa_device_fd;
> > >      s->vhost_vdpa.index =3D queue_pair_index;
> > > +    s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> > > +    s->vhost_vdpa.iova_tree =3D iova_tree;
> > >      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_in=
dex, nvqs);
> > >      if (ret) {
> > >          qemu_del_net_client(nc);
> > > @@ -266,6 +282,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
> > >      g_autofree NetClientState **ncs =3D NULL;
> > >      NetClientState *nc;
> > >      int queue_pairs, i, has_cvq =3D 0;
> > > +    g_autoptr(VhostIOVATree) iova_tree =3D NULL;
> > >
> > >      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >      opts =3D &netdev->u.vhost_vdpa;
> > > @@ -285,29 +302,44 @@ int net_init_vhost_vdpa(const Netdev *netdev, c=
onst char *name,
> > >          qemu_close(vdpa_device_fd);
> > >          return queue_pairs;
> > >      }
> > > +    if (opts->svq) {
> > > +        struct vhost_vdpa_iova_range iova_range;
> > > +
> > > +        if (has_cvq) {
> > > +            error_setg(errp, "vdpa svq does not work with cvq");
> > > +            goto err_svq;
> > > +        }
> > > +        vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> > > +        iova_tree =3D vhost_iova_tree_new(iova_range.first, iova_ran=
ge.last);
> > > +    }
> > >
> > >      ncs =3D g_malloc0(sizeof(*ncs) * queue_pairs);
> > >
> > >      for (i =3D 0; i < queue_pairs; i++) {
> > >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > > -                                     vdpa_device_fd, i, 2, true);
> > > +                                     vdpa_device_fd, i, 2, true, opt=
s->svq,
> > > +                                     iova_tree);
> > >          if (!ncs[i])
> > >              goto err;
> > >      }
> > >
> > >      if (has_cvq) {
> > >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> > > -                                 vdpa_device_fd, i, 1, false);
> > > +                                 vdpa_device_fd, i, 1, false, opts->=
svq,
> > > +                                 iova_tree);
> > >          if (!nc)
> > >              goto err;
> > >      }
> > >
> > > +    iova_tree =3D NULL;
> > >      return 0;
> > >
> > >  err:
> > >      if (i) {
> > >          qemu_del_net_client(ncs[0]);
> > >      }
> > > +
> > > +err_svq:
> > >      qemu_close(vdpa_device_fd);
> > >
> > >      return -1;
> > > --
> > > 2.27.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

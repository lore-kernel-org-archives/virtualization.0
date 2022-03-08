Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E86C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 07:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 427BE60D51;
	Tue,  8 Mar 2022 07:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5pHuzHNdQ5OR; Tue,  8 Mar 2022 07:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CCAD860E87;
	Tue,  8 Mar 2022 07:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3C37C001D;
	Tue,  8 Mar 2022 07:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C120BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A181960E87
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4SPqzYxKbgbn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:11:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC71060D51
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646723514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OCY4OT9tZpcgCfvd1EKMKAZOmVH6SWXwzL20tU263M=;
 b=VzQAZqq2++Q2YYrd0WRs1tq09EP6I+nY4dCyMrocsOYWOh4MCODqF7vgzYWbE5CN0kfFl6
 JV2AfSSy4ftzOVEw78IaW+L5eO8BC/hLySnW6cvcqa6MpXtEIfCGdWzqPcJ40mX2anWX5I
 9Y2nGgNjGunZb1OATByM59S7LMXxSCM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-haaQPYwSNu2KxM3ckG72zA-1; Tue, 08 Mar 2022 02:11:51 -0500
X-MC-Unique: haaQPYwSNu2KxM3ckG72zA-1
Received: by mail-ed1-f69.google.com with SMTP id
 l8-20020a056402028800b0041636072ef0so3999667edv.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 23:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7OCY4OT9tZpcgCfvd1EKMKAZOmVH6SWXwzL20tU263M=;
 b=O9f+tUFieM2PK0fnsmAGdlcjJtZVqdtrc4ecgN9JqwFOScZsiBtH0QoMREZdUI9vh+
 WiZ2/iH1NtMLXeIMtHY/YWUIx48hMabBHgFKmOfv6s5Ksq1AwllLmtzTR4bhJoalYzN0
 3m+vun0ctcXqA10m+CgJ5w8R3PyisW2oN1gPLwejlk4tPyCrR3pc7OaPE1U4e7S9/7HO
 fRR0eaLSPuxh6XcYl5JTTZC3k1nVPssBgMzCvwflHrIprZdWVOi8mmxnn1985iFwQ0R3
 RHPGaaX/iq2MXSjhL3e6M3xh7Y8FGYLWsGxjHmPDkzO0ivwfC+ZoT7CO5J1l6GlTBeHq
 1+jA==
X-Gm-Message-State: AOAM530nsblyb7TnGO6pWk+BEvdl7hvN7IZACsB+TU6dklk0Cn2jhqtC
 kpcVFhW1Idj9zoD1GD+KFnfX5lg6xDhd5fahnPJUTLeBZ+iDFURbS2Ehjv3o7VJU5YK7/AjWshN
 3o2oyFJvWE3AChKbgIvQqNbg9RFQDWtMLt9v1VwAAdQ==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id
 k11-20020a17090666cb00b006cfe4f79504mr12408296ejp.142.1646723510392; 
 Mon, 07 Mar 2022 23:11:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSNJDkCRToaorgRXdcNJQODs81xb/a5ZbwoPlRWokgjZOiMsKymQpy2HYV9k0Kmmq2PHXGHg==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id
 k11-20020a17090666cb00b006cfe4f79504mr12408286ejp.142.1646723510140; 
 Mon, 07 Mar 2022 23:11:50 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 dn14-20020a05640222ee00b00410b88abd6fsm7218021edb.45.2022.03.07.23.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 23:11:49 -0800 (PST)
Date: Tue, 8 Mar 2022 02:11:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v5 15/15] vdpa: Add x-svq to NetdevVhostVDPAOptions
Message-ID: <20220308021116-mutt-send-email-mst@kernel.org>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <20220307153334.3854134-16-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220307153334.3854134-16-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
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

On Mon, Mar 07, 2022 at 04:33:34PM +0100, Eugenio P=E9rez wrote:
> Finally offering the possibility to enable SVQ from the command line.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  qapi/net.json    |  8 +++++++-
>  net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 47 insertions(+), 9 deletions(-)
> =

> diff --git a/qapi/net.json b/qapi/net.json
> index 7fab2e7cd8..d626fa441c 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -445,12 +445,18 @@
>  # @queues: number of queues to be created for multiqueue vhost-vdpa
>  #          (default: 1)
>  #
> +# @svq: Start device with (experimental) shadow virtqueue. (Since 7.0)
> +#
> +# Features:
> +# @unstable: Member @svq is experimental.
> +#
>  # Since: 5.1
>  ##
>  { 'struct': 'NetdevVhostVDPAOptions',
>    'data': {
>      '*vhostdev':     'str',
> -    '*queues':       'int' } }
> +    '*queues':       'int',
> +    '*svq':          {'type': 'bool', 'features' : [ 'unstable'] } } }
>  =

>  ##
>  # @NetClientDriver:

I think this should be x-svq same as other unstable features.

> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 1e9fe47c03..c827921654 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -127,7 +127,11 @@ err_init:
>  static void vhost_vdpa_cleanup(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    struct vhost_dev *dev =3D s->vhost_vdpa.dev;
>  =

> +    if (dev && dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
> +        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete=
);
> +    }
>      if (s->vhost_net) {
>          vhost_net_cleanup(s->vhost_net);
>          g_free(s->vhost_net);
> @@ -187,13 +191,23 @@ static NetClientInfo net_vhost_vdpa_info =3D {
>          .check_peer_type =3D vhost_vdpa_check_peer_type,
>  };
>  =

> +static int vhost_vdpa_get_iova_range(int fd,
> +                                     struct vhost_vdpa_iova_range *iova_=
range)
> +{
> +    int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range);
> +
> +    return ret < 0 ? -errno : 0;
> +}
> +
>  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
> -                                           const char *device,
> -                                           const char *name,
> -                                           int vdpa_device_fd,
> -                                           int queue_pair_index,
> -                                           int nvqs,
> -                                           bool is_datapath)
> +                                       const char *device,
> +                                       const char *name,
> +                                       int vdpa_device_fd,
> +                                       int queue_pair_index,
> +                                       int nvqs,
> +                                       bool is_datapath,
> +                                       bool svq,
> +                                       VhostIOVATree *iova_tree)
>  {
>      NetClientState *nc =3D NULL;
>      VhostVDPAState *s;
> @@ -211,6 +225,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientS=
tate *peer,
>  =

>      s->vhost_vdpa.device_fd =3D vdpa_device_fd;
>      s->vhost_vdpa.index =3D queue_pair_index;
> +    s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> +    s->vhost_vdpa.iova_tree =3D iova_tree;
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
>          qemu_del_net_client(nc);
> @@ -266,6 +282,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const c=
har *name,
>      g_autofree NetClientState **ncs =3D NULL;
>      NetClientState *nc;
>      int queue_pairs, i, has_cvq =3D 0;
> +    g_autoptr(VhostIOVATree) iova_tree =3D NULL;
>  =

>      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>      opts =3D &netdev->u.vhost_vdpa;
> @@ -285,29 +302,44 @@ int net_init_vhost_vdpa(const Netdev *netdev, const=
 char *name,
>          qemu_close(vdpa_device_fd);
>          return queue_pairs;
>      }
> +    if (opts->svq) {
> +        struct vhost_vdpa_iova_range iova_range;
> +
> +        if (has_cvq) {
> +            error_setg(errp, "vdpa svq does not work with cvq");
> +            goto err_svq;
> +        }
> +        vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> +        iova_tree =3D vhost_iova_tree_new(iova_range.first, iova_range.l=
ast);
> +    }
>  =

>      ncs =3D g_malloc0(sizeof(*ncs) * queue_pairs);
>  =

>      for (i =3D 0; i < queue_pairs; i++) {
>          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> -                                     vdpa_device_fd, i, 2, true);
> +                                     vdpa_device_fd, i, 2, true, opts->s=
vq,
> +                                     iova_tree);
>          if (!ncs[i])
>              goto err;
>      }
>  =

>      if (has_cvq) {
>          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> -                                 vdpa_device_fd, i, 1, false);
> +                                 vdpa_device_fd, i, 1, false, opts->svq,
> +                                 iova_tree);
>          if (!nc)
>              goto err;
>      }
>  =

> +    iova_tree =3D NULL;
>      return 0;
>  =

>  err:
>      if (i) {
>          qemu_del_net_client(ncs[0]);
>      }
> +
> +err_svq:
>      qemu_close(vdpa_device_fd);
>  =

>      return -1;
> -- =

> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

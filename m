Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C316D4FD
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652821; cv=none; b=Gps1sRz0Mbwcsima4IWTJDp01vWdWkiX4IXflsfns/gVK8oMyZCGclx1sRNKLf5YRyqKepoR48WcYZVVHarHu1Fy9iSWlxwau7mMrLzEyb0aMI/hKsf91G3jK/vdK4fcUMI743X9cO1sbgDMhhXey3A2fuYxEZHaor7fdGUce24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652821; c=relaxed/simple;
	bh=Hb2vlo6jvMfawcIP5+hm/LNCX6XVc0VQ/rbcyfyg/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQnyDysL+4FmDuAq49J7xQ2EodBORTsKoGkobvpWPBl+hYmuHj9gAJQvfqHO0SAHiaFlQh0KXko4m776ndyHMBxDsXhzkzhlFI0RAC6IWosGQ+P7RN6tJgOhxnawzJ5OWHNEZhs26pIjQmFXIHsSKZq6/ADiqfruLboYjM+WG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGfN/Ozp; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGfN/Ozp"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5C3240177
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiD8mT7awOmj for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 12:53:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3759740176
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3759740176
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZGfN/Ozp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3759740176
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
	b=ZGfN/Ozp15oLm0er9RTwQA8+i46erzUuxg7TjMU8wqm2lPuMRKqZkW0q351TtlquswGY5u
	G6bM/UCxCGw6TpH/Gf/RnB1l8prmEWLoN2UCHysy4OboVj2QE/IPdCZ5p4psq6qTPK/E4g
	IKDtYJGc4X0vlmjzTRhBzzr0jxp9FUU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hCEI6DkIPmC3kbHDmA01Wg-1; Mon, 22 Jul 2024 08:53:35 -0400
X-MC-Unique: hCEI6DkIPmC3kbHDmA01Wg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efce218feso1911161e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 05:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652810; x=1722257610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eU/D7g+qP7HfNmpAQB1UFGkewZKa63OdmYLP+myK2LI=;
        b=ulqVn4uTXGvJqozETIzleTXOWA9zLiwHcRWC4NGJ4s9J3R5P2OwC2vrN2r4gBs8Y9U
         yPiC+5a2I4OiSgfkmJeQvaLA43dSPwldKmLFG3T0aVEEC3Y6oIf7DhiKRZAd1AYSiFS5
         1pma8BQfIbIkZ9TFoQ5JPgJuTCRC805DVlR8mcXW7JR2BFz0DHhSHylsKdMua12ck6gm
         iQhHnL1xPFkMJXxeCqcfu5xjr0LmopEkm9H52hFYnwB/I1H1NcbvvBUCbtK3aHs1/xD3
         +Yu/Pp8LD7OSXp6MWY0Q7448QjWBVwQ7ucBjREiX5dqUAEkIEjKHJZHU1yB5FnqJe0A6
         lscw==
X-Forwarded-Encrypted: i=1; AJvYcCWy9r48pBOvVWRcuiv/wplJTQbczHCijXzkPZ/ayxJCWIk4Mtp1elfwDFr1FSBXlPNiepHmZi2MO4nwdilCt8ksOM1TmEq4o9t8caQ3OsQz9A8rmbwezIoWAQ==
X-Gm-Message-State: AOJu0YwjkCg2vkYKd9cppOEzstwUxj3uQGIwNtpTjOMPzwl2r1ZvWWKp
	IhmAL5m4ma42MkcDdizni0h7iiDEJUizOTNoFo4BnTF6902umYJwXAooGJGflhouVlY3xRdEXOt
	QnKBVzNHiaqgkvUzs/dJZX/eaNEtOOk0zGOw/NvMGzjYFQmfi167490yY/eCPjZa5aNnHkw+1st
	fRRduJ7yat19eRDnk2co5vX0DM45JJSQ+nL9W1yn7BWc/Ap3jgzkwxjQ==
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id 2adb3069b0e04-52efb7c81e5mr4946306e87.45.1721652810672;
        Mon, 22 Jul 2024 05:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1mNcBQlFjEipVBmIhBwOyNuYK7PE8pk7ocN9FHW1CRN8mmKIK/bPZP3oGT+TMvN+d/t1tuhOEjNRdYMGH2b0=
X-Received: by 2002:a05:6512:b93:b0:52c:da18:618c with SMTP id
 2adb3069b0e04-52efb7c81e5mr4946290e87.45.1721652810311; Mon, 22 Jul 2024
 05:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
In-Reply-To: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:52:51 +0800
Message-ID: <CACLfguV27KGZE9z5OKuse44tpsF2u8DALhGNxu+g8==qV50CYQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 15:49, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ecfc16151d61..415b527a9c72 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >         destroy_workqueue(wq);
> >         mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                             struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *add_con=
fig)
> > +{
> > +       struct mlx5_vdpa_dev *mvdev;
> > +       struct mlx5_vdpa_net *ndev;
> > +       struct mlx5_core_dev *mdev;
> > +       struct virtio_net_config *config;
> > +       struct mlx5_core_dev *pfmdev;
> > +       int err =3D -EOPNOTSUPP;
> > +
> > +       mvdev =3D to_mvdev(dev);
> > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +       mdev =3D mvdev->mdev;
> > +       config =3D &ndev->config;
> > +
> > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +               if (!err)
> > +                       memcpy(config->mac, add_config->net.mac, ETH_AL=
EN);
> > +       }
> > +       return err;
>
> Similar to net simulator, how could be serialize the modification to
> mac address:
>
> 1) from vdpa tool
> 2) via control virtqueue
>
> Thanks
>
sure. Wiil do
thanks
cindy
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >         .dev_add =3D mlx5_vdpa_dev_add,
> >         .dev_del =3D mlx5_vdpa_dev_del,
> > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


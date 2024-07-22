Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2016CD07
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652966; cv=none; b=tNKWh6TV0whvoVZ+H3v+6VKAufgdrbHfcqGQ73/Km1YAC84xidg6rPDc5E566dTeDRMBABzC7x2De36kKrwcVFhV/7oAD9ssq+EOo3564BKazTBsvHrqxx6Tpz+ggEWwxgLzP5VDNqEN6Q8Xyu91LoGqmtUgNFDgYdhQrjs8r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652966; c=relaxed/simple;
	bh=JZLYf0wsystlScoz0eEY4VxzQQcKUBE/9MHVicMM8II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYkjILMoop9chEkSw7QsoaES63H/ToJEw+FoKdW+AzRkDXnmKRRV0THMU6Gf3DCaZWODkwaweM6g4Zr+VwlPeNqZK6r2Q/yZm7ZpjTEdt/WODfMfemYJZFnte1QQD1lSLPl2iDivaFwpCwomveQGzbVND2qLfAh68YwAC+gcIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/V1nAuE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/V1nAuE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC222605DE
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:56:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zPlOdc60M1qx for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 12:56:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2317A605A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2317A605A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/V1nAuE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2317A605A9
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721652962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
	b=N/V1nAuEDFpTTVmp4L4pfx5WRBx35ziS0OoDbyxLaLoZTv3UnAsnYnTVwoFZisOPyh/ARM
	/Sc3I1dpiqH1x+DDn0tCjZ5D3de8p3jUTLq68rDBBRx5m9wyNtN+j3/f1Jg9hWo5GguBgR
	Ezix3D7yLACrcFXFqpP0cbypMzxql/w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-yUeC10yfPECKmWmE3P26lg-1; Mon, 22 Jul 2024 08:56:00 -0400
X-MC-Unique: yUeC10yfPECKmWmE3P26lg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a2c84a3bbaso3389147a12.3
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 05:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652959; x=1722257759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJVNq97qnVdAr/18tmluAm4AREjAa0bHQTkX1v3BnY0=;
        b=uOeBDS5CkLLeeNtGE2P+r54hSp/4NQkXA9l5g5T76wy+JlLJNlGu4slbmJ6x7PCxNH
         3F2ASe9dxsyNBGolu/yHv2uXwH0z/Y17fS1fgpjPXzzLva5TVBb0qDIE/ohCngSKEGuW
         3FTKXrc64AAMtWdl63tRpcjB+1g0KMYp7MP5DgatWoiMF6Q/i+iNWjkptTSZh6ZIlPG0
         KviY2mJtyQeBZSeQ/iKK4ppwvuZfKeOi2PAB4348kdBhKPkMJizfnGql65MlfErmQpnl
         yU3SJKnhVI+lyYtBOiIUP9ZUlmVVuJFrn47LjkLh4kllDm5whJo7F1m0xry8pE2Ck1Gc
         AUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3CLrhYVYxDWthhjisaTJrDSTTtPO+QyMw9oCU8n84UnxFgdUjewDM4jNTiM0AVuAJOCiTCUoLRAFVvNHJlg9dccx/Jq4HDpl0jh/FigXyYFY4O9JZWxQTA==
X-Gm-Message-State: AOJu0Yx/LQMVjtyM9U3uUf2rXokjLF9PYKSXXAiH7FVtNqWpSASfiGDc
	nsJyYW7Y0h/cmY3qbuC/sHEb5Tcthj7aKlSKn99H7jVIlhS7qqUn6dO5lT1+txRMeQFwsmGrAqr
	//frdZ4vRm+Voes+1ZSwK/qGy48ZgpMleUhqNBNBdPNoi0JhxTq1uBWEkxgJNp5FigVnfHBrv23
	Vsm1hVnqq3cNNrw/o8qHA1jw3tZ7n/TAg0rCkIO6vizxAppnBlWM23Cw==
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id 4fb4d7f45d1cf-5a47b5c0b38mr4441762a12.35.1721652959415;
        Mon, 22 Jul 2024 05:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoczppy1uFSf8Ce5bOr4QQLzSZiqqNznaHB9kc0dNoTPng5nEUdTnupdY6jWQpNPwWvx5HiWx06BR6DpqS8NE=
X-Received: by 2002:a05:6402:2710:b0:5a2:69f9:1fe7 with SMTP id
 4fb4d7f45d1cf-5a47b5c0b38mr4441749a12.35.1721652959078; Mon, 22 Jul 2024
 05:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
 <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com> <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
In-Reply-To: <7a4d99e0f16cbe91000c3c780334a4c866904182.camel@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 22 Jul 2024 20:55:22 +0800
Message-ID: <CACLfguUR_hdJGDcjnmYY=qOXFiSnsBsXD5evTDZQi=K0RM4gZQ@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 17:45, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> On Mon, 2024-07-22 at 15:48 +0800, Jason Wang wrote:
> > On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Add the function to support setting the MAC address.
> > > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > > to set the mac address
> > >
> > > Tested in ConnectX-6 Dx device
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index ecfc16151d61..415b527a9c72 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgm=
t_dev *v_mdev, struct vdpa_device *
> > >         destroy_workqueue(wq);
> > >         mgtdev->ndev =3D NULL;
> > >  }
> > > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > > +                             struct vdpa_device *dev,
> > > +                             const struct vdpa_dev_set_config *add_c=
onfig)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev;
> > > +       struct mlx5_vdpa_net *ndev;
> > > +       struct mlx5_core_dev *mdev;
> > > +       struct virtio_net_config *config;
> > > +       struct mlx5_core_dev *pfmdev;
> Reverse xmas tree?
>
will fix this
> > > +       int err =3D -EOPNOTSUPP;
> > > +
> > > +       mvdev =3D to_mvdev(dev);
> > > +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > > +       mdev =3D mvdev->mdev;
> > > +       config =3D &ndev->config;
> > > +
> You still need to take the ndev->reslock.
>
sure, will do
> > > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) =
{
> > > +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > > +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > > +               if (!err)
> > > +                       memcpy(config->mac, add_config->net.mac, ETH_=
ALEN);
> What is the expected behaviour when the device is in use?
>
if the err is 0 then copy the Mac address to config
will change this code to make it more clear
Thanks
Cindy
> > > +       }
> > > +       return err;
> >
> > Similar to net simulator, how could be serialize the modification to
> > mac address:
> >
> > 1) from vdpa tool
> > 2) via control virtqueue
> >
> > Thanks
> >
> > > +}
> > >
> > >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> > >         .dev_add =3D mlx5_vdpa_dev_add,
> > >         .dev_del =3D mlx5_vdpa_dev_del,
> > > +       .dev_set_attr =3D mlx5_vdpa_set_attr,
> > >  };
> > >
> > >  static struct virtio_device_id id_table[] =3D {
> > > --
> > > 2.45.0
> > >
> >
> Thanks,
> Dragos


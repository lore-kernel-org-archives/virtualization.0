Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C5224F6
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423154; cv=none; b=Ca1ikpNtm9D5tdnRxGbu1rISyA0JlWoWiLFanrZFcNc6X9GAlJdxd2jrYwKD9MCkOOKsyOlvn5dxNxEVB2Mjo0QOtfoRrKnow+rTUBHTv3hRSzXeUY78y1xWyvL/2UJsJqbdfGNAa4+2wL+T+KKy0bXl8Z9LehbJa5f5TK75yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423154; c=relaxed/simple;
	bh=BCpNb63WRewgJB37gIEoqo5egyIJUDlpbkKJgwO8OHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtrqbRAR5vgjhlRCGgNXTWfaoZVoefjjDWlUpiNL4SygqBOS/66bZeA7rWZYUIeEuiIK4P2LLyg+xDoYLHud/eTyiunoKpFLn1c289YaWOGcha78R+chjuBIKB6X56hgUI36RCuL+cdtMIOdgtXL8nY/V9u26NzoxCg9Dfg3jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRilljeW; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRilljeW"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5363F80B9F
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNi02MRjG33o for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 07:19:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8A95680B08
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A95680B08
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MRilljeW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A95680B08
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720423151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
	b=MRilljeWXPZxeqBhAcYW+XPuVMcvo9jjJ/nufLr8Vc/WmxGsPpEfEVfB5tvyM4CK6grd9q
	BNgmLxSqPxZBpEVFZu7XkBja50dz/2L9VBmlNM+lWDx+uooH9CDblGQBleLGzJwnV/Y3tZ
	CK6g48/14a6OXv0Li8GtkpPz/z1GEvc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-_aoXS2n2PLqJGiMrr36KyQ-1; Mon, 08 Jul 2024 03:19:09 -0400
X-MC-Unique: _aoXS2n2PLqJGiMrr36KyQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77d98ed6ebso171873566b.3
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Jul 2024 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720423148; x=1721027948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqM73JSLXU66f0uRVT9WU+gkf5AyrsxUM3dUDMhxBT4=;
        b=aiBpYybL2K9YyHjY+vdkfYpxdUXzfQ2EQ4neFyHfGKkEOmabqK630/tDsJblbN3Wzr
         JBlWNW58QEjeYjLqCyBr6QXVlzdbvgcqH5hecuGJ0VTVnu8TYF1/WCRGAw7ay7qv0KmP
         TjbNBKeU089cOfxOtkhVWGQd+njtJwEWS70Hdfz3Z3eqAKoUnCmp7hcXuB2g051hJ4pi
         NwdFPh2CxDFPLKJUWQZgpkjgQm2dO0pl9S06VZp3YBJXemeBWb2iGz8d9yg2ZmpHGCdT
         Uo40dqPMsLb9Xqsb3VoG+ZcjWvweGp8UNF8nPZKkU+9u2MqLaT895it3t7jau9Tg/YHs
         Z4zw==
X-Forwarded-Encrypted: i=1; AJvYcCVfVIStFTlhtO6hNH5IqXjfmhRQheQgAGyAXJiEV8kGFfKwIf0OUTCFTPUj4guEZag3+ocCaZXCpdiH6G6N9IQF/BaMoSB4A7Gdek7ij+hcUpWvo4ynk/3H6g==
X-Gm-Message-State: AOJu0Yy6uAT8ylhFjQTRBFLpPWrl1wPXnT408SW+KtexD8fukh/eY925
	FiheuY7jqviUpx+buRrf2/0yTJn0bV3gyLg5iOXpI8AjYuuH71srjFIffikAVmn4xXBB58JxZAk
	zVUUs18lFNatQCUcH5t0XWjUepzsbH6IittXynZadHxZYK4ebk76DUvn3pTmil+eD86SW/x83LW
	XaL+SmPKPp0/h1xmsbTTxG4xV34410Pmo7BR1VSBP1deM7gb0MOeZePg==
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id a640c23a62f3a-a77b9dee79dmr706515066b.0.1720423148321;
        Mon, 08 Jul 2024 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGUu1W6MyDpHHXhXDXEq+4hte1tFdv4eIOo7asqiTd/PZmPPhD5t+yUjE3Q9R2KpY/v0HSjx6vJ4Xu91Rb1yY=
X-Received: by 2002:a17:906:175b:b0:a77:a630:cf89 with SMTP id
 a640c23a62f3a-a77b9dee79dmr706512466b.0.1720423147970; Mon, 08 Jul 2024
 00:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
 <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
In-Reply-To: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jul 2024 15:18:31 +0800
Message-ID: <CACLfguXdL_FvdvReQrzvKvzJrHnE9gcTv+rLYsCNB0HtvXC74w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:06, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa_sim_net, the driver will write the MAC address
> > to the config space, and other devices can implement
> > their own functions to support this.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_net.c
> > index cfe962911804..a472c3c43bfd 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim =
*vdpasim, void *config)
> >         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_L=
INK_UP);
> >  }
> >
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *confi=
g)
> > +{
> > +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, v=
dpa);
> > +
> > +       struct virtio_net_config *vio_config =3D vdpasim->config;
> > +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               if (!is_zero_ether_addr(config->net.mac)) {
> > +                       memcpy(vio_config->mac, config->net.mac, ETH_AL=
EN);
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
>
> I think in the previous version, we agreed to have a lock to
> synchronize the writing here?
>
> Thanks
>
Hi Jason
I have moved the down_write(&vdev->cf_lock) and
up_write(&vdev->cf_lock) to the function vdpa_dev_net_device_attr_set
in vdpa/vdpa.c. Then the device itself doesn't need to call it again.
Do you think this is ok?
Thanks
Cindy
> > +}
> > +
> >  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
> >                                      const struct vdpa_dev_set_config *=
config)
> >  {
> > @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_de=
v *mdev,
> >
> >  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
> >         .dev_add =3D vdpasim_net_dev_add,
> > -       .dev_del =3D vdpasim_net_dev_del
> > +       .dev_del =3D vdpasim_net_dev_del,
> > +       .dev_set_attr =3D vdpasim_net_set_attr
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


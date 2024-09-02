Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E83B182
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725251287; cv=none; b=jTIvix7iID06UyOi/IvUGDTBqppoJqjstF1itfbXlyQ6l+c1Zv1MeZbnMV1Ot2oBwfXITrdrEuhri1rSXTqeLHHrs905z+QdEQsf0Ps4KANwIoyKXBRqJuom7UElPyESQ7Y6GtlHWFrcCsXwd0etdiAiB2Bc5nJY2JJAMtRNaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725251287; c=relaxed/simple;
	bh=imrdOP267f9TBBXh8m6wg6kbuBgsSfpHQtnHTBSQ4r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rc81Ry5bXFmoTphS64F5Q88Yu25AkRxmeV/qFSQHVe4Gb4aVODF8pIAMHYRnhS9LWkM4HtzSInEK0f4+L8aypEvzbLZqmGHKdM77JHJgthF4pMDoKTaByTb4QPkZEHmJMNnogRfGAGYhbXYNEA5llWNHwwQfamLWyZS75ylOA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcgqsWm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcgqsWm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725251284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/Gj4eDafKoQrJYXOLZ6AuCMbE6RyJc4zifVlDVrlgU=;
	b=XcgqsWm6qWeumgCqsUrLhkyzWE8ePGadig5sggh99aau4LmCHNE/Q4YQyR3lIrq0bhdYs3
	8yYOrQSW+0ISLydpUYIEcy50lA7r/wVkQwLjR6zomkXSkX9yHS5MSSt0zo6UEeflpgBGvF
	BVtFcs4MJtg+0tSa9m6Ijuj8QTwn35A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-YRfuNGI9NFer4S7mnBxB6g-1; Mon, 02 Sep 2024 00:28:03 -0400
X-MC-Unique: YRfuNGI9NFer4S7mnBxB6g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d889fde2aaso2451847a91.0
        for <virtualization@lists.linux.dev>; Sun, 01 Sep 2024 21:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725251282; x=1725856082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Gj4eDafKoQrJYXOLZ6AuCMbE6RyJc4zifVlDVrlgU=;
        b=ed1GT8jyIrglUl1B9oBh922aI8bRhHDbmieymqOvcwRsTAGEo3OJSyOAahGHwnxPZ4
         +lvXcYQ1BJJBR05uOszOdpTwCcof0LZN0XFYEDvVYN5UiyyIvEKBz7SHjWw/52wW2AQm
         WnHIc6PxQqv/6rDFeHz4Bh4wRd4jGhvITJzomVWEqAgJPIubfpZ+hywVybksHNJqFJWd
         g/u6ODd2w3QCJ/sCXx2QlfVbHMVKFlZY8Vo7kfliDi4HoWUIfC0yu38M1JXMiSrmXTK6
         5ECge7f44n7q0M4jBDK46IWpfyr4ekbXJu55w0xEd3phdLvn+5wL/JkqxKw9IkRgp4RL
         Cjxg==
X-Forwarded-Encrypted: i=1; AJvYcCWOp6aNe4f7H2k6zq3BrZVmvFSeILF8BpVIlKlYWaX7DKt+ZXd1ny1xu07C7PWc1jVWXT3QnB2t1TZDE9Zxig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaIpnQQKCPt4jb95GmAx2gSohuLuooxGKPtsqLDjLw4Y/GgnWd
	9TAiTcouXp9S58yQWLHwnpE//uNC7UASlfx6ecymNhclx66XkFaQp0ZrAhx29tcknUUHAqlt7Ov
	Tw/YrroSzR5ibEg9QRdfHhKaq8Ya42GBY9HPAT3+rYedsnSAFeV6VYNBI7GWTPAOiokAR5MfrTL
	Mfesj9ZAONtr/SgFSA/e/30oUX/Ic2bYCbfpiOcIk=
X-Received: by 2002:a17:90b:2bc6:b0:2d8:99c4:3cd9 with SMTP id 98e67ed59e1d1-2d899c43e12mr6950233a91.3.1725251281966;
        Sun, 01 Sep 2024 21:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ70KQouOrad1n8w655Ru1U5qCbR6u/l5jxaDuXmg5lnMyHLK/m9F3iqPdkC3VCTOyETBUITjc0W1iTC600q4=
X-Received: by 2002:a17:90b:2bc6:b0:2d8:99c4:3cd9 with SMTP id
 98e67ed59e1d1-2d899c43e12mr6950211a91.3.1725251281369; Sun, 01 Sep 2024
 21:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com> <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
 <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com> <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
In-Reply-To: <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Sep 2024 12:27:50 +0800
Message-ID: <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in vDPA/mlx5_vnet
To: Carlos Bilbao <cbilbao@digitalocean.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, 
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:15=E2=80=AFPM Carlos Bilbao <cbilbao@digitalocean=
.com> wrote:
>
> Hello,
>
> On 8/29/24 9:31 PM, Jason Wang wrote:
> > On Fri, Aug 30, 2024 at 5:08=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >> (resending as I accidentally replied only to Carlos)
> >>
> >> On 29.08.24 18:16, Carlos Bilbao wrote:
> >>> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>
> >>> Include support to update the vDPA configuration fields of speed and
> >>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
> >>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initi=
al
> >>> values to UNKNOWN. Also add a warning message for when
> >>> mlx5_vdpa_get_config() receives offset and length out of bounds.
> >>>
> >>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >>> ---
> >>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 +++++++++++++++++++++++++++++=
+-
> >>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
> >>>  include/uapi/linux/vdpa.h         |  2 ++
> >>>  3 files changed, 62 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> >>> index c47009a8b472..a44bb2072eec 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_=
device *vdev, unsigned int offset,
> >>>
> >>>       if (offset + len <=3D sizeof(struct virtio_net_config))
> >>>               memcpy(buf, (u8 *)&ndev->config + offset, len);
> >>> +     else
> >>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\=
n");
> >>>  }
> >>>
> >>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned =
int offset, const void *buf,
> >>>                                unsigned int len)
> >>>  {
> >>> -     /* not supported */
> >>> +     struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> >>> +     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >>> +
> >>> +     if (offset + len > sizeof(struct virtio_net_config)) {
> >>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\=
n");
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Note that this will update the speed/duplex configuration fi=
elds
> >>> +      * but the hardware support to actually perform this change doe=
s
> >>> +      * not exist yet.
> >>> +      */
> >>> +     switch (offset) {
> >>> +     case offsetof(struct virtio_net_config, speed):
> >>> +             if (len =3D=3D sizeof(((struct virtio_net_config *) 0)-=
>speed))
> >>> +                     memcpy(&ndev->config.speed, buf, len);
> >>> +             else
> >>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed=
.\n");
> >>> +             break;
> >>> +
> >>> +     case offsetof(struct virtio_net_config, duplex):
> >>> +             if (len =3D=3D sizeof(((struct virtio_net_config *)0)->=
duplex))
> >>> +                     memcpy(&ndev->config.duplex, buf, len);
> >>> +             else
> >>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for duple=
x.\n");
> >>> +             break;
> >>> +
> >>> +     default:
> >>> +             mlx5_vdpa_warn(mvdev, "Configuration field not supporte=
d.\n");
> >> This will trigger noise in dmesg because there is a MAC configuration =
here.
> >>> +     }
> >> I would prefer that the .set_config remains a stub TBH. Setting the fi=
elds here is
> >> misleading: the user might deduce that the configuration worked when t=
hey read the
> >> values and see that they were updated.
> > Yes, and actually, those fields are read-only according to the spec:
> >
> > """
> > The network device has the following device configuration layout. All
> > of the device configuration fields are read-only for the driver.
> > """
> >
> > Thanks
>
>
> Should I go ahead and remove the ioctl then?

If you meant mlx5_vdpa_set_config, I think yes.

Thanks


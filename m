Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8D3D6D
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023775; cv=none; b=fJcyC6qQO6sr79ZIyS87FA2i0S8sypFFqnvr8zsyELBPnyapbx+UWswwYK/9T6F7tQovc226ulwCU7SJQOUTwZCwu8O50DEcwuxcDd/doeIUjaaPVxmygoWJ3l51EEBFQBTqRRFC/95y4obErleSFW+oKAwUGnutGQt1yHf2mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023775; c=relaxed/simple;
	bh=2nEzZSAQ7DgTxNnpoAkF41UlvGJIEodVbLx5+3jIdYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf6RIadTgEtYVkzL0ZoIcgS2ufY/wMixQudsPIT6mDJ6ra/Xfe5tLsfnGKFtvkOkXYTEsz+rv1qkVkazMX9yzz/QwBMz2Gc13olMJj/c6y+jgNO+2EJDQaXPwuObLt8SJM5yN0C3IVsE6OgeluNOZSEqh6oqXKb5KJWL9FutHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXSpV496; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXSpV496"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9719741EA1
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1nUQPzEy7BMa
	for <virtualization@lists.linux-foundation.org>;
	Thu, 15 Feb 2024 19:02:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B1F9741E9C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1F9741E9C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXSpV496
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1F9741E9C
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708023771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WZK5fZgBb2Kx+FtMjwkiQLfYWqfk94jgXZVqI27ygA=;
	b=IXSpV496qRhwibBpfmrY0GaaGzLEn+t2kyXZlMIPj27dqPKbDt8OCIXOJj0ST20Y/Zjeya
	n8VQZWGZ9TOisGTmA/6pfzeQidD1kK5K/9NwnhFMY3OJb90ALqmq5xRytRRhVcT3nrs6Xq
	mHCsKGPP3hZKB3JQskEpINJiEfGDBmw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-sHlzuqeuMMO4mymx6_9l1g-1; Thu, 15 Feb 2024 14:02:49 -0500
X-MC-Unique: sHlzuqeuMMO4mymx6_9l1g-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-598b4d37248so1153842eaf.1
        for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 11:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023768; x=1708628568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WZK5fZgBb2Kx+FtMjwkiQLfYWqfk94jgXZVqI27ygA=;
        b=LXTzjcxVsWfks1IsJzj+fuV+yUWD52XZHXwNnr12v5cPGRX/fON1UFEYbXgK+k8IHm
         g11Dp3vR7ETZO+ZK1kZsXDpe86olTi12GgarFO+PfY98h0Xe2s7q6LYe683rFXlZ5hcd
         v4H7hRVoO2rgVNIDX+ErI/V9EjNCHjaZpoHSeU+zP24PqPARI8tLVHbqN4+iZWgl634C
         tSG3ADCk5HbzHEfqyZvIeDGqUAvHZjUXD3jnmhNFGFIXIEWM2kIdKPU0Np7EVAwD1/LA
         I9A7BLMEZhr1w74qdLCpIrnP8Cjj1Xr2IX20wdTfEtVU6Lx6T6ULTsr1r76eY5DEnVcL
         oe0w==
X-Forwarded-Encrypted: i=1; AJvYcCXzzsV2YX7XadD3DY5MAm0s8G7zZ9Or49FXjz2fHbNmKZYHhRQ26cK8eFsVmgOpjCaXBU/yx+DFk31HY7aq6r1KonIYprc636OAL4ih/mopN8o+pgGD530NSQ==
X-Gm-Message-State: AOJu0YxQYchB/OsuPt6Mny3iCJqtAslK4xwpMbsevOfVWkTf2EKBnG9V
	co0x7Cdr9Hm1fIwZ2x9joroyEtuEmpeorqbi/LVVL65FN3gbTyHjJe4wvykU0+QlvSFLY7W3hHn
	ez5Q2WbGV407IyAjzjrwNE6MJWkfRivsF7jri97uXS0e7GsmT+jUFOd7AbbCF9H/oRUE79F8EiQ
	R14TPPgNWiJEivnQHTl30abk7dWdDvSnyL4OlkQQb4dy7tEU1w1gu8jA==
X-Received: by 2002:a05:6358:6181:b0:17b:799:6417 with SMTP id w1-20020a056358618100b0017b07996417mr2798175rww.8.1708023767998;
        Thu, 15 Feb 2024 11:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFYS1tUyR1XCikG8c3MvFErVyx0H0IO6cz5Z0cAxudOZeP6NvOMCvgaH3Il6vu1CaLcG7xXXVfuiMcvfgNcpg=
X-Received: by 2002:a05:6358:6181:b0:17b:799:6417 with SMTP id
 w1-20020a056358618100b0017b07996417mr2798143rww.8.1708023767668; Thu, 15 Feb
 2024 11:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240215170507.3865986-1-jonah.palmer@oracle.com> <CAJaqyWfRYj5+BCV5KRmj1xRUtaFg5ixU9SPciqyMRLfJ7ztu2g@mail.gmail.com>
In-Reply-To: <CAJaqyWfRYj5+BCV5KRmj1xRUtaFg5ixU9SPciqyMRLfJ7ztu2g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 20:02:11 +0100
Message-ID: <CAJaqyWcJyzjHB54oPOzjqHwc0JnFWj-wMd+3w0FHBNswDJ3Mpg@mail.gmail.com>
Subject: Re: vdpa/mlx5: Allow CVQ size changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org, 
	dtatulea@nvidia.com, boris.ostrovsky@oracle.com, leiyang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:55=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Feb 15, 2024 at 6:05=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle=
.com> wrote:
> >
> > The MLX driver was not updating its control virtqueue size at set_vq_nu=
m
> > and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> > setup_cvq_vring.
> >
> > Qemu would try to set the size to 64 by default, however, because the
> > CVQ size always was initialized to 16, an error would be thrown when
> > sending >16 control messages (as used-ring entry 17 is initialized to 0=
).
> > For example, starting a guest with x-svq=3Don and then executing the
> > following command would produce the error below:
> >
> >  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
> >
> >  qemu-system-x86_64: Insufficient written data (0)
> >  [  435.331223] virtio_net virtio0: Failed to set mac address by vq com=
mand.
> >  SIOCSIFHWADDR: Invalid argument
> >
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 778821bab7d9..c74de1fe6a94 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2276,9 +2276,15 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_dev=
ice *vdev, u16 idx, u32 num)
> >         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >         struct mlx5_vdpa_virtqueue *mvq;
> >
> > -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> > +       if (!is_index_valid(mvdev, idx))
> >                 return;
> >
> > +        if (is_ctrl_vq_idx(mvdev, idx)) {
> > +                struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> > +                cvq->vring.vring.num =3D num;
> > +                return;
> > +        }
> > +
> >         mvq =3D &ndev->vqs[idx];
> >         mvq->num_ent =3D num;
> >  }
> > @@ -2963,7 +2969,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *=
mvdev)
> >                 u16 idx =3D cvq->vring.last_avail_idx;
> >
> >                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_fe=
atures,
> > -                                       MLX5_CVQ_MAX_ENT, false,

Actually there is one nitpick: MLX5_CVQ_MAX_ENT macro should be
deleted as there are no more usages :). With that change and Dragos'
request you can post a V2 with my Acked-by included.

Thanks!

> > +                                       cvq->vring.vring.num, false,
> >                                         (struct vring_desc *)(uintptr_t=
)cvq->desc_addr,
> >                                         (struct vring_avail *)(uintptr_=
t)cvq->driver_addr,
> >                                         (struct vring_used *)(uintptr_t=
)cvq->device_addr);
> > --
> > 2.39.3
> >


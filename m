Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F43198A02
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871982; cv=none; b=FK2mp/uxdZBX2ggt3ZPHFi6NOwz/h/TjlxdjnTGg8mYQXmjsL6VPzVfO/aU2GxG4wTQo4AJIL4XJhbWD8TKO5jaYcmvCPnX4QXVpo5QxgSzdt02Nl15Ot+wUo84VG/gLeuG1MMzOs3elhJsAr5tyx6qMxLdTKoINWAxDiobFM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871982; c=relaxed/simple;
	bh=CeoY8GPU0CCJrKlp1JJ4nDa6LGodwgXL/Hni5GpJoFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMdTmPHmX8GDP2V3HPyCnQD0NmtrngPUM4l7hjvv0CAm1AzH0WCnjbJWztlbVvqoi53dfWJ+s4bxLUMIDXvWBwAvktiPBWth8fv9mWzJwW8z+utRj2150Lz/uyPwxeQ4IW7cRpj/uJR5Egtb3PmolLl8MqV/ixSCXVUQUkMNK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kb69K0be; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kb69K0be"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpzpDxpgiAo4iZSiruXBIQBzuL0A4exTkq3QGIhWnyE=;
	b=Kb69K0bez68oovMLTc0TnA3YbV96QU0cO/TbVOeXkQzobA4tvBtkor57xAT0ZGDzAcApIz
	12Y14MqAhTRiz7YdtR1FXlOCzoODBuSAzIFiJ8YID+Bc8glx1RJUPUHBrpAMdqctYSYTsy
	Tna/J5IDlE8rAMhEMlTiji/4SIIIVBM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-HdmREIF5NgG5M1DoBGMYzA-1; Thu, 20 Jun 2024 04:26:18 -0400
X-MC-Unique: HdmREIF5NgG5M1DoBGMYzA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so743722a12.3
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871977; x=1719476777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpzpDxpgiAo4iZSiruXBIQBzuL0A4exTkq3QGIhWnyE=;
        b=KKCOdMD0NQXDQ8pbulkzyedRv1VHBjYZISnybNN+0iTMn52WRtRws/gKJynpEtTETy
         EL0bV/hBYaX5n+FNtjgQ7WCJ99LrgVtGsc+B7M8M7Jtq2JB54p0zJK9ibnYEgoTe6zfE
         suyj9gOXRz6ZkIX5QomnERj1JJ6LJGVfuhdjOb3jTRP88No2DoUbNXHsxMsBDeq76VOH
         Vdj0fU9x773AAq8G3LFyhQV34HDvg7dbic5/4HzC35qkgIjVG+tkdNs3cMPUrof80Bkd
         fMPkBKzAXxPXpU4v+mR/D86jUQbt8X0dbTwVEPVO6d+CAZenE0CeCor24IA6CSXfHXi0
         dAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlZcZzsFYaoOwLvwV05B9DO7EVSX2fj9PG7C01u2tDp0/lw9SrKqa3J8F66gS/CMzXpOmFxnnUV8u4JrH+QhfHLCMhzpI0AeowqB3BqbA=
X-Gm-Message-State: AOJu0Yx5v3r1ZIO+mQDLP4gAwhHKh1G3zBcNxsSFaOBNDsS4kwf8V+Oh
	3FbwaS0Y6j6etAkPKHM7un7IqUmYPBWMfmc6qjNGxvC1pqMp9JafPvKs18Yn0d26nb2HZYstzBP
	hSrDo6+ceW3itlFN09mxyFA/yfO06pfprl82B/5F1F+9vZ09yEeeQUjYcKGj13BlAE+ZGwxIsym
	qPvz0TIsh7qiKS3ENq44rRmWFubbqo0fdIZOZJHx0=
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bcbb45f3f7mr4760814637.29.1718871977252;
        Thu, 20 Jun 2024 01:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFesgf2aOIIcjAdv+mgbBHRoXQiVhOGizbrkTGeNaR0y3u/NJMc59SVcxYrznSlm4TyhjCB/ToyJxV2qoZvSMw=
X-Received: by 2002:a05:6a20:30d4:b0:1b8:9d79:7839 with SMTP id
 adf61e73a8af0-1bcbb45f3f7mr4760798637.29.1718871976850; Thu, 20 Jun 2024
 01:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
In-Reply-To: <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:26:05 +0800
Message-ID: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_in=
fo *vi)
> > > >
> > > >     /* Parameters for control virtqueue, if any */
> > > >     if (vi->has_cvq) {
> > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > >             names[total_vqs - 1] =3D "control";
> > > >     }
> > > >
> > >
> > > If the # of MSIX vectors is exactly for data path VQs,
> > > this will cause irq sharing between VQs which will degrade
> > > performance significantly.
> > >
>
> Why do we need to care about buggy management? I think libvirt has
> been teached to use 2N+2 since the introduction of the multiqueue[1].

And Qemu can calculate it correctly automatically since:

commit 51a81a2118df0c70988f00d61647da9e298483a4
Author: Jason Wang <jasowang@redhat.com>
Date:   Mon Mar 8 12:49:19 2021 +0800

    virtio-net: calculating proper msix vectors on init

    Currently, the default msix vectors for virtio-net-pci is 3 which is
    obvious not suitable for multiqueue guest, so we depends on the user
    or management tools to pass a correct vectors parameter. In fact, we
    can simplifying this by calculating the number of vectors on realize.

    Consider we have N queues, the number of vectors needed is 2*N + 2
    (#queue pairs + plus one config interrupt and control vq). We didn't
    check whether or not host support control vq because it was added
    unconditionally by qemu to avoid breaking legacy guests such as Minix.

    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
    Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Signed-off-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > > So no, you can not just do it unconditionally.
> > >
> > > The correct fix probably requires virtio core/API extensions.
> >
> > If the introduction of cvq irq causes interrupts to become shared, then
> > ctrlq need to fall back to polling mode and keep the status quo.
>
> Having to path sounds a burden.
>
> >
> > Thanks.
> >
>
>
> Thanks
>
> [1] https://www.linux-kvm.org/page/Multiqueue
>
> > >
> > > --
> > > MST
> > >
> >


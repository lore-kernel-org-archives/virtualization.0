Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA325776
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502032; cv=none; b=IA613qiCyyNX6ZNzlb+SopyA9nOIfTeXxE/AN0bLaBqUApBndKm09o7jqi/HQn9X0dl6JbzOxzmVZHAZjb0hqgByfpC6ABeQ1Z7H+0tclO2CofSG5sxogb0F5qFpAgxpqT631+SCdqdYkvoG6C/qlJrB7SgwLVaNrCC09FC49Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502032; c=relaxed/simple;
	bh=9Ki4boBBFSTOm6bTDAVCg7R7ZncOaE6Xsh/zpAUfEjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/a9wfITpBqnJCwWpt+aN8kN5Xrn4nh2zvnDaZC4N+IC6qAfBbCJ0O+oA+oGrLU+qmqfAyPRFw2AnEYcLIiUN3AxvcFJBh7N53si4l5SpReVEfdUvSCcxd2YNz1zSdyUkGYTiWxzxKR+P+LqTqtRXZxL2rwupCizafgRUJCUiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq7rwbjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq7rwbjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KySsdtQdiuNJp3kMt+bHY2mjpu7nVhM7jiH9jFwsa8g=;
	b=Xq7rwbjOe0Hzycoavpluvgw+lK/Sg9VPNm/gtOExFNvPvBYU9GhhfUDgwgdFIzMpS49px8
	qzs692Nkwv2tDc0hUFTI1atqBk0j+zxIq4BKyLDadrIVWlYhu0Qav7GOlzZc5ffNk+UjE+
	iiFuNbbQEa3zaDrE5Pa61Pu1eEBt3tI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-dieeNRY9MYeLhc91d0CA7w-1; Sun, 21 Sep 2025 20:47:08 -0400
X-MC-Unique: dieeNRY9MYeLhc91d0CA7w-1
X-Mimecast-MFC-AGG-ID: dieeNRY9MYeLhc91d0CA7w_1758502027
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so41796885ad.3
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502027; x=1759106827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KySsdtQdiuNJp3kMt+bHY2mjpu7nVhM7jiH9jFwsa8g=;
        b=U537wbD9Knm0SN2HXb/PguGteSz2BRmx8DkekFBrOj0pcCRRT7Bp8LAuhCm3C5teup
         1OfpDQWFqGaxcFguYZLR14rIGwaI7vwnL2Cu5Sdme99nLb00wBpzRQTV+CRmwn1Y9Smp
         +h03Kbn2Z+y7UiHoebOfPi35fjsWKlBsEcYnv4CxADIAV76wHVpkrQ4CXYJnWeuUDkTw
         7NoktxpS3JhO2PHldLFLm22CfMeokWbEAhZlpbYk7buUuRLtVPDas5Owz323Xqtbo3f3
         yEMGTaMgfmzr4JkNnfBtw/MvyTLLttAyGjXk8HT9I/By4jW/h9JuypOIrz3fLYBC35GT
         5Yyg==
X-Forwarded-Encrypted: i=1; AJvYcCVdHcuKkvb0QsEUxn7BBbIGMsnPf+8U2tlmG4oQ0luGA1c59MBt30HIMFXex4c3XaTQgz1BG60WL/GhKHGLyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCRm4dJbwlHn8oJgSUdY/Q/6qjhz1G2sKb5TDp1K0XLEkEoWUI
	p7mvAorMHngHXNayr/y9d/Shfe8Tue5n1edVp8ARcY1Ph6r9zrwaKSzhK/C5XkoIAM3e/9G6ZTM
	HItVdvkV2cmxivYa9C9e7vlSy+lqQsp5U/rf1u6nZFsk2z5txtFA7XEorfB73PkwCjLDWgaLxu4
	pz4AyZH0b8JFBvG0XRik1v29AwAJbfnsyOhEg+5jn24fW1eCAMuwSn/A==
X-Gm-Gg: ASbGncusSzAezWfn2gIzZoRQUhiHtdi4PUv9k2DdgTialUU+3+BlQUWeDIayDO46La/
	WFVsU91tG334VR/8VS+1yyVKtzxFSqktyroD8kfdjwsqw4BY5HZM9Jn1mhZ7bPCAOJWUaBdalQ+
	M7AEXMpvaG94sbce4qaeaPPQ==
X-Received: by 2002:a17:902:e790:b0:269:b466:8d46 with SMTP id d9443c01a7336-269ba4b0d19mr142092305ad.27.1758502026775;
        Sun, 21 Sep 2025 17:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx03rywSBBNlmUq18hE46ivk2F2LHYtObQ3Pr0Au/MMmMga+vs6uREz+IlhTQ8NjggT0qss6QVDOyOA8Q6ENA=
X-Received: by 2002:a17:902:e790:b0:269:b466:8d46 with SMTP id
 d9443c01a7336-269ba4b0d19mr142092075ad.27.1758502026433; Sun, 21 Sep 2025
 17:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-16-jasowang@redhat.com>
 <20250921134159-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134159-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:46:54 +0800
X-Gm-Features: AS18NWA8g4bWALv8lBfETe3esqYxg2UugsUhThrcHNsEaChQ7W6Vcol-vylUH1c
Message-ID: <CACGkMEsFrSH=LC4AFKcxCaxXArdtJtyaCQBko_vieT1VAscRHQ@mail.gmail.com>
Subject: Re: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer detaching
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BIi3KtTAL4eb3dSNkJTYZ8ZjLH9xAaZsBrJS9eDMUKQ_1758502027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:50PM +0800, Jason Wang wrote:
> > Factor out core logic of buffer detaching and leave the id population
> > to the caller so in order can just call the core logic.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 0949675a3d12..a83d08070e8a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct =
vring_virtqueue *vq)
> >       return needs_kick;
> >  }
> >
> > -static void detach_buf_packed(struct vring_virtqueue *vq,
> > -                           unsigned int id, void **ctx)
> > +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> > +                                    unsigned int id, void **ctx)
> >  {
> >       struct vring_desc_state_packed *state =3D NULL;
> >       struct vring_packed_desc *desc;
> > @@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >       /* Clear data ptr. */
> >       state->data =3D NULL;
> >
> > -     vq->packed.desc_extra[state->last].next =3D vq->free_head;
> > -     vq->free_head =3D id;
> >       vq->vq.num_free +=3D state->num;
> >
> >       if (unlikely(vq->use_map_api)) {
> > @@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtq=
ueue *vq,
> >       }
> >  }
> >
> > +static void detach_buf_packed(struct vring_virtqueue *vq,
> > +                           unsigned int id, void **ctx)
> > +{
> > +     struct vring_desc_state_packed *state =3D &vq->packed.desc_state[=
id];
> > +
> > +     vq->packed.desc_extra[state->last].next =3D vq->free_head;
> > +     vq->free_head =3D id;
> > +
> > +     return detach_buf_packed_in_order(vq, id, ctx);
> > +}
> > +
>
> Wait what? return in a void function?
> How does this compile?

It looks like it passes the compiling since detach_buf_packed_in_order
returns void as well :(

> I'm guessing it's tweaked by a follow
> up patch?

Nope. Let me drop the return here.

Thanks

>
>
> >  static inline bool is_used_desc_packed(const struct vring_virtqueue *v=
q,
> >                                      u16 idx, bool used_wrap_counter)
> >  {
> > --
> > 2.31.1
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CD17B401
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149157; cv=none; b=cpPxWTCdk0z5+NIzdPpReoIvFk9UW+zW/kp55FC9pvoqBnZgr3cDBexuClzvxme/Psp82wuSwnTbuxAgNf9wLRzLaecVFhSSo6P4v2UEivbwM6R4Mt3LbZv6plJicy9HQ/7AyWi4Ekdx2YDupUSzZNKkdxIAxRV9T6ySYbXDerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149157; c=relaxed/simple;
	bh=nFWeksWwiHDRuocIyS5OZv5DOPyfdCfqD6Zc0mGUK2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqkzB5IDB6SLfY79aOH1g7BukWjBbEScvFPR/t3ki7BMHwnmtRc8f57nQ3ivNDz59gP3yxeS1YSjnRggzd4xr5RDYkwrkOWxqsywewZzCNiV72Ksnx17z1hAcYwLhKZzxNRA6OJ4I2cBolvpfaJTtGMs1RwFSjdvVYhEhpxi5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hECu/4C8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hECu/4C8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjVevVXOLmssCLAAJ8imF8PLNyoL6QY0RzG5Mf1zavQ=;
	b=hECu/4C83kXZ8gfGS7KtzSAquUwkIn2Tjw0iqulGeIp19TF9LdZ39pruSQrXkY9UFMfwzG
	hOMbF3kXBIdcgPv8G4TYKAtuDtBCfYof2KENYh/6id4s9jqoRHVVshTeExOKzKG5aG+mRe
	jZqau1So30eaBnHymYVNgLcVaRYync4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-kQa1y9lLPFaIFQV5BMvtxg-1; Tue, 04 Mar 2025 23:32:33 -0500
X-MC-Unique: kQa1y9lLPFaIFQV5BMvtxg-1
X-Mimecast-MFC-AGG-ID: kQa1y9lLPFaIFQV5BMvtxg_1741149153
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fede63f32dso11566330a91.1
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 20:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741149152; x=1741753952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjVevVXOLmssCLAAJ8imF8PLNyoL6QY0RzG5Mf1zavQ=;
        b=YYmPnAECGNwNu+zjDeuUXaz8UZ6w3c520pYzYlsn1la/L8PibWSo4Rn/+/jfm/H6OL
         unX4KMX5gOmBRbcunjWMWoGK0DkO9+Kft8TzSFN4JkYgLlyN94lj3DmNs3q1x80vY5fj
         e86w7ajg6Am7vAqCFr0cL76X3bw4BHPXWbFGMMlv0iEHb0GGTDw40N4aPw3MRHADNYy9
         nfvCPlbIUm3bZQ5OA9cguXF6AzA5MAbT8dRFfotk4vcsJifV4s2Af36xduFB72dnzcxh
         P6J32Eb9hZHqx5Vi2aK7MfxJFFiQDBTPzxEuYiFwEU0hBJK7+DmdNGannbX3XMvbsidg
         Cdiw==
X-Forwarded-Encrypted: i=1; AJvYcCXOx2xIEPqSbAP7xTiFVuNRBkCdiaZd9xOFT34/RseVoaGzz8im47YLrJ6wmSX1e+nG2hW03ZbPZIVelzr7yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOdFlj72wxakgNztzkU6L866mLMvc5KAA6SeWgqnNgtWmzGoda
	Gg0NDDfejo862pLRE/XxRTRQ1EYztHBhMjLy/Api9/it6KvacsE1jQqkz1rfRHVlBWhrtJOb/JY
	zacE+nNEWoL6BfO1eKirJSG9QSkIHW73g5fP/yynXB8+/0o/wX9CP4drMVlk3QAunf1vqjXUvVw
	qC9CCbGSWZdIjhOlBZxgCSeOlBM37QJU7rKG53p/8=
X-Gm-Gg: ASbGncsDDL+igErKwBcQKIZtdgIYimDSDpZaM9k/SfZldtQmdZr4mPdEujksO9s8IyL
	4TkkOWrmB+bfHkvTwN7ceslJ0Adgr5S2EYWuH5upIiq7cL7k3V77eHa9ZMQj1hNem/jhKC6JGYQ
	==
X-Received: by 2002:a17:90b:1cd0:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2ff4978e92amr2977181a91.5.1741149152683;
        Tue, 04 Mar 2025 20:32:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhHW7v4PkX/3ohSqeT1tugqPYgOYC7QtruOmWg6dZQg09TZ3e6iZmJF1+UJ3XPL9kMzJDnCsDVq/d2f1hpDUo=
X-Received: by 2002:a17:90b:1cd0:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2ff4978e92amr2977160a91.5.1741149152309; Tue, 04 Mar 2025
 20:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250224164956-mutt-send-email-mst@kernel.org>
 <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com> <20250225072222-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250225072222-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 12:32:19 +0800
X-Gm-Features: AQ5f1Jqvzx_MszP7oKSb_mOembHoEYJVKAnXmXCk5PO3hJR0roqLasWY_CV6zvM
Message-ID: <CACGkMEte+TcMk5BRrcp4h+53p1oCs7uR+6OtSZzGj33kG3WL-Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Hanna Reitz <hreitz@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c7br9wcFfU2M7up9SSYsRgbDk2hr-ftyDa_HVExP2Uo_1741149153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 01:17:02PM +0100, Eugenio Perez Martin wrote:
> > On Mon, Feb 24, 2025 at 10:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > > > A VDUSE device that implements virtiofs device works fine just by
> > > > adding the device id to the whitelist.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > >
> > > OK, but the commit log really should say why
> > > you are doing this.
> >
> > Sure I can expand on the motivation.
> >
> > Something like "Allowing VDUSE FS type allows to build filesystems
> > that run in userspace and can be presented transparently to the host
> > and the guest. After modifying userland's libfuse, this allows to
> > expose a good amount to already available userland FS through vDPA."
> >
> > I'd add using the high performance virtio protocol but I still need to
> > do more tests for this TBH.
> >
> > > And also why is it safe.
> > >
> >
> > Can you expand on the scenarios you think this is insecure? While I
> > understand it's security sensitive, you already need root to perform
> > vdpa device operations. Is FS different from net or block?
> >
> > Thanks!
>
> I did not say it was insecure, just that you need to explain the
> security considerations in the commit log.
> The issue is that when one gave access to vdpa user device previously
> it would only allow mounting blk now a filesystem.
>
> Net is different, it is gated by CAP_NET_ADMIN.
>
> When net was introduced, selinux was there initially then it
> was deferred and never surfaced.
> Maybe we should revive it so it is possible to control which
> devices can be created in a granular way.

Can we simply start from CAP_SYS_ADMIN?

Thanks

>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 7ae99691efdf..6a9a37351310 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound=
_wq;
> > > >  static u32 allowed_device_id[] =3D {
> > > >       VIRTIO_ID_BLOCK,
> > > >       VIRTIO_ID_NET,
> > > > +     VIRTIO_ID_FS,
> > > >  };
> > > >
> > > >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *=
vdpa)
> > > > --
> > > > 2.48.1
> > >
>


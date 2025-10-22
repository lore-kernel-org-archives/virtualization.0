Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039927FD49
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106780; cv=none; b=s91rb2P/2ntwquz7koIb8wZdi09/uBM9iIxIQT+QGVENLW1d/SXIjcaJcJCjad7fztTUIrEVOLem1UMVRRGmEIEszQuBTyqx6z1c1FhW/HP+dGmD+rz1+ihi1TeuRY82SMtyvIOZa/OdLDy3RwxPY9366erkhbJNWQPqFytQ7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106780; c=relaxed/simple;
	bh=EgU8rnXynIPhs/BZsA64otPdBcSY9W7JNRXfkBA9twA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3JsddlF1lQ/JYZTkSQ7IClghksRKf85iUZRFGs8LC4A0s+H9hDtyV8/Qdnbs4z4Z7anFmm66mCkawJsVDlMXPr/g5Yg85lasUYodKYO9HqhqBeL5MmFb6YwTjK8Pqhu4TGnqf60euCu5J0yZarGnTn90Azdpw+uyvbCFaRKm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY8n3skv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY8n3skv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761106777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
	b=iY8n3skv/RNBDE4iAgTokUOV7KJB2UbjcrBNvDVcJ1nYkJY6R+pi5uv2D/QbF7sKxXigsN
	RclHcA2PhUgjSycGvQbbNwVskoPu5fqdu31CCvkpb234aVJ+9c2jO6GlRbDlMJoGwFIMXc
	py4OhjvPenlJOG9VAqalRHUVO7xbh4U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-zOf24GzSMv64mSkNldrCjw-1; Wed, 22 Oct 2025 00:19:34 -0400
X-MC-Unique: zOf24GzSMv64mSkNldrCjw-1
X-Mimecast-MFC-AGG-ID: zOf24GzSMv64mSkNldrCjw_1761106773
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33dadf7c5beso2755598a91.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 21:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106773; x=1761711573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
        b=Ova0XMTRX2hAND2mxhlAvCYMhouECIzPHF0PdLXPvh5CI96/LkWCXimS45zNG1s+1q
         OSREHRCk9YXfrL2DRRZC/BzJ0zsDkI5onlxYJJkyT4hjJnAJY5Q5JvdZBkDCXNJcPjPn
         MG4mvYnbSLnz/upz2QNNrKVBv6m1YBmDr22y9eDpNDJW4wHeeDX5jwbA5e5b1q7pazvH
         rm8pWaRJ2zOnxwZ4gSCNtFKxNYp24lkKhsCYuXbun3w45hTbF9DXH1sUJkN1UIOMWITv
         se3Xn6yDwdeXWoNqiGca1iyJYja9QZ2+d8DubgrZX5/JdC4gAM4uH9CaRaG/21TwVCQa
         XiGw==
X-Forwarded-Encrypted: i=1; AJvYcCWWMzrC+hOePq6VDI8XcO8N9jt9UeFWaGyzySCDUWRY+rAZlNA84YXZjhEUA++CBaxXqKl4v1Y4Eva2wIwlrA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm4rYWfm8cU1crcmsng3MDuKZOQsjUQzzzWRxbxzseF8vVjDSL
	qbxJb12GFqGQ7PGnt2RNZPRgN1qel2A61Fh1KCxpYz4jYvYFrj49ZISZaKDc/LW0DN9DTOKzIcc
	YOLDbjeA4WlxvJ4urXqqM0KCzGwyPKymh/UnPob7WcnmtH5q/pH9h4VvS4+Dt/11kESyNdj6ag0
	t4iEs5xwLqdG5+Nzdr9sQ7+SvK9bHv54IE26ZBGDEprrs=
X-Gm-Gg: ASbGnctkYic/bDkHZWev1Vb93uiZ7CeuMMcTDOvPlZsgolAZiICRzVsYiob32shCHeV
	VmTCO3EFAms/ZQOmzSnnv5P0dayR56dbwssTh5A1fY0nWEzseHi+g0Adt7L1t16Z7qmZpNLJCy6
	lnGTmIZFbsTluwr+S00k1ghUpM6V6yHHqcU0XrKAE5LFHUEg2azrI8V0qz
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-33bcf85aba8mr27207012a91.4.1761106773506;
        Tue, 21 Oct 2025 21:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxpm190zeS/O7QhosnTZCJ+sJ0OOtUfB8EF+I18t2uJyG2ctlTvkqQPBgMA4jG+/iqib9IAmxZwYBAa++FoXg=
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id
 98e67ed59e1d1-33bcf85aba8mr27206962a91.4.1761106772999; Tue, 21 Oct 2025
 21:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com> <20251021085030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021085030-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:19:19 +0800
X-Gm-Features: AS18NWCKmXJHmGDH1OnrtnkNAc2Gt2Hyx92v8bPZ5LqsjBJ7559XCA-Y6f0OWpQ
Message-ID: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pavan.kondeti@oss.qualcomm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 103K4oDSqhfhst1j_rtvY5dtJFAgiFetVz2cMbV0VI4_1761106773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > is allocated, later freeze/remove may attempt to free vqs again.
> > Set vblk->vqs to NULL after freeing to avoid double free.
> >
> > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > ---
> > The patch fixes a double free issue that occurs in virtio_blk during
> > freeze/resume.
> > The issue is caused by:
> > 1. During the first freeze, vblk->vqs is freed but pointer is not set t=
o
> >    NULL.
> > 2. Virtio block device fails before vblk->vqs is allocated during resum=
e.
> > 3. During the next freeze, vblk->vqs gets freed again, causing the
> >    double free crash.
>
> this part I don't get. if restore fails, how can freeze be called
> again?

For example, could it be triggered by the user?

Thanks

>
> > ---
> >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0=
344d24f9fa06841eb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> >  out:
> >       kfree(vqs);
> >       kfree(vqs_info);
> > -     if (err)
> > +     if (err) {
> >               kfree(vblk->vqs);
> > +             /*
> > +              * Set to NULL to prevent freeing vqs again during freezi=
ng.
> > +              */
> > +             vblk->vqs =3D NULL;
> > +     }
> >       return err;
> >  }
> >
>
> > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_dev=
ice *vdev)
> >
> >       vdev->config->del_vqs(vdev);
> >       kfree(vblk->vqs);
> > +     /*
> > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > +      * allocation during resume. Note that kfree() already handles NU=
LL
> > +      * pointers safely.
> > +      */
> > +     vblk->vqs =3D NULL;
> >
> >       return 0;
> >  }
> >
> > ---
> > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > change-id: 20250926-virtio_double_free-7ab880d82a17
> >
> > Best regards,
> > --
> > Cong Zhang <cong.zhang@oss.qualcomm.com>
>


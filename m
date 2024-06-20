Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02290193097
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871686; cv=none; b=rDl25CPY1OaLDUTVcOHt/preCzAJpnGGB7tP5gvVuwI3a/vrQruf6axdpbG603EECsl5psbed/hZShA7CNpTbsj8d6biaovIPciGpWzvtOMT0QsREoAq3fDO/0pIQ0R1swCN2ew7Ta3Iy8pxIFBP+eyUuuLq+XSKHgV7N/HT2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871686; c=relaxed/simple;
	bh=LR/K+J6KzpZJF93eE1SpQIRs80lV/+fTYln8iY77+Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRhT55wlSh3pWdkmnc+dBNi9zn+mrMh3lzErMKKCLSDUuPcHwGFpgJZPE/7RB8lDmrAKsxVzweIGKOjdoEPzldzcPW46qhQ+EPCVbze0uESGVPdxS3K399ecFWfVQ6oMgotc5uhLkpKeRjzwejXnRfKgZXqZA/PUo4Y3j4rVuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrcXlpGv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrcXlpGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UycNLq/jPjHQqHMLXV0878YjLaKSICJpDUuvwOlKQOg=;
	b=DrcXlpGvkVH2pX0sQ1oMayEWV7kLEt6qj5t5wur6jUYEH75d62/jQQdER+4qjzTnrRIJ1f
	sklGMV6BKDu4D1w0XRPKQpcQpuSNpy6Imq9/2SXp8Ey7ybH44VeVKMJWr/K2OqraOlLTLC
	PpCe/mhrFZzWdbNS9KStrtnnvGggZI4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-rmn3-OB7NAKjsntoFAoeSA-1; Thu, 20 Jun 2024 04:21:22 -0400
X-MC-Unique: rmn3-OB7NAKjsntoFAoeSA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c6f1c0365eso718604a91.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871681; x=1719476481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UycNLq/jPjHQqHMLXV0878YjLaKSICJpDUuvwOlKQOg=;
        b=ZZXknMgeJejU9pdj/jFZv0v8EY6C65aO2cJRS0k6ngX/uSvirbvbiM+hjHCMHoNSGb
         eUFF71qFARMs+jmF1jTTBUcl1rOybunT0NfHe1PtkyxwrTOGYR9z2qsjjYFX+OSWqC9o
         WKgumdiROqo1l6WOJtKaesNa6pvGSpWc6cbEFDkbhYfra+piKzn3tmCTqqz/5v4VkRaI
         /2vRxl+8XqF+CD0iYsAYd79HTLj8dLXVxiXo8SvmP09AVPuIycjqVSDS/sr5STdOas8d
         Pqv+mmOIhKmZPRPHlzL0KexSDC3SpY/ocKt00rakYJvp3caqQbMM+6zEGflQRwqJiGAK
         IV8A==
X-Forwarded-Encrypted: i=1; AJvYcCVl6trFqvEr3gmPzaIM93FXJgIwSKxDGIGS+YLV0Q/yF7JIEXNdxBhFUicX2JTK942HlBLRgiIWlZFZ+8vV6//OPa2irWF4UuJdG/DoKDs=
X-Gm-Message-State: AOJu0Yy84uz6VJBHYPQvHvBAmqu3fYSlO7Ac3gw9fmw+Kj/O3wa3jyAY
	rhaFQF5rkFilq4gL0/OWcUWHomog30d1wduM/pgdhwipoqiaQCi8WlL/fjdBtoTEA45dUFbs+iW
	hYQ95ntNRVw3AOD6NyXDYIzu2bR4A0763Sfg+FEDBvXPnooR4Tvvrpkl1ULiYVRcpOfczFx7zUl
	RNn9dxGAEdExLzZegmddtfnA3DHiGRdsGfbYVBeL2tnfou4r0=
X-Received: by 2002:a17:90a:12cf:b0:2c2:deda:8561 with SMTP id 98e67ed59e1d1-2c7b5dc9665mr4142094a91.41.1718871680845;
        Thu, 20 Jun 2024 01:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtYn/rf/kl6Qj5/Pavju1IvIHJQmkYLZpAJM3Hav28b/FHSe46aqQwH/hKX1cWbXvGnnxKId86W9xKimIuLO4=
X-Received: by 2002:a17:90a:12cf:b0:2c2:deda:8561 with SMTP id
 98e67ed59e1d1-2c7b5dc9665mr4142074a91.41.1718871680356; Thu, 20 Jun 2024
 01:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-2-xuanzhuo@linux.alibaba.com> <20240620040415-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620040415-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:21:08 +0800
Message-ID: <CACGkMEuGcP1gqmNUGSXx5QLwqizL=DUYWKm5AUycx96pz0JhsA@mail.gmail.com>
Subject: Re: [PATCH vhost v9 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Apr 24, 2024 at 05:15:28PM +0800, Xuan Zhuo wrote:
> > Currently, the init_vqs function within the virtio_balloon driver relie=
s
> > on the condition that certain names array entries are null in order to
> > skip the initialization of some virtual queues (vqs). This behavior is
> > unique to this part of the codebase. In an upcoming commit, we plan to
> > eliminate this dependency by removing the function entirely. Therefore,
> > with this change, we are ensuring that the virtio_balloon no longer
> > depends on the aforementioned function.
> >
> > As specification 1.0-1.2, vq indexes should not be contiguous if some
> > vq does not exist. But currently the virtqueue index is contiguous for
> > all existing devices. The Linux kernel does not implement functionality
> > to allow vq indexes to be discontinuous. So the current behavior of the
> > virtio-balloon device is different for the spec. But this commit has no
> > functional changes.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> I can't make heads of tails of this.
>
> David you acked so maybe you can help rewrite the commit log here?
>
> I don't understand what this says.
> What in the balloon driver is out of spec?

The problem is the spec has bug, see this:

https://www.mail-archive.com/linux-um@lists.infradead.org/msg04359.html

Thanks


> NULL in names *exactly* allows skipping init for some vqs.
> How is that "does not implement"?
>
> And so on.
>
>
> > ---
> >  drivers/virtio/virtio_balloon.c | 48 ++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index c0a63638f95e..ccda6d08493f 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -548,49 +548,41 @@ static int init_vqs(struct virtio_balloon *vb)
> >       struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> >       vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> >       const char *names[VIRTIO_BALLOON_VQ_MAX];
> > -     int err;
> > +     int err, idx =3D 0;
> >
> > -     /*
> > -      * Inflateq and deflateq are used unconditionally. The names[]
> > -      * will be NULL if the related feature is not enabled, which will
> > -      * cause no allocation for the corresponding virtqueue in find_vq=
s.
> > -      */
> > -     callbacks[VIRTIO_BALLOON_VQ_INFLATE] =3D balloon_ack;
> > -     names[VIRTIO_BALLOON_VQ_INFLATE] =3D "inflate";
> > -     callbacks[VIRTIO_BALLOON_VQ_DEFLATE] =3D balloon_ack;
> > -     names[VIRTIO_BALLOON_VQ_DEFLATE] =3D "deflate";
> > -     callbacks[VIRTIO_BALLOON_VQ_STATS] =3D NULL;
> > -     names[VIRTIO_BALLOON_VQ_STATS] =3D NULL;
> > -     callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
> > -     names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
> > -     names[VIRTIO_BALLOON_VQ_REPORTING] =3D NULL;
> > +     callbacks[idx] =3D balloon_ack;
> > +     names[idx++] =3D "inflate";
> > +     callbacks[idx] =3D balloon_ack;
> > +     names[idx++] =3D "deflate";
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> > -             names[VIRTIO_BALLOON_VQ_STATS] =3D "stats";
> > -             callbacks[VIRTIO_BALLOON_VQ_STATS] =3D stats_request;
> > +             names[idx] =3D "stats";
> > +             callbacks[idx++] =3D stats_request;
> >       }
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)=
) {
> > -             names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D "free_page_vq";
> > -             callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D NULL;
> > +             names[idx] =3D "free_page_vq";
> > +             callbacks[idx++] =3D NULL;
> >       }
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > -             names[VIRTIO_BALLOON_VQ_REPORTING] =3D "reporting_vq";
> > -             callbacks[VIRTIO_BALLOON_VQ_REPORTING] =3D balloon_ack;
> > +             names[idx] =3D "reporting_vq";
> > +             callbacks[idx++] =3D balloon_ack;
> >       }
> >
> > -     err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> > -                           callbacks, names, NULL);
> > +     err =3D virtio_find_vqs(vb->vdev, idx, vqs, callbacks, names, NUL=
L);
> >       if (err)
> >               return err;
> >
> > -     vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
> > -     vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > +     idx =3D 0;
> > +
> > +     vb->inflate_vq =3D vqs[idx++];
> > +     vb->deflate_vq =3D vqs[idx++];
> > +
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> >               struct scatterlist sg;
> >               unsigned int num_stats;
> > -             vb->stats_vq =3D vqs[VIRTIO_BALLOON_VQ_STATS];
> > +             vb->stats_vq =3D vqs[idx++];
> >
> >               /*
> >                * Prime this virtqueue with one buffer so the hypervisor=
 can
> > @@ -610,10 +602,10 @@ static int init_vqs(struct virtio_balloon *vb)
> >       }
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)=
)
> > -             vb->free_page_vq =3D vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> > +             vb->free_page_vq =3D vqs[idx++];
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > -             vb->reporting_vq =3D vqs[VIRTIO_BALLOON_VQ_REPORTING];
> > +             vb->reporting_vq =3D vqs[idx++];
> >
> >       return 0;
> >  }
> > --
> > 2.32.0.3.g01195cf9f
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A720B7EF
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485867; cv=none; b=rsp31giiw2H2KzW16JGz4GPel0dV6YjKL2VQFqcZ2eJFztw2EW0BZiqiBmHRs9xxiCclL6rCl0/gEgCpNkOfDCiknJ6pYtPnBKz4a4P1sqsaWx1vzm7k8/FCXJ7/aok7hk9FhYnWJC0IZYXG/tiY8UHVylrwEfiBBHwKEhJQ9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485867; c=relaxed/simple;
	bh=F2vZaOS9f5dPxo1fJQc1/bBdBD5kzX1Fyp6Pv+/djS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNUhhCiBQWyIenhu0EHL7FwniVMe4bioscAXQG/QOr05MG3kZCtqWfHnFpAz9TLLl5TBIt1mUk7foNpe7D6Wqx1EgQ1CQbSiSk9246MV8AN0Qv4kE5nuSKhfOoE0kV7XI1P+RRmF+l793Me/fzwvRxI9EbQrAZW9zMhnlJMzVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ3PTNkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ3PTNkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUj8pOCsz76dhsi/SG3EEBuJV5Q3s6LEl5sicjNVCjQ=;
	b=gZ3PTNkl5Y0OJMFwOiTzcuTAj1XX+I/b6YgOhWiPGkp0p7TzNKa3JZYnEETz64/7gd2rYB
	R9SiUfKfG1R95jSrGflcUDJnKMvKSIapr+yIZof3dsONZR9mSkNMKitE/05HGR6XEqU0SA
	aMPVggfT3PUMeyII9/FRkSjE76ZxfEE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-QOCbTUfQMZm6pw3W2Oum2g-1; Tue, 25 Feb 2025 07:17:41 -0500
X-MC-Unique: QOCbTUfQMZm6pw3W2Oum2g-1
X-Mimecast-MFC-AGG-ID: QOCbTUfQMZm6pw3W2Oum2g_1740485860
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so12040488a91.2
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 04:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485860; x=1741090660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUj8pOCsz76dhsi/SG3EEBuJV5Q3s6LEl5sicjNVCjQ=;
        b=OTlIA2bIbebLlWGKJyKfdCE6kQcDkVqEYnYjVoJRaYv0fVyg6ySiJsjDWFVYnsf9Tv
         KWQyNcgVpxFaxweFE2OFgnGpPTS3vnHwEYLmB0jaUQQ+C80KM0eGl9D4cuXvJ0RzSQZS
         ttZfLPujwxTZT40rvIVIldLoNBvBqVvrBLu811fRrX5yh7WP5vyqTQsDjCImMgK/xeFr
         6ojOazdn25gZyp9I3O0ghkQciFxcqT3qUj+OjOLNMjmkywLZPZFya+BsATp6hJnD6CkV
         VKF5yFXKHondDEVDoBopz/wcIMDc2SMhy7fXO/P4xSJg7JagoCkoLQZAQcd+vC/i/j6m
         jyPg==
X-Gm-Message-State: AOJu0Yw3o0VMzII+/x3oC8zW8NeFBJ9xYmg0ZnyWPrXxSgf7yj9I2sw0
	gy3X0bjkai+FngQ67hvXk+lCSK1CBCzZV21C+GybjpVro4HUhrv4NW/T6I9EKxdxNNxCU2Fu0Ah
	i11vsNo9pA5HJsSl0U+Fd7W4EACBROG9b631BrRC0erF7bEc/sj8u+Ia9ZoSrrVeEjnq0s7XOKx
	rSi9jnYpPq/rjvwSdw46IxS/moKp0/nhmBEUEEwCc=
X-Gm-Gg: ASbGncse4uI7DOZZREdpbDqpJCp+jEfMH3tqTyYVqA/8AeOYPak5bOo2kn/Is4bRKqp
	gQN1x4yXSnDo2+eWFCL5JPhdOG77TIpX+HT8NivJK/C0UoWlMFpuHcvU0nM41OSoBVZE0mQE=
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fce769a8aemr27308465a91.4.1740485860044;
        Tue, 25 Feb 2025 04:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/2zzJb5wvZ7QqLIuzcDLskP+j6OTP1hc+levVyCYPy4thU+0z+g/gmtEF0bRntfAknjp+kHEctUeQsLn49kA=
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2fce769a8aemr27308438a91.4.1740485859755; Tue, 25 Feb 2025
 04:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250224164956-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164956-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 25 Feb 2025 13:17:02 +0100
X-Gm-Features: AWEUYZl9o1wkJEhPYQV6xj-jLOpXFm58am5y2uOOONMp9W8KB-2y7XkozzEpMWw
Message-ID: <CAJaqyWfir7+oVtC3Z+eC+jbDxkACs0J9a4-wnx_dgU5VeFhr8A@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hanna Reitz <hreitz@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jason Wang <jasowang@redhat.com>, German Maglione <gmaglione@redhat.com>, stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5viDlCxZniBXqBfzKqCY9baCoGgSQEhhjKF_cTlfUGE_1740485860
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > A VDUSE device that implements virtiofs device works fine just by
> > adding the device id to the whitelist.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>
> OK, but the commit log really should say why
> you are doing this.

Sure I can expand on the motivation.

Something like "Allowing VDUSE FS type allows to build filesystems
that run in userspace and can be presented transparently to the host
and the guest. After modifying userland's libfuse, this allows to
expose a good amount to already available userland FS through vDPA."

I'd add using the high performance virtio protocol but I still need to
do more tests for this TBH.

> And also why is it safe.
>

Can you expand on the scenarios you think this is insecure? While I
understand it's security sensitive, you already need root to perform
vdpa device operations. Is FS different from net or block?

Thanks!

> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 7ae99691efdf..6a9a37351310 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
> >  static u32 allowed_device_id[] =3D {
> >       VIRTIO_ID_BLOCK,
> >       VIRTIO_ID_NET,
> > +     VIRTIO_ID_FS,
> >  };
> >
> >  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa=
)
> > --
> > 2.48.1
>


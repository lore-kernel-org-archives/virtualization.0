Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD7165F16
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680246; cv=none; b=N2O04C5gFaJ/AJ1ky2zev5semxqHKJ+ASLkdZK0LFaC/uBs+gnwZEz9y5Z4ghQjBwmncynwokP8qFh4e2ZhvSET98gH0GA8qErGfMrNNFke7uaQw+HpkM65+3cc8qdTYEGaWDyWX6YTSGLzSBWmLljwRcT54vVT0eP+F4ITi27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680246; c=relaxed/simple;
	bh=M55zVL3wl0TUEnWYPTrrncM4Cm62czibf4stuL7FP40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4FhIF32XWEbT1m4iGINNVOI8B1SHvbIG7hLXAgj3yvmU9fuygEpKZSo5XWW4E+Peicag4tQE7DBxo+7IgHlef/8tJ7+OIkjIk5p1Add8H/Yw/OaLD9bp3G2kgghtuam+eZVfqv4BarBdR+xZbQyCwfz5HgnTZLLkmWAL5u+uKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J05JhuJv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J05JhuJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781680243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIsAiMFRbuUMjtjMFYM5xi+RjaMEkr6h5x5Wm7Uwb14=;
	b=J05JhuJv6JnS4SBaN3VZBBcOyDQhQ7WsrHMfYdiGxa9b9fzP+nurFEPptBvC6OeaBUav50
	FeJWsrVz9p8GsH9DCPAYPTlOAMZwx91J4A1oOFaCwN0xU20EEyYJtz6TB6kAVrYDPxRK0/
	9N9yUX5Y+ZHKqzuENsAQF5wcTiUNWX0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-63ZOZtNvP3K_O232WaiVtQ-1; Wed, 17 Jun 2026 03:10:42 -0400
X-MC-Unique: 63ZOZtNvP3K_O232WaiVtQ-1
X-Mimecast-MFC-AGG-ID: 63ZOZtNvP3K_O232WaiVtQ_1781680242
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66077c3f223so8005847d50.1
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 00:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781680242; x=1782285042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dIsAiMFRbuUMjtjMFYM5xi+RjaMEkr6h5x5Wm7Uwb14=;
        b=VUWqX0hRNnW7gBpztafYCgJEIPJnNWGgeU9hyhJVLa16ffjQ2ryrQxphKGBdcZQPWJ
         euQbPKBL2zieHyzhfURfXqpPR2pBKBqe4h6FFUyewh2AuFZzTtWyzKulUw/4Sjhi0Um5
         viMzKuNsAJkPueddEegRjlyFMsTDnwD+TUtMc5n+ipxbacqlqvTCdpU5Y1jmq3rgT0I2
         Sks0yIcIEONghBXeME+nSn5c5x36K9iQ++oY8Phe4iJAmfVg83ko01lNecaPltm31sze
         /GRWDhGWfuSLCwiRAf8Ami6AmqBSC1KpwSAzVjTqmDN6SBIoVHWvzDqj4fsNxxSDPv8h
         CriA==
X-Forwarded-Encrypted: i=1; AFNElJ9G8DaZRJZZECklw9suoCAqmrcDs9m3lo0Rb5AE7kIHTwtWc+l+QRQQY0Lf5IWVKpYCgBZfDBpejlCFwZ6wKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZq1rBQ9NXnenztIcIySK6hTNCkSSwNGSWrsjMf1x+1BLoxI4s
	J2BwXJ7rtzjuDbABXQdW+s+GRiODp399CgnZm7bA7SqGpKG5zlIOV8LI9oVnhaiQJgszUQz0/nP
	xKXdwyd8Q8EaZfBd3YcenXMma6eTODjeWNIh8T/cAsBFlCKqLhTspfTt32EgBYI9IBFVxhX3iXT
	0N5uGbB6Lcgvr260r6rmSVliWV8DsrcjXfsP5WkOBNKqg=
X-Gm-Gg: AfdE7clENu3TOcTexroTadt4yiySRUVh6/fTtitmgJUt3L2WQJfuzOlpk9ZIFdolqX7
	XdzGnnXldX6NjFlN7fks1YbpLZXoD+01nmViOaex0bwoYQ7VeIgxcQkwT7nhAc7v8RjusY0WVBA
	hYUfFomhmvwQzxUN3HxOXWtsHctjMzuj+A1XPrGlm+s/69bQ/Hnl5iws5HYI1iGHXOaxE=
X-Received: by 2002:a05:690e:191b:b0:662:db62:14e1 with SMTP id 956f58d0204a3-662db621844mr27488d50.35.1781680241500;
        Wed, 17 Jun 2026 00:10:41 -0700 (PDT)
X-Received: by 2002:a05:690e:191b:b0:662:db62:14e1 with SMTP id
 956f58d0204a3-662db621844mr27465d50.35.1781680240943; Wed, 17 Jun 2026
 00:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260612105054.1850453-1-slf@hdu.edu.cn>
In-Reply-To: <20260612105054.1850453-1-slf@hdu.edu.cn>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Jun 2026 09:10:04 +0200
X-Gm-Features: AVVi8CcST45SfqQoikALSAtZCi6M5Pfhp3CkfuPlJDrOurrJIlYPGUnbbqOls-o
Message-ID: <CAJaqyWeYrEq9LcsxMXTzkttthkQFWM=rzekrB36VOtrkaZuyCg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix cleanup after worker creation failure
To: Linfeng Sun <slf@hdu.edu.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5wqYO64zjH6ilS6-kXZe2KvcWjrs_55HuhmdqEfTlhU_1781680242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 12:57=E2=80=AFPM Linfeng Sun <slf@hdu.edu.cn> wrote=
:
>
> vdpasim_create() leaves vdpasim->worker as an ERR_PTR when
> kthread_run_worker() fails. The error path then drops the device
> reference, which releases the partially initialized simulator.
>
> vdpasim_free() unconditionally passes the worker pointer to
> kthread_destroy_worker(), so the ERR_PTR is dereferenced and can
> trigger a general protection fault.
>
> Store the worker error, clear the pointer, and make the release path
> only clean up resources that were successfully initialized before
> the failure.
>

Good catch! Yet a few things to improve,

It missees Fixes: tag

> Signed-off-by: Linfeng Sun <slf@hdu.edu.cn>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8cb1cc2ea139..6a4e28c49d2d 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -230,9 +230,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_at=
tr *dev_attr,
>
>         kthread_init_work(&vdpasim->work, vdpasim_work_fn);
>         vdpasim->worker =3D kthread_run_worker(0, "vDPA sim worker: %s",
> -                                               dev_attr->name);
> -       if (IS_ERR(vdpasim->worker))
> +                                            dev_attr->name);
> +       if (IS_ERR(vdpasim->worker)) {
> +               ret =3D PTR_ERR(vdpasim->worker);
> +               vdpasim->worker =3D NULL;
>                 goto err_iommu;
> +       }
>
>         mutex_init(&vdpasim->mutex);
>         spin_lock_init(&vdpasim->iommu_lock);
> @@ -742,18 +745,24 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>         int i;
>
> -       kthread_cancel_work_sync(&vdpasim->work);
> -       kthread_destroy_worker(vdpasim->worker);
> +       if (vdpasim->worker) {
> +               kthread_cancel_work_sync(&vdpasim->work);
> +               kthread_destroy_worker(vdpasim->worker);
> +       }
>
> -       for (i =3D 0; i < vdpasim->dev_attr.nvqs; i++) {
> -               vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
> -               vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> +       if (vdpasim->vqs) {
> +               for (i =3D 0; i < vdpasim->dev_attr.nvqs; i++) {
> +                       vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
> +                       vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> +               }
>         }
>
>         vdpasim->dev_attr.free(vdpasim);
>
> -       for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> -               vhost_iotlb_reset(&vdpasim->iommu[i]);
> +       if (vdpasim->iommu && vdpasim->iommu_pt) {

It looks to me that this conditional and the one for `vdpasim->vqs`,
are needed if vdpasim_create returns from error paths other than the
error from kthread_run_worker, isn't it? For example, if
dma_set_mask_and_coherent fails, vhost_iotlb_reset will also be
called. In that sense, it would be great to note this in the patch
message.

Also, vdpasim->iommu[i] should be reset regardless vdpasim->iommu_pt,
so omit that in the conditional.

Finally, if you found the issue or coded the patch with AI please
indicate it with the Assisted-by tag.

With these changes applied, feel free to add:

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> +               for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> +                       vhost_iotlb_reset(&vdpasim->iommu[i]);
> +       }
>         kfree(vdpasim->iommu);
>         kfree(vdpasim->iommu_pt);
>         kfree(vdpasim->vqs);
> --
> 2.43.0
>
>


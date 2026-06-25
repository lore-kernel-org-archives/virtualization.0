Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7D331EDF
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377687; cv=none; b=cMqLyjeJQSsBIAQDJc4fjVeZRA+OS/8fv8IgwsZc3GadQH6fW0z62hr7+9tPFZUGoQkiD6IJG4DpH7TEEglFLW/1J50YJEhBnfwSOmNbHoyqOkbVHKm/+BH9GqUdcVHQ/uN5GsJcvRkeQjfEr5pYze5SP0Fo5e2FIwJQNVrIMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377687; c=relaxed/simple;
	bh=X8yCcV/YWgYKgK7IegaCYBojBgoI0vKj8L7buZx67rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLj+Z1pk78OqppHOC/elJvI56sOXoVYEeKst6F8vtKNdN2qLmpDDiJUuO18xnEbiRjPrKkNUykMQoJOFqGxTUoXsEcaGubnnwUdoOUayexRFOTEqVLWFW/JpC7wyWwVuJ8vQbiEQOLwmt5uRwjwFC5N9ong7C0rrS4Cc9h5yOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2WPxsGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2WPxsGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782377685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvxll0tnGHxonIQuLyvGdHRwMshiL5VlMSlBtrHUy78=;
	b=L2WPxsGUYOcH7KNGcOxHDfnytKkmr0vZef5+v4ZFhQSVqTfBYSgsdWd6uR05NpO0hgQldV
	1O0n4vaD8l+VsLfnyZV0g/KIi9PFjuTIkVAFErFguAX8IfllkONOc8o7+pw0rK+6f9LSzi
	VBmPNBM+Drd0CNlthMHosgtOc50US6M=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501--50gN0O_Mc-LyQWwf_3Q6w-1; Thu, 25 Jun 2026 04:54:43 -0400
X-MC-Unique: -50gN0O_Mc-LyQWwf_3Q6w-1
X-Mimecast-MFC-AGG-ID: -50gN0O_Mc-LyQWwf_3Q6w_1782377683
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6628850c6e4so3285575d50.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 01:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377683; x=1782982483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvxll0tnGHxonIQuLyvGdHRwMshiL5VlMSlBtrHUy78=;
        b=KsG56jJkURdwO5rU5aDaqn6sj2wu5BT1kjE09L8dijBHO5fVKFGU4YeDDlVnS2P7Jo
         LHADeuhpbxye2X48aUNERIoPlxxlBhtNt65l5JBViP3GEU3NxahkgXlFP5Gshv3HzR/J
         BgERq4AqyRJNOlXD39PWue2SWdkbCVNKBdmiy6CNlpnNLbsaF1Ia1Sq/jmDdmA7iTfaL
         LMJs3Mr9q+b3ECOa+dTi0BGpqlcSSyb5N3sFylURqbjS3qiHgLeTlf3kQQ9c1rvTP0Ec
         JFEu0ho8aSRW0thIfiyF7F1dXqbHys2uWlY0hnZ8fCjDx3XxEB5zGcKA9IElE5wdxKe2
         MXsA==
X-Gm-Message-State: AOJu0YyB9/jlVyZwX20XOpZtc6d8xEO43ZhZ9fkXOTl3Hb8McZjMJ5OS
	ld6QlPKQ/mQLvWH44ou5nPEB9TtblJ7vKLRRwcGWnSdjevo1wS7h01pFDjF4JjH7vSxqRpmP0sg
	n4nV6byQV6vT6TVgbqJ4+8BgfPw8q7OXpcuT7DAVEkHepFk2z0B7OtNHb8MA0ufl+5oDUYBIu6f
	K4lnWOCdq4Yp79GArhVRLcBHxQfJ3obotsrwta1ooXp5w=
X-Gm-Gg: AfdE7cmclIDLTCnUQ/xxAKBFk2ByWMx4SH2XxZoxvwMASb1H31V2dWq9stgSYP4nj/X
	e9OkPmUeH0/9qievkl9kQbQV/VXZrb3nj5hyO2oOryvY/cBWoqQChsn19Xg96P8bwfDoHqkZxfC
	9Mwp5t8DOvRBXstb5/8dBlVqcNtTn6ymjmy2P/XZ4xK5LBBEKpKFuMcBMHaISiwcRFGsU=
X-Received: by 2002:a05:690e:14cc:b0:663:9a0a:7b80 with SMTP id 956f58d0204a3-66487da95c5mr1124138d50.19.1782377682892;
        Thu, 25 Jun 2026 01:54:42 -0700 (PDT)
X-Received: by 2002:a05:690e:14cc:b0:663:9a0a:7b80 with SMTP id
 956f58d0204a3-66487da95c5mr1124111d50.19.1782377681957; Thu, 25 Jun 2026
 01:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260625083017.497842-1-15927021679@163.com>
In-Reply-To: <20260625083017.497842-1-15927021679@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 10:54:04 +0200
X-Gm-Features: AVVi8CdF9i4n50KPrxsywQvPws0MsU3mXNVxVvg5KYQuRUkcbFWKObLi94ggOd0
Message-ID: <CAJaqyWdwk8ki-1TXwoTNW9j5prHZwN77cYFWT9ir9o55at9p1Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix cleanup after worker creation failure
To: Xiong Weimin <15927021679@163.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ruFsLrrkwogtF57yaskA1p1eZ2NdNFypHgODFI2_82g_1782377683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:37=E2=80=AFAM Xiong Weimin <15927021679@163.com>=
 wrote:
>
> From: Xiong Weimin <xiongweimin@kylinos.cn>
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
> Tested on openEuler VM with kernel 6.16.8: module build, reload,
> and vdpa dev add via vdpasim_net.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 1111111..2222222 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -231,8 +231,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_at=
tr *dev_attr,
>         kthread_init_work(&vdpasim->work, vdpasim_work_fn);
>         vdpasim->worker =3D kthread_run_worker(0, "vDPA sim worker: %s",
>                                                 dev_attr->name);
> -       if (IS_ERR(vdpasim->worker))
> +       if (IS_ERR(vdpasim->worker)) {
> +               ret =3D PTR_ERR(vdpasim->worker);
> +               vdpasim->worker =3D NULL;
>                 goto err_iommu;
> +       }
>
>         mutex_init(&vdpasim->mutex);
>         spin_lock_init(&vdpasim->iommu_lock);
> @@ -750,18 +753,24 @@ static void vdpasim_free(struct vdpa_device *vdpa)
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
> +               for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> +                       vhost_iotlb_reset(&vdpasim->iommu[i]);
> +       }
>         kfree(vdpasim->iommu);
>         kfree(vdpasim->iommu_pt);
>         kfree(vdpasim->vqs);

Isn't this the exact same fix as v1 of
https://lore.kernel.org/lkml/20260620100959.2070316-1-slf@hdu.edu.cn/
?


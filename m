Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA51BDCB
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708924814; cv=none; b=IRkGkeSwuuXC7kKDVI0rd8Q3YmPtSf6Gi/IxC3G44rtF0/Q4LRK5/AC6edW1TOw5ZVy/2wWcymbavRMBZXQ8xpbsJtXHO8AH7ZRT4roTlBaNqdzSBgIm9hZOhdumOgveV5j08KVbzuCAIrgbhy3EOmcdBsFOcloZSsBBqcat7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708924814; c=relaxed/simple;
	bh=efRE82bmn2sSdUjgLdybc3a8cQET+NqpE4ZOzuHzZPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRtfo1wCqSTaQQ4a4ijVix994Ub+cXdcwLGbkZZyGcxVvqKa3RrAyktYTWEjUeLu9P9RwVVMIQdjNfPF/JUgF5gb6Z5HfBunj/OlwO9qyHzO1GJFV586X+b4Rvvy8Zm1soF3cQchh7toEVKTzeHFldDrJgSq4yqILxlcEEvMz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/yZj+o7; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/yZj+o7"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7461E408C5
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 05:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hAlTepPp5rWk
	for <virtualization@lists.linux-foundation.org>;
	Mon, 26 Feb 2024 05:20:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 27E9140133
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27E9140133
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/yZj+o7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27E9140133
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 05:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708924810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR7Q2zkYqSnX8F3oRCUhnjClUfm8h1EeNqtuMcww9ds=;
	b=Z/yZj+o7g9ZSWykVWIedxus/RXjMYRYH/0Sy21Ap0NtdudYS1r6lOJA+EAfANuUiXj5mvm
	Z6ww2NtZHWAEX9oR5zV4T4bOsnak6QyTvi3/KxYEWnmarIuEMvQ2NiHmijJrLUebI+yTty
	tm+2uNMN1ZWSNbOORr5PgO2cNyEjbUQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-cR-wHmVUNheCESFNvjKZAg-1; Mon, 26 Feb 2024 00:20:08 -0500
X-MC-Unique: cR-wHmVUNheCESFNvjKZAg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2997a3f97fcso1567430a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 25 Feb 2024 21:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708924808; x=1709529608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR7Q2zkYqSnX8F3oRCUhnjClUfm8h1EeNqtuMcww9ds=;
        b=fCnRQ4MogL0Qb2YKQX7z9NyHNEN0mXKhrhxNr4NoII8yWpoVZeu908CZvUfPThCQDp
         UJ7ebd65iApEcqdlL6VHE/nYNVHdtASGw6G1Q+tTW0VNxc5mJs77hF3QNf+kOwC7xd8p
         UKeaetCle3Qe5/m53kBswDC610ZHYcQG/tag+eixmI7Zw60o1Pe4eKmRNGfVubcNv8bY
         xxZzGGpkyGA57m8oe7ODvnTqXv/0I0XFXJwSE0j5YqnFW3DZtnHszMFyq8cZzxZL9nIa
         ZVWXH98WL1Zntew4TV8d69f77cZ0BGoyfcQacKULBdjXdO3v7RFZevjVvwMGDE+u0b6p
         9KLw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYzNyM+Co8IijISw0gNeNbetcv6m8gOcQ/UpKhZgj8YUuAzaEZw19csWkh0THLPVDOCYjCmCS/QkeJaUoX2+ZHksL7jMQAYU+9VOtvN3C0hcQaSG4OBlDyQ==
X-Gm-Message-State: AOJu0YwgDQVVFlveQWPK+hZdo3RqaGS+OAT7ImUTrjmABxG4hQ78FJE4
	5S3D3KtlYHZiqjxRcJrstH4AIM1HYPMP8nFm//1ktaJ8Sso7+EjntCN0UAtOsI9HnDOMddal0rJ
	YNOa38DpSW75Rcjg3sTKJV1Tt+9UogxRvKgSVppATO6X42SRy08o1jDEe1NRIWMonK+aYJrZS46
	Yv7DWa6s20DOnmj19goMTeDeHt7kBRkpqnq4yRRZNgMxv2sNrBoujaQg==
X-Received: by 2002:a17:90a:bd09:b0:29a:8b1b:1f61 with SMTP id y9-20020a17090abd0900b0029a8b1b1f61mr2984047pjr.17.1708924807787;
        Sun, 25 Feb 2024 21:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR55k+CiiY4IChHH5uH5prMG2DYSKJzeu4TWGgPhzhmvsfhfsWai7RFTjtrg64PoJL6UP1qQVnbxXaB67SjkE=
X-Received: by 2002:a17:90a:bd09:b0:29a:8b1b:1f61 with SMTP id
 y9-20020a17090abd0900b0029a8b1b1f61mr2984033pjr.17.1708924807480; Sun, 25 Feb
 2024 21:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240220011050.30913-1-shannon.nelson@amd.com>
In-Reply-To: <20240220011050.30913-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 13:19:56 +0800
Message-ID: <CACGkMEu5WskbWu3Qte7aXyYKG53D3u8exeQESBFzJvtUS9NZyw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/pds: fixes for VF vdpa flr-aer handling
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com, 
	drivers@pensando.io
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:11=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>
> This addresses a couple of things found while testing the FLR and AER
> handling with the VFs.
>  - release irqs before calling vp_modern_remove()
>  - make sure we have a valid struct pointer before using it to release ir=
qs
>  - make sure the FW is alive before trying to add a new device
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/vdpa/pds/aux_drv.c  |  2 +-
>  drivers/vdpa/pds/vdpa_dev.c | 20 +++++++++++++++++---
>  drivers/vdpa/pds/vdpa_dev.h |  1 +
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/pds/aux_drv.c b/drivers/vdpa/pds/aux_drv.c
> index 186e9ee22eb1..f57330cf9024 100644
> --- a/drivers/vdpa/pds/aux_drv.c
> +++ b/drivers/vdpa/pds/aux_drv.c
> @@ -93,8 +93,8 @@ static void pds_vdpa_remove(struct auxiliary_device *au=
x_dev)
>         struct device *dev =3D &aux_dev->dev;
>
>         vdpa_mgmtdev_unregister(&vdpa_aux->vdpa_mdev);
> +       pds_vdpa_release_irqs(vdpa_aux->pdsv);
>         vp_modern_remove(&vdpa_aux->vd_mdev);
> -       pci_free_irq_vectors(vdpa_aux->padev->vf_pdev);
>
>         pds_vdpa_debugfs_del_vdpadev(vdpa_aux);
>         kfree(vdpa_aux);
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 25c0fe5ec3d5..301d95e08596 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -426,12 +426,18 @@ static int pds_vdpa_request_irqs(struct pds_vdpa_de=
vice *pdsv)
>         return err;
>  }
>
> -static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
> +void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
>  {
> -       struct pci_dev *pdev =3D pdsv->vdpa_aux->padev->vf_pdev;
> -       struct pds_vdpa_aux *vdpa_aux =3D pdsv->vdpa_aux;
> +       struct pds_vdpa_aux *vdpa_aux;
> +       struct pci_dev *pdev;
>         int qid;
>
> +       if (!pdsv)
> +               return;
> +
> +       pdev =3D pdsv->vdpa_aux->padev->vf_pdev;
> +       vdpa_aux =3D pdsv->vdpa_aux;
> +
>         if (!vdpa_aux->nintrs)
>                 return;
>
> @@ -612,6 +618,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         struct device *dma_dev;
>         struct pci_dev *pdev;
>         struct device *dev;
> +       u8 status;
>         int err;
>         int i;
>
> @@ -638,6 +645,13 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *md=
ev, const char *name,
>         dma_dev =3D &pdev->dev;
>         pdsv->vdpa_dev.dma_dev =3D dma_dev;
>
> +       status =3D pds_vdpa_get_status(&pdsv->vdpa_dev);
> +       if (status =3D=3D 0xff) {
> +               dev_err(dev, "Broken PCI - status %#x\n", status);
> +               err =3D -ENXIO;
> +               goto err_unmap;
> +       }

This seems a violation of the virtio spec.

Note that spec has a DEVICE_NEEDS_RESET(64) or do we have a vendor
specific way to detect this instead?

Thanks

> +
>         pdsv->supported_features =3D mgmt->supported_features;
>
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
> index d984ba24a7da..84bdb45871ff 100644
> --- a/drivers/vdpa/pds/vdpa_dev.h
> +++ b/drivers/vdpa/pds/vdpa_dev.h
> @@ -46,5 +46,6 @@ struct pds_vdpa_device {
>
>  #define PDS_VDPA_PACKED_INVERT_IDX     0x8000
>
> +void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv);
>  int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
>  #endif /* _VDPA_DEV_H_ */
> --
> 2.17.1
>


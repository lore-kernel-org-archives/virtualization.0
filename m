Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAFB67E
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080005; cv=none; b=EZb0l/HDbcndJgOLH2a5TfGqE1U50nbEylLW/akIxUe4VqUNxsf3pNgAx+R6QUZAtfV1NEoGwQBIFA++jH9DcSC1KgkXyZIrIM7Eo2rsJGB16vwz89ZtcuawcJlug4PiahO4uAXQUaJ7PXV+9APtme0GgLo+8whkHIP2cEP1ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080005; c=relaxed/simple;
	bh=2+xopuqcb8jYIYZ43TKLFq1BSj8EDYzIfiTpnANL+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWJcpubW2hO6qoxHSMwAnRJAK2HQTOJQAIQk2uFKDg/fLhk6aDPoDwNoxeLCpt7FSTBYLoSu5gP+B9bLqqtIxxfyLChxMhz/5eciTC31vxmYpgmFwjJgZtdHBrdnP6U/LOE471cicLwFTbhF7JJA6hc/8jN5BHGeZ+VeWMNQzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjAtw209; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjAtw209"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760080002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNF4bqSfxRXQ2tMzr7IR6cFMVgrJk7iMG/ca9AYKDuQ=;
	b=LjAtw2095CocYh5YwC0vTXJuaPh8qDLlf6cs9redJoo56VJv9UnDJqV1vniSoD5YNGFn8d
	9wKEdD4oITabcoWMqUUbORn+FF+m/fT/7OR554+rPGcohZR7b7DnhK2Tfz6qOM5y85Ostu
	NQlHTN4llUyZPMk6XPMEih6gfTM+CPk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-O_kvxcRcPhqBcPaiVpDNKw-1; Fri, 10 Oct 2025 03:06:41 -0400
X-MC-Unique: O_kvxcRcPhqBcPaiVpDNKw-1
X-Mimecast-MFC-AGG-ID: O_kvxcRcPhqBcPaiVpDNKw_1760080001
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-74717169ab5so30658367b3.2
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 00:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080000; x=1760684800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNF4bqSfxRXQ2tMzr7IR6cFMVgrJk7iMG/ca9AYKDuQ=;
        b=NRqBr1LQv4G/4s9X7IRTuoD6fuInj4RxgvgrjkIG2UI1b9nIgYqFQlkuuQJD8rS6O3
         Q2SaJp+DVP6ysend8XrNdJu78e44qL5DQVu6ooxSr7SHXwxaZHmoZX/oWRB+ck0cgr8m
         yCZB3VFOW8vLB8AL3zMuyGhsWqw/vAbhD2w3zhNqTH14fDlBDGKsjqtJP4+QDLLJKGiw
         DfQtJVbjfC5EKIuh7nWajADIKxAGoB7/Z9K7CIRvwIEHj04Z7+hrpqhZTRw7gELWPnJR
         mgYv0KoFffqTInwViVXR3nvTDE9HqQ/fDuuM9CguBT1/5/wwAOfnudwCD3FcsOJqLTsQ
         7czA==
X-Forwarded-Encrypted: i=1; AJvYcCWI9s2kZzjShIRAw5ArAkLI2o7cJAPAapylCG5nnonlHc9WzZ8+18JUFJBSGPvfdEcc23enn94Bla1aFLyPoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqs2hZXYvEpXsJORq+y1Yq35Q8PdE+PMQzT+50NFXbo1nswJup
	Y4vPXXvoMmRWnpY0dhkqYM2W1F+xK9R/D0vFL8+6JsKkB8tflcxfnq8HS2OjlDn5madDAGAXzVB
	t5ckK7TKPs7mYAIAmhPOvbRfb/Kp8FkCP2LNLNx9OTEerbY9Gh/2e/w5Ez1xIYJm5DTnAWAhwcV
	UwYVg95FTz1+CPCaaXVSkzr1ceT8/oPNgSPTvA6CuViBE=
X-Gm-Gg: ASbGncurOTrfI7PKaubNHSVybpPlaAWyMH6tL3NExj/ZiITTNacTK5iwvR5zCEkmbNB
	P2HSOFljl97kaZCfJTdSEAZVQ8J6SQEKm3NeEwm7cp4tQJb5JfM1iJKPrOFQRk46oU/v8EWig03
	f1NN7fOlTICqOAtrYHmigWKDV8VtOqCcAJuAY6Hu7MFyqqOse3RX82LqJ47XVKpWvWgrawn5ytg
	vKqGQZz
X-Received: by 2002:a05:690e:1a0f:b0:633:b9eb:85ff with SMTP id 956f58d0204a3-63ccb845174mr8758528d50.12.1760080000668;
        Fri, 10 Oct 2025 00:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGoIFzOultU88GKL3yEdXx/Sa1hT+G+e2edQkctkSb896rcs+z2VWdsWIjNeAA6gUDvvKfsp0/P1YuTQGtdI=
X-Received: by 2002:a05:690e:1a0f:b0:633:b9eb:85ff with SMTP id
 956f58d0204a3-63ccb845174mr8758511d50.12.1760080000276; Fri, 10 Oct 2025
 00:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929165213.2896034-1-eperezma@redhat.com> <20250929165213.2896034-7-eperezma@redhat.com>
 <CACGkMEuRMXrt3zyQtrW8QvHJSVPqh5XGXtxBtir3UxGzjSmXOQ@mail.gmail.com>
In-Reply-To: <CACGkMEuRMXrt3zyQtrW8QvHJSVPqh5XGXtxBtir3UxGzjSmXOQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 Oct 2025 09:06:03 +0200
X-Gm-Features: AS18NWBLONCc_FbcAQRyNDKclrFzfavSvYt64l1dGovRosSfau7oYRhiOOj7tZ0
Message-ID: <CAJaqyWcSeNo-182zAQdjUxs+3LhBH+ype2NYNcFjiBEEjBeVXw@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zICd1Z9uaKL8eFgkq-wRA7vCEqZhL1KB9pyMdSofccU_1760080001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Sep 30, 2025 at 12:52=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v6:
> > * Make vdpa_dev_add use gotos for error handling (MST).
> > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?=
/
> >   (MST).
> > * Fix struct name not matching in the doc.
> >
> > v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
> > * Properly set domain bounce size to divide equally between nas (Jason)=
.
> > * Exclude "padding" member from the only >V1 members in
> >   vduse_dev_request.
> >
> > v4:
> > * Divide each domain bounce size between the device bounce size (Jason)=
.
> > * revert unneeded addr =3D NULL assignment (Jason)
> > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> >   return; } (Jason)
> > * Change a bad multiline comment, using @ caracter instead of * (Jason)=
.
> > * Consider config->nas =3D=3D 0 as a fail (Jason).
> >
> > v3:
> > * Get the vduse domain through the vduse_as in the map functions
> >   (Jason).
> > * Squash with the patch creating the vduse_as struct (Jason).
> > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> >   (Jason)
> >
> > v2:
> > * Convert the use of mutex to rwlock.
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> >   VDUSE_IOTLB_GET_INFO.
> > * Use of array_index_nospec in VDUSE device ioctls.
> > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > * Move the umem mutex to asid struct so there is no contention between
> >   ASIDs.
> >
> > RFC v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 347 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 290 insertions(+), 110 deletions(-)
> >
>
> [...]
>
> > @@ -2154,7 +2280,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                         const struct vdpa_dev_set_config *config)
> >  {
> >         struct vduse_dev *dev;
> > -       int ret;
> > +       size_t domain_bounce_size;
> > +       int ret, i;
> >
> >         mutex_lock(&vduse_lock);
> >         dev =3D vduse_find_dev(name);
> > @@ -2168,29 +2295,35 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1=
,
> > -                                                 dev->bounce_size);
> > -       write_unlock(&dev->domain_lock);
> > -       if (!dev->domain) {
> > -               ret =3D -ENOMEM;
> > -               goto domain_err;
> > +       ret =3D 0;
> > +
> > +       domain_bounce_size =3D dev->bounce_size / dev->nas;
>
> Could dev->nas be zero here?
>
> It looks like we only have the check like this:
>
>         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : confi=
g->nas;
>
> When API version >=3D 1, userspace could fill zero here.
>

It's protected in the change in vduse_validate_config of this patch:

-       if (api_version >=3D VDUSE_API_VERSION_1 &&
-           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
-               return false;
+       if (api_version >=3D VDUSE_API_VERSION_1) {
+               if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GRO=
UPS)
+                       return false;
+
+               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
+                       return false;
+       }

> > +       for (i =3D 0; i < dev->nas; ++i) {
> > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SI=
ZE - 1,
> > +                                                       domain_bounce_s=
ize);
> > +               if (!dev->as[i].domain) {
> > +                       ret =3D -ENOMEM;
> > +                       goto err;
> > +               }
> >         }
> >
> > +       write_unlock(&dev->domain_lock);
> > +
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> > -       if (ret) {
> > -               goto register_err;
> > -       }
> > +       if (ret)
> > +               goto err;
>
> We don't hold domain_lock here but err tries to unlock it.
>

Ouch, good point! fixing it, thanks!

> >
> >         return 0;
> >
> > -register_err:
> > -       write_lock(&dev->domain_lock);
> > -       vduse_domain_destroy(dev->domain);
> > -       dev->domain =3D NULL;
> > +err:
> > +       for (int j =3D 0; j < i; j++) {
> > +               if (dev->as[j].domain) {
> > +                       vduse_domain_destroy(dev->as[j].domain);
> > +                       dev->as[j].domain =3D NULL;
> > +               }
> > +       }
> >         write_unlock(&dev->domain_lock);
> >
>
> Thanks
>


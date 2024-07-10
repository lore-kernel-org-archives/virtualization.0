Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303E194C88
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635206; cv=none; b=JO6S+W5sGVxJVjlbTDdTqieIZbsfq72ypIJuPFswpHn0u8Zurk/UlzNAD4Uo53J0gy43J5ynYlmQA+/HcoJaM9bdVwonGLpekSkACzy0ggD5yVabPx/lSPudzgkczFFdeAEk/kYzW0FPbLV+jqVY6WraFekpvHcCy4l82zRRuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635206; c=relaxed/simple;
	bh=MowyvhNf6vGY6QkQdJz3UoNEMj0pRe3OT+CjdYCaGBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqAQiI+TCIAhuYaUCmXbX6zK6XvZYH+OeV8MyRLIfrBNj3xJn9pYdGxAzT/lj9Kzk7qrothr54P3UNUKSiVYI7XE8YTtpm2iLEkTr4JrjNu6ZL5vrw0RSVBCzsCJuLgsxUPQqTtP/axrGZKtHWN3bHOd1eRptohoC8FQyoF3sXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DE+4fy+O; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DE+4fy+O"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea79e689eso94001e87.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720635203; x=1721240003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=DE+4fy+OkL7NACA7wxmH40ZE5/3iEAPoUGsFSfmemTj6IWt4tDudNM/xH3Tb2RdbVw
         zI/Tsy26XEU4v6L9WDOnuAFSQk7IS9rJTaWnNRI+vFJ4pii+w6XzuvJTQ/ebeCNlwTKQ
         8uICwFCfc+GLyOzkx81R9Ux0qxeWabGny08jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635203; x=1721240003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=hFac5mw3pS7XsiCoHw94dCd7xX9A44NLE6EzsWizU/8nryICvkcRSOehqI0NWoFK+F
         /QmPkSU/AYq8d0+g3JMrJ7nOFhZVSN6xN636X6f2OkTfLR6eFpECeLvVL5PYMGb9UWXY
         MsNyQdBxUVV/97GmUV3TfyRTKwIuEiifoySE+yEQUNgVK8J3gLjOxeEqzzKbdkiZspSv
         fKvu8DuDhU0Jf58ZdySjUy3VRboe69JEf5wp2eEoU0ZeZ87JXe93DqXwBn8FLx7+oa7S
         pK2dmxVbByKyX+hLGlQ8Hdhchth/TTNjucvF22hWeyDGQ2vDW3qIeMLu+oI/2B9zpiRT
         dT9w==
X-Forwarded-Encrypted: i=1; AJvYcCVUFQ1ANT8ehYE/7gVQ1Evj/+VpUVrqYzqS7DeV725ArFcBvC8kpK3V6cj+wY8cHKJ7DfhbCl+93EHIdLGNJCzuOXu3KvNxxHLhM43pMTY=
X-Gm-Message-State: AOJu0YweUgEXmXLUJ1GbjIX4fM5PhkQslBbFTJ8LOx9wBWh6vt6RcCQZ
	y2GxhQJHQVqip7diOXxRCK8GQR3hq+euPetdfgfxLETSfbfGVC/QJtj9YDGLgju25rpMr/1UamB
	7Fg==
X-Google-Smtp-Source: AGHT+IH9SvbanSisq7fAEc2ycsYpf20kYGlGZA89qkO3XLFHv0msg8EZD4TstXdBeq3IkVZ4pNSokw==
X-Received: by 2002:a05:6512:239c:b0:52c:8b69:e039 with SMTP id 2adb3069b0e04-52eb9991e44mr6297119e87.4.1720635203020;
        Wed, 10 Jul 2024 11:13:23 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc721sm178003966b.53.2024.07.10.11.13.22
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:13:22 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367a3d1a378so4449658f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkOVW+y0yFNOWw0tB3TpT709S7jgTdDndgbgfNt52r9d0GJyLocTb0CIg1Xzqg74Xd3mAB9vUowRUUVjEZ2brQECnDLShUiLYsmisAgAk=
X-Received: by 2002:a05:6512:281d:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-52eb9991dcfmr5848110e87.14.1720635181335; Wed, 10 Jul 2024
 11:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 11:12:34 -0700
X-Gmail-Original-Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.

Thanks for fixing this - I think the overall approach of the patch looks go=
od.

> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.

In addition to virtio-balloon, I believe the same problem also affects
the virtio-fs device, since queue 1 is only supposed to be present if
VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
meant to be queue indexes 2 and up. From a look at the Linux driver
(virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
and assumes that request queues start at index 1 rather than 2, which
looks out of spec to me, but the current device implementations (that
I am aware of, anyway) are also broken in the same way, so it ends up
working today. Queue numbering in a spec-compliant device and the
current Linux driver would mismatch; what the driver considers to be
the first request queue (index 1) would be ignored by the device since
queue index 1 has no function if F_NOTIFICATION isn't negotiated.

[...]
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index 7d82facafd75..fa606e7321ad 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>         struct virtqueue_info *vqi;
>         u16 msix_vec;
> -       int i, err, nvectors, allocated_vectors, queue_idx =3D 0;
> +       int i, err, nvectors, allocated_vectors;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>                         msix_vec =3D allocated_vectors++;
>                 else
>                         msix_vec =3D VP_MSIX_VQ_VECTOR;
> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] =3D vp_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx, msix_vec);
>                 if (IS_ERR(vqs[i])) {
>                         err =3D PTR_ERR(vqs[i]);
> @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vde=
v, unsigned int nvqs,
>                             struct virtqueue_info vqs_info[])
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vd=
ev, unsigned int nvqs,
>                         vqs[i] =3D NULL;
>                         continue;
>                 }
> +<<<<<<< HEAD
>                 vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
>                                      vqi->name, vqi->ctx,
> +=3D=3D=3D=3D=3D=3D=3D
> +               vqs[i] =3D vp_setup_vq(vdev, i, callbacks[i], names[i],
> +                                    ctx ? ctx[i] : false,
> +>>>>>>> f814759f80b7... virtio: fix vq # for balloon

This still has merge markers in it.

Thanks,
-- Daniel

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF22EBB90
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464931; cv=none; b=l/RrNeLjJYDpetj/7mCl0ChuncsrjG7eonBtJ9IHS/zjXOep7EGKHTZSRu7WVVmEX0pbyisrRbS5rBIsVHf831TFRYF/kYbi820SLzx3MvO1K7Ft/SJV0JVFcfo1QG4A22vrqlCO8No2Y0pzF6bFSGhR9lKsk7NAN2T73JXU9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464931; c=relaxed/simple;
	bh=jt9lfgZcbwc7haKhCvTiBPqNRlKQCgPxSbaW/4cNkVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfNRKc2KMZAFYCqwC0qmRfnzXtRiNaIraX5bRMmnHlQmC9A8D9oq6+5s0R0faDO9v5Eoh5lZkRjzCCvma66okHkMQCWdeobNqGrkwRlSzNtdt15D3nuiC6LBE6hhgeDjkW51sWoeGtpGvUnVtK389xWXgulfXk1x7wShwh3D08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjU/7fdx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjU/7fdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768464929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hO+Ea9B8CWP9cByfRxwTLKNytVANT8OzclTqWlTYBc=;
	b=hjU/7fdxqWOyFRvFzthtbAWWlRJL0sp8guR3FvY5lyjLUvBOPtIQ9zrf4mSUIMDSiewuUX
	3Z1C+rJHdta2WpiSn32sdb9Tmdgqlss95wEQh/Ir4eZNDJbrdnRs0Rc7xZYGGqmO26ubrS
	Y1SOgnWWvYtT7GXdVZY6eLlJU+QSIIk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-qgJ399wuMaKZrCBfFviEnQ-1; Thu, 15 Jan 2026 03:15:28 -0500
X-MC-Unique: qgJ399wuMaKZrCBfFviEnQ-1
X-Mimecast-MFC-AGG-ID: qgJ399wuMaKZrCBfFviEnQ_1768464927
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a08cbeb87eso7104935ad.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464927; x=1769069727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hO+Ea9B8CWP9cByfRxwTLKNytVANT8OzclTqWlTYBc=;
        b=MkAMrblfMDPTUyMrvFxUdq+r8F6Fh19M4ZGuNeG9x8m0krY5/d8kFUUAIIiM7CS357
         pkvEF/8C/uLCqVewzgAG0gs+FtMMYHgMyOoF8DNZQ1/4abNLdUhVP/d89qp8I8Du1f8k
         9Tv+IsvYLVCnmZaiJsOKOqPvipmwg3coWIPZAEFVxrJygIQMS/9+SUh/5mxjRg5HoGYW
         zVhLpqzqz05iEcTl+JwGq+kuSg+68CKUNnqVMlhzeLb1XvKz2j7YVTAwd01Xg9R4Xq7K
         kyjc8xgaLKGDPzma4pSgjoGP1BvschvXiTEqJdOD7M3SDOaDi9TS1WdkQWEFdwA6Ou0U
         RHLA==
X-Forwarded-Encrypted: i=1; AJvYcCVxjuJxOOdSjXamI3VPfxo6OVS938roFEMU5gUbvwc65i8V7uQAM5f7Y5a0WP0I1JEZG4++iOCW63Ud4fQ8yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwNqQmanseniCgN1SFCRJuI5E1w5JxIJDm8+gBsegd/NZzOaZp
	LwvH04iHjrwKgdZK/sQinZAEs3O2lGwv4cPCsLlkjWnCAAxZyXIhX93SSxG0ro9GDm2qfn7PK6w
	8ZzuvU3XRdmG+IQxnw3BzM+hRUz6lcVG3CWhvL0ajRwULiUiQJR3R2qquwAa/57j069tUqhUEHo
	ET3gAhadpMNteRmdOqdzI8Xgi480MaAkwNWFydziQwVuI=
X-Gm-Gg: AY/fxX5kvNt3Z2UAloi3Np6MD4VgWc3dRIaMsWNwHjAwj5EmoH5uJMtuj5qwT3ekc+N
	efEO2CWhTsHcJkN43ovRf45CfBXDDQX3wbaL2hoee74NHZpau3zfjOBXdlgz75FetKbGtbmTmEO
	Er0uGQOGGaFe6iA1E218hUuMdizy8NfWCwi3Fng9W7LJrlCXatlMqZZ1TRmZ5/AFqLAj4=
X-Received: by 2002:a17:902:d4d0:b0:295:8a21:155a with SMTP id d9443c01a7336-2a599e34da4mr52752925ad.35.1768464926952;
        Thu, 15 Jan 2026 00:15:26 -0800 (PST)
X-Received: by 2002:a17:902:d4d0:b0:295:8a21:155a with SMTP id
 d9443c01a7336-2a599e34da4mr52752655ad.35.1768464926411; Thu, 15 Jan 2026
 00:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-14-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:15:13 +0800
X-Gm-Features: AZwV_Qi7ZKiEXNeas_vAPG6HkFMeQm18rx_zSkSffsklkzvlvz52Ksv-LMGYTZQ
Message-ID: <CACGkMEva=PPzqHBT4tXsPAjkYHnNO1vXYGE-3KxdTQJPVoeZKQ@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iFMhZK2C_pg1wlBsrFOUyGz0T1jDMfT92mTOdGjAJHk_1768464927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Address Space IDs allows the VDUSE framework to support devices able to
> expose different virtqueues to different part of the drivers.  For
> example, to let QEMU handle the net device control virtqueue, so QEMU
> always knows the state of the device like mac address or number of
> queues enabled, while leaving the dataplane passtrhough to the guest
> intact.  This enables live migration.
>
> Expands the VDUSE documentation to explain how to use the new ioctls or
> the new struct members of old ioctls.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v12: New in V12. Requested by Jason.
> ---
>  Documentation/userspace-api/vduse.rst | 49 +++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..66110d918815 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -230,4 +230,53 @@ able to start the dataplane processing as follows:
>  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_I=
RQ ioctl
>     after the used ring is filled.
>
> +Enabling ASID (API version 1)
> +------------------------------
> +
> +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> +version 1. Setup it with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/con=
trol` and
> +pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> +ioctl(VDUSE_CREATE_DEV).
> +
> +Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO) t=
o
> +select the address space of the IOTLB you are queryng. Similarly, you ca=
n use

Should be "querying"

> +ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an I=
OVA

Should we fail VDUSE_IOTLB_GET_FD on API version 1 or it is implied for ASI=
D 0?

> +region of an specific ASID. Example usage:
> +
> +.. code-block:: c
> +
> +       static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
> +                               uint64_t *len)
> +       {
> +               int fd;
> +               void *addr;
> +               size_t size;
> +               struct vduse_iotlb_entry_v2 entry =3D { 0 };
> +
> +               entry.v1.start =3D iova;
> +               entry.v1.last =3D iova;
> +               entry.asid =3D asid;
> +
> +               fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> +               if (fd < 0)
> +                       return NULL;
> +
> +               size =3D entry.v1.last - entry.v1.start + 1;
> +               *len =3D entry.v1.last - iova + 1;
> +               addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), MAP_S=
HARED,
> +                           fd, entry.v1.offset);
> +               close(fd);
> +               if (addr =3D=3D MAP_FAILED)
> +                       return NULL;
> +
> +               /*
> +                * Using some data structures such as linked list to stor=
e
> +                * the iotlb mapping. The munmap(2) should be called for =
the
> +                * cached mapping when the corresponding VDUSE_UPDATE_IOT=
LB
> +                * message is received or the device is reset.
> +                */
> +
> +               return addr + iova - entry.start;
> +       }
> +

It looks like we missed the documentation of VDUSE_SET_VQ_GROUP_ASID.

>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> --
> 2.52.0
>

Thanks


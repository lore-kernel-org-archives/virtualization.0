Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBF3254A8
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825644; cv=none; b=GSPcVTsIJA3ZpxB/BK6vASMrSyu1rMqTOmPUWqgD+FNRcCkaxMbO9NzhA9jdQepxPYnT1VQSiaKmlRpzhMtjPuQ/GDGP1MTKvki7HkgUCGNlp9gL41JMamPkdxGQfaPXi+5/IhcKnfsSIUFMx/sl7uXnkE3A5gSiGYwyFoob1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825644; c=relaxed/simple;
	bh=KoDiNaIzynAaRg6TgbZno1bBRgzrJr8GseyC5BPA/DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyeoZG4jWiwQfnm1lBPMj912ExPgU3rI/x6SR0+iBJxRNDQWNoYgVT2LPzzUZt0tBaPyaMB/OA1S9QxQpotltEProMx41Ebk6Bu3n5d6nMlofGQmVbEvMq2sdyC+W+czGO2EECsa6MD82N6J9jvoLwMFTAowVQi+ij/4C8UWZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRNUOeAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRNUOeAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768825638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJifwmw7Y/0YZkAQUm+uIRlf1mBDtu4TYZfZSmOx2gE=;
	b=DRNUOeAtLaYpY7DMVjv/Gz1DT3yx04+ggS1erFjbkloIdaiLVmLR6efCJqgjsTOhFhmRi0
	K74y2cWw2z7Wr/DM8s7rSi4kMNbwEJiPBu9qAKwcdDigADlnaRT/c/d8zL8Mng6MaNHqR5
	iyaFPEyS1ub7VgqgrQXjYcng4rjXeKM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-oWTKMym5PuiBoOti9jnwQg-1; Mon, 19 Jan 2026 07:27:17 -0500
X-MC-Unique: oWTKMym5PuiBoOti9jnwQg-1
X-Mimecast-MFC-AGG-ID: oWTKMym5PuiBoOti9jnwQg_1768825636
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f8c209cfbso1960904b3a.2
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 04:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768825636; x=1769430436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJifwmw7Y/0YZkAQUm+uIRlf1mBDtu4TYZfZSmOx2gE=;
        b=UHM1qAHD5oo9gxq9BEeDZ1oBElTI2Uz7kqu4eoFNsh3glgYBwyps7ojG5G7KU7ww5t
         2jztaUWLooZFyU3wj5aOUJrMk5Iq2vFKwO5FJE/EiQ+EaXJTP0XKRWcpwIp+heR2Ah4v
         H6GoaWtZM4ek0UnoHu0tRWqbxJtWitNTvMT0igCEB2II3UOZNWQsGzoj7OUvZe2AtVAE
         Ti8HOh1WPZCxi6DTYR6SaSDt4iCFPdWW5AZLLjGSHGIVk43XzRquSdd2LaNJJYWHR5IA
         mxwHTCOkFtygK2h4l0fazQQ9xazcP4C8/4pt6nDuJVgnnuX+fqMqkdkPuoSYAxU7Y7aO
         UA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWz9OetPhdtcv3RP4BSTpjyT+cjcGv5UakzZ4pdS3M7kIwodI1Pu9i9a6mpemLaOD7fCYLGAhXbEuuJGhxKBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4DsQ9gzveTxxLZwuytPVj65IC76WhXQgUupw/DkvSdcQoMNps
	m+OgGgg72HkRVfWG/rlsJ75j+omBgO70l9Vy7Jvop8MX62J06/CplM2GejsIQl2n1AYHkWP2SoP
	JjYpAzy8aN0dXu244WC7zYVQL/UDxKmMKMnmWN0WGJXP76SjMjdSasjGBfAm8f3oINLz+75uG0B
	A6ZHyKo9zicUxx25dY9txqcPbCbJDMavLkD3Q8uUP7N8w=
X-Gm-Gg: AY/fxX5q/e6qiCDvZkhKszrd9QVrCJHtrWLd9a9K52IccuGXzf0MSxFS+cHOuKURqOH
	TTDe514/NCmBZIUQRFtD/vmBslLRfqw2C1rsrXwxsZYi3SuHtvj2lRbLpqE/ewc2TvgM7/CfhwM
	yZcxHp8Sxpc6eNLhDYag8XoS6Dt7qPvLUjzkd5vqvy0qfTJ+oXjrU5SGF4GTDqomB3fw==
X-Received: by 2002:a05:6a21:339c:b0:35f:aa1b:bbff with SMTP id adf61e73a8af0-38dfe590741mr10608144637.11.1768825636199;
        Mon, 19 Jan 2026 04:27:16 -0800 (PST)
X-Received: by 2002:a05:6a21:339c:b0:35f:aa1b:bbff with SMTP id
 adf61e73a8af0-38dfe590741mr10608125637.11.1768825635757; Mon, 19 Jan 2026
 04:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-14-eperezma@redhat.com>
 <CACGkMEthnMXVYDEO+=XPumyWf9abN8bCLVQ42emYOWZQuDLG-w@mail.gmail.com> <CAJaqyWcMJ0mdwW9wwVZp2K5j2GA74w0P1atDpPG-PP8Dz7tsmg@mail.gmail.com>
In-Reply-To: <CAJaqyWcMJ0mdwW9wwVZp2K5j2GA74w0P1atDpPG-PP8Dz7tsmg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 20:27:03 +0800
X-Gm-Features: AZwV_Qjj2vQvQlahpF6ew1W7FjSjfTiMPmINjdoGWk_9659xDJB_HxHqPVOKCxM
Message-ID: <CACGkMEu09+AjRoKpGkF_QogkUdS_QZigKT-quHv3v16oqenmkg@mail.gmail.com>
Subject: Re: [PATCH v14 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5ccJXO78cRkxqucGJNfeVKh_RRLqH6bPKSSjDOPAqAU_1768825636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:40=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jan 19, 2026 at 8:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > >
> > > Address Space IDs allows the VDUSE framework to support devices able =
to
> > > expose different virtqueues to different part of the drivers.  For
> > > example, to let QEMU handle the net device control virtqueue, so QEMU
> > > always knows the state of the device like mac address or number of
> > > queues enabled, while leaving the dataplane passthrough to the guest
> > > intact.  This enables live migration.
> > >
> > > Expands the VDUSE documentation to explain how to use the new ioctls =
or
> > > the new struct members of old ioctls.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v13:
> > > * Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/.
> > > * Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
> > > * Fix typos (MST and Jason).
> > >
> > > v12: New in V12. Requested by Jason.
> > > ---
> > >  Documentation/userspace-api/vduse.rst | 53 +++++++++++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/us=
erspace-api/vduse.rst
> > > index bdb880e01132..aa067da92cf5 100644
> > > --- a/Documentation/userspace-api/vduse.rst
> > > +++ b/Documentation/userspace-api/vduse.rst
> > > @@ -230,4 +230,57 @@ able to start the dataplane processing as follow=
s:
> > >  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_=
VQ_IRQ ioctl
> > >     after the used ring is filled.
> > >
> > > +Enabling ASID (API version 1)
> > > +------------------------------
> > > +
> > > +VDUSE supports per-address-space identifiers (ASIDs) starting with A=
PI
> > > +version 1. Set it up with ioctl(VDUSE_SET_API_VERSION) on `/dev/vdus=
e/control`
> > > +and pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance =
with
> > > +ioctl(VDUSE_CREATE_DEV).
> > > +
> > > +Afterwards, you can use the member asid of ioctl(VDUSE_VQ_SETUP) arg=
ument to
> > > +select the address space of the IOTLB you are querying.  The driver =
could
> > > +change the address space of any virtqueue group by using the
> > > +VDUSE_SET_VQ_GROUP_ASID VDUSE message type, and the VDUSE instance n=
eeds to
> > > +reply with VDUSE_REQ_RESULT_OK if it was possible to change it.
> >
> > Nitpick: Is this better to move this to the part of
> >
> > "There are now three types of messages introduced by VDUSE framework:"
> >
> > ?
> >
>
> It makes more sense to add th ASID on top of the simple app example to
> me, so developers of simpler apps with no ASID don't need to mess with
> it.

That's fine.

> But I'm happy to move it if you want.
>

So

Acked-by: Jason Wang <jasowang@redhat.com>

> > > +
> > > +Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file=
 descriptor
> > > +describing an IOVA region of a specific ASID. Example usage:
> > > +
> > > +.. code-block:: c
> > > +
> > > +       static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t i=
ova,
> > > +                               uint64_t *len)
> > > +       {
> > > +               int fd;
> > > +               void *addr;
> > > +               size_t size;
> > > +               struct vduse_iotlb_entry_v2 entry =3D { 0 };
> > > +
> > > +               entry.v1.start =3D iova;
> > > +               entry.v1.last =3D iova;
> > > +               entry.asid =3D asid;
> > > +
> > > +               fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> > > +               if (fd < 0)
> > > +                       return NULL;
> > > +
> > > +               size =3D entry.v1.last - entry.v1.start + 1;
> > > +               *len =3D entry.v1.last - iova + 1;
> > > +               addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), M=
AP_SHARED,
> > > +                           fd, entry.v1.offset);
> > > +               close(fd);
> > > +               if (addr =3D=3D MAP_FAILED)
> > > +                       return NULL;
> > > +
> > > +               /*
> > > +                * Using some data structures such as linked list to =
store
> > > +                * the iotlb mapping. The munmap(2) should be called =
for the
> > > +                * cached mapping when the corresponding VDUSE_UPDATE=
_IOTLB
> > > +                * message is received or the device is reset.
> > > +                */
> > > +
> > > +               return addr + iova - entry.start;
> > > +       }
> > > +
> > >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > > --
> > > 2.52.0
> > >
> >
> > Thanks
> >
>

Thanks


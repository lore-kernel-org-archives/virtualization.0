Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F52EC0A3
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807474; cv=none; b=XNBJLlrgnSEktIwwyX7UxtRXo3O6I0a7rw37A+AQV/oCCH//0iI5ac9Ku8T0Wh5h0jdHVvmFZUjspFaRjCBZNvuJL0py4sm/Mwz+PuzfZq7IfHdkmFbu7TaXBMe4bpVnuUarYV8oCwLsrrZ4gNz63MUtERmjZZRsgWjMVf8HQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807474; c=relaxed/simple;
	bh=AAKCG+ftRxVHafGf7tQ9bKWECnMVnX9+l8IMup+ZEPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCK//pKb2kKOeetx7QVXTs1Rxiv24YvlYWyCaWAToU4HVLwkyCtZrH6XCvFInEbUNYXtBIbt60Ame3MiUl6qSki0rrKYA1CZ2H2mXYhO+6QZirSM6Zsjdk9XFvkEaa5VpgepyJKeRo1aEtoMmyIPWgp42x4vKWWPLET7DQuPgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPYwhhfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPYwhhfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768807472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxH9ul0xzvW8w54NeBjhhE58Y/7fvSEBuuaxH3AE9tE=;
	b=dPYwhhfjt3mvrJP4FLHnmc3IRgMlddMCQiOuyCXmdctilQMlkFdgLtjpOnIWW56aZqbRNG
	L4Wk3vjGhyrtwjUZm/rEE3TCgOuSDXxRsRlrcYmOU1+a4Qyti0AVZqsAIPLzNjJvS2BXLz
	IE/omD/1iisH84rlCEAX7TRan3m2qpE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-gqT6HlchOn2SLC_1bbzf9A-1; Mon, 19 Jan 2026 02:24:31 -0500
X-MC-Unique: gqT6HlchOn2SLC_1bbzf9A-1
X-Mimecast-MFC-AGG-ID: gqT6HlchOn2SLC_1bbzf9A_1768807471
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78d694a1eb2so40171457b3.0
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 23:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768807471; x=1769412271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxH9ul0xzvW8w54NeBjhhE58Y/7fvSEBuuaxH3AE9tE=;
        b=wYxq2qjGgNs+nysmx4Tn5o50QeuvICzSZYTL0uqbpaZCBUJXUo487hFjeKRvc5jRn1
         GgxCiM+zL0E/AQdPasYT44aEYUEwi+q1QkdWflNpFJtvG/So7BQCP2odZVH6dcaAYN3E
         CzanDLWAVM437LBlzwISzRzkCY7+mH0w9z2gQla/z2MQGmTc/U+5MEjz81L7wxv3qZRc
         dJ1dmkOE6GjEONBbj911tcfxGcOOnZpcmHvurpj1xQS6FdIen+RWcDJUIqcpWXq/t/Fk
         MASkwmK4EumWdwfMCiOa2LPtqVyD3yimrrRP6Ckzc9PlwziMP6GsNEqHMxCx7v0nUQdo
         oPow==
X-Forwarded-Encrypted: i=1; AJvYcCUEX/ipKxUm8PBxXZ7U2zvSj0lLu7oyiyftO7mm6JyaiaKaGbIoyojIZFtf32dyT5My1qLtcmHFLFl+ynMUKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtuTVqW3tT3dn6fo4deQEAGoWNih8N7lLqiA783pdjXb4iukS3
	9tY89uaDPclW9qBmV8/rs3uwAb1IbWf6nnSGmjGVDkaeuoTVaSS4wUQekYezii4VsY7xfBY/5GB
	swnFe0VjbGdtQnNzuuPFrP+BAKYh8XHEjhj/aV2b4EUrZrY9etczVX+H67eTmCWNqn6ufDXHmtT
	H96FDvVgScDSewwQge+hnYeUuen5BZ8ZRIbbAvlHFzOKo=
X-Gm-Gg: AZuq6aKG+i1LxuAVkeddSE1khoMmMtj5t5/SFnn0iRd/bnDLqCzxncx/L9mAASI4FZl
	Hm1ze1xKwkx2PG122Ai1+GLh/aOVEUqdr9BrKXf2BUMB/C2vSjprwTWapAXZwTpfsp3uLlEGxCt
	qEOylJkLYGheuDQ3qd9/KfcN2GjogTiVZxxuxta23HOv2wTcOo4nSIXTZH3+wNlaaz+w==
X-Received: by 2002:a05:690c:c4c9:b0:78e:1aa5:e98a with SMTP id 00721157ae682-793c5387778mr182981617b3.37.1768807470790;
        Sun, 18 Jan 2026 23:24:30 -0800 (PST)
X-Received: by 2002:a05:690c:c4c9:b0:78e:1aa5:e98a with SMTP id
 00721157ae682-793c5387778mr182981337b3.37.1768807470404; Sun, 18 Jan 2026
 23:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-14-eperezma@redhat.com>
 <85d3c2e7-3608-4a60-b088-912877ef2e65@oracle.com>
In-Reply-To: <85d3c2e7-3608-4a60-b088-912877ef2e65@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 19 Jan 2026 08:23:52 +0100
X-Gm-Features: AZwV_Qh0ApuFsjPLg9eguuEyfDkCoCWx4R12YTjmDmIDFXX9J8J-4yJcAKLDPFU
Message-ID: <CAJaqyWec525ydy7P4CZtXuSUSm4-uk4tueQFci6AXNuQJDO4fw@mail.gmail.com>
Subject: Re: [PATCH v14 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: puEpcgZKsf1O3N9-4G8TUOnUKB10iD22tpNg8AcxtA8_1768807471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 7:41=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 1/16/2026 7:34 PM, Eugenio P=C3=A9rez wrote:
> > Address Space IDs allows the VDUSE framework to support devices able to
> > expose different virtqueues to different part of the drivers.  For
> > example, to let QEMU handle the net device control virtqueue, so QEMU
> > always knows the state of the device like mac address or number of
> > queues enabled, while leaving the dataplane passthrough to the guest
> > intact.  This enables live migration.
> >
> > Expands the VDUSE documentation to explain how to use the new ioctls or
> > the new struct members of old ioctls.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v13:
> > * Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/.
> > * Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
> > * Fix typos (MST and Jason).
> >
> > v12: New in V12. Requested by Jason.
> > ---
> >   Documentation/userspace-api/vduse.rst | 53 ++++++++++++++++++++++++++=
+
> >   1 file changed, 53 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..aa067da92cf5 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -230,4 +230,57 @@ able to start the dataplane processing as follows:
> >   5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_V=
Q_IRQ ioctl
> >      after the used ring is filled.
> >
> > +Enabling ASID (API version 1)
> > +------------------------------
> > +
> > +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> > +version 1. Set it up with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/=
control`
> > +and pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance wi=
th
> > +ioctl(VDUSE_CREATE_DEV).
> > +
> > +Afterwards, you can use the member asid of ioctl(VDUSE_VQ_SETUP) argum=
ent to
> > +select the address space of the IOTLB you are querying.  The driver co=
uld
> > +change the address space of any virtqueue group by using the
> > +VDUSE_SET_VQ_GROUP_ASID VDUSE message type, and the VDUSE instance nee=
ds to
> > +reply with VDUSE_REQ_RESULT_OK if it was possible to change it.
> > +
> > +Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file d=
escriptor
> > +describing an IOVA region of a specific ASID. Example usage:
> > +
> > +.. code-block:: c
> > +
> > +     static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
> > +                             uint64_t *len)
> > +     {
> > +             int fd;
> > +             void *addr;
> > +             size_t size;
> > +             struct vduse_iotlb_entry_v2 entry =3D { 0 };
> > +
> > +             entry.v1.start =3D iova;
> > +             entry.v1.last =3D iova;
> > +             entry.asid =3D asid;
> > +
> > +             fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> > +             if (fd < 0)
> > +                     return NULL;
> > +
> > +             size =3D entry.v1.last - entry.v1.start + 1;
> > +             *len =3D entry.v1.last - iova + 1;
> > +             addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), MAP_S=
HARED,
> > +                         fd, entry.v1.offset);
> > +             close(fd);
> > +             if (addr =3D=3D MAP_FAILED)
> > +                     return NULL;
> > +
> > +             /*
> > +              * Using some data structures such as linked list to stor=
e
> > +              * the iotlb mapping. The munmap(2) should be called for =
the
> > +              * cached mapping when the corresponding VDUSE_UPDATE_IOT=
LB
> > +              * message is received or the device is reset.
> > +              */
> > +
> > +             return addr + iova - entry.start;
>
> typo entry.start; -> entry.v1.start;
>

Fixing in the next version, thanks!

> > +     }
> > +
> >   For more details on the uAPI, please see include/uapi/linux/vduse.h.
>
>
> Thanks,
> Alok
>


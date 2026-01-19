Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB373370E5
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808445; cv=none; b=QpwhIbHCH9b/5q3mds4+e4jQ4v8iLV23/+3gBnnrkp61fOIHslxYJ1wDgmzugP+fDuuJqBfraHXODWoGMmDbXxpVD7IUD47tBSaunE7LOBbX8YolK+38Wyd5KJOii/xRxT7/ZauXuZDSqrBolivivvNBHSC7kqAJFXZVT5ZNbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808445; c=relaxed/simple;
	bh=UgNhybkIdVw1fpPoimCsKGen1E89EcH0fdaPDRFzTB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9Let5idKm5Tz2eswN/HnCJLeZciwAr/xQ6dRZofwylytT3w56y9TR1BsSSaLaUmpi5gPTi43wkNAxyhxmq9BucDIe5R4qTGVgQxMUMjqJ+M48hOIFbwB5grBjNNp15ETif0DN15Y0+u/r0fzdmQ4iFjOZ3UT03GaPciYvR/v1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2LfSTJH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2LfSTJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768808442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq66EzhVFFiZgqsDWdbPjXm0kMYRPVto80HwLkpPNSA=;
	b=h2LfSTJHV3hwr90TZNF74a1f80iM7V3US44owJTm6MCnnZOO2i//quCye0qE4EQKJYrXhi
	3bRmkh5gQltiO+4ZnDkQCQUAv2kAiXUXuSJtCWTZdrOBqdZmcdD58ziBeimholFJ8aIQob
	xhSPRA6RlLGJnNURryC1x11PmS38VQ0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-JApBQX24N32zlXih3mP__w-1; Mon, 19 Jan 2026 02:40:41 -0500
X-MC-Unique: JApBQX24N32zlXih3mP__w-1
X-Mimecast-MFC-AGG-ID: JApBQX24N32zlXih3mP__w_1768808441
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900fc7033bso63629707b3.1
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 23:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808441; x=1769413241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nq66EzhVFFiZgqsDWdbPjXm0kMYRPVto80HwLkpPNSA=;
        b=MhR+pNLVQydRqAgadpG943BPlijNkgzkvByhn7VIbO3wjVF3HTKn3QLc9EGHw6tFvi
         9noOBEmra2m9dPUZbTBkbtEqcGWmsggjlMc5/1x8eXXY8Lsvycva7vREoq7VKy0aZSCv
         nb7Phy/FnGB+fXTtKB1sSIhSGSlB+hStj6JkPUdudAMvrBtfZ27MQP4SqEAIEgjt5ZxC
         SkJ/pPs4ZYVM9AIT7wIElhz7+OYN+K4gGQSspapeJA+TOYzlIUjw2EAwYWYph1cDvpOa
         zXk/v1LPYCEEfDysLX/JuoNqZ0Wd6ARL+815t6IyE8guLAmT8JeFRa3Masmtv3oOsHyd
         i1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXKVhQnGq5OyYsB7tpXc/TfXFAPLRe4Te40j2HbabaG56E9x8gWEtk2pP7u8CiP/iPulrYp5CUPrli34jwaoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQM4aFCViK1Q3UWtswAo4t+VKq7X1VSfbGxNOS+SicJqGKszZD
	QR0F5NtTQx+MRWm8pVD0xnNvCktebh440+PZOqm5adArD9Cbf/9jzpfafqemafPlkw6+ysPiwYc
	IAXJK/NSOGvRVe3rjhu8HuTfOIkzC98qIV+OAs9xXhfnirSU1eW+46Yc0srAQSlLUaFeOFApoHW
	hZODs4lQsPe4rZO2C16ZixouhyeL1CkXyRLXu4Iw0Jd9Y=
X-Gm-Gg: AZuq6aIZWQXVtcNyRAG//Tw8x0wKt3/CuQ0xyQRy6gb2h0+56NjJigtAP0GGLyakeV0
	d7jgemAY2aU5TJUIi7KxM2uiLk4ryAaloCVoT72FvcCQ4cXVPiDBetOJvR9oBVuKr5DVyY2Mw8r
	aa3RpLYlwknJgZEt78WpdcRWtWuYKEXrWOodp+VPxY+FmQSsVmT356iitqM4QwK6aJ/A==
X-Received: by 2002:a05:690c:7248:b0:790:456a:4735 with SMTP id 00721157ae682-793b355dd65mr101934557b3.29.1768808440779;
        Sun, 18 Jan 2026 23:40:40 -0800 (PST)
X-Received: by 2002:a05:690c:7248:b0:790:456a:4735 with SMTP id
 00721157ae682-793b355dd65mr101934507b3.29.1768808440403; Sun, 18 Jan 2026
 23:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-14-eperezma@redhat.com>
 <CACGkMEthnMXVYDEO+=XPumyWf9abN8bCLVQ42emYOWZQuDLG-w@mail.gmail.com>
In-Reply-To: <CACGkMEthnMXVYDEO+=XPumyWf9abN8bCLVQ42emYOWZQuDLG-w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 19 Jan 2026 08:40:04 +0100
X-Gm-Features: AZwV_QgMAFxDmtL3RxmklHM8Kxz8dSlzsnlOUYIYjAZ7k3It9iSGiz4RJZ_FFMs
Message-ID: <CAJaqyWcMJ0mdwW9wwVZp2K5j2GA74w0P1atDpPG-PP8Dz7tsmg@mail.gmail.com>
Subject: Re: [PATCH v14 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Chy0KVGapDWx5W7Am_ooi08_aifAWaI4IbRTFYyGXc_1768808441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 8:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
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
> >  Documentation/userspace-api/vduse.rst | 53 +++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..aa067da92cf5 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -230,4 +230,57 @@ able to start the dataplane processing as follows:
> >  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ=
_IRQ ioctl
> >     after the used ring is filled.
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
>
> Nitpick: Is this better to move this to the part of
>
> "There are now three types of messages introduced by VDUSE framework:"
>
> ?
>

It makes more sense to add th ASID on top of the simple app example to
me, so developers of simpler apps with no ASID don't need to mess with
it. But I'm happy to move it if you want.

> > +
> > +Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file d=
escriptor
> > +describing an IOVA region of a specific ASID. Example usage:
> > +
> > +.. code-block:: c
> > +
> > +       static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iov=
a,
> > +                               uint64_t *len)
> > +       {
> > +               int fd;
> > +               void *addr;
> > +               size_t size;
> > +               struct vduse_iotlb_entry_v2 entry =3D { 0 };
> > +
> > +               entry.v1.start =3D iova;
> > +               entry.v1.last =3D iova;
> > +               entry.asid =3D asid;
> > +
> > +               fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> > +               if (fd < 0)
> > +                       return NULL;
> > +
> > +               size =3D entry.v1.last - entry.v1.start + 1;
> > +               *len =3D entry.v1.last - iova + 1;
> > +               addr =3D mmap(0, size, perm_to_prot(entry.v1.perm), MAP=
_SHARED,
> > +                           fd, entry.v1.offset);
> > +               close(fd);
> > +               if (addr =3D=3D MAP_FAILED)
> > +                       return NULL;
> > +
> > +               /*
> > +                * Using some data structures such as linked list to st=
ore
> > +                * the iotlb mapping. The munmap(2) should be called fo=
r the
> > +                * cached mapping when the corresponding VDUSE_UPDATE_I=
OTLB
> > +                * message is received or the device is reset.
> > +                */
> > +
> > +               return addr + iova - entry.start;
> > +       }
> > +
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > --
> > 2.52.0
> >
>
> Thanks
>


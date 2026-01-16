Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21606376BCD
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562822; cv=none; b=G+iPdd254bZkrD/wbK9WGSl9AfhndAgTVIpIsyuGrkqmh4QUtlOJx8Qi0WY6IKlx3uV8kB7JE0NZVRB7L0ZpFsMNC/ee04UjFD9IqFFZyi1ogIqG68bmgTl4zQoscvbE16EISs0hXI9Q1+J4Qih4iRjkQ/T/MpuLZZCW4gCn62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562822; c=relaxed/simple;
	bh=lq08io6RtIZNooFyRXHNYNHRUX5ctxPHqm+qe2StU2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hm2oTsMY3gKo4VhJz5lxBSJbFgHRtVoIvMYqw69fyjxYDmPMXrtVryrFWBq4e6VlGWOleSxmXk+2Lq0EHh2KtMMm0qKCBx/5ZXHMtZ0rhiIy8u5uWQVb4umdFCr6H30QT1ebZrQlSg0Ix9rOHHlOxXUn7+rI1jUrgYIuwipPS1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgFAK/o2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgFAK/o2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768562815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08z9/aOOPsWGo83LxkVfxX4EvenPF0WUoTB6OwjKcHQ=;
	b=JgFAK/o2+kUtFLoOYljmNloN7p5DKPIa4H5NEhaN5J0On/GZ3Z8Dpvbq8QiwrzoyMUC4dU
	bFtGl8Qx3kn8J2ii4s2d2y9FCXy1XEzRpFpFDeeTrnJczJ8Loo93AJfpIyM/Pub8dEbEgn
	JVH37TNdV3375nWA4Zk5bVl/PUHfZjE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-UWRxJwBaOSKMuJ_Phx4oUA-1; Fri, 16 Jan 2026 06:26:54 -0500
X-MC-Unique: UWRxJwBaOSKMuJ_Phx4oUA-1
X-Mimecast-MFC-AGG-ID: UWRxJwBaOSKMuJ_Phx4oUA_1768562814
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-792766161bdso23007737b3.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 03:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562813; x=1769167613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08z9/aOOPsWGo83LxkVfxX4EvenPF0WUoTB6OwjKcHQ=;
        b=t8CM2KJCPafBOtU5W8xc2TBTadLegcfdQ3r1VOHHTN1A+ytbExSpu3j7getzGzFFk2
         SEvL3fe3Hj1rIMm5AaYGs/SBCK4dQlDO3Y+m6xOp3fx8vt2xbOjVUYRm6eJFGIE5xUZo
         4KXSPDIBndkimkLg9HLB5/DmzEzBOK41ZopIfzgxHPgRDN0SZR8MoBD/nKR7+dYVCrtd
         tk6D9Aqowi092zgWnmbOeNM53S2diNJW5KWx+zBerHi/HCJgER5C+iK+O30taleCh+Ng
         9dWkfg4NfD387mr11s5W9YPSqIyZOPADvh/qwHYhvXKyr0wNehxahA8xqvMdEWPzbWK1
         B8sA==
X-Forwarded-Encrypted: i=1; AJvYcCUfxH6kNmwb/UiJSgGpGu+tWhbYFuPmoGE8gJFXwsmFvJtgGhk8oivT7DVKcLX8Z2HMVtPnAeaRx1ZvonjSoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNOP5rcjAvZjKMCKpKkbs7y7oNrmTpcInoL5CwLobzVu1S5C+m
	DblBTU4sh2V5XtnxWubuZ1BxZHb4NRW0LluMC98D//C1Nz79QlkWep3QBnZ8ShfPrmlACWdnsfH
	NwTnAo4OkVX8JKShqFGqyT+mblFGFHnOKfGdk/uAGQFbBHTlHhZ+cFmNdksQMtH2IXd0aRqunXn
	lMpWp6gLByH3CJhLA0DV581t5kKSgXf54mEpaR+LjEkYo=
X-Gm-Gg: AY/fxX6Fc6atr+P7k3Mod6v+6TStATZC0RgbYlJC8oUiCLprZbnzT2rCxT6u1OGIl8t
	73HWRgHXWMbcwHBfOrFvZlK/JHttZHU9/VSO5kX7PE1bgC/CiJJqRc0uThflVpMKIVricQJZBWg
	F74UcwqdhzKP5KlGr8wTpnYQftwlYBkuXAU3RE3YwNQeApqwb0sUAkwcQAehZf3QD5mQ==
X-Received: by 2002:a05:690c:dc3:b0:78d:6657:fd01 with SMTP id 00721157ae682-793c66adafemr19134397b3.12.1768562813663;
        Fri, 16 Jan 2026 03:26:53 -0800 (PST)
X-Received: by 2002:a05:690c:dc3:b0:78d:6657:fd01 with SMTP id
 00721157ae682-793c66adafemr19134187b3.12.1768562813343; Fri, 16 Jan 2026
 03:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-14-eperezma@redhat.com>
 <CACGkMEva=PPzqHBT4tXsPAjkYHnNO1vXYGE-3KxdTQJPVoeZKQ@mail.gmail.com>
In-Reply-To: <CACGkMEva=PPzqHBT4tXsPAjkYHnNO1vXYGE-3KxdTQJPVoeZKQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 16 Jan 2026 12:26:17 +0100
X-Gm-Features: AZwV_Qh0inM-KNYXSa8mNaMqXTBvtuyZXc3Bb0_BJOes6ukbU1qwReMWxPKxtDY
Message-ID: <CAJaqyWfPYnshMoEhtJtzJM=7v7RqMEa1jmMWVJwYkxJ1KEnskw@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y_GIksQwIDezjVdHnjp7KE_svmsGssGw-UKKFIALOos_1768562814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:15=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Address Space IDs allows the VDUSE framework to support devices able to
> > expose different virtqueues to different part of the drivers.  For
> > example, to let QEMU handle the net device control virtqueue, so QEMU
> > always knows the state of the device like mac address or number of
> > queues enabled, while leaving the dataplane passtrhough to the guest
> > intact.  This enables live migration.
> >
> > Expands the VDUSE documentation to explain how to use the new ioctls or
> > the new struct members of old ioctls.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v12: New in V12. Requested by Jason.
> > ---
> >  Documentation/userspace-api/vduse.rst | 49 +++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..66110d918815 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -230,4 +230,53 @@ able to start the dataplane processing as follows:
> >  5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ=
_IRQ ioctl
> >     after the used ring is filled.
> >
> > +Enabling ASID (API version 1)
> > +------------------------------
> > +
> > +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> > +version 1. Setup it with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/c=
ontrol` and
> > +pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> > +ioctl(VDUSE_CREATE_DEV).
> > +
> > +Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO)=
 to
> > +select the address space of the IOTLB you are queryng. Similarly, you =
can use
>
> Should be "querying"
>

Right, fixing the typos for the next version, thanks!

> > +ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an=
 IOVA
>
> Should we fail VDUSE_IOTLB_GET_FD on API version 1 or it is implied for A=
SID 0?
>
> > +region of an specific ASID. Example usage:
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
>
> It looks like we missed the documentation of VDUSE_SET_VQ_GROUP_ASID.
>

Sure, adding it for the next version. Thanks!


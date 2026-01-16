Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2B374184
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562668; cv=none; b=VhEvK3yYBfIxP4k7pOI5/JBn2ngqn/PIc50PHDuHn+sm8M+Cc67Kh2WnOV2rm2t4cQrOki5SLw3EjQHxbdVkTXoiWnXJjGWP8PZb/DRmdx/I7ICabVG5hS20buA+OBfSioNgQ9YCHiX+lJbYTkhatVhsRXKVZbQN9tZ2LGYdn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562668; c=relaxed/simple;
	bh=JxFZk6Uz/WUXK5Yu8cPagZ1FCN/F6MGmLLWlH6ecufs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbns31u5XTyLXtKD7DKO1kSvCOwbmhqVoLZIcAegb3hI/X9HpqvaSoC+rlu/X/dqI+3zWIipvE5WjH1YEcTwRdWSjpe6ZRoAO1o9OEDxJBb8KL2a6hW/uHk5/KNkac4UDhKhRcc45ooSKz1iLh/2n2aC77Qg7LYKR5OZoqB1SGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1T8zpXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1T8zpXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768562662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcQTKz1QgKLq4+HA4lbmG4tZSfFrd69V/ny2x9EPW18=;
	b=N1T8zpXga6hpkJktxH7xAoLpLQ2pxrWh6t0Gkwi8tatdZ+AzZLCmUvtYQpdJYESqnFOHxK
	xK+zua675PMcCsSRFLh4ZNCGI5X/9eAuuIeGZ9xNXjFuYvTtLvx7JeKYWiOkSAT7g1kvB4
	FJlfxgwNmzl5p7x0NCflby0MeW8gaQ4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Rni2LOL9NYCTcR-QVlQBWw-1; Fri, 16 Jan 2026 06:24:19 -0500
X-MC-Unique: Rni2LOL9NYCTcR-QVlQBWw-1
X-Mimecast-MFC-AGG-ID: Rni2LOL9NYCTcR-QVlQBWw_1768562658
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-790afc07667so21539647b3.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 03:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562658; x=1769167458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcQTKz1QgKLq4+HA4lbmG4tZSfFrd69V/ny2x9EPW18=;
        b=oB0plUS9a7SQVBT38sZDXgdrN4OBCFWHbiszw9xt4jxNd4epvYs51NhZxk+IKUa4Sl
         iDSy+CRjX3RyGaApCfqYMsFQaBjm3I+c1M+YnEQchkFpP0Vfh75sLVr+bryln8YkQhMF
         7rNZ8jtNflPBNxg3mXD+O1YezJ/uukWqjFFPX7aJFshZCf1h3RezUqKJ+eWipAAXF3vA
         OA/s6kM0AU10PVXYepaziqdAsrPnPmQQvq86nvgjtYper5nNkF3u5dn7JseF1dB7UOlB
         ssn8ix+NIdz34APtOZdHUdORZgXRrvGpGQEEWvjAGoMA51xW/1i8NyZ6LCnirSgyiChN
         H9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8CyxhzwlqGGvgbaVdbFkU3CKVpv1xMMczKA2IYifJCUn6boIDaJLGY3nr2b01xfX3aiaiHihlCDAXDPKhnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh/wFlxYywTFUZD2WXLhRKuGtCeYkakCo6hAoFVGzKXIcUCjgd
	IUDdivbcrUWbRrXDR2MDPzxPXZagMT+nEjOThuTg/n4sRTEvNkkAHejM5hzgs9S617HAif2DGTi
	6yYla6vGXeBVhSvwRLUcM4Z90QA4BZQ/cTGFnozgZOl1dD8g8pG+BkmTGENHHT+D6msj1uF6qzM
	bQcz2zIAGwxRjzyWJG+34H51BbTCfNVdHAd54ASuVwQpk=
X-Gm-Gg: AY/fxX4EqzmmUBBFmv/AiLqdJCf2PLQ6h8WhXMUD1E8+uXelGf+od+DYUSmhRghseMY
	DLWWKSJAs40qOVl841zxN0ohRDDw2kCeJrK4LxJRvcXJyaL4J4//VFnjrWxszaG9wPSOpXoknSq
	Y0HX0ZZWrueMeVdosqnIsuNnniQyofms7DvmGIH1maVtZvjgPvoKk8FsGRWQ6RjksMSQ==
X-Received: by 2002:a05:690c:4d08:b0:78f:f32c:39e with SMTP id 00721157ae682-793c540b242mr22768517b3.67.1768562658409;
        Fri, 16 Jan 2026 03:24:18 -0800 (PST)
X-Received: by 2002:a05:690c:4d08:b0:78f:f32c:39e with SMTP id
 00721157ae682-793c540b242mr22768407b3.67.1768562658107; Fri, 16 Jan 2026
 03:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-14-eperezma@redhat.com>
 <20260115033239-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260115033239-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 16 Jan 2026 12:23:41 +0100
X-Gm-Features: AZwV_QhQcPquvIfN9kogWmx1ZUsTkf_8aq83KbLYzIKBmVsa_hiSaKDRfQD6Bjk
Message-ID: <CAJaqyWcz4+ixvUJ_brK5k4dRVdp9dHP-LT30hEc0mFNjQDRp4Q@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SFWrwGAlDJEgr0dEzdlQJgepwBULZWJs8z3FM8HqekA_1768562658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jan 14, 2026 at 07:48:39PM +0100, Eugenio P=C3=A9rez wrote:
> > Address Space IDs allows the VDUSE framework to support devices able to
> > expose different virtqueues to different part of the drivers.  For
> > example, to let QEMU handle the net device control virtqueue, so QEMU
> > always knows the state of the device like mac address or number of
> > queues enabled, while leaving the dataplane passtrhough to the guest
>
> passthrough
>
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
> > +version 1. Setup it
>
> Set it up
>
> > with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/control` and
> > +pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> > +ioctl(VDUSE_CREATE_DEV).
> > +
> > +Afterwards, you can use the member asid of ioctl(VDUSE_IOTLB_GET_INFO)=
 to
> > +select the address space of the IOTLB you are queryng.
>
> querying
>
> > Similarly, you can use
> > +ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor describing an=
 IOVA
> > +region of an specific ASID. Example usage:
>
> a specific
>
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
> > +     }
> > +
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.

Fixing typos for the next version, thanks!


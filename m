Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEC2010EE
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120881; cv=pass; b=qO90mpXwZQI0EQkK3vCiSjJwJxOVExm1gml1Ueot+n+TJ6hK9tdqxscu7Rk0jKyocyTc3EaA4sVrjYsGQzdYc8i9lBp9duxYWfszgzwaeNsICAe2EDAuB07IfprCcDQtJfSks8oWE6Q1XahvF/i5FZ3fU4vzsQGx40Zoy6hp7gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120881; c=relaxed/simple;
	bh=FhlvHsVJOcDEYCauTeZmuIUXi3nqjEsE8UdFdXCu1WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT1/JEaP7qRl699NBT2vfnG5i9hO+g/g5ETND+D/DMmoYzRTN9fdFwJLBDDWDBQa1/uu4HDXIKJoZEC0cxRinEA4nfSZHqtJjwvt5Fmvf6x96Mv3XXfBFZTVWJS5DAdXhmhESdcpvwHsEtbIOVGiioJ5SeP2sZexiIrin4SWae8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGjy1hqC; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGjy1hqC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-660d77cacc2so7541546a12.1
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 22:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773120878; cv=none;
        d=google.com; s=arc-20240605;
        b=gZJPrqFGPJdLT+s5xB8ZM2g5n/4aUzOzmEKwSOpjsj5Ocei/uUYV3ZqvhXABxzXz8r
         L5a+1Bn3ePyLzf2IoMK2djw6eze8ucMDusE8svtM9VpfmMNsRZ5RIDvNjIyiwMEvsKld
         5tb1etdSGb+w+RTnVuVzjjHLmOYvSg8X5lsknMhWMW+0VSQdsrZV5HL6qETdTK7W+ucp
         bhf7+oxSE6sAAHqDSbQoxMgatGzsoLkxi+zC3C2+qGTZ9oJnNLYZpJZpUPztktdhWbWc
         G5il5pFTs6+550eGjHpMqFt4uHr9Y+K/MBbRmvQtpLjPrSmsFwrNyvORB/OznTSS7ht+
         u02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/kw3z1PhJw4KrRW2p1O9UfcjujmqwTdriNPn/b3oYE=;
        fh=6Krri8xwEI48KyQISXrFLebISxwZTX9Giv6kjsfMMrA=;
        b=Dwovhgiva8Wgzmnv8eV2WxdCuPrUfQqerZ9yjE8CqWstO8Iws87XzOcNZIH+eXG7mi
         2+QMgjsfQWW9evqQqqODT4euQQqQn6nD7U2GEPKLAACD3hdswIa2vKCCz7uMCZOV+fx3
         28NZjrDMC6M+2G0gIqo6zNwC9gOsbvQ89Xe2MbkagG3Q3M07N/o6j3YNYodG5xV/aubB
         BRjZ/HhfzE8ZDDpodROVptZe+ydH+Busc439ua9HLIXSbRlPRe2JPafzz47h1ps1EsLf
         /xc3rAYHO7JQh8Ya5ayZANUsgL2MrtTfIWZbSLNdOKvqwaW+CcksdQdSP6QAkfp3kRB2
         CLrg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773120878; x=1773725678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/kw3z1PhJw4KrRW2p1O9UfcjujmqwTdriNPn/b3oYE=;
        b=mGjy1hqCYJHov5vX4vIT2j3ibjBBOCW6LaizCSTCS0yRJJ9XRhcl97+DuME7xB0MA3
         rgeSpEVXzXnFbricXfLV/VpB96AlxluEC9vV/gSiT174hlOeEl33Or+NDoNu79azBA5T
         oNsTLyiAUsncqBhpIWSLeNXkprLQBb+qr9HiOyfShXs9rhymOKwMOiJKqcDj64bJ8lEF
         cPhPsRZXakl1QHAnoM1QqW9AUXgQ15yRL72JEtikj3PN2oKxC8bZg3yu/N73OZoc74/F
         vWic1abcbzY9h8a3b3TlDT136MjNEjWHNsMaYMbtAsf/0urxyKtPaj/p3anXFg4R/dK7
         Ik0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773120878; x=1773725678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/kw3z1PhJw4KrRW2p1O9UfcjujmqwTdriNPn/b3oYE=;
        b=ePWuM99kD3VjJzNq0yAlxPnad8yZ0o6uqZKE8TVj5+LrD0IiHpNrRMUy9h1kyrE00p
         pNQoCZhnhsUV0S/tvo9py1xZcBqxcM3KH83lsObsCx+ALZeEr8NUjXD3cIwOJdUmz3dI
         0YS1zHWjHwVMILUOA/i8lJ+5QIxb5KqRtiPktSlfu5FREU1ZxCjGgqzo7fcaohZ1fm1O
         7k0jhIji60+u8EHTW7jIN2/x84Z8J8XY8QfPtxQNuQR1t/1iQjbKdpIYAHwQzMsB8tZn
         DTxQKjQDVFpPxJ31uztszaP3wAaylLE+xdc7EF61pB52I91Zp8qintBmr5AYYACQy1Vt
         8N+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSUS0aKl0hpsLCHDo+ujl31N6uC1HDk6xsNaipS4r/ya5XcUmsPFNRJKybKCkZ9xwtymbBTlpA0V0LjwHODw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXDhIep9zZzo1A8v61XNQjAv22BuwwAZrBsNHwT+AwTJAhD//4
	BN6zIGcsequotylM8P5HKIIioecV2OnAAmKrYc3eGeike6EIq/UM5JvqD3UuFzJFoNh17sNYYQl
	THwqeW27CRuNXqIlSGrlMFH26+NOth7w=
X-Gm-Gg: ATEYQzx5EE65fppNXOWKp6S8CREmwNGe9k1cTAlYpk+GDvbDFTafGjkEga2zEUI/J0I
	q1yA4s7lgseAKkNDCcq4N1JHggQuM3AgPoGb2o2R2F/u/Bh2KtLsLozwX9nOTixLHVKPAY9F7ij
	R3HX7SNCGDpLwz8WyH9Y+foXQyqSXeS/vItotHgAgjiE8vzK4ZjlHREP/mNw0cGKfEqO3nmLO/b
	eP1i1XAah71ASsBnqzdP62PTlof2MoQJoU/QjaZuuJJxQ8xvdS3lag6YEgVQ9X5o7FsL7yQW9On
	+yRZAToM
X-Received: by 2002:a05:6402:35c5:b0:658:bf9f:75be with SMTP id
 4fb4d7f45d1cf-662bab5c818mr1085630a12.16.1773120878189; Mon, 09 Mar 2026
 22:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309023353.652650-1-yui.washidu@gmail.com>
 <CACGkMEu+fd91yCwmSPNj0fTXw5v3ZON7F4kL_PVUz6TbG-iT4g@mail.gmail.com>
 <d6161d2e-066e-4d85-bc5a-0129a5f116b8@gmail.com> <CACGkMEvQfQn-BwUA2LcJ1mQuqyLpVNF8xyJ7VxsxnU-duNRA5Q@mail.gmail.com>
In-Reply-To: <CACGkMEvQfQn-BwUA2LcJ1mQuqyLpVNF8xyJ7VxsxnU-duNRA5Q@mail.gmail.com>
From: Washizu Yui <yui.washidu@gmail.com>
Date: Tue, 10 Mar 2026 14:34:25 +0900
X-Gm-Features: AaiRm51DX5HfrVSI0YoRvi7imaRYAzDTiymUiN_rc3XnDxz2NXTQij26uFivBb4
Message-ID: <CAM8iNRoBQ117EhyPH=nCuAOXtrr7VOBzD2mqZ25UNb-DFmx6NQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: add num_vf callback to virtio_bus
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B43=E6=9C=8810=E6=97=A5(=E7=81=AB) 12:02 Jason Wang <jasowang@re=
dhat.com>:
>
> On Mon, Mar 9, 2026 at 2:19=E2=80=AFPM Yui Washizu <yui.washidu@gmail.com=
> wrote:
> >
> >
> > On 3/9/2026 12:33 PM, Jason Wang wrote:
> > > On Mon, Mar 9, 2026 at 10:37=E2=80=AFAM Yui Washizu <yui.washidu@gmai=
l.com> wrote:
> > >> Recent QEMU versions added support for virtio SR-IOV emulation,
> > >> allowing virtio devices to expose SR-IOV VFs to the guest.
> > >> However, virtio_bus does not implement the num_vf callback of bus_ty=
pe,
> > >> causing dev_num_vf() to return 0 for virtio devices even when
> > >> SR-IOV VFs are active.
> > >>
> > >> net/core/rtnetlink.c calls dev_num_vf(dev->dev.parent) to populate
> > >> IFLA_NUM_VF and IFLA_VFINFO_LIST
> > > Patch looks good but,
> > >
> > > If I understand correctly, ndo_get_vf_config is needed for
> > > IFLA_VFINFO_LIST but not implemeted in this patch?
> >
> > Thank you for your comment.
> >
> > I submitted this patch because I confirmed
> > that "ip link show" returns the correct VF IDs with this implementation=
.
> >
> > In the current implementation,
> > I believe there is no information that would need to be referenced
> > through IFLA_VFINFO_LIST.
> > Therefore, I did not include ndo_get_vf_config in this patch,
> > as it did not seem essential at this stage.
> >
> > Would it be better to implement IFLA_VFINFO_LIST support together with =
this?
>
> Then it's not, I think it's better to not mention IFLA_VFINFO_LIST in
> the commit log as it may confuse people.
>
> Thanks
>

Thank you.
I'll update the commit message to remove the reference to IFLA_VFINFO_LIST
and send a v2.
Regards,

>
> >
> > Regards,
> >
> >
> > >> in RTM_GETLINK responses.  For a
> > >> virtio-net device, dev.parent points to the virtio_device, whose bus
> > >> is virtio_bus.  Without num_vf, SR-IOV VF information is silently
> > >> omitted from tools that rely on rtnetlink, such as 'ip link show'.
> > >>
> > >> Add a num_vf callback that delegates to dev_num_vf(dev->parent),
> > >> which in turn reaches the underlying transport (pci_bus_type for
> > >> virtio-pci) where the actual VF count is tracked.  Non-PCI transport=
s
> > >> are unaffected as dev_num_vf() returns 0 when no num_vf callback is
> > >> present.
> > >>
> > >> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> > >> ---
> > >>   drivers/virtio/virtio.c | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > >> index 5bdc6b82b30b..299fa83be1d5 100644
> > >> --- a/drivers/virtio/virtio.c
> > >> +++ b/drivers/virtio/virtio.c
> > >> @@ -435,6 +435,14 @@ static void virtio_dev_shutdown(struct device *=
_d)
> > >>          dev->config->reset(dev);
> > >>   }
> > >>
> > >> +static int virtio_dev_num_vf(struct device *dev)
> > >> +{
> > >> +       struct virtio_device *vdev =3D dev_to_virtio(dev);
> > >> +
> > >> +       return dev_num_vf(vdev->dev.parent);
> > >> +}
> > >> +
> > >> +
> > >>   static const struct bus_type virtio_bus =3D {
> > >>          .name  =3D "virtio",
> > >>          .match =3D virtio_dev_match,
> > >> @@ -444,6 +452,7 @@ static const struct bus_type virtio_bus =3D {
> > >>          .remove =3D virtio_dev_remove,
> > >>          .irq_get_affinity =3D virtio_irq_get_affinity,
> > >>          .shutdown =3D virtio_dev_shutdown,
> > >> +       .num_vf =3D virtio_dev_num_vf,
> > >>   };
> > >>
> > >>   int __register_virtio_driver(struct virtio_driver *driver, struct =
module *owner)
> > >> --
> > >> 2.47.3
> > >>
> > > Thanks
> > >
> >
>

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20023B3C13
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578037; cv=pass; b=DVrik+zlqnMWfFMGqz8W/cApdECRcuJ3Idq2DFO3ALnQGD4fEeOuIXbgcZuwFAaG0jJbWr1+lRfOlaF3TOivhVOCArjefvJFDmMi9Skyum3r1zRQYuqA35uhEjqJ6xSJb6SxIevV4fw7YkQhHUcDhtKPYOQL2gUSbnTchoZuESo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578037; c=relaxed/simple;
	bh=SqL3degzZLHUkXp9EwtnnbweSN4ovzuW0PiF1qi0rCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEMThbH+fiXvN1hNT5ZM8LZldxP2GQ9jNY/kSVh4AL5mu8B3yKZqV6M0RahGHvu3V/QHVOSlecak2Za9I8kjPHXWNhuRSA6EzSaysDcxQxL6BhkayW1zHQCPUmjn1q/IhjSfJ9+zVuf1mLNiFp4HGJdoCRrbl2Q8UD3vQi7TkBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRZjHhAn; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRZjHhAn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacef7d299so411865ad.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 13:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784578035; cv=none;
        d=google.com; s=arc-20260327;
        b=kpdKIfxPXYZ7XaxiVVEJrqIalN/jlLPKJ2wCSJwv5swvVXhOT8ECp8zFtmfvwrqfKX
         9o+g+Je82YEKwvEgk3J3FgUlNmfS1jm3I1MiVNxeL736mKNKXnno98FFYXbgoSrc/0XJ
         tUFfh/uTeAZLirReIpkFecWkV0Ixh2rBOIIVvTdhQpX4ks4m6Cgqh3XYG++SvaGrEnG2
         1jZZ4op1NQzny9IyznGC17x8A47eqXqKbhWskqRJo/C7sYxn2noE+55K7rXgqbGmhhwo
         777Nj9DSDNB86f5sWRv6Rl6/XdbhT4BLA51NvFGBTfUvRp9OZqGZx1xlPOo30b89Z2fZ
         nWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/ClODyeOdd7PaXyNWgToVcSHxDJZKiN7tuU3APQ5w0=;
        fh=9SnZ92WJgW44G2dQ5g6dpKELGj/S6oaoW9WgyWnfLz4=;
        b=QNw2hZgRMGgI/XOe+3qAgifHAbPdCGbpfrGweAgYFZwWvkjonYOShTxibyUl88QOMs
         UTIf0GwKHgMm5FqoeeljLPTfJQ3ejFybyCK0fR+3A1bgCTdSUPUI4QBLBOUwS/JZVjLi
         o/Y4LQXNYnO9SOl8HE9pFjInhu9oi16kwkDsMRq5c6OMEAhxF1ANXsSeOi35nV8wJctD
         rEhAD3TachWNeAZz8quOu8uB+b2f2aXf/dDUXceJcO/szlxvB1T7cQbFf8Kvj/YUw7Ss
         vdg0FJN113Dr2VUznyFghfPhBTexHIututFOR8M+5Il3fnnjXhaLlgJ0fglc05+51GoD
         DbIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784578035; x=1785182835; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/ClODyeOdd7PaXyNWgToVcSHxDJZKiN7tuU3APQ5w0=;
        b=LRZjHhAnvCoSbIK/qx7Lsw/jk6cUTuUrsLws4DxLs8Tb4lffE4ht7TYWk55ws82TFJ
         M3GwwroW6+lYx2fybANFkUkxKcWY9qaZGCZJ0kxT1Z9AY96HW0dyK7U+n6FlN2UlwBF/
         U6p8uER00B6Bvd7/l4LtrLwQjIRGjndjo3J04Gn+kPlsgCiz6QHIk0nAsvbOD6K5H9Tg
         ubOnOOhrIlSC8O1w5j3Kgg9w+kiP+CUBoeqez4uR+YO4B1+755ka5hGLHYTKnW1SzPui
         yx5k6Nfk5j7uiEOlL9samOdI84BVleqrkeui3TT4c1x0pWCt7NSGDt+T/uiLliBMkLyb
         mgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578035; x=1785182835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/ClODyeOdd7PaXyNWgToVcSHxDJZKiN7tuU3APQ5w0=;
        b=So+uezdkPg4HabUBBgfAGryO4b0IHv9D0lpzqLx8fraj25Kmm2HVIg0rK6JoE8aEtK
         bibSzKvm2bkI2HqrvZqK0GF/0nugCKbDejj0A3gRYwZjLMtNgvPvmfs4XXTpxUiTVJA+
         jvOwdTDMG7YJ6icXwmt3Y+aIYshBCcqY6hznV05i0yqnXT5MVUUvmqXW9FOcfXlt7fds
         n0eFk1cz9rsuyse8idGx1DZdmEFklgUUTnYKIg/ZBAkkKJESxIos8aX570KHCuVg6pR4
         qG6qrJjKUXBbvDMnKUcV9bGaDGeYzisObHjW03Abr2BcubrMIxU++l2aME9mqUDoL47h
         nb1w==
X-Forwarded-Encrypted: i=1; AHgh+RqZN2xdH7tJrIu3aM5Z45D2K/TcvVkkc9JsmnxSKwJBeuOLwQ29Y38oUL+fFHgYzDt7oRIHmlK2VqNRSd2lvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfqcD+Cp+ga4EMx4gt1ifKOx8H+62i+M0LvC56BDnv5/irAdjL
	odokKOXJdw2Do0ssyMackQy1J0US45nFuabZDQgvoplNM2tnBHK5tf63hqfcNXOaS3FHwAWh/iP
	vysYVfUhWb+kFHg6gtk1+K/KNT8HiftiHNr9yD9M=
X-Gm-Gg: AR+sD11wX/o2vSRbP8PvC4i0jODuFoqx4YOIdKzY9Vf3Ib0dL64ZzF9rIEmptC6YWMB
	w3i8uJRTBZ930pwfNBpjkeBcn3cMr+RjAJmsetyoSt1R7kFzwxa0m4/WhiHP4kRRO21AAB3Hw1D
	VylPyfvWw/h0pLULZnmPb2qkWUERzRUfymg6IAmfPY4sCXw3X4Nh+QWUh4bnPZuMQIarWKsX30T
	f7v/4R5O38QiU7HwtZELlgbMb4Bv0ll9Zbi479F4L036yq6eYixI2oZIXvblYNuVBrWUJE=
X-Received: by 2002:a17:903:41ce:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2cf7b68e33amr2522855ad.18.1784578034191; Mon, 20 Jul 2026
 13:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-2-briandaniels@google.com> <20260712092836.488acb8d@foz.lan>
In-Reply-To: <20260712092836.488acb8d@foz.lan>
From: Brian Daniels <briandaniels@google.com>
Date: Mon, 20 Jul 2026 16:07:02 -0400
X-Gm-Features: AUfX_myO5O3VrBnnpTc_5BC1JAiM2Vdq0nne5eHsfXFhzb508mfxB2BxpRGJ62Q
Message-ID: <CAD4i_GSDAF8o+ky6ddd5tig+icT3GaVruPUFMVUNpoOdRraK+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] media: virtio: Add protocol
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 3:28=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On Mon, 22 Jun 2026 16:43:36 -0400
> Brian Daniels <briandaniels@google.com> wrote:
>
> > From: Alexandre Courbot <gnurou@gmail.com>
> >
> > Add the identifiers and structs used to implement the virtio interface
> > as described in section 5.22 of version 1.4 of the virtio spec:
> >
> > https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cspr=
d01-diff-from-v1.2-cs01.html#x1-82200022
> >
> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > ---
> >  drivers/media/virtio/protocol.h | 287 ++++++++++++++++++++++++++++++++
> >  1 file changed, 287 insertions(+)
> >  create mode 100644 drivers/media/virtio/protocol.h
> >
> > diff --git a/drivers/media/virtio/protocol.h b/drivers/media/virtio/pro=
tocol.h
> > new file mode 100644
> > index 000000000..5878d107c
> > --- /dev/null
> > +++ b/drivers/media/virtio/protocol.h
> > @@ -0,0 +1,287 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> > +
> > +/*
> > + * Definitions of virtio-media protocol structures.
> > + *
> > + * Copyright (c) 2024-2025 Google LLC.
> > + */
> > +
> > +#ifndef __VIRTIO_MEDIA_PROTOCOL_H
> > +#define __VIRTIO_MEDIA_PROTOCOL_H
> > +
> > +#include <linux/videodev2.h>
> > +#include <linux/bits.h>
> > +
> > +/*
> > + * Virtio protocol definition.
> > + */
> > +
> > +/**
> > + * struct virtio_media_cmd_header - Header for all virtio-media comman=
ds.
> > + * @cmd: one of VIRTIO_MEDIA_CMD_*.
> > + * @__reserved: must be set to zero by the driver.
> > + *
> > + * This header starts all commands from the driver to the device on th=
e
> > + * commandq.
> > + */
> > +struct virtio_media_cmd_header {
> > +     u32 cmd;
> > +     u32 __reserved;
> > +};
> > +
> > +/**
> > + * struct virtio_media_resp_header - Header for all virtio-media respo=
nses.
> > + * @status: 0 if the command was successful, or one of the standard Li=
nux error
> > + * codes.
> > + * @__reserved: must be set to zero by the device.
> > + *
> > + * This header starts all responses from the device to the driver on t=
he
> > + * commandq.
> > + */
> > +struct virtio_media_resp_header {
> > +     u32 status;
> > +     u32 __reserved;
> > +};
> > +
> > +/**
> > + * VIRTIO_MEDIA_CMD_OPEN - Command for creating a new session.
> > + *
> > + * This is the equivalent of calling `open` on a V4L2 device node. Upo=
n
> > + * success, a session id is returned which can be used to perform othe=
r
> > + * commands on the session, notably ioctls.
> > + */
> > +#define VIRTIO_MEDIA_CMD_OPEN 1
> > +
> > +/**
> > + * struct virtio_media_cmd_open - Driver command for VIRTIO_MEDIA_CMD_=
OPEN.
> > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_OPEN.
> > + */
> > +struct virtio_media_cmd_open {
> > +     struct virtio_media_cmd_header hdr;
> > +};
> > +
> > +/**
> > + * struct virtio_media_resp_open - Device response for VIRTIO_MEDIA_CM=
D_OPEN.
> > + * @hdr: header containing the status of the command.
> > + * @session_id: if hdr.status =3D=3D 0, contains the id of the newly c=
reated
> > + *              session.
> > + * @__reserved: must be set to zero by the device.
> > + */
> > +struct virtio_media_resp_open {
> > +     struct virtio_media_resp_header hdr;
> > +     u32 session_id;
> > +     u32 __reserved;
> > +};
> > +
> > +/**
> > + * VIRTIO_MEDIA_CMD_CLOSE - Command for closing an active session.
> > + *
> > + * This is the equivalent of calling `close` on a previously opened V4=
L2
> > + * session. All resources associated with this session will be freed a=
nd the
> > + * session ID shall not be used again after queueing this command.
> > + *
> > + * This command does not require a response from the device.
> > + */
> > +#define VIRTIO_MEDIA_CMD_CLOSE 2
> > +
> > +/**
> > + * struct virtio_media_cmd_close - Driver command for VIRTIO_MEDIA_CMD=
_CLOSE.
> > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_CLOSE.
> > + * @session_id: id of the session to close.
> > + * @__reserved: must be set to zero by the driver.
> > + */
> > +struct virtio_media_cmd_close {
> > +     struct virtio_media_cmd_header hdr;
> > +     u32 session_id;
> > +     u32 __reserved;
> > +};
> > +
> > +/**
> > + * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioctl.
> > + *
> > + * This command asks the device to run one of the `VIDIOC_*` ioctls on=
 the
> > + * active session.
> > + *
> > + * The code of the ioctl is extracted from the VIDIOC_* definitions in
> > + * `videodev2.h`, and consists of the second argument of the `_IO*` ma=
cro.
> > + *
> > + * Each ioctl has a payload, which is defined by the third argument of=
 the
> > + * `_IO*` macro defining it. It can be writable by the driver (`_IOW`)=
, the
> > + * device (`_IOR`), or both (`_IOWR`).
> > + *
> > + * If an ioctl is writable by the driver, it must be followed by a
> > + * driver-writable descriptor containing the payload.
> > + *
> > + * If an ioctl is writable by the device, it must be followed by a
> > + * device-writable descriptor of the size of the payload that the devi=
ce will
> > + * write into.
> > + *
> > + */
> > +#define VIRTIO_MEDIA_CMD_IOCTL 3
> > +
> > +/**
> > + * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MEDIA_CMD=
_IOCTL.
> > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
> > + * @session_id: id of the session to run the ioctl on.
> > + * @code: code of the ioctl to run.
> > + */
> > +struct virtio_media_cmd_ioctl {
> > +     struct virtio_media_cmd_header hdr;
> > +     u32 session_id;
> > +     u32 code;
> > +};
> > +
> > +/**
> > + * struct virtio_media_resp_ioctl - Device response for VIRTIO_MEDIA_C=
MD_IOCTL.
> > + * @hdr: header containing the status of the ioctl.
> > + */
> > +struct virtio_media_resp_ioctl {
> > +     struct virtio_media_resp_header hdr;
> > +};
> > +
> > +/**
> > + * struct virtio_media_sg_entry - Description of part of a scattered g=
uest
> > + *                                memory.
> > + * @start: start guest address of the memory segment.
> > + * @len: length of this memory segment.
> > + * @__reserved: must be set to zero by the driver.
> > + */
> > +struct virtio_media_sg_entry {
> > +     u64 start;
> > +     u32 len;
> > +     u32 __reserved;
> > +};
> > +
> > +#define VIRTIO_MEDIA_MMAP_FLAG_RW BIT(0)
> > +
> > +/**
> > + * VIRTIO_MEDIA_CMD_MMAP - Command for mapping a MMAP buffer into the =
driver's
> > + * address space.
> > + *
> > + */
> > +#define VIRTIO_MEDIA_CMD_MMAP 4
> > +
> > +/**
> > + * struct virtio_media_cmd_mmap - Driver command for VIRTIO_MEDIA_CMD_=
MMAP.
> > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MMAP.
> > + * @session_id: ID of the session we are mapping for.
> > + * @flags: combination of VIRTIO_MEDIA_MMAP_FLAG_*.
> > + * @offset: mem_offset field of the plane to map, as returned by
> > + *          VIDIOC_QUERYBUF.
> > + */
> > +struct virtio_media_cmd_mmap {
> > +     struct virtio_media_cmd_header hdr;
> > +     u32 session_id;
> > +     u32 flags;
> > +     u32 offset;
> > +};
> > +
> > +/**
> > + * struct virtio_media_resp_mmap - Device response for VIRTIO_MEDIA_CM=
D_MMAP.
> > + * @hdr: header containing the status of the command.
> > + * @driver_addr: offset into SHM region 0 of the start of the mapping.
> > + * @len: length of the mapping.
> > + */
> > +struct virtio_media_resp_mmap {
> > +     struct virtio_media_resp_header hdr;
> > +     u64 driver_addr;
> > +     u64 len;
> > +};
> > +
> > +/**
> > + * VIRTIO_MEDIA_CMD_MUNMAP - Unmap a MMAP buffer previously mapped usi=
ng
> > + * VIRTIO_MEDIA_CMD_MMAP.
> > + */
> > +#define VIRTIO_MEDIA_CMD_MUNMAP 5
> > +
> > +/**
> > + * struct virtio_media_cmd_munmap - Driver command for VIRTIO_MEDIA_CM=
D_MUNMAP.
> > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MUNMAP.
> > + * @driver_addr: offset into SHM region 0 at which the buffer has been
> > + *               previously
> > + * mapped.
> > + */
> > +struct virtio_media_cmd_munmap {
> > +     struct virtio_media_cmd_header hdr;
> > +     u64 driver_addr;
> > +};
> > +
> > +/**
> > + * struct virtio_media_resp_munmap - Device response for
> > + *                                   VIRTIO_MEDIA_CMD_MUNMAP.
> > + * @hdr: header containing the status of the command.
> > + */
> > +struct virtio_media_resp_munmap {
> > +     struct virtio_media_resp_header hdr;
> > +};
> > +
> > +/* The values for these events are set by the virtio-media specificati=
on. */
> > +#define VIRTIO_MEDIA_EVT_ERROR 0
> > +#define VIRTIO_MEDIA_EVT_DQBUF 1
> > +#define VIRTIO_MEDIA_EVT_EVENT 2
>
> As I mentioned on v3, media also has events. Some userspace apps may
> need them to do some optimizations related to buffer sync, source
> changes, motion detection and such. See the specs:
>
>         https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/=
vidioc-dqevent.html#event-type
>         https://linuxtv.org/downloads/v4l-dvb-apis-new/driver-api/v4l2-ev=
ent.html
>
> As the virtio driver may end needing such events in the future,
> it needs to start numbering its private events after:
>
>         #define V4L2_EVENT_PRIVATE_START                0x08000000
>
> which is where driver-specific events should be placed.

The VIRTIO_MEDIA_EVT_* event IDs are supposed to be seperate from the
V4L2_EVENT_* event IDs. The virtio events are for the private use of
the virtio driver and are never directly exposed to the V4L2 framework
or the user. They're events for the VIRTIO transport.
The VIRTIO_MEDIA_EVT_EVENT is used to pass through the V4L2 events
(shown in section 5.22.6.2.4 of the virtio spec
[https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01=
-diff-from-v1.2-cs01.html#x1-8620004]).
As an example, here's the virtio message for passing through a
V4L2_EVENT_VSYNC event:

  struct virtio_media_event_event {
      struct virtio_media_event_header hdr; // hdr.event =3D
VIRTIO_MEDIA_EVT_EVENT
      struct v4l2_event event; // event.type =3D V4L2_EVENT_VSYNC
  };

The virtio-media driver currently doesn't send events to the V4L2
framework unless they were sent to it by the host device (through
VIRTIO_MEDIA_EVT_EVENT). However, if this changes in the future, I
anticipate we would have a function that mapped the virtio events to
the v4l2 events if that were necessary.

Does that make sense to you? Or perhaps I'm misunderstanding?

> Thanks,
> Mauro

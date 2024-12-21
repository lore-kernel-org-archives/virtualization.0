Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177A2746C
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734788673; cv=none; b=XQcwUQPx1Bpr4M4urZXhsZxAK8A6if9bdmckZZETCMI2NVovxsNTSG1Kpb5m9jiH+P247HmanuvJzYJ937BoOIywJbHrv5ApehVSUbV8t7UzDp6m2bL+aMPYFyA/N4dj2BO/iZ8Wdh2jdKrZVy4Ya4KRR4vOQOZiaLhRCB0o7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734788673; c=relaxed/simple;
	bh=OQ6QttGCSCApWYKs+bCj1/JANk/Wx2jm6FDFViclKy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc9rP+nrK9Q297O+ksY5kU0XDs3EiQPv6yHBXUq1g9iIoazhxKb1pxSqzKC3c3nx8+PM3k2TeLm6ye916xrR4J6zvIjbOH21v/Znkh8xOmqQ7a3XymDtr1OKn5G1GpYBFeBsqVe3BMLCGasksHkwVg3spomX9zKGXr+5DT32OJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3FbAspk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3FbAspk"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7feb6871730so1832455a12.2
        for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734788667; x=1735393467; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PegK4f9v8Jt41DnTc7gioTp+3B/rfF+vaQMT/KbNcLc=;
        b=X3FbAspktRJ8VAoR+AxQRoWonoihQNgXiOZmpYIuXrdEcZC+oHNzFTThYl8nEv2mCP
         DBvmG7ANh36MNaGkF8Zsqy9X/u5h7TCkRqwI4YPzAs8ZigH1WjqI9fwMBnObAPHgzF81
         IgUKFikVCxaNvY72AiksdA3sxhpDo5p0j7T45MzEDDTwUbhqWcDpYXNGFa/cSG+4G0y6
         R1J7L92ahJW3yCKtrZI5l/D4sN3igb0JoKIm0zbI5geRM2qSYvS3doJUxxNOKjU9K7pc
         UDUDZO42ZezYDltvKK163zjQuBEDscIxw5+xVtdsxOx/gWGwHsViwaj59fIW9nGKi4tB
         cYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734788667; x=1735393467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PegK4f9v8Jt41DnTc7gioTp+3B/rfF+vaQMT/KbNcLc=;
        b=EWwz/PjZ7YCsDEyPeaysTEp2mwwRPZYk4qwBmL3pkSyO7Zl/r6+qSiDqP5kiOItNWz
         Hkd7DDvihnG6NeEQE0MPuLNaCshZ0SkU45s268XRTJL0n/vx1Vp5opomoOsIymiJIdiR
         EBDbbDUU2iIriCZNddxwOFQYBdJ/AX4GT3wJmyc7W1sWnKZsuffpB9Va4vloAr3Ubu/h
         cJa0FlEMppLlG7rWD218bni5ntNUGgmBS5nbLQXHFyAHITDnEwub5CqZfxwiQeU3Uobp
         poxOPfs0wsqGhG6oitY0Vz8BpMcKRuyujMg8ofM6mDS3n9TUP65SzRs9g4PSWawGDxh1
         OEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9c6Rb55ntNYXEGxGE4gvArQdiU6HQAx4ynUo6TwIGUDAK0mUVoyvfonJuSoulb8cYIyTK3F9uSlNjQaucHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwepgAiRLVJPLojI2OTRDY5GBaTlZfSjSGhwAU9gRVDwcDp6Stq
	Ai4eBI3nF3Ll2HzGV76D/4aWOm7QChM1CAtvF7P2vNRuzUSpV4FkoTcSVPSx7jlXeGNZhiOrq2X
	PmlYZIgRyuj9dboqxCjBsaZPrcLo=
X-Gm-Gg: ASbGncvuZMf0PQa9Pbp0wTAkmohoipnxzeiWBfJM+GhWefvNyZFnX+6i+IHpMl7s4Dk
	ZA8xijRjWpuHCuNX89y9n06rkIcOIG9eLWlNALAM=
X-Google-Smtp-Source: AGHT+IEMIt+tLWQDkssdkfdpzmwzJRke6FzI942btSHBUVmgwXWz0VJwWUFTwEQ77PuALCryubFAqfiYnf+CiiicrWU=
X-Received: by 2002:a17:90a:da8e:b0:2ee:bf84:4fe8 with SMTP id
 98e67ed59e1d1-2f452ec6ee0mr10285397a91.30.1734788666693; Sat, 21 Dec 2024
 05:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
 <20241204153811.126028-2-t.ampelikiotis@virtualopensystems.com>
 <CAJSP0QW4oJGYDSLVFoeR741jVvFNS_AapFR710e5jwJ+vWHH9A@mail.gmail.com> <CANN35wK00GEOEeHbvx5wd+ZaNxN4vD7gSb8YT=mPs9CZ0rR7nw@mail.gmail.com>
In-Reply-To: <CANN35wK00GEOEeHbvx5wd+ZaNxN4vD7gSb8YT=mPs9CZ0rR7nw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 21 Dec 2024 08:44:07 -0500
Message-ID: <CAJSP0QXdvWWnp-61WMeWTLnDLPWiZVqvg3Nsc3zqLuEDkxARFw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 1/1] VirtIO: Add platform bus driver for
 loopback virtio device
To: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
Cc: virtio-dev@lists.oasis-open.org, anna@virtualopensystems.com, 
	a.rigo@virtualopensystems.com, m.paolino@virtualopensystems.com, 
	s.raho@virtualopensystems.com, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, jsmoeller@linuxfoundation.org, 
	virtualization@lists.linux.dev, stefanha@redhat.com, 
	xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2024 at 10:56, Timos Ampelikiotis
<t.ampelikiotis@virtualopensystems.com> wrote:
>
>
>
> On Wed, Dec 4, 2024 at 7:18=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>>
>> On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> wro=
te:
>> >
>> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> >
>> > This commit, is based on virtio MMIO driver, adds support
>> > for dynamic allocated (platform) virtio devices. This
>> > allows applications running in native environments to use
>> > virtio drivers as a HAL and eventually communicate with
>> > user-space drivers (implementing the vhost-user protocol).
>> >
>> > Signed-off-by: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.c=
om>
>> > ---
>> >  MAINTAINERS                                |  10 +
>> >  drivers/virtio/Kconfig                     |  20 +
>> >  drivers/virtio/Makefile                    |   2 +
>> >  drivers/virtio/virtio_loopback.c           | 780 +++++++++++++++++
>> >  drivers/virtio/virtio_loopback_transport.c | 924 ++++++++++++++++++++=
+
>> >  include/uapi/linux/virtio_loopback.h       | 259 ++++++
>> >  6 files changed, 1995 insertions(+)
>> >  create mode 100644 drivers/virtio/virtio_loopback.c
>> >  create mode 100644 drivers/virtio/virtio_loopback_transport.c
>> >  create mode 100644 include/uapi/linux/virtio_loopback.h
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 1e930c7a58b1..2d6a17357ea0 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -24765,6 +24765,16 @@ F:     include/uapi/linux/virtio_vsock.h
>> >  F:     net/vmw_vsock/virtio_transport.c
>> >  F:     net/vmw_vsock/virtio_transport_common.c
>> >
>> > +VIRTIO LOOPBACK TRANSPORT DRIVER
>> > +M:     Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> > +M:     Anna Panagopoulou <anna@virtualopensystems.com>
>> > +M:     Alvise Rigo <a.rigo@virtualopensystems.com>
>> > +L:     virtualization@lists.linux.dev
>> > +S:     Maintained
>> > +F:     driver/virtio/virtio_loopback.c
>> > +F:     driver/virtio/virtio_loopback_transport.c
>> > +F:     include/uapi/linux/virtio_loopback.h
>> > +
>> >  VIRTIO BALLOON
>> >  M:     "Michael S. Tsirkin" <mst@redhat.com>
>> >  M:     David Hildenbrand <david@redhat.com>
>> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> > index 2eb747311bfd..da147c93a094 100644
>> > --- a/drivers/virtio/Kconfig
>> > +++ b/drivers/virtio/Kconfig
>> > @@ -160,6 +160,26 @@ config VIRTIO_MMIO
>> >
>> >          If unsure, say N.
>> >
>> > +config VIRTIO_LOOPBACK
>> > +       tristate "Platform bus driver for virtio loopback devices"
>> > +       depends on HAS_IOMEM && HAS_DMA
>> > +       select VIRTIO
>> > +       help
>> > +         This driver provides support for a virtio loopback platform =
device
>> > +         driver.
>> > +
>> > +         The virtio loopback driver allows virtio devices to be used =
in a
>> > +         non-virtualized environment, coupled with vhost-user device =
(user-
>> > +         space drivers). It is used for testing or for environments w=
here a
>> > +         loopback communication mechanism is needed to facilitate dat=
a
>> > +         exchange between virtual devices on the same host.
>> > +
>> > +         Select Y here if you want to enable the virtio loopback driv=
er
>> > +         for testing or development purposes. This driver is typicall=
y
>> > +         not recommended for production systems.
>> > +
>> > +         If unsure, say N.
>> > +
>> >  config VIRTIO_MMIO_CMDLINE_DEVICES
>> >         bool "Memory mapped virtio devices parameter parsing"
>> >         depends on VIRTIO_MMIO
>> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>> > index 58b2b0489fc9..662fbe8fb00a 100644
>> > --- a/drivers/virtio/Makefile
>> > +++ b/drivers/virtio/Makefile
>> > @@ -14,3 +14,5 @@ obj-$(CONFIG_VIRTIO_VDPA) +=3D virtio_vdpa.o
>> >  obj-$(CONFIG_VIRTIO_MEM) +=3D virtio_mem.o
>> >  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) +=3D virtio_dma_buf.o
>> >  obj-$(CONFIG_VIRTIO_DEBUG) +=3D virtio_debug.o
>> > +obj-$(CONFIG_VIRTIO_LOOPBACK) +=3D virtio_loopback_dev.o
>> > +virtio_loopback_dev-objs :=3D virtio_loopback.o virtio_loopback_trans=
port.o
>> > diff --git a/drivers/virtio/virtio_loopback.c b/drivers/virtio/virtio_=
loopback.c
>> > new file mode 100644
>> > index 000000000000..a3013f0e1109
>> > --- /dev/null
>> > +++ b/drivers/virtio/virtio_loopback.c
>> > @@ -0,0 +1,780 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +/*
>> > + * Virtio loopback device driver
>> > + *
>> > + * Copyright 2022-2024 Virtual Open Systems SAS
>> > + *
>> > + * Authors:
>> > + *  Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> > + *  Anna Panagopoulou <anna@virtualopensystems.com>
>> > + *  Alvise Rigo <a.rigo@virtualopensystems.com>
>> > + *
>> > + * This module allows virtio devices to be used in a non-virtualized
>> > + * environment, coupled with vhost-user device (user-space drivers).
>> > + *
>> > + * This module is responsible to assign the virtio-loopback transport=
 driver
>> > + * to a group of virtio drivers in order to be able to share notifica=
tions and
>> > + * the vrings (without copies) with the corresponding vhost-user devi=
ces in
>> > + * the user-space.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modi=
fy
>> > + * it under the terms of the GNU General Public License as published =
by
>> > + * the Free Software Foundation; either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>> > +
>> > +#define pr_fmt(fmt) "virtio-loopback: " fmt
>> > +
>> > +/* Loopback header file */
>> > +#include <uapi/linux/virtio_loopback.h>
>> > +
>> > +/* Features */
>> > +MODULE_LICENSE("GPL");
>> > +
>> > +/* The global data for the loopback */
>> > +static struct loopback_device_data loopback_data;
>> > +static struct loopback_devices_array loopback_devices;
>> > +
>> > +/*
>> > + * This function registers all mmap calls done by the user-space into=
 an array
>> > + */
>> > +static void add_share_mmap(struct file *filp, uint64_t pfn,
>> > +                          uint64_t vm_start, uint64_t size)
>> > +{
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(filp->private_data);
>> > +       struct mmap_data *mm_data =3D (struct mmap_data *)file_data->m=
m_data;
>> > +
>> > +       mm_data->share_mmap_list[mm_data->mmap_index].pfn =3D pfn;
>> > +       mm_data->share_mmap_list[mm_data->mmap_index].vm_start =3D vm_=
start;
>> > +       mm_data->share_mmap_list[mm_data->mmap_index].size =3D size;
>> > +       mm_data->share_mmap_list[mm_data->mmap_index].uid =3D
>> > +               task_pid_nr(current);
>> > +       mm_data->mmap_index++;
>> > +}
>> > +
>> > +/*
>> > + * This function removes a record from mmap array
>> > + */
>> > +static void share_mmap_rem(struct vm_area_struct *vma)
>> > +{
>> > +       struct file *file =3D vma->vm_file;
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(file->private_data);
>> > +       struct mmap_data *mm_data =3D (struct mmap_data *)file_data->m=
m_data;
>> > +       int i;
>> > +
>> > +       for (i =3D 0; i < MMAP_LIMIT; i++) {
>> > +               if (mm_data->share_mmap_list[i].vm_start =3D=3D vma->v=
m_start) {
>> > +                       mm_data->share_mmap_list[i].uid =3D 0;
>> > +                       mm_data->share_mmap_list[i].pfn =3D 0;
>> > +                       mm_data->share_mmap_list[i].vm_start =3D 0;
>> > +                       mm_data->share_mmap_list[i].size =3D 0;
>> > +               }
>> > +       }
>> > +}
>> > +
>> > +static void print_mmap_idx(struct mmap_data *mm_data, int i)
>> > +{
>> > +       pr_debug("share_mmap_list[%d].uid %x\n", i,
>> > +                mm_data->share_mmap_list[i].uid);
>> > +       pr_debug("share_mmap_list[%d].pfn %llx\n", i,
>> > +                mm_data->share_mmap_list[i].pfn);
>> > +       pr_debug("share_mmap_list[%d].vm_start %llx\n", i,
>> > +                mm_data->share_mmap_list[i].vm_start);
>> > +       pr_debug("share_mmap_list[%d].size %x\n", i,
>> > +                mm_data->share_mmap_list[i].size);
>> > +}
>> > +
>> > +/**
>> > + * print_mmaps - Debug function to print details of all active mmap e=
ntries
>> > + * @mm_data: Pointer to the mmap_data structure containing mmap detai=
ls
>> > + *
>> > + * This function iterates through the `share_mmap_list` array in the =
given
>> > + * `mm_data` structure and logs the details of each active mmap entry=
 by
>> > + * calling `print_mmap_idx`. The number of entries printed is determi=
ned as:
>> > + * - `MMAP_LIMIT` if `mmap_index` is `0`.
>> > + * - The value of `mmap_index` otherwise.
>> > + *
>> > + * Note:
>> > + * - The function uses `pr_debug` for logging, so enable debugging to=
 see
>> > + *   the output.
>> > + * - Ensure that `mm_data` is properly initialized before calling thi=
s
>> > + *   function to avoid accessing invalid memory.
>> > + */
>> > +
>> > +static void print_mmaps(struct mmap_data *mm_data)
>> > +{
>> > +       int i, limit =3D
>> > +               mm_data->mmap_index =3D=3D 0 ? MMAP_LIMIT : mm_data->m=
map_index;
>> > +
>> > +       for (i =3D 0; i < limit; i++)
>> > +               print_mmap_idx(mm_data, i);
>> > +}
>> > +
>> > +/**
>> > + * share_mmap_exist_vma_return_correct_pfn - Calculate corrected PFN =
for a
>> > + * given address.
>> > + * @mm_data: Pointer to struct containing memory mapping data
>> > + * @addr: Address for which to calculate the corrected PFN
>> > + *
>> > + * This function iterates through the list of shared memory mappings =
in
>> > + * `mm_data` and checks if the given `addr` lies within any of the ma=
ppings.
>> > + * If it does, it computes the corrected PFN based on the mapping's s=
tart
>> > + * address, size, and PFN.
>> > + *
>> > + * Returns:
>> > + * - The corrected PFN if the address falls within a mapping.
>> > + * - 0 if the address does not match any mapping.
>> > + */
>> > +static uint64_t share_mmap_exist_vma_return_correct_pfn(
>> > +                                       struct mmap_data *mm_data,
>> > +                                       uint64_t addr)
>> > +{
>> > +       int i;
>> > +       uint64_t corrected_pfn;
>> > +
>> > +       for (i =3D 0; i < MMAP_LIMIT; i++) {
>> > +               if ((mm_data->share_mmap_list[i].vm_start <=3D addr) &=
&
>> > +                   (addr < mm_data->share_mmap_list[i].vm_start +
>> > +                   mm_data->share_mmap_list[i].size)) {
>> > +                       corrected_pfn =3D ((addr -
>> > +                                         mm_data->share_mmap_list[i].=
vm_start)
>> > +                                        / PAGE_SIZE)
>> > +                                       + mm_data->share_mmap_list[i].=
pfn;
>> > +                       return corrected_pfn;
>> > +               }
>> > +       }
>> > +       return 0;
>> > +}
>> > +
>> > +/**
>> > + * pf_mmap_fault - Handle page faults for the device mmap area
>> > + * @vmf: Pointer to the `vm_fault` structure containing fault informa=
tion
>> > + *
>> > + * This function is called during a page fault to find and insert the=
 correct
>> > + * page for the faulting address. It calculates the corrected PFN usi=
ng the
>> > + * provided mmap data of the device and updates the faulting page.
>> > + *
>> > + * Returns:
>> > + * - 0 if successful.
>> > + * - `VM_FAULT_SIGBUS` on failure.
>> > + */
>> > +static vm_fault_t pf_mmap_fault(struct vm_fault *vmf)
>> > +{
>> > +       uint64_t corrected_pfn;
>> > +       pfn_t corr_pfn_struct;
>> > +       struct page *page;
>> > +
>> > +       struct file *file =3D vmf->vma->vm_file;
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(file->private_data);
>> > +       struct mmap_data *mm_data =3D
>> > +               (struct mmap_data *)file_data->mm_data;
>> > +
>> > +       /* Count the total number of page_faults for debugging purpose=
 */
>> > +       mm_data->sum_pgfaults++;
>> > +
>> > +       /* Find the corrected pfn */
>> > +       corrected_pfn =3D share_mmap_exist_vma_return_correct_pfn(mm_d=
ata,
>> > +                                                               vmf->a=
ddress);
>> > +       corr_pfn_struct.val =3D corrected_pfn;
>> > +
>> > +       /* Ensure the PFN is valid */
>> > +       if (unlikely(!pfn_valid(corrected_pfn))) {
>> > +               pr_err("Invalid PFN: %llu\n", corrected_pfn);
>> > +               return VM_FAULT_SIGBUS;
>> > +       }
>> > +
>> > +       /* After finding the page, correct the vmf->page */
>> > +       page =3D pfn_to_page(corrected_pfn);
>> > +       if (unlikely(!virt_addr_valid(page_address(page)))) {
>> > +               pr_err("Invalid page address for PFN: %llu\n", correct=
ed_pfn);
>> > +               return VM_FAULT_SIGBUS;
>> > +       }
>> > +
>> > +       /* Insert the correct page */
>> > +       return vmf_insert_pfn(vmf->vma, vmf->address, corrected_pfn);
>> > +}
>> > +
>> > +static void pf_mmap_close(struct vm_area_struct *vma)
>> > +{
>> > +       share_mmap_rem(vma);
>> > +}
>> > +
>> > +const struct vm_operations_struct pf_mmap_ops =3D {
>> > +       .close =3D pf_mmap_close,
>> > +       .fault =3D pf_mmap_fault,
>> > +};
>> > +
>> > +/**
>> > + * pf_mmap_vm_page - Set up memory mapping for a file
>> > + * @filp: Pointer to the file structure for the mapping
>> > + * @vma: Pointer to the VM area structure representing the memory map=
ping
>> > + *
>> > + * This function sets up a user-space area by associating a physical =
frame
>> > + * number (PFN) with the virtual address range. It updates internal d=
ata
>> > + * structures to track the mapping and sets appropriate VM flags.
>> > + *
>> > + * Returns:
>> > + * - 0 on success.
>> > + * - Negative error code on failure.
>> > + */
>> > +static int pf_mmap_vm_page(struct file *filp, struct vm_area_struct *=
vma)
>> > +{
>> > +       uint64_t size =3D (unsigned long)(vma->vm_end - vma->vm_start)=
;
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(filp->private_data);
>> > +       struct mmap_data *mm_data =3D (struct mmap_data *)file_data->m=
m_data;
>> > +       uint64_t pfn =3D ((mm_data->cur_ram_idx++) * (size >> PAGE_SHI=
FT));
>> > +
>> > +       vm_flags_set(vma, VM_PFNMAP);
>> > +       add_share_mmap(filp, pfn, vma->vm_start, size);
>> > +       return 0;
>> > +}
>> > +
>> > +/**
>> > + * mmap_vqs_com_struct - Map virtqueue or communication structure to =
user space
>> > + * @filp: Pointer to the file structure associated with the mapping
>> > + * @vma: Pointer to the VM area structure describing the memory regio=
n
>> > + *
>> > + * This function maps either the virtqueue data or the communication =
structure
>> > + * to the user space using `remap_pfn_range`. The choice of what to m=
ap depends
>> > + * on the `share_communication_struct` flag in the mmap data structur=
e.
>> > + *
>> > + * Returns:
>> > + * - 0 on success.
>> > + * - Negative error code on failure.
>> > + */
>> > +static int mmap_vqs_com_struct(struct file *filp, struct vm_area_stru=
ct *vma)
>> > +{
>> > +       int ret =3D 0;
>> > +       unsigned long size =3D (unsigned long)(vma->vm_end - vma->vm_s=
tart);
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(filp->private_data);
>> > +       struct device_data *dev_data =3D
>> > +               (struct device_data *)file_data->dev_data;
>> > +       struct mmap_data *mmap_data =3D (struct mmap_data *)file_data-=
>mm_data;
>> > +       struct mmap_info *com_mmap_virt =3D
>> > +               (struct mmap_info *)(file_data->dev_data->info)->data;
>> > +       uint64_t com_mmap_pfn =3D
>> > +               ((uint64_t)virt_to_phys(com_mmap_virt)) >> PAGE_SHIFT;
>> > +       uint64_t starting_pfn;
>> > +
>> > +       if (mmap_data->share_communication_struct) {
>> > +               vm_flags_set(vma, VM_RESERVED);
>> > +               mmap_data->share_communication_struct =3D false;
>> > +               starting_pfn =3D com_mmap_pfn;
>> > +       } else {
>> > +               mmap_data->share_vqs =3D false;
>> > +               starting_pfn =3D dev_data->vq_data.vq_pfn;
>> > +       }
>> > +
>> > +       ret =3D remap_pfn_range(vma, vma->vm_start, starting_pfn, size=
,
>> > +                             vma->vm_page_prot);
>> > +       if (ret !=3D 0) {
>> > +               pr_err("Mmap error\n");
>> > +               print_mmaps(mmap_data);
>> > +       } else {
>> > +               add_share_mmap(filp, starting_pfn, vma->vm_start, size=
);
>> > +       }
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +/**
>> > + * op_mmap - Map vring buffers, virtqueue or communication structure
>> > + *           to user space.
>> > + * @filp: Pointer to the file structure associated with the mapping
>> > + * @vma: Pointer to the VM area structure describing the memory regio=
n
>> > + *
>> > + * This function checks if the incoming mmap sys_call is related to a=
) vrings
>> > + * or b) virtqueues / communication structure data (depending on
>> > + * `share_communication_struct` and `share_vqs` variables. Then calls
>> > + * `mmap_vqs_com_struct` and `pf_mmap_vm_page` correspondingly in ord=
er
>> > + * to apply a different mapping logic.
>> > + *
>> > + * Returns:
>> > + * - 0 on success.
>> > + * - Negative error code on failure.
>> > + */
>> > +static int op_mmap(struct file *filp, struct vm_area_struct *vma)
>> > +{
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(filp->private_data);
>> > +       struct mmap_data *mmap_data =3D (struct mmap_data *)file_data-=
>mm_data;
>> > +       int ret =3D 0;
>> > +
>> > +       vma->vm_ops =3D &pf_mmap_ops;
>> > +
>> > +       if (mmap_data->share_communication_struct || mmap_data->share_=
vqs)
>> > +               ret =3D mmap_vqs_com_struct(filp, vma);
>> > +       else
>> > +               ret =3D pf_mmap_vm_page(filp, vma);
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +static ssize_t loopback_write(struct file *file,
>> > +                             const char __user *user_buffer,
>> > +                             size_t size,
>> > +                             loff_t *offset)
>> > +{
>> > +       ssize_t len =3D sizeof(int);
>> > +
>> > +       if (len <=3D 0)
>> > +               return 0;
>> > +
>> > +       return len;
>> > +}
>> > +
>> > +static ssize_t loopback_read(struct file *file,
>> > +                            char __user *user_buffer,
>> > +                            size_t size, loff_t *offset)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +/*
>> > + * The lseek sys_call is needed only by the vhost-user device
>> > + * located in vhost-device crate.
>> > + */
>> > +static loff_t loopback_seek(struct file *file, loff_t offset, int whe=
nce)
>> > +{
>> > +       loff_t new_pos;
>> > +
>> > +       switch (whence) {
>> > +       case SEEK_SET:
>> > +               new_pos =3D offset;
>> > +               break;
>> > +       case SEEK_CUR:
>> > +               new_pos =3D file->f_pos + offset;
>> > +               break;
>> > +       case SEEK_END:
>> > +               new_pos =3D file->f_inode->i_size;
>> > +               break;
>> > +       default:
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       if (new_pos < 0 || new_pos > file->f_inode->i_size)
>> > +               return -EINVAL;
>> > +
>> > +       return new_pos;
>> > +}
>> > +
>> > +static int register_virtio_loopback_dev(uint32_t device_id)
>> > +{
>> > +       struct platform_device *pdev;
>> > +       int err =3D 0;
>> > +
>> > +       pr_info("Received request to register a new loopback transport=
\n");
>> > +
>> > +       /* Register a new loopback-transport device */
>> > +       pdev =3D platform_device_register_simple("loopback-transport",
>> > +                                              device_id, NULL, 0);
>> > +       if (IS_ERR(pdev)) {
>> > +               err =3D PTR_ERR(pdev);
>> > +               pr_err("Failed to register transport device: %d\n", er=
r);
>> > +       }
>> > +
>> > +       return err;
>> > +}
>> > +
>> > +/* Insert new entry data for a discovered device */
>> > +int insert_entry_data(struct virtio_loopback_device *vl_dev, int id)
>> > +{
>> > +       int err =3D 0;
>> > +       /* Read that value atomically */
>> > +       uint32_t max_used_dev_idx =3D atomic_read(&loopback_devices.de=
vice_num);
>> > +
>> > +       /* Store the new vl_dev */
>> > +       if ((id <=3D MAX_PDEV) && (max_used_dev_idx < MAX_PDEV))
>> > +               loopback_devices.devices[id] =3D vl_dev;
>> > +       else
>> > +               err =3D -ENOMEM;
>> > +
>> > +       /* Mark the request as completed and free registration */
>> > +       complete(&loopback_devices.reg_vl_dev_completion[id]);
>> > +       return err;
>> > +}
>> > +
>> > +/* Helper function to mark an entry as active */
>> > +static struct virtio_loopback_device *
>> > +activate_entry_data(struct device_data *data, uint32_t curr_dev_id)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D NULL;
>> > +
>> > +       /* See if there is any available device */
>> > +       if (curr_dev_id < MAX_PDEV) {
>> > +               /* Find and store the data */
>> > +               vl_dev =3D loopback_devices.devices[curr_dev_id];
>> > +               vl_dev->data =3D data;
>> > +       }
>> > +
>> > +       return vl_dev;
>> > +}
>> > +
>> > +static int start_loopback(struct file_priv_data *file_data,
>> > +                         uint32_t curr_dev_id)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev;
>> > +       int ret;
>> > +
>> > +       /* Activate the entry */
>> > +       vl_dev =3D activate_entry_data(file_data->dev_data, curr_dev_i=
d);
>> > +       if (vl_dev) {
>> > +               file_data->vl_dev_irq =3D vl_dev;
>> > +               /* Register the activated vl_dev in the system */
>> > +               ret =3D loopback_register_virtio_dev(vl_dev);
>> > +       } else {
>> > +               pr_debug("No available entry found!\n");
>> > +               file_data->vl_dev_irq =3D NULL;
>> > +               ret =3D -EFAULT;
>> > +       }
>> > +
>> > +       return ret;
>> > +}
>> > +
>> > +/**
>> > + * loopback_ioctl - Handle various ioctl commands for loopback device
>> > + * @file: Pointer to the file structure associated with the device
>> > + * @cmd: The ioctl command code
>> > + * @arg: User-space argument associated with the command
>> > + *
>> > + * This function processes various ioctl commands to configure and co=
ntrol the
>> > + * loopback device. The supported commands include:
>> > + *
>> > + * - `EFD_INIT`: The user-space adapter component shares an eventfd w=
ith the
>> > + *   loopback device. This eventfd is triggered by the device each ti=
me a
>> > + *   read / write operation is requested via the communication data s=
tructure.
>> > + *
>> > + * - `WAKEUP`: Sets a flag in the device's internal structure and wak=
es up any
>> > + *   read / write process waiting on the communication wait queue.
>> > + *
>> > + * - `START_LOOPBACK`: Registers and starts a new loopback device, as=
signing a
>> > + *   unique device ID and waiting for its probe function to complete =
before
>> > + *   returning to user space.
>> > + *
>> > + * - `IRQ`: Handles an interrupt request by triggering the device's i=
nterrupt
>> > + *   logic with the provided IRQ number.
>> > + *
>> > + * - `SHARE_VQS`: Shares a specified virtqueue (selected via a queue =
index)
>> > + *   between the user-space application and the loopback device.
>> > + *
>> > + * - `SHARE_COM_STRUCT`: Notifies the loopback-device that the next m=
map call
>> > + *   will request the communication structure to be as shared between
>> > + *   user-space and the loopback device.
>> > + *
>> > + * - `SHARE_VQS_NOTIF`: The user-space uses this command to share the=
 eventfd
>> > + *   associated with a specific virtqueue. This eventfd will be trigg=
ered each
>> > + *   time the virtio device calls the `notify` function. In this way =
the
>> > + *   by-pass the user-space adapter component and delivered directly =
to the
>> > + *   vhost-user devices in user-space.
>> > + *
>> > + * If an unknown `cmd` is provided, the function logs an error and re=
turns
>> > + * `-ENOTTY` to indicate an unsupported ioctl command.
>> > + *
>> > + * Returns:
>> > + * - `0` on success.
>> > + * - Negative error codes (`-EFAULT`, `-ENOTTY`, or others) on failur=
e.
>> > + */
>> > +static long loopback_ioctl(struct file *file, unsigned int cmd,
>> > +                          unsigned long arg)
>> > +{
>> > +       struct efd_data efd_data;
>> > +       int irq, err;
>> > +       uint32_t queue_sel;
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(file->private_data);
>> > +       struct mmap_data *mm_data =3D (struct mmap_data *)file_data->m=
m_data;
>> > +       struct device_data *dev_data =3D
>> > +               (struct device_data *)file_data->dev_data;
>> > +       uint32_t curr_avail_dev_id;
>> > +       struct vq_notifier vq_notifier;
>> > +
>> > +       switch (cmd) {
>> > +       case EFD_INIT: {
>> > +               struct task_struct *userspace_task;
>> > +               struct file *efd_file;
>> > +
>> > +               if (copy_from_user(&efd_data, (struct efd_data *) arg,
>> > +                                                  sizeof(struct efd_d=
ata)))
>> > +                       return -EFAULT;
>> > +
>> > +               userspace_task =3D pid_task(find_vpid(efd_data.pid), P=
IDTYPE_PID);
>> > +
>> > +               rcu_read_lock();
>> > +               efd_file =3D files_lookup_fd_raw(userspace_task->files=
,
>> > +                                              efd_data.efd[0]);
>> > +               rcu_read_unlock();
>> > +
>> > +               dev_data->efd_ctx =3D eventfd_ctx_fileget(efd_file);
>> > +               if (!dev_data->efd_ctx)
>> > +                       return -1;
>> > +
>> > +               break;
>> > +       }
>> > +       case WAKEUP: {
>> > +               atomic_set(&((struct virtio_neg *)(dev_data->info->dat=
a))->done,
>> > +                          1);
>> > +               wake_up(&(dev_data)->wq);
>> > +               break;
>> > +       }
>> > +       case START_LOOPBACK: {
>> > +               if (copy_from_user(&(file_data)->device_info,
>> > +                                  (struct virtio_device_info_struct *=
) arg,
>> > +                                  sizeof(struct virtio_device_info_st=
ruct)))
>> > +                       return -EFAULT;
>> > +
>> > +               /* Read and increase that value atomically */
>> > +               curr_avail_dev_id =3D
>> > +                       atomic_add_return(1, &loopback_devices.device_=
num) - 1;
>> > +
>> > +               /* Register a new loopback device */
>> > +               err =3D register_virtio_loopback_dev(curr_avail_dev_id=
);
>> > +               if (err)
>> > +                       return -EFAULT;
>> > +
>> > +               /*
>> > +                * Wait for probe function to be called before return =
control
>> > +                * to user-space app
>> > +                */
>> > +               wait_for_completion(
>> > +                       &loopback_devices.reg_vl_dev_completion[curr_a=
vail_dev_id]);
>> > +
>> > +               /* Start the loopback */
>> > +               err =3D start_loopback(file_data, curr_avail_dev_id);
>> > +               if (err)
>> > +                       return -EFAULT;
>> > +
>> > +               break;
>> > +       }
>> > +       case IRQ:
>> > +               if (copy_from_user(&irq, (int *) arg, sizeof(int)))
>> > +                       return -EFAULT;
>> > +               /*
>> > +                * Both of the interrupt ways work but a) is more stab=
le
>> > +                * and b) has better performance:
>> > +                * a) vl_interrupt(NULL);
>> > +                * b) queue_work(interrupt_workqueue, &async_interrupt=
);
>> > +                */
>> > +               vl_interrupt(file_data->vl_dev_irq, irq);
>> > +               break;
>> > +       case SHARE_VQS:
>> > +               if (copy_from_user(&queue_sel, (uint32_t *) arg,
>> > +                                  sizeof(uint32_t)))
>> > +                       return -EFAULT;
>> > +               dev_data->vq_data.vq_pfn =3D dev_data->vq_data.vq_pfns=
[queue_sel];
>>
>> queue_sel could be out of bounds.
>
>
> Indeed! I will fix that.
>
>>
>>
>> EFD_INIT also looks like it trusts userspace to call the ioctl exactly
>> once? If it's called multiple times, eventfd references are leaked.
>>
>> I have only skimmed over the code up to this point and might have the
>> wrong impression, but this worries me. It looks like the kernel code
>> trusts userspace, which is not normally how things work. Can you
>> explain the security model?
>
>
> The current implementation of the driver collaborates with our
> user-space counterpart (adapter application) in order to establish
> the control plane with the vhost-user device, and indeed there is
> partially a trust relationship.
>
> Currently we are working on updating the API between driver and the
> user-space counterpart in order to make the driver more robust
> and make sure that leaks like this do not happen.

Okay. Please take kernel lockdown into account:
https://www.man7.org/linux/man-pages/man7/kernel_lockdown.7.html

Userspace must not be able to modify arbitrary kernel memory or load
code. Even root cannot do this except for limited mechanisms like
loading signed kernel modules.

>
>>
>>
>> Another security question: how does the zero copy memory access scheme
>> work safely? Userspace cannot fault in pfns of its choosing because
>> that would break kernel<->user memory isolation.
>
>
> I will provide a brief description of how the memory mapping
> mechanism works and set up between the virtio-transport and
> the vhost-user devices and then comment on the security aspect.
>
> The adapter application sends a set of memory regions to the
> vhost-user device which are essentially sets of [FD_1, HPA_1, SIZE],
> [FD_2, HPA_2, SIZE], ... [FD_N, HPA_N, SIZE]. The SIZE is 1 GB and
> eventually HPA_N + SIZE should be bigger than the RAM size.
>
> When vhost-user receives those regions it calls the MMAP sys_call
> for each one of those FDs individually and the driver assigns a page
> handler to all of those VM regions and returns. The vhost-user device
> at the end of this process generated the following mappings:
> [VA_1, HPA_1, SIZE_1], [VA_2, HPA_2, SIZE_2], ..., [VA_N, HPA_N, SIZE_N].
>
> That more or less is the initialization process which will make sense
> right after we describe how the driver give access for data buffers to th=
e
> vhost-user device below.
>
> When the vhost-user device tries to access a VA_X obtained by those
> mmaps, a page-fault will occur and then the driver will need to
> provide the corresponding page. At that point, the transport driver
> goes through the records, recognise that VA_X is in [VA_Y, VA_Y + SIZE)
> and constructs the required PFN by doing HPA_Y =3D VA_Y + offset where
> offset =3D VA_X - VA_Y. Finally the driver inserts the page to the runnin=
g
> process cause the page-fault with "vmf_insert_page".
>
> Security wise this approach has to fulfill the following two
> requirements:
>
> a) The first one is that we need to check efficiently if
> the calling process (vhost-user device) can have access to
> the requested pages. For example, assuming that we run a virtio
> blk on top of virtio-loopback transport the vhost-user blk
> should be able to access only pages which are related with
> virtio-blk virtqueues and vrings. That challenge is solvable
> and we can add those checks without changing the architecture.

Once pages have been faulted in, how does the kernel revoke access
when the request is complete? I'm thinking of the scenario where a
page is used for virtio DMA but then later reused for other purposes.
Userspace must not retain access once the page is reused for non-DMA
purposes.

>
> b) The second one is the fact that the current memory mapping
> approach cannot guarantee safety for the remaining data on a page
> when the virtio buffers do not cover the whole size of it.
> In order to address that security issue, we should implement
> an approach such the one proposed by Jason Wang below:
> https://github.com/jasowang/net/tree/vduse-zerocopy
>
> In this way we utilize the bouncing buffer idea and we can
> guarantee to not expose the remaining data when buffer_size <
> PAGE_SIZE and insert the page into the process otherwise.
>
> Overall, we are aware of those two security points, the first
> one will require the implementation of additional checks and
> the second the modification of data sharing model to avoid
> exposing kernel data.
>
> If you think that the overall approach is interesting we
> continue the discussion and target any future work to address
> the above described challenges.

With regards to the overall approach, please work with Jason since
there is an overlap with VDUSE. If you guys agree on how VDUSE and
loopback fit together, then I'm happy.

>
>>
>>
>> > +               mm_data->share_vqs =3D true;
>> > +               break;
>> > +       case SHARE_COM_STRUCT:
>> > +               mm_data->share_communication_struct =3D true;
>> > +               break;
>> > +       case SHARE_VQS_NOTIF:
>> > +
>> > +               struct task_struct *userspace_task;
>> > +               struct file *efd_file;
>> > +
>> > +               if (copy_from_user(&vq_notifier, (struct vq_notifier *=
) arg,
>> > +                                  sizeof(struct vq_notifier)))
>> > +                       return -EFAULT;
>> > +
>> > +               userspace_task =3D
>> > +                       pid_task(find_vpid(vq_notifier.pid), PIDTYPE_P=
ID);
>> > +
>> > +               rcu_read_lock();
>> > +               efd_file =3D files_lookup_fd_raw(userspace_task->files=
,
>> > +                                              vq_notifier.notifier_fd=
);
>> > +               rcu_read_unlock();
>> > +
>> > +               dev_data->vq_data.vq_notifiers[vq_notifier.vq_index] =
=3D
>> > +                       eventfd_ctx_fileget(efd_file);
>> > +               if (!dev_data->vq_data.vq_notifiers[vq_notifier.vq_ind=
ex])
>> > +                       return -1;
>> > +               /* Mark device notifiers as enabled */
>> > +               dev_data->vq_data.vq_notifiers_enabled =3D true;
>> > +               break;
>> > +       default:
>> > +               pr_err("Unknown loopback ioctl: %u\n", cmd);
>> > +               return -ENOTTY;
>> > +       }
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int loopback_open(struct inode *inode, struct file *file)
>> > +{
>> > +       uint32_t val_1gb =3D 1024 * 1024 * 1024;
>> > +       struct virtio_neg device_neg =3D {.done =3D ATOMIC_INIT(0)};
>> > +       /* Allocate file private data */
>> > +       struct file_priv_data *file_data =3D
>> > +               kmalloc(sizeof(struct file_priv_data), GFP_KERNEL);
>> > +       struct device_data *dev_data =3D
>> > +               kmalloc(sizeof(struct device_data), GFP_KERNEL);
>> > +       struct mmap_data *mm_data =3D
>> > +               kmalloc(sizeof(struct mmap_data), GFP_KERNEL);
>> > +
>> > +       if (!file_data || !dev_data || !mm_data)
>> > +               goto error_kmalloc;
>> > +
>> > +       /* Set the i_size for the stat SYS_CALL*/
>> > +       file->f_inode->i_size =3D 10 * val_1gb;
>> > +
>> > +       /* Initialize the device data */
>> > +       dev_data->info =3D kmalloc(sizeof(struct mmap_info), GFP_KERNE=
L);
>> > +       if (!dev_data->info)
>> > +               goto error_kmalloc;
>> > +       dev_data->info->data =3D (void *)get_zeroed_page(GFP_KERNEL);
>> > +       memcpy(dev_data->info->data, &device_neg, sizeof(struct virtio=
_neg));
>> > +
>> > +       /* Init wq */
>> > +       init_waitqueue_head(&(dev_data)->wq);
>> > +
>> > +       /* Init mutex */
>> > +       mutex_init(&(dev_data)->read_write_lock);
>> > +
>> > +       /* Init vq_data */
>> > +       dev_data->vq_data.vq_index =3D 0;
>> > +       dev_data->valid_eventfd =3D true;
>> > +       dev_data->vq_data.vq_notifiers_enabled =3D false;
>> > +       file_data->dev_data =3D dev_data;
>> > +
>> > +       /* Init file mmap_data */
>> > +       mm_data->mmap_index =3D 0;
>> > +       mm_data->share_communication_struct =3D false;
>> > +       mm_data->share_vqs =3D false;
>> > +       mm_data->cur_ram_idx =3D 0;
>> > +       mm_data->sum_pgfaults =3D 0;
>> > +       file_data->mm_data =3D mm_data;
>> > +
>> > +       /* Store in the private data as it should */
>> > +       file->private_data =3D (struct file_priv_data *)file_data;
>> > +
>> > +       return 0;
>> > +
>> > +error_kmalloc:
>> > +               kfree(file_data);
>> > +               kfree(dev_data);
>> > +               kfree(mm_data);
>> > +       return -ENOMEM;
>> > +}
>> > +
>> > +static int loopback_release(struct inode *inode, struct file *file)
>> > +{
>> > +       struct file_priv_data *file_data =3D
>> > +               (struct file_priv_data *)(file->private_data);
>> > +       struct device_data *dev_data =3D
>> > +               (struct device_data *)file_data->dev_data;
>> > +       struct mmap_data *mm_data =3D (struct mmap_data *)file_data->m=
m_data;
>> > +
>> > +       pr_info("Releasing the device\n");
>> > +       /*
>> > +        * This makes the read/write do not wait
>> > +        * for the virtio-loopback-adapter if
>> > +        * the last has closed the fd
>> > +        */
>> > +       dev_data->valid_eventfd =3D false;
>> > +       /* Active entry found */
>> > +       if (file_data->vl_dev_irq) {
>> > +               pr_debug("About to cancel the work\n");
>> > +               /* Cancel any pending work */
>> > +               cancel_work_sync(&file_data->vl_dev_irq->notify_work);
>> > +               /* Continue with the vl_dev unregister */
>> > +               virtio_loopback_driver.remove(file_data->vl_dev_irq->p=
dev);
>> > +               file_data->vl_dev_irq =3D NULL;
>> > +       }
>> > +       /* Subsequently free the dev_data */
>> > +       free_page((unsigned long)dev_data->info->data);
>> > +       kfree(dev_data->info);
>> > +       eventfd_ctx_put(dev_data->efd_ctx);
>> > +       dev_data->efd_ctx =3D NULL;
>> > +       kfree(dev_data);
>> > +       file_data->dev_data =3D NULL;
>> > +       /* Continue with the mm_data */
>> > +       kfree(mm_data);
>> > +       file_data->mm_data =3D NULL;
>> > +       /* Last, free the private data */
>> > +       kfree(file_data);
>> > +       file->private_data =3D NULL;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static const struct file_operations fops =3D {
>> > +       .owner                  =3D THIS_MODULE,
>> > +       .read                   =3D loopback_read,
>> > +       .write                  =3D loopback_write,
>> > +       .open                   =3D loopback_open,
>> > +       .unlocked_ioctl         =3D loopback_ioctl,
>> > +       .mmap                   =3D op_mmap,
>> > +       .llseek                 =3D loopback_seek,
>> > +       .release                =3D loopback_release
>> > +};
>> > +
>> > +static int __init loopback_init(void)
>> > +{
>> > +       int err, i;
>> > +       dev_t dev;
>> > +
>> > +       err =3D alloc_chrdev_region(&dev, 0, MAX_DEV, "loopback");
>> > +
>> > +       /* Set-up the loopback_data */
>> > +       loopback_data.dev_major =3D MAJOR(dev);
>> > +       loopback_data.class =3D class_create("loopback");
>> > +       if (IS_ERR(loopback_data.class)) {
>> > +               pr_err("Failed to create class\n");
>> > +               return PTR_ERR(loopback_data.class);
>> > +       }
>> > +       cdev_init(&loopback_data.cdev, &fops);
>> > +       loopback_data.cdev.owner =3D THIS_MODULE;
>> > +       cdev_add(&loopback_data.cdev, MKDEV(loopback_data.dev_major, 0=
), 1);
>> > +       device_create(loopback_data.class, NULL,
>> > +                     MKDEV(loopback_data.dev_major, 0), NULL, "loopba=
ck");
>> > +
>> > +       /* Register virtio_loopback_transport */
>> > +       (void)platform_driver_register(&virtio_loopback_driver);
>> > +
>> > +       /* Init loopback device array */
>> > +       atomic_set(&loopback_devices.device_num, 1);
>> > +
>> > +       /* Init completion for all devices */
>> > +       for (i =3D 0; i < MAX_PDEV; i++)
>> > +               init_completion(&loopback_devices.reg_vl_dev_completio=
n[i]);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static void __exit loopback_exit(void)
>> > +{
>> > +       int i;
>> > +       uint32_t max_used_device_num =3D
>> > +               atomic_read(&loopback_devices.device_num);
>> > +
>> > +       pr_info("Exit virtio_loopback driver!\n");
>> > +
>> > +       /* Unregister loopback devices */
>> > +       for (i =3D 0; i < max_used_device_num; i++)
>> > +               if (loopback_devices.devices[i])
>> > +                       platform_device_unregister(
>> > +                               loopback_devices.devices[i]->pdev);
>> > +
>> > +       /* Unregister virtio_loopback_transport */
>> > +       platform_driver_unregister(&virtio_loopback_driver);
>> > +       pr_debug("platform_driver_unregister!\n");
>> > +
>> > +       /* Necessary actions for the loopback_data */
>> > +       device_destroy(loopback_data.class, MKDEV(loopback_data.dev_ma=
jor, 0));
>> > +       cdev_del(&loopback_data.cdev);
>> > +       pr_debug("device_destroy!\n");
>> > +       class_destroy(loopback_data.class);
>> > +       pr_debug("class_destroy!\n");
>> > +}
>> > +
>> > +module_init(loopback_init);
>> > +module_exit(loopback_exit);
>> > diff --git a/drivers/virtio/virtio_loopback_transport.c b/drivers/virt=
io/virtio_loopback_transport.c
>> > new file mode 100644
>> > index 000000000000..c3511131e89c
>> > --- /dev/null
>> > +++ b/drivers/virtio/virtio_loopback_transport.c
>> > @@ -0,0 +1,924 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +/*
>> > + * Virtio loopback transport driver
>> > + *
>> > + * Based on virtio_mmio.c
>> > + *   Copyright 2011-2014, ARM Ltd.
>> > + *
>> > + * Copyright 2022-2024 Virtual Open Systems SAS
>> > + *
>> > + * Authors:
>> > + *  Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> > + *  Anna Panagopoulou <anna@virtualopensystems.com>
>> > + *  Alvise Rigo <a.rigo@virtualopensystems.com>
>> > + *
>> > + * This module allows virtio devices to be used in a non-virtualized
>> > + * environment, coupled with vhost-user device (user-space drivers).
>> > + *
>> > + * It is set as a transport driver by the virtio-loopback device
>> > + * driver for a group of virtio drivers and reroutes all read/write
>> > + * operations to the userspace. In user-space, virtio-loopback adapte=
r
>> > + * (the user-space component of the design) handles the read/write op=
s
>> > + * translates them into the corresponding vhost-user messages and
>> > + * forwards them to the corresponding vhost-user device.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modi=
fy
>> > + * it under the terms of the GNU General Public License as published =
by
>> > + * the Free Software Foundation; either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>> > +
>> > +#define pr_fmt(fmt) "virtio-loopback-transport: " fmt
>> > +
>> > +/* Loopback header file */
>> > +#include <uapi/linux/virtio_loopback.h>
>> > +
>> > +static void print_neg_flag(uint64_t neg_flag, bool read)
>> > +{
>> > +       if (read)
>> > +               pr_debug("Read:\n");
>> > +       else
>> > +               pr_debug("Write:\n");
>> > +
>> > +       switch (neg_flag) {
>> > +       case VIRTIO_MMIO_MAGIC_VALUE:
>> > +               pr_debug("\tVIRTIO_MMIO_MAGIC_VALUE\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_VERSION:
>> > +               pr_debug("\tVIRTIO_MMIO_VERSION\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_DEVICE_ID:
>> > +               pr_debug("\tVIRTIO_MMIO_DEVICE_ID\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_VENDOR_ID:
>> > +               pr_debug("\tVIRTIO_MMIO_VENDOR_ID\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_DEVICE_FEATURES:
>> > +               pr_debug("\tVIRTIO_MMIO_DEVICE_FEATURES\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
>> > +               pr_debug("\tVIRTIO_MMIO_DEVICE_FEATURES_SEL\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_DRIVER_FEATURES:
>> > +               pr_debug("\tVIRTIO_MMIO_DRIVER_FEATURES\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_DRIVER_FEATURES_SEL:
>> > +               pr_debug("\tVIRTIO_MMIO_DRIVER_FEATURES_SEL\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_GUEST_PAGE_SIZE:
>> > +               pr_debug("\tVIRTIO_MMIO_GUEST_PAGE_SIZE\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_SEL:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_SEL\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_NUM_MAX:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_NUM_MAX\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_NUM:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_NUM\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_ALIGN:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_ALIGN\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_PFN:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_PFN\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_READY:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_READY\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_NOTIFY:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_NOTIFY\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_INTERRUPT_STATUS:
>> > +               pr_debug("\tVIRTIO_MMIO_INTERRUPT_STATUS\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_INTERRUPT_ACK:
>> > +               pr_debug("\tVIRTIO_MMIO_INTERRUPT_ACK\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_STATUS:
>> > +               pr_debug("\tVIRTIO_MMIO_STATUS\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_DESC_LOW:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_DESC_LOW\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_DESC_HIGH:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_DESC_HIGH\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_AVAIL_LOW:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_AVAIL_LOW\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_AVAIL_HIGH:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_AVAIL_HIGH\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_USED_LOW:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_USED_LOW\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_QUEUE_USED_HIGH:
>> > +               pr_debug("\tVIRTIO_MMIO_QUEUE_USED_HIGH\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_SHM_SEL:
>> > +               pr_debug("\tVIRTIO_MMIO_SHM_SEL\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_SHM_LEN_LOW:
>> > +               pr_debug("\tVIRTIO_MMIO_SHM_LEN_LOW\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_SHM_LEN_HIGH:
>> > +               pr_debug("\tVIRTIO_MMIO_SHM_LEN_HIGH\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_SHM_BASE_LOW:
>> > +               pr_debug("\tVIRTIO_MMIO_SHM_BASE_LOW\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_SHM_BASE_HIGH:
>> > +               pr_debug("\tVIRTIO_MMIO_SHM_BASE_HIGH\n");
>> > +               break;
>> > +       case VIRTIO_MMIO_CONFIG_GENERATION:
>> > +               pr_debug("\tVIRTIO_MMIO_CONFIG_GENERATION\n");
>> > +               break;
>> > +       default:
>> > +               if (neg_flag >=3D VIRTIO_MMIO_CONFIG)
>> > +                       pr_debug("\tVIRTIO_MMIO_CONFIG\n");
>> > +               else
>> > +                       pr_debug("\tNegotiation flag Unknown: %lld\n",
>> > +                                neg_flag);
>> > +               return;
>> > +       }
>> > +}
>> > +
>> > +/*
>> > + * Print the pdev:
>> > + *
>> > + *static void print_virtio_pdev(struct platform_device *pdev)
>> > + *{
>> > + *     int i;
>> > + *
>> > + *     pr_info("Print the pdev:\n");
>> > + *     pr_info("\t.name =3D %s\n", pdev->name);
>> > + *     pr_info("\t.id =3D %d\n", pdev->id);
>> > + *     pr_info("\t.num_resources =3D %d\n", pdev->num_resources);
>> > + *
>> > + *     for (i=3D0; i < pdev->num_resources; i++) {
>> > + *             pr_info("\t.num_resource =3D %d\n", i);
>> > + *             pr_info("\t\t.start =3D 0x%llx\n", pdev->resource[i].s=
tart);
>> > + *             pr_info("\t\t.end =3D 0x%llx\n", pdev->resource[i].end=
);
>> > + *             pr_info("\t\t.flags =3D 0x%lx\n", pdev->resource[i].fl=
ags);
>> > + *     }
>> > + *}
>> > + *
>> > + *Result:
>> > + *
>> > + *     .name =3D a003e00.virtio_loopback
>> > + *     .id =3D -1
>> > + *     .num_resources =3D 2
>> > + *     .num_resource =3D 0
>> > + *             .start =3D 0xa003e00
>> > + *             .end =3D 0xa003fff
>> > + *             .flags =3D 0x200
>> > + *     .num_resource =3D 1
>> > + *             .start =3D 0x2c
>> > + *             .end =3D 0x2c
>> > + *             .flags =3D 0x401
>> > + */
>> > +
>> > +/* function declaration */
>> > +static uint64_t read_adapter(uint64_t fn_id, uint64_t size,
>> > +                            struct device_data *dev_data);
>> > +static void write_adapter(uint64_t data, uint64_t fn_id, uint64_t siz=
e,
>> > +                         struct device_data *dev_data);
>> > +
>> > +/* Configuration interface */
>> > +static u64 vl_get_features(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +       u64 features;
>> > +
>> > +       /* Take feature bits 0-31 */
>> > +       write_adapter(1, VIRTIO_MMIO_DEVICE_FEATURES_SEL, 4, data);
>> > +       features =3D read_adapter(VIRTIO_MMIO_DEVICE_FEATURES, 4, data=
);
>> > +       features <<=3D 32;
>> > +
>> > +       /* Take feature bits 32-63 */
>> > +       write_adapter(0, VIRTIO_MMIO_DEVICE_FEATURES_SEL, 4, data);
>> > +       features |=3D read_adapter(VIRTIO_MMIO_DEVICE_FEATURES, 4, dat=
a);
>> > +
>> > +       return features;
>> > +}
>> > +
>> > +static int vl_finalize_features(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       /* Give virtio_ring a chance to accept features. */
>> > +       vring_transport_features(vdev);
>> > +
>> > +       /* Make sure there are no mixed devices */
>> > +       if (vl_dev->version =3D=3D 2 &&
>> > +           !__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
>> > +               dev_err(&vdev->dev,
>> > +                       "New virtio-mmio devices (version 2) must prov=
ide VIRTIO_F_VERSION_1 feature!\n");
>> > +               return -EINVAL;
>> > +       }
>> > +
>> > +       write_adapter(1, VIRTIO_MMIO_DRIVER_FEATURES_SEL, 4, data);
>> > +       write_adapter((u32)(vdev->features >> 32), VIRTIO_MMIO_DRIVER_=
FEATURES,
>> > +                     4, data);
>> > +
>> > +       write_adapter(0, VIRTIO_MMIO_DRIVER_FEATURES_SEL, 4, data);
>> > +       write_adapter((u32)vdev->features, VIRTIO_MMIO_DRIVER_FEATURES=
,
>> > +                     4, data);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static void vl_get(struct virtio_device *vdev, unsigned int offset,
>> > +                                  void *buf, unsigned int len)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       u8 b;
>> > +       __le16 w;
>> > +       __le32 l;
>> > +
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               u8 *ptr =3D buf;
>> > +               int i;
>> > +
>> > +               for (i =3D 0; i < len; i++)
>> > +                       ptr[i] =3D read_adapter(VIRTIO_MMIO_CONFIG + o=
ffset + i,
>> > +                                             1, data);
>> > +               return;
>> > +       }
>> > +
>> > +       switch (len) {
>> > +       case 1:
>> > +               b =3D read_adapter(VIRTIO_MMIO_CONFIG + offset, 1, dat=
a);
>> > +               memcpy(buf, &b, sizeof(b));
>> > +               break;
>> > +       case 2:
>> > +               w =3D cpu_to_le16(read_adapter(VIRTIO_MMIO_CONFIG + of=
fset,
>> > +                                            2, data));
>> > +               memcpy(buf, &w, sizeof(w));
>> > +               break;
>> > +       case 4:
>> > +               l =3D cpu_to_le32(read_adapter(VIRTIO_MMIO_CONFIG + of=
fset,
>> > +                                            4, data));
>> > +               memcpy(buf, &l, sizeof(l));
>> > +               break;
>> > +       case 8:
>> > +               l =3D cpu_to_le32(read_adapter(VIRTIO_MMIO_CONFIG + of=
fset,
>> > +                                            4, data));
>> > +               memcpy(buf, &l, sizeof(l));
>> > +               l =3D cpu_to_le32(read_adapter(
>> > +                                       VIRTIO_MMIO_CONFIG + offset + =
sizeof(l),
>> > +                                       4, data));
>> > +               memcpy(buf + sizeof(l), &l, sizeof(l));
>> > +               break;
>> > +       default:
>> > +               BUG();
>> > +       }
>> > +}
>> > +
>> > +static void vl_set(struct virtio_device *vdev, unsigned int offset,
>> > +                                       const void *buf, unsigned int =
len)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       u8 b;
>> > +       __le16 w;
>> > +       __le32 l;
>> > +
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               const u8 *ptr =3D buf;
>> > +               int i;
>> > +
>> > +               for (i =3D 0; i < len; i++)
>> > +                       write_adapter(ptr[i], VIRTIO_MMIO_CONFIG + off=
set + i,
>> > +                                     1, data);
>> > +
>> > +               return;
>> > +       }
>> > +
>> > +       switch (len) {
>> > +       case 1:
>> > +               memcpy(&b, buf, sizeof(b));
>> > +               write_adapter(b, VIRTIO_MMIO_CONFIG + offset, 1, data)=
;
>> > +               break;
>> > +       case 2:
>> > +               memcpy(&w, buf, sizeof(w));
>> > +               write_adapter(le16_to_cpu(w), VIRTIO_MMIO_CONFIG + off=
set,
>> > +                             2, data);
>> > +               break;
>> > +       case 4:
>> > +               memcpy(&l, buf, sizeof(l));
>> > +               write_adapter(le32_to_cpu(l), VIRTIO_MMIO_CONFIG + off=
set,
>> > +                             4, data);
>> > +               break;
>> > +       case 8:
>> > +               memcpy(&l, buf, sizeof(l));
>> > +               write_adapter(le32_to_cpu(l), VIRTIO_MMIO_CONFIG + off=
set,
>> > +                             4, data);
>> > +               memcpy(&l, buf + sizeof(l), sizeof(l));
>> > +               write_adapter(le32_to_cpu(l),
>> > +                             VIRTIO_MMIO_CONFIG + offset + sizeof(l),
>> > +                             4, data);
>> > +               break;
>> > +       default:
>> > +               BUG();
>> > +       }
>> > +}
>> > +
>> > +static u32 vl_generation(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       if (vl_dev->version =3D=3D 1)
>> > +               return 0;
>> > +       else
>> > +               return read_adapter(VIRTIO_MMIO_CONFIG_GENERATION, 4, =
data);
>> > +}
>> > +
>> > +static u8 vl_get_status(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       return read_adapter(VIRTIO_MMIO_STATUS, 4, data) & 0xff;
>> > +}
>> > +
>> > +static void vl_set_status(struct virtio_device *vdev, u8 status)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       write_adapter(status, VIRTIO_MMIO_STATUS, 4, data);
>> > +}
>> > +
>> > +static void vl_reset(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       /* 0 status means a reset. */
>> > +       write_adapter(0, VIRTIO_MMIO_STATUS, 4, data);
>> > +}
>> > +
>> > +/* Notify work handling function */
>> > +static void notify_work_handler(struct work_struct *work)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D
>> > +               container_of(work, struct virtio_loopback_device, noti=
fy_work);
>> > +       struct device_data *dev_data =3D vl_dev->data;
>> > +       struct notify_data *entry, *tmp;
>> > +       uint32_t index;
>> > +
>> > +       spin_lock(&vl_dev->notify_q_lock);
>> > +       list_for_each_entry_safe(entry, tmp, &vl_dev->notify_list, lis=
t) {
>> > +               index =3D entry->index;
>> > +               list_del(&entry->list);
>> > +               kfree(entry);
>> > +               /* Proceed in dispatching the notification to the adap=
ter */
>> > +               spin_unlock(&vl_dev->notify_q_lock);
>> > +               write_adapter(index, VIRTIO_MMIO_QUEUE_NOTIFY, 4, dev_=
data);
>> > +               spin_lock(&vl_dev->notify_q_lock);
>> > +       }
>> > +       spin_unlock(&vl_dev->notify_q_lock);
>> > +}
>> > +
>> > +/* The notify function used when creating a virtqueue */
>> > +static bool vl_notify(struct virtqueue *vq)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D
>> > +               to_virtio_loopback_device(vq->vdev);
>> > +       struct eventfd_ctx **vq_notifiers =3D vl_dev->data->vq_data.vq=
_notifiers;
>> > +       bool vq_notifiers_enabled =3D vl_dev->data->vq_data.vq_notifie=
rs_enabled;
>> > +       struct notify_data *data;
>> > +       int ret =3D 1;
>> > +
>> > +       if (vq_notifiers_enabled && (vq_notifiers[vq->index])) {
>> > +               /* Notify directly vhost-user-device bypassing the ada=
pter */
>> > +               eventfd_signal(vq_notifiers[vq->index]);
>> > +       } else {
>> > +               /* Create the new node */
>> > +               data =3D kmalloc(sizeof(struct notify_data), GFP_ATOMI=
C);
>> > +               if (!data)
>> > +                       return false;
>> > +
>> > +               data->index =3D vq->index;
>> > +               INIT_LIST_HEAD(&data->list);
>> > +
>> > +               /* Add in the notify_list, which should be protected! =
*/
>> > +               spin_lock(&vl_dev->notify_q_lock);
>> > +               list_add_tail(&data->list, &vl_dev->notify_list);
>> > +               spin_unlock(&vl_dev->notify_q_lock);
>> > +
>> > +               /* Schedule the element */
>> > +               while (ret) {
>> > +                       /*
>> > +                        * Force scheduling if queue_work fails and
>> > +                        * list is not empty
>> > +                        */
>> > +                       ret =3D !queue_work(vl_dev->notify_workqueue,
>> > +                                         &vl_dev->notify_work);
>> > +                       spin_lock(&vl_dev->notify_q_lock);
>> > +                       ret &=3D !list_empty(&vl_dev->notify_list);
>> > +                       spin_unlock(&vl_dev->notify_q_lock);
>> > +               }
>> > +       }
>> > +
>> > +       return true;
>> > +}
>> > +
>> > +/* the interrupt function used when receiving an IRQ */
>> > +bool vl_interrupt(struct virtio_loopback_device *vl_dev, int irq)
>> > +{
>> > +       struct device_data *data =3D vl_dev->data;
>> > +       struct virtio_loopback_vq_info *info;
>> > +       unsigned long status;
>> > +
>> > +       /*
>> > +        * Read and acknowledge interrupts
>> > +        *
>> > +        * Those two operations should be executed without any
>> > +        * intermediate status change.
>> > +        */
>> > +       status =3D read_adapter(VIRTIO_MMIO_INTERRUPT_STATUS, 4, data)=
;
>> > +       write_adapter(status, VIRTIO_MMIO_INTERRUPT_ACK, 4, data);
>> > +
>> > +       if (unlikely(status & VIRTIO_MMIO_INT_CONFIG))
>> > +               virtio_config_changed(&vl_dev->vdev);
>> > +
>> > +       if (likely(status & VIRTIO_MMIO_INT_VRING)) {
>> > +               spin_lock(&vl_dev->lock);
>> > +               list_for_each_entry(info, &vl_dev->virtqueues, node) {
>> > +                       (void)vring_interrupt(irq, info->vq);
>> > +               }
>> > +               spin_unlock(&vl_dev->lock);
>> > +       }
>> > +
>> > +       return true;
>> > +}
>> > +
>> > +static void vl_del_vq(struct virtqueue *vq)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D
>> > +               to_virtio_loopback_device(vq->vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +
>> > +       struct virtio_loopback_vq_info *info =3D vq->priv;
>> > +       unsigned long flags;
>> > +       unsigned int index =3D vq->index;
>> > +
>> > +       spin_lock_irqsave(&vl_dev->lock, flags);
>> > +       list_del(&info->node);
>> > +       spin_unlock_irqrestore(&vl_dev->lock, flags);
>> > +
>> > +       /* Select and deactivate the queue */
>> > +       write_adapter(index, VIRTIO_MMIO_QUEUE_SEL, 4, data);
>> > +
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               write_adapter(0, VIRTIO_MMIO_QUEUE_PFN, 4, data);
>> > +       } else {
>> > +               write_adapter(0, VIRTIO_MMIO_QUEUE_READY, 4, data);
>> > +               WARN_ON(read_adapter(VIRTIO_MMIO_QUEUE_READY, 4, data)=
);
>> > +       }
>> > +
>> > +       vring_del_virtqueue(vq);
>> > +       kfree(info);
>> > +}
>> > +
>> > +static void vl_del_vqs(struct virtio_device *vdev)
>> > +{
>> > +       struct virtqueue *vq, *n;
>> > +
>> > +       list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>> > +               vl_del_vq(vq);
>> > +}
>> > +
>> > +static struct virtqueue *vl_setup_vq(struct virtio_device *vdev,
>> > +                                    unsigned int index,
>> > +                                    void (*callback)(struct virtqueue=
 *vq),
>> > +                                    const char *name, bool ctx)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +       struct virtio_loopback_vq_info *info;
>> > +       struct virtqueue *vq;
>> > +       unsigned long flags;
>> > +       unsigned int num;
>> > +       int err;
>> > +
>> > +       if (!name)
>> > +               return NULL;
>> > +
>> > +       /* Select the queue we're interested in */
>> > +       write_adapter(index, VIRTIO_MMIO_QUEUE_SEL, 4, data);
>> > +
>> > +       /* Queue shouldn't already be set up. */
>> > +       if (read_adapter((vl_dev->version =3D=3D 1 ?
>> > +                        VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_REA=
DY),
>> > +                        4, data)) {
>> > +               err =3D -ENOENT;
>> > +               goto error_available;
>> > +       }
>> > +
>> > +       /* Allocate and fill out our active queue description */
>> > +       info =3D kmalloc(sizeof(*info), GFP_KERNEL);
>> > +       if (!info) {
>> > +               err =3D -ENOMEM;
>> > +               goto error_kmalloc;
>> > +       }
>> > +
>> > +       num =3D read_adapter(VIRTIO_MMIO_QUEUE_NUM_MAX, 4, data);
>> > +       if (num =3D=3D 0) {
>> > +               err =3D -ENOENT;
>> > +               goto error_new_virtqueue;
>> > +       }
>> > +
>> > +       /* Create the vring */
>> > +       vq =3D vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_AL=
IGN, vdev,
>> > +                                   true, true, ctx, vl_notify, callba=
ck, name);
>> > +       if (!vq) {
>> > +               err =3D -ENOMEM;
>> > +               goto error_new_virtqueue;
>> > +       }
>> > +
>> > +       vq->num_max =3D num;
>> > +
>> > +       /* Activate the queue */
>> > +       write_adapter(virtqueue_get_vring_size(vq), VIRTIO_MMIO_QUEUE_=
NUM, 4,
>> > +                     data);
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               u64 q_pfn =3D virtqueue_get_desc_addr(vq);
>> > +
>> > +               q_pfn =3D q_pfn >> PAGE_SHIFT;
>> > +
>> > +               /* Copy the physical address and enable the mmap */
>> > +               data->vq_data.vq_pfn =3D q_pfn;
>> > +               data->vq_data.vq_pfns[data->vq_data.vq_index++] =3D q_=
pfn;
>> > +
>> > +               /*
>> > +                * virtio-loopback v1 uses a 32bit QUEUE PFN. If we ha=
ve
>> > +                * something that doesn't fit in 32bit, fail the setup=
 rather
>> > +                * than pretending to be successful.
>> > +                */
>> > +               if (q_pfn >> 32) {
>> > +                       dev_err(&vdev->dev,
>> > +                               "platform bug: legacy virtio-loopback =
must not be used with RAM above 0x%llxGB\n",
>> > +                               0x1ULL << (32 + PAGE_SHIFT - 30));
>> > +                       err =3D -E2BIG;
>> > +                       goto error_bad_pfn;
>> > +               }
>> > +
>> > +               write_adapter(PAGE_SIZE, VIRTIO_MMIO_QUEUE_ALIGN, 4, d=
ata);
>> > +               write_adapter(q_pfn, VIRTIO_MMIO_QUEUE_PFN, 4, data);
>> > +       } else {
>> > +               u64 addr;
>> > +
>> > +               addr =3D virtqueue_get_desc_addr(vq);
>> > +               write_adapter((u32)addr, VIRTIO_MMIO_QUEUE_DESC_LOW, 4=
, data);
>> > +               write_adapter((u32)(addr >> 32), VIRTIO_MMIO_QUEUE_DES=
C_HIGH,
>> > +                             4, data);
>> > +
>> > +               addr =3D virtqueue_get_avail_addr(vq);
>> > +               write_adapter((u32)addr, VIRTIO_MMIO_QUEUE_AVAIL_LOW, =
4, data);
>> > +               write_adapter((u32)(addr >> 32), VIRTIO_MMIO_QUEUE_AVA=
IL_HIGH,
>> > +                             4, data);
>> > +
>> > +               addr =3D virtqueue_get_used_addr(vq);
>> > +               write_adapter((u32)addr, VIRTIO_MMIO_QUEUE_USED_LOW, 4=
, data);
>> > +               write_adapter((u32)(addr >> 32), VIRTIO_MMIO_QUEUE_USE=
D_HIGH,
>> > +                             4, data);
>> > +
>> > +               write_adapter(1, VIRTIO_MMIO_QUEUE_READY, 4, data);
>> > +       }
>> > +
>> > +       vq->priv =3D info;
>> > +       info->vq =3D vq;
>> > +
>> > +       spin_lock_irqsave(&vl_dev->lock, flags);
>> > +       list_add(&info->node, &vl_dev->virtqueues);
>> > +       spin_unlock_irqrestore(&vl_dev->lock, flags);
>> > +
>> > +       return vq;
>> > +
>> > +error_bad_pfn:
>> > +       vring_del_virtqueue(vq);
>> > +error_new_virtqueue:
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               write_adapter(0, VIRTIO_MMIO_QUEUE_PFN, 4, data);
>> > +       } else {
>> > +               write_adapter(0, VIRTIO_MMIO_QUEUE_READY, 4, data);
>> > +               WARN_ON(read_adapter(VIRTIO_MMIO_QUEUE_READY, 4, data)=
);
>> > +       }
>> > +       kfree(info);
>> > +error_kmalloc:
>> > +error_available:
>> > +       return ERR_PTR(err);
>> > +}
>> > +
>> > +static int vl_find_vqs(struct virtio_device *vdev,
>> > +                      unsigned int nvqs,
>> > +                      struct virtqueue *vqs[],
>> > +                      struct virtqueue_info vqs_info[],
>> > +                      struct irq_affinity *desc)
>> > +{
>> > +       int i, queue_idx =3D 0;
>> > +
>> > +       for (i =3D 0; i < nvqs; ++i) {
>> > +               struct virtqueue_info *vqi =3D &vqs_info[i];
>> > +
>> > +               if (!vqi->name) {
>> > +                       vqs[i] =3D NULL;
>> > +                       continue;
>> > +               }
>> > +
>> > +               vqs[i] =3D vl_setup_vq(vdev, queue_idx++, vqi->callbac=
k,
>> > +                                    vqi->name, vqi->ctx);
>> > +               if (IS_ERR(vqs[i])) {
>> > +                       vl_del_vqs(vdev);
>> > +                       return PTR_ERR(vqs[i]);
>> > +               }
>> > +       }
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static const char *vl_bus_name(struct virtio_device *vdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +
>> > +       return vl_dev->pdev->name;
>> > +}
>> > +
>> > +static bool vl_get_shm_region(struct virtio_device *vdev,
>> > +                             struct virtio_shm_region *region, u8 id)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct device_data *data =3D vl_dev->data;
>> > +       u64 len, addr;
>> > +
>> > +       /* Select the region we're interested in */
>> > +       write_adapter(id, VIRTIO_MMIO_SHM_SEL, 4, data);
>> > +
>> > +       /* Read the region size */
>> > +       len =3D (u64) read_adapter(VIRTIO_MMIO_SHM_LEN_LOW, 4, data);
>> > +       len |=3D (u64) read_adapter(VIRTIO_MMIO_SHM_LEN_HIGH, 4, data)=
 << 32;
>> > +
>> > +       region->len =3D len;
>> > +
>> > +       /* Check if region length is -1. If that's the case, the share=
d memory
>> > +        * region does not exist and there is no need to proceed furth=
er.
>> > +        */
>> > +       if (len =3D=3D ~(u64)0)
>> > +               return false;
>> > +
>> > +       /* Read the region base address */
>> > +       addr =3D (u64) read_adapter(VIRTIO_MMIO_SHM_BASE_LOW, 4, data)=
;
>> > +       addr |=3D (u64) read_adapter(VIRTIO_MMIO_SHM_BASE_HIGH, 4, dat=
a) << 32;
>> > +
>> > +       region->addr =3D addr;
>> > +
>> > +       return true;
>> > +}
>> > +
>> > +static const struct virtio_config_ops virtio_loopback_config_ops =3D =
{
>> > +       .get                    =3D vl_get,
>> > +       .set                    =3D vl_set,
>> > +       .generation             =3D vl_generation,
>> > +       .get_status             =3D vl_get_status,
>> > +       .set_status             =3D vl_set_status,
>> > +       .reset                  =3D vl_reset,
>> > +       .find_vqs               =3D vl_find_vqs,
>> > +       .del_vqs                =3D vl_del_vqs,
>> > +       .get_features           =3D vl_get_features,
>> > +       .finalize_features      =3D vl_finalize_features,
>> > +       .bus_name               =3D vl_bus_name,
>> > +       .get_shm_region         =3D vl_get_shm_region,
>> > +};
>> > +
>> > +static void virtio_loopback_release_dev(struct device *_d)
>> > +{
>> > +       struct virtio_device *vdev =3D
>> > +               container_of(_d, struct virtio_device, dev);
>> > +       struct virtio_loopback_device *vl_dev =3D to_virtio_loopback_d=
evice(vdev);
>> > +       struct platform_device *pdev =3D vl_dev->pdev;
>> > +
>> > +       devm_kfree(&pdev->dev, vl_dev);
>> > +}
>> > +
>> > +/* Function to carry-out the registration of the virtio_loopback */
>> > +int loopback_register_virtio_dev(struct virtio_loopback_device *vl_de=
v)
>> > +{
>> > +       struct platform_device *pdev =3D vl_dev->pdev;
>> > +       struct device_data *data =3D vl_dev->data;
>> > +       unsigned long magic;
>> > +       int rc;
>> > +
>> > +       /* Check magic value */
>> > +       magic =3D read_adapter(VIRTIO_MMIO_MAGIC_VALUE, 4, data);
>> > +
>> > +       if (magic !=3D ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>> > +               dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", m=
agic);
>> > +               return -ENODEV;
>> > +       }
>> > +
>> > +       /* Check device version */
>> > +       vl_dev->version =3D read_adapter(VIRTIO_MMIO_VERSION, 4, data)=
;
>> > +
>> > +       if (vl_dev->version < 1 || vl_dev->version > 2) {
>> > +               dev_err(&pdev->dev, "Version %ld not supported!\n",
>> > +                                                       vl_dev->versio=
n);
>> > +               return -ENXIO;
>> > +       }
>> > +
>> > +       vl_dev->vdev.id.device =3D read_adapter(VIRTIO_MMIO_DEVICE_ID,=
 4, data);
>> > +
>> > +       if (vl_dev->vdev.id.device =3D=3D 0) {
>> > +               /*
>> > +                * virtio-loopback device with an ID 0 is a (dummy) pl=
aceholder
>> > +                * with no function. End probing now with no error rep=
orted.
>> > +                */
>> > +               return -ENODEV;
>> > +       }
>> > +
>> > +       vl_dev->vdev.id.vendor =3D read_adapter(VIRTIO_MMIO_VENDOR_ID,=
 4, data);
>> > +
>> > +       if (vl_dev->version =3D=3D 1) {
>> > +               write_adapter(PAGE_SIZE, VIRTIO_MMIO_GUEST_PAGE_SIZE, =
4, data);
>> > +
>> > +               rc =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>> > +               /*
>> > +                * In the legacy case, ensure our coherently-allocated=
 virtio
>> > +                * ring will be at an address expressable as a 32-bit =
PFN.
>> > +                */
>> > +               if (!rc)
>> > +                       dma_set_coherent_mask(&pdev->dev,
>> > +                                 DMA_BIT_MASK(32 + PAGE_SHIFT));
>> > +       } else {
>> > +               rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_M=
ASK(64));
>> > +       }
>> > +       if (rc)
>> > +               rc =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_M=
ASK(32));
>> > +       if (rc)
>> > +               dev_warn(&pdev->dev,
>> > +                        "Failed to enable 64-bit or 32-bit DMA. Tryin=
g to continue, but this might not work.\n");
>> > +
>> > +       /* Register the virtio device in the system */
>> > +       rc =3D register_virtio_device(&vl_dev->vdev);
>> > +       if (rc)
>> > +               put_device(&vl_dev->vdev.dev);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int virtio_loopback_probe(struct platform_device *pdev)
>> > +{
>> > +       int err;
>> > +       struct virtio_loopback_device *vl_dev;
>> > +
>> > +       pr_info("Entered probe with id: %d!\n", pdev->id);
>> > +       vl_dev =3D devm_kzalloc(&pdev->dev, sizeof(*vl_dev), GFP_KERNE=
L);
>> > +       if (!vl_dev) {
>> > +               err =3D -ENOMEM;
>> > +               goto out;
>> > +       }
>> > +
>> > +       vl_dev->vdev.dev.parent =3D &pdev->dev;
>> > +       vl_dev->vdev.dev.release =3D virtio_loopback_release_dev;
>> > +       vl_dev->vdev.config =3D &virtio_loopback_config_ops;
>> > +       vl_dev->pdev =3D pdev;
>> > +       INIT_LIST_HEAD(&vl_dev->virtqueues);
>> > +       spin_lock_init(&vl_dev->lock);
>> > +       /* Initialize the workqueue */
>> > +       vl_dev->notify_workqueue =3D
>> > +               create_singlethread_workqueue("notify_workqueue");
>> > +       INIT_WORK(&vl_dev->notify_work, notify_work_handler);
>> > +       INIT_LIST_HEAD(&vl_dev->notify_list);
>> > +       spin_lock_init(&vl_dev->notify_q_lock);
>> > +
>> > +       platform_set_drvdata(pdev, vl_dev);
>> > +
>> > +       /* Insert new entry data */
>> > +       err =3D insert_entry_data(vl_dev, pdev->id);
>> > +
>> > +out:
>> > +       return err;
>> > +}
>> > +
>> > +static void virtio_loopback_remove(struct platform_device *pdev)
>> > +{
>> > +       struct virtio_loopback_device *vl_dev =3D platform_get_drvdata=
(pdev);
>> > +
>> > +       /* Destroy the notify workqueue */
>> > +       flush_workqueue(vl_dev->notify_workqueue);
>> > +       destroy_workqueue(vl_dev->notify_workqueue);
>> > +
>> > +       if (vl_dev->data) {
>> > +               unregister_virtio_device(&vl_dev->vdev);
>> > +               pr_info("unregister_virtio_device!\n");
>> > +               /* Proceed to de-activating the data for this entry */
>> > +               vl_dev->data =3D NULL;
>> > +       }
>> > +}
>> > +
>> > +/* No need of DTS and ACPI */
>> > +struct platform_driver virtio_loopback_driver =3D {
>> > +       .probe   =3D virtio_loopback_probe,
>> > +       .remove  =3D virtio_loopback_remove,
>> > +       .driver  =3D {
>> > +               .name   =3D "loopback-transport",
>> > +       },
>> > +};
>> > +
>> > +static uint64_t read_adapter(uint64_t fn_id, uint64_t size,
>> > +                            struct device_data *dev_data)
>> > +{
>> > +       uint64_t result;
>> > +
>> > +       mutex_lock(&(dev_data)->read_write_lock);
>> > +
>> > +       /*
>> > +        * By enabling the following line all
>> > +        * read messages will be printed:
>> > +        *
>> > +        * print_neg_flag(fn_id, 1);
>> > +        */
>> > +       print_neg_flag(fn_id, 1);
>> > +
>> > +       ((struct virtio_neg *)(dev_data->info->data))->notification =
=3D fn_id;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->data =3D 0;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->size =3D size;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->read =3D true;
>> > +
>> > +       atomic_set(&((struct virtio_neg *)(dev_data->info->data))->don=
e, 0);
>> > +
>> > +       eventfd_signal(dev_data->efd_ctx);
>> > +
>> > +       /*
>> > +        * There is a chance virtio-loopback adapter to call "wake_up"
>> > +        * before the current thread sleep. This is the reason that
>> > +        * "wait_event_timeout" is used instead of "wait_event". In th=
is
>> > +        * way, virtio-loopback driver will wake up even if has missed=
 the
>> > +        * "wake_up" kick, check the updated "done" value and return.
>> > +        */
>> > +
>> > +       while (dev_data->valid_eventfd &&
>> > +              atomic_read(&((struct virtio_neg *)(dev_data->info->dat=
a))->done) !=3D 1)
>> > +               wait_event_timeout(dev_data->wq,
>> > +                       atomic_read(&((struct virtio_neg *)(dev_data->=
info->data))->done) =3D=3D 1,
>> > +                       1 * HZ);
>> > +
>> > +       result =3D ((struct virtio_neg *)(dev_data->info->data))->data=
;
>> > +
>> > +       mutex_unlock(&(dev_data)->read_write_lock);
>> > +
>> > +       return result;
>> > +}
>> > +
>> > +static void write_adapter(uint64_t data, uint64_t fn_id, uint64_t siz=
e,
>> > +                         struct device_data *dev_data)
>> > +{
>> > +
>> > +       mutex_lock(&(dev_data)->read_write_lock);
>> > +
>> > +       /*
>> > +        * By enabling the following line all
>> > +        * write messages will be printed:
>> > +        *
>> > +        * print_neg_flag(fn_id, 1);
>> > +        */
>> > +       print_neg_flag(fn_id, 0);
>> > +
>> > +       ((struct virtio_neg *)(dev_data->info->data))->notification =
=3D fn_id;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->data =3D data;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->size =3D size;
>> > +       ((struct virtio_neg *)(dev_data->info->data))->read =3D false;
>> > +
>> > +       atomic_set(&((struct virtio_neg *)(dev_data->info->data))->don=
e, 0);
>> > +
>> > +       eventfd_signal(dev_data->efd_ctx);
>> > +
>> > +       /*
>> > +        * There is a chance virtio-loopback adapter to call "wake_up"
>> > +        * before the current thread sleep. This is the reason that
>> > +        * "wait_event_timeout" is used instead of "wait_event". In th=
is
>> > +        * way, virtio-loopback driver will wake up even if has missed=
 the
>> > +        * "wake_up" kick, check the updated "done" value and return.
>> > +        */
>> > +       while (dev_data->valid_eventfd &&
>> > +              atomic_read(&((struct virtio_neg *)(dev_data->info->dat=
a))->done) !=3D 1)
>> > +               wait_event_timeout(dev_data->wq,
>> > +                       atomic_read(&((struct virtio_neg *)(dev_data->=
info->data))->done) =3D=3D 1,
>> > +                       1 * HZ);
>> > +
>> > +       mutex_unlock(&(dev_data)->read_write_lock);
>> > +}
>> > diff --git a/include/uapi/linux/virtio_loopback.h b/include/uapi/linux=
/virtio_loopback.h
>> > new file mode 100644
>> > index 000000000000..57e2ce53ea36
>> > --- /dev/null
>> > +++ b/include/uapi/linux/virtio_loopback.h
>> > @@ -0,0 +1,259 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> > +/*
>> > + * Virtio loopback device driver
>> > + *
>> > + * Copyright 2022-2024 Virtual Open Systems SAS.
>> > + *
>> > + * Authors:
>> > + *  Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>> > + *  Anna Panagopoulou <anna@virtualopensystems.com>
>> > + *  Alvise Rigo <a.rigo@virtualopensystems.com>
>> > + *
>> > + * This program is free software; you can redistribute it and/or modi=
fy
>> > + * it under the terms of the GNU General Public License as published =
by
>> > + * the Free Software Foundation; either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>> > +
>> > +#ifndef __LOOPBACK_H__
>> > +#define __LOOPBACK_H__
>> > +
>> > +#define DRIVER  "LOOPBACK"
>> > +
>> > +#include <linux/cdev.h>
>> > +#include <linux/eventfd.h>
>> > +#include <linux/fdtable.h>
>> > +#include <linux/init.h>
>> > +#include <linux/interrupt.h>
>> > +#include <linux/mm.h>
>> > +#include <linux/module.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/of_address.h>
>> > +#include <linux/cpumask.h>
>> > +#include <linux/smp.h>
>> > +#include <linux/version.h>
>> > +#include <linux/completion.h>
>> > +
>> > +/* MMIO includes */
>> > +#include <linux/acpi.h>
>> > +#include <linux/dma-mapping.h>
>> > +#include <linux/highmem.h>
>> > +#include <linux/io.h>
>> > +#include <linux/list.h>
>> > +#include <linux/spinlock.h>
>> > +#include <linux/virtio.h>
>> > +#include <linux/virtio_config.h>
>> > +#include <linux/virtio_mmio.h>
>> > +#include <linux/virtio_ring.h>
>> > +
>> > +#include <linux/kernel.h>
>> > +#include <linux/pid.h>
>> > +#include <linux/sched.h>
>> > +#include <linux/rcupdate.h>
>> > +#include <linux/kthread.h>
>> > +
>> > +/* mmap includes */
>> > +#include <linux/fs.h>
>> > +#include <linux/device.h>
>> > +#include <linux/mutex.h>
>> > +
>> > +#include <linux/pagemap.h>
>> > +#include <linux/delay.h>
>> > +
>> > +/* max Minor devices */
>> > +#define MAX_DEV        1
>> > +#define MAX_PDEV 100
>> > +#define PDEV_TYPES 2
>> > +
>> > +/* Define mmap elements limit */
>> > +#define MMAP_LIMIT     200
>> > +
>> > +/*
>> > + * The alignment to use between consumer and producer parts of vring.
>> > + * Currently hardcoded to the page size.
>> > + */
>> > +#define VIRTIO_MMIO_VRING_ALIGN PAGE_SIZE
>> > +
>> > +#define to_virtio_loopback_device(ptr) \
>> > +       container_of(ptr, struct virtio_loopback_device, vdev)
>> > +
>> > +/* mmap functionality */
>> > +#ifndef VM_RESERVED
>> > +#define VM_RESERVED (VM_DONTEXPAND | VM_DONTDUMP)
>> > +#endif
>> > +
>> > +/* IOCTL defines */
>> > +#define EFD_INIT _IOC(_IOC_WRITE, 'k', 1, sizeof(efd_data))
>> > +#define WAKEUP _IOC(_IOC_WRITE, 'k', 2, 0)
>> > +#define START_LOOPBACK _IOC(_IOC_WRITE, 'k', 3, sizeof(struct virtio_=
device_info_struct))
>> > +#define IRQ _IOC(_IOC_WRITE, 'k', 4, sizeof(int))
>> > +#define SHARE_VQS _IOC(_IOC_WRITE, 'k', 5, sizeof(uint32_t))
>> > +#define SHARE_COM_STRUCT _IOC(_IOC_WRITE, 'k', 6, 0)
>> > +#define SHARE_VQS_NOTIF _IOC(_IOC_WRITE, 'k', 7, sizeof(struct vq_not=
ifier))
>> > +
>> > +/* Data structures */
>> > +struct virtio_device_info_struct {
>> > +       unsigned long magic;
>> > +       unsigned long version;
>> > +       unsigned long device_id;
>> > +       unsigned long vendor;
>> > +};
>> > +
>> > +struct virtio_neg {
>> > +       uint64_t notification;
>> > +       uint64_t data;
>> > +       uint64_t size;
>> > +       bool read;
>> > +       atomic_t done;
>> > +};
>> > +
>> > +struct share_mmap {
>> > +       uint64_t pfn;
>> > +       uint64_t vm_start;
>> > +       uint32_t size;
>> > +       uint32_t uid;
>> > +       struct page *page;
>> > +};
>> > +
>> > +struct mmap_data {
>> > +       int mmap_index;
>> > +       bool share_communication_struct;
>> > +       bool share_vqs;
>> > +       struct share_mmap share_mmap_list[MMAP_LIMIT];
>> > +       int cur_ram_idx;
>> > +       uint64_t sum_pgfaults;
>> > +};
>> > +
>> > +struct vq_notifier {
>> > +       uint32_t vq_index;
>> > +       int notifier_fd;
>> > +       int pid;
>> > +};
>> > +
>> > +/* vq related data */
>> > +struct vq_data {
>> > +       uint32_t vq_index;
>> > +       uint64_t vq_pfns[16];
>> > +       uint64_t vq_pfn;
>> > +       struct eventfd_ctx *vq_notifiers[16];
>> > +       bool vq_notifiers_enabled;
>> > +};
>>
>> Please separate the userspace API from the internal API and put them
>> in separate header files. That way it's easy for userspace
>> implementors to understand what the API is without being distracted by
>> possibly changing kernel implementation details. struct eventfd_ctx is
>> internal to the kernel, so struct vq_data probably shouldn't be in a
>> uapi header file.
>
>
> Thanks for the suggestion, that can be fixed.
>
>>
>>
>> > +
>> > +/* Data describing each device private status */
>> > +struct device_data {
>> > +       /* Info needed for adapter ops */
>> > +       struct mmap_info *info;
>> > +       /* Waitqueue for the adapter */
>> > +       wait_queue_head_t wq;
>> > +       struct mutex read_write_lock;
>> > +       struct eventfd_ctx *efd_ctx;
>> > +       /*
>> > +        * If this variable is true then read/write should wait
>> > +        * the adapter to unlock this operation by sending an
>> > +        * eventfd. If it's equal to "false" then the operation
>> > +        * does not wait for adapter's confirmation.
>> > +        */
>> > +       bool valid_eventfd;
>> > +       /* vq data */
>> > +       struct vq_data vq_data;
>> > +};
>> > +
>> > +/* Data describing each entry of the driver */
>> > +struct loopback_devices_array {
>> > +       /* Array of probed devices */
>> > +       struct virtio_loopback_device *devices[MAX_PDEV];
>> > +       /* Number of available devices */
>> > +       atomic_t device_num;
>> > +       /* Registration completion */
>> > +       struct completion reg_vl_dev_completion[MAX_PDEV];
>> > +};
>> > +
>> > +/* Data concealed in the file private pointer */
>> > +struct file_priv_data {
>> > +       /* Device needed data */
>> > +       struct device_data *dev_data;
>> > +       /* mmap needed data */
>> > +       struct mmap_data *mm_data;
>> > +       /* Device info! */
>> > +       struct virtio_device_info_struct device_info;
>> > +       /* The vl_dev pointer for the irq */
>> > +       struct virtio_loopback_device *vl_dev_irq;
>> > +};
>> > +
>> > +struct virtio_loopback_device {
>> > +       struct virtio_device vdev;
>> > +       struct platform_device *pdev;
>> > +       /* Corresponding data pointer */
>> > +       struct device_data *data;
>> > +
>> > +       /* Status: -1 not initialized, 0 running, 1 paused */
>> > +       int status;
>> > +
>> > +       void __iomem *base;
>> > +       unsigned long version;
>> > +
>> > +       /* A list of queues so we can dispatch IRQs */
>> > +       spinlock_t lock;
>> > +       struct list_head virtqueues;
>> > +
>> > +       /* Define workqueue for notifications */
>> > +       struct workqueue_struct *notify_workqueue;
>> > +
>> > +       /* Notify list and work struct */
>> > +       spinlock_t notify_q_lock;
>> > +       struct list_head notify_list;
>> > +       struct work_struct notify_work;
>> > +};
>> > +
>> > +struct virtio_loopback_vq_info {
>> > +       /* the actual virtqueue */
>> > +       struct virtqueue *vq;
>> > +       /* the list node for the virtqueues list */
>> > +       struct list_head node;
>> > +};
>> > +
>> > +/* Notify data*/
>> > +struct notify_data {
>> > +       uint32_t index;
>> > +       struct list_head list;
>> > +};
>> > +
>> > +/* Shared data structure between driver and user-space application */
>> > +struct mmap_info {
>> > +       void *data;
>> > +       int reference;
>> > +};
>> > +
>> > +/*
>> > + * This structure holds the eventfds shared between the driver
>> > + * and the user-space application.
>> > + */
>> > +struct efd_data {
>> > +       int efd[2];
>> > +       int pid;
>> > +};
>> > +
>> > +/* device data holder, this structure may be extended to hold additio=
nal data */
>> > +struct loopback_device_data {
>> > +       /*device Major number */
>> > +       int dev_major;
>> > +       /* sysfs class structure */
>> > +       struct class *class;
>> > +       struct cdev cdev;
>> > +};
>> > +
>> > +/* Global variables */
>> > +extern struct platform_driver virtio_loopback_driver;
>> > +
>> > +/* Global functions */
>> > +int insert_entry_data(struct virtio_loopback_device *vl_dev, int id);
>> > +int loopback_register_virtio_dev(struct virtio_loopback_device *vl_de=
v);
>> > +bool vl_interrupt(struct virtio_loopback_device *vl_dev, int irq);
>> > +
>> > +#endif /* __LOOPBACK_H__ */
>> > --
>> > 2.34.1
>> >
>> >

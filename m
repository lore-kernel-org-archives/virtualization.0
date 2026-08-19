Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C93C4B64
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137184; cv=none; b=Yqr8zsBVgN+dLyBxXv4ySug1klLEmbk559FIVBA0nYW/jO05ABrKDxSdGR5DIaiDTbI76yHqD/P5r+4Bvg3+D+MKyXcms2nOYrM9W2QAOkaTWWakbKdLDrxJShR7lf2eecyqXoFYkiE3YOgTa/ImUAyOB3iNif8Z/+SmN0kOOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137184; c=relaxed/simple;
	bh=+7aoRXzOeu8FIbEeExEWaM1mpTFVchMIdLXPuBb02Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVtaRtGbUbLGWuHn7FxGDDIiF4kvRX3Spi6CTcylyalL0yGc8S9li4oFQE3XufyTofaAUcgy9ZjtHU3vHbVryocoZ4jqHZL34mw/0dvk8Ay9gOrADwMkl4Qv2QP46vDqOrOeLFTMvK3MvBWEiNQEhKIWSAsZ+8CGG0++V8p/cbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENc2ZZyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENc2ZZyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787137180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bQy85FYru0364i+TSYFxZMd8qb7YtUombC+riOJd5g=;
	b=ENc2ZZyNiUWzBYxeHOg/qvWzvc0IfhBP6U7lbfciP8KJ2zO5z541CYen7upvHrR1qw/wfs
	3KCrIQTBj8KuHafa74F0sBEgqTTgg6u1U3scaDlNi/ul17FUseZO9KVUn2pRkj26bXel/E
	y8BcXcbd3a37CCV7WRE1Ufr70ty7ht8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-LqhLCH-vOYWeqAcFa1JIYg-1; Wed, 19 Aug 2026 06:59:38 -0400
X-MC-Unique: LqhLCH-vOYWeqAcFa1JIYg-1
X-Mimecast-MFC-AGG-ID: LqhLCH-vOYWeqAcFa1JIYg_1787137178
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a7c64fbbc6so1284441b6e.2
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 03:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137178; x=1787741978;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bQy85FYru0364i+TSYFxZMd8qb7YtUombC+riOJd5g=;
        b=KbKE5wveo/khOxY2Q23hPSccBkCcXoYhXHZAAK1iH66G3L/pgOD7LsUXzZhJN+iDsy
         VknBV8YWQUAP+Le1BucePoIZG4CxYbaFh9qR5t6dSWUtO9m3ZBW8tHkZRVXvcJoi9ElP
         tu52l0Vxf4sFM9n6vCX/DAMJ5TmFTtfiAINJ7i8hKoolmZvD6LeuXPADf/dNEF/rM6Re
         7W9YGh+9N47k44NGUWbGtTtvknp77Wuc8u1gQwGLwvAJMmCXfykIoi3IUPChV4chf7K9
         wpAsW/KVwqVSckgCRGF22+33RJttEwy/f0HHACO4jxKqj0Vh2Pfk8ckKzeNWf9+sfqSQ
         mT1g==
X-Forwarded-Encrypted: i=1; AHgh+RoacxER48Q1XaWbebv7HzNCFCNrARv/EJdOhDXJmVCP2AqPUoCE0DYz4+RBi9XA6vhU7JwhTfURs+iZ2HtO3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLvjRrWvIxux1/aHcmmynnpzgLGSW9KCJ58adnsyALzsBPeaIx
	7tJ+eMhfbFhFaPwPJF2+2R0fMFTWM2okBqHH5MxCVqA4VSQX3USkwCcgnNmh2vGxOY+aoLYY9O/
	W2+nnO173GPTDPG4n5wjtHLKA+vHd5XcfRuGf9nEfIuEoQ0gGd+OYXhqMskS3/ZBh/WvruxKmZ1
	VwlLjmrgye1JsKVM1gJhaDBaCDTJOy9Bblx/ea6ZIRJYA=
X-Gm-Gg: AR+sD109FV0AIvGx8k4TYk9GPT07BXZX9NhluaW/wicJN5zFYXUI9nfUsxFtHMttYjr
	69vmd+0ykz34EFCnRj6RyJ3hSBrcfJeooKQO2ndmlWFXoH+nOzDOTSV+vkx5+zLPqchvc4TNJPu
	SijnpF3CK5y73qE0fyXAyyJmyRdRDZHockjZO/QTuCuPfHr6NoqZenv2g5ejzHP4GkFZ/ry9lle
	8akHDi+Fbl2ay5OPyDTH45PQuSGVMFOy8UhDuPvlFvuFUp/
X-Received: by 2002:a05:6808:5146:b0:48a:ddd4:d36f with SMTP id 5614622812f47-4b2bc95352fmr2912584b6e.8.1787137177547;
        Wed, 19 Aug 2026 03:59:37 -0700 (PDT)
X-Received: by 2002:a05:6808:5146:b0:48a:ddd4:d36f with SMTP id
 5614622812f47-4b2bc95352fmr2912525b6e.8.1787137176909; Wed, 19 Aug 2026
 03:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260813180026.2636879-1-briandaniels@google.com> <20260813180026.2636879-4-briandaniels@google.com>
In-Reply-To: <20260813180026.2636879-4-briandaniels@google.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Wed, 19 Aug 2026 12:59:25 +0200
X-Gm-Features: AcwNN1VhkG--rbbx_7RkbrR_lDL8MoyQcTUl58pPx5tJMjwfhpu-EuE1zc6XK4w
Message-ID: <CACzuRyxMR6sbpka-L5rGyBXdH+4dJYDw25uzLL6FqXn+4QH+UA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] media: virtio: Add scatterlist builder
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	laurent.pinchart@ideasonboard.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yIcxwUm0QJasudo-bPwF_Xmz7-3uxxADdKdiiX3UCfM_1787137178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Alexandre Courbot <gnurou@gmail.com>
> This patch adds the scatterlist builder, which is used to construct
> scatterlists for virtio commands from V4L2 structures.
> It adds drivers/media/virtio/scatterlist_builder.c and
> drivers/media/virtio/scatterlist_builder.h.
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>


 Tested-by: Dorinda Bassey <dbassey@redhat.com>


On Thu, Aug 13, 2026 at 8:00=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> From: Alexandre Courbot <gnurou@gmail.com>
>
> This patch adds the scatterlist builder, which is used to construct
> scatterlists for virtio commands from V4L2 structures.
>
> It adds drivers/media/virtio/scatterlist_builder.c and
> drivers/media/virtio/scatterlist_builder.h.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
>  drivers/media/virtio/Makefile              |   2 +-
>  drivers/media/virtio/scatterlist_builder.c | 515 +++++++++++++++++++++
>  drivers/media/virtio/scatterlist_builder.h | 109 +++++
>  3 files changed, 625 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/virtio/scatterlist_builder.c
>  create mode 100644 drivers/media/virtio/scatterlist_builder.h
>
> diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefil=
e
> index 09d9834da..8290d8506 100644
> --- a/drivers/media/virtio/Makefile
> +++ b/drivers/media/virtio/Makefile
> @@ -2,6 +2,6 @@
>  #
>  # Makefile for the virtio-media device driver.
>
> -virtio-media-objs :=3D virtio_media_driver.o
> +virtio-media-objs :=3D scatterlist_builder.o virtio_media_driver.o
>
>  obj-$(CONFIG_MEDIA_VIRTIO) +=3D virtio-media.o
> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> new file mode 100644
> index 000000000..97925b277
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -0,0 +1,515 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> +
> +/*
> + * Scatterlist builder helpers for virtio-media.
> + *
> + * Copyright (c) 2024-2026 Google LLC.
> + */
> +
> +#include <linux/moduleparam.h>
> +#include <linux/scatterlist.h>
> +#include <linux/videodev2.h>
> +#include <media/videobuf2-memops.h>
> +
> +#include "uapi/linux/virtio_media.h"
> +#include "scatterlist_builder.h"
> +#include "session.h"
> +
> +/*
> + * If set to %true, then the driver will always copy the data passed to =
the
> + * host into the shadow buffer (instead of trying to map the source memo=
ry into
> + * the SG table directly when possible).
> + */
> +static bool always_use_shadow_buffer;
> +module_param(always_use_shadow_buffer, bool, 0660);
> +
> +/* Convert a V4L2 IOCTL into the IOCTL code we can give to the host */
> +#define VIRTIO_MEDIA_IOCTL_CODE(IOCTL) (((IOCTL) >> _IOC_NRSHIFT) & _IOC=
_NRMASK)
> +
> +/**
> + * scatterlist_builder_add_descriptor() - Add a descriptor to the chain.
> + * @builder: builder to use.
> + * @desc_index: index of the descriptor to add.
> + *
> + * Returns %-ENOSPC if @builder->sgs is already full.
> + */
> +int scatterlist_builder_add_descriptor(struct scatterlist_builder *build=
er,
> +                                      size_t desc_index)
> +{
> +       if (builder->cur_sg >=3D builder->num_sgs)
> +               return -ENOSPC;
> +       builder->sgs[builder->cur_sg++] =3D &builder->descs[desc_index];
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_add_data() - Append arbitrary data to the descrip=
tor
> + *                                  chain.
> + * @builder: builder to use.
> + * @data: pointer to the data to add to the descriptor chain.
> + * @len: length of the data to add.
> + *
> + * @data will either be directly referenced, or copied into the shadow b=
uffer
> + * to be referenced from there.
> + */
> +int scatterlist_builder_add_data(struct scatterlist_builder *builder,
> +                                void *data, size_t len)
> +{
> +       const size_t cur_desc =3D builder->cur_desc;
> +
> +       if (len =3D=3D 0)
> +               return 0;
> +
> +       if (builder->cur_desc >=3D builder->num_descs)
> +               return -ENOSPC;
> +
> +       if (!always_use_shadow_buffer && virt_addr_valid(data + len)) {
> +               /*
> +                * If "data" is in the 1:1 physical memory mapping then w=
e can
> +                * use a single SG entry and avoid copying.
> +                */
> +               struct page *page =3D virt_to_page(data);
> +               size_t offset =3D (((size_t)data) & ~PAGE_MASK);
> +               struct scatterlist *next_desc =3D
> +                       &builder->descs[builder->cur_desc];
> +
> +               memset(next_desc, 0, sizeof(*next_desc));
> +               sg_set_page(next_desc, page, len, offset);
> +               builder->cur_desc++;
> +       } else if (!always_use_shadow_buffer && is_vmalloc_addr(data)) {
> +               int prev_pfn =3D -2;
> +
> +               /*
> +                * If "data" has been vmalloc'ed, we need at most one ent=
ry per
> +                * memory page but can avoid copying.
> +                */
> +               while (len > 0) {
> +                       struct page *page =3D vmalloc_to_page(data);
> +                       int cur_pfn =3D page_to_pfn(page);
> +                       /* All pages but the first will start at offset 0=
. */
> +                       unsigned long offset =3D
> +                               (((unsigned long)data) & ~PAGE_MASK);
> +                       size_t len_in_page =3D min(PAGE_SIZE - offset, le=
n);
> +                       struct scatterlist *next_desc =3D
> +                               &builder->descs[builder->cur_desc];
> +
> +                       if (builder->cur_desc >=3D builder->num_descs)
> +                               return -ENOSPC;
> +
> +                       /* Optimize contiguous pages */
> +                       if (cur_pfn =3D=3D prev_pfn + 1) {
> +                               (next_desc - 1)->length +=3D len_in_page;
> +                       } else {
> +                               memset(next_desc, 0, sizeof(*next_desc));
> +                               sg_set_page(next_desc, page, len_in_page,
> +                                           offset);
> +                               builder->cur_desc++;
> +                       }
> +                       data +=3D len_in_page;
> +                       len -=3D len_in_page;
> +                       prev_pfn =3D cur_pfn;
> +               }
> +       } else {
> +               /*
> +                * As a last resort, copy into the shadow buffer and refe=
rence
> +                * it with a single SG entry. Calling
> +                * scatterlist_builder_retrieve_data() will be necessary =
to copy
> +                * the data written by the device back into @data.
> +                */
> +               void *shadow_buffer =3D
> +                       builder->shadow_buffer + builder->shadow_buffer_p=
os;
> +               struct page *page =3D virt_to_page(shadow_buffer);
> +               unsigned long offset =3D
> +                       (((unsigned long)shadow_buffer) & ~PAGE_MASK);
> +               struct scatterlist *next_desc =3D
> +                       &builder->descs[builder->cur_desc];
> +
> +               if (len >
> +                   builder->shadow_buffer_size - builder->shadow_buffer_=
pos)
> +                       return -ENOSPC;
> +
> +               memcpy(shadow_buffer, data, len);
> +               memset(next_desc, 0, sizeof(*next_desc));
> +               sg_set_page(next_desc, page, len, offset);
> +               builder->cur_desc++;
> +               builder->shadow_buffer_pos +=3D len;
> +       }
> +
> +       sg_mark_end(&builder->descs[builder->cur_desc - 1]);
> +       return scatterlist_builder_add_descriptor(builder, cur_desc);
> +}
> +
> +/**
> + * scatterlist_builder_retrieve_data() - Retrieve a response written by =
the
> + *                                       device on the shadow buffer.
> + * @builder: builder to use.
> + * @sg_index: index of the descriptor to read from.
> + * @data: destination for the shadowed data.
> + *
> + * If the shadow buffer is pointed to by the descriptor at index @sg_ind=
ex of
> + * the chain, then ``sg->length`` bytes are copied back from it into @da=
ta.
> + * Otherwise nothing is done since the device has written into @data dir=
ectly.
> + *
> + * @data must have originally been added by scatterlist_builder_add_data=
() as
> + * the same size as passed to scatterlist_builder_add_data() will be cop=
ied
> + * back.
> + */
> +int scatterlist_builder_retrieve_data(struct scatterlist_builder *builde=
r,
> +                                     size_t sg_index, void *data)
> +{
> +       void *shadow_buf =3D builder->shadow_buffer;
> +       struct scatterlist *sg;
> +       void *kaddr;
> +
> +       /* We can only retrieve from the range of sgs currently set. */
> +       if (sg_index >=3D builder->cur_sg)
> +               return -ERANGE;
> +
> +       sg =3D builder->sgs[sg_index];
> +       kaddr =3D pfn_to_kaddr(page_to_pfn(sg_page(sg))) + sg->offset;
> +
> +       if (kaddr >=3D shadow_buf &&
> +           kaddr < shadow_buf + VIRTIO_SHADOW_BUF_SIZE) {
> +               if (kaddr + sg->length >=3D shadow_buf + VIRTIO_SHADOW_BU=
F_SIZE)
> +                       return -EINVAL;
> +
> +               memcpy(data, kaddr, sg->length);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_add_ioctl_cmd() - Add an ioctl command to the des=
criptor
> + *                                       chain.
> + * @builder: builder to use.
> + * @session: session on behalf of which the ioctl command is added.
> + * @ioctl_code: code of the ioctl to add (i.e. ``VIDIOC_*``).
> + */
> +int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builde=
r,
> +                                     struct virtio_media_session *sessio=
n,
> +                                     u32 ioctl_code)
> +{
> +       struct virtio_media_cmd_ioctl *cmd_ioctl =3D &session->cmd.ioctl;
> +
> +       cmd_ioctl->hdr.cmd =3D VIRTIO_MEDIA_CMD_IOCTL;
> +       cmd_ioctl->session_id =3D session->id;
> +       cmd_ioctl->code =3D VIRTIO_MEDIA_IOCTL_CODE(ioctl_code);
> +
> +       return scatterlist_builder_add_data(builder, cmd_ioctl,
> +                                           sizeof(*cmd_ioctl));
> +}
> +
> +/**
> + * scatterlist_builder_add_ioctl_resp() - Add storage to receive an ioct=
l
> + *                                        response to the descriptor cha=
in.
> + * @builder: builder to use.
> + * @session: session on behalf of which the ioctl response is added.
> + */
> +int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *build=
er,
> +                                      struct virtio_media_session *sessi=
on)
> +{
> +       struct virtio_media_resp_ioctl *resp_ioctl =3D &session->resp.ioc=
tl;
> +
> +       return scatterlist_builder_add_data(builder, resp_ioctl,
> +                                           sizeof(*resp_ioctl));
> +}
> +
> +/**
> + * __scatterlist_builder_add_userptr() - Add user pages to @builder.
> + * @builder: builder to use.
> + * @userptr: pointer to userspace memory that we want to add.
> + * @length: length of the data to add.
> + * @sg_list: output parameter. Upon success, points to the area of the s=
hadow
> + *           buffer containing the array of SG entries to be added to th=
e
> + *           descriptor chain.
> + * @nents: output parameter. Upon success, contains the number of entrie=
s
> + *         pointed to by @sg_list.
> + *
> + * Data referenced by userspace pointers can be potentially large and ve=
ry
> + * scattered, which could overwhelm the descriptor chain if added as-is.=
 For
> + * these, we instead build an array of &struct virtio_media_sg_entry in =
the
> + * shadow buffer and reference it using a single descriptor.
> + *
> + * This function is a helper to perform that. Callers should then add th=
e
> + * descriptor to the chain properly.
> + *
> + * Returns %-EFAULT if @userptr is not a valid user address, which is a =
case the
> + * driver should consider as "normal" operation. All other failures sign=
al a
> + * problem with the driver.
> + */
> +static int
> +__scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
> +                                 unsigned long userptr, unsigned long le=
ngth,
> +                                 struct virtio_media_sg_entry **sg_list,
> +                                 int *nents)
> +{
> +       struct sg_table sg_table =3D {};
> +       struct frame_vector *framevec;
> +       struct scatterlist *sg_iter;
> +       struct page **pages;
> +       const unsigned int offset =3D userptr & ~PAGE_MASK;
> +       unsigned int pages_count;
> +       size_t entries_size;
> +       int i;
> +       int ret;
> +
> +       framevec =3D vb2_create_framevec(userptr, length, true);
> +       if (IS_ERR(framevec)) {
> +               if (PTR_ERR(framevec) !=3D -EFAULT) {
> +                       pr_warn("error %ld creating frame vector for user=
ptr 0x%lx, length 0x%lx\n",
> +                               PTR_ERR(framevec), userptr, length);
> +               } else {
> +                       /* -EINVAL is expected in case of invalid userptr=
. */
> +                       framevec =3D ERR_PTR(-EINVAL);
> +               }
> +               return PTR_ERR(framevec);
> +       }
> +
> +       pages =3D frame_vector_pages(framevec);
> +       if (IS_ERR(pages)) {
> +               pr_warn("error getting vector pages\n");
> +               ret =3D PTR_ERR(pages);
> +               goto done;
> +       }
> +       pages_count =3D frame_vector_count(framevec);
> +       ret =3D sg_alloc_table_from_pages(&sg_table, pages, pages_count, =
offset,
> +                                       length, 0);
> +       if (ret) {
> +               pr_warn("error creating sg table\n");
> +               goto done;
> +       }
> +
> +       /* Allocate our actual SG in the shadow buffer. */
> +       *nents =3D sg_nents(sg_table.sgl);
> +       entries_size =3D sizeof(**sg_list) * *nents;
> +       if (builder->shadow_buffer_pos + entries_size >
> +           builder->shadow_buffer_size) {
> +               ret =3D -ENOMEM;
> +               goto free_sg;
> +       }
> +
> +       *sg_list =3D builder->shadow_buffer + builder->shadow_buffer_pos;
> +       builder->shadow_buffer_pos +=3D entries_size;
> +
> +       for_each_sgtable_sg(&sg_table, sg_iter, i) {
> +               struct virtio_media_sg_entry *sg_entry =3D &(*sg_list)[i]=
;
> +
> +               sg_entry->start =3D sg_phys(sg_iter);
> +               sg_entry->len =3D sg_iter->length;
> +       }
> +
> +free_sg:
> +       sg_free_table(&sg_table);
> +
> +done:
> +       vb2_destroy_framevec(framevec);
> +       return ret;
> +}
> +
> +/**
> + * scatterlist_builder_add_userptr() - Add a user-memory buffer using an=
 array
> + *                                     of &struct virtio_media_sg_entry.
> + * @builder: builder to use.
> + * @userptr: pointer to userspace memory that we want to add.
> + * @length: length of the data to add.
> + *
> + * Upon success, an array of &struct virtio_media_sg_entry referencing
> + * @userptr has been built into the shadow buffer, and that array added =
to the
> + * descriptor chain.
> + */
> +static int scatterlist_builder_add_userptr(struct scatterlist_builder *b=
uilder,
> +                                          unsigned long userptr,
> +                                          unsigned long length)
> +{
> +       int ret;
> +       int nents;
> +       struct virtio_media_sg_entry *sg_list;
> +
> +       ret =3D __scatterlist_builder_add_userptr(builder, userptr, lengt=
h,
> +                                               &sg_list, &nents);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D scatterlist_builder_add_data(builder, sg_list,
> +                                          sizeof(*sg_list) * nents);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_add_buffer() - Add a &struct v4l2_buffer and its =
planes
> + *                                    to the descriptor chain.
> + * @builder: builder to use.
> + * @b: &struct v4l2_buffer to add.
> + */
> +int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
> +                                  struct v4l2_buffer *b)
> +{
> +       int ret;
> +
> +       /* v4l2_buffer */
> +       ret =3D scatterlist_builder_add_data(builder, b, sizeof(*b));
> +       if (ret)
> +               return ret;
> +
> +       if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
> +               /* Array of v4l2_planes */
> +               ret =3D scatterlist_builder_add_data(builder, b->m.planes=
,
> +                                                  sizeof(struct v4l2_pla=
ne) *
> +                                                          b->length);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_retrieve_buffer() - Retrieve a &struct v4l2_buffe=
r
> + *                                         written by the device on the =
shadow
> + *                                         buffer, if needed.
> + * @builder: builder to use.
> + * @sg_index: index of the first SG entry of the buffer in the builder's
> + *            descriptor chain.
> + * @b: &struct v4l2_buffer to copy shadow buffer data into.
> + * @orig_planes: the original ``planes`` pointer, to be restored if the =
buffer
> + *               is multi-planar.
> + *
> + * If the &struct v4l2_buffer pointed to by @sg_index was copied into th=
e
> + * shadow buffer, then its updated content is copied back into @b.
> + * Otherwise nothing is done as the device has written into @b directly.
> + *
> + * @orig_planes is used to restore the original ``planes`` pointer in ca=
se it
> + * gets modified by the host. The specification stipulates that the host=
 should
> + * not modify it, but we enforce this for additional safety.
> + */
> +int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *buil=
der,
> +                                       size_t sg_index, struct v4l2_buff=
er *b,
> +                                       struct v4l2_plane *orig_planes)
> +{
> +       int ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(builder, sg_index++, b)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
> +               b->m.planes =3D orig_planes;
> +
> +               if (orig_planes) {
> +                       ret =3D scatterlist_builder_retrieve_data(builder=
,
> +                                                               sg_index+=
+,
> +                                                               b->m.plan=
es);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_add_ext_ctrls() - Add a &struct v4l2_ext_controls=
 and its
> + *                                       controls to @builder.
> + * @builder: builder to use.
> + * @ctrls: &struct v4l2_ext_controls to add.
> + *
> + * Add @ctrls and its array of &struct v4l2_ext_control to the descripto=
r
> + * chain.
> + */
> +int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builde=
r,
> +                                     struct v4l2_ext_controls *ctrls)
> +{
> +       int ret;
> +
> +       /* v4l2_ext_controls */
> +       ret =3D scatterlist_builder_add_data(builder, ctrls, sizeof(*ctrl=
s));
> +       if (ret)
> +               return ret;
> +
> +       if (ctrls->count > 0) {
> +               /* array of v4l2_controls */
> +               ret =3D scatterlist_builder_add_data(builder, ctrls->cont=
rols,
> +                                                  sizeof(ctrls->controls=
[0]) *
> +                                                          ctrls->count);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_add_ext_ctrls_userptrs() - Add the userspace payl=
oads of
> + *                                                a &struct v4l2_ext_con=
trols
> + *                                                to the descriptor chai=
n.
> + * @builder: builder to use.
> + * @ctrls: &struct v4l2_ext_controls from which we want to add the
> + *         userspace payload.
> + *
> + * Add the userspace payloads of @ctrls to the descriptor chain. This is=
 split
> + * out of scatterlist_builder_add_ext_ctrls() because we only want to ad=
d
> + * these to the device-readable part of the descriptor chain.
> + */
> +int
> +scatterlist_builder_add_ext_ctrls_userptrs(struct scatterlist_builder *b=
uilder,
> +                                          struct v4l2_ext_controls *ctrl=
s)
> +{
> +       int i;
> +       int ret;
> +
> +       /* Pointers to user memory in individual controls */
> +       for (i =3D 0; i < ctrls->count; i++) {
> +               struct v4l2_ext_control *ctrl =3D &ctrls->controls[i];
> +
> +               if (ctrl->size > 0) {
> +                       unsigned long uptr =3D (unsigned long)ctrl->ptr;
> +
> +                       ret =3D scatterlist_builder_add_userptr(builder, =
uptr,
> +                                                             ctrl->size)=
;
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * scatterlist_builder_retrieve_ext_ctrls() - Retrieve controls written =
by the
> + *                                            device on the shadow buffe=
r,
> + *                                            if needed.
> + * @builder: builder to use.
> + * @sg_index: index of the first SG entry of the controls in the builder=
's
> + *            descriptor chain.
> + * @ctrls: &struct v4l2_ext_controls to copy shadow buffer data into.
> + *
> + * If the shadow buffer is pointed to by @sg_index, copy its content bac=
k into
> + * @ctrls.
> + */
> +int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *b=
uilder,
> +                                          size_t sg_index,
> +                                          struct v4l2_ext_controls *ctrl=
s)
> +{
> +       struct v4l2_ext_control *controls_backup =3D ctrls->controls;
> +       int ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(builder, sg_index++, ct=
rls);
> +       if (ret)
> +               return ret;
> +
> +       ctrls->controls =3D controls_backup;
> +
> +       if (ctrls->count > 0 && ctrls->controls) {
> +               ret =3D scatterlist_builder_retrieve_data(builder, sg_ind=
ex++,
> +                                                       ctrls->controls);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/v=
irtio/scatterlist_builder.h
> new file mode 100644
> index 000000000..47bfd7ae0
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> +
> +/*
> + * Scatterlist builder helpers for virtio-media.
> + *
> + * Copyright (c) 2024-2026 Google LLC.
> + */
> +
> +#ifndef __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
> +#define __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
> +
> +#include <linux/scatterlist.h>
> +
> +#include "session.h"
> +
> +/**
> + * struct scatterlist_builder - helper to build a scatterlist from data.
> + * @descs: pool of descriptors to use.
> + * @num_descs: number of entries in descs.
> + * @cur_desc: next descriptor to be used in @descs.
> + * @shadow_buffer: pointer to a shadow buffer where elements that cannot=
 be
> + * mapped directly into the scatterlist get copied.
> + * @shadow_buffer_size: size of @shadow_buffer.
> + * @shadow_buffer_pos: current position in @shadow_buffer.
> + * @sgs: descriptor chain to eventually pass to virtio functions.
> + * @num_sgs: total number of entries in @sgs.
> + * @cur_sg: next entry in @sgs to be used.
> + *
> + * Virtio passes data from the driver to the device (through e.g.
> + * virtqueue_add_sgs()) via a scatterlist that the device interprets as =
a
> + * linear view over scattered driver memory.
> + *
> + * In virtio-media, the payload of ioctls from user-space can for the mo=
st part
> + * be passed as-is, or after slight modification, which makes it temptin=
g to
> + * just forward the ioctl payload received from user-space as-is instead=
 of
> + * doing another copy into a dedicated buffer. This structure helps with=
 this.
> + *
> + * virtio-media descriptor chains are typically made of the following pa=
rts:
> + *
> + * Device-readable:
> + * - A command structure, i.e. ``virtio_media_cmd_*``,
> + * - An ioctl payload (one of the regular ioctl parameters),
> + * - (optionally) arrays of &struct virtio_media_sg_entry describing the
> + *   content of buffers in guest memory.
> + *
> + * Device-writable:
> + * - A response structure, i.e. ``virtio_media_resp_*``,
> + * - An ioctl payload, that the device will write to.
> + *
> + * This structure helps laying out the descriptor chain into its @sgs me=
mber in
> + * an optimal way, by building a scatterlist adapted to the originating =
memory
> + * of the data we want to pass to the device while avoiding copies when
> + * possible.
> + *
> + * It is made of a pool of &struct scatterlist (@descs) that is used to
> + * build the final descriptor chain @sgs, and a @shadow_buffer where dat=
a that
> + * cannot (or should not) be mapped directly by the host can be temporar=
ily
> + * copied.
> + */
> +struct scatterlist_builder {
> +       struct scatterlist *descs;
> +       size_t num_descs;
> +       size_t cur_desc;
> +
> +       void *shadow_buffer;
> +       size_t shadow_buffer_size;
> +       size_t shadow_buffer_pos;
> +
> +       struct scatterlist **sgs;
> +       size_t num_sgs;
> +       size_t cur_sg;
> +};
> +
> +int scatterlist_builder_add_descriptor(struct scatterlist_builder *build=
er,
> +                                      size_t desc_index);
> +
> +int scatterlist_builder_add_data(struct scatterlist_builder *builder,
> +                                void *data, size_t len);
> +
> +int scatterlist_builder_retrieve_data(struct scatterlist_builder *builde=
r,
> +                                     size_t sg_index, void *data);
> +
> +int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builde=
r,
> +                                     struct virtio_media_session *sessio=
n,
> +                                     u32 ioctl_code);
> +
> +int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *build=
er,
> +                                      struct virtio_media_session *sessi=
on);
> +
> +int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
> +                                  struct v4l2_buffer *buffer);
> +
> +int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *buil=
der,
> +                                       size_t sg_index,
> +                                       struct v4l2_buffer *buffer,
> +                                       struct v4l2_plane *orig_planes);
> +
> +int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builde=
r,
> +                                     struct v4l2_ext_controls *ctrls);
> +
> +int
> +scatterlist_builder_add_ext_ctrls_userptrs(struct scatterlist_builder *b=
uilder,
> +                                          struct v4l2_ext_controls *ctrl=
s);
> +
> +int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *b=
uilder,
> +                                          size_t sg_index,
> +                                          struct v4l2_ext_controls *ctrl=
s);
> +
> +#endif // __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
> --
> 2.55.0.737.g08866a6d13-goog
>


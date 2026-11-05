Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882662;
	b=5LiPTzz+sJo57aeIyhXzUxqyJ7PM354iqsOchdLSiks13qKFilmLBCirWtd5E79q8s3L
	 6DQmLtr9FKi0IufKcQq3aTLs3AC4zOO8MlMYhr8HL78M2HcJb0DhrwAU+x9nfPjtba9Gt
	 GdeMtvmBBsYd1o3tYhmMdUk1vklhCTwpo4Mqmwb0jBJSu2RdIZSEYzIm+x2RFf7Ci0zSz
	 JWUzwQMjkgC/tsMfnDK0sPr7jjw+sOU7kpRcHjwZN8ygBU2WfLStFX2Dxzhy28pmIzXiJ
	 O3bFfQs+JPLFQNGsoiTtqffhet2Agux+kUOiFuPlPLjEhJfA4p4t0cFPZcWv3tW5FAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882662;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=5b+jfDc050OGSY87YvTd77puTY+UECDC2Q6pZInu7AE=;
	b=qIG+1xrepU6H87MOE1wJfh5QrmnOYnha9vVP2DiOGoCtzL9F5vKMjFzVq5bE8pgLNWCo
	 j+92+7VgA/FvkpD2RwOhcaUwevXQpqjv0l5R8MIBtuiI3prX3xRk6s/TSPEML2//dGsok
	 veehiyQi9NRtTQFCar+HSrcOey4bNFCnA7oda3BhUKLDOTuH+9jcnfr0Nv6kzLfcsrD2D
	 TMd5sSOBd7x7ZtdgULuH7ZOvkylnTA2HfiugttV6Ot7qku+aEiTYwa4V4mHgXY6fYZneH
	 f6VXKcwyrpziHztiCNQO/T6c3eFplEegQD6xYhbrS33dNX50t3y9fpH1R5e5FNmJu6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W453FwaY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CC606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9CC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W453FwaY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793882659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b+jfDc050OGSY87YvTd77puTY+UECDC2Q6pZInu7AE=;
	b=W453FwaYrnBibCuKsQbrZk2iyJIhOfjT+fFpPdaiY43nvi9Arwsw4TjumH5P77HJAFqSOD
	i/n0IMVDl4gPllQAX8B4iiy1QHlaIDetuynkrSbC1caygoQYFGst1i4Kh2MmMKiWRflcse
	6ZSl7dUbmxnnxoazzou3RA/qJ3u9Nec=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-xBC5jgwXOgu4HiCRmyiDFQ-1; Thu, 05 Nov 2026 07:44:18 -0500
X-MC-Unique: xBC5jgwXOgu4HiCRmyiDFQ-1
X-Mimecast-MFC-AGG-ID: xBC5jgwXOgu4HiCRmyiDFQ_1793882658
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-54d6281f6dbso1902824b6e.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 04:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882657; x=1794487457;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5b+jfDc050OGSY87YvTd77puTY+UECDC2Q6pZInu7AE=;
        b=BFZXqWwtlOBdWU6a2ny/UvxE2eW1uJOGGRweZJ4gsn7KFFVCvXj/Ucm1bKtACNomJu
         1amhVDB4Fh6q3hs3b6X+poUB3FYt+rtT0/g0jjWO1dN6VQIv9SaL40U3vpsjHPH3AO5t
         YJ8ErWgctkNxN3dglnybDXyFuqV0eg00BClv8ERHw7+H7i4+6o4R16JGCKsCm2HRUGuJ
         vlPO9x6U+nIMrvHwc82yfBtkXItlrVZtaw00xIZWVjqw/vLXMawYMMlNTTWvhjcbxM1F
         +OCV/8D7zoBzyeuGVKHx5AV/GdVh737xGceqkVkDgmcYqU19+yIUIUBX/VcaScd1ZGmn
         2ywA==
X-Forwarded-Encrypted: i=1; AKwUvBxyoz7oQGWV9sSQLVBXyptRUZwF3MfCnRF7FQm/+swpuKQPjysDC9xKwHE6tQ9HY/owokp8Vt0GZnYN1IRlWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Jo89kuP8iPXc0Ry+wh960VpAdkI/T36EMGYDEFf7pyLGln1kv
	gRzU5NiHqNqz01LjUyfbaq24fqdz2lkigWk4fUsInacKeEuwtdPbLuuLb7rRNWDhVAHyds2Q5Uy
	Qhsr+nO7nJlDQpr63R05+cJE6eStPkFH7hFAPrxiqS9WK5Zd5RUJWKMVmEiktKnHT0wf/pyqIek
	nyfMVGU26UvpsdBgziTNsg98RapF3o3oiyn6gtZGTQEug=
X-Gm-Gg: AYBFou0TZF/QoIxBPI/K4HdiQka0GGmPq+OWUqm2eF92rMBO1HihsEDu5MTbSNZtvZY
	O4mayMCiq8Qmqcxydhs9CBEhc4UDqYTvNtmw9jyogBxN7XED/toyHMREac8hYPGudgJ/Xvc6jD2
	OYGXZYQCa9vZQ9p66kIj7bmFDwNVftMgbFVhpVaC8uksfy4Y2N8EGRq7ya
X-Received: by 2002:a05:6808:2396:b0:53f:3c0e:c74b with SMTP id 5614622812f47-5640d91a298mr14816589b6e.9.1793882657299;
        Thu, 05 Nov 2026 04:44:17 -0800 (PST)
X-Received: by 2002:a05:6808:2396:b0:53f:3c0e:c74b with SMTP id
 5614622812f47-5640d91a298mr14816545b6e.9.1793882656505; Thu, 05 Nov 2026
 04:44:16 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261029153038.3800747-1-briandaniels@google.com> <20261029153038.3800747-3-briandaniels@google.com>
In-Reply-To: <20261029153038.3800747-3-briandaniels@google.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 5 Nov 2026 13:44:03 +0100
X-Gm-Features: AclHuK-61BWQPxfxNpRKscWtZ6cy-wGNAtpooxoNbPI9PJlDWm77LheZv5xPeRc
Message-ID: <CADSE00+icnVREW397uxaixY=O-j_VNXrYjvoEHDNr91zKFpqPw@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] media: virtio: Add V4L2 ioctl forwarding infrastructure
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X1uPLmcaipQc9HuWzLhWBWlcUQI_6ZjmZsR_c96J8A4_1793882658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:31=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> From: Alexandre Courbot <gnurou@gmail.com>
>
> Introduce the scatterlist builder and synchronous V4L2 ioctl forwarding
> via VIRTIO_MEDIA_CMD_IOCTL.
>
> The scatterlist builder constructs virtio descriptor chains for ioctl
> commands and responses, mapping 1:1 kernel memory and vmalloc buffers
> directly into scatterlists when possible while falling back to a
> per-session shadow buffer otherwise.
>
> Use this infrastructure to implement VIDIOC_QUERYCAP from the virtio
> configuration space along with fixed-size read, write, and read-write
> V4L2 ioctls covering format negotiation, frame sizes and intervals,
> control and menu queries, inputs and outputs, audio, selection, video
> standards, tuners, and DV timings.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Assisted-by: LLM
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
>  drivers/media/virtio/Makefile              |   2 +-
>  drivers/media/virtio/scatterlist_builder.c | 222 ++++++++
>  drivers/media/virtio/scatterlist_builder.h |  90 +++
>  drivers/media/virtio/session.h             |  28 +-
>  drivers/media/virtio/virtio_media.h        |   9 +
>  drivers/media/virtio/virtio_media_driver.c |  24 +-
>  drivers/media/virtio/virtio_media_ioctls.c | 606 +++++++++++++++++++++
>  include/uapi/linux/virtio_media.h          |  43 ++
>  8 files changed, 1020 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/media/virtio/scatterlist_builder.c
>  create mode 100644 drivers/media/virtio/scatterlist_builder.h
>  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
>
> diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefil=
e
> index 09d9834da..f1bc8a3ce 100644
> --- a/drivers/media/virtio/Makefile
> +++ b/drivers/media/virtio/Makefile
> @@ -2,6 +2,6 @@
>  #
>  # Makefile for the virtio-media device driver.
>
> -virtio-media-objs :=3D virtio_media_driver.o
> +virtio-media-objs :=3D scatterlist_builder.o virtio_media_ioctls.o virti=
o_media_driver.o
>
>  obj-$(CONFIG_MEDIA_VIRTIO) +=3D virtio-media.o
> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> new file mode 100644
> index 000000000..ae8ffee82
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -0,0 +1,222 @@
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
> +       if (!always_use_shadow_buffer && virt_addr_valid(data) &&
> +           virt_addr_valid(data + len)) {
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
> +               bool prev_pfn_valid =3D false;
> +               unsigned long prev_pfn =3D 0;
> +
> +               /*
> +                * If "data" has been vmalloc'ed, we need at most one ent=
ry per
> +                * memory page but can avoid copying.
> +                */
> +               while (len > 0) {
> +                       struct page *page =3D vmalloc_to_page(data);
> +                       unsigned long cur_pfn =3D page_to_pfn(page);
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
> +                       if (prev_pfn_valid && (cur_pfn =3D=3D prev_pfn + =
1)) {
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
> +                       prev_pfn_valid =3D true;
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

Just a suggestion: scatterlist_builder_add_data() feels a bit
lengthy., and the if/else if branches could become their own static
helpers (also they have similar init + cur_desc++ sequence). Fine to
leave as is if you prefer.

Other than that, the patch looks good to me, so either way:

Reviewed-by: Albert Esteve <aesteve@redhat.com>

BR,
Albert

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
> +           kaddr < shadow_buf + builder->shadow_buffer_size) {
> +               if (kaddr + sg->length >
> +                   shadow_buf + builder->shadow_buffer_size)
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
> +       cmd_ioctl->hdr.__reserved =3D 0;
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
> diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/v=
irtio/scatterlist_builder.h
> new file mode 100644
> index 000000000..044ea409a
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.h
> @@ -0,0 +1,90 @@
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
> +#endif // __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
> diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/sessio=
n.h
> index 4ade7fb9c..6fe7ff5ae 100644
> --- a/drivers/media/virtio/session.h
> +++ b/drivers/media/virtio/session.h
> @@ -9,17 +9,32 @@
>  #ifndef __VIRTIO_MEDIA_SESSION_H
>  #define __VIRTIO_MEDIA_SESSION_H
>
> +#include <linux/scatterlist.h>
>  #include <media/v4l2-fh.h>
>
>  #include "uapi/linux/virtio_media.h"
>
> +/*
> + * Size of the per-session virtio shadow and event buffers. 16K should b=
e
> + * enough to contain everything we need.
> + */
> +#define VIRTIO_SHADOW_BUF_SIZE 0x4000
> +
>  /**
>   * struct virtio_media_session - A session on a virtio_media device.
>   * @fh: file handler for the session.
>   * @file: file pointer associated with the session's file handler.
>   * @id: session ID used to communicate with the device.
> - * @cmd: union of session-level commands. A session can have one command
> - *       currently running.
> + * @cmd: union of session commands ``close`` and ``ioctl``. A session ca=
n have
> + *       one command currently running. The rest of the commands are han=
dled by
> + *       &struct virtio_media.
> + * @resp: union of responses to session commands. A session can wait on =
one
> + *        command only. The rest of the responses are handled by
> + *        &struct virtio_media.
> + * @shadow_buf: shadow buffer where data to be added to the descriptor c=
hain can
> + *              be staged before being sent to the device.
> + * @command_sgs: SG table gathering descriptors for a given command and =
its
> + *               response.
>   * @list: link into the list of sessions for the device.
>   */
>  struct virtio_media_session {
> @@ -30,9 +45,18 @@ struct virtio_media_session {
>         __dma_from_device_group_begin();
>         union {
>                 struct virtio_media_cmd_close close;
> +               struct virtio_media_cmd_ioctl ioctl;
>         } cmd;
> +
> +       union {
> +               struct virtio_media_resp_ioctl ioctl;
> +       } resp;
>         __dma_from_device_group_end();
>
> +       void *shadow_buf;
> +
> +       struct sg_table command_sgs;
> +
>         struct list_head list;
>  };
>
> diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/v=
irtio_media.h
> index 68299377a..a120c1014 100644
> --- a/drivers/media/virtio/virtio_media.h
> +++ b/drivers/media/virtio/virtio_media.h
> @@ -14,6 +14,8 @@
>
>  #include "uapi/linux/virtio_media.h"
>
> +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> +
>  #define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
>
>  /**
> @@ -66,5 +68,12 @@ to_virtio_media(struct video_device *video_dev)
>  int virtio_media_send_command(struct virtio_media *vv, struct scatterlis=
t **sgs,
>                               const size_t out_sgs, const size_t in_sgs,
>                               size_t minimum_resp_len, size_t *resp_len);
> +
> +/* virtio_media_ioctls.c */
> +
> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +                              unsigned long arg);
> +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> +
>  #endif // __VIRTIO_MEDIA_H
>
> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 10073d863..2f2e95077 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
> @@ -37,10 +37,20 @@ static struct virtio_media_session *
>  virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
>  {
>         struct virtio_media_session *session;
> +       int ret;
>
>         session =3D kzalloc_obj(*session, GFP_KERNEL);
>         if (!session)
> -               return ERR_PTR(-ENOMEM);
> +               goto err_session;
> +
> +       session->shadow_buf =3D kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNE=
L);
> +       if (!session->shadow_buf)
> +               goto err_shadow_buf;
> +
> +       ret =3D sg_alloc_table(&session->command_sgs, DESC_CHAIN_MAX_LEN,
> +                            GFP_KERNEL);
> +       if (ret)
> +               goto err_payload_sgs;
>
>         // The caller is expected to set the ID once the host assigns a v=
alue.
>         session->id =3D 0;
> @@ -50,6 +60,13 @@ virtio_media_session_alloc(struct virtio_media *vv, st=
ruct file *file)
>         virtio_media_session_fh_add(session, file);
>
>         return session;
> +
> +err_payload_sgs:
> +       kfree(session->shadow_buf);
> +err_shadow_buf:
> +       kfree(session);
> +err_session:
> +       return ERR_PTR(-ENOMEM);
>  }
>
>  /**
> @@ -77,6 +94,9 @@ static void virtio_media_session_free(struct virtio_med=
ia_session *session)
>         virtio_media_session_fh_del(session);
>         v4l2_fh_exit(&session->fh);
>
> +       sg_free_table(&session->command_sgs);
> +
> +       kfree(session->shadow_buf);
>         kfree(session);
>  }
>
> @@ -342,6 +362,7 @@ static const struct v4l2_file_operations virtio_media=
_fops =3D {
>         .owner =3D THIS_MODULE,
>         .open =3D virtio_media_device_open,
>         .release =3D virtio_media_device_close,
> +       .unlocked_ioctl =3D virtio_media_device_ioctl,
>  };
>
>  static void virtio_media_release(struct v4l2_device *v4l2_dev)
> @@ -394,6 +415,7 @@ static int virtio_media_probe(struct virtio_device *v=
irtio_dev)
>
>         vd =3D &vv->video_dev;
>         vd->v4l2_dev =3D &vv->v4l2_dev;
> +       vd->ioctl_ops =3D &virtio_media_ioctl_ops;
>         vd->fops =3D &virtio_media_fops;
>         vd->release =3D video_device_release_empty;
>         strscpy(vd->name, "virtio-media", sizeof(vd->name));
> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 000000000..656ecea8a
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
> @@ -0,0 +1,606 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> +
> +/*
> + * Ioctl implementations for the virtio-media driver.
> + *
> + * Copyright (c) 2024-2026 Google LLC.
> + */
> +
> +#include <linux/mutex.h>
> +#include <linux/videodev2.h>
> +#include <linux/virtio_config.h>
> +#include <media/v4l2-ioctl.h>
> +
> +#include "scatterlist_builder.h"
> +#include "virtio_media.h"
> +
> +/**
> + * virtio_media_send_r_ioctl() - Send a read-only ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + *
> + * Send an ioctl that has no driver payload, but expects a response from=
 the
> + * host (i.e. an ioctl specified with ``_IOR``).
> + */
> +static int virtio_media_send_r_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                    void *ioctl_data, size_t ioctl_data_=
len)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[3];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload */
> +       ret =3D scatterlist_builder_add_data(&builder, ioctl_data,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 1, 2,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                       ioctl_data_len, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(&builder, 2, ioctl_data=
);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to retrieve response descriptor chain\n"=
);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_w_ioctl() - Send a write-only ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + *
> + * Send an ioctl that does not expect a reply beyond an error status (i.=
e. an
> + * ioctl specified with ``_IOW``) to the host.
> + */
> +static int virtio_media_send_w_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                    const void *ioctl_data,
> +                                    size_t ioctl_data_len)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[3];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Command payload */
> +       ret =3D scatterlist_builder_add_data(&builder, (void *)ioctl_data=
,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 2, 1,
> +                                       sizeof(struct virtio_media_resp_i=
octl),
> +                                       NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_wr_ioctl() - Send a read-write ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + * @minimum_resp_payload: minimum expected length of the response's payl=
oad.
> + *
> + * Sends an ioctl that expects a response of exactly the same size as th=
e
> + * input (i.e. an ioctl specified with ``_IOWR``) to the host.
> + *
> + * This corresponds to what most V4L2 ioctls do. For instance
> + * ``VIDIOC_ENUM_FMT`` takes a partially-initialized &struct v4l2_fmtdes=
c
> + * and returns its filled version.
> + */
> +static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                     void *ioctl_data, size_t ioctl_data=
_len,
> +                                     size_t minimum_resp_payload)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[4];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Command payload */
> +       ret =3D scatterlist_builder_add_data(&builder, ioctl_data,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload, same as command */
> +       ret =3D scatterlist_builder_add_descriptor(&builder, 1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 2, 2,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                               minimum_resp_payload,
> +                                       NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(&builder, 3, ioctl_data=
);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to retrieve response descriptor chain\n"=
);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Macros suitable for defining ioctls with a constant size payload.
> + */
> +
> +#define SIMPLE_WR_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,   \
> +                                      payload_t *payload)            \
> +       {                                                             \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);          \
> +               return virtio_media_send_wr_ioctl(vfh, ioctl, payload,\
> +                                                 sizeof(*payload),   \
> +                                                 sizeof(*payload));  \
> +       }
> +#define SIMPLE_R_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,  \
> +                                      payload_t *payload)           \
> +       {                                                            \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);         \
> +               return virtio_media_send_r_ioctl(vfh, ioctl, payload,\
> +                                                sizeof(*payload));  \
> +       }
> +#define SIMPLE_W_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,  \
> +                                      payload_t *payload)           \
> +       {                                                            \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);         \
> +               return virtio_media_send_w_ioctl(vfh, ioctl, payload,\
> +                                                sizeof(*payload));  \
> +       }
> +
> +/*
> + * V4L2 ioctl handlers.
> + *
> + * Most of these functions just forward the ioctl to the host, for these=
 we can
> + * use one of the SIMPLE_*_IOCTL macros. Exceptions that have their own
> + * standalone function follow.
> + */
> +
> +SIMPLE_WR_IOCTL(enum_fmt, VIDIOC_ENUM_FMT, struct v4l2_fmtdesc)
> +SIMPLE_WR_IOCTL(g_fmt, VIDIOC_G_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(s_fmt, VIDIOC_S_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(try_fmt, VIDIOC_TRY_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(enum_framesizes, VIDIOC_ENUM_FRAMESIZES,
> +               struct v4l2_frmsizeenum)
> +SIMPLE_WR_IOCTL(enum_frameintervals, VIDIOC_ENUM_FRAMEINTERVALS,
> +               struct v4l2_frmivalenum)
> +SIMPLE_WR_IOCTL(query_ext_ctrl, VIDIOC_QUERY_EXT_CTRL,
> +               struct v4l2_query_ext_ctrl)
> +SIMPLE_WR_IOCTL(s_dv_timings, VIDIOC_S_DV_TIMINGS, struct v4l2_dv_timing=
s)
> +SIMPLE_WR_IOCTL(g_dv_timings, VIDIOC_G_DV_TIMINGS, struct v4l2_dv_timing=
s)
> +SIMPLE_R_IOCTL(query_dv_timings, VIDIOC_QUERY_DV_TIMINGS,
> +              struct v4l2_dv_timings)
> +SIMPLE_WR_IOCTL(enum_dv_timings, VIDIOC_ENUM_DV_TIMINGS,
> +               struct v4l2_enum_dv_timings)
> +SIMPLE_WR_IOCTL(dv_timings_cap, VIDIOC_DV_TIMINGS_CAP,
> +               struct v4l2_dv_timings_cap)
> +SIMPLE_WR_IOCTL(enuminput, VIDIOC_ENUMINPUT, struct v4l2_input)
> +SIMPLE_WR_IOCTL(querymenu, VIDIOC_QUERYMENU, struct v4l2_querymenu)
> +SIMPLE_WR_IOCTL(enumoutput, VIDIOC_ENUMOUTPUT, struct v4l2_output)
> +SIMPLE_WR_IOCTL(enumaudio, VIDIOC_ENUMAUDIO, struct v4l2_audio)
> +SIMPLE_R_IOCTL(g_audio, VIDIOC_G_AUDIO, struct v4l2_audio)
> +SIMPLE_W_IOCTL(s_audio, VIDIOC_S_AUDIO, const struct v4l2_audio)
> +SIMPLE_WR_IOCTL(enumaudout, VIDIOC_ENUMAUDOUT, struct v4l2_audioout)
> +SIMPLE_R_IOCTL(g_audout, VIDIOC_G_AUDOUT, struct v4l2_audioout)
> +SIMPLE_W_IOCTL(s_audout, VIDIOC_S_AUDOUT, const struct v4l2_audioout)
> +SIMPLE_WR_IOCTL(g_modulator, VIDIOC_G_MODULATOR, struct v4l2_modulator)
> +SIMPLE_W_IOCTL(s_modulator, VIDIOC_S_MODULATOR, const struct v4l2_modula=
tor)
> +SIMPLE_WR_IOCTL(g_selection, VIDIOC_G_SELECTION, struct v4l2_selection)
> +SIMPLE_WR_IOCTL(s_selection, VIDIOC_S_SELECTION, struct v4l2_selection)
> +SIMPLE_R_IOCTL(g_enc_index, VIDIOC_G_ENC_INDEX, struct v4l2_enc_idx)
> +SIMPLE_WR_IOCTL(encoder_cmd, VIDIOC_ENCODER_CMD, struct v4l2_encoder_cmd=
)
> +SIMPLE_WR_IOCTL(try_encoder_cmd, VIDIOC_TRY_ENCODER_CMD,
> +               struct v4l2_encoder_cmd)
> +SIMPLE_WR_IOCTL(try_decoder_cmd, VIDIOC_TRY_DECODER_CMD,
> +               struct v4l2_decoder_cmd)
> +SIMPLE_WR_IOCTL(g_parm, VIDIOC_G_PARM, struct v4l2_streamparm)
> +SIMPLE_WR_IOCTL(s_parm, VIDIOC_S_PARM, struct v4l2_streamparm)
> +SIMPLE_R_IOCTL(g_std, VIDIOC_G_STD, v4l2_std_id)
> +SIMPLE_R_IOCTL(querystd, VIDIOC_QUERYSTD, v4l2_std_id)
> +SIMPLE_WR_IOCTL(enumstd, VIDIOC_ENUMSTD, struct v4l2_standard)
> +SIMPLE_WR_IOCTL(g_tuner, VIDIOC_G_TUNER, struct v4l2_tuner)
> +SIMPLE_W_IOCTL(s_tuner, VIDIOC_S_TUNER, const struct v4l2_tuner)
> +SIMPLE_WR_IOCTL(g_frequency, VIDIOC_G_FREQUENCY, struct v4l2_frequency)
> +SIMPLE_W_IOCTL(s_frequency, VIDIOC_S_FREQUENCY, const struct v4l2_freque=
ncy)
> +SIMPLE_WR_IOCTL(enum_freq_bands, VIDIOC_ENUM_FREQ_BANDS,
> +               struct v4l2_frequency_band)
> +SIMPLE_WR_IOCTL(g_sliced_vbi_cap, VIDIOC_G_SLICED_VBI_CAP,
> +               struct v4l2_sliced_vbi_cap)
> +SIMPLE_W_IOCTL(s_hw_freq_seek, VIDIOC_S_HW_FREQ_SEEK,
> +              const struct v4l2_hw_freq_seek)
> +
> +/*
> + * QUERYCAP is handled by reading the configuration area.
> + */
> +
> +static int virtio_media_querycap(struct file *file, void *fh,
> +                                struct v4l2_capability *cap)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +
> +       strscpy(cap->bus_info, "platform:virtio-media");
> +       strscpy(cap->driver, VIRTIO_MEDIA_DEFAULT_DRIVER_NAME);
> +
> +       virtio_cread_bytes(vv->virtio_dev, 8, cap->card, sizeof(cap->card=
));
> +
> +       cap->capabilities =3D video_dev->device_caps | V4L2_CAP_DEVICE_CA=
PS;
> +       cap->device_caps =3D video_dev->device_caps;
> +
> +       return 0;
> +}
> +
> +/*
> + * s/g_input/output work with an unsigned int - recast this to a u32 so =
the
> + * size is unambiguous.
> + */
> +
> +static int virtio_media_g_input(struct file *file, void *fh, unsigned in=
t *i)
> +{
> +       u32 input;
> +
> +       int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                        VIDIOC_G_INPUT, &input,
> +                                        sizeof(input), sizeof(input));
> +       if (ret)
> +               return ret;
> +
> +       *i =3D input;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_s_input(struct file *file, void *fh, unsigned in=
t i)
> +{
> +       u32 input =3D i;
> +
> +       return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                         VIDIOC_S_INPUT, &input,
> +                                         sizeof(input), sizeof(input));
> +}
> +
> +static int virtio_media_g_output(struct file *file, void *fh, unsigned i=
nt *o)
> +{
> +       u32 output;
> +
> +       int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                        VIDIOC_G_OUTPUT, &output,
> +                                        sizeof(output), sizeof(output));
> +       if (ret)
> +               return ret;
> +
> +       *o =3D output;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_s_output(struct file *file, void *fh, unsigned i=
nt o)
> +{
> +       u32 output =3D o;
> +
> +       return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                         VIDIOC_S_OUTPUT, &output,
> +                                         sizeof(output), sizeof(output))=
;
> +}
> +
> +/*
> + * s_std doesn't work with a pointer, so we cannot use SIMPLE_W_IOCTL.
> + */
> +
> +static int virtio_media_s_std(struct file *file, void *fh, v4l2_std_id s=
)
> +{
> +       int ret =3D virtio_media_send_w_ioctl(file_to_v4l2_fh(file), VIDI=
OC_S_STD,
> +                                       &s, sizeof(s));
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +const struct v4l2_ioctl_ops virtio_media_ioctl_ops =3D {
> +       /* VIDIOC_QUERYCAP handler */
> +       .vidioc_querycap =3D virtio_media_querycap,
> +
> +       /* VIDIOC_ENUM_FMT handlers */
> +       .vidioc_enum_fmt_vid_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_vid_overlay =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_vid_out =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_sdr_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_sdr_out =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_meta_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_meta_out =3D virtio_media_enum_fmt,
> +
> +       /* VIDIOC_G_FMT handlers */
> +       .vidioc_g_fmt_vid_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_overlay =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out_overlay =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vbi_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vbi_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sliced_vbi_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sliced_vbi_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_cap_mplane =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out_mplane =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sdr_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sdr_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_meta_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_meta_out =3D virtio_media_g_fmt,
> +
> +       /* VIDIOC_S_FMT handlers */
> +       .vidioc_s_fmt_vid_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_overlay =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out_overlay =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vbi_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vbi_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sliced_vbi_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sliced_vbi_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_cap_mplane =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out_mplane =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sdr_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sdr_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_meta_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_meta_out =3D virtio_media_s_fmt,
> +
> +       /* VIDIOC_TRY_FMT handlers */
> +       .vidioc_try_fmt_vid_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_overlay =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out_overlay =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vbi_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vbi_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sliced_vbi_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sliced_vbi_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_cap_mplane =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out_mplane =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sdr_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sdr_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_meta_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_meta_out =3D virtio_media_try_fmt,
> +
> +       /* Standard handling */
> +       .vidioc_g_std =3D virtio_media_g_std,
> +       .vidioc_s_std =3D virtio_media_s_std,
> +       .vidioc_querystd =3D virtio_media_querystd,
> +
> +       /* Input handling */
> +       .vidioc_enum_input =3D virtio_media_enuminput,
> +       .vidioc_g_input =3D virtio_media_g_input,
> +       .vidioc_s_input =3D virtio_media_s_input,
> +
> +       /* Output handling */
> +       .vidioc_enum_output =3D virtio_media_enumoutput,
> +       .vidioc_g_output =3D virtio_media_g_output,
> +       .vidioc_s_output =3D virtio_media_s_output,
> +
> +       /* Control handling */
> +       .vidioc_query_ext_ctrl =3D virtio_media_query_ext_ctrl,
> +       .vidioc_querymenu =3D virtio_media_querymenu,
> +
> +       /* Audio ioctls */
> +       .vidioc_enumaudio =3D virtio_media_enumaudio,
> +       .vidioc_g_audio =3D virtio_media_g_audio,
> +       .vidioc_s_audio =3D virtio_media_s_audio,
> +
> +       /* Audio out ioctls */
> +       .vidioc_enumaudout =3D virtio_media_enumaudout,
> +       .vidioc_g_audout =3D virtio_media_g_audout,
> +       .vidioc_s_audout =3D virtio_media_s_audout,
> +       .vidioc_g_modulator =3D virtio_media_g_modulator,
> +       .vidioc_s_modulator =3D virtio_media_s_modulator,
> +
> +       /* Crop ioctls */
> +       /*
> +        * Not directly an ioctl (part of VIDIOC_CROPCAP), so no need to
> +        * implement.
> +        */
> +       .vidioc_g_pixelaspect =3D NULL,
> +       .vidioc_g_selection =3D virtio_media_g_selection,
> +       .vidioc_s_selection =3D virtio_media_s_selection,
> +
> +       /* Compression ioctls */
> +       /* Deprecated in V4L2. */
> +       .vidioc_g_jpegcomp =3D NULL,
> +       /* Deprecated in V4L2. */
> +       .vidioc_s_jpegcomp =3D NULL,
> +       .vidioc_g_enc_index =3D virtio_media_g_enc_index,
> +       .vidioc_encoder_cmd =3D virtio_media_encoder_cmd,
> +       .vidioc_try_encoder_cmd =3D virtio_media_try_encoder_cmd,
> +       .vidioc_try_decoder_cmd =3D virtio_media_try_decoder_cmd,
> +
> +       /* Stream type-dependent parameter ioctls */
> +       .vidioc_g_parm =3D virtio_media_g_parm,
> +       .vidioc_s_parm =3D virtio_media_s_parm,
> +
> +       /* Tuner ioctls */
> +       .vidioc_g_tuner =3D virtio_media_g_tuner,
> +       .vidioc_s_tuner =3D virtio_media_s_tuner,
> +       .vidioc_g_frequency =3D virtio_media_g_frequency,
> +       .vidioc_s_frequency =3D virtio_media_s_frequency,
> +       .vidioc_enum_freq_bands =3D virtio_media_enum_freq_bands,
> +
> +       /* Sliced VBI cap */
> +       .vidioc_g_sliced_vbi_cap =3D virtio_media_g_sliced_vbi_cap,
> +
> +       /* Log status ioctl */
> +       /* Guest-only operation */
> +       .vidioc_log_status =3D NULL,
> +
> +       .vidioc_s_hw_freq_seek =3D virtio_media_s_hw_freq_seek,
> +
> +       .vidioc_enum_framesizes =3D virtio_media_enum_framesizes,
> +       .vidioc_enum_frameintervals =3D virtio_media_enum_frameintervals,
> +
> +       /* DV Timings IOCTLs */
> +       .vidioc_s_dv_timings =3D virtio_media_s_dv_timings,
> +       .vidioc_g_dv_timings =3D virtio_media_g_dv_timings,
> +       .vidioc_query_dv_timings =3D virtio_media_query_dv_timings,
> +       .vidioc_enum_dv_timings =3D virtio_media_enum_dv_timings,
> +       .vidioc_dv_timings_cap =3D virtio_media_dv_timings_cap,
> +       .vidioc_g_edid =3D NULL,
> +       .vidioc_s_edid =3D NULL,
> +
> +       /* For other private ioctls */
> +       .vidioc_default =3D NULL,
> +};
> +
> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +                              unsigned long arg)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct v4l2_fh *vfh =3D NULL;
> +       struct v4l2_standard standard;
> +       v4l2_std_id std_id =3D 0;
> +       int ret;
> +
> +       if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
> +               vfh =3D file_to_v4l2_fh(file);
> +
> +       mutex_lock(&vv->vlock);
> +
> +       /*
> +        * We need to handle a few ioctls manually because their results
> +        * rely on vfd->tvnorms, which is normally updated by the driver
> +        * as S_INPUT is called. Since we want to just pass these ioctls
> +        * through, we have to hijack them from here.
> +        */
> +       switch (cmd) {
> +       case VIDIOC_S_STD:
> +               ret =3D copy_from_user(&std_id, (void __user *)arg,
> +                                    sizeof(std_id));
> +               if (ret) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +               ret =3D virtio_media_s_std(file, vfh, std_id);
> +               break;
> +       case VIDIOC_ENUMSTD:
> +               ret =3D copy_from_user(&standard, (void __user *)arg,
> +                                    sizeof(standard));
> +               if (ret) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +               ret =3D virtio_media_enumstd(file, vfh, &standard);
> +               if (ret)
> +                       break;
> +               ret =3D copy_to_user((void __user *)arg, &standard,
> +                                  sizeof(standard));
> +               if (ret)
> +                       ret =3D -EFAULT;
> +               break;
> +       case VIDIOC_QUERYSTD:
> +               ret =3D virtio_media_querystd(file, vfh, &std_id);
> +               if (ret)
> +                       break;
> +               ret =3D copy_to_user((void __user *)arg, &std_id, sizeof(=
std_id));
> +               if (ret)
> +                       ret =3D -EFAULT;
> +               break;
> +       default:
> +               ret =3D video_ioctl2(file, cmd, arg);
> +               break;
> +       }
> +
> +       mutex_unlock(&vv->vlock);
> +
> +       return ret;
> +}
> diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virti=
o_media.h
> index ad05d7421..c1e68d47c 100644
> --- a/include/uapi/linux/virtio_media.h
> +++ b/include/uapi/linux/virtio_media.h
> @@ -115,4 +115,47 @@ struct virtio_media_cmd_close {
>         __le32 __reserved;
>  };
>
> +/**
> + * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioctl.
> + *
> + * This command asks the device to run one of the ``VIDIOC_*`` ioctls on=
 the
> + * active session.
> + *
> + * The code of the ioctl is extracted from the VIDIOC_* definitions in
> + * ``videodev2.h``, and consists of the second argument of the ``_IO*`` =
macro.
> + *
> + * Each ioctl has a payload, which is defined by the third argument of t=
he
> + * ``_IO*`` macro defining it. It can be writable by the driver (``_IOW`=
`), the
> + * device (``_IOR``), or both (``_IOWR``).
> + *
> + * If an ioctl is writable by the driver, it must be followed by a
> + * driver-writable descriptor containing the payload.
> + *
> + * If an ioctl is writable by the device, it must be followed by a
> + * device-writable descriptor of the size of the payload that the device=
 will
> + * write into.
> + *
> + */
> +#define VIRTIO_MEDIA_CMD_IOCTL 3
> +
> +/**
> + * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MEDIA_CMD_I=
OCTL.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
> + * @session_id: id of the session to run the ioctl on.
> + * @code: code of the ioctl to run.
> + */
> +struct virtio_media_cmd_ioctl {
> +       struct virtio_media_cmd_header hdr;
> +       __le32 session_id;
> +       __le32 code;
> +};
> +
> +/**
> + * struct virtio_media_resp_ioctl - Device response for VIRTIO_MEDIA_CMD=
_IOCTL.
> + * @hdr: header containing the status of the ioctl.
> + */
> +struct virtio_media_resp_ioctl {
> +       struct virtio_media_resp_header hdr;
> +};
> +
>  #endif // _UAPI__LINUX_VIRTIO_MEDIA_H
> --
> 2.56.0.317.g454f8302e1-goog
>


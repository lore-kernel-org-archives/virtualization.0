Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593B3BBC9
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026884; cv=none; b=F5zCUsHtKfKXaCe+7EAuatxzMzU8k8GyaA5HHLMIO2K/klShjkRUPSqibPpXFEnz1+xXCT7TrnhBT5Kh0QD4KZnMuuBb/a4HjMNJLTJ3AALsMXFiJjDsRzUhW4aTx1HAIjeq9x2m6wtox1rPxtLFD99EH84Me/JVuELGxaMOBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026884; c=relaxed/simple;
	bh=2CWAlhlnKcc7MH6/E5lXRf4vRW1usWDyg6TKtD9rkEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0MmPyOiJRiPLYdOsYe+ccpfRNHcNZgmR1gH2MGmSjrV9hASKGCh5mschWr5Pr9n68WJbUGPBYaajdWayMUhssdJj2jOvvecsUsUPMhlJKm6cj7iQPVF+2l6vByhym1NqLX1iufTQFWFA9vWcFDQHu3qbXMsihOxRZJbsvZqwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA1AhL6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA1AhL6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726026882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01mHA8SQdMZDR/tmlv/TJXMa+tfVx6a6L+cHkA4B0lQ=;
	b=EA1AhL6y3q3Sx7ot82pfJkbnUXTK+INq9fdQ3PBZxKlE7f2Fy24IzEzc0u4mqli5A7FIgB
	EIecsNGVmWXQh1/JCDGwCPSHRgDtACf688pFTGNkJlinuk+fhruTc9wxNU9unrq/lUwphw
	mUnVb3LxWE8D59o/Q1EiNdfROQBi/sI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-jfqSGPUJNpe_zvioUnzjWw-1; Tue, 10 Sep 2024 23:54:39 -0400
X-MC-Unique: jfqSGPUJNpe_zvioUnzjWw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d889fc26e7so6410626a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 20:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726026878; x=1726631678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01mHA8SQdMZDR/tmlv/TJXMa+tfVx6a6L+cHkA4B0lQ=;
        b=MPA10g+g0wBhHa6Rc1FGM/3392rmAiR/onGYemC5Ytpp7SzmkqquqPv8bdPnPBeCuZ
         pvOheDyEji0IvUdc3W+wpW/m6t6SLHbdsPvgWoh9ByWjqysErh2YUrFz7bQxQYe9j+JJ
         mL3w2VwoCXz9x6ILZxLj9hLVKiTQriTWd/PXXJ/hN6DV27YtiZvoPz4yOcqQS0i+ywuY
         m2AXi25mhPMW5oYsWe89GCC/x1AJhc5CXf8fiGgklpNtxIdZqKY60WiYsmGeYk6h7ikx
         aTXkNU93pO3O2EQFCDMcHNUdmDaz1DBSzpmeT5KsieZTYvET1LI7UTKlQdLAw3ogEH9S
         OXRg==
X-Forwarded-Encrypted: i=1; AJvYcCVafNmuaju9Cxh8yDO9/MyzHk7BEGxXVQiUQVvzdw48Y4Np/o9PO/yfyMXJs0z/3Fil2C/yowRiMhNIcFheHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl6UN23wn0vCJHaykst/o3qbxnVDn7oahmx78cSr7EeT5dn/UK
	Fnjn30KFFzpXwzbJqkjEvYMrumsxxu7I6A9W0cOJSOaozAhjeO8T/cdrhcYbFYb4evVg97bmrwB
	rlQrypgn8Gv5pO3jqxXxdRp3IgHZDpEY8bzPDTTfyhe/joz6Y7pgBa8vGSMPkWAh7B/K7Pldfwp
	Vl4xXDZcoNjWvDx58CQWRPJDlFYm4OHRVn+ogwmJA=
X-Received: by 2002:a17:90a:b702:b0:2d3:d066:f58b with SMTP id 98e67ed59e1d1-2dad50d19aemr15719536a91.12.1726026877667;
        Tue, 10 Sep 2024 20:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvmBe+V3UYcFMyoFiIsyQUF0YlakYvGmsNdl8vM8Y/lmMTmDeGH486oED+qxAKBuiGUGjc4+9vpUHYWVIokWU=
X-Received: by 2002:a17:90a:b702:b0:2d3:d066:f58b with SMTP id
 98e67ed59e1d1-2dad50d19aemr15719500a91.12.1726026876990; Tue, 10 Sep 2024
 20:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 11:54:25 +0800
Message-ID: <CACGkMEt19u07b_2GkT_tEBhpKJj97VoF-jcSqoaTyEULoWvdFw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/13] virtio_ring: perform premapped operations
 based on per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The current configuration sets the virtqueue (vq) to premapped mode,
> implying that all buffers submitted to this queue must be mapped ahead
> of time. This presents a challenge for the virtnet send queue (sq): the
> virtnet driver would be required to keep track of dma information for vq
> size * 17, which can be substantial. However, if the premapped mode were
> applied on a per-buffer basis, the complexity would be greatly reduced.
> With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> skb buffers could remain unmapped.

Is this only applied to TX or both TX and RX.

>
> We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> indicates that the driver has performed DMA mapping in advance, allowing
> the Virtio core to directly utilize sg_dma_address(sg) without
> conducting any internal DMA mapping.

This seems conflict with the code below?

#define sg_is_premapped(sg) (!sg_page(sg))

And rethink of the design, a question is that is there a chance that
VM_PFNMAP area could be used for virtio-net? If it is true, the trick
for sg_page() can not work?

A quick glance told me AF_XEP seems to be safe as it uses
pin_user_pages(), but we need to check other possibilities.

Or we need to fall back to our previous idea, having new APIs.

> Additionally, DMA unmap operations
> for this buffer will be bypassed.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 70 +++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b43eca93015c..7efddc71af67 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -235,6 +235,7 @@ static void vring_free(struct virtqueue *_vq);
>   */
>
>  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
> +#define sg_is_premapped(sg) (!sg_page(sg))
>
>  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>                                    unsigned int total_sg)
> @@ -292,9 +293,10 @@ static bool vring_use_dma_api(const struct virtio_de=
vice *vdev)
>         return false;
>  }
>
> -static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
> +static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring,
> +                                   const struct vring_desc_extra *extra)
>  {
> -       return vring->use_dma_api && !vring->premapped;
> +       return vring->use_dma_api && (extra->addr !=3D DMA_MAPPING_ERROR)=
;
>  }
>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev)
> @@ -366,7 +368,7 @@ static struct device *vring_dma_dev(const struct vrin=
g_virtqueue *vq)
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
> -       if (vq->premapped) {
> +       if (sg_is_premapped(sg)) {
>                 *addr =3D sg_dma_address(sg);
>                 return 0;
>         }
> @@ -457,7 +459,7 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vring_need_unmap_buffer(vq))
> +               if (!vring_need_unmap_buffer(vq, extra))
>                         goto out;
>
>                 dma_unmap_page(vring_dma_dev(vq),
> @@ -510,7 +512,7 @@ static inline unsigned int virtqueue_add_desc_split(s=
truct virtqueue *vq,
>                                                     dma_addr_t addr,
>                                                     unsigned int len,
>                                                     u16 flags,
> -                                                   bool indirect)
> +                                                   bool indirect, bool p=
remapped)
>  {
>         u16 next;
>
> @@ -518,7 +520,7 @@ static inline unsigned int virtqueue_add_desc_split(s=
truct virtqueue *vq,
>         desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
>         desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
>
> -       extra[i].addr =3D addr;
> +       extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
>         extra[i].len =3D len;
>         extra[i].flags =3D flags;
>
> @@ -611,7 +613,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                          */
>                         i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, sg->length,
>                                                      VRING_DESC_F_NEXT,
> -                                                    indirect);
> +                                                    indirect, sg_is_prem=
apped(sg));
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
> @@ -629,12 +631,12 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                                                      sg->length,
>                                                      VRING_DESC_F_NEXT |
>                                                      VRING_DESC_F_WRITE,
> -                                                    indirect);
> +                                                    indirect, sg_is_prem=
apped(sg));
>                 }
>         }
>         /* Last one doesn't continue. */
>         desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> -       if (!indirect && vring_need_unmap_buffer(vq))
> +       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;
>
> @@ -643,19 +645,15 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                 dma_addr_t addr =3D vring_map_single(
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
> -               if (vring_mapping_error(vq, addr)) {
> -                       if (vq->premapped)
> -                               goto free_indirect;
> -
> +               if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
> -               }
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
>                                          vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
>                                          VRING_DESC_F_INDIRECT,
> -                                        false);
> +                                        false, false);
>         }
>
>         /* We're using some buffers from the free list. */
> @@ -712,7 +710,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 i =3D vring_unmap_one_split(vq, &extra[i]);
>         }
>
> -free_indirect:
>         if (indirect)
>                 kfree(desc);
>
> @@ -794,7 +791,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
>
> -               if (vring_need_unmap_buffer(vq)) {
> +               if (vq->use_dma_api) {
>                         for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
>                                 vring_unmap_one_split(vq, &extra[j]);
>                 }
> @@ -1228,7 +1225,7 @@ static void vring_unmap_extra_packed(const struct v=
ring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vring_need_unmap_buffer(vq))
> +               if (!vring_need_unmap_buffer(vq, extra))
>                         return;
>
>                 dma_unmap_page(vring_dma_dev(vq),
> @@ -1309,7 +1306,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         i++;
>
>                         if (unlikely(vq->use_dma_api)) {
> -                               extra[i].addr =3D addr;
> +                               extra[i].addr =3D sg_is_premapped(sg) ? D=
MA_MAPPING_ERROR : addr;
>                                 extra[i].len =3D sg->length;
>                                 extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
>                         }
> @@ -1320,12 +1317,8 @@ static int virtqueue_add_indirect_packed(struct vr=
ing_virtqueue *vq,
>         addr =3D vring_map_single(vq, desc,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
> -       if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> -                       goto free_desc;
> -
> +       if (vring_mapping_error(vq, addr))
>                 goto unmap_release;
> -       }
>
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> @@ -1383,7 +1376,6 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_extra_packed(vq, &extra[i]);
>
> -free_desc:
>         kfree(desc);
>
>         END_USE(vq);
> @@ -1474,7 +1466,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                         desc[i].id =3D cpu_to_le16(id);
>
>                         if (unlikely(vq->use_dma_api)) {
> -                               vq->packed.desc_extra[curr].addr =3D addr=
;
> +                               vq->packed.desc_extra[curr].addr =3D sg_i=
s_premapped(sg) ?
> +                                       DMA_MAPPING_ERROR : addr;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
>                                 vq->packed.desc_extra[curr].flags =3D
>                                         le16_to_cpu(flags);
> @@ -1625,10 +1618,9 @@ static void detach_buf_packed(struct vring_virtque=
ue *vq,
>                 if (!extra)
>                         return;
>
> -               if (vring_need_unmap_buffer(vq)) {
> +               if (vq->use_dma_api) {
>                         len =3D vq->packed.desc_extra[id].len;
> -                       for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
> -                                       i++)
> +                       for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc); i++)

Unnecessary changes?


>                                 vring_unmap_extra_packed(vq, &extra[i]);
>                 }
>                 kfree(desc);
> @@ -2212,6 +2204,11 @@ static inline int virtqueue_add(struct virtqueue *=
_vq,
>   * @data: the token identifying the buffer.
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * When sg_page(sg) is NULL, this indicates that the driver has performe=
d DMA
> + * mapping in advance, allowing the virtio core to directly utilize
> + * sg_dma_address(sg) without conducting any internal DMA mapping. Addit=
ionally,
> + * DMA unmap operations for this buffer will be bypassed.
> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> @@ -2246,6 +2243,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
>   * @data: the token identifying the buffer.
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * When sg_page(sg) is NULL, this indicates that the driver has performe=
d DMA
> + * mapping in advance, allowing the virtio core to directly utilize
> + * sg_dma_address(sg) without conducting any internal DMA mapping. Addit=
ionally,
> + * DMA unmap operations for this buffer will be bypassed.
> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> @@ -2268,6 +2270,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>   * @data: the token identifying the buffer.
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * When sg_page(sg) is NULL, this indicates that the driver has performe=
d DMA
> + * mapping in advance, allowing the virtio core to directly utilize
> + * sg_dma_address(sg) without conducting any internal DMA mapping. Addit=
ionally,
> + * DMA unmap operations for this buffer will be bypassed.
> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> @@ -2291,6 +2298,11 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
>   * @ctx: extra context for the token
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * When sg_page(sg) is NULL, this indicates that the driver has performe=
d DMA
> + * mapping in advance, allowing the virtio core to directly utilize
> + * sg_dma_address(sg) without conducting any internal DMA mapping. Addit=
ionally,
> + * DMA unmap operations for this buffer will be bypassed.
> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> --
> 2.32.0.3.g01195cf9f
>

Thanks


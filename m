Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BE3D7D78
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452610; cv=none; b=ISOLo6BNx4vxO6j/m17IE8+7EF07jruYQnugmhQ8Yxjks6urq2O81ryNVn38/QJqUf2fbRMEEj58Nol6P0t2NjWQQU6MnIdjjUJoIvHDCaY1SviAExqF40w2VDpiTANBCaGS9257ePDT7uTcZRJCJEKPKvAMAjMNaHSBai18vuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452610; c=relaxed/simple;
	bh=VXRoTZ5J5XB0qyvlT1qAxAKEaunjy+UA8h4HrVB9vuI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=MpndIpYXttVy1wBVYPrqmwfG5H90u3LcW2roZzW3qv2nQde/guRK1f5J0ZRnfTEX6Kuz6JF72nNzKzInQWmW0G3Tvz7p/abUHaGXi7MSEnxXaq30N+KWtxNnz+UqmCjhyE3EiMFXnVXxaGGf5hXIpZovkw/bwyQ7kfsw2cUdGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C3OTYfJQ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C3OTYfJQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780452601; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=aN3hCgUddAzYpTgwEBJlmAjUoLQNw9GbtOCPwpFW2YI=;
	b=C3OTYfJQUEfhcdf/u7SBWUkPnmgs+zvjPPGf5Io1mkg++wdiCFZ+XBVZ+LBc9SlRchxnPgggxOXRGoaqyL5HYmwLtoMIeuWAGoaZMKN+zCUhYeWA74L1EjFy/bT3rAD7eizP7Jjv32OKeSGeCOQyCvOGkU+uTHWHgbFoTNN+8RY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X45mTak_1780452600;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X45mTak_1780452600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 10:10:00 +0800
Message-ID: <1780452519.414238-1-xuanzhuo@linux.alibaba.com>
Subject: Re:Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Date: Wed, 3 Jun 2026 10:08:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "yangjiale133" <yangjiale133@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eugenio Perez Martin <eperezma@redhat.com>
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <46a9dc36.1986.19e8b34896c.Coremail.yangjiale133@163.com>
In-Reply-To: <46a9dc36.1986.19e8b34896c.Coremail.yangjiale133@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 3 Jun 2026 09:58:56 +0800 (CST), "yangjiale133" <yangjiale133@163.c=
om> wrote:
> From the device's perspective, during a single read of the descriptor
> list-and that list spans across cache lines.
> the retrieved data will show `desc[head].flags` as valid,
> and `desc[i].flags` as valid as well; however,
> the `desc[i].addr` and `len` fields may be invalid.
>
> I suspect this occurs because a single DMA operation is internally
> split into multiple parallel read transactions,
> aligned to cache line boundaries.


I am aware of one case. When reading, the device reads multiple descriptors
at once. If the head descriptor's flag is 'avail', it then checks the data =
of
the subsequent descriptors from that same batch. However, this does not com=
ply
with the specification. The device should only read the subsequent descript=
ors
after the head descriptor's flag is confirmed to be 'avail'. Although this =
might
impact performance, it is the correct behavior.

Thanks


>
> I apologize that I currently lack the necessary environment to verify
> whether this modification definitively resolves the issue or
> merely reduces the probability of its occurrence;
> therefore, this patch can be discarded.
>
> yangjiale
>
>
>
> At 2026-06-02 14:04:13, "Eugenio Perez Martin" <eperezma@redhat.com> wrot=
e:
> >On Tue, Jun 2, 2026 at 6:34=E2=80=AFAM yangjiale <yangjiale133@163.com> =
wrote:
> >>
> >> When a descriptor list spans across cache lines,
> >> updating the flag first can lead to a scenario where the device side
> >> perceives the flag as valid, yet the corresponding address and length
> >> fields remain unupdated=E2=80=94resulting in invalid values.
> >> Therefore, the flag field must be updated last.
> >>
> >> Signed-off-by: yangjiale <yangjiale133@163.com>
> >> ---
> >>  drivers/virtio/virtio_ring.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring=
.c
> >> index fbca7ce1c6bf..036b4f90d30f 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct v=
ring_virtqueue *vq,
> >>                                              &addr, &len, premapped, a=
ttr))
> >>                                 goto unmap_release;
> >>
> >> +                       desc[i].addr =3D cpu_to_le64(addr);
> >> +                       desc[i].len =3D cpu_to_le32(len);
> >> +                       desc[i].id =3D cpu_to_le16(id);
> >> +
> >>                         flags =3D cpu_to_le16(vq->packed.avail_used_fl=
ags |
> >>                                     (++c =3D=3D total_sg ? 0 : VRING_D=
ESC_F_NEXT) |
> >>                                     (n < out_sgs ? 0 : VRING_DESC_F_WR=
ITE));
> >> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct v=
ring_virtqueue *vq,
> >>                         else
> >>                                 desc[i].flags =3D flags;
> >>
> >> -                       desc[i].addr =3D cpu_to_le64(addr);
> >> -                       desc[i].len =3D cpu_to_le32(len);
> >> -                       desc[i].id =3D cpu_to_le16(id);
> >> -
> >>                         if (unlikely(vq->use_map_api)) {
> >>                                 vq->packed.desc_extra[curr].addr =3D p=
remapped ?
> >>                                         DMA_MAPPING_ERROR : addr;
> >
> >These flags are updated before the flags of the head descriptor at the
> >end of the function, at "vq->packed.vring.desc[head].flags =3D
> >head_flags", so the device should not see these. Because of that, the
> >relative order between the rest of the fields of the same descriptor
> >or other descriptors' fields, except for the head descriptor's flags,
> >should not matter. There is a write memory barrier just before
> >updating the head's flags.
> >
> >Also, I don't get why the cache line matters here. Can you expand? Am
> >I missing something?
>

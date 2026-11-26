Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680920;
	b=1gHXgAgMApu6d08pNmZfTKIa3Mv2MBZqvKPkdANgzsxpBtkmS8xHqjbuF9lHetzSsPrX
	 /Scca3oyQj5bGV+RYQ/L5Sj6PF7e6I4suaH7Y3ffiqcQR8LbV9c+eRjPGbL6g1gyvDT8Y
	 INahAO3edfi/wsIyfbLYOqVPu896ZsEvLgTIdMgUBXZb0E6T/rY2JRhEzz6ym6UQu830q
	 eeRlwlfYmOeBobGpMTEWy3wNBZcbWew6Rn6V+Ko21k85/3DB13OkVzoYWTcmYFgONYv6a
	 WRf/OEqUJGvlMXVvyn7d8zHHPMhGaqL44h9V7CdcLcZ8xK1A4VwQ7xTMxV6Gq2YxguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680920;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=mBcESn8+ASrF+yjc8Fu6QsHb9JYU3cy8vbhZM0PtWs8=;
	b=kpus6Pt5/Vdu7SJ2tDkE6jBzpSAwHhpNmxML8ud+svbAjDWibJkzkfJsTI93X5Ru//WU
	 nqV2QHVFHKF+0sdbtDqmnqxhg0BnMpOUz2OJEqggNC8sgBUMBqvdA71OS2xAeRFAF7OkD
	 nczkBWdZYlm5S17uJZavbj+RRl2gydK4SjXkkCFYfXvkVCPN2i27NOV5ADfIk67qQaVOD
	 FSUwq3zzJBqRpMmO+iiq5GEazTJyT6g68OGVpfxfrFLqD5Z2RqOt5c97J+d39Frp+wEbf
	 0wnuYH47G/8KvmRmCKmcVmiOqOQv7hlodstHnOgY5BE0xDkmgJH9iajsHKAIXnoLcCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ToI5E3Uv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467F606A31E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7467F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ToI5E3Uv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795680918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBcESn8+ASrF+yjc8Fu6QsHb9JYU3cy8vbhZM0PtWs8=;
	b=ToI5E3UvvhP/FT9Qdp5UHzFCQk0emXRJDQmtc8ghBl2bYpXYf6w2wS9oIieN5YimIaYLqw
	24q1fwvAxXKE9YpSKuq2SLPKj0SRGJ0DPWHDraoKOhA0xq7xUBc5bm+uZ8Ki54qB0jVFoM
	T05UGgIjLwKqcQLyeJtFiElYomdKeeM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-NsTDkC9oPimAbWEXVHqZ9Q-1; Thu, 26 Nov 2026 08:15:14 +0000
X-MC-Unique: NsTDkC9oPimAbWEXVHqZ9Q-1
X-Mimecast-MFC-AGG-ID: NsTDkC9oPimAbWEXVHqZ9Q_1795680914
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b3030bd581so93727627b3.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 00:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680914; x=1796285714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBcESn8+ASrF+yjc8Fu6QsHb9JYU3cy8vbhZM0PtWs8=;
        b=Cv9rT0yM1hmo0WKzYp1nodlEnxQGY1aFejLnf8t2AScftPu+icUKD4IRE5phl3SoE1
         z88SIPaBykmfYkaDbDOwaxGxHaZMxm0Pdw8ChhU8ISy1fvJk0EZcGit07bT8y7iW+obQ
         DHwbecbcczACFejNWrMWZXILeJIpK75KqIAPuzhsDXnuqMJIM09BxwE1npMHTVQPjVut
         oice32sfb1VLewJfL78v0pysS1pI2R2zbMkFsl5cKbszzEnZiG3dyKXmv01lDsXFoCBG
         7N3XTMBY2PWanAV2afTvA8el7ZZ2867rM/a7QKSePYbTzFAlwdi4ZJsdc67D2JfzuaHW
         jd5A==
X-Forwarded-Encrypted: i=1; AL+hErG5Q4vsMwtjhJIIw+i3+PhvWJv4H+mizzAiUcLVMDduAouhYIKMBy6YvkEd1h7pnjhn3ozRHbyF9JXE22WBmQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+p/fGLIe+pc7t1TlRMorFyc6xdA0F0BK6PDZSAkzTBA754c50Q
	rCzAb71A8SWZbrled+3M9clR3g0aQyqhewp4942ZYhMeTvGGTgu6anoGK3xSPHooRokPFKxvxBj
	GTo5RfHv62q1V2sACLV5uJuI/w2clVl0BhJVRZEMx3e6xL5N/GMUifdkgANegJkIG4Enlq+0S3Q
	Z5RpcXJpU4cdMCP2HuIiDXFV1IVlyDeM4cqyW0fL+d4tE=
X-Gm-Gg: AZFdTZev02tExG6iH7IwCrSFp/p3upPVCgiStIM9QoJQXATClGYNKEX/2taZKRh4/Jp
	wZ/z7y0I02ZtyRLfGKwlBOjTsCLGuab8bxjY7yOvEY99duq0WWXqDUTP62sW3BjdO6ansdXE1pZ
	DUdnsbTowOD4CBgrfBBiU5C4r6uu95WC4c8fnsj6Cp1A2B7D+M8LwaIunT7rYkSXd+pHH4OFn+D
	BR4R9CeK4dBPICHuGkwIgf8hLgExcppALXIsyo3zcQVZ4Moo69kw130zYY=
X-Received: by 2002:a05:690c:2a44:b0:8b3:5b88:a21d with SMTP id 00721157ae682-8b5204aab8fmr70577747b3.58.1795680913425;
        Thu, 26 Nov 2026 00:15:13 -0800 (PST)
X-Received: by 2002:a05:690c:2a44:b0:8b3:5b88:a21d with SMTP id
 00721157ae682-8b5204aab8fmr70577687b3.58.1795680912878; Thu, 26 Nov 2026
 00:15:12 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
In-Reply-To: <20261126080209.2898344-1-love09010224@uos.ac.kr>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Nov 2026 09:14:36 +0100
X-Gm-Features: Aa3M54plsKtwMN2bth4NYjgcIzmNAHKvKKGuE6iTSRdixwYi9huQK-5LFALx9W8
Message-ID: <CAJaqyWdLXzosXuFs8iafx0x1moGsOZuWuAQCJqCQUrOt++FCBQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
To: Seojin An <love09010224@uos.ac.kr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	security@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5QQh7NfDR0xs6iNjhX6FkEvW4qM1uoHMIDR5IrDU0CE_1795680914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 9:02=E2=80=AFAM Seojin An <love09010224@uos.ac.kr> =
wrote:
>
> Split descriptors store the next index as u16. alloc_indirect_split() can
> allocate a larger table, but virtqueue_add_split() feeds the truncated ne=
xt
> value back into its construction index. With more than 65,536 SG entries,
> the index wraps and later entries replace descriptors at the start of the
> table. The device then consumes a chain different from the caller's SG
> sequence.
>
> Reject split indirect tables whose entry count exceeds the representable
> index range. Keep the existing compatibility policy that permits
> representable indirect chains longer than Queue Size, and leave packed
> indirect descriptors unchanged.
>
> A virtio-gpu render client can reach this condition with a vmalloc-backed
> EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
> substitution provided guest physical read/write and initial-namespace
> uid/euid 0. The virtio-gpu producer needs its own Queue-Size check becaus=
e
> its current queue error path warns about an add failure but advances
> pending state and reports success.
>
> AI tools assisted the source audit, reproducer construction and patch
> drafting.
>
> Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_INDIRE=
CT_DESC)")
> Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> Cc: stable@vger.kernel.org
> Signed-off-by: Seojin An <love09010224@uos.ac.kr>
> ---
>  drivers/virtio/virtio_ring.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a2002..ad9e52584fb52 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_v=
irtqueue *vq,
>
>         head =3D vq->free_head;
>
> -       if (virtqueue_use_indirect(vq, total_sg))
> +       if (virtqueue_use_indirect(vq, total_sg)) {
> +               /*
> +                * The core historically permits an indirect chain to exc=
eed the
> +                * queue size.  Preserve that policy, but do not let its =
16-bit
> +                * split descriptor links wrap within the allocated table=
.
> +                */

Seems like the same code path in the packed vqs also needs this check?

Also, a question for everybody: is it really too late to forbid
indirect tables bigger than the queue size? It is not guaranteed that
the device will be able to handle it anyway, should we just add a if
(total_sg > vq.split.vring.num) return -E2BIG?

> +               if (unlikely(total_sg > (1U << 16))) {
> +                       END_USE(vq);
> +                       return -E2BIG;
> +               }
> +
>                 desc =3D alloc_indirect_split(vq, total_sg, gfp);
> -       else {
> +       } else {
>                 desc =3D NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
>         }
>
> base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
> --
> 2.43.0
>


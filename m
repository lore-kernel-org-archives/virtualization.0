Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5E2F12D4
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906133; cv=none; b=YKCz4d9osS+WA9XyFWKE8tU/Lq7tehJtVA8fIyt4OhyyVSo6UlbG8x20CP4x8F3Q8A6sfjT/5dp6bm+BAj3v1E+A9mETiJPQxJBw2RzggeXo8DZFKfhFw+Zc42shgHbTxAHSObkTvoEHTuNuYmsd6FNVyFeWLyX2eK0FdkWEEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906133; c=relaxed/simple;
	bh=ztAoDQgvq4bSA8VWXQVbpgA+LAQpU2idPAwGKkw6dfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkpxQRlQsQwsGpNZBMT+sBciJ253ok+uQeWbwd0RVNfDKKnI4SpgBCV+W95b7v+T+9pctsPnSUZQ+9wIHzA3hGEzp6ca+r1zykmrDlytpq46gvinGmNaZzsbj5aeJzLEqHdCeP2iDZrNkQziOwGKqxyaZdn1DrKZqs1zJ8Q1EVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZPKVYjT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZPKVYjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780906130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCZmz4ueyJVA7+IGOS6DZPM8ylxkV4oSBnbzxZlHUaA=;
	b=LZPKVYjTeOX5gayV12xBFqK14phBPLt1FV2z/gTyPe5zeUWq37opc7c/lUJnn7y3NrZT6y
	KGO1+LXiBmwDRES4KPEmWU4rgVZZsCLWq8Fzd5cZXur2zktnuGrEn6jpZsmrUZEFWABs2n
	RzswaDIQUvfG7zriIFl21WsR16Fg7uA=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-6yPrHEbdORuTWPu58VfENg-1; Mon, 08 Jun 2026 04:08:48 -0400
X-MC-Unique: 6yPrHEbdORuTWPu58VfENg-1
X-Mimecast-MFC-AGG-ID: 6yPrHEbdORuTWPu58VfENg_1780906128
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6607988ca90so6884784d50.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906128; x=1781510928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCZmz4ueyJVA7+IGOS6DZPM8ylxkV4oSBnbzxZlHUaA=;
        b=Yr+9tNoEXnxCkyZBOOR/dn4AtJ8fhq0y3CfALJzOm4dUgxf/tDS6Zp69rnc5k4Dx7J
         UVADb+iD9X3lctoZR3FCCiNhiY6dOyxx00KShpndIobIX3rCAZT2ZpHTPiwh1xrJtm+5
         +WkPrZwpILtyD/nDbvfI0cFA5ITFQt3cjwKxRpCFfpO+KZfwl8/LM3UH5kaITvxcIoZ8
         FFzrVYh2PgPsqfogo5m4eKpi5UxU0dsoAxH4/FRn7l4ujCCuOFjOqSeXWWvbAkxMyepP
         Lt1xH3ez0WTY+Lqkv91Cc77jqEDGvb54W07lxp8uXT+UWLvjfLllOms4v/pHumAKVKXZ
         R2XQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IyiOmLx5LnExVGaTuCTkJx4dYq8Wo1n7cG8+PW4xgm6g0wvoM4zoX0FW9xF/zowqdXvfMvkvDHxt/ioSkkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxatShP0TeX2cyIBGgUVjHGGyVDIPqp5xMLhLBe93z8tgtZxxyc
	+omFXd8+1eLA6c39SrsDAEeWS4yYv2zDbTiGAVv0MqEJKN2cWpZXLnYWgl05AU5AZtiaM+YG80U
	lmatHr57Vh4+ob6W8SYzlxOSekCtbPchhXGrNjqUQlYwhSLzCTJ+Njmzcuz08KUzZ48Ab+FpzzO
	5v5qsRs9GhGAx7lOmPXbfutV0I6hDLJjMrTSk4lg8B+u4=
X-Gm-Gg: Acq92OGWeu5XhOCl+KLACeJ9a+9hdwOy0+RHY6X4f/F2cGMaFwov6jLNsO2SiZbyGy6
	5y3spYzEFk9GolpNb3CDr3ViL8SkAlxE8YgoaZthjVbReD0bAoL0+EsKMHlafAar+Ps89oCpl6y
	TKnIZfqMoM4lN0mGhMY9zTggmK7/rdLQTtzIcrJXWOePyVxHxRvhlmufULoiNif4Omqx83YVrPv
	P9RdciHG0oxFhB9
X-Received: by 2002:a53:ce82:0:b0:651:e1e7:7f50 with SMTP id 956f58d0204a3-66106f4e6f9mr9812149d50.29.1780906127839;
        Mon, 08 Jun 2026 01:08:47 -0700 (PDT)
X-Received: by 2002:a53:ce82:0:b0:651:e1e7:7f50 with SMTP id
 956f58d0204a3-66106f4e6f9mr9812139d50.29.1780906127375; Mon, 08 Jun 2026
 01:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260602043123.10207-1-yangjiale133@163.com> <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com> <20260605134252-mutt-send-email-mst@kernel.org>
 <5e1a10bd-2783-42ba-b443-853f12159756@oracle.com>
In-Reply-To: <5e1a10bd-2783-42ba-b443-853f12159756@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 8 Jun 2026 10:08:10 +0200
X-Gm-Features: AVVi8CfR7BDZIt0MIqtzGbvRtw1IaGuCipUc1K37Na2FgPWt8h-26qJGg2KXJVk
Message-ID: <CAJaqyWeoF=V16bxF3ei4Ai4u-TDm6jikdaH2iBNsRKtUrXw3Jw@mail.gmail.com>
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, yangjiale <yangjiale133@163.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew.Boyer@amd.com, Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mLzarcKLe_csAa35e3pWWkN0RvnXxT_8y9gs3GkKCpM_1780906128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 6/5/2026 10:43 AM, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2026 at 09:03:36AM -0700, Si-Wei Liu wrote:
> >>
> >> On 6/1/2026 11:04 PM, Eugenio Perez Martin wrote:
> >>> On Tue, Jun 2, 2026 at 6:34=E2=80=AFAM yangjiale <yangjiale133@163.co=
m> wrote:
> >>>> When a descriptor list spans across cache lines,
> >>>> updating the flag first can lead to a scenario where the device side
> >>>> perceives the flag as valid, yet the corresponding address and lengt=
h
> >>>> fields remain unupdated=E2=80=94resulting in invalid values.
> >>>> Therefore, the flag field must be updated last.
> >>>>
> >>>> Signed-off-by: yangjiale <yangjiale133@163.com>
> >>>> ---
> >>>>    drivers/virtio/virtio_ring.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ri=
ng.c
> >>>> index fbca7ce1c6bf..036b4f90d30f 100644
> >>>> --- a/drivers/virtio/virtio_ring.c
> >>>> +++ b/drivers/virtio/virtio_ring.c
> >>>> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct=
 vring_virtqueue *vq,
> >>>>                                                &addr, &len, premappe=
d, attr))
> >>>>                                   goto unmap_release;
> >>>>
> >>>> +                       desc[i].addr =3D cpu_to_le64(addr);
> >>>> +                       desc[i].len =3D cpu_to_le32(len);
> >>>> +                       desc[i].id =3D cpu_to_le16(id);
> >>>> +
> >>>>                           flags =3D cpu_to_le16(vq->packed.avail_use=
d_flags |
> >>>>                                       (++c =3D=3D total_sg ? 0 : VRI=
NG_DESC_F_NEXT) |
> >>>>                                       (n < out_sgs ? 0 : VRING_DESC_=
F_WRITE));
> >>>> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct=
 vring_virtqueue *vq,
> >>>>                           else
> >>>>                                   desc[i].flags =3D flags;
> >>>>
> >>>> -                       desc[i].addr =3D cpu_to_le64(addr);
> >>>> -                       desc[i].len =3D cpu_to_le32(len);
> >>>> -                       desc[i].id =3D cpu_to_le16(id);
> >>>> -
> >>>>                           if (unlikely(vq->use_map_api)) {
> >>>>                                   vq->packed.desc_extra[curr].addr =
=3D premapped ?
> >>>>                                           DMA_MAPPING_ERROR : addr;
> >>> These flags are updated before the flags of the head descriptor at th=
e
> >>> end of the function, at "vq->packed.vring.desc[head].flags =3D
> >>> head_flags", so the device should not see these. Because of that, the
> >>> relative order between the rest of the fields of the same descriptor
> >>> or other descriptors' fields, except for the head descriptor's flags,
> >>> should not matter. There is a write memory barrier just before
> >>> updating the head's flags.
> >> The above analysis is absolutely correct. Though one hardware vendor t=
old me
> >> that this driver implementation kinda stops them from reading ahead of
> >> descriptors already posted beyond the available index., ending up with
> >> suboptimal performance that is hard to make up by other means. Would i=
t be a
> >> bad idea to go with this change and add write barrier in a gentle way =
for a
> >> small flit in the batch, e.g. commit to memory after every cache line =
size
> >> worth of descriptors are posted? Would the memory barrier have negativ=
e
> >> performance overhead to other backend implementation variants than rea=
l
> >> hardware PCI device?
> >>
> >> -Siwei
> > this would need a new feature bit, won't it?
> Probably. This is to capture the device's expectation and behavior
> right? the driver change itself is not spec violating...
>
> >
> >>> Also, I don't get why the cache line matters here. Can you expand? Am
> >>> I missing something?
> > me too.
> >
> Just to avoid extra delay due to excessive coherency messages and
> frequent cache thrashing, device read over pci bus contends with host
> write/update on the descriptors in a same cache line..
>

Whether the descriptors are in the same cache line or not, how does
the device know that the memory for the other descriptors is updated
or dirty and needs to be read again? The only way I can imagine is to
force both the device and the driver to update the flags of all
descriptors, regardless of whether they're in a chain, and use that
information for synchronization. Also, the device must read these
flags strictly before the other members, as it does with the head's
flag now. I'm not sure if that memory dance beats the PCI latency.

I thought of something similar, not for cache thrashing but to save
the overhead and latency of the extra PCI read for the length and id
descriptor members. My understanding is that a PCI device can only
read 64 bits atomically at most. So it can only save one fetch of the
fields together with the flags (length and id) if the driver promises
to write all of them atomically. This needs a feature flag as MST
says.

Something like this super early draft:

VIRTIO_F_ATOMIC_64_FLAGS: The driver writes the length, id, and flags
of a packed descriptor atomically, ensuring they are always
synchronized. The device will not read them again once it finds the
descriptor available via its flags.

Conversely, the device could atomically update the descriptor ID along
with the flags, meaning the driver wouldn't need a memory barrier
between these updates.

I guess it does not buy much on x86 software devices, but it might
improve performance in architectures with less cache coherency. From
the driver's perspective, implementation isn't hard.

I also see 128-bit CAS PCI, but I'm not sure if the CPU can write the
128 bits of the descriptor atomically from the device's POV or if the
driver's write barrier is sufficient. Perhaps this is an improvement
for SW devices actually.

Adding Dragos to the thread.


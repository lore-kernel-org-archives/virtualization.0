Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15F346782
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283321; cv=none; b=aP+NyZxrYyKPveCwZTX1ZcizwCHoPpQ46ldjrMyHYn1ECscIk/CnIhbsihvGN1/cc+6d/Zlk/78dJjVl4goE+CW5E4E3sPWzr2eqeE45ppmsKqRKx/uHqwIhvY7oOPQgbPWC3T2ZAvXvuO2R0ryIIeFG/n7rOpz8JBCe+soaxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283321; c=relaxed/simple;
	bh=lfHozr70337RSYUwTIcXetgO+Glu6lcUkiN833X+ZL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1DnMEI3METGrCVXXbPvSuubY8ZzlE+m4FoXB+dR3VBTPqxTBYq/KzNbEZ8x3H9J8gPhuuC4oCSK7fa7TVwxr7F5ttKyTV2mHdVItT8qzRcBjnc9/6AtBDWHjdKpjF9RtClmEwlVpMWpA9XBd/XUMp1qFiILvF/S396S3cr2mAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJpgZvlL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJpgZvlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773283319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE8hGt5QQUxb3QzBqRwRdIA/aNd2P8A9qVRs6qqrPSo=;
	b=GJpgZvlLvshwdDW5mPGcf6P4er7SlKY02XlDGXeCxLSoqJEE08IoOI1yy0KmGNrE8nm/TG
	KTEroVxhTuySY1XpjkS6N+20+wTzlf0HoNc1UqWHqwuB7IXIjNprT6/erJT2+g73Gge3gA
	0bKEGY7H75cgmhlRsooY3GE/jumaPUw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Q7TF_16CPqO-5Gc2y2-gNg-1; Wed, 11 Mar 2026 22:41:58 -0400
X-MC-Unique: Q7TF_16CPqO-5Gc2y2-gNg-1
X-Mimecast-MFC-AGG-ID: Q7TF_16CPqO-5Gc2y2-gNg_1773283317
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7378ffeeacso2409155a12.0
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 19:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773283316; x=1773888116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IE8hGt5QQUxb3QzBqRwRdIA/aNd2P8A9qVRs6qqrPSo=;
        b=M6kJ5bDEBUvfu4GOyUzWMMxAEkvf0GUjFzI6mqwJWWxIYSsrzcgi7syRedngFuwKg6
         NQQDHLIF8C/OLihWbV6zV1s6eZTCk63rqhzCsnO5drehRYFWwaTsQ6FfWbbqvt7BnkDo
         +T2P6BECaacTJ9Gb7M/KzNwR/ILZywMcDsdqb7fRi8P4Lx1E1fHXYIQoqhH2bIiCP2TF
         +labC7aakwUUHUBRLU6pFR9FlYujIjt7rUuHPoRVDYBhA+FptPVp/Jk3EBDm6KOUJdoO
         cjEFkLSo6LwIx4GwA80uSM+gqTGStd1VIf0vJjlBoklgHTinX/PTepVbPHEPF/2qD/ks
         Yq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWuNzNemZplToAyOunxKwytCD6LDoh0DhD7UTtar3Z0UubCCV5/Qc6YqxA34w3rzEApgPgL+r9K2ivkM/Frbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrAncSQsM9CySENr8qLoqbzmUs2hMNZ36owfRDeRqrE/Jk/ETy
	f9K6FV/SoGIKUk4DjwMXb4RDnTFMCBstjW/PslQkJ6qGf0+WeBlCKOPMpeJyS16gXv5MjxV0ol1
	g8ZqGmp8OdGOqtQzlO9l+4pvRQop5clbAao40P6noEe/zn1JPUa7TYU5MvGSuNR2i4ntfr3zKEi
	Xd/FqxrK/mOOGttmcKXl9DZGCLR58c08UkCzH86VCjN1VsbiJqi3M=
X-Gm-Gg: ATEYQzx+PvtuwwHAi62Ngmrlp6T+D7zHV1TsZERxOqJJmw2cgoTEUNhXUWSLBxYmjK/
	wPMdY8sa6fsDR+jBGJuKJFDMvSdYUn7iPaN1tbaovnMUzrJcfZ3lzCBjs9+7WXdT9pxasvCKlCt
	BuEN/g1rCAqsA1glTqC6WFdCS9A5OTx7DEiEZbM5RWO3EjWAYDLVnRJN/fKgqkrEvABQs34K+HQ
	KVykoX/
X-Received: by 2002:a05:6300:4049:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-398c6124edfmr4567967637.50.1773283316653;
        Wed, 11 Mar 2026 19:41:56 -0700 (PDT)
X-Received: by 2002:a05:6300:4049:b0:398:ac0d:9a0b with SMTP id
 adf61e73a8af0-398c6124edfmr4567946637.50.1773283316208; Wed, 11 Mar 2026
 19:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260311170510.288840-1-wdhh6@aliyun.com>
In-Reply-To: <20260311170510.288840-1-wdhh6@aliyun.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Mar 2026 10:41:45 +0800
X-Gm-Features: AaiRm50EAAVnChZrCqhCodH4rEb_bUN4giFUBg8QcZi_0jVEOujxWS9z3lD9PWM
Message-ID: <CACGkMEuXNMqpK0S6kbhZGM7ge4As-iWuwAMwsiW-AZaH+TzHwQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_ring: Fix KCSAN warnings in virtqueue_enable_cb_delayed_split()
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: biCOmP-dbtlxQsTqQe1GYgLgNzr04aZm6uLNz5G89BY_1773283317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:05=E2=80=AFAM Chaohai Chen <wdhh6@aliyun.com> wro=
te:
>
> KCSAN warns as follow:
>
> [  109.277250] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split=
+0x10f/0x170
>
> [  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of=
 2 bytes by interrupt on cpu 1:
> [  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
> [  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
> [  109.318852]  start_xmit+0x315/0x860 [virtio_net]
> [  109.324532]  dev_hard_start_xmit+0x85/0x380
> [  109.329993]  sch_direct_xmit+0xd3/0x680
> [  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
> [  109.340568]  __dev_queue_xmit+0x560/0xe00
> [  109.345701]  ip_finish_output2+0x49a/0x9b0
> [  109.350743]  __ip_finish_output+0x131/0x250
> [  109.355789]  ip_finish_output+0x28/0x180
> [  109.360712]  ip_output+0xa0/0x1c0
> [  109.365479]  __ip_queue_xmit+0x68d/0x9e0
> [  109.370156]  ip_queue_xmit+0x33/0x40
> [  109.374783]  __tcp_transmit_skb+0x1703/0x1970
> [  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
> ...
> [  109.499585]  do_idle+0x7a/0xe0
> [  109.502979]  cpu_startup_entry+0x25/0x30
> [  109.506481]  start_secondary+0x116/0x150
> [  109.509930]  common_startup_64+0x13e/0x141
>
> [  109.516626] value changed: 0x0029 -> 0x002a
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Add READ_ONCE() to fix the warning.
>
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>

Nit: maybe it's better to explain it's a false positive.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 335692d41617..ceb026161639 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struc=
t vring_virtqueue *vq)
>                         &vring_used_event(&vq->split.vring),
>                         cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + =
bufs));
>
> -       if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.u=
sed->idx)
> -                                       - vq->last_used_idx) > bufs)) {
> +       if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
> +                               READ_ONCE(vq->split.vring.used->idx))
> +                               - vq->last_used_idx) > bufs)) {
>                 END_USE(vq);
>                 return false;
>         }
> --
> 2.43.0
>


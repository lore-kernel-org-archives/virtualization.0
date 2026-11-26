Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681455;
	b=0Jz0tKmcSwbuL8ifO+bOBsaBNbPHjJ217Nmo2p0WgiM23Sot/CmSl5GV6wSDlvktWfQa
	 pIl5gFhtf4d8Zkc6pJFWEgMpZDrumcl0Cf5L3rKVG502Htgtuf/6TugVwG5YCSaQcMQqb
	 bxdS5qIMz0CaYlNilsCb9F+PZkMxQK9+69Zcgf1vkiSWg/0QbzFxsO3SLBNXIdNuFSCTF
	 Y1iFCQxseNrJHYLTCHXbpbydgVOaPbZC+4oLi6i4M8Lp+pnZL+wYEgvW12Ce14uFFzClK
	 qAJqNnFPCicB6HKVJNk0NTZ0S5lFMCOcWg/Au8AwkyM8PNGQK5HHTxorRKQjCJglH6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681455;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=pQJTlolp/xi+6o7OlGu/nUrAFYiUGZO4XF4cHJ5blEU=;
	b=G/uBpVBPQMA3UWEK9G0MiDBKrB2SYs2bneJ0lgs4nAtyf4lTM04ZDTkVutMulUGBI6CW
	 HV3zSZkjtCJ+/QU2tz1juG9i1no2nIpnEPj1yrYRaFZugcpmk3JANzmw+pUiS9L8BDZvq
	 Cgpg9eua1tfo+vb/pu2Bz3jBTZf/QgrWNH7yCFIAbWIfhjg6huJbsnkCRqOMjf40WgJOz
	 8peXtrm+gsS8vI1KJdj8ZRn9bX2oJrR9+cc3IRkjk1x+eD+iufL+jGPjDrdcuzJTPf999
	 N2PzMV5URMWHzxVD7GbrjLsc0OKysDS8y8HWAX2Fk5BWiE/z/Tpt2qj8/xjfbHugfZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SHtlFf09;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95125606A33A
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95125606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SHtlFf09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795681450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQJTlolp/xi+6o7OlGu/nUrAFYiUGZO4XF4cHJ5blEU=;
	b=SHtlFf09Ngl0LzHzD5lYELKzzePUE6NJuF6MkrDojCziKSI4N8Tj8WrfnKgnnIHuxW2ZUA
	k3Xtmz27IgU6nlye1WF8SfDxsVds58aAksEcvewP12ktGFgp+KEtkOQOpxuRQyMlwfwEEI
	TJ2SG4OFAvLK6UDHCy+y0oTmgKMD8LY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Gub5swCSO8uiE8dqa7lVrg-1; Thu, 26 Nov 2026 08:24:08 +0000
X-MC-Unique: Gub5swCSO8uiE8dqa7lVrg-1
X-Mimecast-MFC-AGG-ID: Gub5swCSO8uiE8dqa7lVrg_1795681447
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so4158102f8f.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 00:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681447; x=1796286247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pQJTlolp/xi+6o7OlGu/nUrAFYiUGZO4XF4cHJ5blEU=;
        b=zk4VCwaTY1dfCAZBw4WtqlX7S8RIRHNdRcdkjHDULGoSbtCnQyYLNKLPtJZtfB2+pa
         6vv/4kFNN2RHdLQOiB35fd7z7lvfBb5s3E0pZUpQSUsVDbb9Tf26s9AyLoEOKBJsOluV
         hTuShepSgFkeSIqu5Fgohc9VWzrGn0eYetMIwTMBp+8LYSb433QSzfo6jJf0ZPiz+9su
         i4ayUD0jxempu+YhfqcvgMA2j13UD3+HAJSsUd4xtYaNpFN/Ljiq8BX9UBjVqU38StzK
         PfPgTI5gM3UZu6WR/loC7LPscusVWsv1/hWw8AcP9j2/0dP/WRdEkAs9/JYaBMsutQqC
         /EqQ==
X-Forwarded-Encrypted: i=1; AL+hErFe+FGx1hj/JXeLSyGnFvXckujwEwKIx3g60k2+Vt/Rt5QLJScGJhezszG0BysHUYwY870xI0jMOI2Y8nfMJQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/J+yF11i73HEv50XQUap2+5qe9EN+aaLrrj8LFda4xAS1rBJjL
	ifhWYuKn9JSwxut90wXv91pGXZjoXmcSdUO5Rqt5E7edGh7ozJWA3boPf1Zgt2HkbQNRS0SRp+b
	PpiTERLtkLltZh/AoW//rVpPNNgDhupZigZlEn3KcpazHo8SpMNggrTdqelohArs/SJdC
X-Gm-Gg: AZFdTZcGevLJ1fu+Rt4/3DX9mHv3OribZvip8TYFF0DxHsFX3ppPaSzptY5Itooxb2S
	r7+S+EQNKAUXC5GzMyhqDXMHzEi7ZIyoL98WQEabmbIPBeCMEnwCOScgafjDoYdd4o7G8QNHKcr
	UPeZBUGYT86qhZDSKRwE/grGb4vwOAEdUiXz9zjaE2/UKSwO/erPdIGoF2mVN1R+C/SuPqyVaXH
	JiBfm+TTjJujPZUi1w5kz1BqG+fhcqYuCZNaj48lS3IA505gFyvRj5CIUALQEe7WbtwkAD35dRi
	YfYkfW9bD6eImClbY9DNb7XgsEkSI5q9yUV7h9Zjn6zUf24z/0fp0p22zEWtGFXuoLzPFsyQ9fk
	Voa7teuqR4MVVkLcRCsCRnBs/2tJoFWGH07hPG2ak6pQ=
X-Received: by 2002:a05:6000:26ca:b0:492:3176:3d64 with SMTP id ffacd0b85a97d-4abad5ac748mr39978327f8f.8.1795681446889;
        Thu, 26 Nov 2026 00:24:06 -0800 (PST)
X-Received: by 2002:a05:6000:26ca:b0:492:3176:3d64 with SMTP id ffacd0b85a97d-4abad5ac748mr39978266f8f.8.1795681446308;
        Thu, 26 Nov 2026 00:24:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm39200632f8f.4.2026.11.26.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:24:05 -0800 (PST)
Date: Thu, 26 Nov 2026 03:24:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Seojin An <love09010224@uos.ac.kr>, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, security@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Message-ID: <20261126032258-mutt-send-email-mst@kernel.org>
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
 <CAJaqyWdLXzosXuFs8iafx0x1moGsOZuWuAQCJqCQUrOt++FCBQ@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdLXzosXuFs8iafx0x1moGsOZuWuAQCJqCQUrOt++FCBQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jqcYgCK48beyodlNpJl7lYbFuA-mHubAHytYw6zklWM_1795681447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 09:14:36AM +0100, Eugenio Perez Martin wrote:
> On Thu, Nov 26, 2026 at 9:02 AM Seojin An <love09010224@uos.ac.kr> wrote:
> >
> > Split descriptors store the next index as u16. alloc_indirect_split() can
> > allocate a larger table, but virtqueue_add_split() feeds the truncated next
> > value back into its construction index. With more than 65,536 SG entries,
> > the index wraps and later entries replace descriptors at the start of the
> > table. The device then consumes a chain different from the caller's SG
> > sequence.
> >
> > Reject split indirect tables whose entry count exceeds the representable
> > index range. Keep the existing compatibility policy that permits
> > representable indirect chains longer than Queue Size, and leave packed
> > indirect descriptors unchanged.
> >
> > A virtio-gpu render client can reach this condition with a vmalloc-backed
> > EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
> > substitution provided guest physical read/write and initial-namespace
> > uid/euid 0. The virtio-gpu producer needs its own Queue-Size check because
> > its current queue error path warns about an add failure but advances
> > pending state and reports success.
> >
> > AI tools assisted the source audit, reproducer construction and patch
> > drafting.
> >
> > Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_INDIRECT_DESC)")
> > Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> > Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Seojin An <love09010224@uos.ac.kr>
> > ---
> >  drivers/virtio/virtio_ring.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index f683a2d6a2002..ad9e52584fb52 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> >
> >         head = vq->free_head;
> >
> > -       if (virtqueue_use_indirect(vq, total_sg))
> > +       if (virtqueue_use_indirect(vq, total_sg)) {
> > +               /*
> > +                * The core historically permits an indirect chain to exceed the
> > +                * queue size.  Preserve that policy, but do not let its 16-bit
> > +                * split descriptor links wrap within the allocated table.
> > +                */
> 
> Seems like the same code path in the packed vqs also needs this check?
> 
> Also, a question for everybody: is it really too late to forbid
> indirect tables bigger than the queue size? It is not guaranteed that
> the device will be able to handle it anyway, should we just add a if
> (total_sg > vq.split.vring.num) return -E2BIG?

It's not too late in that the spec forbids it.  But a bunch of drivers
are broken, so for now the best place for this check is in the driver.

> > +               if (unlikely(total_sg > (1U << 16))) {
> > +                       END_USE(vq);
> > +                       return -E2BIG;
> > +               }
> > +
> >                 desc = alloc_indirect_split(vq, total_sg, gfp);
> > -       else {
> > +       } else {
> >                 desc = NULL;
> >                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> >         }
> >
> > base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
> > --
> > 2.43.0
> >


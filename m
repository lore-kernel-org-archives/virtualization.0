Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB782FD69D
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780463419; cv=none; b=uxl1NbZ2f1T87Y1yecsv7KaNrJUuaaW/fyybVZzKof6NoqDRck6GltuxahYtVldM005Uu2DmqaDheDqX5Rl06ykSoByCFElXR+b+JtQiGNTpzPdMk6c6q79rDYbT91WzQOYa9vhCopN8SJ3Qca+evC6RgOmIRiGNDxX9aThiMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780463419; c=relaxed/simple;
	bh=TMuRorPnXh0/q0Epr8aWbRUQFdWaiTfi93eQL9g5Ftg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MCvIAcJU5PF0aTPg7ndxPp6CL1uXhcHdMUwuEKB1nWgGI3pGB4U1pjVb7RP9Zme3HtRHy3hWPKslDEo7IO8WBRzi9TLIt4H95vCMYOggg1ppdTJz64CQgb5SVGOb42MQ+MrrEu1T2zObF73iW3datjQesj1cWImcwt7C7f0VF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXpN1YYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXpN1YYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780463417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+J3prPmslsfPO9pmuIRUDYHV1FwtfpJ+bwDKkD+iUA=;
	b=cXpN1YYN23IQaRFbEsPifv283V6ZR/K7zn0PW7Z4MeaX3QHenz6tiM6ANzhYecRBp4IiMC
	/hORdnB+oG4llPQUL3oWr9H7Ri+fYqmhILKaOLJSjt6c/4delOXj9mVtX7fuP+ugDGyt9m
	hXgoBdOQy7j36XkCBHH2gPYQhsTeigw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-SRVlLkDuOiqfX5GhGYbUyg-1; Wed, 03 Jun 2026 01:10:16 -0400
X-MC-Unique: SRVlLkDuOiqfX5GhGYbUyg-1
X-Mimecast-MFC-AGG-ID: SRVlLkDuOiqfX5GhGYbUyg_1780463415
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso2812814f8f.0
        for <virtualization@lists.linux.dev>; Tue, 02 Jun 2026 22:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780463415; x=1781068215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+J3prPmslsfPO9pmuIRUDYHV1FwtfpJ+bwDKkD+iUA=;
        b=Y82P2kGm2/MCoiV7lkrBAsMO34KvPLnwdc3YRoIencok3n695LY9wCZI53hfbIG2xj
         92BD1q88hVPF3fzu4sMeCK3jmQPX9c+6ZMcLfIT321Je9NHH7fD49uesx3bM/+eoJrDa
         0zQ3NwyUTlUrGOfDcqf3IB9TjvLbkdRr8qxHa+lYOJzxG7kY6BBx/6pxxa4D2Rz3j+UP
         ITT4gql8ArBR40uGIPuoxcmbd21RP9Q5II0szVd0QMekBy0IAWafImVWoyT1/A0vmVCT
         dRB+H8zSwi2SpMcZCimj/WqofS5w8aULLxKgPhI25bZ7E6/ztEZgWpyO4jmuWXWa9MzY
         W8kw==
X-Forwarded-Encrypted: i=1; AFNElJ/x7H/iwmT5cW6hBJYrifngApBX/lmZA8GancAS5d1c/hgIfmvS+GR9kt+ZNLhV5ZTF1t9mN1SZEBVxLE90NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydsYJ1WlLrct9dVvG8nqt9Pmo4BOxnhA5T1TbHHMPWdaX78t41
	66Gh/ggA0313xnQWTEoaplvJitXVEvFIJ8u70r1Iar/Pj7xeKezMaTguIo/IqsISD2RFIB4GpNi
	zTlX4h1cnwQRiO119kj1U3+vNqUd86Icc314W+RxKFm6zEH958Azde228HCUfJ9qb27Wp
X-Gm-Gg: Acq92OHloNvo0skRwjyIH2L3CycGdk7btcxZ3A/R4wmGIb8KLoLfIkGlZEY3onHoS2q
	bOyU+EM3pLZE/oxLBz8adHnneLgOL15xYYK4utKXvBanKFYGQ8unNFTuLDbp9LXAviDnmc+gKap
	HrC++xpFDxs9sD6WQNb7ej5Zd6BDEMkonMhwBd+5sAMy/6+7w284AJvDiUBS0H215tuAbDhqv9v
	xfgCBL7CpqoA7CJdR6rqPKVFpWFuHCKu9lcoxMKMsD33OJDGePYT86vlNnjgARQNt5WJsgRPXlG
	BncIXcsMBdDxEHUSDdwT/Zc9EXijn5MK3D8E7atODjeTR4try/6hFZTE++dTsWUKyoSRBX1s9ec
	fRbnBKjc9c1sxjWPdJHTT4c+HJtO+131z6dHSNEvqu9GuaEdlyeimog==
X-Received: by 2002:a5d:42c2:0:b0:45e:e230:e53 with SMTP id ffacd0b85a97d-460218701f1mr1573481f8f.34.1780463414691;
        Tue, 02 Jun 2026 22:10:14 -0700 (PDT)
X-Received: by 2002:a5d:42c2:0:b0:45e:e230:e53 with SMTP id ffacd0b85a97d-460218701f1mr1573433f8f.34.1780463414129;
        Tue, 02 Jun 2026 22:10:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm4549179f8f.0.2026.06.02.22.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 22:10:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 01:10:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yangjiale133 <yangjiale133@163.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed
 ring.
Message-ID: <20260603010910-mutt-send-email-mst@kernel.org>
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <5a3e06d5.103d.19e8b1863dd.Coremail.yangjiale133@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5a3e06d5.103d.19e8b1863dd.Coremail.yangjiale133@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3cIFntlilNZWjX37FzTTQ09KtbwWuagymD87WSpSHs_1780463415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 03, 2026 at 09:28:11AM +0800, yangjiale133 wrote:
> From the device's perspective, during a single read of the descriptor list
> specifically when that list spans across cache lines.
> the retrieved data will show `desc[head].flags` as valid, 
> and `desc[i].flags` as valid as well; however, 
> the `desc[i].addr` and `len` fields may be invalid.
> 
> I apologize that I currently lack the necessary environment to verify 
> whether this modification definitively resolves the issue or 
> merely reduces the probability of its occurrence; 
> therefore, this patch can be discarded.
> 
> yangjiale


it could be that your device does a single read of the descriptor.
the pci spec is explicit that after getting valid flags,
device must read the descriptor again.


> 
> At 2026-06-02 14:04:13, "Eugenio Perez Martin" <eperezma@redhat.com> wrote:
> >On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
> >>
> >> When a descriptor list spans across cache lines,
> >> updating the flag first can lead to a scenario where the device side
> >> perceives the flag as valid, yet the corresponding address and length
> >> fields remain unupdated—resulting in invalid values.
> >> Therefore, the flag field must be updated last.
> >>
> >> Signed-off-by: yangjiale <yangjiale133@163.com>
> >> ---
> >>  drivers/virtio/virtio_ring.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index fbca7ce1c6bf..036b4f90d30f 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> >>                                              &addr, &len, premapped, attr))
> >>                                 goto unmap_release;
> >>
> >> +                       desc[i].addr = cpu_to_le64(addr);
> >> +                       desc[i].len = cpu_to_le32(len);
> >> +                       desc[i].id = cpu_to_le16(id);
> >> +
> >>                         flags = cpu_to_le16(vq->packed.avail_used_flags |
> >>                                     (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> >>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> >> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> >>                         else
> >>                                 desc[i].flags = flags;
> >>
> >> -                       desc[i].addr = cpu_to_le64(addr);
> >> -                       desc[i].len = cpu_to_le32(len);
> >> -                       desc[i].id = cpu_to_le16(id);
> >> -
> >>                         if (unlikely(vq->use_map_api)) {
> >>                                 vq->packed.desc_extra[curr].addr = premapped ?
> >>                                         DMA_MAPPING_ERROR : addr;
> >
> >These flags are updated before the flags of the head descriptor at the
> >end of the function, at "vq->packed.vring.desc[head].flags =
> >head_flags", so the device should not see these. Because of that, the
> >relative order between the rest of the fields of the same descriptor
> >or other descriptors' fields, except for the head descriptor's flags,
> >should not matter. There is a write memory barrier just before
> >updating the head's flags.
> >
> >Also, I don't get why the cache line matters here. Can you expand? Am
> >I missing something?
> 


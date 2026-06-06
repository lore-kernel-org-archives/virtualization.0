Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E612CDA5
	for <virtualization@lists.linux.dev>; Sat,  6 Jun 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704712; cv=none; b=I4uy8lxsWwlc8sRUYnmq18RX8kNHq2sc3SqS1+k+j8QkaOchzGuxv0VFgDrMXI1g3MdQNLzXhwyjIQhYd9vYkjaJZmoTvqIuraEntKbt4VEb4tHWsRLJnxTLEPvioXLhLv14ouuuPks+zpUogXBeXmtm/Hauq1s4FRGUyjlERUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704712; c=relaxed/simple;
	bh=ccE1vyo3mkwzgcyciyLNh8mUmRuplMG/jETlxZAMsnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LN11YKUIq+1fpnc4393iV5UWALKSYtMshgJhwdxHRSCtsN23Ct+TdBd9Q550KYWrvnv4qc8gCV1m103atAVgDdS4rV+6Yy19QRWgq3kQzADBzOtL9/nTlFVDC1ka1R2ycTXhs94bnLwx74MLdQKnJzrpAIRf1I04SPz3eCa1gQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqnZCO4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqnZCO4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780704709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJSVZacPqI8DQo08516ne3I19qnW6i3FfC453BcTXZ4=;
	b=TqnZCO4+xYdRtkZ8I7Xan1fZmcuLxp1FcqvbKW8iFdH0omXi0luoX98IxmG8duASwKvPTo
	hvvPUkbwd+X/YDXEdiYHMtP8r0WhOkTHT8PL+0gLCA9q1OdNPwv8cZMMv68UvUEzhmgvwB
	K0st4IGhg37bww2drYdwRJGXuKOQoeM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-gfBafBLuM8itGsVnwsYjCg-1; Fri, 05 Jun 2026 20:11:48 -0400
X-MC-Unique: gfBafBLuM8itGsVnwsYjCg-1
X-Mimecast-MFC-AGG-ID: gfBafBLuM8itGsVnwsYjCg_1780704707
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef93c359fso2065018f8f.0
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 17:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780704707; x=1781309507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJSVZacPqI8DQo08516ne3I19qnW6i3FfC453BcTXZ4=;
        b=QIIPwojRHmIknK/J0pIoM81hoSdMZBRzN7yYFwuK5RVY4Lw8trDONgI+IOiadlxa3T
         Hx2ysglIE8I188yKOJc2K4awO88Pxb5BB9s+qaSVIeUB2LkPqLj/SbE36Q9cz/YCHut+
         HnM2PX9U/yZYzOfR9Lid8ftAyviUJyLgFBA/j9oEXNAuRUAYPcP7pqO5tk/tk9vrCKp7
         7bYFC6wBkfH+/gnxfyvxAygPgvaX2vMnCFZK7T+nvEt/L6BuYCwGlIqMYMCZZxwHPJWy
         Hu9TvDR04dyXzmFKSYnhYiOUnwxCS1Tz7bd290TC5e3QM9DF42lmBnD5OVOAnwKW6e/L
         ePsg==
X-Forwarded-Encrypted: i=1; AFNElJ+LbGvf0VzY0mmSY0bt5iO4oW4uxUm2avq8ebzfDicsae2HlOwlpa/WS1eitMikG0Ty7i+APezZET4xWkvEgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFQxAoX7TwZmMEOn6mXXNiAsvgPPTR95jZNfaCTemTkbremFAt
	RHyjvpCD/Hy9YWXR6ScftxB33akO5gTk/blLI2SIefkumDabVd23IldbeWGunpwXf0WDXGL27pI
	dVTCuhQhKHJ5RA1hGPCMeQlrIt3m9IQn2K33sQmjsOlfZ4/Rc6gLl5/iVWSwQyn8KEi54qc/kwZ
	Bg
X-Gm-Gg: Acq92OFwQnVKDnSV93KhBxdOKv5WV56D4rsTyUmPQviVfeLlHAD4o9xa8+hMvw/80dO
	GmTEB3a2/XUffeYfCeX1MM7Lz9z2/j5icXltTFP+DIaTZgJt8IdD9VoB/zskNzUBubaUUmKlwSZ
	i0Df2EnBnOr+PPCpJpcvEafp7Tvz3E7gCVPSbaVUyY/Z9FbuhSpvmrXk2PlFrVeXao4SFL35CnE
	++bTmU6V2b4iZd6/EZrVu9pjBtrAc3CebnXugaZdXEt0mzLIwBZMLNF5tXVWTq8sWm6AfR/jNGJ
	xIqWuEBSRTtGYpPjSi3mzqGJbV8RsX1paX2kWRQtgwoY8X2RkTakoVckMGZCwM/O8uI8/Xsyewo
	5Z3G9NWscyz01QGrhaDgw6Ugw7/zAovFqQmaId6HZyw3TkHvnFcllGec=
X-Received: by 2002:a5d:5270:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-4603051261dmr7230422f8f.26.1780704706743;
        Fri, 05 Jun 2026 17:11:46 -0700 (PDT)
X-Received: by 2002:a5d:5270:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-4603051261dmr7230401f8f.26.1780704706256;
        Fri, 05 Jun 2026 17:11:46 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm29881640f8f.0.2026.06.05.17.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 17:11:45 -0700 (PDT)
Date: Fri, 5 Jun 2026 20:11:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	yangjiale <yangjiale133@163.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew.Boyer@amd.com
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Message-ID: <20260605200908-mutt-send-email-mst@kernel.org>
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com>
 <20260605134252-mutt-send-email-mst@kernel.org>
 <5e1a10bd-2783-42ba-b443-853f12159756@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5e1a10bd-2783-42ba-b443-853f12159756@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlhdsaQsO_ohoMpHV67R0e2vHoee2UV4XdHjKq74hQk_1780704707
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 05, 2026 at 11:50:36AM -0700, Si-Wei Liu wrote:
> 
> 
> On 6/5/2026 10:43 AM, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2026 at 09:03:36AM -0700, Si-Wei Liu wrote:
> > > 
> > > On 6/1/2026 11:04 PM, Eugenio Perez Martin wrote:
> > > > On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
> > > > > When a descriptor list spans across cache lines,
> > > > > updating the flag first can lead to a scenario where the device side
> > > > > perceives the flag as valid, yet the corresponding address and length
> > > > > fields remain unupdated—resulting in invalid values.
> > > > > Therefore, the flag field must be updated last.
> > > > > 
> > > > > Signed-off-by: yangjiale <yangjiale133@163.com>
> > > > > ---
> > > > >    drivers/virtio/virtio_ring.c | 8 ++++----
> > > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index fbca7ce1c6bf..036b4f90d30f 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> > > > >                                                &addr, &len, premapped, attr))
> > > > >                                   goto unmap_release;
> > > > > 
> > > > > +                       desc[i].addr = cpu_to_le64(addr);
> > > > > +                       desc[i].len = cpu_to_le32(len);
> > > > > +                       desc[i].id = cpu_to_le16(id);
> > > > > +
> > > > >                           flags = cpu_to_le16(vq->packed.avail_used_flags |
> > > > >                                       (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> > > > >                                       (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> > > > > @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> > > > >                           else
> > > > >                                   desc[i].flags = flags;
> > > > > 
> > > > > -                       desc[i].addr = cpu_to_le64(addr);
> > > > > -                       desc[i].len = cpu_to_le32(len);
> > > > > -                       desc[i].id = cpu_to_le16(id);
> > > > > -
> > > > >                           if (unlikely(vq->use_map_api)) {
> > > > >                                   vq->packed.desc_extra[curr].addr = premapped ?
> > > > >                                           DMA_MAPPING_ERROR : addr;
> > > > These flags are updated before the flags of the head descriptor at the
> > > > end of the function, at "vq->packed.vring.desc[head].flags =
> > > > head_flags", so the device should not see these. Because of that, the
> > > > relative order between the rest of the fields of the same descriptor
> > > > or other descriptors' fields, except for the head descriptor's flags,
> > > > should not matter. There is a write memory barrier just before
> > > > updating the head's flags.
> > > The above analysis is absolutely correct. Though one hardware vendor told me
> > > that this driver implementation kinda stops them from reading ahead of
> > > descriptors already posted beyond the available index., ending up with
> > > suboptimal performance that is hard to make up by other means. Would it be a
> > > bad idea to go with this change and add write barrier in a gentle way for a
> > > small flit in the batch, e.g. commit to memory after every cache line size
> > > worth of descriptors are posted? Would the memory barrier have negative
> > > performance overhead to other backend implementation variants than real
> > > hardware PCI device?
> > > 
> > > -Siwei
> > this would need a new feature bit, won't it?
> Probably. This is to capture the device's expectation and behavior right?
> the driver change itself is not spec violating...

yes, device can't rely on this without a feature bit.

> > 
> > > > Also, I don't get why the cache line matters here. Can you expand? Am
> > > > I missing something?
> > me too.
> > 
> Just to avoid extra delay due to excessive coherency messages and frequent
> cache thrashing, device read over pci bus contends with host write/update on
> the descriptors in a same cache line..
> 
> -Siwei

this should be infrequent, the whole idea is that there's parallelism:
device reads descriptors from X while host writes other ones to Y.

btw i can't say whether it's ok for device to just issue 2 reads,
or does it have to receive read result and only then issue the second
read.
-- 
MST


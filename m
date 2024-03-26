Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE694749A
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434938; cv=none; b=lNsfY6IRkKfEnnoEyVelI2/7p/IoYLpeHA34HyV/pRGswVQnKb6NQBjO9IpdXNYPRPO+SqVHyZ3M7GLE4K9HkO2OFmvbcyUk0K3bzYy2iVg8AU6ktwS5q/p+vvV6sPX12dkVjmfa6KAzzE6G7w+AuciCA1qkau1Px6teLrTae8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434938; c=relaxed/simple;
	bh=4+78nYQYB5Ci4NBkQebLOQgyOWv4FelTbQqjgSKmNzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P14aNz0p5Gv++xX/5NbNtUVL2ZQK2jmK5Ph6A3tuXniI+2I+K+nTvHVVD2x4L+PF0FEe8DvRtOksZ/cLr9xAPLs9GsTuNxOfUW+Z161mN3YUfinOtcaMbB/0eLOL3G7kXF0A6tyJYR/2m5mbe/d9LbLvBbwQrpp9jkRql2LFU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUs3uehJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUs3uehJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711434935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV+n/AeH1+Y7vCOvFadr8DCW2Eq+lIrkj6t17qDJyoM=;
	b=DUs3uehJbb9o+Z86OpHKah8wmqNdE+H3IQCWWG7GzJbDAMiM2JhwTaJwB0hEn8UeEmatjD
	eOfgViJ9EtkrX4UQk2AWSnqu/79DG50/zvV8WwQUcgPUxDMtWB2fE39EtthM7SOox58xku
	wWIEjid37wPqJezjyF8/jsaEBfrrBn8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-PLqkrXIRNAmYh_pC09UvqA-1; Tue, 26 Mar 2024 02:35:34 -0400
X-MC-Unique: PLqkrXIRNAmYh_pC09UvqA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dddbcc6a2aso41730695ad.1
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 23:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434933; x=1712039733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV+n/AeH1+Y7vCOvFadr8DCW2Eq+lIrkj6t17qDJyoM=;
        b=uz0BhtkH4yFAadav0fCJUZduS3/LZ3ULyGFaXwVFZiBMFmbOTFrsrR8c6uIZ3iIYXc
         GrEdnzG5uYe9yTrEmqXcczzUwL1n+WvAkXQnWQ180xFT2szxIOiVlSyMCgBDLkMFVNZh
         +PyBBPQn+SGWEcVhRChI5EHMtibAioM4i1TYWwHz8JboJHSyTTA2larFaFjuCl4LNthu
         ryOZcgfDruzZNEen3Gp/WJDW8If5zPYIuAyc2peza+V8ieLfaf3JG6Uq/1D6N2qiBAo2
         YEfnxzFKuBBqo7LpOzHxrPgSBNgHsuheON7ApxIw6xYcsPvvw86gABOsa5JlUMQBS1xC
         4JbA==
X-Gm-Message-State: AOJu0YzrcJAXUDL4w/GV8dLsP1G8YDSSkPk+kHYfl548LKQXv9hqcPCb
	qjIDArPn//4wrbftXdRjQ8pkRbibst9lCj0/z8LhJt/6ayn/mIM79VWNPfEmJ0NeYYC7t0sDwX2
	TT0bXAtwpIIaN7toMUwBo6xWQEY+EN1gCo6KC/tFDasMeizO+DsyaHsgn49KVlVvZa4TTNPkZwm
	iqxkFKR/TmwE2hwJcgwuN4uDN09RWm1Ntda+97oNQ=
X-Received: by 2002:a17:902:fc45:b0:1e0:93a:e681 with SMTP id me5-20020a170902fc4500b001e0093ae681mr10547523plb.58.1711434932771;
        Mon, 25 Mar 2024 23:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG38L73eoMVI0gE3VFcyJZbiAF71PJ9iqlnhy7YMgjlqkfIehY0e1Gl+LcuuDusrn1SHlJkZivN0EXqYXxdNPQ=
X-Received: by 2002:a17:902:fc45:b0:1e0:93a:e681 with SMTP id
 me5-20020a170902fc4500b001e0093ae681mr10547503plb.58.1711434932411; Mon, 25
 Mar 2024 23:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:35:21 +0800
Message-ID: <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
>
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYq=
RZxYg@mail.gmail.com
>
> If the virtio is premapped mode, the driver should manage the dma info by=
 self.
> So the virtio core should not store the dma info. We can release the memo=
ry used
> to store the dma info.
>
> For virtio-net xmit queue, if the virtio-net maintains the dma info,
> the virtio-net must allocate too much memory(19 * queue_size for per-queu=
e), so
> we do not plan to make the virtio-net to maintain the dma info by default=
. The
> virtio-net xmit queue only maintain the dma info when premapped mode is e=
nable
> (such as AF_XDP is enable).
>
> So this patch set try to do:
>
> 1. make the virtio core to do not store the dma info when driver can do t=
hat
>     - But if the desc_extra has not dma info, we face a new question,
>       it is hard to get the dma info of the desc with indirect flag.
>       For split mode, that is easy from desc, but for the packed mode,
>       it is hard to get the dma info from the desc. And hardening
>       the dma unmap is safe, we should store the dma info of indirect
>       descs when the virtio core does not store the bufer dma info.
>
>       The follow patches to this:
>          * virtio_ring: packed: structure the indirect desc table
>          * virtio_ring: split: structure the indirect desc table
>
>     - On the other side, in the umap handle, we mix the indirect descs wi=
th
>       other descs. That make things too complex. I found if we we disting=
uish
>       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be cl=
earer.
>
>       The follow patches do this.
>          * virtio_ring: packed: remove double check of the unmap ops
>          * virtio_ring: split: structure the indirect desc table
>
> 2. make the virtio core to enable premapped mode by find_vqs() params
>     - Because the find_vqs() will try to allocate memory for the dma info=
.
>       If we set the premapped mode after find_vqs() and release the
>       dma info, that is odd.
>
>
> Please review.
>
> Thanks

This doesn't apply cleany on vhost.git linux-next branch.

Which tree is this based on?

Thanks


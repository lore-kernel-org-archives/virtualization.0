Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12114830D
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163318; cv=none; b=q8nBpcdd+FkJWOPKgZZOqZ1aspsWreMxsdXE7NFLl5qp9dLeFxwfUB4SxEBbu64tXOQbNAOpWVmHIJ58R6ZnBmyhgNaV2jjwsDyTchbXI+/zNlw9u6KftEUzt5E3qmaV+XWFzWK+h+UQiQdHGcKJ6xxeKgMyapkI5LXQ5La14rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163318; c=relaxed/simple;
	bh=Pi9d7gNiO4DS3SDzWa/4QtX1cX+prhZOX1ZtG7jctZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTTXI3Ns9yP7hW3Yot9DoInfbreaL1XuaPalAi2ByzEleDf56WhiOzOxHN3FLDWcMVRw11CfyCvevoyj/NMSckYuvjMssNv+SZQhLEo7n13NfgjIq/EZIHs0e9fKe9VcDkoZKe6SwgYP11ag2XUjltyfXcSKKUuOB3JUhIHojvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFqWk+o1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFqWk+o1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ8OJ8bmZ0N9rNX3pgknWe8I/aqMX0yClUl7I+76Q+k=;
	b=fFqWk+o1Zi7jY3y3IJsYm9gRCyczD29IFpLpuaQwPZoIasuFH0RiAEOQ6Q29Z8qi3J8kSZ
	uUSCPG2kc3x/WFGT/oOK5Zz0dPddQzEe7fpkXy3f8GCXeixsRRsxTkgQoX5mfSs1PmN+Q7
	QVN2eigI5w99RLa/7/iswRKUVQoKKus=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-M6NOLFJzOKGmEh1fnFVjfQ-1; Tue, 24 Sep 2024 03:35:15 -0400
X-MC-Unique: M6NOLFJzOKGmEh1fnFVjfQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71a122bf521so1683439b3a.2
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163314; x=1727768114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ8OJ8bmZ0N9rNX3pgknWe8I/aqMX0yClUl7I+76Q+k=;
        b=Vm93uAAknvXVcPkevboA451FdUhIngUYgu2bBNmMXu827iVahnnCZIwhHnQAMX8oLW
         MdJkHx0dcjpeNkkrsZZRgve5ZuenQE6loOkDEnKvOjiRyPASpyS5Ajpro0mOAS4Nravg
         vFciw/JmVZjVDtnADRDWPVW84hB0DID/ZgbjXF0Gt9USrG9K7YNsf/GdzCeYHGiFH/1b
         V+HDzL/alEt+69mnBHsuHKVuF0LhouNSS7F6JXJFPeSE3Njzhhjweek9g4BIrTfL756F
         uBSOKpn+T/cce5WGsyHE9N2Gb0zuwiF60ciPTanfDNIpbqxG7Eo9ADRMy7+mVXs27c0/
         IOKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7tWZktIPl+tae58d4QE0IrTvbqDzd/Yy1NuWve5n06Lr0p/kpLPUS9qEE4xj65+RuCc0VQi3bijvmy9BkMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSExxm+oCa7mnHbAIKeMRjZ9CkNjDCbPc6nxLNdD4IFAL5EdqK
	9g/6BAOtCd150uvJk1UTQgNRyat2le//VTDDF+BVR18DUdlV3yYvU5L7Xt68oiUR0MzxewUF5xz
	nkQ47s7XQpbN6t1j0qY6F1r0/1GQpt3T3lXNsrHoIfLD/p4gFXzTPeHKTWqQIXyEbQozPxwKfHS
	hsXFOnJMgkTgCSAj/OGt0B5eRdyj4/qP0vZGGXr8M=
X-Received: by 2002:a05:6a20:2d2c:b0:1c6:fb0b:51d8 with SMTP id adf61e73a8af0-1d30a947df3mr14803009637.9.1727163314096;
        Tue, 24 Sep 2024 00:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH93wsd9olWTU1uYReqgn70Hj++nACEzMR+hjA412Zlezslgj7mshDHYfl/+df7GQDC/eLVRkVTwOK95+rYsu0=
X-Received: by 2002:a05:6a20:2d2c:b0:1c6:fb0b:51d8 with SMTP id
 adf61e73a8af0-1d30a947df3mr14802990637.9.1727163313667; Tue, 24 Sep 2024
 00:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:01 +0800
Message-ID: <CACGkMEtuF8xx-R08oKmoZo3dMSnCBkjG9tKTZJ=mL1z=SgO2tQ@mail.gmail.com>
Subject: Re: [RFC net-next v1 04/12] virtio_ring: perform premapped operations
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

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
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
>
> We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> indicates that the driver has performed DMA mapping in advance, allowing
> the Virtio core to directly utilize sg_dma_address(sg) without
> conducting any internal DMA mapping. Additionally, DMA unmap operations
> for this buffer will be bypassed.

So I think we still need some explanation here. I think this works for
virtio-net as the sgs are initialized by the virtio-net device itself.

But it seems not the case for all the others where the sgs were passed
from the uppyer subsystem. For example in __virtscsi_add_cmd(), we
had:

        if (sc && sc->sc_data_direction !=3D DMA_NONE) {
        if (sc->sc_data_direction !=3D DMA_FROM_DEVICE)
                out =3D &sc->sdb.table;
        if (sc->sc_data_direction !=3D DMA_TO_DEVICE)
                in =3D &sc->sdb.table;
        }

        /* Request header.  */
        sg_init_one(&req, &cmd->req, req_size);
        sgs[out_num++] =3D &req;

        /* Data-out buffer.  */
        if (out) {
                /* Place WRITE protection SGLs before Data OUT payload */
                if (scsi_prot_sg_count(sc))
                        sgs[out_num++] =3D scsi_prot_sglist(sc);
                sgs[out_num++] =3D out->sgl;
        }

Thanks


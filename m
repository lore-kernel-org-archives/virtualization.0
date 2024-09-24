Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28A14E2CC
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166254; cv=none; b=HsDGK6Jr/UNh1qYJW13MsHa+yEPZWyjet95bLPAMEwX9PIh5a4B74mBjFAkCU1wxoOWogEOTlRu7ry5opSWQLBbE8Hso0L57/SJbNuEURnEiRwRD1qR0XddYFuL4aL6H50Yc4klO3Dxb5TtT9tdxdO6cyWL+lLlkafLbpVq+K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166254; c=relaxed/simple;
	bh=HLr8oWvgzOpLtqPcMBjfonh4/FyMI+ThhNUZFnu5JcI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=JfCxOJ+LGyJ3tqs4CtDkM9iJhiBNnNsqRoQruEhEbVbX0G5u2Hs0ZIKoSqIChthIaahxQ2wTWybLNqnvbkQX3fy0+Y18sHsC9+jQBQVQrYFu3x0QhdiPVrvMDjyO+aQkm7/WWHY6YpJKhYpCeai1RU+3uJppyOscebHBYuttbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HYBQVMcj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HYBQVMcj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727166245; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=xisSaNawnlGSwR/PzRWf7E78QFcMlAE+VNQimYqDHBg=;
	b=HYBQVMcjrisQDfnk+ZHVFpthEtqOuCpZi9ZcTpt0rmdGR7vAdnbAzRzOR30Tdgp8TsqGxVvq3HgbAHR2LqLV9JGg2sFSKJWEBGwcHmXi3J2xxCd2lyYdPXw6/N1pFV/XoLEsmq3LqsJqWDKKr+dZt8Bw+hY20Iy+2jhRJsrebXw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFfUpEj_1727166243)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 16:24:04 +0800
Message-ID: <1727166134.9448166-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 04/12] virtio_ring: perform premapped operations based on per-buffer
Date: Tue, 24 Sep 2024 16:22:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
 <20240924013204.13763-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEtuF8xx-R08oKmoZo3dMSnCBkjG9tKTZJ=mL1z=SgO2tQ@mail.gmail.com>
In-Reply-To: <CACGkMEtuF8xx-R08oKmoZo3dMSnCBkjG9tKTZJ=mL1z=SgO2tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 24 Sep 2024 15:35:01 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The current configuration sets the virtqueue (vq) to premapped mode,
> > implying that all buffers submitted to this queue must be mapped ahead
> > of time. This presents a challenge for the virtnet send queue (sq): the
> > virtnet driver would be required to keep track of dma information for vq
> > size * 17, which can be substantial. However, if the premapped mode were
> > applied on a per-buffer basis, the complexity would be greatly reduced.
> > With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> > skb buffers could remain unmapped.
> >
> > We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> > indicates that the driver has performed DMA mapping in advance, allowing
> > the Virtio core to directly utilize sg_dma_address(sg) without
> > conducting any internal DMA mapping. Additionally, DMA unmap operations
> > for this buffer will be bypassed.
>
> So I think we still need some explanation here. I think this works for
> virtio-net as the sgs are initialized by the virtio-net device itself.
>
> But it seems not the case for all the others where the sgs were passed
> from the uppyer subsystem. For example in __virtscsi_add_cmd(), we
> had:
>
>         if (sc && sc->sc_data_direction !=3D DMA_NONE) {
>         if (sc->sc_data_direction !=3D DMA_FROM_DEVICE)
>                 out =3D &sc->sdb.table;
>         if (sc->sc_data_direction !=3D DMA_TO_DEVICE)
>                 in =3D &sc->sdb.table;
>         }
>
>         /* Request header.  */
>         sg_init_one(&req, &cmd->req, req_size);
>         sgs[out_num++] =3D &req;
>
>         /* Data-out buffer.  */
>         if (out) {
>                 /* Place WRITE protection SGLs before Data OUT payload */
>                 if (scsi_prot_sg_count(sc))
>                         sgs[out_num++] =3D scsi_prot_sglist(sc);
>                 sgs[out_num++] =3D out->sgl;
>         }


With this in mind, I think the new api is a suitable approach to avoid chan=
ging
sg.

Thanks.

>
> Thanks
>

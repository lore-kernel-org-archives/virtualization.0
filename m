Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131575234
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672474; cv=none; b=hMT92HQIBh5PQVK8pxM2e/QQMGM8s+rR4gq4NdhZBseQu0Z7V1MIWdAgJWH/i1izU7SfQ8QqX0HHEjDQ/gDLVDnkkmiqbv4Hi92cF79TKuRQD1SAMzWZg8uL5LBuYAZoNleGa3G28bJlXZFiluqThsFiVuyB83jxq5/z2kIvtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672474; c=relaxed/simple;
	bh=o9dUcKuCDkZLFH+Ize0uSknTGiExmyABhsMcYCOQ1LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddLq3Puj75XpIGPbpeiBr51gfGqzfHqFpPqLKgwBZYpUJy5dJ5CDE+fyFaklTDWmVFxcNyFgo+bXNcDEBRpCrGrzVjVnCP4YBkp4TJD4jgDPrhlATm3czkCVaxpkv6ACcc4yd5RNwodRDWfxW/7bCMRjw7EI91c1QAuZyxyrQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9QC4oE6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9QC4oE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXvv2GQTrxLVyV8hwACjfrya2w52VLmD0zOMjFGecj4=;
	b=I9QC4oE664E6L4DJ8w52NGny3y24vmNCbn31aIhuwu7ax73pWUzPD/WIZzCCOgiCG0bnZJ
	O03Rtkpj5cYdJ7G9zmRSDohnme436XIoei0wNQsjJK6Gqb9D+ffaK8O1thw+aRcqZb2EI+
	fcCD+kQRZt/vpmaY+3n35MXxskmWyj4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-VgWySqq0OeuwnxbaIT146A-1; Mon, 17 Jun 2024 21:01:10 -0400
X-MC-Unique: VgWySqq0OeuwnxbaIT146A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bffbc8ad81so5187301a91.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 18:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672469; x=1719277269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXvv2GQTrxLVyV8hwACjfrya2w52VLmD0zOMjFGecj4=;
        b=t/vyRuabdudEBmnWkSDVCMW5aoT8RtIAZLVXJsrTq3oYxhOjJyCYt+He3NFzvhpL1+
         PLB/HBcKPULRRbS1qpq4gBtlJOmF+ABFhFaVfqG3YiX5W0NKD514Y6SfS4wUWQPVpnfO
         cQxg0IvNMPBFSALaWp22XuH2UBFywt+Ninecc+otRY0Q1twQ4SFMwQ4EhUhNLcoRA/xl
         tgMs63PQ7UUgdTlODi0Jx32Y2NJC+VSQCypzJij11afldSp5TalhBdrrG+LpD+bco4F9
         qyANuStaGf1KvOqXZljbVsQ+fhOW1lqPGFLcrkOXoiWFaK1PWng4MaeBe+BzzfrKlmC/
         0yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW38Su7PhzgjHhkWIz4Er013r+Y9OWsee825FLS5ww/d4ZyH/T/o9hDgAos58pcRgG8yy3GmtyEj0mi6/XQ1EnkzdgRhsXLPAbskcc0G0M=
X-Gm-Message-State: AOJu0YwDPrEOGQnK3MlqqKMS2skGmE5RidQCCnZUpEA3Y1wqf1TrArvt
	nHQqAFtqSzS8kOJ7kBSyYuYtd8rGaO0pkXRlHXoVsjdn8pGFy2kDtzJUCmtEOCUCrqKHHxjrw1P
	agIzFYeYuQhpB2NKhUhlvBsIGPokpJch3Y6BAvOdbuh4QjeQ7/8VBGHMcVZhKSrE+pRuVkBWtiD
	gXtZJUKOy4eHbotyeiWYZ7bTTAuwuMVblMNcwYMm4=
X-Received: by 2002:a17:90a:b401:b0:2c4:a7af:4d79 with SMTP id 98e67ed59e1d1-2c4db2483f5mr10217145a91.11.1718672468408;
        Mon, 17 Jun 2024 18:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEOesevLHOR9KmJxw9wrE7RFv500NZL2XhwPTXQc8HuT59F/ZwbthYrkZcg2Fiy3f73wAPCU0c6b9+nYuQJqo=
X-Received: by 2002:a17:90a:b401:b0:2c4:a7af:4d79 with SMTP id
 98e67ed59e1d1-2c4db2483f5mr10217114a91.11.1718672467972; Mon, 17 Jun 2024
 18:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com> <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:00:56 +0800
Message-ID: <CACGkMEuWCYdvYkxPBodw4cuxDhkszJkA0h9rwDOKVLJFjaxyEw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
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

On Mon, Jun 17, 2024 at 3:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 14:28:05 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > But the xsk requires that the send queue use the premapped mode.
> > > > So the send queue must support premapped mode when it is bound to
> > > > af-xdp.
> > > >
> > > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mo=
de.
> > > >
> > > >     In this mode, the driver will record the dma info when skb or x=
dp
> > > >     frame is sent.
> > > >
> > > >     Currently, the SQ premapped mode is operational only with af-xd=
p. In
> > > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will s=
hare
> > > >     the same SQ. Af-xdp independently manages its DMA. The kernel s=
tack
> > > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > > >     info.
> > > >
> >
> > Note that there's indeed a mode when we have exclusive XDP TX queue:
> >
> >         /* XDP requires extra queues for XDP_TX */
> >         if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> >                 netdev_warn_once(dev, "XDP request %i queues but max
> > is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
> > mode.\n",
> >                                  curr_qp + xdp_qp, vi->max_queue_pairs)=
;
> >                 xdp_qp =3D 0;
> >         }
> >
> > So we need to mention how the code works in this patch.
>
> Sorry, I do not get it.
>
> Could you say more?

I meant in the commit log, you said:

"""
In this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
the same SQ.
"""

is not correct if we have sufficient queue pairs.

We need to tweak it and explain if the code can still work if we have
exclusive XDP TX queues.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


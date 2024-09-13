Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32314A4FB
	for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197771; cv=none; b=B/jIzi/JxWtiMLRIfi3HXiQgfq0fr4L6fbSJ8StDFJcnHKEZiO+Ffm2Gem8qfS3nIB/7QqHpocRX27IGhPgJPH9sEKgXQcY9lN2mwVh6W7TyarejUTNYvSzLJeCFDZm7gZHRABgM+UUBVPlFUoaWC3rSIbPXn9kgKRpB8a5o73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197771; c=relaxed/simple;
	bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P70GZ1GCcn3EkpLUnDbevco12O2B2Ep9mf2o9Mv4FYAYaU4Nrtsylxu4KTunlfqkoEHc2GxXTKBe9w2dXPJEsBc6Vn9Titxk8MBCFgaEXNLHuHb/8w6Iy+mnslzyTW05yHBddkLnNJiXE1/CZGOlRzWRMEYvGzMv+/3uU/bRf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiQbB/v/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiQbB/v/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726197768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
	b=HiQbB/v/L09/TmwsHVNxc45H4y4C5h1ysGxXMjO9Puk3lHXOUiBVLJHikKBU3YpvsxtNyM
	t8Woix/lTIY/AnTKYKYS1HtN/ebhhg0sq35IJf9KoGc1ehzxenERNkYYNiTkmQHguFN7Cq
	lzICbZNMwmXRmpBOttnuyOqGtoPSiKQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-XjV4CN23O2Sgc5R7BZaebQ-1; Thu, 12 Sep 2024 23:22:45 -0400
X-MC-Unique: XjV4CN23O2Sgc5R7BZaebQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8b4a23230so1720549a91.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 20:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197765; x=1726802565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxfGljSjSQRs8vlX0n8r3Q3hgopbQWHf5oD6iS7Yruo=;
        b=WUvMSikaIyyx8siITI3j4ihEurgjLzC+KzddeoLRHz1OxWkCQFkEvWKzRDLnGK84vb
         73QRuhwMrNcBKXTsxQRXFE18W5p58sA/2K90cxSRv4u7M6MLXU8XvBPKFARpNCbpYRTh
         MPZzx2lqEVGMA5n6gjiK2KFWkQc/odFQBFL15ePME8QjMEKJks7Dhxbakf40I+XlrKX+
         8+hAHVi3xdWyDM7gF328jQDz/JI6OBym+mjEcOVWqazFYA3BU+SFz9miqFwCThXF8x19
         Ws+L7zos7Nn0nhQjZ0WiUjVeLjfnck3bgOK1B3IRXxX2qA3LjbiUNPCb5Oi5BwljjBuI
         16hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWI5dZgNHemZAZjFmI9lIMSI8U2KTZKpSsbkwA3BCmB9+HCpeobZu3jyRSwX+miTV9mPPLC2tfwitbCkp4/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwICfUWP+kDEptkio/clJkzf/IuriIaGvbMtzHnzTbVOUE5HHNP
	0tZCOKE3zmbXSjG3h3ebssZzH1BQ7maaIDK1acnlzO6dxFPtAIsRmxNbkDJE0h/XpLIfjSfJi4M
	8uMPtduIFWsn2kkpo4MJmCr5tIyt/eOvWSz0KkWT4Yh6F0rheLzi98Yn5yBtY+ZkpyjRyoTmW3J
	AezHkmduWCuxeqbcqCBFIV+f3Dw9dr6L6OIIbtlZo=
X-Received: by 2002:a17:90a:10c2:b0:2da:7b8b:ea0d with SMTP id 98e67ed59e1d1-2db9ff798edmr4938512a91.8.1726197764799;
        Thu, 12 Sep 2024 20:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDSyIn5VZqHXbLGqF9GP9md3dx0oN9Dsc2ZtabVyYIqEsNVyWe39BP20d7CIwnjjaiSDAzCq0nv5s0j4jTZmc=
X-Received: by 2002:a17:90a:10c2:b0:2da:7b8b:ea0d with SMTP id
 98e67ed59e1d1-2db9ff798edmr4938487a91.8.1726197764304; Thu, 12 Sep 2024
 20:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-8-xuanzhuo@linux.alibaba.com> <CACGkMEuDg800zy+-W7VRY5Ns4COsmvMP_kpHdzJ-ws8PuMoGhA@mail.gmail.com>
 <1726127409.3427224-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726127409.3427224-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:22:31 +0800
Message-ID: <CACGkMEuK3WEDYgeS+WvW-pb9NU01AXt1rxPQT0QsPgW4qu7h6Q@mail.gmail.com>
Subject: Re: [PATCH net-next 07/13] virtio_net: refactor the xmit type
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

On Thu, Sep 12, 2024 at 3:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Sep 2024 12:04:16 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Because the af-xdp will introduce a new xmit type, so I refactor the
> > > xmit type mechanism first.
> > >
> > > We use the last two bits of the pointer to distinguish the xmit type,
> > > so we can distinguish four xmit types. Now we have three types: skb,
> > > orphan and xdp.
> >
> > And if I was not wrong, we do not anymore use bitmasks. If yes, let's
> > explain the reason here.
>
> In general, pointers are aligned to 4 or 8 bytes. If it is aligned to 4 b=
ytes,
> then only two bits are free for a pointer. So we can only use two bits.
>
> But there are 4 types here, so we can't use bits to distinguish them.
>
> b00 for skb
> b01 for SKB_ORPHAN
> b10 for XDP
> b11 for af-xdp tx

Let's add these in the changelog.

Thanks


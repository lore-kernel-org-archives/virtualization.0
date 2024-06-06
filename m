Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B217E46A
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667392; cv=none; b=FiNo8YsH1JXltxG99Iu5LUF5p3mBSQFCUAbHJYRKLHqaLmXXzhFNLawdEsM8bXu1d1MRQrE4XuC6Cw3VJsGP+4GOaSeFToLKXWPg75lDsywXgad2qTx4BS43kAfkwIxJ6k/m1aiK7xUr4HIEVZxyErU92dIUjpCgN+pHKWhjAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667392; c=relaxed/simple;
	bh=+s+yhOwg79j75o8WoByyWhf+YyJpWwFPenJ7DA7VLW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WojH4s7Rcc7zRmIytGB1ZqtmGln7g7ks4Ef8qZGGDUu4vdLKub79Pdm/OZfskxM0LLa54Pw4ksXyTRKbc6QJ09Ohnh7aCH9G0gpGiyJ4a8DLKPZ9uuAJsUFT0N+jI1GEBjJ1AdxF480VvUrIcBPq/bXGaOOgyoFRg7/IEibjQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Xc6vXN1; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Xc6vXN1"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62689607AD
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 09:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.601
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inG5MBA-JKmo for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 09:49:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=glider@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6EE09605EA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EE09605EA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=4Xc6vXN1
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EE09605EA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 09:49:50 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6ae2e6dba36so4063836d6.3
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Jun 2024 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717667389; x=1718272189; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5dL381WobNig2njEknAbaM2t6txWWIRtjrYV1jJVaM=;
        b=4Xc6vXN1wYgc2+adWe/cuKBkYUQ6FOVTJPI6YjK9MIIdg/hLSO+nyd3oI1SMTefZV6
         koK3BUQxeLo6J59bz96e6UN/g8Y5ci0z9vHsSgihgfG/UJ57VgY//oBu7PGsETgaFEL9
         aZy15JYXn5VkuTSAMGKL4DcOKEjoNb2t2KPzxEJ0pQzkVTKYZyNqPlhTq3ErBrf1Eaag
         G5TQ2lQg9eWdGEIAoxVn9paBwYcXrFfBG9U1cc+WaD0ygdFkUKzISy9S/pNsJeeJW6NA
         JIOi04mLCx4oERYmCNvCZhMAD4VJFrJvmXHzyPydgdWw49uWmCenoNTvmfjZv3WxOhWz
         eezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667389; x=1718272189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5dL381WobNig2njEknAbaM2t6txWWIRtjrYV1jJVaM=;
        b=jqz0Od19gdlusEnGFa+pH6lVHJibLafRNl7y3aswdOjEO8u3CwCVP0InTehuw4UpTJ
         xXfEGgoPj2WKI3KvYgBy/LsCfc9HOpMPECMVXi+qwbWzha3iDyKIHCM2bcKXS8MTzMwz
         exYzG979GCQm1eztD8CDErxfOzgUY0ps2Mm7JqjUhJUmDNq60rubYzGLVKa/KigZL0jg
         zMnEgSJprs/C3SV4wDA5jQT0jvc4Q7Cwy0sIxjXI56lbSv8hi/9QToKGftOi9Xpfs2Pc
         6Kkgq4VHlFzyGav5A1RV4ArfyzKLvAneNeVDwXHna6iJktCfgXLFSW/FKZql7J/yWyCR
         2tfw==
X-Forwarded-Encrypted: i=1; AJvYcCXAG4crPauwv7XdZzB039O41iyeH7V/ahmD/4rXMVto2YYuY4oAEFwVS7erZYmCOYZvi0PvDFG1WTiP7Q7h339JXPnCLVJWbEAisM69osJGCUfjW7kqWCf+bw==
X-Gm-Message-State: AOJu0YznL6TsPSYWjJJW3A0g1ryM8MOe4WH0b3RT0hNNzmLfyLvW/vob
	OrlPX5vO0D47ZaUKXSra+VpdOHJcwvPk4EKWhVKgyriJXXcqH60fMd2MEVLYcUPwbPrkJ/gmV+m
	gdVYtGjn82iULEDisvlHu+LDwGoivgAbiqPMC
X-Google-Smtp-Source: AGHT+IGSavWspcAP+9gFMHHK5+xZQBSdefZIDFgx0Jb2MuNzkoSE1fUwptT3XiTbAuOpSImCAU9XqTknjXm91l63MJU=
X-Received: by 2002:a05:6214:5f01:b0:6ae:cec8:be38 with SMTP id
 6a1803df08f44-6b020321366mr63489686d6.5.1717667388916; Thu, 06 Jun 2024
 02:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com> <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
 <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 6 Jun 2024 11:49:07 +0200
Message-ID: <CAG_fn=WwijXza_xufVNpBMo79Nh6uysV4MyWt_T264Pji3gA7g@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 6 Jun 2024 10:20:21 +0200, Alexander Potapenko <glider@google.com=
> wrote:
> > > Could you try this?
> >
> > Hi Xuan,
> >
> > What kernel revision does this patch apply to? I tried it against
> > v6.10-rc2, and only the first hunk applied.
> > However this seems to fix the problem, at least the kernel boots withou=
t
> > warnings now.
>
>
> Sorry, I have some changes locally.
>
> If the hunk #1 is applied, then it is ok.
>
> Do you think we need more test? Or I post an new patch directly.

I think we're good to go (just double-checked that). Assuming you're
sending the following patch:

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2a972752ff1bc..9d3a9942c8c82 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3121,8 +3121,10 @@ dma_addr_t
virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(virt_to_page(ptr),
offset_in_page(ptr), size, dir);
                return (dma_addr_t)virt_to_phys(ptr);
+       }

        return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attr=
s);
 }

, feel free to add:

Tested-by: Alexander Potapenko <glider@google.com>

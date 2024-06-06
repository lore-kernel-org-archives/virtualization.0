Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1460199A2
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662411; cv=none; b=ha+Cjomqb/6XA1bBgtUZ5E0PUNeS6vuObDJ6Dg6z8ft9SsDgqJYBhJ5cAu1HyOibdGIlHJ+JcI5ZebGU+LRIpfoUJJzGqC7II6kw/qg+3x/EybqK9B/JeM8aOPIHgF1RZdUXdam20EoDT6sv546MlE9MzEWNQokZ9VUAfakO1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662411; c=relaxed/simple;
	bh=n0pZueRUmpdvtloIPpgcxNu/B7/nDsSTEeurRzHnHsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHNjFKhXKUodOLKdnuzD76SPd/tt4UfU1n8k5U5zCP9O3HtqazuZ8SEqReSsoQVpRlxGbHbrifqCijyJNKvHzLv3VnNO74fR4dpbu5emVYOi6yQ2ajOllDj9mmfiinYi7uPYDmhIVAKRubQZoTyA9i6VMfPKEwBe6O3AKBBEBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4mmEU54; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4mmEU54"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 624104031A
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.601
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ki_gtkpwvW5d for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 08:26:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=glider@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6D0CC400BA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D0CC400BA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=I4mmEU54
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D0CC400BA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 08:26:49 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so3837916d6.1
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Jun 2024 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662408; x=1718267208; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAoWLPLPpZp/YDC/UyXezS+9/hRBrQtfl1bKW+wACuw=;
        b=I4mmEU54YkY3sfgPfxigwjhNd83YgHA3SG4fRQIiDv5/mmIl41xZOBtvLA/M9k6H94
         Mjm9j2KgsJEgfeaYU47CUx89x4uXQ9+pSLcVOJVW2cprOe4hQkQdkjCguCgahvLd+5nE
         XiqkqVloBKBsZlOmTbs7wz052fT+6XCsDWxlYEppWDCAIScy/GIuRVyNAXPWD+RR98Q0
         odeuC55RYfmKU7AqhSi8nFQofOYvsoP1JBBKvruZow8Xkd5j6z6DZhaxjfTzSbsQimg0
         7siIb/pp2uRZ6PEx3WH8JoLccLmAgygKx+N71hpK91hNgQRUWbQwf3ihUQGMWOlCA/Uz
         3VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662408; x=1718267208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAoWLPLPpZp/YDC/UyXezS+9/hRBrQtfl1bKW+wACuw=;
        b=PQMGrbq/KB3Nk22xDDFHKQV5Cqla18C/4uaFAYqitfULz+aJERuJrUgISQ6jw4rOBM
         q+TAL1ay8D+ORN3tu6cz9fA0CzUnNvZS/iIMWaMFAZPPJWUkGSL+6ugdAUN0nVh62xf6
         6lf5AQlC/aDf7bKspGEXCWaz0efKoWjxknMx+h9vLsZvxX0uoGrl1VcNg+kgyEc1IzDy
         sEBDMkMllxbhP1zjYwQf/Am2n6YbEP6WLdR6DFDSaBgGa4oQXda0IX+PhDy3W7ZBI3A+
         CKruJlDejdds9mxcnxdvQS6yWyvs45uQ8w4aV5qAaVCGspfGGN3tpSMLVez7lgDH0qh9
         gTSA==
X-Forwarded-Encrypted: i=1; AJvYcCXBBtqnza23F1hWB0yXualYn4rpgP7PQAQiHr6upoNAtIKCpqkXjfWeRIdzfoNtEV2BGYdNaOPj8PO2kXto3v/gYhs+ADi5NuoxwzB0fknw+tUjo8zssORe6A==
X-Gm-Message-State: AOJu0Yz840bZqDomckIKfYq3EfaLxH/730phxhRptqC7vF1j4cls1FmJ
	67CT4pv2wt/PuTEIc0eJ8LCMgohN5TkMx+iAClwhFrB59mnyH2ikH/Hj/Krlp346uiih4ky+gIX
	fj6XqjRShAVvLGLXerlrd/wrdHTl5tYJ59jPm
X-Google-Smtp-Source: AGHT+IHSPl2srWABU7TtuEx6MInqkT/TqH/zLF1tN13BVl/h67uv526s9BJchBKedf9gNhwL02Rx2Ai332/cTTjwml8=
X-Received: by 2002:a05:6214:3911:b0:6af:c66a:d5a8 with SMTP id
 6a1803df08f44-6b030aa0653mr52388716d6.51.1717662403007; Thu, 06 Jun 2024
 01:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 6 Jun 2024 10:26:06 +0200
Message-ID: <CAG_fn=Uvfeg7LGQGjTy4qDSoYis39OeyA3W7=FgOAU+isk5Acg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

>
> Could you try this?

(resending without HTML, sorry for inconvenience).
Hi Xuan,

What kernel revision does this patch apply to? I tried it against
v6.10-rc2, and only the first hunk applied.
However this seems to fix the problem, at least the kernel boots
without warnings now.

> Thanks.
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 37c9c5b55864..cb280b66c7a2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_dma_api) {
> +               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
>                 return (dma_addr_t)virt_to_phys(ptr);
> +       }
>
>         return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
>  }
> @@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_dma_api) {
> +               kmsan_handle_dma(page, offset, size, dir);
>                 return page_to_phys(page) + offset;
> +       }
>
>         return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
>  }

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777E1103
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2f6gbCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701928341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
	b=U2f6gbCen4DeIH9SJfftv3dd/9Xf6LqYMLgdx7IBkY3F+b18bTFeYIlvLjixuqBoHACLDo
	p2y4sR3T+c6EU0XTGd8R57KzQBdXgPrLSJEGR2zRILQiCQO+aD/Q3cHOls4FeADYQybgsA
	+8LfitEIEQ3Etd4E6TB5/TEA20MGzKU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Fujztz-zNm-cqe8q_Y54Fw-1; Thu, 07 Dec 2023 00:52:20 -0500
X-MC-Unique: Fujztz-zNm-cqe8q_Y54Fw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-286a4fc4e9eso716419a91.2
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 21:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928339; x=1702533139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
        b=Q741b+fi7l64vx4oXgxilI+FH3P4yyXgv8A4+j/AxSX5jEaZUpmIpKM2LkwPIXc1gc
         jVwARV7hRoS9JRvFD33jbXM6MkN+gVFvwZpMY0OZdMyExWwvYIhKJ7VB7B+7fr0SC7fW
         dEHPUVZ68VsLJ5hCug5xuHEgh3xQTs3wD76Mm7izLl2Z8/YNmL7rBgruJP8rTKRsjWtX
         ONM6ClFuM8r0co6u9R2EI09+5eKpLae6kFT/dz6P9dV2oWYsJe3LEmMvMoxowW4tAOX7
         5gAZmYSLYMT+zZJJvE7eMSlbqfxVj/cIg8hY2YQTnPeaZoEGfZtgCJPRaCxwpvItsy4C
         NFjw==
X-Gm-Message-State: AOJu0YxafXdUmpAsEtBecJ+3dgzjFTQyHY1HOvmRRAYqfuz4XNeG6h/Z
	GPhl2x2LLS10N9O7u2Pd5Q0rs+Wu2uRVi6RyUaHJ1sHQTjugmVo6zA/bPkdiT4SThd6yHlJkCTp
	yXFhvY9NYMskNrORJtMIFUS6jJytRYKlqGrkd/zdtR3E=
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id cv9-20020a17090afd0900b002866cc0cad3mr1949098pjb.74.1701928339230;
        Wed, 06 Dec 2023 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmSjJEJticrA6iI+yH1lm5XAyMtFr/azBvGsGe1XMJiQigUQ9nLH+oU43aD6xf+IguxCTdguGcxA4sxW4hVuw=
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id
 cv9-20020a17090afd0900b002866cc0cad3mr1949085pjb.74.1701928338997; Wed, 06
 Dec 2023 21:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-5-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-5-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:52:08 +0800
Message-ID: <CACGkMEvwG6EvZ3me9ReqA-YSR1Y_6fb_kotT=+PFARaLS1FTmg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] vhost/net: remove vhost_net_page_frag_refill()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> The page frag in vhost_net_page_frag_refill() uses the
> 'struct page_frag' from skb_page_frag_refill(), but it's
> implementation is similar to page_frag_alloc_align() now.
>
> This patch removes vhost_net_page_frag_refill() by using
> 'struct page_frag_cache' instead of 'struct page_frag',
> and allocating frag using page_frag_alloc_align().
>
> The added benefit is that not only unifying the page frag
> implementation a little, but also having about 0.5% performance
> boost testing by using the vhost_net_test introduced in the
> last patch.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


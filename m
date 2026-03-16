Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A234D905
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646540; cv=none; b=KLq+jyeVCZ8qXAFUQUhKwGJhHCaj94LrVA8gt+ZSgYwu2Yg57hKm0UQJTpOAPKR03yBEt7VOMz1NFlQWyg0htuPnvBg97Aiauc1iUcLc2qRWikUnMuHfOwhLzyLp7wLsATdytwNHVWF990YDVYCME31fu8JAlXgPitFSYpbT4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646540; c=relaxed/simple;
	bh=lAhWFR3bWeLZMNXrZqumDODsT4ckBImkBWjf2qGHHVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHbFGZArwnzttjU9NW5Xk6oLRPnyxh7VZ7niLOXLULpd8doF1q7Q3wzuMcroO9HMN5xN4Z/EOIlIj/RdoTkfS8vhKNxXubBEh6XYDM8juib9F6RpxSn0cHW3dr/n7wI5Pg93WyKAUay4R/QLtn2lAbBbFxgqE+tSVL+EcFsJ0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik15KYkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik15KYkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773646537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
	b=Ik15KYkcyiwHPBcKdKehU1SyBIIht/QTOFoIuhi0d3MfavXCoVkMeVqnGL5EoFAFwUoJoS
	jBooppr3HG15W808crBsJ3ysDMuWkAIJJDDm1dUIgyZmqpJ7GiXM+SmQPQfTgWiK11tyJ/
	qFrLp5YMAG3yplJS0j+QYw+VYkHBsYA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-dDY73b59PXSTcRqe4mcuIQ-1; Mon, 16 Mar 2026 03:35:36 -0400
X-MC-Unique: dDY73b59PXSTcRqe4mcuIQ-1
X-Mimecast-MFC-AGG-ID: dDY73b59PXSTcRqe4mcuIQ_1773646535
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b05370ec01so82686875ad.1
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 00:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646535; x=1774251335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ardp/fbfEqn64qjd6obkacuKJHkoPymrZiOmJjjTPnQ=;
        b=njyxYTwZclUlX+EmY/P8338B4olDS4TTejNgIWUDM0DAJs0MsJat25iU/Td+XRdNhF
         ni0qVFDCqRBPLh7wJGLNUDPy/QIsnfM8UfaaNywnTkwDdwq4oVrVMbWx0bGgujwdvDT1
         xYTtAs4NvGKkj7GLFbhycR4xQdEX1BHi56RFWX9utRSQ7OTfsId3GB2STwBOuDtPz5ul
         t+0UjQ05mMQuMnAOqYonkN6o2ablPFLA/UeUSQFS6GPH4s8xBABDeYlEg+BiiJFXqSPc
         iT8xpTNPezGn1FB4XWgmkvzDd4EpJ95dOSYU00cuBBTS4Q37GxnVI/fNjM12lNO0C0PA
         bgCA==
X-Forwarded-Encrypted: i=1; AJvYcCUy81nLo6AmuQmMKiznX5euOsCPxtGHE2uaFUyTCbePjmfRfHXiU2YdV68kYB6mQ3GljQ6stcyjKQKeNFSoQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyX7Tm6u3wMMT5wsHw7swWB/iFLQqjcLBIkHlcPum6Pc3ooRT7
	HUGw6hr5jpe+4xbsceXPu2tkVM2D2kceMUzCIRehDk8vZb/eUFH52sYk2B1VNESJSzBSczBJt9f
	Z8FthgiZsZI87386QZxZewRXnF4IyS0NTm/ar/G/jF1LUZ6RWxObcsP2LUyjspGk8HlGlbU5G8l
	1Vs6C/KK2aZpsVSLzlgHbJS6+TrB2UPJ7xHemClfRMysM=
X-Gm-Gg: ATEYQzwL7eAaAgBhK3M0bB7Z9DTI/kogrOI9D39KKBJ0W4OgZ3Zdng4lQ5O3deFjSdV
	rgNdV98a2yK49KHF8nuYNTVwHk0ikwQnZpyM79SfmGbpBgiL9mSFuPTuvO065veyv/dBbpe0I/U
	1HQZa7kkuOjgfFhQrpyaHKmV33z3A9zdErdsOPSGQ4oquZ4oLXqb3eshRbeGkBVpK9X7c2mozZZ
	Q8=
X-Received: by 2002:a17:902:f650:b0:2b0:58a8:5fc4 with SMTP id d9443c01a7336-2b058a862b6mr23039345ad.50.1773646535320;
        Mon, 16 Mar 2026 00:35:35 -0700 (PDT)
X-Received: by 2002:a17:902:f650:b0:2b0:58a8:5fc4 with SMTP id
 d9443c01a7336-2b058a862b6mr23038825ad.50.1773646534592; Mon, 16 Mar 2026
 00:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310183107.2822016-1-vishs@meta.com> <CACGkMEt8WWbHRpD-e4aHBdwbK9QdvCcCX39xzK6FRrb263G+5w@mail.gmail.com>
 <130cf9d5-79fd-4d12-ae3e-3cafebde02ce@meta.com>
In-Reply-To: <130cf9d5-79fd-4d12-ae3e-3cafebde02ce@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Mar 2026 15:35:23 +0800
X-Gm-Features: AaiRm519WlL2o5GfvD8ccaY4YvNIamxuTuuvNhNKG3MAIpamtLVCsJ2D-ZyJFmI
Message-ID: <CACGkMEtBhTtzjxaUnN_3+gHUUq0v9C0f38OJ52HAz9WhoAnWrg@mail.gmail.com>
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BTXXiuaLJke8enQ291l1YGJSbhjsC2DbTTFVP9bc7lM_1773646535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 12:51=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.c=
om> wrote:
>
>
>
> On 3/13/26 1:21 PM, Jason Wang wrote:
> >> -static void put_xdp_frags(struct xdp_buff *xdp)
> >> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *=
xdp)
> >>   {
> >>          struct skb_shared_info *shinfo;
> >>          struct page *xdp_page;
> >> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >>                  shinfo =3D xdp_get_shared_info_from_buff(xdp);
> >>                  for (i =3D 0; i < shinfo->nr_frags; i++) {
> >>                          xdp_page =3D skb_frag_page(&shinfo->frags[i])=
;
> >> -                       put_page(xdp_page);
> >> +                       page_pool_put_page(rq->page_pool, xdp_page, -1=
, true);
> >>                  }
> >>          }
> >>   }
> >> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct ne=
t_device *dev,
> >>          if (page_off + *len + tailroom > PAGE_SIZE)
> >>                  return NULL;
> >>
> >> -       page =3D alloc_page(GFP_ATOMIC);
> >> +       page =3D page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
> >>          if (!page)
> >>                  return NULL;
> >>
> >> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct n=
et_device *dev,
> >>                  p =3D virt_to_head_page(buf);
> >>                  off =3D buf - page_address(p);
> >>
> >> +               if (rq->use_page_pool_dma)
> >> +                       page_pool_dma_sync_for_cpu(rq->page_pool, p,
> >> +                                                  off, buflen);
> >
> > Intresting, I think we need a patch for -stable to sync for cpu as
> > well (and probably the XDP_TX path).
>
> In the old code, I believed the sync was handled implicitly inside
> virtnet_rq_get_buf() -> virtnet_rq_unmap() before data was accessed.
> Could you point me at the specific path you're concerned about for
> -stable? I want to make sure I understand the issue correctly before
> sending a fix.

You're right; the code seems fine.

(Note that, when big_packets is true but small is used, we will go
virtqueue_get_buf(), so the unamp is done via deatch_buf().

>
> >
> >
> >> +
> >>                  if (check_mergeable_len(dev, ctx, buflen)) {
> >> -                       put_page(p);
> >> +                       page_pool_put_page(rq->page_pool, p, -1, true)=
;
> >>                          goto err_buf;
> >>                  }
>
> Sorry for missing that comment in the earlier email

No worries.

Thanks

>


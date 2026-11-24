Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522665;
	b=JFtW+h0ZIhOg4HpFgUdCYNhhPiYo8QAcn0JmbOgx/DS+BsRQ300pF/6CDww39kjjXyEV
	 Ulg3irP0/i/eedXoVOhzaC6SuuGVuAawllzeBDrW/pr4EhA5wteTJBLb9G+4je91h8uPi
	 Ebb5luBgcLzdKVM3dHne6JG/DHBy61dUP8jlDR4a45BTRnIJMe1FD2ROA3SFCJsQ2ds7C
	 2WwGxXY6UUn962WcQNe9AyJUBnGihERxkotltmONR/dm9/OK6MkkZbVQ24HumwR4y7jcL
	 MynHOXAkZtRndA0AI39sjtG0u7BNZrQemesExhAGp34i5cRS8ptEQYfNNIYh16jv/cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522665;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=DbmIw63aK5D8KN1MjDBOUuihKJOCEJYVlY9ddII3aL8=;
	b=CPoI5bWO/Twrc4FxgXTK9thDLQ4HKqrY26Pdp2RXz4n260P7s8t5Rb4DQPh3mZeLii90
	 EDfpT0gniprLpNEiTUNV9Ty5edmJptXPSeJrEiau6tEExiXEPppLzC0+4Rmg7qQ2a/GHs
	 OTcCCrZktjMGjzEqGhOVAOcme5Qvd2kkqp9Kn8vwsJ2jVe0/23WodKqT+Lciikb12CXff
	 Yn9d4rBgLFRczebLZ/muIhwOSGQoKKjQ5CAOXVFuxhL6IRiOGmvKRZITvfGotc4WTDs14
	 Yb93zDxhSaqNMZQfY9YSgU9v2hE1O2UUbXAKP7O0fuMD3zJMkwQ/VQWB2tt6y9LIfIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aijY3mNF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B687606A32D
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B687606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aijY3mNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbmIw63aK5D8KN1MjDBOUuihKJOCEJYVlY9ddII3aL8=;
	b=aijY3mNFYk26Nodyhy5eSg5CG9IQDsGh/LGD/e7DjzB0LhXjHMtT8+4mjVuwKPxu62TT5Y
	RrzSwf5LEodAhliqiUUqVycHRxWEDF3fXWB0mTvFYtd9iZpN3pSacC2YKCyXpcmQrMrJ0/
	bCytnoVPjda1rVXPpFik237OtZ0cRLk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-yhxAmXoQMzOglXQLVYQ8Ew-1; Tue, 24 Nov 2026 12:17:41 +0000
X-MC-Unique: yhxAmXoQMzOglXQLVYQ8Ew-1
X-Mimecast-MFC-AGG-ID: yhxAmXoQMzOglXQLVYQ8Ew_1795522661
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b502255651so60766827b3.1
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 04:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522661; x=1796127461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbmIw63aK5D8KN1MjDBOUuihKJOCEJYVlY9ddII3aL8=;
        b=T/EUId6aS6UXwyiqet5bFAI+Ke17B2RzgxD0+e+bt0nLdkTHzETvC92c8k1I7u0oLt
         /b8S3vWR8uwIi1kateNNtDmifwcHBAfpLKmKWHRgPnb9af5H1DpJVsDkKtfcZwkJQGRJ
         mbRGK0hHpbV0mFtVumx+j7VtC3EyM3V6sLiey8RIpOyal9HTZUFa488nEjbcwufkJNUO
         Q0kujJ7GLIkdGwyUj+NS2POap/02yqHAb7HDMHaqN67K/qcMQdZjQdxPLxAjD/qWH4NI
         EprcpsciFdxcY4pccK2Db1xhLLU88hhmn04kbcQP5PFuF6cGSoJ5mJE8QOHEkL6RNGAN
         kL/A==
X-Forwarded-Encrypted: i=1; AL+hErEZMgreEq3GZfmRyfC7gcwogHUTOj+JVxIHc8siazCWtz7/EwIYCgybDN0hyHPTbqmlY9uRzIrlaXuzGRNRVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Kcvtg5Qml+F9Xp6vuXZ37WxV/CpbuPJOepPnk8I65+nhBo5O6
	NM2tSDaGoQlK3VjI7TnCW16G9qqgoElKPqACJOO8F64tisB6XXuReMhUt6YXFl8xqIB+5wNpImp
	EDmYwoiTmwhQ3RfDRCZIy8v/0CB+hYEyw/9/gbEo7BjSFyWqMDcALNMiIqh7cYAPGJMvKxWTmpQ
	ZjMpKB6DYn27AxrntnMvSh5/YFwlo37wA4M275DAUOhjw=
X-Gm-Gg: AZFdTZfm7TmkUbzNGC3/SX/uDkgLoA9O2H4hVXBIDQl9CekG+aqDLR3fE/f/W1X8v4w
	6AvAkhW1OliHkrPFfEMM1LzdzPlJYe5b3ZDdW7tai1ZRHXOR5rcR3igICefCp0ZOTLYpo3cQz8a
	2Vm+d1XLZQMN8aNKFxfiLrLmeDfB269QhRW6W2mwscyaTVs2f8kOLdLDJUvqypTXQmFsRKMUOXW
	2/nipkqmODWZyH0hspYmPBZeWN3Rm+VclbAT2aB9rAmgioBncRdedPYsfs=
X-Received: by 2002:a05:690e:12c1:b0:67d:c0d2:d1a4 with SMTP id 956f58d0204a3-67df43f2946mr5746538d50.24.1795522661120;
        Tue, 24 Nov 2026 04:17:41 -0800 (PST)
X-Received: by 2002:a05:690e:12c1:b0:67d:c0d2:d1a4 with SMTP id
 956f58d0204a3-67df43f2946mr5746518d50.24.1795522660569; Tue, 24 Nov 2026
 04:17:40 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123192220.4013325-1-nilayvaish@google.com>
In-Reply-To: <20261123192220.4013325-1-nilayvaish@google.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Nov 2026 13:17:02 +0100
X-Gm-Features: Aa3M54oMFIvhNd4yA8WUxlIHyLTQrWthI4lAaUAMGkK0ZLwLtvJCUTh2MEvQmbU
Message-ID: <CAJaqyWfVmp8KuqX_8v_QnXFysmwjNieWbosqD+R=Oqo4Pmg+5w@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: use page_private() accessors for the
 big-packets page chain
To: Nilay Vaish <nilayvaish@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WifKSjAYC27q9oUCKEMB3wOPzdu-e64ZrppWdc85IuI_1795522661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 8:22=E2=80=AFPM Nilay Vaish <nilayvaish@google.com>=
 wrote:
>
> Big packets mode chains its receive pages through page->private, reading
> and writing the field directly.
>
> struct page is being shrunk as part of the memdesc work, and its private
> field is one of those that will move. Direct users have to go through
> the accessors before that can happen.
>
> Use page_private() and set_page_private() instead, like the rest of the
> kernel, so that the driver no longer depends on where struct page keeps
> the field.
>
> No functional change.
>
> This patch was written with the help of an AI coding assistant (Gemini).
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Nilay Vaish <nilayvaish@google.com>
> ---
>  drivers/net/virtio_net.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0988a946ef35..5eef2c315963 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -680,8 +680,10 @@ static void give_pages(struct receive_queue *rq, str=
uct page *page)
>         struct page *end;
>
>         /* Find end of list, sew whole thing into vi->rq.pages. */
> -       for (end =3D page; end->private; end =3D (struct page *)end->priv=
ate);
> -       end->private =3D (unsigned long)rq->pages;
> +       for (end =3D page; page_private(end);
> +            end =3D (struct page *)page_private(end))
> +               ;
> +       set_page_private(end, (unsigned long)rq->pages);
>         rq->pages =3D page;
>  }
>
> @@ -690,9 +692,9 @@ static struct page *get_a_page(struct receive_queue *=
rq, gfp_t gfp_mask)
>         struct page *p =3D rq->pages;
>
>         if (p) {
> -               rq->pages =3D (struct page *)p->private;
> +               rq->pages =3D (struct page *)page_private(p);
>                 /* clear private here, it is used to chain pages */
> -               p->private =3D 0;
> +               set_page_private(p, 0);
>         } else
>                 p =3D alloc_page(gfp_mask);
>         return p;
> @@ -881,7 +883,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                  * Currently, big packets mode doesn't use page pools.
>                  */
>                 if (!rq->page_pool) {
> -                       page =3D (struct page *)page->private;
> +                       page =3D (struct page *)page_private(page);
>                         if (page)
>                                 give_pages(rq, page);
>                 }
> @@ -929,7 +931,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
>                                 frag_size, truesize);
>                 len -=3D frag_size;
> -               page =3D (struct page *)page->private;
> +               page =3D (struct page *)page_private(page);
>                 offset =3D 0;
>         }
>
> @@ -2705,7 +2707,7 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
>                 sg_set_buf(&rq->sg[i], page_address(first), PAGE_SIZE);
>
>                 /* chain new page in list head to match sg */
> -               first->private =3D (unsigned long)list;
> +               set_page_private(first, (unsigned long)list);
>                 list =3D first;
>         }
>
> @@ -2725,7 +2727,7 @@ static int add_recvbuf_big(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         sg_set_buf(&rq->sg[1], p + offset, PAGE_SIZE - offset);
>
>         /* chain first in list head */
> -       first->private =3D (unsigned long)list;
> +       set_page_private(first, (unsigned long)list);
>         err =3D virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_s=
kbfrags + 2,
>                                   first, gfp);
>         if (err < 0)
> --
> 2.56.1.839.g22a8290db9-goog
>


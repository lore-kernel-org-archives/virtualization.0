Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98437199D8
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185094; cv=none; b=nVI3grjZ+TpGlNLc3HykiUm2FNaCVyoS5XOT6mTOvy02l+zIdbXFKbHAdMaPTQ6c8daAhAd6grU0fCkSLjuoOjf8t+oFB0VKsbIH0a//qkZS4jqUy7/WqqmspOglFB07+PMSK4ZSzkWCCvFVIyTopOdCYx//rdw4jMwRLu8jN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185094; c=relaxed/simple;
	bh=OrsYaHbebd/SSPKeyKf/VJ6Qd2v9505H2ZrSwNlE5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX+/68CrNdmm+3RQDAfiJOWOrMoWYa2pUjE7/Zm4lhZylMjSR/itn1Kz/x8HNypBPU8ORGQTNpusNE2PRfiCzPQKCLB+ZSGpj0WrpqWePghYKNe3OyQLsSfwLTsL2AQg90VP78fIzGdcA4AYVj8XE97WRns8sbWymkfhG24T9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0aAPftT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0aAPftT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775185092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEDAPwDEEynt6WVmKPpdzSXOKEt2L8PEvBbzu0ltSi8=;
	b=N0aAPftTdGf+OM9Mejrlzhy2YH7k9flgzYe7em8CRlYdgEawzWX6Cf0XqProfVX/lcO3UF
	p09Hw0xXFWatV1wBUT/fMM873m4g61ynDhPwrgRYr5z2ZQ0OE2di6vq6Ccpe8CyOOK3bs6
	wS7D7o7zLshcKFReKCRnkTzVFsfXoCQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-eveSa9WXOv-0yl4RpMczig-1; Thu, 02 Apr 2026 22:58:11 -0400
X-MC-Unique: eveSa9WXOv-0yl4RpMczig-1
X-Mimecast-MFC-AGG-ID: eveSa9WXOv-0yl4RpMczig_1775185090
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35c1107da15so1455235a91.2
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 19:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775185090; x=1775789890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEDAPwDEEynt6WVmKPpdzSXOKEt2L8PEvBbzu0ltSi8=;
        b=lwpudw/nURxiR0DhY+0p3G53DGabRIF6bfsPrK95kb9UjV6EtAaScwCTN+UFqq3MEk
         RwhYTk8ko686wXHdEMojiwW9wsmsQsY1HVk+SzELpQ0WNQO3+1RXvk1xIge3KMujh3OW
         HGlfRro1QPQxwXSamnMQDm6TIUVlarvwWfyRIy+LO62SZZ7utFYF7PZ39nFSEfMbutjq
         CIdL26FTzzA4p4ATNjR0V76Owp1XSGuS/IfwgunU2gCazOrI6WeTm+r+w1XA+Ehl7tHV
         mz6NE5XP/VGHI2xx7PD4PMb3/hSQDFQpn6Wo6b6PzssrOS9LJeH3o6I43HRUx21ZOK92
         QJlw==
X-Forwarded-Encrypted: i=1; AJvYcCWdhthiwZAiPrOd7HBvU/G3FaoYsKg1SqbcV6aXha9pKfNHos8bOK0eqmf+q02bYV3oMlZ1Nkmi0jm4s7VDdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGVmzXT7BpsblS+VxMHS8ndlS1sTaF8PLTx+LiXnlQ3xgopGSe
	ka39IWEPtwWJSvlb4FAO1vFzNerpy7VT7Y3Iu4clS7CbcpzdfH24ATmk39SqpiEsWzuETzV42Mt
	Bl9l/GoXwURvxlZ8J8zXClNA44OhOff9fw7arBRXSouIGB+I7uGlY2583CtQj694HaPZEZ+3Pg5
	2z6QK3KZXoD307pB/i5vyI/QaihByzEbRJC9I1PJih3gk=
X-Gm-Gg: ATEYQzyPLmNdJGqqaEroZx4OIe2IHF/vkpHdCF62o36nJx6G4GK9Wj6yz3WT0Z1M9XN
	ItZkU4tHwiF5IJvJOe81pEghdNoEhExVuHn8nFaBFGTO/yNOrtil51QUujWbecCY+GjQJAfpviV
	q+j+3Y3gtYNlPx1U4ejCxYQ0KgH2H2x54aJZQYuDoQG6b4NUWM78cgtGS7kc3ohcpKS3yq7yxiZ
	ZIbkaw=
X-Received: by 2002:a05:6a20:7f98:b0:387:a311:3825 with SMTP id adf61e73a8af0-39f2f3079f3mr1212045637.61.1775185090338;
        Thu, 02 Apr 2026 19:58:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f98:b0:387:a311:3825 with SMTP id
 adf61e73a8af0-39f2f3079f3mr1212024637.61.1775185089824; Thu, 02 Apr 2026
 19:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260331102626.108962-1-lange_tang@163.com> <20260331102626.108962-2-lange_tang@163.com>
In-Reply-To: <20260331102626.108962-2-lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Apr 2026 10:57:58 +0800
X-Gm-Features: AQROBzCuJCoKuJshy4hPFnkz6yoFCG-wgRnUwaDqexm9jhVzFw_1yyQu6eCi6U8
Message-ID: <CACGkMEtakF0EUYT11N=aNjphY_Ra4YsRaJZmJ4UD0VL5aPxX9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: disable cb when in busy-polling
To: Longjun Tang <lange_tang@163.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, edumazet@google.com, 
	tanglongjun@kylinos.cn, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2M6CEfO2fxCcKjAXXEwFDonPi5gVD_mbyOgNLiEe32E_1775185090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:27=E2=80=AFPM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> virtnet_poll() is shared between NAPI softirq context and the busy-poll
> path (sk_busy_loop).  In the busy-poll path the caller drives the loop
> directly and does not rely on interrupts to schedule NAPI; keeping
> callbacks enabled is wasteful and risks a flood of IRQ_NONE returns that
> can trigger the kernel's spurious-IRQ detector.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..df365fba2c40 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3078,6 +3078,9 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>         unsigned int xdp_xmit =3D 0;
>         bool napi_complete;
>
> +       if (READ_ONCE(napi->state) & NAPIF_STATE_IN_BUSY_POLL)
> +               virtqueue_disable_cb(rq->vq);
> +

I guess the root cause is virtuqeue_disable_cb() doesn't disable cb in
this case?

static void virtqueue_napi_schedule(struct napi_struct *napi,
                                    struct virtqueue *vq)
{
        if (napi_schedule_prep(napi)) {
virtqueue_disable_cb(vq);
                __napi_schedule(napi);
        }
}

If there's an interrupt in the middle of NAPIF_STATE_IN_BUSY_POLL,
napi_schedule_prep() will return false, so we lose the chance to
disable cb.

Thanks

>         virtnet_poll_cleantx(rq, budget);
>
>         received =3D virtnet_receive(rq, budget, &xdp_xmit);
> --
> 2.43.0
>


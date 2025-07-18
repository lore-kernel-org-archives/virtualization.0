Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98F293C72
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827555; cv=none; b=e3a0Sxu0h8HOZgHI1pJz01kvet5u6PwuVtX/tPaQvFiqyxaXAF3TEZAeyjfUcgdsOuflGTnuupDD3KrxbinssUI3QRloKEOPJ7l4e4z9eoBwHaRN7tHMoX5Bb6J35ArBmcJMRLuIyuPM8OBA8m05gQ2yfJKcRQ8Im+czFaavD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827555; c=relaxed/simple;
	bh=u+hOpWXYGqQzlXztN0daxiDWMdTwEOshtpHvQqgxZTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBLQPOretDR1GueoP90f010Eqhve1CxcqCjcdYnzT12RSfSDjtloDxVNHMmN9vexm2e7U0VLAjmqfqNZmd6Y7sZcXqfttTSjBY0uJqM8Si0czFeNcVfS/H0Zibdip9lgb9h3UiapidDMXzPZ2HMcuN6hcrEnv36ubT4lXBIynf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akv67P4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akv67P4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752827552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
	b=Akv67P4gdWrlXT3el9DcBoVd/2viIeArNvghPStEE8NL3oJ3osueu62w72Ybg2pIcQU6CF
	QMvqmGhXIQD/zHkXbAZJZFJ8K0mWz10wZLVdpn+bTyEUspxRoJR/juRgdxJOa4dma+6SUv
	mbl8bz1BiRKwsVnWnhr3uTDfzAAjTeM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-EQhuF-JtPRKVzMFJwHqD1g-1; Fri, 18 Jul 2025 04:32:30 -0400
X-MC-Unique: EQhuF-JtPRKVzMFJwHqD1g-1
X-Mimecast-MFC-AGG-ID: EQhuF-JtPRKVzMFJwHqD1g_1752827550
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aec53d77a78so106758766b.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827549; x=1753432349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
        b=E7Yrc4oQhDWfJySyRbo7VvE/731b97f7Lb0xt7Z8Yb4fhcMgc/9mrGFHCa/OyQROOB
         3jiiMlmaupZht4PvD6jGCILZTEc+BdF4scd1wmIu2+P5x9jTsJmzE/4LvzDKraiESJwS
         +lw8HdSg0ZNyRi2j4LmSJ3HjlkKIVRsxKX2qxPe5VJ9IIQZw4EcridmsBQL291XLAQGW
         SNvrZCZvTBzd/p9si3+JP08KRVAkfuQ6gDegW9qrxo/gvhGpCxYDoVvEukH9oT14jGxZ
         kPr0YEahgy/hFHQKPX+yvRQ7OvBEdMkmF9CV+1ZrwYOiwU/CSB86drrMFVeJGfR1zbdo
         xEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1QURYBXdlLbsdCh1swXL2hSEP4MEDGCqaiHnsdRwz/6Lo+3+XWt18xSvfZDd/POhxCjRQeygrPfph2JG0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE4wXuJRJfCASzbpBjMbhcVG40lx559UytW2xks6u0AmlwLA88
	dizWcPbHBMGGFXZIVF1kLkh9L7H0LMEUTt/No5QwbzvaoBHuFSKpg9PdXtea/lcL+NI2lRSgJ03
	VAg1DNC3yf5VwQi8p6Dx4E1179LAq9bPiAvRr87ETvM8KiysBs/HPCxDAc6wHsk3g/JP8/qzqLe
	R+y5rtMYuoAXxanWnoKG/q8wXyx3bhFjXwKq17vj/xTZo=
X-Gm-Gg: ASbGncsBaieS7ZeE/SXABIvqaBpR8gzB4eftHj/AQ82QmUkhH0aOnqy5l5Z1YNIw5b1
	sAXviWshyLHJn0WarZ494tO0wVQrHiRP/7Llq9N06BMh/BgmGd14z7g7cgjj7aF6qE/4BdmxnIK
	VyaVpUHW/gUMoe3Q4rzokqeQ==
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-aec5a3354femr462487966b.41.1752827549545;
        Fri, 18 Jul 2025 01:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZRbZf1CSxDdcr2KaS1fw9e3BgI0jPEf8QS4qDJaocQ3CHMAkyjsYYe2SLqnUm1+1w/XSVLxztz/eFpNmyZDs=
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id
 a640c23a62f3a-aec5a3354femr462485166b.41.1752827549130; Fri, 18 Jul 2025
 01:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716162243.1401676-1-kniv@yandex-team.ru>
In-Reply-To: <20250716162243.1401676-1-kniv@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Jul 2025 16:31:52 +0800
X-Gm-Features: Ac12FXz3P7sVlSAVAM9be3FkuV1rX0FLSe-KqiVKeDU_xg3yE_St4sNLJJ0dYVg
Message-ID: <CAPpAL=xE4ZCyAhc+fkZwREo-cDHS4CG4fq4+sebazJgRzZoDHg@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org, 
	Andrey Ryabinin <arbn@yandex-team.com>, Andrey Smetanin <asmetanin@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n8uFLNuWBrF5f46iKOMbCmBG2Re7yly5qgYUoyDaVGM_1752827550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Thu, Jul 17, 2025 at 12:24=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.=
ru> wrote:
>
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NE=
T_SET_BACKEND
>                              // &ubufs->refcount =3D=3D 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wai=
t_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_a=
nd_wait()
>                                                        vhost_net_ubuf_put=
()
>                                                          int r =3D atomic=
_sub_return(1, &ubufs->refcount);
>                                                          // r =3D 1
> int r =3D atomic_sub_return(1, &ubufs->refcount);
> // r =3D 0
>                                                       wait_event(ubufs->w=
ait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs h=
ere because condition is already true
>                                                     kfree(ubufs);
> if (unlikely(!r))
>   wake_up(&ubufs->wait);  // use-after-free
>
> This leads to use-after-free on ubufs access. This happens because CPU1
> skips waiting for wake_up() when refcount is already zero.
>
> To prevent that use a completion instead of wait_queue as the ubufs
> notification mechanism. wait_for_completion() guarantees that there will
> be complete() call prior to its return.
>
> We also need to reinit completion because refcnt =3D=3D 0 does not mean
> freeing in case of vhost_net_flush() - it then sets refcnt back to 1.
> AFAIK concurrent calls to vhost_net_ubuf_put_and_wait() with the same
> ubufs object aren't possible since those calls (through vhost_net_flush()
> or vhost_net_set_backend()) are protected by the device mutex.
> So reinit_completion() right after wait_for_completion() should be fine.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Suggested-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..454d179fffeb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>          * >1: outstanding ubufs
>          */
>         atomic_t refcount;
> -       wait_queue_head_t wait;
> +       struct completion wait;
>         struct vhost_virtqueue *vq;
>  };
>
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool=
 zcopy)
>         if (!ubufs)
>                 return ERR_PTR(-ENOMEM);
>         atomic_set(&ubufs->refcount, 1);
> -       init_waitqueue_head(&ubufs->wait);
> +       init_completion(&ubufs->wait);
>         ubufs->vq =3D vq;
>         return ubufs;
>  }
> @@ -249,14 +249,15 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf=
_ref *ubufs)
>  {
>         int r =3D atomic_sub_return(1, &ubufs->refcount);
>         if (unlikely(!r))
> -               wake_up(&ubufs->wait);
> +               complete_all(&ubufs->wait);
>         return r;
>  }
>
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs=
)
>  {
>         vhost_net_ubuf_put(ubufs);
> -       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +       wait_for_completion(&ubufs->wait);
> +       reinit_completion(&ubufs->wait);
>  }
>
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *=
ubufs)
> --
> 2.34.1
>
>


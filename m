Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C620B34
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507323; cv=none; b=fdLQgQfmD9OzVyO03aUSeoo68killnCwIwQ9+0TPtXEyomgchB+dcYthYL/12j2gFs15yU8XxhNb6Yt+Wk7COdjYyFDoSbVBIZwF1ha09X9bqEsoRsaKpYHsloDc/SyKItocqO+K0Ijhjnrd4+MiljA7LRs7S5ELn00No0wNqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507323; c=relaxed/simple;
	bh=axjOW/vY9e3o+PZdfzQ5WQAdCV1jLWhlfmMBoBEahCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h79QcP+BAOCa6XuDAoBq+5NDZFVw6uPTDOFaKRiWMCvkfVa1W7RD6GJZX5CjaF0ULaXlMAO5zKwkqpbAivjulMK2gUNim5ns1eNw7EeiCWZz/4mpMKdydMnOdBa8hJe0XI8ZaJyqTag68dkmEArmUCM16qv7LLH/PXiXxuN7sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px5iTBfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px5iTBfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711507320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7kv7KXHkhOIlsVSgT9TYuMfAwXaBotnL9UfnoFbD78=;
	b=Px5iTBfcCbVzCHtCSFaH7f2k7RLvHJAzoBK8pMLwHaaMJm7roLpTuxfYVGCqpW/CLllnXu
	1gMR/MryG5N19AtX1xb8wXX6gq1/MntUaJJp0DhtcHluln6XrfmrTvUcBfS9H4qwrmGuXb
	JC8nztVWZc22MoPnIYXT4YKJm9dYiI0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-txZ7_AiIOsalVq3xYJbIQw-1; Tue, 26 Mar 2024 22:41:57 -0400
X-MC-Unique: txZ7_AiIOsalVq3xYJbIQw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so4695568a12.1
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 19:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507316; x=1712112116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7kv7KXHkhOIlsVSgT9TYuMfAwXaBotnL9UfnoFbD78=;
        b=DfKqmlWov6yshZUs9xFuK3ep+PzOU8wHxwS4m4vQRN60ngKEjcQeayk3/jcLCnJW7F
         jRmYlZAKvC0uD5mvPPlJEyO7iCV327YpQ33WjJ8rmmlprzjfP38Wc8PuOHA4kNmLbD5t
         bh4bo1KFsmaMw2gWjh+MeHF1RMA5qiZNGCS+QdGDc/imbQ0LvJdjHNGxg/lToniasMkZ
         MSIdEgP6wiZDQfAF08PL+cbvfVcd+FvucgmrJiSC6az4M59mK1LuQJbXpLMyRwUxxOXm
         yfHfma5e5fFxmHu/Yf9V7eWXcNvpYCFUJMUk7toMBdfbVXZGUF/3KR8fbkRg1kol6kAN
         u3/Q==
X-Gm-Message-State: AOJu0YyGSHoY+vMjWnAv6kdmG9QmOZQV28UpHiBv42aaOhOpnAk4Yx8B
	nj63WK1Oiul+61NFFA3dv9PILhTrZdRd5jiP1H44kPIlwnXaT5vIex63FcxII6zCMUTuF01jLXQ
	D2EDouB+rjHfuZbQgEqYXRrxV/G/lPj1MVsD2hyKRBCKJjX4pyJ0qk1Tx008xighDEgaJWk2XPu
	Wct1wPii1xEhZimG4Ez2RLTQ0h3pYvzl602dV6i1k=
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd9:3123 with SMTP id x7-20020a056a20914700b001a3bdd93123mr9985482pzc.9.1711507315998;
        Tue, 26 Mar 2024 19:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Z+wFgaV7C5ynBGBf1PskljLQf3sO3b8YmTi3SpnxiZuF/2uCdwLrbHKuf4QxtkJ9nf79f1L9OngqZAGf1cs=
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd9:3123 with SMTP id
 x7-20020a056a20914700b001a3bdd93123mr9985471pzc.9.1711507315720; Tue, 26 Mar
 2024 19:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-3-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-3-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:41:44 +0800
Message-ID: <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: Add smp_rmb() in vhost_enable_notify()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> A smp_rmb() has been missed in vhost_enable_notify(), inspired by
> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> available ring entries pushed by guest can be observed by vhost
> in time, leading to stale available ring entries fetched by vhost
> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> grace-hopper (ARM64) platform.
>
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>   -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
>   -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,threads=3D=
1 \
>   -m 4096M,slots=3D16,maxmem=3D64G                                 \
>   -object memory-backend-ram,id=3Dmem0,size=3D4096M                \
>    :                                                           \
>   -netdev tap,id=3Dvnet0,vhost=3Dtrue                              \
>   -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00:f1:26=
:b0
>    :
>   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>   virtio_net virtio0: output.0:id 100 is not a head!
>
> Add the missed smp_rmb() in vhost_enable_notify(). Note that it
> should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
> ("vhost: cache avail index in vhost_enable_notify()").
>
> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> Cc: <stable@kernel.org> # v5.18+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 00445ab172b3..58f9d6a435f0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2847,9 +2847,18 @@ bool vhost_enable_notify(struct vhost_dev *dev, st=
ruct vhost_virtqueue *vq)
>                        &vq->avail->idx, r);
>                 return false;
>         }
> +
>         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> +               /* Similar to what's done in vhost_get_vq_desc(), we need
> +                * to ensure the available ring entries have been exposed
> +                * by guest.
> +                */
> +               smp_rmb();
> +               return true;
> +       }
>
> -       return vq->avail_idx !=3D vq->last_avail_idx;
> +       return false;

So we only care about the case when vhost_enable_notify() returns true.

In that case, I think you want to order with vhost_get_vq_desc():

last_avail_idx =3D vq->last_avail_idx;

if (vq->avail_idx =3D=3D vq->last_avail_idx) { /* false */
}

vhost_get_avail_head(vq, &ring_head, last_avail_idx)

Assuming I understand the patch correctly.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
> --
> 2.44.0
>


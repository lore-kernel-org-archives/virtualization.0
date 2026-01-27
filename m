Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED8225775
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501197; cv=none; b=NMdcYXj8eMyJa5QcI2p4CNAt1Km8/WAEXWuLR8MlxlbZs6v0X9nLi7hlqbLpCe+Kkt6sbxXpFbpCx+lp+WZHWUzb6NhtgUYwt0RIO6LUUfWGZrrgRspABwWdPgTYeTEuY3MPeTSjb4DIwKx1cDriBOiorx4uy3Tde0P7oKU6O/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501197; c=relaxed/simple;
	bh=TTzX35zi7e2uDGzGbD+UvIWRM4CrGZWHR2CuACTNbQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAF1dB2GXHfn4LQjaFr5jIQrV8GyI3yAiap5ppanW4Gyz9dVrXsRGsTMRhurprucQ9wCosNrQ2gRNsJHdUucPcmYPcvbPQzfZR8H9LTffnxVuKmIntB4qZxX0jJsIrJKLO9o3ghoMRTqmtGppQfQ91uglfvEFx/97ikpcp88yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6zn9PCm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6zn9PCm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 808D040B9C
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 08:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NYevjs8avx1 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jan 2026 08:06:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6854340794
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6854340794
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f6zn9PCm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6854340794
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769501192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
	b=f6zn9PCmaoBzFX7mLrnVckZZVXJZAQ1m55gT2mWyh3S314Z6b49joxTuw3iA3/YFHBXt/v
	rjNOmrtwi/sSlcS0p6DJDXgBF8fOptqdHFQDdKFnPFLN0K/K/8VBhvIdJIOdAcqLTvrfBN
	a67028b/IFZsbV7R/19MxjAkD7RBSlc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-TWKp3wlOPmuMLAA5eWz0pw-1; Tue, 27 Jan 2026 03:06:28 -0500
X-MC-Unique: TWKp3wlOPmuMLAA5eWz0pw-1
X-Mimecast-MFC-AGG-ID: TWKp3wlOPmuMLAA5eWz0pw_1769501187
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c61dee98720so2775116a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 00:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501187; x=1770105987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Np7Cptnfw+XZkLrXgFu9BqaG1+Fb7vNwdeFnlALDuRg=;
        b=jXcUgs//B1s0cR7kVnkGyovazgpj3uRsNP90+iPFrTssGy2lg2Ed3/05w/q21vCAPU
         8Q/YCc4Sqy5e5IiIDqlD9TSqWYYrrmkYrH3kA3875YqF5AAVfbjgHBDaInlDjB9ksnO3
         5Gf7JX6OIylIohr1AwKHXs2cbnetzUNabJXVwYN8NVxHwWV591OYxWO+JghU0aEmLsB2
         Rh75+/y95VjXswSyFx7orjbzcAh4hbBhFHNozDSeMpwHaWXBB1et5cuQ4sFGkl9xExTp
         DDnzK9iBDFR8rdiZGOibPiWWcj2xZAqpBJHpnRVrF48TJPyhzm7SAf7lbH5DUDoZGnpc
         pSIw==
X-Forwarded-Encrypted: i=1; AJvYcCViBmAS+iE5oRNBfao5WQk1Vzmqpnfj1RqXcjCZd9s6MoKUUgsk1AwU8LDtfEk4BM74x2Uz2EFNv6AALu0DXg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxBgf3xujvQi8QTYej8bZLDoJg+yuZoHe2Ew177am/KTwSR/E7F
	6jE8Mlh8MUDEwagzJPUEEsTKVooQa9ceaWlKB23zrLHnchnrJqpvuXAjg7qSm3JDhrbQtz8Y7lW
	PbqML95ZrSUVnEqK3QkbVn8l6H2IjggShNaoQjzMVLWUitgmsb1lJs1DUtcz6wms3HOCztuniTu
	pFBnL4nlJopE0TL1CvE97yBWdLjUEp0uO5F6R1TVL42n4qP7CjBG2xHzxZXA==
X-Gm-Gg: AZuq6aKX/LmNqD/ckw1CvpUCdn83jGrbf5OQFagmVRfbvTKncvvNHVl+Vpm4MVrkw7q
	rpp8U6MHo6eDCoWNfjo1OpIhvO6dIRRDj9dR47FvR0rAWpBKJ/LxodmWRrX60+qfxL9mlN0R23N
	gHgzhYPXl7PK7q/VBVO7hN+8AfgvmC1jvcpJs0YrWmjerxdVvOAsqyvnm23V25EuW5keU=
X-Received: by 2002:a05:6300:670b:b0:361:63eb:d024 with SMTP id adf61e73a8af0-38ec62c85f2mr864710637.23.1769501187110;
        Tue, 27 Jan 2026 00:06:27 -0800 (PST)
X-Received: by 2002:a05:6300:670b:b0:361:63eb:d024 with SMTP id
 adf61e73a8af0-38ec62c85f2mr864691637.23.1769501186706; Tue, 27 Jan 2026
 00:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260127073921.175981-1-lulu@redhat.com>
In-Reply-To: <20260127073921.175981-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jan 2026 16:06:14 +0800
X-Gm-Features: AZwV_Qi9BNqEGOfaJTvxImo9xsBd4ZDBvvBGEwTUkdPThnSlmVC_s4smZpdhUJw
Message-ID: <CACGkMEuEjtnY=-BFj-hhn7JG+N=LtjOJYM1HSonjgKo+wf3m5A@mail.gmail.com>
Subject: Re: [PATCH] vhost: remove impossible check in VHOST_GET_FORK_FROM_OWNER
 ioctl
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ToYdNfH6QIEJCKp9mfqgPQWGIdnTtMsP3CLQIsks1JU_1769501187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> remove impossible fork_owner check in VHOST_GET_FORK_FROM_OWNER ioctl
>
> Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode sel=
ection")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index bccdc9eab267..889481c92236 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2338,11 +2338,6 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>         if (ioctl =3D=3D VHOST_GET_FORK_FROM_OWNER) {
>                 u8 fork_owner_val =3D d->fork_owner;
>
> -               if (fork_owner_val !=3D VHOST_FORK_OWNER_TASK &&
> -                   fork_owner_val !=3D VHOST_FORK_OWNER_KTHREAD) {

There's another similar check in VHOST_SET_FORK_FROM_OWNER?

Thanks

> -                       r =3D -EINVAL;
> -                       goto done;
> -               }
>                 if (put_user(fork_owner_val, (u8 __user *)argp)) {
>                         r =3D -EFAULT;
>                         goto done;
> --
> 2.51.0
>


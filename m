Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47B322B
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749994136; cv=none; b=gUTRV8ZcFtPlRmmR17xtrBkwdP3JnEEqUKpnMKxPLQrEj5tK6ViG2Juz0QDgpeqh+THO9T23Wru0jKUYqxSPsuNzPuSajpdimPNxZMdeaxYXKB9fOq58sTEdO8pXfLJyu9+1NYNm3XYWEK4ZO5A15ExV8hOvnIjzKctkHdwtSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749994136; c=relaxed/simple;
	bh=sWAssjyEI19FZAiGhHjYqcuvewEk9PvOIDIT68my4gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXFS1cz6kLo3gb6fLWIzY+FFu6cE4UwHnJGk7//s3Wp5fp2homc5t9RzZh31fw030KYB6pOYSZfPgat1g6eFtYvHPHzuu1Z2Ubrl9XfPkElWmJECgNpZqPpZZ5iAm/W0LRPZcy02h/gJKzRHluqUOa+ODl5B1JDwBxMy3Fu2sVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT2eGQB1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT2eGQB1"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso7338172a12.2
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749994133; x=1750598933; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjiH1xK6fYQmGjxEPvPdDfi2YzSjG40dEI9e3IGwPTE=;
        b=nT2eGQB1fEL9dGSTDvBgfrybLnbpxpib7usr4RhAxzrcMJHmNyEcOvV2z3RrZqpQuU
         9j42KRaOm3VdTTdhGZazrN9mci1DkVitdi+k5cyaN6I9mX2ZGQL680Wx3jThvQiPx4XB
         e1AyYeu5FB+LYx3HgMRfQOO2MX4t4SqOhinpmTLwxeakgjE1c1ky5G9ciTB6DHzJXmcU
         wUFSeVcLfvfDXiKJxufmMcq0lL1hPFZG8InuaNEPmuTA6QNkLOipWEaGcZbTDi30Xced
         UqmBzlDwHzvcyiUTpFvqoymhadLiaMqOtBsUsKC+kvT+7bmf5dJDXDagOLFlIX0c97La
         tXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749994133; x=1750598933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjiH1xK6fYQmGjxEPvPdDfi2YzSjG40dEI9e3IGwPTE=;
        b=cyq+jpLjTwpP+osF+ASNNcSHeLTvSszzXW0mxyC/byuKlEjTOQOE086dsYaEfSABEi
         ICDHSarCG8//o/Al618upF0SNUjdun/mdHKkiv513UDsA4Z5S7h49XL7pzL0xEO3qRb1
         vB22lGkNRrMFqcypV7ZuftcrdJ0mwY2T8xjfgJ2NYCiZLeNm2VdOn2npkVOk2M+QDvT5
         lOTLXCtFxMa55POLVraBGuY0kegXG6QOgT4zLOgpAmXKsGvh8IrAR96L5Z5JbNB0wuuC
         dYUnodqt7i2etcrTVj5qWGBm6pyv8Z1ms11jluhZ09ClWmUrdwOTEacPv2ISax5ScJOw
         hd+w==
X-Forwarded-Encrypted: i=1; AJvYcCUY/rsRjSAg1tokSOZly+5lSdIi7fTJShUG3w6bKYm8B5DyqMjJSTSwqOZPJsnGUMpdrcPes1vnb3T3lE7bcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5+IVY732a3wbKZKz2lx5vopMkWl0KzuaHTf3Ds3ErfwHjzSW3
	o9xchdhMwKNxMPZnCskC7DyFqiEdHVBGEsKBasgWVI/IXg6/WSnYQmPV4YcByYR7XFYTOT/YVk8
	+R2R2YT3DwnKzrwx8R3KN9cP4YUhFso8=
X-Gm-Gg: ASbGncu9PM9ylzRxeSpToQF/ZwR+R+pGyWIQKdrhk4as24fLURbXx8Ww6XuduT4TF+o
	IZ8bT7Yq4HlSOJr8Y61oZeUCJwgB8QupeZwlqBGEJh+MPsEqsXt2DElCDRfIcO7kWKEXEkpGWn4
	Q4GTbkovxOrzbuVkVBMo6A8p/ChxT7+Nbs6r0+HZKz9A==
X-Google-Smtp-Source: AGHT+IEfPwOQQW3BYE3BbET2rMawKMlJdtkVUQC6mHkl795b/83dj9ucpxE8YPdhun56cwNQV3GZRCl8O6dhcwJxOwM=
X-Received: by 2002:a17:907:3f10:b0:ade:3015:534e with SMTP id
 a640c23a62f3a-adfad39c71emr510352566b.14.1749994132726; Sun, 15 Jun 2025
 06:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250613055051.1873-1-lirongqing@baidu.com>
In-Reply-To: <20250613055051.1873-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Jun 2025 09:28:40 -0400
X-Gm-Features: AX0GCFvWiMT6P3Ve9qL9VUU1ghgL0MnzvSUQp9Ds_FjN69brmotJ2fLC6Yboi7U
Message-ID: <CAJSP0QWrqb9m0jY00xvxz+Mfsi+UtE-D_Q5TE45RCKbS_ZkgZg@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:51=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

The spin lock originally protected req->list, so the lock has no use here.

The initial req->list access is still protected by fpq->lock in
virtio_fs_requests_done_work():
  while ((req =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
      spin_lock(&fpq->lock);
      list_move_tail(&req->list, &reqs);
      spin_unlock(&fpq->lock);
  }

Looks safe, but please see the kernel test robot email about an unused
variable warning.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8f2e2f3..de34179 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -791,9 +791,7 @@ static void virtio_fs_request_complete(struct fuse_re=
q *req,
>                 }
>         }
>
> -       spin_lock(&fpq->lock);
>         clear_bit(FR_SENT, &req->flags);
> -       spin_unlock(&fpq->lock);
>
>         fuse_request_end(req);
>         spin_lock(&fsvq->lock);
> --
> 2.9.4
>
>

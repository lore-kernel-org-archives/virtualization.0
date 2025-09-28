Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570341E8320
	for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759084094; cv=none; b=ktz7OWSQN5ENBUWHyAQVYi7CIoRPYKsG4Jq+MKkXZiqMCa1326NOwnhideoSePXjbCchWuB7RE+dPeZ6attBStJBNYTJCPbpZfpZha7XskB4hsLbbxQJXoZLcT5KqHJUoE5QFEkOxSIGcla6aUzIpsUe1WCKMcnoL2t4QwqJVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759084094; c=relaxed/simple;
	bh=TeBpzck/c7OMPChD6RmJx4cqXDKvwDsYwcS3NXi78L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slpJoliLruz29wJiaerMqO9wiz28XtHYk2tewFUrw7kBzJ2SaJkye7uvPBrxoDINwpXD7VnJY7ot45cnSoUYd1Jb5HfpXgrjz32uNn+4GSy3g8QSLxXclRPFKfJa/gEiA8Rpu6HfmRjl6Kxha6obN4HiSHVM97SKl7FKED7wHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saziy5cm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saziy5cm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so27392265e9.0
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759084091; x=1759688891; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdKzRlhcATdj0vLPnh0uR+5zLTf4ork1cuaBafA3aLk=;
        b=Saziy5cmqmWoQyPDPw/H1yG/g2aPrwUP7FpY8jAbMGMaGLRhZztJajLsSV4iq6QRO2
         obUf2+gdlyXIIt1KAJpsXZrsa0V4AeIVfwwY5sW/k2xl+A0jtU12wXumrf7gF5C7ll10
         cl0Q7RJ8DXYLqJh0HQ7/UoycVPVtesCS6hbLEl0MXYYc0YlJvezMUo6elKyngg++R8Pc
         VtlG+7jgpb7ab+y64cHpZq+iH3ZXI4PChXf0Un1XxEALRF2b8tPWhK6XPSSbBqButMtp
         AQg1VxW4WGV187kuNo6nrOxhP2LxyikymM8lhSLTn/A+B2WiTU2JJJJajTO916diDnPx
         AAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759084091; x=1759688891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdKzRlhcATdj0vLPnh0uR+5zLTf4ork1cuaBafA3aLk=;
        b=rDcaFFe4YrrS+gYhdXEYemKfOeaQCjWrUc32/pgcxHHFXGrWQkW3pSaxRU8ulXNLEA
         d5/zs1+zlu1rFkY4ntrWPTi7/cDwrKCNR9RN5w/JlmH0mL2bKLF8gWL8uxDl5S+LoAMf
         sUD9RnC9/fDQRtPFv1nVtFt2aA3kjlya59wP18g+u5Y4ze6S5SEywYE+5lzEr66FkFZe
         jGkhdclj3n1Z6HHdd/9I0d8W33UwABi9ZeTd0mn+Hd4OINCbUvxniUvEZjVY2vAFr+8Y
         I5ENGXswxP6V/9vuiw4IThsfi6HbLPcxzGJQjIUMO4VDOur0PAuUce3Gxh88jJaqEV8c
         +4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQzGY1AkFNKoPTMx0GEki7UlIOiMc6fQn6jrjBeDhTCTvaGDASo5IDl/MsED1UyZK+LoUgEQXmYwcTZ7RvXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU0LANkVIoTR0KLzfqvFmFZrN51VdPQBvQeaQe8CHAI6C2CKY0
	dvQduljMZ9U3Ljof1+gaAAOQPn5nn6HSHzqfD8yNXXeEXN+exCT3BWf3
X-Gm-Gg: ASbGncudXivrlGth0dJTntmchndO3BopKv0s/pNLjPFOBAePYCxxzv/b/t1xbslImyW
	hpMGQgKer49BO05OyW4buUYkKX9aAf6RvxfyIHwmA0KrL9+5stEStBJ5levTlsBMyxXVue2oJD0
	iQvrUX7exm+Jo65FdTme5bBxX69GyawBhgGVP3qgjFobSus8N/5OGoKb955+okCDdUjbgqVWmtT
	JGyfqOQ8j9VS6MDt6TIvjozSQZ69Od15S9TzSfxbjvaVW4nnv7N3DyqLJUeA3WMmlx92BE8lFW7
	JgZu61T8Ns+n+UNyAbwohlWDNKrzq9i4Wqu28orIpSXcLvFD9cWMX8jeUarj5aC8C8XPNrM2krY
	fOjKY9saIniFnMK4qSORRKBMldHk3/Z0AzVouIiVZHgv3UQVCzUAwMS/z208O6pnM1cYqsd5kxj
	b7rPs1yMLYig==
X-Google-Smtp-Source: AGHT+IGgJXF55LKOLfygan1FdknY3MPOgSje7cnTfB9m7PtcORMGhQK7mNNBqRWtitLvFZ26Lo5ULg==
X-Received: by 2002:a05:600c:1d89:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-46e4925cb9dmr40017065e9.20.1759084090504;
        Sun, 28 Sep 2025 11:28:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996e2fsm212602475e9.2.2025.09.28.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:28:10 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:27:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in
 virtqueue_poll_split()
Message-ID: <20250928192719.7ea3a825@pumpkin>
In-Reply-To: <20250925103708.44589-13-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
	<20250925103708.44589-13-jasowang@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sep 2025 18:37:01 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> spec.

If you care about performance you should pretty much never use 'u16' for
function parameters, return values or any arithmetic.
Just because the domain of the variable is [0..65535] doesn't mean that
'unsigned int' isn't the correct type.

>=20
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58c03a8aab85..4679a027dc53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>  }
> =20
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -				 unsigned int last_used_idx)
> +				 u16 last_used_idx)
>  {
>  	return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,

You can't want that (u16) cast now, I doubt it was ever needed.
Note that the compiler promotes the value to 'signed int',
so the LHS of the comparison is actually (int)(u16)last_used_idx.

	David

>  			vq->split.vring.used->idx);


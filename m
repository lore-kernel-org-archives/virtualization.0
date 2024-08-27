Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5757171AF
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725966; cv=none; b=UX1thelY8NTAjmXBcayNaQ0BCNgB+KECj+6s350nfHNaRxfzGoOefLuVWAV17c3DgURQnMGKX/aOyRv74YxklynpaHckdRXFgxlOJ6SZVJTi/szCVSUZdjlkwfm1G0ruKaJiiSyDWzqHhqP8MBBAvGi5pxVlJCVNcUr6rrcAsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725966; c=relaxed/simple;
	bh=sbJPq9FvX2e6wYSiTp7LDJ/eS//czmssCLWsf4RJfMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7oIv5de/UwcKvqmJOrkQz2zCW1EJpFSjjnElfK63CGCZmVXQUReR0IZy6n4D4AVC05Znvlodzlh9eDkKTX2EuOoDYD2Zd9JfPT1e96p36y2fiQwHskggM/6dnqQ+PbnAiVIPwi9SSB+ccHpf9Qy9xxKPUpTBmUfGBpX60QUcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaGuHqBG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaGuHqBG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9635B40283
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVITRRBLKMpx for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:32:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 81F9040261
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81F9040261
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CaGuHqBG
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81F9040261
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724725962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y7/wa1MaZmQ/+PLuz5xVB2gQebXbYhMUF4nVUR+irA=;
	b=CaGuHqBGGEyCpwQhSHwNfXUKRIn/djKZW5yWxjuY7HMUY7oE+wtlCiSUaD5VZuTeU/mdFM
	WzCI/CtewaPxvbuVk5FRyF+nBIObTcn97JsGpNMVg7AxCARqdZDFM+D8BvSD+FEoFW9zN3
	qOCw4RP2pAkHBtDi4nRjCgc3B/AK0bY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-GzAn89D0O_2Vz40LSxTVXA-1; Mon, 26 Aug 2024 22:32:41 -0400
X-MC-Unique: GzAn89D0O_2Vz40LSxTVXA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71431f47164so5198971b3a.1
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725960; x=1725330760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y7/wa1MaZmQ/+PLuz5xVB2gQebXbYhMUF4nVUR+irA=;
        b=R2OFTX1YpAkBn9nMb2js9otcEI+zb4fWp+vBjEmPokWO94MUat1XvjXwYJURKi1szo
         CTpmecv/TIIIq9W87NpwCSGhs5r9h993MMA5rscw7VMmsuftOMJdFNN06hRPRTIIFGby
         saklrlTdmSKvCjYxwnQiuodTZQ0IQAgsZIIUIZseWbi9XGANuQYbW+cFfdJ59rBkyJ20
         Om7cg8Ii7nArfrQcJgilwuPpFeuqKZwzazo6hJO+Rrnq49aoRWxqS6CjbzTYe9Yqmerv
         MQmgTLx0/cOKdWCj/ODaW2ZZQxTRnVcZ9JUrPy/4wbI2g2sXGzbVd5qwz05po7a0ANEr
         dApA==
X-Forwarded-Encrypted: i=1; AJvYcCWsr2w//kUouHqFomBfGN/JkUeHAHefjm5OKc158wIcCX0g1KGQBFiabJRu5fORDmZsQ9Z8Vvuru1LajMIk3w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzS7RSPVCFnBiXBzgC2yPFnjJjgvnHcK9DrUN3E41b82uBKw1uP
	FUboOtCfjNsoovX85rJuUnvUd59LON5VfM1g4epCAFsad0/ioXKEAggLIf4OiLWeICD6jsD0YRX
	I232PO9g0DgMGFTEwmZbuSfuXz4h7QVnEvZl8H3LuQqUHv+1CR/8FtjJzdPc+TOGBbZGMNNHKqc
	q2MqBbTXuN8OeYc488qjzdmoo2yfkxwyRnq3BLTQl7ZxHvN/etTlS7zA==
X-Received: by 2002:a05:6a20:c6c1:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1cc8b63e7admr15581331637.53.1724725959989;
        Mon, 26 Aug 2024 19:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0YzDFcuPZUEn/RDzIMIFU0bMwWHEcp2sJbXmCkPl/vxtY4HYrc6Ziaa9VVlyYiEP1DgNDh9tY5fDaUtI7Hg8=
X-Received: by 2002:a05:6a20:c6c1:b0:1c3:b61c:57cb with SMTP id
 adf61e73a8af0-1cc8b63e7admr15581317637.53.1724725959432; Mon, 26 Aug 2024
 19:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:32:26 +0800
Message-ID: <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to support setting the vhost device to
> use kthread mode. The user space application needs to use
> VHOST_SET_USE_KTHREAD to set the mode. This setting must
> be set before VHOST_SET_OWNER is set.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 11 ++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 0a7b2999100f..d6b71bddc272 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool kthread;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +       if (ioctl =3D=3D VHOST_SET_USE_KTHREAD) {
> +               if (copy_from_user(&kthread, argp, sizeof(kthread))) {
> +                       r =3D -EFAULT;
> +                       goto done;
> +               }
> +               use_kthread =3D kthread;
> +               goto done;
> +       }
>
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..386fe735da63 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +

Unnecessary changes.

> +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)

So I think we need to do something the opposite. New flag for new
behaviour instead of new flag for the old one ...

By using this we can unbreak the old applications.

Btw, I think this needs to come before/along with the introduction of
the module parameter that enforce old beahviour.

Thanks


>  #endif

> --
> 2.45.0
>


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8F171D8
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083448; cv=none; b=Lf4NEt6jDYtEEP1Sm99VSr+IdDMmQFrD2F4nPMwq8Yszkh/LH6T7tC/FVYqMMkrtHjk//mhyDSDYk02TUc5gxjiUrGy2XRpiMTecAWQoRkxn1eqDTexeEQLjljVjVs14DMoHKM8HK8MAlgGP0tDgMG8jCNhI81QXwY7vbLD6Edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083448; c=relaxed/simple;
	bh=3ryJ9QfMSJB5meTFNmrsG8yMJDsWZtcgCBG7GnLOU2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRIQsOKp7CO3qHGN32vPKbPWayIbmtVIXqj5Krzs5g7vL4t7iLJ4o8mC6Lo8I23LCC6GcOHT9t0KlijJNUk9QT4e8KcA03QtlHApCifs3iRLzSlTIIQCxK/SNUtxUW0ia5HO/Y4id+gnQdWkpqDcDSWYGiYcwE8kMs/FlGALobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8uudBmP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8uudBmP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA024421E1
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA024421E1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b8uudBmP
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkvXF1sBXnjQ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:04:06 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF1D1421DA
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:04:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF1D1421DA
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a3129939d67so15079966b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706083443; x=1706688243; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMsMvcqo9tiI+zEI4bAOrsj58NkwX4U+iZs9afW5yO8=;
        b=b8uudBmPOJTp60C9glPpus60O4Wb7FVmK2kIoZ7sPPGEYHgRFA/8ihOrm4iV8npu0e
         DB7iQsst+6jf5m1Z6RjCAV/vuJYzSEU8t0uSKLPAVE00ie0z3Fm5Flad3sIrJZFs3VT9
         ljDtvqwYynfcdx9oGobqmQgfZiBqqH+Qt2Br7ZnXUYqVjn0amQCuqwO+VF3H4DOmAqr6
         Mjqj+1P7C8831uGhNniAdLFi8+rYXhVwkVxYMldUlYxdEbl8Yk2LeX0wsdQzXshFz3rR
         bQKBIGvKq8X0k5yAoXj9Q0XO/ll2W+suPme2YwTl+2453IcuhMFg7xdjhkcFYar7tApu
         KMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083443; x=1706688243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMsMvcqo9tiI+zEI4bAOrsj58NkwX4U+iZs9afW5yO8=;
        b=S6teCM5aUgiM4lm5RfR4y+Hz+wj7TpgD1uLt6wvuX10aQHcyZk8XKgNSmeKOVfFcTn
         ZVANyDY3qNYBJ8j0RvMrhx1PY6nTpJuwhiYEz8Yf6S3RP+XId5FAHqJtUvERH7rROvHI
         k8ExOpt1xtHtwi8+NXt8SMHWJn2OrT4grLGiYhfX7linKysB0bGEO10d55XkcTBU/uXa
         T03ZAGHUNC0uF9qEwkKVlTsrU5XGrW6DA1gRlnvfq7+iqBC/WKgvpRde7Y0UghrIt6mR
         6GVOui6nSUXHfMwoWxvJngLl1ba8jrFvWgAWfWrP+pAN/Br6+EFNyzk7ppNQcKZiVFBF
         1xJw==
X-Gm-Message-State: AOJu0Ywd/q0lWiaUpRzgiMxZWCO8bUhVV3mh2Znje+ebpNahmd9dj/Cw
	D9EO/I9vQBrLP7XZci3oOb6QJduX3bZ3VsPBAtIijb74XrAPZPRqAUOHMDawr9mqKu+PK2e7NPZ
	duKJTS9hJRjAkwPyIBBo0L2pb278=
X-Google-Smtp-Source: AGHT+IF4cJRxM1jSTL21PLnaFKGDqLs8hHv0lg2CRob3WakI7L0fkc1IUVV1PKo8IQj68dFnLssUR7qZBZPcSh6IUjw=
X-Received: by 2002:a17:906:c7d2:b0:a26:4625:eeb4 with SMTP id
 dc18-20020a170906c7d200b00a264625eeb4mr656392ejb.51.1706083443312; Wed, 24
 Jan 2024 00:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
In-Reply-To: <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 16:03:51 +0800
Message-ID: <CAKhg4tLMw01HgvmtSL9L8+1Yek9-JE2-BKxvWF1JeJeyMF5HFg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:12=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jan 22, 2024 at 6:23=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >         }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                          enum xdp_rss_hash_type *rss_type)
> > +{
> > +       const struct xdp_buff *xdp =3D (void *)_ctx;
> > +       struct virtio_net_hdr_v1_hash *hdr_hash;
> > +       struct virtnet_info *vi;
> > +
> > +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +               return -ENODATA;
> > +
> > +       vi =3D netdev_priv(xdp->rxq->dev);
> > +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
>
> Is there a guarantee that the hdr is not modified?
>

We cannot guarantee the hdr is not modified by the XDP prog, So the
idea is to save it in a wrapper structure before running the xdp prog.
Patch is coming soon.

Thanks,
Liang

> Thanks
>

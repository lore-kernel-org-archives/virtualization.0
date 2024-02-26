Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E356745
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943441; cv=none; b=Ko3xzD35JBJqo6UHHfP63roNzP0PjfEeykFHwsWeJnmV2+xA4Nk/5/c46KtAVczuJqKV9Ca7+YuyW66sO1WBM89uJLuNaLHEdPXykYBO3gUjElitYTyGAcviu4PljXrrAjNmvDk2gwF9Ndw/V224LR2N+u+7a5PoC7zbN68ZE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943441; c=relaxed/simple;
	bh=3AEg61c9t2RdSbrA3SOYlabwim+w14UVA/dDDZpqvZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oILfmONbvBMM5qlkG559FweClga5dpoH1P8ExCszkrN+jEYa2ZN4qhtGGCRrCRZ+nYmKtSyPbuNDulF4YVGTb3euVnrN5BANIjEoMYBrHX1mBz0gFqIJHFDs5v74CNIcWBx00zwkgAMZAjs3SUe5jNU2vsbITDhMwZBo2bRU4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=llppeNd1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="llppeNd1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e72ec566aso356430866b.2
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708943438; x=1709548238; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=llppeNd1Qkym5UShs0yohv2NmqFaFevPsegG8PrAD3q3pfEAnX9Yy4/o0rYUgdu8iR
         qwAYa1v/mG6O4LAmAw7CKkA3PLjLERL8m7p/hJfyhQRNPwu+BL7vpF5CL9kubIMeudDP
         PkJisquIJ7PmhmnMQa1fe+bUkazxi5lHluehontzo8ZR3LRJG4R684R/i8AKY0xvSpRZ
         Usuzu4QlqmRlIB/O7H5rfXs8utwyB0yox7P/hYUST8/p5jibJO/QL9h96CPQXn1PODwq
         CxHyESDLvN8S4XfC8iVlJebsDNOYGuc+eTtgbYi6NKOpxmfw6U27DJ43WwCZc9ynSZja
         phFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943438; x=1709548238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=hPvmork+R0PrkutHOup2Nc1z/8c5UtWWnCYkeZ+GZh0sdJx4obe7pZLSyrbiETn7u3
         6+k7ZhnnkW1zWpaWWdonZRnD8DJ10N0W0Ba0nuJtQXISGQwwIs4UEDlSy7QuUsPxT8wd
         JyeYcWDnWSVNlgJOswSwXVDs8kxUVFh8IYPnnAOCf4CWAaGaDaTtpo+BAkPN2mxO/JsM
         zHhGWglZdWXZFqivcHbXljNGy+DmlGvdvbJcru6Io+YYr2YxXdVyr/wq95ilGaOiY4+q
         iVnBXHmN97JanuyG8W9+fh47f8J1E5qFlGc6aEJJePIDsCbXGlEiXDa7buJ2pgCca76T
         mvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdTiwiDcTsiP5MUmTf1BNy94g4pWWh3leJacqUTi8cQybXjNLw6QR5mis+VVo8KJIKIhHVY2YaYCXNSfaJDnEztkwcYJCWp5gTMg7Idq4=
X-Gm-Message-State: AOJu0YzE6QvT1p0y/ZmGvUcZH0r3x/ZxjY5L8pZ6eUVSL9BMne9vXlrt
	Cgm2YPyPYzBlYs69dHdA38I94mavlLIv/4F1NKKQtjv9EsXyLEkmi3QTYllpGc4gIBAdL1/T4N6
	2mbSSe9kcEIV+1sXv5R78VJiXfJE38vuI+c5MqkYhjyxVL5ky
X-Google-Smtp-Source: AGHT+IFRPov8/cpih2mq251F4b8kRlFyC5NNX1J7o+YMmyopd5NzNTlRC1I0AnsNzV9tfVe1KWjRjh446NXfYck2paE=
X-Received: by 2002:a17:906:68d2:b0:a3e:5b7f:6d31 with SMTP id
 y18-20020a17090668d200b00a3e5b7f6d31mr3616604ejr.5.1708943437867; Mon, 26 Feb
 2024 02:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com> <20240115172837-mutt-send-email-mst@kernel.org>
 <20240222150212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222150212-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 26 Feb 2024 12:30:27 +0200
Message-ID: <CABcq3pEtW4j60n3jJgkSUDy=VbcfzAbS_4eYMHpEPR2bYU9aww@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
Ok, let me prepare a new patch v2, where I'll write a
description/analysis of the issue in the commit message.

On Thu, Feb 22, 2024 at 10:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > > When the Qemu launched with vhost but without tap vnet_hdr,
> > > vhost tries to copy vnet_hdr from socket iter with size 0
> > > to the page that may contain some trash.
> > > That trash can be interpreted as unpredictable values for
> > > vnet_hdr.
> > > That leads to dropping some packets and in some cases to
> > > stalling vhost routine when the vhost_net tries to process
> > > packets and fails in a loop.
> > >
> > > Qemu options:
> > >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> > >
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >  drivers/vhost/net.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index f2ed7167c848..57411ac2d08b 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> > >     hdr =3D buf;
> > >     gso =3D &hdr->gso;
> > >
> > > +   if (!sock_hlen)
> > > +           memset(buf, 0, pad);
> > > +
> > >     if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> > >         vhost16_to_cpu(vq, gso->csum_start) +
> > >         vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> >
> >
> > Hmm need to analyse it to make sure there are no cases where we leak
> > some data to guest here in case where sock_hlen is set ...
>
>
> Could you post this analysis pls?
>
> > > --
> > > 2.43.0
>

Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBB6BB3D
	for <virtualization@lists.linux.dev>; Thu,  8 Feb 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384909; cv=none; b=Qmt88ihXzmSjb75MKlKnQUTKYxWADpR5w81CuN+KGhuOwy9wAxNzePIzT7F2MT2lXftN2eVz64NCSPkeIIs6YBLauHHxnVyTQAoXGUB0v6rRk0RFJ8n3sGzNwB3RtSvbM2+w6bXesmMTf9IyrokgxceCusEPzbm3OPW3jqCRRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384909; c=relaxed/simple;
	bh=PL4bURsXss2T7/h04cdjZreNU22ZlKTVyPSJ+8zE40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBNIx8zVp+HwTL24HR1ZYyyJc7z+Hk5baaLkENy80/EwiIyrZjuBTilU7h9fIoqAKxlpHxu8k9KC1acGbx5UhAoj9I7bZZC3bCINJLPO+4HlIeNpleK+oAKtyggnv8lbQhlIZUEDmiegq9I1J42N1PB0y5XBubRtRx1X7FXKQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=cMbHCSfF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="cMbHCSfF"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5114fa38434so1783422e87.0
        for <virtualization@lists.linux.dev>; Thu, 08 Feb 2024 01:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707384906; x=1707989706; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o7bUDuGuu2YaKsxQ+9DhHSbmvO5ysjRunyhwVyAC5o=;
        b=cMbHCSfFh/A6k4HjaAsMZ0gO7//QU9IX5OjLHmyIthPKr6WnyReGIYXHbay/TWBR9J
         TuTlaiZrbdSHykW0ehuMU2m+VGJGlRir6j+YJP+nBcj3sN3MXrXQiMUxRpfZ0z1EbDTl
         T7EInYwGmNnUXzOWmh7KSguHVIUf3JZcppE6xFaKnA1sz5ZDeXQ5pdxwzISSqj4iwUHl
         F0PIOd2hVR2IeXke1DVWnNejNn/BwUE08O3d1+sY+zN70LqpUT0XHhXEwM+fdPEv5q+J
         gsvHXvBv//VSghwWXHvGCOXmYP5yvWVYraSUYC43KKzVS++KsS0s6mpkcILDgJ8cwHl3
         LeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384906; x=1707989706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o7bUDuGuu2YaKsxQ+9DhHSbmvO5ysjRunyhwVyAC5o=;
        b=d2EAf/v/U/oDaA8aDiFIrHH6+aRvVDZXkSAhukVrLobZwihbkXt08yWPeov8JV0fnM
         vnmy8R2AuyLzq0XaJLA4+CQzCLMWK1Ch8IZE7KyBRDq/hbrH1KZN6jPhTol9tmFk4Vf1
         3ArYkUFL6Ggdjdv4CdmOfadh6olpmdb7C9jhnKR8EAXJgulYDfXvMH2nGzmJCpgzahuD
         gY8yWHJWvqyqbFV6rwDLRpyV4KPI/Gqo9FeY/4kAcWOevCL3Bs4AkVJO43bQkY1ijXtq
         uXH2ZD0G6VfmFyobAGilj8vaAXJ9Ey58clYSlJMK76oZLof9mZ4ininAy1jtLWngaXna
         wzbA==
X-Gm-Message-State: AOJu0Yw23xZAshy3V7ushsZLofi1PndcW1qzLcqOMVKoFOgSkY+r2hUz
	K5gPkgCC28NUyaO8AW0LgpUxn+Z933g0ZjgvSHCUf6U0GcPn3qX9sOMBjvWM/YW/BNYF8GPruo/
	n6T0VO3mGe5TPa3ZDsdW3CVL++ON9k4yHtcILXA==
X-Google-Smtp-Source: AGHT+IEoQSQjo9erO6Il084RgQafaf4DUGfU2yCLEOnMeOlg/r958bA/YMsX95xq7vDLb2BC2YRvJwvjNWwiPA+eBhc=
X-Received: by 2002:a05:6512:3c88:b0:50d:f81e:6872 with SMTP id
 h8-20020a0565123c8800b0050df81e6872mr8479864lfv.10.1707384905935; Thu, 08 Feb
 2024 01:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com> <20240115172837-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240115172837-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 8 Feb 2024 11:34:53 +0200
Message-ID: <CAOEp5OfKUs+Q+Nq3YywYR=oihSw8Nr=jYSC6a7CN1MTMzJVtHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just polite ping

On Tue, Jan 16, 2024 at 12:32=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > When the Qemu launched with vhost but without tap vnet_hdr,
> > vhost tries to copy vnet_hdr from socket iter with size 0
> > to the page that may contain some trash.
> > That trash can be interpreted as unpredictable values for
> > vnet_hdr.
> > That leads to dropping some packets and in some cases to
> > stalling vhost routine when the vhost_net tries to process
> > packets and fails in a loop.
> >
> > Qemu options:
> >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/vhost/net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index f2ed7167c848..57411ac2d08b 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_vir=
tqueue *nvq,
> >       hdr =3D buf;
> >       gso =3D &hdr->gso;
> >
> > +     if (!sock_hlen)
> > +             memset(buf, 0, pad);
> > +
> >       if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> >           vhost16_to_cpu(vq, gso->csum_start) +
> >           vhost16_to_cpu(vq, gso->csum_offset) + 2 >
>
>
> Hmm need to analyse it to make sure there are no cases where we leak
> some data to guest here in case where sock_hlen is set ...
> > --
> > 2.43.0
>

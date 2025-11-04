Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DA334696
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274536; cv=none; b=kVP0AP6EYwZsCcBZIlCJKqFW3dob4PGUBc5FH600fM29PbMCpoTQJRWrMLY9uSWwczE/zMfHHlu1lR7Due2K9TAJUHFBPlQ9Gumb9eM7V1A5lWxU1r9I5IpFow8ApoQWObghDLpFfYD+iXCQsftvrwFjLWZdABlCT8/HNmH6oGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274536; c=relaxed/simple;
	bh=mo1b9l4bY6uG/Bg+NP+YlpbJo8eMD96kvJ+XbXF6mCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svTmle0zqLCkaYI61gzzr4BV9D4sxiXz1qKH1OGroaN6P+q2o2wgIBmSmD1KzOSWx60QHKxND7k0ADONpB5S8sfk+8smUIROv3KJ4A3jtIxuvnGYXEWjzHoB6Snczpd9I/0V4UMrc1Qsm6P1p/a1AokjU+0yoSgl96w/sxgaRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+nVKkoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+nVKkoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762274531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iz6G9rKDATEjuxgyrnRx8l5fumymzofPum53hGum0Bw=;
	b=Z+nVKkoCkY+4jOaluQ/1odZs1Vje0nDJ9BlC+I6PG1+MEeyD9dphJJLFoFCRUJgISVZ7PN
	nVxOd6VdCaRftc5u7cO8xg5tYcEkQjDcPUyuoB86Rr1Iya4sHJON21z1f6vu+Xo3StHYk4
	Ua4ds8nvVRqafSlX481b1InTW3vWgHQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-7AxLiqVSPy2DQtXbMuKrNg-1; Tue, 04 Nov 2025 11:42:10 -0500
X-MC-Unique: 7AxLiqVSPy2DQtXbMuKrNg-1
X-Mimecast-MFC-AGG-ID: 7AxLiqVSPy2DQtXbMuKrNg_1762274529
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b6d42c454c2so586169766b.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 08:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274529; x=1762879329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz6G9rKDATEjuxgyrnRx8l5fumymzofPum53hGum0Bw=;
        b=CSQYcI4k77mWTAvYYyYIKjwqt2nwrIVKnbnNwqFwlPIbbqG2z3mlwmkDgCZoQqKhST
         5xYCRj5JzhhpZYhbw0nbb8ogvhYTVNyzBCwcTuzaV2fiKkUKCBPYyxa7Ztwp8sT12ybo
         CbyRgetfQEbYt9GISpTtmpI3AHR6Qx4fmWxSfnEA0CedCLEjWxAB+mTcBONxMRV0NIvJ
         IJM5lG9vw1RJCXx/CxUO+krHTNNDmNt88TImNk4I3RW+SlSo7gTrF/lyIz2gwmuPjSZx
         CWRD1YdHT/Aj6UHXb+QwvDMwUjeKOFiZ5MxO4tYRbz8yus5p/+gOPYy0PeQOy/6vxZe0
         Rqbw==
X-Forwarded-Encrypted: i=1; AJvYcCXI8wVRIb/NGfqkxv6U94x9TYb5LmDjKQ2Io1ZbzUbudYm6/OoYs28NOYq+JyQITZesqnkDnXNT4ki2jADLsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVQBjQjWN3bgSyOXMm6KLKk/WDxMcQmnG2dIe78lNEM70yFiRI
	l6gDX8D+m8U7ft81W+DS5VMgvpMzKV9Nj0pk6S5YWz5HH2xauKt1JdZLDNZ/x745EB+L+whoz7t
	jrspD3QrdqmFr4QE6Uqnj02uOS6QRWSYi9sh9PgigcFXrp2aRvZrgOYXN09aElmeVG5DlM7JWei
	zeugNybcBEErQM6nYJmfr+1S5z2pd2rUIIcmlsDaRyDgQ=
X-Gm-Gg: ASbGnctGBoEOfxJpEYad4kiWaHW3z6ojVheLlIT3EXFMDUrgp4vmsuRyPCwJHF6EnAT
	o7ea2CFb2B1A3iZr+kBcI3bR5NmuHA8AtB1m+BE6QqtK0VdP+cJA/EE7NakcXze7qfWJA9FBs1C
	6ZU1F/auE2SifGkoTTFZ6xoseE5121LFy2UtpkJ2gOwFTcrmEHd5psVTQc
X-Received: by 2002:a17:907:a45:b0:b6d:6026:58da with SMTP id a640c23a62f3a-b70704c3da9mr1767561366b.34.1762274529057;
        Tue, 04 Nov 2025 08:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0vPTxs1SeWugV7im7EcI5VaBj9++S0r/jr40HykURiiY/bmOyrm8AGx0cUEymhUuvAEaV34kFForbL9L24ac=
X-Received: by 2002:a17:907:a45:b0:b6d:6026:58da with SMTP id
 a640c23a62f3a-b70704c3da9mr1767558866b.34.1762274528715; Tue, 04 Nov 2025
 08:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251028152856.1554948-1-nhudson@akamai.com> <881d2462-895c-4ee6-a530-957a8dbac072@lunn.ch>
In-Reply-To: <881d2462-895c-4ee6-a530-957a8dbac072@lunn.ch>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 00:41:31 +0800
X-Gm-Features: AWmQ_bnmCkT7IJlhGjvwSkQoWY9AS8Yu1GUbwnZJ0xPFuRrPC-rjjG0NUx8Xc98
Message-ID: <CAPpAL=yN9QLc2svWrtWutvjzXOCgKWLc9smh9RNPS1=hK_Ug8Q@mail.gmail.com>
Subject: Re: [PATCH v2] vhost: add a new ioctl VHOST_GET_VRING_WORKER_INFO and
 use in net.c
To: Nick Hudson <nhudson@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Max Tottenham <mtottenh@akamai.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YUML4Lj_7HlJVJyzWFZxs_a_O_nOFHd-tNlW4G14tvk_1762274529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Oct 29, 2025 at 5:14=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 28, 2025 at 03:28:54PM +0000, Nick Hudson wrote:
> > The vhost_net (and vhost_sock) drivers create worker tasks to handle
> > the virtual queues. Provide a new ioctl VHOST_GET_VRING_WORKER_INFO tha=
t
> > can be used to determine the PID of these tasks so that, for example,
> > they can be pinned to specific CPU(s).
>
> Could you add something about the lifetime of the PID. How do you know
> the PID still belongs to the worker by the time you come to use it?
>
>         Andrew
>


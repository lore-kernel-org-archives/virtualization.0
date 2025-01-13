Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563515687C
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748231; cv=none; b=P5zfxD9csqPVx9q/vQdi+dz+/ItslDQJl3M43EyFRMVV/WMy7Pu5421w09Rm2WSviaTYISi3/CayiZ6ROu2osS4AAXVMqQZePyMxHWnc0+UxY9p7eBzPxOfioDHKZH/30OOWXQLrq8MCCzSeQmyy8Gbcjeo4lXE2H8fsfwfjk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748231; c=relaxed/simple;
	bh=Jx8UqfzIjWLE/l5vEYoWQiykUMtbF2Xs+fqRm8C2jnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elBcfweb+HRhnyvfS7yC/QUnW05/Q/j74wXub3rMvREtOKlW7mzAqMnYQtRfJx9zv8Xxn/VY9lhjSLN5JJ4doyfvNtWOXYEtwhY4dLyZ71mYNub51cnRj2FbhBBX4ns5ajne43BeNe+H0Asi72ehkruqWv6z5Iwn52jW887YFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNzx/m9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNzx/m9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736748228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRfvoZSq59xDgIbjE3MXjh3C8swGNv8nTHTENTK3KGs=;
	b=aNzx/m9dc4wE07N5ecDpAphuIzTXPJVUnKXDLXBa/xhdikbLnSQE2FtBH999IwEGRjfmuh
	1xAo/THiiVmgn0Uw6MxMY4yaTPLq10ekkGJPiCeN0u1dSqXaHYValhf/8DOEbJttiZojcR
	HaIHchZyEdXRInaE/q2eu537WapQBI0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-WEjuStRkMeCWQxJrPhpRXA-1; Mon, 13 Jan 2025 01:03:46 -0500
X-MC-Unique: WEjuStRkMeCWQxJrPhpRXA-1
X-Mimecast-MFC-AGG-ID: WEjuStRkMeCWQxJrPhpRXA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a999so3722578a12.0
        for <virtualization@lists.linux.dev>; Sun, 12 Jan 2025 22:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736748226; x=1737353026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRfvoZSq59xDgIbjE3MXjh3C8swGNv8nTHTENTK3KGs=;
        b=cm7qqvLs12L0K/XqDziwHE/OGQRKjs/ky7FicqXNK3VlWTPtrcKGKh9gHLawepAvp3
         zBWiVwuUTgTw135JJQoYSoIO9zOoBE37irem/8miTgh+HVgXGyjFj5K4gkIWE1pkFMe+
         cOJXGKTD9a9xVJxpKWz6QWo4TvW0VbZGsn3HHY5a8DfmHTlL0HSYC7al/2JEXVkpMFB2
         2xB3Q5PEtNS7EAMOR9Gi5K3kScP+ce5jqVK0sUrbKfS3wzOU7/iR7xMJWkeDOOiYvogV
         0Ju4KYlXcJJsbg4j3LPFthSK5Xgtir79Al3lEAGnYdO/d3UCjJjFdDkJoAExqIL1F8zQ
         zXGg==
X-Forwarded-Encrypted: i=1; AJvYcCWYPDHbBGBBHn015hYQFXYOh+6wHDLg2xUyczvIukAYS40MJ3GwSn/Ef34tH/RZrNo6UKDqV+0vPbzCdLblGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjZeJPtEXv/MvKUlWiP69NcCeA+m0/7B5+K0vSziOAOEGAk/NV
	7KxZDIb5K1znYvGzzPWHz//1jJbU0nQfct4ejQ5ryxstGaRBTZn2dG5MjynnuwM7esnA/szyU3c
	3ZaD0zeFVidAX3wwT0/Bcwj7e3zA60kGP7DOGBJ5I0Jk4P83y8SOxEXqBrlnW62cfuk1x7KnIon
	Mrxt97jzO/Y7XD6/H40A4tK3I8BaYbvcnbWv4gb/Q=
X-Gm-Gg: ASbGncuytwaiRH3x/6cs3sn7csTBrD/T/FtPeT8PwRC81koT+7JqsLjZodlldb4UoQ4
	iYf+7cm/lb2b7X7cHJALer4XLpU9pjM/6nds8s8c=
X-Received: by 2002:a05:6402:274d:b0:5d0:e50b:899e with SMTP id 4fb4d7f45d1cf-5d972dfb400mr17355048a12.4.1736748225651;
        Sun, 12 Jan 2025 22:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpXP2UdK5u/lOnf8j8kk81BB8Xh2L/TCeQINOuQMpxzWoGcGTx1RD12iNsQmVoUUuFtpxXcO58VNsKCybQiKQ=
X-Received: by 2002:a05:6402:274d:b0:5d0:e50b:899e with SMTP id
 4fb4d7f45d1cf-5d972dfb400mr17355011a12.4.1736748225218; Sun, 12 Jan 2025
 22:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250110202605.429475-1-jdamato@fastly.com>
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 13 Jan 2025 14:03:08 +0800
X-Gm-Features: AbW1kvba2fNdUGVp7gFxi1Bq2_NuWMOr_1YCCnaur_kbyMnys2wQSdgaX54y0uM
Message-ID: <CAPpAL=zaZ+7judG424sEmndE2UxEFA0ZdcEB7tB1A3PcGw5n9A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] virtio_net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yZkYwSRwVObljFJb47vh2sVhkx0e50UYxoQh6DjyjO8_1736748226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sat, Jan 11, 2025 at 4:26=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> Recently [1], Jakub mentioned that there were a few drivers that are not
> yet mapping queues to NAPIs.
>
> While I don't have any of the other hardware mentioned, I do happen to
> have a virtio_net laying around ;)
>
> I've attempted to link queues to NAPIs, taking care to hold RTNL when it
> seemed that the path was not already holding it.
>
> Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
> As such, I've left the TX NAPIs unset (as opposed to setting them to 0).
>
> See the commit message of patch 3 for example out to see what I mean.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/
>
> Joe Damato (3):
>   virtio_net: Prepare for NAPI to queue mapping
>   virtio_net: Hold RTNL for NAPI to queue mapping
>   virtio_net: Map NAPIs to queues
>
>  drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
>
> base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
> --
> 2.25.1
>
>


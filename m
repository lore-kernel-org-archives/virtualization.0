Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0752325494
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355289; cv=none; b=IEDliGEZH3Chz08ojft/mqAYKiJOk1eadFhW1qArsxOXiBfCYjNLVtL3mxB6juDcGloyGo1UnJdZOsiaZDhUrz8nhBhjKwygqtdfvVuJPwp9sTF1H6JrBeirRZ4ghPrbUxdjjBEJT/dAAU+Okt1092yj1p2xgwa+vYve1fqNQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355289; c=relaxed/simple;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDYdwi0BGr3Xh6uVR17LO8IVpSIhTr32KbHdiaR0NuD3ANEpz58zofZA6B47Sez6XbyS5mmEaqZP2iV0mgYh2KalGk28LZFULeqayKHTYbE4lsJhDz1LB7BmH2xDkWiO0Ci2A+lJEmGtIK/t58XiM6UaMQWe0T/PN1pZzoZAAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibr5ouUD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibr5ouUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762355286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	b=ibr5ouUDPitVjgdtW7Bs7JNSGQ1+r/I0Dr1MZwCja75xmaxjBEdWUYX4xfteYY7WBPh6RF
	NQig0iVCXUctd2fLPNfIE9drCpjwgQS9qEaxxfpvh/otVlQHGmZz0izWwaKUAoJaBsm+Gg
	Pyft/hLogULP1UNzYLeG+7EwfkNs2GQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-jFDdd-JjOv2ukUgg9quTbg-1; Wed, 05 Nov 2025 10:08:03 -0500
X-MC-Unique: jFDdd-JjOv2ukUgg9quTbg-1
X-Mimecast-MFC-AGG-ID: jFDdd-JjOv2ukUgg9quTbg_1762355282
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2ef8e0133fso975476866b.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 07:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355282; x=1762960082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=KTfsKv7ky5NLE7uU2Q9K4Z5wnqgfxQzrUmIDstQHaGWhtZWKuru7CMBHGi07I+Usyg
         aXpLcDMOP0rWKWUGZeAioxWezhbTOSofpyl17kofogqqxA57akl1khIWjNfYXo4x8Zcg
         0AqOJ+fI0aIq5+An6cK4zCf8EINY9uWzvqVIkfIEouSdMjT0tbKWNNaouI/XnOCMx3vP
         Ow1K8a8Wdd2B0jwna4ZFVNi6nFEb1KlB7IiQUujjEG9LIwGErbTu/bNu7tizDPZvOV6m
         J0J19jJ9CAoLWXr9OVUTs7iugwdo5Q4m6EBmO9safbFSL88t6MKggEaDtfdFW3jwgGen
         1B8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUybOH1uIX1xzgzx2RRwoktN6H6SCMrERDgPY7Dotahfkcng75OEu+9dCPlyXM0hEF07LNrQe87NzJMFD8pVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsLT8XM+ksopXdBK+RxZzyAVQBd1PhWINeWvuWuEDIEmCwRWr5
	RimBPNZmlhCi0Az/k9tPfoqPsZJLWtO4RKL2Djtzoe0RuKzumnk/TzhxHhIQz0CV+rjj6tyJzTd
	g+wAjwKtGv2rptlfpls8LgWD0QctbHuq6Ij7Q7nPHWUGHWY/GNcvsyMfTCBF3JWkTHKANogESQl
	SQjiYUOHHLC4WzQLrU1brEkzRqxT6lW9hqV8SOAUlDehs=
X-Gm-Gg: ASbGncuOCks5IzSXRaI8a4UR37MuoYD6ugQ7m9aVVzTDTHg7sPcg07FV03kK5LjDdBK
	hm8lUsAjK7+YZByKjsfL78C9Acm6XSZOPpWjft1d4RdkZXoWYzp3ixOTb/HwKCJbaxfEYjlg6ph
	JL8Sm9AdDzSvVmj6RjDea8iSevcAjEmMBi4zdc5D4I8nWEsvOpMSD24+fP
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id a640c23a62f3a-b7265568be1mr330078366b.50.1762355282291;
        Wed, 05 Nov 2025 07:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOQsjYVyVVrNvkq8akL5ZkGRlDA5wjcsUyQMOyzqYmrxUAS+dfw/oU0IlQDgyfAtyrlbYChyW3M7kMF0tLDI=
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id
 a640c23a62f3a-b7265568be1mr330075866b.50.1762355281900; Wed, 05 Nov 2025
 07:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
 <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 23:07:25 +0800
X-Gm-Features: AWmQ_bn6PCV_WZmKEJ3xHMkBMOhvHDcRetwwHLmBCefOcZy0CYLo96d-gGmw7e8
Message-ID: <CAPpAL=xDpqCT9M6AWHTfNuai=3ih-452sW4g43gduiw7TptToQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OdteRCDEqCh2BX1A2piAPRizEg3SlrLozd6V9-PVX0E_1762355282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Lei,
>
> On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wro=
te:
> >
> > Tested this patch with virtio-net regression tests, everything works fi=
ne.
>
Hi Jason

> I saw you mentioned various tests on virtio_net multiple times. Could
> you share your tools with me, I wonder? AFAIK, the stability of such
> benchmarks is not usually static, so I'm interested.

My test cases are based on an internal test framework, so I can not
share it with you. Thank you for your understanding :). But I think I
can share with you my usual test scenarios: ping, file transfer
stress, netperf stress, migrate, hotplug/unplug as regression tests.

Thanks
Lei
>
> Thanks,
> Jason
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7054654
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628391; cv=none; b=ruD+mB9KevfDl/tr6AeRVCsVZrCirqiHPGX/OtdX6b8JZukCG57KYuKKiB+QjFOWKwfZQ7oVV5KQc6bRiXT/L2wNsmNf38+8cmEr+fKSAJ+hLC9aH0MzGNVNgsMZt7ajgJ5EcpAS4SFwp+2quTkWC+imSNKUHS6qD1UbV6Cv1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628391; c=relaxed/simple;
	bh=BKWyQDlgpduqK70y5bsJ48SQyWbfCqQEOJF0Pjbu2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imUpDF4RD9vXFO/s3kJVe9d2/wPICEgcc/MwCPRISV7OVoak8IwFOhbrfno4buSAV+d1cqdSANKgR9Fv3vGIo5CiNRQSjkeUaGRGkIsWx1fUgpeRVeJaj7SLr7KkvzsCbJbXBvig4dfiStA+zj4Duy7yQyRG1/LengJI9UhLKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQTX9yTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQTX9yTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752628388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
	b=jQTX9yTBfriMp8K91jFO7/OZravKDjCnq5yLcEG0qMOnqf419WKWdKjt4nDJ9s2pfrv9yu
	7bxX8XUopEsd1m00QbxYf281lkdwXv5Wg3/phvImqJoB/nn0cP/aGKywZwOR0Oyu4+rY+0
	OkSPQOrE5xZsCiDdgZkI/tiUDyslIkk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-V4zAik-wPR-9q_zMLNK3tg-1; Tue, 15 Jul 2025 21:13:07 -0400
X-MC-Unique: V4zAik-wPR-9q_zMLNK3tg-1
X-Mimecast-MFC-AGG-ID: V4zAik-wPR-9q_zMLNK3tg_1752628386
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c4d140b4bso5050984a12.2
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 18:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752628386; x=1753233186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
        b=gxPzOEA0rzFzQdbbAAXpzRg3H2LycCsGc9eaWoGszzroO9h9R2N62auLQlfRAt5VvA
         f4LE5I9K1UbdfA7fwRfyaBcwzeCXEglQBR4NjnnYLxRdOPmgoWyPeSV14ESLmNHdWcDB
         nER1mNAhjAUurQF9LVkGC5gS6JeJJxPnhaEZuHhbIqQYRSCSLvzUq43G0+sqhRQB0MHk
         drJ8Y0BfeL42tgcessUDZezT3vQEJFMA84eYfgQ3hbQ61fBTqFM7ilPusRT8YM+OUALb
         Nbu5mv9np4KZi6fgVoynmOWNpB5GxTgiZ7BdBVRPVZTzDOeWtCZGbI0BTqlj31haaHSN
         WfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZmmGTUDjGn+l1W3z+8gBj3TUA1oFoUCg6DHQ5zGtoS8jDgjc0WzA2EHVZ+5i+d/zpPYnmHBtAQcofZMN3gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwITycd5ppky8Kc03BGSjefS0wxbZQz9qJOq+iFOrSQXiXJ+NkO
	UXJfm0oSSTcM1kR/KUHGkRCTlp20XMYxIb+PNbmW9cp+WY6YOlHmjxBm7IunIJWs6EfSp73hwJM
	DRXrI15wmi646ZNPmh1/EAB244olUrNctjl9hi3duoNF/q8GTqg93a9PYAtxnwfb2pEZvkLfzqx
	q61QLMiBpqDYqfCsOmA+aS22KJqw89cyUIajWTCjjz9eE=
X-Gm-Gg: ASbGnctKbCh+H3iobjV5DSrpenwSLkK5+ev4cF5j75Q1vrS5ZpJCqHIE8Fmg6CIkK0S
	PpC583E/mU2MuJPBbc86pLhxREAub4M89sIwzb+HcbMGl1NnNoUF+P+6wRK4sURqmSvpFbkj+Qf
	j/tA5Hc7RFxJWS6xIhG4JFlg==
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae9c9b6c4f7mr138675066b.57.1752628386133;
        Tue, 15 Jul 2025 18:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD3HiOIYDUW7hX6g4mjiRwOrmAALXXgw8/ypx88cvn2L6gXAwS9h7hC+qro3T7N25vt1Mq+1Ot39s20uVR1Y=
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id
 a640c23a62f3a-ae9c9b6c4f7mr138673666b.57.1752628385746; Tue, 15 Jul 2025
 18:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com>
In-Reply-To: <20250714084755.11921-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 16 Jul 2025 09:12:27 +0800
X-Gm-Features: Ac12FXzEZyLhkQ-ZlRuaRJizHbPzC5U2b0INYQwKCqtanE6LNjchFHQweOloptQ
Message-ID: <CAPpAL=zo2nom7=nL6y8g5N+7qR3oG+bVip1KFxCnJCu9V-M8nA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LhyPiPGNbU16CE8uP8Prmb3s9l0p9ixgyzSNCIg0CEM_1752628386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v2 with "virtio-net-pci,..,in_order=3Don",
regression tests pass.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 4:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all,
>
> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> feature is designed to improve the performance of the virtio ring by
> optimizing descriptor processing.
>
> Benchmarks show a notable improvement. Please see patch 3 for details.
>
> Changes since V1:
> - add a new patch to fail early when vhost_add_used() fails
> - drop unused parameters of vhost_add_used_ooo()
> - conisty nheads for vhost_add_used_in_order()
> - typo fixes and other tweaks
>
> Thanks
>
> Jason Wang (3):
>   vhost: fail early when __vhost_add_used() fails
>   vhost: basic in order support
>   vhost_net: basic in_order support
>
>  drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
>  drivers/vhost/vhost.c | 123 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vhost.h |   8 ++-
>  3 files changed, 171 insertions(+), 48 deletions(-)
>
> --
> 2.39.5
>
>


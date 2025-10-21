Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386ED515
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018742; cv=none; b=ZZO7jYTD7DNbtgm+UssjUHbbDNOen7loQBsvBU/2fpUmovOWrIXjTJFaUkAwc3ck+eHz0jwvDC507Q2DpL7fsDgilyzdDEE5Jprwf+X3jTw9Q52b8W5IpUtVPczENgrxvLsHnIjZ4huWEulXbUh8ZB1KBsOa2xzhJaWoxd1zTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018742; c=relaxed/simple;
	bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiCSMTwy8wEZ4C1NZCsJKBN+PYAh3itrhZox6uNLvFvVt9dcYgMpNobBypQcVy+nVrHcT1OfQHN5OfRkvwtj+NO16KEOQlB3hvFgw11cWkHNukD0Xwu2wyjrrjJHVOuU+C5329YTS8AQ+x0edA47ZmOo7fUSpgQM/5NRJLqsPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5FwZXNm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5FwZXNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
	b=a5FwZXNmvuSwfo8Y8g5soTxRpXyA9Aekv4yeyq02gW9FKU+JWYNBD4WJO6C/znVyrxpxX2
	+xAt76XxEU2hBQ9w9Dot09WmYkyFOSO3zU8s82MLQz5cyT2QdNjccatrHz49CPkp2vHeZL
	Md85O4Rn/u4uTvHIr+IMUBN9fqMMQUI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-EqFMV-RDMZ-5djlsCXjMXQ-1; Mon, 20 Oct 2025 23:52:19 -0400
X-MC-Unique: EqFMV-RDMZ-5djlsCXjMXQ-1
X-Mimecast-MFC-AGG-ID: EqFMV-RDMZ-5djlsCXjMXQ_1761018738
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6a793619b2so1621686a12.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018738; x=1761623538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
        b=Ms/Nq+WWERpXDFhMCCS805yOKLIvjNtqixecC+xEMR8uHymHVTHt8kTwsIPGXSoyOq
         PjEMZ+BWCQnY8rpz+JY8Hrt9HGouwJ4oSH6BZBwVuJa6Oa+/9gu4Jazggc5oqg3vJt+e
         qLqtHOaDBeb0ddkUSk/Qi71UXYTaqVpUsi5EfxEuA9KPmomGhNhxQEA3hk8QPEPODP3Q
         E4vlnWa7rcQzFMgxSknOwbrB/+CXSMDFzrLCxOwc+3EGl8/k7FpRidfVMMDXjeAO9HQK
         G7ZWxzph3t/K9vljdDdo92jx3GztRuc0rbW9aAj1rN7fgFZGUPrULJ3fyuE3qVQz4jHB
         S8uA==
X-Forwarded-Encrypted: i=1; AJvYcCVAc0id+wOywr/5STcipOCGmG/vOHekDsXGeqQAAQnng0EU34eExvQGeo0lyvCoYOX1hIFewUXU/rmqzGkBVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNE6goB4qyerGcKKQje5+F6QxK1KWwM5o07XYgKAmTvZC/eW1p
	xTeLXuu2cn6/vzzvwIwc/XuPynO3OWE6Q5ne8gRGVP97AWDUVOl209wAF//cW3cs6HmP5MEXXVV
	tE8b389hw8Bhe8hC+6CnAtDMou6k+TwCqoHejjrg6zLP157P4w6f3rY5beFG5dCCNXJVrOryqPh
	VBkzDfCwYpbRMNhVkDbZ/Byts6AZekTYSM5h3lIKeYpMUhk7yNTvFRUA==
X-Gm-Gg: ASbGnctyqCZbGCUfUIwDo39cd5KJd+0jZRq+8JxDG2bzm2lobT5kBsn8zQ5Oi3OyfNr
	1GD/y9p9+1+EvAe+B+K4HtdpdB2tH8MVKcvs6m9wXzueh3StHLpMVsrNHTAVN0XYb+ANMoEvULz
	NnqWrnC8shXJtQSg25nJ8mYKP1/DkpN5mQnqBx7J8iHzodRIvTdYyPVmM+
X-Received: by 2002:a17:902:d588:b0:290:d4d4:212f with SMTP id d9443c01a7336-290d4d42213mr162169485ad.22.1761018737916;
        Mon, 20 Oct 2025 20:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBB/PdvbziwlczPPyCYr7kdKsMuEgc5kO5aFnH0SuRpY6ZXhjmD7d3u1YgdwWaIXJHHU8PINDbSLTyZpI1mPQ=
X-Received: by 2002:a17:902:d588:b0:290:d4d4:212f with SMTP id
 d9443c01a7336-290d4d42213mr162169335ad.22.1761018737567; Mon, 20 Oct 2025
 20:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-14-jasowang@redhat.com>
 <20251020111938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020111938-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:52:06 +0800
X-Gm-Features: AS18NWB-g5Vdvff9aJwtHaMfAhyHzMhdHIZZitkZLVIiwHSy8PIubnL7FbKzkgw
Message-ID: <CACGkMEuZK9nr_gnkMvNti2BMt+ZPKtSpJwqoA1wPZdMDp-4=pg@mail.gmail.com>
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QbKLRWUuBG2lwBHdShDKBQk69UReYbMwQvnbz-KFJOw_1761018738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
>
> a set of callbacks
>
>

Fixed.

Thanks


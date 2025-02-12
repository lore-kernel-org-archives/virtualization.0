Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2220E70B
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370558; cv=none; b=XKw8NBlxKH8nwAralHO4OCVOJJIgAyAS66sgN/BT7n7CO1vAYu/wwdYInyxHCyjeKOCDydbxOlorJW9cVhRxiUEwJ0BUsRQlfWbLY+Q14Kb4RJBfFDrLf5p5FHh7hkw++PW4gOtaNaPGVc2vacPGD0IKt2orjJydDBhhBgCY5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370558; c=relaxed/simple;
	bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv1e7053uDTRaH94hjJm/Cn7VT3vYyOQF4Kq319H7BMBTsZfXuQAuB7dEmkk4hv7H1aYkozbavGTV7Mj5OFCZ0wUkUec8Ncq1Y7Ih5QplppvkF5TzkS6h6T4yD4mKHU3xgpmaN45oEiWQuiAQqFs7z6xqWiYhz7bg91uryA1fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/FGpSKB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/FGpSKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739370555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
	b=B/FGpSKBjTvKvhXpsdIcpeUHumO0tmZO8M7KLfkzgfNeLujL5qsvFaRlEOYO5CxDaKAyi6
	l61flJaNqX4P50ts1TtEPdxWNYKCKOIm498gUaGaxdaH095HrUEhQHhU9OUMJluDHFE4RH
	7/nIlw+ViNK6lDC5y63NbpDDaHObqRY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-hDYHPfRbN_aMt23jeWwCoA-1; Wed, 12 Feb 2025 09:29:14 -0500
X-MC-Unique: hDYHPfRbN_aMt23jeWwCoA-1
X-Mimecast-MFC-AGG-ID: hDYHPfRbN_aMt23jeWwCoA_1739370553
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab78d23202cso443729466b.3
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 06:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370553; x=1739975353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
        b=ODZn2KLZtuScEY9zJ3xbrh6MzYG4sOZKqyaTrLHkUFpnznohbSkCbWPuTFZIngXm1m
         RYeFQziO1grkv+AgCESBAEKAakqHjvVteX1Thrj9P3qoeSgxLTCcNwnkF6YxP+MfN4NE
         9xLAiW1Z6o5+i+VFK4RkdIb8KipUbO4RBNHoG88/H2CFvUzF09aeY4fV1W4xCQMo2LbI
         HG42tm4btAitDtncn8o2TAJQsFeTe3JZ1Ko+kxVwrRr6xXfx5rCT+GBBQ4SobnW+qgUk
         RAGwSO/zD1mGjQsKw4W7PxBt3N7TtaCmKxjNItVwGxJ8lIt+Cg8RdAXXMJAOLtwNPODN
         bZEg==
X-Forwarded-Encrypted: i=1; AJvYcCW8crV0TVWWdU01hFaoBnwOlRBN9rvqqsTWq1C4WoPrrOIffnlhEOrTq6p3TnCHCaXJYEEqRrYzCFk/hikwvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLDTc0ZQN3oGJgyEVacmPmjiqcC2DPvsNoW/AORxd7eYsS8bP5
	ClVz6u8cU9q+8upyY7ar/AHSiyTAJABYGSU6UAC7bA68KHSEBW/idAjQ5yCkDh+y+7FB3nVBZxg
	wV1ksEC9UGG9sL9Ek9GhUHNRsk6QboZ8+5En2zFIsi93s3V6Gvq1UAlbBxJ3HmaX+LHFIuNuJXD
	7mP+4sMl3lRmjhHlibo9Vnu9n2wOvVwZyR1kQnNkg=
X-Gm-Gg: ASbGncsghulKf32DKszH+bX6S36Rbqw7sBrcG2Z8weLI+WoRteSZRc0RdOEoHvOOtX+
	fiZiJr5IUfE+Lm8kKn/lwmLvVZOToAXbnO9LbuB5826ywSnpoYdzXVpXntKcolrbmmGaVf+begf
	ISvmAsh0DECRVML57N2A==
X-Received: by 2002:a05:6402:3510:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5deadd71ae6mr7994593a12.7.1739370552928;
        Wed, 12 Feb 2025 06:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFODMyc0mg69LtDY6AULrP8h8emzE8pmqlTP7h4KHBaL4p+FpoBPUfEFgNkycdGMlVSlAMSgfgepus94exDBMg=
X-Received: by 2002:a05:6402:3510:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5deadd71ae6mr7994548a12.7.1739370552594; Wed, 12 Feb 2025
 06:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250206104300.416014-1-ryasuoka@redhat.com> <d8a453e9-c8ce-4a7d-8fb9-08a13c44d7f3@collabora.com>
 <3c0e06d4-b5b7-45cf-bc42-8f12b293b7da@redhat.com>
In-Reply-To: <3c0e06d4-b5b7-45cf-bc42-8f12b293b7da@redhat.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Wed, 12 Feb 2025 23:29:00 +0900
X-Gm-Features: AWEUYZlZPWJuA_vK95ztJ7A8EkKN1A4KF5b4RIqvSAABBcmQQ3uMF8dJqmXE2rg
Message-ID: <CAHpthZqYGwXCqZYSXgrbZ8AT58kXS+qm8LRE=SWkrQvgx9CUHw@mail.gmail.com>
Subject: Re: [PATCH v7] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Jocelyn Falempe <jfalempe@redhat.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, daniel@ffwll.ch, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yrcCuQF-EwBZjMsoebZIX7ubwO0JH6up_tHJ0H0TLr0_1739370553
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:14=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> On 09/02/2025 18:45, Dmitry Osipenko wrote:
> > On 2/6/25 13:42, Ryosuke Yasuoka wrote:
> >> Virtio gpu supports the drm_panic module, which displays a message to
> >> the screen when a kernel panic occurs. It is supported where it has
> >> vmapped shmem BO.
> >>
> >> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> >> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> >> ---
> >
> > Applied to misc-next, thanks!
> >
> > I've tested v7 with a different capsets, works well. For a non-VT FB th=
e
> > vmap indeed will be needed. Looking forward to the atomic vmap support.
> > The rough idea of the atomic vmap helper is to make vmap code paths fai=
l
> > whenever hitting path that needs to sleep. Likely will be easy to imple=
ment.
> >
>
> Thanks for your support.
>
> I will see if we can do something for atomic vmap support for shmem.
>
> Best regards,
>
> --
>
> Jocelyn
>

Thank you for your kind support.
I'll try to write the atomic vmap support patch soon.

Best regards,
Ryosuke


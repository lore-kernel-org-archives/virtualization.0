Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1C2EAB66
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161661; cv=none; b=sRYd8mPmmI6PP4BKebIlvhzMHuE8JxDV4Ey+I6YXTJaXXLqovDOnqTZJLsp4Zcrss0at4/mwshmg5o34lRmurus7qNldQve47C5tFoQfnyv3NuzxSJ5YD9J3iCFkO21gWrN+FrcfWhl9vvKbkSmX+m+y/wArihXyD70cddLLrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161661; c=relaxed/simple;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgxeChLG7QiReFJPOdtSkb/IIpooqo0LhLCy4s6LSbAEHPHlgxwZ1iKQoC80Oy7zwGkJoAaXmRwaaPyYJZiz6jLtRHkO4sp7g5dysy0bnEVTg1fcrM+0BYH41INiMpff64pgTDgX6fcRYp802fqZw40Exp4pbwAb0t5ccPPhJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfN+ag3p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfN+ag3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759161659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	b=JfN+ag3pNuXQwhIKsJ2eOHLF1Qtb5wwK6bFHSSwv1V+2Y5NTbhSaEniITycAuopVKeEYzT
	frLrEZ4WpgAanJxm/l20pvhLJ9bHJjQG9x50RdTqZRryK6KoIv3n9Kyiq0Lj2qoHaTTk6w
	aFAb5z55wWnzWY5az4ECLhrHaWgxnuY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-lo9YJ9OdNnmCYFfRikkLkw-1; Mon, 29 Sep 2025 12:00:57 -0400
X-MC-Unique: lo9YJ9OdNnmCYFfRikkLkw-1
X-Mimecast-MFC-AGG-ID: lo9YJ9OdNnmCYFfRikkLkw_1759161656
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2e6b2bb443so510030866b.2
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 09:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161656; x=1759766456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
        b=offJcQaI96znWOWg3wBp9xV9vE+EEctQZgL4zqHVu4GXBo7TCYK+d11p3/lLsVgrn6
         94gY+X0MfiQKgrDqJebHQBS+vaajl+2NqIIwudEHB/NM9QpAccczf75NC0BLa7BJncxz
         l1RLh9f+XcRKNdcZ7mmY72Ac7v+GECST6ebkgxQTkw0xkawJljn4HoE4xRDgiMGXPfMq
         o7JGDIHBsoaDE7uVLzbwe5gd+hCCvqqpcxzCj6ZNqVkoBw1Yzefo3Ztkl/yNGaQk8Rrm
         27/l18+0PnmWhkwAKjDoz/1FXnPK98TcToiSkbzlGmxjtZPQd/Ujdlq0b3bYMTfGK5nd
         4h7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbNKLVdGyw9NwPxgJLpFc3ATKWkeITP+Jbe8NpsWchpT6EXGbEx+bts+L4dtN60zIrhaN0Hzqjec8+VUjWbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx26Y0NuWBerxAeuNKueR4uaWmM6m3H/nz/eU0GlXS853A+IHLQ
	LcXp9gjvNlO2SfMzlpDzxXjIWTASXiVg/RvttzDrw020FTkz5BP6wZjLHCvHKgpl7NECs0078RG
	1u5iwbXmte/dAENT6NZ/adYOPNWMC6wmzUJdVRAim1+ip1+mla2DB7jo5cMneafp6Tn+4Yc9vpR
	BafBnxWS6+w4O8b3bQg5wuH4zJu22zeaLNg9ul3L37o0Y=
X-Gm-Gg: ASbGncuuS6gdrjRepb/h+JSKEOmkb0eAX75e1uCY2vyB0julqRWzlIuI1iT/CHX9ZDy
	JIDyDKUR6NiaSPdLhOsxmEv6edS+VPQ3XLnOoXn8H9ZP/KKyqjJ8jC9tY18dityNhgfy8sTAE9z
	OjuoLyvENwQ5y44emT7hib4g==
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id a640c23a62f3a-b3bd781ba71mr843425266b.41.1759161655718;
        Mon, 29 Sep 2025 09:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6hzu6lwEjjnhGnHFD8M9ofM8ojrlvCKKGBmnqXaS/KCPAQ0khSQKd+hnPIMyAHKH3zg+/WlTMjm+XtQu+5y0=
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id
 a640c23a62f3a-b3bd781ba71mr843420566b.41.1759161655326; Mon, 29 Sep 2025
 09:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
 <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
In-Reply-To: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 30 Sep 2025 00:00:18 +0800
X-Gm-Features: AS18NWC2orrPAiafpnWLj0PiUo6H6ktFe9pH1En2rWhE1VkgRlQKrFKPhSd3Jgc
Message-ID: <CAPpAL=z9GZKTDETJVEpq1aop8q1Rgn7VaXbV_S4_y-nsVfzpxQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	zhang jiao <zhangjiao2@cmss.chinamobile.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YeQ-Jt-kazsqehptkKKDbTUKJMmK01mAOuz6hdOWfxE_1759161656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 24, 2025 at 8:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> >
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss=
.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> >
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


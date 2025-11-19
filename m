Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752742D0C63
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520724; cv=none; b=XYCBtuv1PogDKSmEpYL0ap3bX3qjaiS3z6KzPCYJaHuFiGhtU3zd+GZbzN0RebEimpMYhYzMEe2IO8sAJNmkSDWfW+GOa/exwLeeFOyuHm/0NL5lP16bi3hpvkEQX0xOmL6L4pKPaTkPrsF+xSrLwDsEjs/evvw4syieSXsMIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520724; c=relaxed/simple;
	bh=Ae3k4fBWcYRDoRbFykpGp1T97ePcfzGBTEJQ7CnLa3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU1RIrXbYZCh7nPHs7GBHjbMQ4VBLUw6PEkX928ZNbdMF5TO9BtLBhKcY+wBO1WMHEimYA82CoDUtCU1TWJM1fhDAsL04W0wzMTmvBKkQTaFguODbK+ehngci+RUfzR3mY3AeMXdnZtf18VTG+gBz29wXAr2ukNiPMWR+iktsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJcjzTMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJcjzTMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763520720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFBeNliXIcuhBCFefd7r5jbdEU16Uv9se2IWZ63ryjk=;
	b=BJcjzTMox55M4qla5cvoic16HCsD3MQUaO+uzxD03LreSSlYQgiMt5InpXrOQo90TY8hB5
	khwvOi5bglF8o8J0aPqeqxSSeyOW+CltvkUpfLbXB9Vf47Sz0gbqSWCUOinqd3B/eRmYwd
	Jg5sweMlGwlh7CM7TLTCX1vBtrlk26U=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--73ICE2JM6yHJiQDpNHhng-1; Tue, 18 Nov 2025 21:51:58 -0500
X-MC-Unique: -73ICE2JM6yHJiQDpNHhng-1
X-Mimecast-MFC-AGG-ID: -73ICE2JM6yHJiQDpNHhng_1763520718
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9371a5de3f0so13188215241.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520718; x=1764125518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFBeNliXIcuhBCFefd7r5jbdEU16Uv9se2IWZ63ryjk=;
        b=tI4DZKqgwsIVythK1G3AN0jfchdoJBd8sHnMbDMx8N9v4U8Tk8GlQyKKICj+ew1NWB
         kw9TgxdBg6yX936xgKKpxSwBu3TiMOMUm90JUCeQTvYxH70wrCuG06JqX7XMVh6RZq5q
         v6tTgOekdvWyTO9SiLuDpj1ARah60JrIDvP5BqWU+w13B1cVtwrQfIbdQ3MWGgIE2shI
         yv25lI6StxJdO7WQv5SRrf1HHkkZmEOpQTjavwPiiwgwZAqDB48HdUy6dJOnxkuuufsN
         jFhMtrQOwBbLbDMKfqS1zepCSkQJ4ILNFf3+SYENOsQb+0t6rOHukWAD3nZEaLCGX5oH
         EFYw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOwf5TKeuyILa2fly5auE5GnNo7Y8zTOjKMnaQh7LojgJ6AocSfX73qwQHa/XlzHAzFk/p5hunHW12d6M9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7RBmEfwyQErmkrLJh4RI8SrrJ/c1IgJCd99azZPyYyJNRgw9Z
	t1Gx0HudP+9OUhrgmvLC3ZV7pJLtU5f/NirSQpI2BQdXgTyBWzVpnZqcDidI7s5g0aKlvp1Erx6
	jLM7wTiFPi4YEjmn17yjz2XYksw2gulMaAa69X3pr3Lpe3GENnpSybrBY77otn777KTIRsTZKIC
	HEyJrxVsSjWKgbof1cVGZIje8GY3Iy9gv7DpdLyL/q8Kk=
X-Gm-Gg: ASbGncuKRqVkJENhRjw5imzZxE/8pWLSyPZtCEo6N3bjvBmuYkri3pGvsGJtTBnFFWI
	vkb6ZX7mlg2FqVOYkRZ5BuANb9UtylCuqAxnrtZQc/ksOLZZQmPrZKqIRfC4AgDpicvSGv9zYJF
	0hwTCwr2ALOGDj2kkUd9axgR8d6B8JMCQGQw9twRKPT6QkGok9yQZQwYmL/9+rSkw=
X-Received: by 2002:a05:6102:4b82:b0:5db:25b5:9b5e with SMTP id ada2fe7eead31-5dfc5b93ff4mr7065381137.22.1763520718316;
        Tue, 18 Nov 2025 18:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjFYHVHwoui5kA9+RYjbUvDfZr/NEVE5goTp88GriyeCAdrJlhbGC4amH38VQOIWnEAL3un/e8KEL7nNPcuqQ=
X-Received: by 2002:a05:6102:4b82:b0:5db:25b5:9b5e with SMTP id
 ada2fe7eead31-5dfc5b93ff4mr7065375137.22.1763520717983; Tue, 18 Nov 2025
 18:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
In-Reply-To: <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:51:44 +0800
X-Gm-Features: AWmQ_blFb2oJPYtUay5nkJZ1e4RbvJeLv6CvHccxybTqhrDxLvG8ls4SnfEcuQU
Message-ID: <CACGkMEsRqbO0G26xiLwwB6BPBwZSYtfDLzN2S89=sSRrHKuvDA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: drop kernel.h
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Knn9VHLeGec1dy07fkAezO7VSuzUnRZ70AKo2WxxdhU_1763520718
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 7:08=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> UAPI headers really have no business pulling in kernel.h
> Drop it - it does not seem to be needed, either.
>
> Fixes: 7c1ae151e812 ("virtio_pci: Introduce device parts access commands"=
)
> Cc: "Yishai Hadas" <yishaih@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_pci.h | 1 -
>  1 file changed, 1 deletion(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


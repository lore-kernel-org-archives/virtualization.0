Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF919992D
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548981; cv=none; b=KKafsSqmPN9UB2EKJQVVsetnmJJLgdjprav7qfj6daiPdBXoAmHF9OeHE/50kt+MpiDVOHHGH1FyrmhV97adjzg0jA4J+t6cwDd59yhCy/umE958DB/TcVf0HwD0No6Y00hUnW3IkJP7sWEjFUueR+5OUTJjo5/bmC318G956wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548981; c=relaxed/simple;
	bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE2MN5YDcIiBtCoEjK/5v7/iSK9vPc0BSxLeiYP30qgf0fAXj9U60Hirr5GfQrBakUEGYwRAUBROUGHCHOM2r43g6yOskRhXaAUriiEt5G9WwcEFsVjD79d9NKqgVTjHdDlZOCARKkisxM08ShwnwQIRhVy0jzixU8f0DULj2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ll5e3UQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll5e3UQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
	b=Ll5e3UQj0Jy1bp5c7MATEv9SoGaP5TQIUAXRfua8I/5FC7VHjWCBisjS3foA23C/QJvf7e
	t9y9aG0dE48YmG5mnNkiuWz2Z3PAIyEgVSlspHLav+0uRhZmFQwIhzasOOKzURLWKD8e0K
	S+PisQ951GIPLonK+lTSWyKoIraRPe8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-aW1zcmDhP46JGjoqQle6Pg-1; Wed, 26 Feb 2025 00:49:36 -0500
X-MC-Unique: aW1zcmDhP46JGjoqQle6Pg-1
X-Mimecast-MFC-AGG-ID: aW1zcmDhP46JGjoqQle6Pg_1740548975
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so13839596a91.0
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 21:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548975; x=1741153775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JslJeDzk/c13P0I370hNGaxUhAl2eLc1HmpJBdcBaw=;
        b=uJ1EIU2g0dqHDEbmvexLeOU0J0bqD1XVK0qHL66VoYh106jGWGU2Kr35+F0s5xXuX/
         q78nLr4IsTAwVTCSI0J12ekA94MLjaSzRDYVc/dl5JR8k7WROSDp7I7BYBQy2i6g1Kw2
         wn6mcCgkzRudAGVbNQhh3ojU7uhAupp45w3DTeJE3eC5wc3axKKZczAxaw/Uib4sdkTH
         jAX/eAttMAzWyF6dWychuu0AJfFn4HFDAnET3yVFDkRpij5i4nFMx65g5Agb8leP8+aI
         kTTjHF0PPHwTec96nGd3nLJlGIzygviiOahE4bGHRIGuIl2ewIJPW7ToENqq7UC4v+Yo
         tDDw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzpTTCWhynfZlNePTcBv/Cgl9xBB3XppxkZNKEDJD34XGSVhRh7DowW+rNq1CFbcZGHDAuyQX9AesAi2jUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvnrEhYkBmP3LkXVOG5PQFkQLK6OEMyODRX8/RA8ekswkDN4N4
	Bx/Dik1PXOG4aH2EqEplfdd1j7Q7VnmRHasBeZFp32hhX6oa/+Sh/a/3X4kSc5COM1BWiBCKx4z
	caxKr59shMEEKyCEQFgsA5NyvTDbv9Bo02UrhiS5mteEoLkE/ZgAPyyFVfEkFrXHFAOM3JUhnjV
	PbQbqlNnEdjBNu4hfX9/bgjmJznGOxhtPiYoqrDK4=
X-Gm-Gg: ASbGncsTQ7gwJZCTehwG035HBpb0XP/FRS8IzMgmdV3bPYyK2mPheuYYeGREj+Lusf+
	TfbQOg6il5MaENk/JBvzsaIEZUInsIjzJRuD1XbKBxod4hbel6SHS6rIkv8L8BDw4P0ppZj9n1A
	==
X-Received: by 2002:a17:90b:540e:b0:2fa:200e:acd8 with SMTP id 98e67ed59e1d1-2fe7e36c6a5mr2830398a91.26.1740548975535;
        Tue, 25 Feb 2025 21:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHao4sHapKak96kS34jjVbnf/J/xsI5aoEpJfu6k85ld0wzno5T370e5VcuJKWSZcF3LJ8r2FpUj/vtSH7zOG0=
X-Received: by 2002:a17:90b:540e:b0:2fa:200e:acd8 with SMTP id
 98e67ed59e1d1-2fe7e36c6a5mr2830379a91.26.1740548975203; Tue, 25 Feb 2025
 21:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-2-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-2-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:49:22 +0800
X-Gm-Features: AWEUYZnY9EFWcoJ3ogh3GxbFxsL5lrfcPA2_752HhK9UejW8xtaSGW6hEYORVZc
Message-ID: <CACGkMEsGuw8WqoGQZarktjPbF+UPmTk5GS7Z5UtTUK2B8Zkg-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] virtio-net: Refactor napi_enable paths
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nkd5hMdUeZ-jZA87XZbuzJ78NC9ow6hrYGqLPSMDdSw_1740548975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
> receive_queue. Create a helper, virtnet_napi_do_enable, which contains
> the logic to enable a NAPI.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


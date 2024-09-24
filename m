Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA779B8E
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165195; cv=none; b=hncqnQMTIgwobwLbYUJBfh92Hru0wsMYJ6TuV1nz+QZW28GHNIMCn8v4JVTpyMYRjfGOetZKHemaeQusJfZEvusknsvF1xDEje/Xw0Ns38wrPFo0/scBuXASljzVgl82lP/zscFN3hzBlMHTXdIxLfCF2tO9CjPpGsKAnMI0uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165195; c=relaxed/simple;
	bh=67LWStMPZnMxEU7ft7DleIniSzRAvyxn70INzRxcYpk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEFoHx82qb5dYYtc4SZfLjGaoE5010t3O3eMiDmqeXSmEDoNhB04XOebmn3wOVc/waUlD9c0afE8dRUntOpip9SlJld9JUgAuz0LDR9eWVujbhPUIxYFfZafx7n/435Bn1/C+JbZqMDuWlF9kCx+Z5TpqzJpZUBAzhxTbQTmzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDSDlJTd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDSDlJTd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365b6bd901so6046469e87.2
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727165192; x=1727769992; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67LWStMPZnMxEU7ft7DleIniSzRAvyxn70INzRxcYpk=;
        b=fDSDlJTdtbseGizCzFLYhzvVO+UrqREWKQugZRgxK8fO91dqnK2T8KQd8E2mVNPlfN
         n3vD05GhGrfR0AJDC8REZbIDF/B3ScCZ757oGySQl3RDwqZzOms6T2RQRYD6C3bA81W5
         wvXcnRgbsxdD5wsHMkavzk8aJOOkDRwoBQSKSCPooM1fiK8ksL0iZ6a1nNSQl2OWQP/c
         2/ive3qIKgicQz1u5ZaP3hy55J8EjQRl1yHPLF8HHLmqrJUE/g0NDpzthcvf1Mv+SySn
         /EJuSAcyirbLLGg+8hwCqpP6h+2zC2/M1la6DXo93HWec7mF3xF5xJHmU+c2Xf1KIaRn
         bSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165192; x=1727769992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67LWStMPZnMxEU7ft7DleIniSzRAvyxn70INzRxcYpk=;
        b=UrqbWdNwYG8yuJVggxdSE2sJ6DmKsaVw8Y35NmHQ/58cp30NquQ2+PqKuxb2RtE4vd
         7cC1Liq0ydOWKEPMkH3+IsYgnkKndcRZcrFDG2zdzzkpU3mrT1uS/KXIQ+mzauaizD3j
         kYEC7S+DwwHFUPxPEHey7H//yiBweK/0RDpnGO3quzoIDSsqLYmzUxg1Eypg3mO5BguP
         awrPZ6cHmC/XciYYPb9ffFD18Qu68j3SoYve9ZPaA2gVqgtN6X/zSt+EFi/66OJuIj35
         8hdAFfydcEVIpgHCugf5DLlj/sJhrKdhFxxVyJz5j3sX5TTs/eQyGcrqS5qCJZgO+wYp
         bN+w==
X-Forwarded-Encrypted: i=1; AJvYcCW4VNyL+lk/3cIqqktD5aSK9DSsM/Tt9D1TB8+M2ebLkColCG25mwx90Wxd6SiI/lKxg7ZuJ2EnAiBWAWR4Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy60bYZZQX/yY5HjEl3AkDXGif4qJAEYO5DpJ6yEiWLQkNTipmY
	dW0U/KxC0hUF/kIO6hsJ+kYtvMAbix/zPuBwNJgegoBIfL0gax/sOg0qBF3L
X-Google-Smtp-Source: AGHT+IFpJvqO+N2IH2ErjFZSjfDDWuwEBL/xCnRTffHFUto9DtR4BU8zbQbFrI7yUMeGFhw+AYpuyQ==
X-Received: by 2002:a05:6512:33cb:b0:533:711:35be with SMTP id 2adb3069b0e04-536ad17d5e7mr7422996e87.26.1727165191700;
        Tue, 24 Sep 2024 01:06:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:9232:6860:60da:f193? ([2001:b07:5d29:f42d:9232:6860:60da:f193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f188bsm52548966b.153.2024.09.24.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:06:31 -0700 (PDT)
Message-ID: <f786e134a018004820fd147053e4eae722a6004f.camel@gmail.com>
Subject: Re: [PATCH v2] virtio_blk: implement init_hctx MQ operation
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, stefanha@redhat.com,
 virtualization@lists.linux.dev,  mst@redhat.com, axboe@kernel.dk
Cc: kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Date: Tue, 24 Sep 2024 10:06:29 +0200
In-Reply-To: <17b866cb-c892-4ebd-bfb9-c97b3b95d67f@nvidia.com>
References: <20240807224129.34237-1-mgurtovoy@nvidia.com>
	 <CGME20240912064617eucas1p1c3191629f76e04111d4b39b15fea350a@eucas1p1.samsung.com>
	 <fb28ea61-4e94-498e-9caa-c8b7786d437a@samsung.com>
	 <b2408b1b-67e7-4935-83b4-1a2850e07374@nvidia.com>
	 <5e051c18-bd96-4543-abeb-4ed245f16f9e@samsung.com>
	 <17b866cb-c892-4ebd-bfb9-c97b3b95d67f@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-23 at 01:47 +0300, Max Gurtovoy wrote:
>=20
> On 17/09/2024 17:09, Marek Szyprowski wrote:
> > Hi Max,
> >=20
> > On 17.09.2024 00:06, Max Gurtovoy wrote:
> > > On 12/09/2024 9:46, Marek Szyprowski wrote:
> > > > Dear All,
> > > >=20
> > > > On 08.08.2024 00:41, Max Gurtovoy wrote:
> > > > > Set the driver data of the hardware context (hctx) to point
> > > > > directly to
> > > > > the virtio block queue. This cleanup improves code
> > > > > readability and
> > > > > reduces the number of dereferences in the fast path.
> > > > >=20
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > > =C2=A0=C2=A0=C2=A0 drivers/block/virtio_blk.c | 42
> > > > > ++++++++++++++++++++------------------
> > > > > =C2=A0=C2=A0=C2=A0 1 file changed, 22 insertions(+), 20 deletions=
(-)
> > > > This patch landed in recent linux-next as commit 8d04556131c1
> > > > ("virtio_blk: implement init_hctx MQ operation"). In my tests I
> > > > found
> > > > that it introduces a regression in system suspend/resume
> > > > operation. From
> > > > time to time system crashes during suspend/resume cycle.
> > > > Reverting this
> > > > patch on top of next-20240911 fixes this problem.
> > > Could you please provide a detailed explanation of the system
> > > suspend/resume operation and the specific testing methodology
> > > employed?
> > In my tests I just call the 'rtcwake -s10 -mmem' command many times
> > in a
> > loop. I use standard Debian image under QEMU/ARM64. Nothing really
> > special.
>=20
> I run this test on my bare metal x86 server in a loop with fio in the
> background.
>=20
> The test passed.

If your kernel is running on bare metal, it's not using the virtio_blk
driver, is it?

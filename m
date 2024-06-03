Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6C58AA5
	for <virtualization@lists.linux.dev>; Mon,  3 Jun 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405594; cv=none; b=EEFd4BmPMDd/oFoK6PnczsrT8MPwZxwaIN2uSehDONoWuM/Oanu3JsmvAlfgqUTLOG2Yyb0A/R9QS0yZGmA8QWbWSgLWyQgzNRN++QOiTYYNGF2e8g2tlTUFwUoUpIJUoaJARhW7bf0axRvQI3+rIbMpOYY6THEMRZ3d8U+Iz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405594; c=relaxed/simple;
	bh=e5KmvQjDUeFpUSn94wFBVcAhTokQWkHDxz5eJgxO6Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STrGBWhoskY2NzDEeRbEPknK9StAeCKUPI/YaT+r+nCuqLeHhulwI8v5ynFAWsz1ouUzJONxe7QvgoUKjdJUaI8nc1sD9nzMRmqTyZARFLIVJ6fr5yt7cW/YOfR0hHP2i8g1BgYVSmdJuFocbAq4GmulgXlAGqfKyfLXxlXT37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bZmFPUXA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bZmFPUXA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68bf84d747so162602066b.3
        for <virtualization@lists.linux.dev>; Mon, 03 Jun 2024 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717405591; x=1718010391; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/KGKFroLHLvccCfGANjHQWcwdrvjUhEDXE1KYheHoQ=;
        b=bZmFPUXAuL+54GaFcPqYQFMfWRlweBMvpORQz5MJhcvxD1m+Bx5Tt2NicTKqlCpsLX
         eJ7VoEmPmNheiIo5U5hvLIfmL6GdwZ9yZyRGplLXSfazLc7GzX9FBWVUefFyiuLZGL9/
         lyERRK3iZ5UtptTm4HvOTj/LuaWzlNmeIL18A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405591; x=1718010391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/KGKFroLHLvccCfGANjHQWcwdrvjUhEDXE1KYheHoQ=;
        b=oKcuRpmSMJpWhzGwjsk6PErpncALb/FnDHZ7N4Gv5Kav/4/mPUCkHY4CGCq2Kqzr0X
         Mmr1DuJA97dF+KmvYNM0tyikKHesIZDiTz62Y3cSejZpi3QE5WYFHcLH8riNo9BSjVs7
         3oRIgVnoIkHo2df4K/fw00xpo5NdrL45Wvihn9VaRnqOGo9ZGnDJJhntLW5ltKPjvP8u
         T9I3vJBQxkD5/1EMvEpDANiCTKDMtaftCaj7kGpQrQnQYJMIi7Jd9tryXlFdvkqAH+Rt
         BsWsCkCf2QCkbC3LNt9JU+yYiPocp0OQMyHWlOlHOjQiLnfvPruBRPSzkFeeSvoju9LB
         iluA==
X-Forwarded-Encrypted: i=1; AJvYcCVRZp5jXuqCcvJkSWRQi5EOu5UJbQs3sYTJsDrsmXy7OXDoBM7m/pYInBfoYdm2P75X1JdaQclavrRPymyZZ3J4HheoOBi1IVWBwbUXyOQ=
X-Gm-Message-State: AOJu0YxkJdGSPYG5LMbiOUFgi/gSmRp/JZ8rMWghur2WQmEwkM7W+0F2
	6KF+e9IUP8pf01eTNHF9wMggij9n/2pp3Rc0hfyW/fJkTTeN/XBg9jUblzs/ltQOHSdLj8E+x/y
	HFupo5IXV1Of5Jlvhtpg3bRNtto3Hl1a0aOj1KQ==
X-Google-Smtp-Source: AGHT+IHdK5tYaFMmrN69eVYnH5x/bM/8a2V8+sJbycCBdig0hUz9ZUeujQWgKbqV9aS9ChtAb9eQmFPemjGHAcRcWaI=
X-Received: by 2002:a17:906:b894:b0:a68:e3a0:65eb with SMTP id
 a640c23a62f3a-a68e3a067cemr252378366b.16.1717405591083; Mon, 03 Jun 2024
 02:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com> <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
In-Reply-To: <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 11:06:19 +0200
Message-ID: <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> We also considered this idea, it would kind of be like locking FUSE into
> being x86. However I think this is not backwards compatible. Currently
> an ARM64 client and ARM64 server work just fine. But making such a
> change would break if the client has the new driver version and the
> server is not updated to know that it should interpret x86 specifically.

This would need to be negotiated, of course.

But it's certainly simpler to just indicate the client arch in the
INIT request.   Let's go with that for now.

Thanks,
Miklos

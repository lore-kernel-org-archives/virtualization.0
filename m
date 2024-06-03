Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A845A0F4
	for <virtualization@lists.linux.dev>; Mon,  3 Jun 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403076; cv=none; b=rsIbslcIS5OBZzK2pUBce7DMwSvslNFpg0+tb+2MVDkvo2FaxnOD432zZV92uvJGaStJ/4lMqx7Bg0W9tHcCTiHg0/JY60+2RszRBLeyFmvsQFJFVMZXi5t+Nz5At8K+nCStBamWkpqA/ShYn4EhDTOQBREBkygwVh/xh4tCPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403076; c=relaxed/simple;
	bh=xAIZ+DQHyV0udtEfccsYtJWq1o1HPNaWK1OKdflmajQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muWyDocMJ3HU6jCBivub5PsHrKlpAaUi9Os/ckwfSaiIgMnJ+5CWA//TeMPFFnrzSKBAPPS36Me/3gJaquMiVQYaGIes1+AaZ1Wq1MibZzi9QZp4rBm4qdI9mKgtcjKFZtGNthS9nMSFtbgTfpMiKzQTXWjbjqKRd3DRcjmT3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S9atawAm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S9atawAm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68a4a9946cso166835266b.1
        for <virtualization@lists.linux.dev>; Mon, 03 Jun 2024 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717403072; x=1718007872; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4HWxQegOCl8PWi1xhoGaSFVjTCYGr9F/bsnti1t6Q=;
        b=S9atawAmqfzTlq1SttN69OvqQ5OM6oLhB4EI6w2mTuYlk96ctONVfFxCaVqJpysdoG
         erSBl6SJZNN+b6MdWgudSOqJPxJOW7+BPf5y8eUkCx7yHPwetl/eepe0vJNK/tD4k7Zv
         OKElEuFf/CGskoYxHQv3+Y1bmJf1U63J0Gaqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403072; x=1718007872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry4HWxQegOCl8PWi1xhoGaSFVjTCYGr9F/bsnti1t6Q=;
        b=JvVus4Vu9nH4Iv7P/bj+9W+prXEe6l05OKJ0oGtp0MuiPEUqA9iji1tXbHpjTp58wl
         wxs0JS0RtQU663lg1XzW86iuWEDNwF7Cy/MH7Q8Yvcv9zIYBiiC8PvcOIErfD9AuAO6+
         GWIAVXi+eI4h///06tDDnVZK1jlM1dHeHCkTEorKE1l0ocp7dPFSjEvd/9d13RpdqSe0
         SArzHPt0DaOLAL3XPBBy0hmaNVFFV0Jp1FPZXSVbx5FEbo4y2MhfS9zeJuG7JKiBkOKU
         WrkJk/gKQEr9vb7Bk6ybsXPsKHp9gExg7LXFZPyrcyIE6EvCuN2vnGif+qTwNQLWqXse
         f5dg==
X-Forwarded-Encrypted: i=1; AJvYcCVSAncPkzc66VwTdVEWsSYuze6Mz7vj+xheGuWPkz7ncBwmK7ZI/GHMBuLbL7Q0yKHqQj3Z8tZYP32QMDzsOYkTLMenyEVs0HCyl5NiY0Q=
X-Gm-Message-State: AOJu0YykC1JYyBS7XO0VxZCEqIrz8VCe5gJ7njkAV8vkE9D+PovRGIve
	ak2j8wCcyf0Fzj2734XE3y8t2PO+Fx+TyJzLcyQZKMdGi3aZhLG/Oc+QTJMIRmZTYnNrujXeSex
	lujSinJhYrtVZZqsU/p/ze9y1DnZF3fAoKlGZqQ==
X-Google-Smtp-Source: AGHT+IH8WE25qqoL5c3i7KXeRvrPO2rSbvHuTxjzKAMI/IseGoBrnlNoUepBXVENGV0IXygqCvgPj2tQzDeBbFisKPg=
X-Received: by 2002:a17:906:a008:b0:a62:2c5f:5a64 with SMTP id
 a640c23a62f3a-a681fc5c68amr576081866b.15.1717403071862; Mon, 03 Jun 2024
 01:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
In-Reply-To: <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 3 Jun 2024 10:24:20 +0200
Message-ID: <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "mszeredi@redhat.com" <mszeredi@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Idan Zach <izach@nvidia.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 10:02, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> We would like to make a proposal regarding our idea for solving this
> issue before sending in a patch:
> Use a uint32_t from the unused array in FUSE_INIT to encode an `uint32_t
> arch_indicator` that contains one of the architecture IDs specified in a
> new enum (is there an existing enum like such?):
> enum fuse_arch_indicator {
>     FUSE_ARCH_NONE = 0,
>     FUSE_ARCH_X86 = 1,
>     FUSE_ARCH_ARM64 = 2,
>     ...
> }
> Through this the host tells the FUSE file system which version of
> fcntl.h it will use.
> The FUSE file system should keep a copy of all the possible fcntl
> headers and use the one indicated by the `fuse_init_in.arch_indicator`.

To be clear: you propose that the fuse client (in the VM kernel) sets
the arch indicator and the server (on the host) translates constants?

That sounds like a good plan.

Alternatively the client would optionally translate to a common set of
constants (x86 would be a good choice) and then the server would only
need to know the translation between x86 and native.

What about errno?  Any other arch specific constants?

Thanks,
Miklos

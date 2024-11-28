Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA11428E7
	for <virtualization@lists.linux.dev>; Thu, 28 Nov 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790000; cv=none; b=RfBEmh0yigAulCbvkf0YlSbXMF38ki2dNwlhs5r1BgCQEFyItymG0Whrt9fhZgi+tqPGE7yvP1DduSmnvFcGZsW5FxhyItKGgj7foZWfCk8XumMHLvdTfkacmG/OGKMaMlIq5/bKjBmAjWfQy5wlm0LycxmnMSt8T2xHUtEhIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790000; c=relaxed/simple;
	bh=XVI8va0sH+hlFPsTGqYXRjjRNC4wP50HEmRED/nMhCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmQgpy0M1fesMGhbqwYp0EO2IihTWSWA3iRarBXHWmtrz4s8Oy3ThtSrQHL2ZFebeB6SAYx8vOmeW6mQrwK5qbRdLlE311ZeEpC+mT97KC8r56JVpc1NXZgavRf/xcuS2i+5h1F3nRsCob2TGF660ujOgVQW5goWp9RbFiGq/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zQ/2ZT6s; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQ/2ZT6s"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4af5dd908bfso100464137.2
        for <virtualization@lists.linux.dev>; Thu, 28 Nov 2024 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789997; x=1733394797; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSlH/MPJCfCK+2zO1UQk1j2YriDW0ayAfaC2LQcPB+w=;
        b=zQ/2ZT6sh15P8soT0mXtTlTIXkhwUYHSLmZBstHDTK9vJZoqEta5SfBfEhqQj7ycqI
         1T8FKMnd0sPEwMocMncRBWnYPeXDIpPfbxyAH28PulW0ZqtZq3ionH6Y7k+6QI3JVvOx
         ii0A5z/Vm8/vKHjBC0IYfAjiWUOeOys+HICXhqKD9tiHWjy5WTP/7xekyhhFDVNwnkvI
         XSdsQHkwdZOX4+LycF73EsNk3rufaIj9Ll7PNTwmXo4gTZGVs1RBrK5+nTJGcbELVVtY
         ORyy/5/rh4qK8SwexrzsyO2nfkTTQSI9KvnyeSrYXCEWVAp3XhsCopW9JDYffIV72Ydm
         VZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789997; x=1733394797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSlH/MPJCfCK+2zO1UQk1j2YriDW0ayAfaC2LQcPB+w=;
        b=iAqllqDjBE3j8U86xf4ptn7asxKmPs0/NSNIAMoIylUu6uHVDJ3d+ghbNcij3ask4Q
         gsu4a0J3+vHb25d2THpkgdtL7791FmsE+jybIv9Z/Jyw5SOlXZsSEDkOhBWa1IrSWCef
         rg7fAIKKPKL6Rzv5iI2zsdOTUP/9TZMYq4Oe/DpISQ4RKVSVDXU588Jio+L2MALpL9U0
         Evm4LXp0ZwPoxDbkrfztzhdPy20sSl3cuE1aFhB5yDETsI3l9LnOONjdBDZryd5ZkR4j
         79qpbnNjukn7VISrntYqFhPIgPCnJs5P9HZk6iVanhs2gCn7HXAXghvMQll65/kyipB4
         GC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXprpuYnnWgIPlxRqV04C6SNpD287PLfz3RKMgCgOwQlMzsJsvV7Vy5En86J+2HhX5FgLvW5hpkGqX9xuvrag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3e/Auxg3hfVRiJFtjCwQ6HapOfd3quleoZDOAVEkMHUiuaJGM
	vaHgb+0RxFtTYfbjyWD+scWf1VaqELZp9Ma9T3GwLZdMYKrQVqEeNVUhx1z0ngV7UClVBbyKOEJ
	TuNfDxKtfLB3OQieGafbr02GU2dHab1uCGaY2F0ixPwXri4ZChIg=
X-Gm-Gg: ASbGnctivzQBVwyr+TF6vnbGzDE95ubiENbRRUQbBJiL3TXVDRzOcKWyyk14Q0QCW0t
	NVSiRv6lLdpj7Lb225l50GYRj5CHELiEWOQ==
X-Google-Smtp-Source: AGHT+IG6Cpu92BFuaMn7+1AP7D9PHmlimrKNM8AMzFkG5MR2IUheXwXzsAppyk7NHe93TQVJIm89CKZ9kUCC0HxzAEo=
X-Received: by 2002:a05:6102:cc9:b0:4af:400e:2a9c with SMTP id
 ada2fe7eead31-4af44950ed3mr8210778137.25.1732789997497; Thu, 28 Nov 2024
 02:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
 <1732763459.0668714-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1732763459.0668714-1-xuanzhuo@linux.alibaba.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 16:03:06 +0530
Message-ID: <CA+G9fYsrhdkWZ-tfLiHU0a4unRVn1GMrTsDnW2RNxeOipU44hw@mail.gmail.com>
Subject: Re: drivers/virtio/virtio_ring.c:1162:11: error: 'struct
 vring_virtqueue' has no member named 'premapped'
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Sasha Levin <sashal@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, eperezma@redhat.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 08:42, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 27 Nov 2024 13:30:59 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > The following build errors were noticed for arm64, arm, x86_64 and riscv.
> >
> > First seen on Sasha Linus-next 441d2975754ad94f3ce2e29f672824bc2dc5120c.
> >   Good: 07e98e730a08081b6d0b5c3a173b0487c36ed27f
> >   Bad:  441d2975754ad94f3ce2e29f672824bc2dc5120c
>
> There maybe one conflict between net-next and vhost, how did you handle it?
>
> Thanks
>
>
> >
> > arm64, arm, riscv and x86_64:
> >   build:
> >     * clang-19-defconfig
> >     * gcc-13-defconfig
> >     * clang-19-lkftconfig
> >     * gcc-13-lkftconfig

The reported build regressions have been fixed on Sasha ' s Linus-next tree.

Links:
--------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig/history/
 - https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/history/

- Naresh

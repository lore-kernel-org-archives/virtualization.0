Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294412C15A9
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313372; cv=none; b=e7pKHnJldDCFPfISlY6Z/bjJOBDwraN7tgEL5MuaC8Y4zoIZALGdOwySndxQT6v4+LdGkMmZibBiLJ7J31G6DJEVXl1sSJEgXKUGV/0uUeMJRw8D9xfoxqoyXlqNO+p214Vniz+ui/RYmkL9s6oIqV4j8C2CaNO5K/GhHDPoCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313372; c=relaxed/simple;
	bh=rd2xZtg1TUqhPE9MjX+asDiZUF22CLDQ+9AXCBYKRVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbxtFG1PoaL92K2OxCPwiF6OlPl8U4kqdv7/Lid+NxXieOs4BysyYLaxs8W27XrTpCX2s8lpjh9lbFuWKzdeGWzpVJDFGlphUwVUBGQ5kdjsAf+3eVmchGOtPfFr7S3xtBhSq8+QEfXTIo+Mku+foA6Vg6QwgZhQryGd9X/PjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fEkUm2N1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fEkUm2N1"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so3619162a12.2
        for <virtualization@lists.linux.dev>; Tue, 09 Dec 2025 12:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765313368; x=1765918168; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=fEkUm2N1QrTteUub/PSDsX/CJAC2tl7nTJoi174QdGN98XYqwkpDyT+zVHKRyudZdJ
         MjGPBxY7EFcTehgW8NEx8aZNEfZ1Q9jDDRvccaI03/3Vf4IdmZ7ajzbFpylpo+qYFPwS
         ATgczF+xcWzRVvGOrtXR2dwP0hUUub4t5dGeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313368; x=1765918168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qFu6Gyyu/IjR2ufdMGg+lZtY71e20af3aIOCWzwQgQ=;
        b=Lf/OnnuLFERQnbVeZojaauWcSaKB75vURDRxbrfV8aMDsMD0tcVzY7tWtbXk/mRgLY
         Eamt+qfnizy57fC8yrhiX49MLIE3s46/Gb64Vdxbbd6VUvZVphb1oaAKQEsumg1AfiyM
         deakPnUDeGiYvW0b8M9Xv/9Nc4S+O9AfbuymSbpsZ5mMgAxOsfCSKQ0R3Yg4SQu04Do6
         3nr8Qw+KaTiPDiaTFgJ30RSTK1Eyz2t5qrjIDSWsAUwyL5fhvsnzYqkbwJ+J7jqBJeuI
         /KTPIXA/GxsCqZIpvRv6nawLOkHWHu5I2YqqzFxVy2sOrJQ3aTv7tpGI/CUDPQinbWKq
         U3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuDP/UadoTA9D+xMDx2c7f7TvH/zTfsN8hqxqMJsZjYu5aDC+fSn01+zA6j5ZV076DkJw3mM475dBHozhoBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVQJ0/Wug2Mgpykqj9L4llbNRtvag2+A+5UjL2kViCpqYkc9Il
	HAPeb39DoFqJwDLg8ekh5gZPuit/lNWg02KSZboFxxvdYeUEMny6NR5yrV3mn8K8KQIMcsrdNLF
	c+63wLDUnmg==
X-Gm-Gg: AY/fxX7Lr4oD+/WZ1Fsi885JEBogqEdhV0bZONGUg77a5Ml6ahyz+ZISRRb9L3QOckO
	igmaubbz7HnTzDKBiN7SEbP2RCjBA/s9x2rSftmKExR4NDNCxf2Qw9PizcEOlODFTufFQUQO3Dz
	HaZSWpkknnmcKAw6CEjjfhpuLIHEF92Fvr20EIcmYxQmiFYrOmSGOj8nUO22rXr2CbXn0Z1YY8o
	eBcl5cIN76BAvr0V+HOeKW2yyfw7D/hFptBDGFuTwhhK08H8nKN/K+iFwYKP/BfSWyMxIlhIp+d
	2Y5Dhdx1Pu31gOm4qsswCphw2DGCoE+CoT3fgvBgs1CHizco5gOwvLESxHifBLIlDQDk6i+zuXN
	8ktf0v2Nezu2AreoN4eDlD1+jrQ1uXTZkwiV2yHmOtqkJiwv/dKSg7aafcraoPVDRi836fcxA8D
	UZQ+XkGvGtz6BaflRFXXCPe6l9E1HpamBsEKwNE3JCICtq2ySIXH39JxlMbd85
X-Google-Smtp-Source: AGHT+IG/h8OYU8U6n8itFt30f7tblciwwkK3TqXNPhmMgo5waKryYKvurUb/Y3N0inKYAS9F01OHZQ==
X-Received: by 2002:a05:6402:13c2:b0:649:2666:431e with SMTP id 4fb4d7f45d1cf-6496d5ba6admr194737a12.7.1765313368237;
        Tue, 09 Dec 2025 12:49:28 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edf54asm14868164a12.10.2025.12.09.12.49.27
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 12:49:27 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735487129fso921627066b.0
        for <virtualization@lists.linux.dev>; Tue, 09 Dec 2025 12:49:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZWFqYdXOiqjlcSVRG3xc4vDd1/ZpOBGBYYPvG8Iuio53PYmWmf+F+26EXcWfTyOpAUWBTEzNNyG/1mkf2Dw==@lists.linux.dev
X-Received: by 2002:a05:6402:27d2:b0:640:74f5:d9f6 with SMTP id
 4fb4d7f45d1cf-6496db38dccmr139683a12.25.1765312868177; Tue, 09 Dec 2025
 12:41:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <20251209002519.GT1712166@ZenIV>
 <43CDF85F-800F-449C-8CA6-F35BEC88E18E@zytor.com> <20251209032206.GU1712166@ZenIV>
 <87F4003B-5011-49EF-A807-CEA094EA0DAC@zytor.com> <20251209090707.GV1712166@ZenIV>
In-Reply-To: <20251209090707.GV1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Dec 2025 05:40:51 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
X-Gm-Features: AQt7F2qPCXJihSB0EifxcMqIJwZJZTW_3j7hMQ2OwASD92TgZWMxviusY-ovH6E
Message-ID: <CAHk-=wi=2errb29CgwA4eSaLCEojo2Jq1d3ptDhxANfcKPH9xw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, speaking of C23 fun that is supported by gcc 8, but not by sparse:
> __has_include().
>
> Linus?  Seeing that I'm touching pre-process.c anyway for the sake of
> __VA_OPT__, adding that thing ought to be reasonably easy

It sounds straightforward, and I'm certainly not going to object. I'm
not sure how much we'd want to use it in the kernel: it might make it
slightly easier to deal with various architectures and the "if the
architecture has this header, use it, otherwise use the generic
implementation" kinds of issues, but we do have fairly straightforward
solutions for that already in our build system ('generic-y' and
friends).

So I'm not convinced it really buys us anything - I suspect it's a lot
more useful in "normal" projects that have to deal with non-standard
system headers and possible lack of libraries etc etc. Our build
environment is so self-sufficient that it's not nearly the same issue
for the kernel.

              Linus

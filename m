Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23521B9E0
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875404; cv=none; b=IFpVi8RqpLeKuInPQJ2K9aRwoHCf+PvDTF9PNQu6YMSj2iAvNOYfTmUTsVaJYfLgF7nftqzfI1CCLBDXHc48v5lp+N1hhVlJhh0o3a1E32Q7qoRYY7dLHYfMJXRf6y7za0EhWEzfbZZrLiOgWcIovULF93e4/J9dHylcVsee9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875404; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NObx5fx91LSpWZVRPOChpqb8/yHhRHhFvjLpelSlvAyxHYQbzq+dNIPT26B9fhd8Czdk9BMNSsKEXPP6LQ2tCMJVIWKUwnjysrUXARnimrxbDQamNLtQv4NgShNTCkTglFlF+rMQ7ZtY9sXhJlCuhWv8da2C5swQtPV2McjBYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b4JTlvJk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b4JTlvJk"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so4025308a12.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875401; x=1753480201; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=b4JTlvJkjxxZ906cESGc3rmqGN74L7wdYqS3JFoVJYUhERzjClrAhqMHijdSdAXJcr
         woZ3bjRTnIjytfF2drMwMIWMfEa2HDVt4BP1JpfmhHCJmVgqJDAUrbn2vvW5YkKWwrOx
         mXr+QlfRi3ndJvsV7xH2KAPJVv1ZXG4/3HjeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875401; x=1753480201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=lJHxmdKEEd7f/Kt/PuzhSvGxyd7SiTWz9JVINq8hDK4WGN4VhAn3EP3gyDYuIMhUqx
         4osxbxFxn+r/QqV+dyEx4tAvalUlBSOjsYMiAq8YNCvFgZR3RBeKVRetX/d9Iwj1xk8z
         zUMLaK7369q2MA6xrOu6upHTDFoIPOpyWlEIJAWwWQUsGOY43nOAbDC6IguPxnu9Do7q
         NKriqNGu0LPlhU+8tK3QHjpHve5NubxNUO8hjBnF0Jj8tdbolA+cQJwDAtJ+F0d8W16O
         ZyxtzQyJl73Prdjupm0RLWx12wt90IIcCevVeIZ894p2YIqOsqZgS1BNHQTyK6P1ClNZ
         SwRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbN65nvtXBXKqiyDx02v35+zlxohqF+ryWsnwQrHdoYnbcE1Fz0Pp6xGSDrrkzBwTkGRZYZimlapbqjaf2Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFFzr3hlvrtYBMa45FxI5nqjqcUoGXZHLaJ1o7hTavjI7gNzSF
	ZIPUfEegE36d7rpWNKREdQc525VFUaPfLlBgu5+gdpk9aTPsntnvHJWlGo8Xfr+vJC19s5LXqy2
	cP+d/ecA=
X-Gm-Gg: ASbGncsk9Jm+1u13S1Cw+lj7OLNdCl5007MplAAK/MMaQD0p5DNLNQusqSE5yQNAbih
	XsHU8j8Hg8z5lFDLKZ14a5iSzpYlNxkRtKyetZoa1RjnTIUPk43e9nUxEBfNmyXSSKgtkfDAeu7
	JFCVSm9BaZRbM9J3wkLZwUDdMCQHPwMVZ2E6mR8OkqR5+NWNs/Ft17xhlfcmVIoqbzWECKidnwq
	RlpcKdbFW4He2ZfeQJK2i5HJewehs594hNecaAw0Nh+SEkIg4r8OoypY/2YlaIVHzMTrPnxEaop
	NUTk1UGfJcrrJZg2AMgSQAaORp9wRklN3v7t7wFIOp5Xp1DKnwDScV8QD7Ei2ijN2fBY23yxK7d
	Z/6PuNpMtLXT36j5Ps5X6+qPm9fK9qoqyZHGxr6hytm5phz3ttGACxxwE/hE1ptG8dqsD/kQA
X-Google-Smtp-Source: AGHT+IFxKpsfN+lTXidhfE9J4MGSNu/UwPAvXKjufiP8WgjGAO6bjR3Mv+pfQTpNpLc81ZvV2WrYVQ==
X-Received: by 2002:a17:907:728c:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-aec4de65ccemr915594966b.16.1752875400869;
        Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d7783sm188402366b.63.2025.07.18.14.50.00
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so5559933a12.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 14:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8rPvNjI03kj90k8bj0HVJDFoGZI00EjsqrVsFzVxIzt/EPHDGCgYqrFIG20uIfMImCud/bbYAy9b9rRObDg==@lists.linux.dev
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus

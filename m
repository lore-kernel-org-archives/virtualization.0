Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C120E70B
	for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752918754; cv=none; b=ueH6yeT4TStxhKJ9S8DdhfD9NH+Ui8bOSFJqFZkZmKc18Od1XwQtydwWzf/xKoVzGkIfeMob3W1mK7SUWwufExKJYcieSzg10ufjBAaBbJTeGDkcwuvpUH0jk4XefkbhI9FZGGoTt47icT8hNdOWy1hR5MfZLpUdHRq6wa9bCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752918754; c=relaxed/simple;
	bh=oSt+1bwQznG4gMR3tFfughPMF0WDaB7Y07l3ebktgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSZCiPfrl4LtCQXWvKSBFVFmbJ5CCmoNTbn73rs30MpzUC6Out1EPaGy3vvMnKuI/RIXIk6kBNKC1odfBPj/26GSsOrjegfHX2misgvNfbcmbXWk6cfBSk87b3YL2FAbpn12vu1FfVKUWubTyfbCUBZAsL7fY5vLw76Nmwsw9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5dfaqVN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5dfaqVN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45610582d07so22096235e9.0
        for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752918751; x=1753523551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pEXn5VHOGjD9SP45xNUPOGCXrKn0jYGF1BCukLPods=;
        b=I5dfaqVN6BP40TeTG65bNGgCmtj1jLFyp9xSlgw196qt561Xr6p2zNgPpN46zMJ5Sl
         YBMxqM2oZ7CmvRuZ+Yfi1/NdKappH+00MhNJ4gJPslmW+C6PnUHbl19WMpjRktZeJGQ9
         7dpj8XdJcCSPvnpPgNDoq/Td9+cApID2XYXqBZQODGFZquwLrtNvKVi9Jjm0jBmJ/HkS
         qbbAs5qQjBouXMHzOunSEVN16qzuUmaFmCAXt7hOFRMniV5pfgYyItUqmtShDr8PxYl+
         vDS1J4mBLeqpn84sDJC/AEflaB4ilDBQ24Popg4UT2DMNVP6caaXdRIoFN27GdWPrsJz
         c5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752918751; x=1753523551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pEXn5VHOGjD9SP45xNUPOGCXrKn0jYGF1BCukLPods=;
        b=IXFLtX+JFL2r7IjUs1FQC0yaPxMsGSFyqENWNM6vKUBVDqMC0msiUCh3ieFtxTHW4b
         OUhJYDePogT/UXhaA70WyFvRQA288tUcBnIovkAfg6FL+IPJUNYgW5R4LwtogJCQyRls
         kiSrXuYZCrqKHlbQ/qXdb5+lVZNZ4HeuXYvk8+nrwEisiSrECsSfdocR6fHFUKDuIJzs
         /tVIGmIj0E0HYYnWQ3UQ2cGJjA5pJqy07bSfaI92q0tKZjC5gPBUI+afQ483LTrH8V/c
         lIeUJPCm+SKXog+VcPSnAEP0fY7mQ56azqKvF/g9yTPUTu0YStpZJLM/59UbFSCf45M6
         JM7w==
X-Forwarded-Encrypted: i=1; AJvYcCUj8f5eypg1zze+vUQADQ4Tg0CpSZ0F+XaGcP2Hs67+YQDKHWP5orDQuwnLiLXXjZs702CCK14FSzoqWDhn1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyqHRcLcfglvZtCQLy3hDLLQmAtkrGaX1OeGHHwxsXIXNMhThE
	cmXnpNFjYTGopXy+a3gg2vNU5GJQGZ6ebPt8ogJcd1BpoHQhoZa4hvHg
X-Gm-Gg: ASbGncsz1Hx8rA8AQW188zzaC2SfsoUK4xm9Ko8CAYFuyCcxg1mVkkqAPuK89iXf2q1
	ipXxIPuPsRmx0N9XAl+ToJHhsjAi6fOOnUeI9XjpcA4Qj3r8tQRDHd3JzRUw/L/iTOhxNkvtXSL
	UqmdxlG5oDrGYkrYRCo+1RzLP9sTyqYn81VGXoWiL4GCZXZwnyRQtxAV2nfbF6jT2letAbGH2+P
	z1ZIiRlFmBrwPs9lMAc/sqjTCpmXk6phKHIEliRZfQrFUmakznaaJPxpllBXaIJOoG0ltHO7oEc
	/fTDT/STCPL7CI1MeWOtnuqHddW1JJ7xkBJQc/6bqXFbbxEgDqOUjc6N95L8olUr0k+YUmc6MJ2
	36S3XxFqxoaUiTBUJv2G0+Zg2eoVHCJkxNoHUQj4iM2al50NfJTvXCzBoXiAV
X-Google-Smtp-Source: AGHT+IGgS3eKZd0WOE5CaGVORMk8w7YbhfbUyHdCIflKLfBmlFtKqD0yPw9BMSfCnK1ze+Ow5Wktqw==
X-Received: by 2002:a05:600c:3484:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-4563535d2ddmr77234825e9.22.1752918750524;
        Sat, 19 Jul 2025 02:52:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm100634135e9.8.2025.07.19.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:52:30 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:52:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, Dan
 Williams <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook
 <kees@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc
 Herbert <Marc.Herbert@linux.intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj
 <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, NeilBrown <neil@brown.name>, Peter Zijlstra
 <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Thomas
 Gleixner <tglx@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>,
 Uros Bizjak <ubizjak@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, Yonghong
 Song <yonghong.song@linux.dev>, Yufeng Wang <wangyufeng@kylinos.cn>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-sparse@vger.kernel.org, virtualization@lists.linux.dev,
 x86@kernel.org
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
Message-ID: <20250719105228.1704538d@pumpkin>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
References: <20250718213252.2384177-1-hpa@zytor.com>
	<20250718213252.2384177-5-hpa@zytor.com>
	<CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:49:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

...
> Side note: I think some coccinelle (or sed) script that replaces that
> older form of
> 
>        typeof(x) Y = (typeof(x))(Z);
...
> 
> with just
> 
>         auto Y = Z;
> 
> is also worthwhile at some point.

That one needs to keep the typeof() - but the cast might be spurious.
It could be either:
	typeof(x) Y = Z;
or:
	auto Y = (typeof(x))(Z);
but the latter could hide compilation errors.

I'm waiting for the next 'duck shoot' (after strings) to be casts.

While casts of 'buffer' to/from 'void *' are fine (and not needed),
casts to/from 'integer_type *' are definitely problematic.

And 'random' casts of integer values could easily hide real bugs
and most just aren't needed.
Although you might want the compiler to make the result of
'u64_var & 0xffu' 'unsigned int'.

	David

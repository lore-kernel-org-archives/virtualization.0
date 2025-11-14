Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44F2F0C74
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153356; cv=none; b=qWigdAMz00mDwCja8DK8s9hwuQSa18yNnknjNcnJ9wwBX6JK7WiuKNAqPLDa5T1msvCcjd+cTQShBsTKUG3D+W7fdMS62cPIBw8gNgbxQL/bjBw9wZybPwwqYip83Gp98Fqg7rrZLp4zCjAyPo3IYLBw6ZgFn2ZfWAMEQD1oyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153356; c=relaxed/simple;
	bh=tE7fP22dB2vlNTuE6sh0FMu1Pi5aw/zDuijOpLixHCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3S1KZbmh7xzgVAWicpO8gvyBoPWQEhkEaGTRjpL97pQiny25Tcj8ABaxEprByeUwqk+gCFKdw8kJoDMUJY/AjKrJOnLYwZvi0AFxKR9TOuvmcaufQ+itTg7i7zav2qN8Wl3QmC8jnPpNfZwpM1EL+Ib1jmw4eIZskbscV2pX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RlNn/fl2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RlNn/fl2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so3342344a12.3
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 12:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763153351; x=1763758151; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIotG2TBVJHtLyVkQ1nV/V4Ve4TP77XPvYjhlVaFGps=;
        b=RlNn/fl2x8d/bKqz2NxmufpSkFO9D5wn/GWw87HuBTp7j7dyONtsf0I1SbRmGg5LPE
         xuWuO7r6HU4diJGMq3p0/EcI4ZBPq0Qi51zWVWXOfhDzdz7PHOQVK6KY4Wyk0oFlNLyk
         EYuqWtObAOT8e2l+l/x5HvABnTABpLg7XbrDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153351; x=1763758151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIotG2TBVJHtLyVkQ1nV/V4Ve4TP77XPvYjhlVaFGps=;
        b=VIlgSFXHH5nS6yc5beDhgmpkueFprgLEfrNx05zrgiOnWpj2ZSSb3zTebuQGfJJRcE
         FqUit1DumCQeGU7MCeZDcRfjzJFv2nuP7QqVVH+ugNyW/7nWbngo65RRkqPNLSdUndfZ
         5KWdN7aIZZ90ZWIgyn96cLfGB75qh0int3hqKdOcfG9/lsFdRIj23j81WVFLNS+ecHFA
         UZu1SNElTWRM0MoWjpmYUQIisBEwoVhiPwFRVPXK3rY6GBLn3P3nAP6mWPkRw62Kqiu+
         pB73d2e8zeuemcnIvq0Mr36Q0JpB0dyTSkCEoZLiiigeCoB8EAXEu40pXjydRamfEnrT
         y2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8hgFfJAB6x4mzmIHo+K6WVcNLwxKGc2B/fsWgx++Oo7b8znDYly/5f3xgJ1SpIIP2AQg24YiuCaXjZKk12A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7ykzofkwhqOhgVmnFQNMuzVpH2LDjUmae4PspTT7AMhVkzEQ+
	PIotmg05IvMnqfuf017CPO7vBz4x19gGkGC7mah025MB9rllgmCBE6+9Mq+Aic0RWn6jZmG+lPb
	4BwD16X8=
X-Gm-Gg: ASbGncvH9Yfi8XWa08/elh5QAxrLjmwYjP/7FZE5f6z3EhxHFwb65RltdOY/vUy43jL
	ByZsy4C7GHjJEanbeo2dpirqyJ0Ou7/EMHNhHrqg+BhChzT9/uX90zd7vVGGHrNtadkc4Jd9SoW
	pc4LaiiCdTW/y/1ogGWhpd3hcI3HY6uPPdTZ+tzlkrYB1wAJna80eZrWpQFle6TXHHXG8zMC3hm
	+ciEHN0yOvG9CgyycXdUbhUFFpjuJcF7reAbOvPwx08xWxoFvzzYV3MdfSzgnIn+d8bR6e6Ghu/
	VnZ2s8kSDsAvL2k1UqEQ7cT23ORrVtBuqjCtabIdpWuBHReYUGjhcW3W7pH1UjQRXGHurZEHzdE
	2JGrCrFqQxkAkIgRvO0UXXHKKNvBKCSAt6p//IZ8DTpNCVTlYItwnMo9suIb3J9nmmBif2Wyylh
	bdfK7S+6aCpEUjczWv4c3Y73pCC0zkBT1jlJgeeIniMO7f77YWPg==
X-Google-Smtp-Source: AGHT+IF7qXHHVzkc/A4LZc3/OOCfd4bntfLgAJ9fmFDfxjZI7wUewK6l62s7wJV2Xne6cYaDwau5ew==
X-Received: by 2002:a05:6402:270e:b0:640:b978:efdb with SMTP id 4fb4d7f45d1cf-64350eab173mr4093742a12.25.1763153351428;
        Fri, 14 Nov 2025 12:49:11 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f8e6dsm4387533a12.10.2025.11.14.12.49.09
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:49:11 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7379641791so50876866b.2
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 12:49:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1cS1iCLLMK+M3enoESVeaHfFWdXQ67auYXGDLw00nZ7dSEs9T34qdfbCNfsds/rozzlMtApDesInCoIgCUA==@lists.linux.dev
X-Received: by 2002:a17:907:1b27:b0:b70:bc2e:a6f0 with SMTP id
 a640c23a62f3a-b73677edbcemr485389666b.5.1763153349232; Fri, 14 Nov 2025
 12:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
 <20251114190856.7e438d9d@pumpkin>
In-Reply-To: <20251114190856.7e438d9d@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 12:48:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
X-Gm-Features: AWmQ_bkW5f2iQA-30H7SfZ-1SPQdVwpCHIQwF379qtfjWrYcgYHuVtfQQYOnQPg
Message-ID: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: David Laight <david.laight.linux@gmail.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 11:09, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think that is currently only x86-64?
> There are patches in the pipeline for ppc.
> I don't think I've seen anything for arm32 or arm64.

Honestly, the fact that it's mainly true on x86-64 is simply because
that's the only architecture that has cared enough.

Pretty much everybody else is affected by the exact same speculation
bugs. Sometimes the speculation window might be so small that it
doesn't matter, but in most cases it's just that the architecture is
so irrelevant that it doesn't matter.

So no, this is not a "x86 only" issue. It might be a "only a couple of
architectures have cared enough for it to have any practical impact".

End result: if some other architecture still has a __get_user() that
is noticeably faster than get_user(), it's not an argument for keeping
__get_user() - it's an argument that that architecture likely isn't
very important.

           Linus

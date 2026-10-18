Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD13DD508
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365146; cv=none; b=jERZBwe1uzzagDfAxp/hEj9fxyJ2LHeV1enIrEhKWSvq3uLkPlQ6Y8roAh5iMqbyNlInJQy6NvK0xddtdqXuxnFX0r/tiEW5ZaiBBrpO+dAJ2COGpwfVUPKsCIqM51c1GkDz0KLa6oMUTZGLIjlxaf6c1fGTqN/q1qfmHsP/E00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365146; c=relaxed/simple;
	bh=FmRZBhpqLPyc1UGxxy4qJoUHxNedPgUqXqvk3ujJM1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7m5h5A9yJckOBvpceCPtiJoUOjZjaToHalznFWG+TgPsdv3/Ui3D15aBAXWg+O/UfbijZ5H+7CPVic+6LJVmcU2z9Lqw+JNsFTOZUhiPZ7IJtgn3Yg+po3l3tVjCK/ww4Y86AN/GYM+MThGm+vZP8AdECMMunKPurNE+jvnkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ek9P7io0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ek9P7io0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c315869241fso150109666b.0
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792365143; x=1792969943; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=Ek9P7io0XQuBmImrw5G4oF6/3SteAtbZpRkTZsXCVvP8bPmyEWIfkTfK1pIx1TeBDP
         s9YVjVyVcjZXNl28O0ldIvlMd+VElg8BLxBQIKoEwCkweCzx4aDYQEUirih4Pll4lno5
         +55w/TBwPH6Mqn0ZzSmkyDL4XHJeHpajOtujk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365143; x=1792969943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppuPp4Of6QB0MqdJw5vbPQTFdSm51NtQw86VD0/q+5E=;
        b=cMiK4yS8kW+fW/OWPvGbO3tlLODo73ZhA6CJ4VYftQ4f5JXOuNLvmQETZnLrlGx71W
         mOerZuOroPTCYA+jFUpLHXOrc7JfotBBBDZTEI3d4iJX+B4mOWAm7URxa5Fq97Re1YD8
         9ms3Kd9dVb8uEIXvN7skNUoUPXhnAqXIpM5ZrcIzcTJosqhr/78a4IvhAwLEWMfGS8T5
         yUoLYtoI4KJdp9XG7JM7MfMu0T7RyB8xxR8zJXKJnoNCEz8x2K82xND8Lt/U3UUdn5n7
         n6E/xJ1pA8QwFyxNuwrq0NbuITdOAl73N0X5e+cNwA3DK7pK6Ldhbwvzb1/nzuPip0e6
         Ci6g==
X-Forwarded-Encrypted: i=1; AKwUvBzWtlBPovUyUHUYDjZoON45KcDsqmnysv0gvwkyKbuFiHCyZ9ipPmKAHBuO87rztl2Ndo1GGpVq03pcdgtfig==@lists.linux.dev
X-Gm-Message-State: AFq9FYKY5+R6uEJOS7F787RJ7jT/pAyeIIvzRuRi4FQag5HNMgyw71tf
	XXR9Vq2wBS6mjz0+XwwLq76xZO7pOBFNGCLi4jvX5CWXQj5sX4GcaVKb4uXOCVfPEljDp8W3wi6
	J5p39+uY=
X-Gm-Gg: AYBFou3NDoy7DC/0f9ObTsw5HG5tGqrFKlS/QBG9FfX/CSCzmKRBtSMauEUiUKXikh8
	SnDL2ifz4Pc722gfgKtVMc/hSFjF7La2HIqJ5W6huJkbHLQRuDmrq3O5gazF1lRiBuL6JSaFGIj
	bef1uBqc0vUzI88GEXMP3RMYV+laFALZ4kOW+hmBqKK2BTLMonvZ7dEVy0ldRb/71rq5/jFL2Lp
	DFpCwX7s/zk+tkS14QewBJtmMX3sLsAP4fuEU/4vdlviHLgVOZUa5xBIkjMlNUGTwLF0qoIZ4zI
	wK52YJex5m/C9D41sNxVvajlds5uyRwEy/JfdmcHHhMmXdved2dXrIKCTBBOISa9k2SVZIUCn6V
	RTPh4IKKlBnbqLJU/Og1Y44H2E8t76JoH0+mgP9xxdykSTAMicP9H6ZAOU9QbzoTnZnuYs04yXj
	CDwwKHKP9OXW68Sfs4xH+tYRyErdnDOuT2zrCTxoyhDvmDbkrlJDb1erOoyFP4EF1VUHx4KZ/vE
	VV2j5zoxbJyVm7KdidUrHrByfqvNa5i1oMox32on4MwL6Km6MmIXT+lfg==
X-Received: by 2002:a17:907:e104:b0:c42:34c1:1e5b with SMTP id a640c23a62f3a-c4234c121eemr171804466b.10.1792365143305;
        Sun, 18 Oct 2026 16:12:23 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32875fsm302336666b.8.2026.10.18.16.12.22
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 16:12:23 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2a4e013a44so176101066b.2
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 16:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzdCQx2GFr3f0PScpPMe+vt2Dlx3fzdiBBwUOJFFcwYpLiehvAy6nqJ7z9/uP3enNP4U5INEedqnlHQmkPjWg==@lists.linux.dev
X-Received: by 2002:a17:907:9494:b0:c3f:7270:1093 with SMTP id
 a640c23a62f3a-c419f706c4cmr443663566b.26.1792365142168; Sun, 18 Oct 2026
 16:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin> <20261018175347-mutt-send-email-mst@kernel.org>
 <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjneFJ7XmZ6ux-LsHq4apDgANcKfERztmAG9sGVY_TxAg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 13:12:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
X-Gm-Features: AclHuK8ibgIQ7ZzCJT6T1XNCTCPJUVy2j1kAdMYMCDJTCT4gsOXcLC7aX43RNik
Message-ID: <CAHk-=wjZiwN8=PGEVm19QO2SiO29aA1E459+5mVQ0nmNoqOpjA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Haoran Wang <haoranwangsec@gmail.com>, 
	jasowangio@gmail.com, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux.dev, 
	Netdev <netdev@vger.kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 12:06, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> That's a separate bug, and you really shouldn't use __get_user to work around it just because it doesn't check.
>
> You should use pagefault_disable() around the access. And if there is still a sleep_on() complaint, that should be fixed.

Ok, no longer driving around and checked: using pagefault_disable()
around the get_user() should indeed fix the warning, because
get_user() uses 'might_fault()', which doesn't complain if
pagefault_disabled() is set.

Admittedly the actual fault handler uses a different check: it uses
faulthandler_disabled(), which also checks for "in_atomic()", which is
why that __get_user() case just silently happened to work (badly).

But that check is historical - but actively wrong - the added
in_atomic() check in faulthandler_disabled() also checks for disabled
preemption, which is one of those "it's not reliable" things (because
the preemption count depends on whether preemption is enabled at
all!).

So no. There are exactly _zero_ valid reasons to use __get_user() and
friends. We really need to just get rid of that broken garbage. All it
does now is open up potential security holes and allow people to avoid
warnings for actively buggy code.

               Linus

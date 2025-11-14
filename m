Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30D3446D9
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142505; cv=none; b=sGsdIzQzxG4Dth3n1+o6lhCL5bsijr8sKIpU/MS/NaHMEk7WxKn5zSxAhhVJyxqF3AK1GV2PZc0vUZtIjBxKQEiOTICYElDEt35+uNnsg6n5mfbd9Q0pjQCiX+F9pPY+AfUnDEzocPgvq26pbEFEkDdFtQRdo/VuMrxwYqOhYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142505; c=relaxed/simple;
	bh=M3lRJLmEZ7JGwWTvf6UoV64DNFaFI5lqaxXQ8tgqiIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axx2I2CLAcr1UT4jOcpWhLLPBoOIAN9Q0FnNH1R1cTf/8HIKrWxlHGYIgDLgJjQ7nm5wA3206jKy92HkzM8bIEfV0B8V/dy0APJAD2c57EMXNQpoSK/ggBYblHpZ4qloj9TIDjfBf0BDv7nhl0Mh+83JSRaoIulzkXTjeXhUCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RzG4vh++; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RzG4vh++"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so3666510a12.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763142500; x=1763747300; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg7DjlCq7wS0LcCCJEhlzHEukmpZjrkwro9CVQtSZwo=;
        b=RzG4vh++6k8XNM6kWh04/BMqY1IvWMvNfTrq3GoN1HNbzaIvX+Bf2CWtxX9ph7xwqI
         D62XI2mNcwwy6MzaWPqF11v7d0PO9KG/ZzVvYAbiP2ndUE2QsTON8js1Mg4pnTLHB+74
         9yTBIYawPDQAKNci7GDLFr+VCWOdrMAU0xjAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142500; x=1763747300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zg7DjlCq7wS0LcCCJEhlzHEukmpZjrkwro9CVQtSZwo=;
        b=i6RbieDEYkwS0+LpkopauHbdVmVh5KizqjCA9Yhv3ZIe+n0iS4pNsWDwpL0ffUpYjR
         ARVjSovI4OzLnHFBDoqCV1qvvih5AZHOuRu8awEEWOM6yAb0Zz6J8z5vnHuqJ+NCykPf
         hP7dVMi6rWxQdWmM8tIVu2vRD6bW4zqjVAke2yYydJ7buvZJVvnbNFbcqq+0+LSw0/na
         L5Z0bLnK8hthxpjTFTj1HOzWrs2YnF1fQP/mur9FMI94xIfHhL+YTYxYeaPa97NRUXgA
         EstkMrDBw12SNEri1DpMQMIEdSaVo2VgMphH+FK8UCQ2uioQiDgEqJxzmVgax3zTmdIb
         /GLA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcUyIeK7EOEPcQwi8mCbWgUN7fPBTXmfAep1TVfk2hSbG4LAa3RPeLBTxG3ZfjMYH73oQGbYkIP3qBqW+lg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJNMLRobk/aFZzfA/XPZA3w9y+mm4WncUk4Y7iRHNW2Ef69uE1
	66G8EWEXiRzZfEq8m6tM8VMp6TAusCaKzPNTMZh5Yg7NBStC1NCNufzIO+RdVTOvKKzMdSsV3LT
	P6bXhUw8=
X-Gm-Gg: ASbGncsYO3l4GQCtVrxEgkOQgxgqx7peaY/IKpzAlg/P0vFFKt0iqRkbCxohObdQRUr
	+RHAyGoJOlK7WEKrLmWupbIzxx4Jydf5t5Dex0I81DV2NgyKrdR60mkJOc9OqemmxngzvI3tV13
	NBQgjlRdPYx8x4gCgHcXGZT919R6GN0KthRjXzI7iH+IhbB6JD4OeVUq2DC5oE2810s1HVgTukH
	p0OoJN0ZMuKjGdRqrW/EVdS+iw+5JwXNZkRrVV4LHSRpUTKgQV9JhnwMWI13uRpk3lZvngeltjg
	B6V0/VFxdh3GTHh6Ifme0RVg8tIUniRrmhQ4tNmCx2zij54qAQZxaYL1MqY2Ax6F5oEExe45X6y
	hx2Y4MtQqb8NCCUVdasWFouuvkYEYQydtBHzs5fehqgyY9hEw6jeW5lAfP4VLlQapt4RdRWE+xL
	fcoTe0ZZPL/bcYcb50fEKE3yumZBF1fNknOeQfewSJ1THk1qIXJpWi42oYuILL
X-Google-Smtp-Source: AGHT+IFPnMA9mvbYPaRaVJyfT6m7LAm7fFHciJXg1UDCT6+oFM6PT2VhiqSQsuLR7bXAK5EpAmoIXA==
X-Received: by 2002:a05:6402:13cd:b0:63b:f1aa:11c8 with SMTP id 4fb4d7f45d1cf-64350e0511bmr3603745a12.10.1763142500054;
        Fri, 14 Nov 2025 09:48:20 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497f1csm4092166a12.23.2025.11.14.09.48.18
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:48:18 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b728a43e410so356420866b.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 09:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3dXi9GRA2o1dWtXBrvbwkIMOJV+rwkDpN1DrHCqXaBQLk9A3oEJRqCnM8/0mSIqtSGz0xiXnH1DfUZXBSlA==@lists.linux.dev
X-Received: by 2002:a17:907:a0b:b0:b72:5e2c:9e97 with SMTP id
 a640c23a62f3a-b7367b8b6bfmr305496966b.36.1763142498394; Fri, 14 Nov 2025
 09:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
In-Reply-To: <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 09:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
X-Gm-Features: AWmQ_bk0jgyM9fIRt_Ee0fGAZtYocBkhM5AivJHg1mQmAcGyfeiZb7v3Ov-HW6k
Message-ID: <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 at 06:53, Jon Kohler <jon@nutanix.com> wrote:
>
> > On Nov 12, 2025, at 8:09=E2=80=AFPM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > It has been used even before this commit.
>
> Ah, thanks for the pointer. I=E2=80=99d have to go dig to find its genesi=
s, but
> its more to say, this existed prior to the LFENCE commit.

It might still be worth pointing out that the LFENCE is what made
__get_user() and friends much slower, but the *real* issue is that
__get_user() and friends became *pointless* before that due to SMAP.

Because the whole - and only - point of the __get_user() interface is
the historical issue of "it translates to a single load instruction
and gets inlined".

So back in the dark ages before SMAP, a regular "get_user()" was a
function call and maybe six instructions worth over code. But a
"__get_user()" was inlined to be a single instruction, and the
difference between the two was quite noticeable if you did things in a
loop.

End result: we have a number of old historic __get_user() calls
because people cared and it was noticeable.

But then SMAP happens, and user space accesses aren't just a simple
single load instruction, but a "enable user space access, do the
access, then disable user space accesses" for safety and robustness
reasons.

That's actually true on non-x86 architectures too: on arm64 you also
have TTBR0_PAN, and user space accesses can be quite the mess of
instructions.

And in that whole change, now __get_user() is not only no longer
inlined, the performance advantage isn't relevant any more. Sure, it
still avoided the user address space range check, but that check just
is no longer relevant. It's a couple of (very cheap) instructions, but
the big reason to use __get_user() has simply gone away. The real
costs of user space accesses are elsewhere, and __get_user() and
get_user() are basically the same performance in reality.

But the historical uses of __get_user() remain, even though now they
are pretty much pointless.

Then LFENCE comes around due to the whole speculation issue, and
initially __get_user() and get_user() *both* get it, and it only
reinforces the whole "the address check is not the most expensive part
of the operation" thing, but __get_user() is still technically a cycle
or two faster.

But then get_user() gets optimized to do the address space check using
a data dependency instead of the "access_ok()" control dependency, and
so get_user() doesn't need LFENCE at all, and now get_user() is
*faster* than __get_user().

End result: __get_user() has been a historical artifact for a long
time. It's been discouraged because it's pointless. But with the
LFENCE it's not only pointless, it's actively detrimental not just for
safety but even for performance.

So __get_user() should die. The LFENCE is not the primary reason it
should be retired, it's only the last nail in the coffin.

             Linus

Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A941F5CC
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488496; cv=none; b=cxuIZPpWfptGMX3P4MAP5pe6SHDmYoaeW7g9Df0BkIvZ/r+aACXqcgtKSoDlvHGohNzvBLtrbadajM82RGjXjLFIKoWU498O0/+kt0zaCxuxucuaCjD92hmjU9NviKYCVbCfEGunkwZV/+N2QdiQlQhZCyztE0mmy6za6wmvmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488496; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEpp57ucal5AnRJEBQshbx+aIBc5gIvVqYUSt6O+BRYBz8J47bIKjhLWWRoAsK3XT8rP/fkDi1X7LAVhu0e9qCgPcfRiuviOPShBdo5V3wgUCNAWpOw9dyu9n6NA8xIRGGUgaVFdeEnTh2RkWpPich4Zj2k+WxwcGmABGg6MVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KFpGw6Io; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KFpGw6Io"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so2044530a12.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488492; x=1790093292; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=KFpGw6Io7OJyKiF8k9uuFwyhBP4PFoZDIl9UcsL9gth0qzaiCufJqx+QjfUsGdVRZp
         7z2lZNkbeA5mvpg+Cuv5v8I2mNy9FHcu7XEAUZMPN6rAQYljhw7TgptRHxFNem5olaA3
         DO3hu1dID5eGT/C3vAgIpaQFoATxtbxyMpPxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488492; x=1790093292;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=ETshj/r2EefKMvAIM4lNKn2EoR38A3542LG1t9y21ZS2rccs6bs65pFQphFYDmreMW
         RJDUKesNfty7cqOSOTMUqJ+So2aViUYZI+ArAz3rcNSWlhILSzdvhvzL6sr0b3U4bAMu
         6Rv/bHAnN1qEqpcMzN04XVbKvuGxCwgk8JgBDwn1KKlUbdswKwn7mqiuDQ454ubWXFnv
         z8enCfxd02NBAv6gonTW1sBykGEMlYifiD7KXp3X6YpYOcpJVteoqYuRw6TiC+Dx4r55
         avyW51RlHqmolgGcvLMNdOoRAeofQmgueQ4HTAGK8tReFBNJKU7Ypyh6uBIrqfI9Q8Ca
         54FA==
X-Forwarded-Encrypted: i=1; AKwUvBwQMC3E8VSGzm5o8JdXOt/FUrT3KcBurca/raqVfzsm5WY2k/Ac1O6lVAC+onz+3UAdFTdOmZUMCihxx7Wauw==@lists.linux.dev
X-Gm-Message-State: AFuF++k5rf6WIew8j6jOPwflnj1fBGtWWoLlBIKaq37EqiGB8upzCLcW
	/FSWx4ys8xCXszLAZD9zK65vwWO7rjbJYyzKj1jI7xbSf009TPcri2ZWfNpE+wjITWKIhLcPZWS
	mAgDf5b8=
X-Gm-Gg: AYBFou1SSK+yqZlDwu1irLovaRQQOtsUUvDZRz4SudPrDp6+w4zTMZhw0c6LkmuHNDW
	PcboAjoAG4XsAQb+LjUxYB12fcPoFJhsHQc4GlDjuWhRcEC/s1JIvzGxfNHSyVqIqvn6yifK1HU
	FB+PW81BO1vIN+8tOTqqn+DOAcusMcGhWdkAF+Skarl50KG7k0mGBoQCwDvGy4zRcJbvJLhLUnf
	hflYbpgbKv8MZGcnfHEhulI6oHKdONdQ/J9bWlX55CDdj6UCdY796HDKBVUY7iIJB9pyKvfnI21
	ace2KVSf80xLiz3VFAhwX4jdin9h3XHwqvAGP9kY+P2pJvOn52tA9PZ9/v8DM2q6OMTD2ON6Fez
	ca7+6Jp3Ehcc35P6XnsPEZ9Av52n3TKAJw42zRzmfGaCpeL5tzzUpTcXI1h/P6DVp83ghzwVM+I
	bGY4nx6kDSMDlqIMpD+7F1Vz4cWVMTskXtxu3r5McILIF4yybGbOfhU+vU2HrhD2H96YLNpAAb8
	8Coo3kcs11CHO0a249A0gvQ7or2mKViBd0zghfDgOyK3gfKew==
X-Received: by 2002:a05:6402:3245:b0:6a7:ee55:dcc9 with SMTP id 4fb4d7f45d1cf-6a9f63cd7d6mr3835557a12.24.1789488492140;
        Tue, 15 Sep 2026 09:08:12 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b594e462sm6295997a12.24.2026.09.15.09.08.12
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:08:12 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso538189066b.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByte6MC2UN3rKSZ4fXPdTk8KbqxaiZwB+gD/b6Mowh2XjhFhDeRvxP6vjhhWF8Sz9oEZaogCT9GoME3n8+88g==@lists.linux.dev
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus

Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F64CE681
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499362; cv=none; b=HFjF0YwNeaQBszoZSV5ECtQWFADrgwDR6ArTt7dLwVmO4EJeqfBynid7QJeliAE/Go5FWveZ7sT9Lo2TyM6V+3/JdkLUMtgG+FuhDtggiZER7rVZpkBKC9KzSLp+sMSnys3GzdhfHQfcNsYUaiGTknsswvo9zi4THkBf8tlxdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499362; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueEXYuHZE8K9zaXgJuqxna6HtsXXaNQaJ2vMrGXlxtD3DTTYOrQP/Y2aXuuXTHli6vOGbKWxIxf0FZU6j67WVx46D5/ywYiv7/lAWUaQTxvH4NTXHH6VGNTFHOpWMX1EAWY/ogwn4Jkm/iOVD1cOGyNBn7xNptbJUQnXQUA41o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V3s9Yuam; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V3s9Yuam"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so254736a12.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499358; x=1790104158; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=V3s9YuamrCt01NNfCrDScq1pVZIeBzVXEDFo2Zz1shTDSzHTGE7wDhsBJDhCoQUBgj
         +VQxxh3VIhaFm26MB0r6hA9UNkCcyZJuxtluZTf0iqi/aws3ts01LkTXZKd6JdUkJCL8
         AuKrpKJnqwzWwHcy+Ry3oKer6qp+64mKtpo/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499358; x=1790104158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=Aj1/943nPjuRCYpeE3jIQAxd3JgmfjDJvZNBvwvvEqQtbrTK8uC2SdHNVXbuiq23sk
         IrMJgG6a0eBcp2/nAmYhJhDcNMkkGsoRbBIufP4h3kfqhEkIHVAwR1Mz/kY+IKONKwBl
         OPqxSwOuWOKDZNIpTD0fg1Qz+eg3Az2Q3z6fMsrTheQBydYS2Jxzi2ZmXVRx94JgA8Fr
         bmgI3hft9yhq/WvlG8YR63jgyrcRf4YCttbvhKhxodGlMLY1NdVvGY1X0aTAh6QJM6Ua
         lIy+9XiAre1Z82zbTPTVM8ovENPzjMAy07ctx4gb6xHnIAvz+AedrBjxOTtoRflFgKA1
         299w==
X-Forwarded-Encrypted: i=1; AKwUvBzXI7Sqeh5fdawtsmU66/z3hMhL6fpYwO+EhgEFDCu+DPWCkBvv25TQ3Vit3Vorc0sm5NG7lmKyVW0KTzdUNA==@lists.linux.dev
X-Gm-Message-State: AFuF++meLUNbZ9EaG82v1GC58jhbG2nRrfDuFpMi/CtXEtEE1WCY0zl5
	/yKOxmYB5z0KoWwpaG37FjtM4HF35qum3gxjddXt8CP615TV0gIn1VOED6mAYQkYgJk/8xEcEOm
	Q1evlfNk=
X-Gm-Gg: AYBFou2JCiVdC7L0Rwh/3RqbDPMErHl1YiiVGPNzHeJ3roEQOzcHvs3/CefIa7NOr2z
	d5X2LWUEuZjc2BVfJhLrU2fjrJ0UAyXHUImsHMBvs7iIWlSrlX3LXKHcfKVIpn0l6OFXmPmrGFl
	XCG81oICULDb/6RCh04ADax0RYe9PuZxWqOxOkBT5cjct7aupr6WXpI06DjbyNAQtsclJa9j2sf
	mYpCE3pxnjsOlNSIvKYM45vp9O5zzm15hJYk8BuuLU5dOwVhvet/+TmrtxxvLS6aU87SgVuXEPN
	oftLVjA+ARG7YyCIKgJaLXmO25rCJD06dcJwaCPUm5xLHSa3IfVJJXNbhvld2Ur8j6d6ap6G0yO
	TFEjiodLOmjFG9Tmer33GbzFSXKGghP0roVWXpPQ3Cr/rTAjn4mBNHRbLTsDZHhiA8IO00LKcQs
	J78igfZXGqQ2eHk5mXfqG3t0H2EeryqNd1ztjTMIpaIN56vonMiZi1bLa4rzbUBHnJW5QM2Uo7n
	gKJN3WllOOfXiKFNlSEKi7XbVtrE/9+uZCRhvY7o3UdkIUfqC4=
X-Received: by 2002:a05:6402:1ed0:b0:6a6:4783:b6ff with SMTP id 4fb4d7f45d1cf-6a9f61e3cefmr11240945a12.4.1789499357588;
        Tue, 15 Sep 2026 12:09:17 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de454b4csm16635066b.17.2026.09.15.12.09.15
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15d3so28233866b.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxyjDT0zGdfeUd5jyh2NDgPl0HuYk4llWHh3PD3SlePjynuL4IMPQRlqBM9nqzmz+FvcfeuJm2bcw/h/3dGtg==@lists.linux.dev
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
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

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus

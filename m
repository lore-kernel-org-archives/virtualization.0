Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849511F936
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139395; cv=pass; b=Blo3sp5DBiZaJfch7Pub+xY/AwLa+ucoJrTKnuxDkXToHBw99w4su1BE6oOnizNP4bKrCNh1WZAYdXP6boDTYkxLOKOxK81dAXk6fYN5EpkNUczncYSAH1FUyJJHlpMV4BQShLah/W15EjsVfOHtCuEQNJPVCFmYajWsKia3HZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139395; c=relaxed/simple;
	bh=VBRKuMtuCqLj93aJNz51SPAyq2ccWdxygtbptJhcxBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhbJCVmehGYXa5YJ2RxgqtL34zWgajD3DMGV+vcoOwXn0hSs7/5rGxT18DbnHTOs0OlPR1fe4gAfUyMUchXhF1R2tQ8nIbPIRs1j32rtVelJQm3j5PkSUUfPpOO+vYgoE5Y6habb/UHIGgaEX6v+kbO1eE75qiAGzVkzwqpIMq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgtVylb+; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgtVylb+"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aae90e595fso724585eaf.1
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 04:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787139393; cv=none;
        d=google.com; s=arc-20260327;
        b=H5ubL8F2vtlOaZ/hfLUj0BBShYpmc6dtZbOgnKX2KHpD3UHJ9qfEXzBKm4gdeJ2+Wq
         JEdMcgKizCPlpa3u/Ghf6n/qetc4w0MjLcmatdRRnmSsG2BeBM0h9or6KavzC1w85pnc
         M4bCKC0NiVzxFZNAGCHs5aF53mN+VDaVeqV2VDz3TMumIckxlTQUjKgR85onGhZiXkCM
         zWVEJnh0Q6rll6pHEKRWLg9WU68Onh8ptaKjlB3nVfxF5i2RduuohbANakTZIQjglxnO
         nu5L5MRkogUXORF+n5fnLPbtjdcPWbeXyAxlVICabyHJQvCL9Z0VH1o52b6U3EZw7slP
         VBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WiTcXzWjFW9VvSGAd4Nh41NQA5ZfA16GyaEsqmo4A5s=;
        fh=Gy5r8TBQ3ZqY8fiJH/sKHNKHQwnBrf6tIukpoZkxnY4=;
        b=n6TLymUX+Ln56MsQeBwkUn4X53GYp+/0r0ZtZUJtZXijXCTIO1z/vM8wsOpZGYXojL
         8YoN+2myBPrvoHJdqvLlpBXZ3123+biDFpoE74UGXP3nCDg+nsTYrwNayuVc2VQiPdEm
         TutmOceClvyD5mDkl5gQUuIjX7i3LZ5b6mTFwpnTphg5IYJPfd7/wuxJ2IdA+NFM1RoX
         E6T927bnCmNqsHSHpKkzobf+rFhI6fk7g2dwFvAmhmrJgK8OQy/KUOqXqJi23sks4v47
         Ak6DD28z9B6QSu5aJG+9uOLh10IKsZFO4ufvJkvdp3gIgb/MvZ0+pizCc0s/0zuJ7Olb
         cqtg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139393; x=1787744193; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WiTcXzWjFW9VvSGAd4Nh41NQA5ZfA16GyaEsqmo4A5s=;
        b=YgtVylb+x8pjR++pVzVHLXdfP8btMMyn8duRfy6fo5c5uxOtQWYYo9sRa5gqcHb/oK
         nK/EH+xsHTZ9Fsukyq25E3a3fpkiaYDPn4526JCzL3INNkch+DCW7i9eCeSdSFVrQ3C+
         agH25kEqLvO9nYGVB/kRUOpV6ev8JdwX1dlkdENGzJPvUnAoZbb/wMj+RggPIGZuQnfn
         z/IFOcz1BuXK1kytHxIPB486LQ6KXyVAog75qcOGJcHpV3dV3VjVtJdZBtOfXmPG1tKx
         as/MEIjvCsMZJfVJ/aVXwK3pxSwDRco5dqXW0YAV9sPHlAVvYgX5vY6N8jXHQs8ayD8t
         Ze/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139393; x=1787744193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WiTcXzWjFW9VvSGAd4Nh41NQA5ZfA16GyaEsqmo4A5s=;
        b=DX5yAerUZ0BStSrlRzrW4AiQUIXZdNa6ajEUKy0N7LHqFlkNS4AgIeLAdzzXmTZrS/
         bmTeet0HNJQZb9n3AGv0pbAu4gkXgpwbFiJ0BbS6Hvko44zs7nztadiHwVXaInXjKQup
         Xi/P2w4P9IoEhPeAsTU1z0gprPJ5fVhA43BZ9DFE8fw367zfVweeHKmGj9H7AD7ismTJ
         ZiA52VetzhWva4h3OtCWQt8ZtAIk3ShN3oIs90TRH4GANY/gQ4zn7v1vr53RDKCtRusj
         zuErdvJXMVSOlZNSGwu+JcL+t2nC5k10o+8TO2Y+NKO90XUK3H2FhU9SnvokUZOSWnlu
         97Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrbdUploJ+X5+64wsqLhiYMxHAKuEMDZorYVN/sxwh8/g8cusrPCJnjdhdbLpnbXYcA9izl4AGmEEgKSApGYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyPNXTZEwKY24PjQ54y1YIsdcHE/TVPFhAt+5/nyYd0dGgzZMF
	sqABKHScsq7P1f6Wg9MVHtp/N1gNvM2xuBy7ubBLL99UWnYODJCLQ9poo5XpA0koL8KoLP5qdoP
	ObvUXbqUEUzGK0nAAVY8xpgQuWJ0Fy6g=
X-Gm-Gg: AR+sD10K7aruFFUzbt/bnKNceKhHFPRC6iQIWReuwCCyVnPuctKwhS3GBtJNm2AgmBU
	XspFTFuvMQ4HcCaKX5Vr0ZnnnppWQ+wrskY41BDldGxSMjSp3yXsj0qHu3o8UFxHtj+lZSklCNb
	lYdCkJvws3UqMSk07XCT45LnzH5DKsG5M3PV7BSPb83JSq9snY+jSQgvY8I07tZTIhnqFP6i5vf
	9SKgYbEA7LgyS/7itXv4opSNjXjtnZL+CVTJPF3j6/LKUmUYFj3KKpx61RiLd1hxkKACJc9jwmt
	CoQOvvUE7uSnPjkFnMAxpkyTZ8QOJ8yO/11MrON1rhsf5rSMZYO8J5DU/V/qOpMHQYz6nPvCNBZ
	oMT7cQKxRY8mh7kJ1nhdmZv5+2zXPlA==
X-Received: by 2002:a05:6820:2d0c:b0:6a1:47ad:d18e with SMTP id
 006d021491bc7-6b13c2b874dmr3346337eaf.2.1787139393394; Wed, 19 Aug 2026
 04:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810-serial-v1-1-abbe51602c13@debian.org>
In-Reply-To: <20260810-serial-v1-1-abbe51602c13@debian.org>
From: Sungho Bae <baver.bae@gmail.com>
Date: Wed, 19 Aug 2026 20:36:25 +0900
X-Gm-Features: AcwNN1X812LLB-Tptma_P24g8yVgLl59ojrUYRd7kjC3eMW6XcMa8rfkI4qnidE
Message-ID: <CAMozUa9Z472cNXHwQNxsgp7wu3MsiL4kG77uoWocQdzC2L+n8w@mail.gmail.com>
Subject: Re: [PATCH] virtio_console: allocate the port_buffer with the
 caller's gfp
To: Breno Leitao <leitao@debian.org>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sungho Bae <baver.bae@lge.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

(Sorry, sending this again as I forgot to use reply-all in my previous emai=
l.)

On Tue, Aug 11, 2026 at 1:46=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> put_chars() runs from the hvc console write path with preemption
> disabled, so it asks alloc_buf() for GFP_ATOMIC. Only the data buffer
> gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
> the allocation can enter direct reclaim and sleep. A write to /dev/kmsg
> on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:
>
>   BUG: sleeping function called from invalid context at ./include/linux/s=
ched/mm.h:320
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtme-=
ng-init
>   preempt_count: 1, expected: 0
>   Preemption disabled at:
>   [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x69/0xa0
>    __might_resched+0x37a/0x4d0
>    __kmalloc_cache_noprof+0x94/0x5f0
>    put_chars+0x209/0x3e0
>    hvc_console_print+0x234/0x640
>    console_flush_all+0x4fc/0x950
>    console_unlock+0xbf/0x1b0
>    vprintk_emit+0x312/0x510
>    devkmsg_emit+0xba/0x110
>    devkmsg_write+0x21b/0x2e0
>    vfs_write+0x4dc/0x9d0
>    ksys_write+0x108/0x1e0
>    do_syscall_64+0xfa/0x460
>    </TASK>
>
> Pass gfp on to that allocation too.
>
> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ow=
nership")
> Signed-off-by: Breno Leitao <leitao@debian.org>


Looks good to me.
Thanks for fixing the part I missed.

Acked-by: Sungho Bae <baver.bae@lge.com>

--
Thanks,
Sungho

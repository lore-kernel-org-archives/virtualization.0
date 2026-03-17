Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5B371CFC
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740731; cv=none; b=tcYqzDx2krTaAkST8qCI14jdoL6HqIW3ALK8EYsoypaCdtOEDYNTQDR0WJiSfEuIidHKzz3XLBY1X+z51UcADAIsag+K+suLN12q3gs8490EsA8K1oRwGsh/9gaAyssWhOdemPuZfUkWFR+Nmh7+gyBLC3ibBvdjETip8or9ixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740731; c=relaxed/simple;
	bh=JGBz0SdiTulLcKwRUnaZplsI+zj2QfUegXT7Nov2gO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK+3nlX0YaKO+OQOuj0RT/+jPZH1eY0Bm/z/bMYmHFY+KY+tMLWNc0i7haQxBHrePVA0MXNG8g1qYHDGJAyZJDzIG2ngH4bDgG7gV7xEg4QSz488zIMm9vpRldJG4Ik1eaWPuQPqB2tvjyimBQoIFH6HRsYNe+dwL6EliBJV5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnQMs3yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnQMs3yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1C1C2BC9E
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740730;
	bh=JGBz0SdiTulLcKwRUnaZplsI+zj2QfUegXT7Nov2gO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnQMs3yDCcmFOrk4R10NlxOp1qHZasnz84rJHrEAlX/FnzPd7AGcSz1uiUV6vwg+l
	 okDB/3MJJyLOD73Iaw4DXFwZB7Tx6OYBMXzlfbpTH4qGGR34HYApEstbaCSaVmoN6j
	 YuNlvAGrDMmZ4D++z0JIDgLqf4drvNKBLvAICWv1Ujf3Bv71kD7lIsNn6DAc5FsrpD
	 n8wlOnUvtY6BEb5j3HWCiNOt8HmcYS82Ok/lvPq+4gZJmKNEtGNXWQQjTcUBb1VqiW
	 YqKJit6vU6BWfc5HbyVFR4oa7B8hbhPBMGsNBlrHScYTtLjLb0ds8MkB6eXf18T7gS
	 L3Jc/vOUao1DQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79801df3e42so7972397b3.0
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 02:45:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJrfnZdDiCqt6NMEkq8Fea1SuSqVqhCoPAs82ijAf2XBnmZ94Oi5IiHldNTfiHn4a3ZQduXgngzotVRZfHHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN+mpj7YIwg+KQpMpvAiGuWZj3rO4wxCKo0n+uy1pHxgnMCNlP
	vAat4VYicGhLmVQvWNd9vaeoG002yeGpEvry/vLU8AUs8RYDhaQE1d/1m2+zghgeVY9bc6HHvhf
	kcB0xXbiyKRFHmnjskJEt+s3VOS5g5T8=
X-Received: by 2002:a05:690c:9688:b0:79a:3564:ee8d with SMTP id
 00721157ae682-79a618e6111mr20649057b3.26.1773740730046; Tue, 17 Mar 2026
 02:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com> <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
 <CAD++jLnTJGt2YXo6ASXEjPPsMbrr+Mz3RKcCVeUpaWEMPm6DOQ@mail.gmail.com> <bh5rgccasvor5xjunkc7wjp3resyulehnqafhzlfwqx2ealwxw@eqohebwzjq2a>
In-Reply-To: <bh5rgccasvor5xjunkc7wjp3resyulehnqafhzlfwqx2ealwxw@eqohebwzjq2a>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Mar 2026 10:45:19 +0100
X-Gmail-Original-Message-ID: <CAD++jLkKqF4ooL7zC0dyT+k7o1MC7AyY-Xat5xSTzSZ6KdLHfw@mail.gmail.com>
X-Gm-Features: AaiRm50c28ehMzG3FZtQnMIktiveKhdLesYuHZvx6K3Ld6TrmqPk05dY8AJLm7s
Message-ID: <CAD++jLkKqF4ooL7zC0dyT+k7o1MC7AyY-Xat5xSTzSZ6KdLHfw@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:49=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
> On 16-03-26, 15:00, Linus Walleij wrote:
> > On Fri, Mar 13, 2026 at 7:09=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> >
> > > I wonder if it is worth it anymore. Why combining allocations is bett=
er when we
> > > are ending up using more memory ?
> >
> > For the same reason we are starting to use Rust in the kernel, despite
> > it sometimes will take more memory essentially. __counted_by() enforce
> > the same type of runtime size checks as Rust do on arrays.
>
> Right. I don't have any issue with __counted_by(). It does the right thin=
g for
> flexible length arrays. But we don't need a flexible length array here an=
d so my
> question.

So why check for something that "can't go wrong".

IIUC it still removes undefined behaviour from the object code.

If someone managed to compromise the kernel using return-oriented programmi=
ng
they cannot call back into this function to overwrite the memory
beyond where the
array is stored, because the runtime checks will block this.

But Kees & Gustavo can tell if I understand this correctly.

Yours,
Linus Walleij

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22710224E3
	for <virtualization@lists.linux.dev>; Fri, 26 Jan 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297507; cv=none; b=C2s3j32LrTl7Mwl8FMKcgKsnBYLvmTfqwQfDJMJzx3cLd0QPEg8nTTF4mAouji6pRhyIFD5JW/UZNDiEB4/JNldxfS3Xbek4wmOznmyQyLkHAJySPv+8C4Mbf9ivfuUpoVGJx2aRqWbgwoeYYPcIPfibpnHABaet3SHDU4Mb0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297507; c=relaxed/simple;
	bh=QJ9CAa5A/yNS1CZvD8wdvEiJQuGv9F0gPuW/DiBsYxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GViuhEoEceRK7H9fCoQnGn7JlEX7H3uYCfnC8PtrhwEbpw/1+o0aKzXnKcRj/eVXfSafKhlLB453FhFf5S6Nr8lkT8pULe0CO7AM7qTny4SLvHWgwzrHCX6JJMPkEm6uovlQF0zXlvU9ZrxwbX3IoquVw12eDo1PKzb0I8umxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TT9BWieN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT9BWieN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706297503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8O4KZiKHB/hwZHbW9Vu9NJR3ZSgU5Japxu+5xbR0p5w=;
	b=TT9BWieNHRXN2ezqmV+/toEUjF5FC60yUOHwjIvblQlx8HIp2LFkgo3KlGjsqDDetCf4P7
	heh3zTc+ZQyMZZbbO4PRIQil0PhPyCBhIrYXUF+RPXR0SEsg/kygPuHuX8rFA/wqpG2ZHA
	J0a5T2GB9Nl1Q/4q9QjzJEeOOjuzJrw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-X3zJ2qXxPGGaTI-XwZg9uA-1; Fri, 26 Jan 2024 14:31:41 -0500
X-MC-Unique: X3zJ2qXxPGGaTI-XwZg9uA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5fffb2798bfso11057197b3.2
        for <virtualization@lists.linux.dev>; Fri, 26 Jan 2024 11:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297501; x=1706902301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O4KZiKHB/hwZHbW9Vu9NJR3ZSgU5Japxu+5xbR0p5w=;
        b=dXsOUeRotpt4bOouKUEsSKb9CRvS58q8QK17lOIFdMjjS5pQKr6V3q3FCaKi+DpCF6
         faoa/Mm1wk7FHRrQ9Hg5c4aU5nXkUzh5CkdKBcfOgWFETQYfyGmZGAvXykIY3/hIXpLF
         ekPHf+lFOnGGDCfLd3Rl+KLqUUK/ALBHygS/9GcVhC3ur1AgW0qZtPO5prxfEfmPZtGr
         b9IFCcXECmd+hahKX6auoVk95UXpC2bc54SXXdMZ7t02CWl7LQ0mUgU3/NIcxsoWhYsr
         hFd7+h3VZB8DTBoho1yc9Phr+2fMCkLp1sNJgqfBFj6ROUMMEZujlbZ+IkST3wcSwxer
         u5cg==
X-Gm-Message-State: AOJu0YyqFUy+aWsd8X0qYWOplr+83GdvGqaPEtPaknBTPQcXDxhiwzAF
	z0nOPbF2ywMTHSe5ZOWHiw2SPJp0H7EG06ovx3hVBf/uCuDx8g/zIiNPF4QWu9fTzWRHxdzjRFj
	mgsQ4r3qc/NW3Qpw4sjgXSdVph5lRWguqjIEckH2QMdMNv/DKwlN4oh6Esa3UVbBqeO9JwR5JD/
	7UBqT394OZSdMATwCNhTR6nRxUBa9LUsFLMjsYAgU=
X-Received: by 2002:a81:4cce:0:b0:602:c7e7:4721 with SMTP id z197-20020a814cce000000b00602c7e74721mr291690ywa.98.1706297501189;
        Fri, 26 Jan 2024 11:31:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0RByXyJ/rysgPkfpq/s7XLE5JytXnsA6kZpBjPROqnD6sbZsuB+j2dxLKBC6MlOZRhXkfdAdA9aE4HMKjgVA=
X-Received: by 2002:a81:4cce:0:b0:602:c7e7:4721 with SMTP id
 z197-20020a814cce000000b00602c7e74721mr291681ywa.98.1706297500954; Fri, 26
 Jan 2024 11:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-32-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-32-keescook@chromium.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jan 2024 20:31:04 +0100
Message-ID: <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>
Subject: Re: [PATCH 32/82] vringh: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:42=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
>         VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> unsigned wrap-around sanitizer[2] in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/vhost/vringh.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 7b8fd977f71c..07442f0a52bd 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u6=
4 addr, size_t *len,
>                                bool (*getrange)(struct vringh *,
>                                                 u64, struct vringh_range =
*))
>  {
> +       u64 sum;

I understand this is part of a bulk change so little time to think
about names :). But what about "end" or similar?

Either way,
Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +
>         if (addr < range->start || addr > range->end_incl) {
>                 if (!getrange(vrh, addr, range))
>                         return false;
> @@ -152,20 +154,20 @@ static inline bool range_check(struct vringh *vrh, =
u64 addr, size_t *len,
>         BUG_ON(addr < range->start || addr > range->end_incl);
>
>         /* To end of memory? */
> -       if (unlikely(addr + *len =3D=3D 0)) {
> +       if (unlikely(U64_MAX - addr =3D=3D *len)) {
>                 if (range->end_incl =3D=3D -1ULL)
>                         return true;
>                 goto truncate;
>         }
>
>         /* Otherwise, don't wrap. */
> -       if (addr + *len < addr) {
> +       if (check_add_overflow(addr, *len, &sum)) {
>                 vringh_bad("Wrapping descriptor %zu@0x%llx",
>                            *len, (unsigned long long)addr);
>                 return false;
>         }
>
> -       if (unlikely(addr + *len - 1 > range->end_incl))
> +       if (unlikely(sum - 1 > range->end_incl))
>                 goto truncate;
>         return true;
>
> --
> 2.34.1
>
>


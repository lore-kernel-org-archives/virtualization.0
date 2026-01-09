Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E073398A
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938532; cv=none; b=t02dwO8XIBaUodRAgZBisnWDQOyygbKIu4xCR/rqCX1OGamiDj9dXZPaCEVHjs9JvVJ6Y9UEFctMsyDliXuH2zAK0ajJXgOcEYQKRsf6MehOX+3XlIoI6muD0lgrTJr+Ep0psr1+asZM6kRIhLkArMQA0vcpJeQGMfmHNq6Z2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938532; c=relaxed/simple;
	bh=LfbV3bIWDp4J9DPIWnoVpSzQ2fMzemhZ73PGMmrMWEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiCCXAOqG/fiuYv/5qqZC6fNgYRzzvqNjsVWAbiu7wEOPYk65TokgUQ6LSBhTHLnjBkRtrXvt70DIA8bXjhPqtCjmMOcAlutzwMNipgypLSHNGYDj5/14hTRvVox3KCNJCJ2O//oJU+ppEwRjdrkj3Cxd/lYZ93HgXbFT/B6HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HX5e1SA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HX5e1SA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62L7uKK76qUdf8AcX+V8O9A8VaWvwOnCNJYaGsTTDE0=;
	b=HX5e1SA3jOH8bQz7r9V/8KiTSDfNhXOgmUHZDymbpGxrIWGvarxT0FsndacfTVju1lrody
	IRNSQADmnAJ1PJbDAxDEIGicuMMP0NBJBWPP7WR+H3e88Yp9tU10XzUn2+yKeJppzxqWLY
	U3XAdVW1107HnqeXu7rJokbdy29d+uE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-Eer9jSsnOfOuAR27k68zQQ-1; Fri, 09 Jan 2026 01:02:08 -0500
X-MC-Unique: Eer9jSsnOfOuAR27k68zQQ-1
X-Mimecast-MFC-AGG-ID: Eer9jSsnOfOuAR27k68zQQ_1767938527
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c337cde7e40so2508147a12.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 22:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938527; x=1768543327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62L7uKK76qUdf8AcX+V8O9A8VaWvwOnCNJYaGsTTDE0=;
        b=gom3qCW/Het5shmu6UyyvrZiwpfOGhPPgMYbvv91t5+363j/x2h3zfgnTU7+WItYeA
         I0it5cdyf86FQnXY8VgO24drmStd3fUO5qnKz5nfYZbh5rDbEqp+PAvqkQAcPX/5YxF9
         FsPMMl4sP7lJErCu6fuWhr1bVAhrxh0xzgTvbgA1ZVi4U49sPWcjSP/an4ASEyjGzlJK
         59yA+olgzjr/0Gx03HgfAvPzXCOOBBL/R/Riqz2WQYUsWvjeZ7OTST1HSYoktpff9Waq
         2iLRNlAEHRmk1HIGRa9bk5AjeS2tioNOS9F1YxwNJEd0IVIXobA5jAi+KXYryf5uVGEu
         CMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4d13HBV3ETKAagRhHz/tk1mr/oEjppPonm3RrhPcpYHPEsVTdIUY5n4EdXCYs9WqqdjR1tJQwWycGNRu+IA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEDYFLmZNUSb7OmTd1dvtkaKsI5jdjB5xgYfuvMTqHsFHLSq+Q
	J975ZTGt/Fw0dfiZMvsf/fBuh2mNxQJHT0EEQDai34ElgJbjcW/Bf+fP/H4nMEuQHAaOgQdU030
	7UXjWBIW/HDqhbgc4soye0uoTn+5jr+k2+Lf9mq22v4mboCb8kUXMF9/UthzO7/8l4E5gtxgd68
	k3nT2+GjKgHxrSAKPy0z5I+rX2dp6lBL3KtXP5DpS7K6o=
X-Gm-Gg: AY/fxX7D69gfsSVLIqT5LneWMLzpNkeVmh1csyp3SKX8MyOGeJtuOKBsHxcxH/d2P2d
	KnPDRxcLsKqzCtj+XyTBiazG33cSg72qWO1I0ZDQ4E/tHJGoWKWfxaqHejowgI4gxR3A7XNoWDu
	oEKjor/6qu3UgdA+ncFHpuJpNPE3XMvsKlX2mRX0sYQrGL8MmQNHxIJ4ygfRvIIaM=
X-Received: by 2002:a05:6a20:6a11:b0:371:53a7:a48a with SMTP id adf61e73a8af0-3898f8f5552mr8820769637.1.1767938527020;
        Thu, 08 Jan 2026 22:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7U5gpSDRrYYCGHdnAQ2bq5uAgkTGfK+sH12YYJ68NVxDB/cGt7yVMQVT5cwc8QARma7YH0oByMp3T1kPE0Jw=
X-Received: by 2002:a05:6a20:6a11:b0:371:53a7:a48a with SMTP id
 adf61e73a8af0-3898f8f5552mr8820736637.1.1767938526583; Thu, 08 Jan 2026
 22:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de> <CACGkMEsHxu_iyL+MjJG834hBGNy9tY9f3mAEeZfDn5MMwtuz8Q@mail.gmail.com>
 <ba3cffe3-b514-435d-88a8-f20c91be722a@tu-dortmund.de>
In-Reply-To: <ba3cffe3-b514-435d-88a8-f20c91be722a@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:01:54 +0800
X-Gm-Features: AQt7F2qhunhdhWvtDP-HjKQwCMpNXEKD9HAqlgqUpB6kCWfjauzXhQR7-f4zQJk
Message-ID: <CACGkMEv2m5q-4kuT5iyu_Z=5h0SMz0YYeKRBu8EtrxC_E-2zWw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m9ui35eSYhxeBw3oyHW8tmxouQF8_kwquIyE8lgYarw_1767938527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:21=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 04:23, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> This proposed function checks whether __ptr_ring_zero_tail() was invok=
ed
> >> within the last n calls to __ptr_ring_consume(), which indicates that =
new
> >> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> >> the head - and no other function modifies either the head or the tail,
> >> aside from the wrap-around case described below - detecting such a
> >> movement is sufficient to detect the invocation of
> >> __ptr_ring_zero_tail().
> >>
> >> The implementation detects this movement by checking whether the tail =
is
> >> at most n positions behind the head. If this condition holds, the shif=
t
> >> of the tail to its current position must have occurred within the last=
 n
> >> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() =
was
> >> invoked and that new free space was created.
> >>
> >> This logic also correctly handles the wrap-around case in which
> >> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> >> to 0. Since this reset likewise moves the tail to the head, the same
> >> detection logic applies.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  include/linux/ptr_ring.h | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> >> index a5a3fa4916d3..7cdae6d1d400 100644
> >> --- a/include/linux/ptr_ring.h
> >> +++ b/include/linux/ptr_ring.h
> >> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(str=
uct ptr_ring *r,
> >>         return ret;
> >>  }
> >>
> >> +/* Returns true if the consume of the last n elements has created spa=
ce
> >> + * in the ring buffer (i.e., a new element can be produced).
> >> + *
> >> + * Note: Because of batching, a successful call to __ptr_ring_consume=
() /
> >> + * __ptr_ring_consume_batched() does not guarantee that the next call=
 to
> >> + * __ptr_ring_produce() will succeed.
> >
> > This sounds like a bug that needs to be fixed, as it requires the user
> > to know the implementation details. For example, even if
> > __ptr_ring_consume_created_space() returns true, __ptr_ring_produce()
> > may still fail?
>
> No, it should not fail in that case.
> If you only call consume and after that try to produce, *then* it is
> likely to fail because __ptr_ring_zero_tail() is only invoked once per
> batch.

Well, this makes the helper very hard for users.

So I think at least the documentation should specify the meaning of
'n' here. For example, is it the value returned by
ptr_ring_consume_batched()(), and is it required to be called
immediately after ptr_ring_consume_batched()? If it is, the API is
kind of tricky to be used, we should consider to merge two helpers
into a new single helper to ease the user.

What's more, there would be false positives. Considering there's not
many entries in the ring, just after the first zeroing,
__ptr_ring_consume_created_space() will return true, this will lead to
unnecessary wakeups.

And last, the function will always succeed if n is greater than the batch.

>
> >
> > Maybe revert fb9de9704775d?
>
> I disagree, as I consider this to be one of the key features of ptr_ring.

Nope, it's just an optimization and actually it changes the behaviour
that might be noticed by the user.

Before the patch, ptr_ring_produce() is guaranteed to succeed after a
ptr_ring_consume(). After that patch, it's not. We don't see complaint
because the implication is not obvious (e.g more packet dropping).

>
> That said, there are several other implementation details that users need
> to be aware of.
>
> For example, __ptr_ring_empty() must only be called by the consumer. This
> was for example the issue in dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") and the reason why
> 5442a9da6978 ("veth: more robust handing of race to avoid txq getting
> stuck") exists.

At least the behaviour is documented. This is not the case for the
implications of fb9de9704775d.

Thanks


>
> >
> >> + */
> >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *=
r,
> >> +                                                   int n)
> >> +{
> >> +       return r->consumer_head - r->consumer_tail < n;
> >> +}
> >> +
> >>  /* Cast to structure type and call a function without discarding from=
 FIFO.
> >>   * Function must return a value.
> >>   * Callers must take consumer_lock.
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> >
>


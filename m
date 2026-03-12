Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10E3B0ACD
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321453; cv=pass; b=GIUATRv2pQEyiU5h3xYRxvbKt82Iw55umWVK+6cGNEh9dXEVV1taMOqbxUKGlClVFNPZlcku4ETP3wyrFDOGHiqoARazcY7l2O8fcE3Le8mNqToaxcEdnjqzMeToCFhXdOv8RgDkqvk7Ihs7PiB+JrV2J3V3zlpVr5KzE88bSNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321453; c=relaxed/simple;
	bh=2CVfKLzEaWzJ6SOlRajph962S9thoJpcyvo/tNIs4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJCfzow78n3N3G7RR3KtTVglcwZNGMaWDgIAHn1W3HD0cAPy046YHQxdRFNd7NCd5izZrgYV4MKD017XOUiw2TvSnDajchHXR0T54lgFNtZ6gzeN9DC8GgQsHBLZIW+zr4jMcLHx5pbcV8ptse8oDYEvxWvZGWUfWJFSVenPztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKJiWCJM; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKJiWCJM"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd8a189f44so100356585a.0
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 06:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321449; cv=none;
        d=google.com; s=arc-20240605;
        b=JsjmqPD4PjGH6ha2wEphLY14myQIpCFTsIaKvgwRUBz0Ake5IP787PastLPtzRawOj
         Vczb8yne4z1y2U9uoxgYlG9l3DSMomyckxZHkFQMLCy58EFwM9lvgKJub+hSSxNycCFN
         fpAZByv5XtZIlFelYhJfBhH7up7vQs3/itBPxodNC1gyui6wb2SFSX8ao79gw+7nbrGI
         0OG/EBtzz8IOfO4gT3by1UgAlu2TfRxGJiLwllG2Ig0RqamRpw6SKYFUJ5mstaJtdPLW
         Bxykhf6fC4nNcVaYdKeTl9wNmQakmZ2FxiUSpVn7TtKniGJ1TW8dTyOPFz468PrLNp75
         Ug1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        fh=/dEILo11ys2R+PGQD26SfK/XMUbgYAXduTW/1SSeUU4=;
        b=kss6OMc9PnIzW3iIQkIM1gqMCXLaLqeksPbG8cikjZI2pChk0uyNogRmA8zz0RORyj
         XD86Jkxi8j/smkc+mWuNo773TFZFFGOdHRNyH+bwtMyiIc4JzjKmjOeKugmhrjxfaZ4H
         XzH2f9msakYsD9XRn200oPePTDZTAfrF0fRPeZxJaRhHsXND7OsPaEP9zssrIKY5D0O9
         MjvBoir1yAmgj+IttU9vD+2VvjrIjdhS7p3zpFAA8pMQu9I02WF3PXWxKgc7LIF3xwzV
         9JgAvaMJTgrhS8pUsc6zqAeoe4o5za9Rl4krsqekWQq5rBrABAUnvf3r4yaLZl0MSvLU
         M1hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773321449; x=1773926249; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=dKJiWCJM3j0B+YYqQaOS0mQpTN+iWUWI9uaCZmGudwsGqbHDubTI7xLoAPqaDkwcdv
         GG8aWDF2y+/ibvrWqq4yWHfFl7GX5oBX+apuvtgEEOdDmMUidz9Ig+mcK/Kda3+GZnAD
         gEQQb9u8TjGXa+6tNaEFzB3sLqsSrXx2I8SHlLbXEoIvhpaVlVY6SSP8/nboj35KOnuQ
         CVE9XtnAozWtS+jnoxLPLqeseT+dGf1vt9Ubow4564dhpCdsydeAXSbz2mVYUY9esRJZ
         aa681yU+rYOo+gzUR1zNTSSyP0wf1QedqjQwgamzwlkQGtJtYm3FZ3PvaLIU/QVBXuA0
         WEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321449; x=1773926249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=lS1uMk8j7rYC+yyWOHCpYkzG36z5YHWRF/zKztbWP4McV0KUkZ5fTZtf3/YkXAaFEe
         HaYceVdfuZnXOv3PSLabLfddqBdGeR94mrxfonPlu9YKkIYJiD6yAjXbHUh0DrEHGtlR
         HnooVo6KvWendc4SSy0bzsLlmw3EwZ7PvU9S+qbAxgq8Q5TdyvpBVx4/GZo3F48aSra6
         OWAiTQA5TjCttJP4s75p/xapPzVapw0AkyEwhAqZHsZuyrij+31I1ZG0/AHfs9JKIPNM
         6n6FjPRu8mLpOwEi542/V4JuKJbbqlzan+dWSzPaL/pRXV4YsIv4LhVrK4cp0k942edb
         Twhg==
X-Forwarded-Encrypted: i=1; AJvYcCW81GpTIBMgUVTCgnnEwv0mg+oJ1fMFktJqyHF0v3xpl2cyhbsoxJmBW5EfUp8nO2ksZKsWnnlsWW6KVOEUTg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3J2ipaeXAk+LuKq0fV6CiYiaZvrTs6e5Q6LeyFErHmGAiayS5
	UfvpeLmjUTvjJZWIiN5n26GD9Yk6Bpp1zYjAWYsP4kp5crswd329cIPN6j/KBImK85f+w9xsA86
	fPy2xiyfE9wMCexdkYXoYijNPNjbHuQ6tmypBQJ9C
X-Gm-Gg: ATEYQzx8tfdWIPDPK2o33JPRgzMr2neFZmhhASpJZOl9k13XlmKIthvRZD38NhQggFe
	1TNDa/ZUj03VlKtFDXk01NLNe31eivEn4OO/Gq6s6MPvim/AXed3e9dcymsJDITBh2rPoddL0r4
	1I327xLRAT+KrE+M3iHGWkOQERrjRGm8uZT778X1I+/MxIglQOlMtRMrMi0FHLpGtKd/zif4X4N
	tBQ3X7BIOiSw3JSa//Wljp19Zp6UEywgUhp48ZNiRVJpZMZHO2RoKfn3uCgRZ8a8cVhnbSwwsmF
	gKzGS+E3
X-Received: by 2002:a05:622a:20a:b0:509:1ee2:69e4 with SMTP id
 d75a77b69052e-50939f83b2emr83671071cf.11.1773321448260; Thu, 12 Mar 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 14:17:16 +0100
X-Gm-Features: AaiRm50cn_rRH55eJvQqDxobMz7O5_lfuBZOF6UtHjJez3Nx18K8yQR7QqLR9ME
Message-ID: <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch moves the check for available free space for a new entry into
> a separate function. As a result, __ptr_ring_produce() remains logically
> unchanged, while the new helper allows callers to determine in advance
> whether subsequent __ptr_ring_produce() calls will succeed. This
> information can, for example, be used to temporarily stop producing until
> __ptr_ring_peek() indicates that space is available again.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 534531807d95..a5a3fa4916d3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r=
)
>         return ret;
>  }
>
> +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> +{
> +       if (unlikely(!r->size) || r->queue[r->producer])

I think this should be

       if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))

And of course:

@@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
 static inline bool __ptr_ring_empty(struct ptr_ring *r)
 {
        if (likely(r->size))
-               return !r->queue[READ_ONCE(r->consumer_head)];
+               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
        return true;
 }

@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
ptr_ring *r, int consumer_head)
         * besides the first one until we write out all entries.
         */
        while (likely(head > r->consumer_tail))
-               r->queue[--head] =3D NULL;
+               WRITE_ONCE(r->queue[--head], NULL);

        r->consumer_tail =3D consumer_head;
 }


Presumably we should fix this in net tree first.

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C128488D
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842610; cv=none; b=ez/4nbccopwEmUWTe1uuR7+0qJycHO+sI3uTPWeA7phCenXGu4jOaCpuP2hjd3/itBiY+8rtdoqZc+9soouLKpT3hGELC7PIjmwpG1FA0t5GVEUnfPi1WWa8tkV45Nw83QtSUsnHj++H2C57L9QBg8n/MQI3Nn+KjtBuPo4ntMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842610; c=relaxed/simple;
	bh=oIv7VTewxFjssL2jhliOXXbBPd3GBbrqXH5sFUlQGGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWZaJNKSHHM/3jzwAf8PDXX1PyFWfPawTF5dkD2fhOGoGvGnGtes2KvMu33R8BCiIa8H1js+zj3sinwg3mzrSAgF1Mol2UEuTqQhkhbo78Uap8Dkd4glg+/zoASHcctd65vQyBgBOl41T0QxF1D99tPVPm69ZAuxFHXhJZoirRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5BuMgMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5BuMgMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767842606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53+r2N7iOHCghDUQ95LK593uOrK3zjiCULW2/UR+Mu0=;
	b=P5BuMgMz3qipG0lldGfymzYfiPt6pDlAz2P4d4lzx9KOwljN1uWqZbzlVCHprLA16DMgeD
	FZSSJmGukvX2yEVdQlddE52dXh+9fPno7EA/8HdL+MBc4MHKuVMyHFaQXP7QA5uH/id68x
	Ji6YahO7RiMrSaOnu5SzBGKRBYLPthc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-zFDJXE34Oyis0w7oVKwGFQ-1; Wed, 07 Jan 2026 22:23:24 -0500
X-MC-Unique: zFDJXE34Oyis0w7oVKwGFQ-1
X-Mimecast-MFC-AGG-ID: zFDJXE34Oyis0w7oVKwGFQ_1767842604
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso41086315ad.0
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 19:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842604; x=1768447404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53+r2N7iOHCghDUQ95LK593uOrK3zjiCULW2/UR+Mu0=;
        b=fGmhErds9+gacPN298FoIcZSewBgqjCm+FElmFrumRuYzYibHX/ayj1f4zis/rTimP
         8Z/eeLqCH5jlHdvO/YmQMbZU/BxumO51Hcs849iOqZTlWeJuMtPsNpcZakcSgi2K4Teh
         Wb0m2ea9O2YBamFeb8MJiqUZwCTnmAKGLPyHX06lVI7ryUvp/d34U/IbMnhFD+g3pJ6v
         XeujOOOPKIPyRt6kQZLJErDdm7xylHmh+2X6gpIQ9J+xq7ymVShx3aD7PVwBZbsqhOqm
         wqZSNlBVpm9FvHqCduff/wU+CEHAZPFyqhmMAbI7w2MR/bl6GyMlDoju4fsUA7x3n6yK
         IugQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxIVwO3s5NKoNJIy69tq3ouJfEM8nvsE16T2Ya7QSFbTgozEt3hT9ORdo0LcDLSs2r5AYLNz4e0CK8KSfNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHl4sn+AH5Zj/nZdXMpbYcK2pDO++JO9hwpN1hVjkkaT97oOJu
	N/ExaFs3q9JvX2bgyjzdY4RBQyFcE/ycWma2+fVsrRyVpWMzBkySlAia1oSEo50c3xpcSSYxm8w
	RLi5UPQPlInM13CJ+Ux1hQCg66L+m37MpeBiv6Dck1mX2RMWik8pPkpxhS4BP9A9Tn3EMNTLxUu
	8+3yGQf9MwLYsfvSgQRh81y2zLRQmNRta2GbN+OJRA1tY=
X-Gm-Gg: AY/fxX4sNdFmwBw3MCIV+Ejtm/HTvl/VCWRIjSNLG8sVttLXweJPzHalDtfvJDhwWzK
	2H8kGcAzIPfl7muYfenM0kqEAD/wmoYct6bkKTqZs4GFt2a6DQ4XO37wXHBTWYfhzqhdLrypTbr
	8GXhQWZkUCXHjLNyNNLn8gD+Sw9nLz21gdxQBIuaERB0UDcq24uDnHvJqyg2pDzP0=
X-Received: by 2002:a17:903:41c9:b0:2a0:a33f:304c with SMTP id d9443c01a7336-2a3ee4c0025mr47651295ad.57.1767842603728;
        Wed, 07 Jan 2026 19:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRtayNY0uqqjM78CiVQw7mFTLxT/iYnZszpaOrmD2ynKaqKve+vos88ChoY6cZhopiJ0fw3kSZsdEyMLVdhzw=
X-Received: by 2002:a17:903:41c9:b0:2a0:a33f:304c with SMTP id
 d9443c01a7336-2a3ee4c0025mr47651025ad.57.1767842603302; Wed, 07 Jan 2026
 19:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:23:10 +0800
X-Gm-Features: AQt7F2oDKZ3eYcdC7fFyoqIzzMdHxzeD7csgTVUKHz7k-5CronqUpphVIiXmk98
Message-ID: <CACGkMEsHxu_iyL+MjJG834hBGNy9tY9f3mAEeZfDn5MMwtuz8Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 65lNhmq4yaE3DE6hmmXSyeqje8ZiarQ3GF3IMiX7DmM_1767842604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> within the last n calls to __ptr_ring_consume(), which indicates that new
> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> the head - and no other function modifies either the head or the tail,
> aside from the wrap-around case described below - detecting such a
> movement is sufficient to detect the invocation of
> __ptr_ring_zero_tail().
>
> The implementation detects this movement by checking whether the tail is
> at most n positions behind the head. If this condition holds, the shift
> of the tail to its current position must have occurred within the last n
> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> invoked and that new free space was created.
>
> This logic also correctly handles the wrap-around case in which
> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> to 0. Since this reset likewise moves the tail to the head, the same
> detection logic applies.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index a5a3fa4916d3..7cdae6d1d400 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct=
 ptr_ring *r,
>         return ret;
>  }
>
> +/* Returns true if the consume of the last n elements has created space
> + * in the ring buffer (i.e., a new element can be produced).
> + *
> + * Note: Because of batching, a successful call to __ptr_ring_consume() =
/
> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> + * __ptr_ring_produce() will succeed.

This sounds like a bug that needs to be fixed, as it requires the user
to know the implementation details. For example, even if
__ptr_ring_consume_created_space() returns true, __ptr_ring_produce()
may still fail?

Maybe revert fb9de9704775d?

> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> +                                                   int n)
> +{
> +       return r->consumer_head - r->consumer_tail < n;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FI=
FO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> --
> 2.43.0
>

Thanks


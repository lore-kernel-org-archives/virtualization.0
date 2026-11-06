Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985930;
	b=SvVeiVwnARN/vvMWQyi8tl17Xie33NYCe+FgA59VesmNtQUrtGEB7eELvXP+6o07aOc1
	 huPdYDtLOpwRbMiAa8NdUu1ExPisRiMlZRG5mLwIR3fXmIiSvD0CYKIQfYBdjjrmOMf8l
	 D9lsGrc5jSgXY9lOozFDIEVbEbmwIg+QFd/G1qgSHVIUGryXU1zrSEHjqg3SdVbmhAxZq
	 BAXLgeWWJWEdjxl9D/9B/C6HLunMH5Uqf7Quw5EISWK+ECK43pu+YpQRFBLjAZogdk8nd
	 H/NJVoJYsL6ByyGDLMe2GQs5eHYNW/TS44VJcL9YffRY0q+q/u3B84WkRjQLDpMfI+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
	b=L87SNn5TwILd23d5zEZHGrkNUamFN8toHmFrhaQ3Qe2DsuW2QDQOi+z9SjSW9ZLha9qa
	 mttBMNweUZ161qsECZqey3xokPWQKHmBbgWKxLDKV92/GPdeReC6Rq504F4Q97S5Li/na
	 mViJxqdGLh/thyEiqM25kb7CoexBqPL3HS3JzvQGuK8Ku3DNc88RwSxhLJz00YOgS0r2E
	 Wz9i+sZGk4CiYWJv8IkzTPRhKlSmmTTjjqMtBZc3MW/nYJMr7/N35hqfAb8CraS1zWeLO
	 1voAlbA+kE/tOVhw/Vx2xFEo5/4tCq45r3t4r/Uz9r1e/7WSHY036ltu2wOZYpxJMYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LM9aHd8d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EC606A32F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568EC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LM9aHd8d
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so1375e9.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985929; cv=none;
        d=google.com; s=arc-20260327;
        b=aJVXLuA/RREXSKL2BrRsQZd+IiRWnyyEu/eyRD3Y1/r1gJedmYNleEV4zJo6qV4wIx
         KZGOM9kt8UO5K7yrv5vMpi9suWEZ2r1ExGncKPBKCBzf0daDOZxM/dbG+1sNtE5OCRRE
         pL5soG2gZDiSGdUu1L0CJeG7+p7ctofldUtZLCi6jmx3VcUr1DCXNrWKfhBJ7HvhoPPv
         8S5LPRd8EyRbxTJm6Nwcy9Lvvw899xd85jn4kUKW9YjZwDBJTP27Hrht9hmwh4ciWSEy
         ctk2X6895ENTZlSA/BvD8NJ6lqrQj6oQsh9NT/YSSFpGB6e/WW/oPmQ4d8HVPZdccXtd
         EvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        fh=AEBpqyMBp6o2gCadii+xOz4v8DVUfZ9IfR/6Jix3+XU=;
        b=is9NSKb2Ba+WNVA9LUzoFE9rSmgDfmIC4iAtfEZog28kfHLRzh5JOyRlLstfVXTK43
         FapL+MNHu0lxFTZFIidBqM5GugYfCRq4tIElQ75R88EdnrzVTHiYk2ZkPMMUCS7oQ0/v
         sFf1Kfnc9qIc1wzpp5Mksd1ykTZgrIW88kXtVopPY14f0ckSnmarhmCrdUoCRCx61xx9
         O+L8Sp7/LBNJWpn6CllxRUapsfdbYJvIW9TD4J70+SR2LqxwMe9lqCVzaDqHfuzONyLx
         RE4LTFhFB8S/FKgNbrruZ09Rv+UaZHrWrYvF45fmtvl9kIfSgsB1Drh6izPBVpBhPnWR
         rUGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985929; x=1794590729; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=LM9aHd8dGwa9CqFYDIt3mLVyqPP09L1a8BfjoT1cuLXbE34ShkTqgIEa2FRrbTI3Y4
         jT02wbTKFeyH+if7EHt83QUylLEsQ1ssvIlYFV6PxXtQNqaRooJ2C3wlN2rP/333QZ2g
         Qgh3nBjAC3eW1ARwsQixnNZ///2UcI7s/H1bSGxv15cTGQWAm2SKWSD+WHH+n2KZdpJY
         90mTsBhqqJMhCvz30RVYo/RckP7F8kFlRUyPVkkcxcWxLG55rLFIBFVXvtYae8uX6xuG
         m9kpgs3GIc6JaFbWK6mH31e17AogvT6Gvr7BRjEhXBEIqbXWIeb/iG+VsFZwvX/0yamR
         Faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985929; x=1794590729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=fBLh/KK8hNDPUwEc+xLqB+oiEZIRfigSUGe6q4ixj4VkoAFNHmEfh9LGrMKPCIUEjw
         XK21MY+2gM13adAY6nXuhH3hsM3doAWGRnNyosTOl8EERjvo8dJ42WWErA9+lUkgOuTx
         Wo6ZQ0KCjuaUoxciKgs+qaaYFaqoa/GzfdioPDNecgqxG1pokRdPdSW7PXceNqBdNTAI
         B5lAwOLPPifHfvr/gECe0Etw80NrshwtWn7LJxeFn5DlCvvoZQyDGMyvKHZNI3324x4s
         9hRGCEpZTYyJAB77OwKyBP83UQKdM6YENwQbo/4EFELLUk8eIXNZAFDKmuFkIJO7cWca
         dacQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6VBWUN22AnZ0AF7VbjkjhavOtqBKY9gkREH8oLJSB8mfhsLNx9ux9IoJ+ulG4edNII6jngvG8mduQOFDPEQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+W6UUYw3z8nGRqqZGegritGVX/22ozeyc4eqKrDTDsTPXP0+r/
	j/UmqcyUN/YK1CSIY85CCWJ2caP/Dv+eygWFi0PtkT8gJmhZXBpd77gLoo32YjzdilT/hVlqVcc
	Ilh2JDmVv6ZY9CXWykpOiKgvzWiL5ow6Oqn8/GQaq
X-Gm-Gg: AYBFou1quo8r4f9NsNXZySe5FFgrOd5krMJ5b8jOr9mydImVx2DOsB8gDWpRD3lpLDa
	maKFCZ9ExVYyacCApKe8pgG+kVfQq/cqKzlf9eTO0c/fU4QSY6n6jtfH3Xi4D3Z9Jo+lM+/K76l
	+0WZ8aIPr09FwDBktIYPdK3Y53XjJaDDmR0VI8nf+ZNzyxku3FB4IDia5n8Rh01YtV0ubWKIOKj
	9NHPNFV/HnLqUdMamlx227ffQcUWemDyKeRISv6q+UIk/XrxghuSDvrDmE/xepxpBlouwZpL3Gu
	dAQBE0PTFAVxAWj7WRFuNlM4wX3h1XVVvmYGhM4XKlj+s90ZVuedPnB7sNU+8o+tAQH9bOfs/Wo
	8kt/0EIplqGrG9ZcvisxXf7RBQcIGBbNbdSuYexU8jKocgCY+4fKVWADlzncBhEibHf3FFma/uz
	wYTkkx8lRnZpBGxA2ze87cmyhtUSnHDY6KwmW6YMHfEf2V
X-Received: by 2002:a05:600d:644f:20b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b78a315689mr14125e9.12.1793985928307; Fri, 06 Nov 2026
 09:25:28 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev> <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
In-Reply-To: <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 09:25:16 -0800
X-Gm-Features: AclHuK_zmhBLd-fBLwMoqE-7QVB_DAT0nisVVyTe7VWHd67XlQDn1ECR61povKo
Message-ID: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, dgilbert@interlog.com, 
	mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com, 
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, 
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, aesteve@redhat.com, harry@kernel.org, vbabka@suse.cz, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/6/26 14:18, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> > data pages keep the accounting of the memfd they were instantiated in,
> > but the bookkeeping around them does not: the page pointer array and
> > the pinned_folios array, both sized by the buffer page count, plus the
> > transient folios array sized by the memfd folio count, are plain
> > GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> > memory, and size_limit_mb defaults to INT_MAX.
> >
> > Charge the three kvmalloc allocations so the creator pays for the
> > metadata it induces.  The system heap in the same subsystem already
> > accounts its buffer allocation;

Only if the mem_accounting param is set to true. We (Android)
currently depend on it being disabled because system heap buffers
don't have a single owner for their entire lifetime (ownership often
changes immediately after they are allocated), and the kernel doesn't
have the ability to switch who is charged for the buffer memory quite
yet. Albert is working hard on it at the moment.

Could you update the message to note the mem_accounting param pls?

> > the data pages here stay with the
> > memfd.

memfd / udmabuf is a little special because it uses shmem for the
backing store, which is already tracked by memcg under all conditions
(except hugetlb). We don't currently use udmabuf, so the lack of memcg
charge transfer for udmabuf is not an issue. But once we get charge
transfer working for the system heap it'd be good to follow up with
udmabuf.

> T.J. needs to take a look here, but I fear that this might break uAPI.

Thanks for looping me in Christian. The buffer allocations cost
gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
so I don't expect charging them to break anyone. Leaving them
uncharged is an accounting gap though, since someone could spam many
udmabufs from the same memfd and only pay for the memfd pages once. So
this change is ok with me.

> A lot of the DMA-buf resources are intentionally not charged against memc=
g.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>

With the commit message updated to mention the mem_accounting param:
Reviewed-by: T.J. Mercier <tjmercier@google.com>

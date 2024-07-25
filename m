Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA05C89
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871543; cv=none; b=SbqaquRMj4iU4I/Io/3FGE5HX4tIaJaInVtPL0odOwEv30qfjrHnJ5sj1ejY3jL6+Fez86G6P/1VTmtGuwhQ9rMIH0Cnb3BfUI4Nxyv7RXKIBXX1OojiVa1FyXjS3HIpXxguGlj/513s9US82prdZrB0gwTkWK/9NUxbWq0CIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871543; c=relaxed/simple;
	bh=CNw3lSjvImA+vYORlXoCiZb9kdkG34CtZVg6LmRdZL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVN2G2+wJ5507/qYpca8txmufq6wDfWm7W6zTuOVejt03WysVuyGMJJa4e0UeOjPqmQAMS+6AEQXjeTv3s0lhcRM/rOSnHb1wpo6ZzV3kuXICx1H3FYpwjCxY3G0i5cwjSEId+FKYO6LjB7n/0jUwvaMY3eArXBVdxtf12xLPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnW5JDk3; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnW5JDk3"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-825896b2058so106435241.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 18:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871541; x=1722476341; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Ak1JTGLjjtGvgKa7m7PZnTqbOmbXiaZvszzz9QUog=;
        b=TnW5JDk3+bivGcYMVXFzEY2Q8gcigsZel/PN/eeLq+Ms0Lfq3rz6OoeH5xp4o9QnVh
         eKzw0E6dFPUFUAYA5YIYOoeKcDfCTt9LwZARctZ9mV0xMXQ1Zi1xbTGaqdnLpV2/YkpU
         eJWqP4ywdAkVr22jbMvj9IAVhD1NWE0n/zxJzNnExyCr7+ZIBRd2EkduUoEf3xCw8f61
         wrqyVdpbJHt7a+mvIOHdueG6Tl5vRUHV47zXdNC6NoMCO7H82MfD+OnOf0iOb8nIiarl
         3OHxbH5QO4tBRuaskyDIP6pkIOW9Q/ocU1derNG/y9j+Te7jMrWqkmNVj5RioSu4aQI9
         RBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871541; x=1722476341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+Ak1JTGLjjtGvgKa7m7PZnTqbOmbXiaZvszzz9QUog=;
        b=F8VR0egLyo8TGwYNvOGhkqhKBHHPIR3rFyCuS0ZXSQMCU29tOrioY7+WsNFCM3x39x
         0HqBBzLrK4cmJm7l0adfUhtMb5BnV5WOfPU4ygDFVI859xnWLzr+1B/pH4a+VGiJtX2N
         OF28J7SCwojBMhfXznouSbkuw+BD9TQNbk7SqFEymdhLoRfr51L7/vjt1LQqvBWSkx49
         /QiFH2EVb2i7MNY/3tra7VUf6KmN98FCi4fJad+Q0VM1/n8uN5ZkLcBDaVB4CvA9ZmlG
         r2p38xscJ7lXGVWqpm1j2Ikk8vQzGz+TMExYyngE20curwAtltBW3+f5mHeAcIx2VHPH
         jUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4b9EUCq3eF62eJpzyfZ4b7DpFYUP06JVTg+SN/J+84mveBPwM/ycs70efILwXlhccAyyNC7dADp9EZCjl/7iP0e5FLkekg8KMkH8CiY=
X-Gm-Message-State: AOJu0Ywomi9WoEiC2of0SNPCrZSwVMdinkUMJydbcF4ZDF8Nt1ag5VI9
	9HCcRHMeKRXUgexEkUYqizXJcKuUmhXXf9Uc5RDMZVugRzmj1Ub2JwZyyk2/O5ikcVSKOJmZGJJ
	ae8fNYcrikBSTkOtIHaAsS67HeG4=
X-Google-Smtp-Source: AGHT+IGsHGyFSG5raIyWHhMfVVB6wctKAD52MhOipikcWdNJ0L/k8XWP5ymbhB5DnYm0DeiFgAutLLVDJOIHmEfiqmk=
X-Received: by 2002:a05:6102:4696:b0:48f:23b4:1d96 with SMTP id
 ada2fe7eead31-493d9ab19e6mr431848137.16.1721871541221; Wed, 24 Jul 2024
 18:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
In-Reply-To: <ZqDw7qoaopnYt3-P@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 13:38:50 +1200
Message-ID: <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:17=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 24-07-24 20:55:44, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > GFP_NOFAIL includes the meaning of block and direct reclamation, which
> > is essential for a true no-fail allocation. We are gradually starting
> > to enforce this block semantics to prevent the potential misuse of
> > __GFP_NOFAIL in atomic contexts in the future.
> >
> > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> > and __GFP_NOFAIL are used together.
>
> Ohh, so you have done the migration. Please squash those two patches.
> Also if we want to preserve clean __GFP_NOFAIL for internal MM use then i=
t
> should be moved away from include/linux/gfp_types.h. But is there any
> real use for that?

yes. currently i got two,

lib/rhashtable.c

static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
                                               size_t nbuckets,
                                               gfp_t gfp)
{
        struct bucket_table *tbl =3D NULL;
        size_t size;
        int i;
        static struct lock_class_key __key;

        tbl =3D alloc_hooks_tag(ht->alloc_tag,
                        kvmalloc_node_noprof(struct_size(tbl, buckets,
nbuckets),
                                             gfp|__GFP_ZERO, NUMA_NO_NODE))=
;

        size =3D nbuckets;

        if (tbl =3D=3D NULL && (gfp & ~__GFP_NOFAIL) !=3D GFP_KERNEL) {
                tbl =3D nested_bucket_table_alloc(ht, nbuckets, gfp);
                nbuckets =3D 0;
        }

        ...

        return tbl;
}

and tools/perf/builtin-kmem.c:

static const struct {
        const char *original;
        const char *compact;
} gfp_compact_table[] =3D {
        { "GFP_TRANSHUGE",              "THP" },
        { "GFP_TRANSHUGE_LIGHT",        "THL" },
        { "GFP_HIGHUSER_MOVABLE",       "HUM" },
        { "GFP_HIGHUSER",               "HU" },
        ...
        { "__GFP_NOFAIL",               "NF" },
       ...
};

>
> --
> Michal Hocko
> SUSE Labs

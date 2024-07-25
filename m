Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0C1CA8A
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888199; cv=none; b=MBKGnSGOlRydPFTSFuEi0OGIcrRvVx/NaMala3U9/y1KyMQbn/EVzO90BptH13WTbiP0YH7vvvnAy1W7Pbhg9/piZTgoeOVzyOz8KcfcRvmsocx8L1jQ+1hCR4zOg9fAs6ujHxj+Bq6yG6ye3vJTHeaBBlztHjc5faC+c9/bfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888199; c=relaxed/simple;
	bh=HCfzXh2aQAP4tRbqQnNNaUfUaBBPH977EHhe6tOjpfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exvJ/FJaYlzQUuH9rKBOWmEOFt7l8xmRaKJJ9VUsDSBNNR1AYG7z97HhK9bkPW33e9WTVWf/9pyZC4YZ8pRtYp1nhCDvGFv32OjZl4vY2fm4yOQO2GFR4JQTSiajI3rSv3LogLcXMR7i7rW3xJcfwoyl37jZiZUou7v8cqUpofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GqKUVCis; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GqKUVCis"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aaa77fac4so3927866b.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721888196; x=1722492996; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SCMsnLhIBfGDTZvGq50b4YwFdguki325nqZTYfqn2Bk=;
        b=GqKUVCiswksN06lueEdQWxWNAXBKtm9/TONaKphPeuDInXH7x9/MOTN2jX7Cb8whem
         hRFQucgyGzg1z1SNNzoQYT3L9kZgdTen1T/8nm4Hc5pqy+LtANGABAP5BrqnrWlkbvxO
         kqvhg479OY0xAKMd8hv7LAJW13qe3nktrccnkzf6JIlVaNJvwSyf6P9Ld77UHLlSiKBF
         Z4+KDh1YFDh9afHAKntZnUcQeST8CzcHm3HBqMwDjLxaVLhe//itftZusPEStdOS62Z8
         PpNVLdHrJCYYYBy/+Vq1/cVMZ2CHHZ55poAD1NzecG5F5cs5w0KNNUdqZA8oIt/plqwc
         PgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721888196; x=1722492996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCMsnLhIBfGDTZvGq50b4YwFdguki325nqZTYfqn2Bk=;
        b=sqvni0utmT8f3uN4QMlhMfrLTTjFWqyl6qW/Ob8JgxknSUQgBrdb1mEaJ+2QshG9fL
         slEY5+DnCq4+SqrppG4JgEtelIyDtNGqiTgd1eWQtXoHdIMJYuuGLOV+h5Kyf6/6+TtV
         7y5uf/SORFg1eUOeLL5TD6IS3aeCWqjPTh//phUGWsnDs74mxpVxt+wJsyBCqMK7Upy/
         hIPfn3rS/xIp990qCegIPxC/bS7+7VtT+Q0Hpm1txFxj4YuUvQ+4CFqLikLP9B4SOcSC
         AXulLL0zSohzLgn8KZH2LGcgkrogMUJi/jNbgjmidoPwHUVFcOP7t4AXKFPYRZhtDAs5
         b5aw==
X-Forwarded-Encrypted: i=1; AJvYcCXEiSIh9UQftzgHXVD/AW8vXs0Fk5Px1QwbY1pNAsONJX/PLfpY2jLWyGX6O7zIfegexecM+g1ksemQwPsWqCLmsnmV9FL8lRNEOsgnU1A=
X-Gm-Message-State: AOJu0YwU6KAzHZxr56CVmIdzcReHC2+f37h2oT9k1PnhP3CB6ytAFbTL
	zlFKYcVZoY3lylwSiibHH1xou8s5OlKwzXCsSvQ3cUv0StGiZv++YbInyYmv2OU=
X-Google-Smtp-Source: AGHT+IGBztCb68n+EhFJJcTiqpcVxJPCtmyGojfDvnZ2Zcc+j18B5Mbdbp+cC1m5vz8cmK2nGoe6CQ==
X-Received: by 2002:a50:8715:0:b0:5a1:de88:a5ef with SMTP id 4fb4d7f45d1cf-5ac6396b16amr799200a12.27.1721888195997;
        Wed, 24 Jul 2024 23:16:35 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac65481320sm444363a12.81.2024.07.24.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 23:16:35 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:16:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqHtwqyj4seB-eut@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
 <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>

On Thu 25-07-24 13:38:50, Barry Song wrote:
> On Thu, Jul 25, 2024 at 12:17 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-07-24 20:55:44, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > GFP_NOFAIL includes the meaning of block and direct reclamation, which
> > > is essential for a true no-fail allocation. We are gradually starting
> > > to enforce this block semantics to prevent the potential misuse of
> > > __GFP_NOFAIL in atomic contexts in the future.
> > >
> > > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> > > and __GFP_NOFAIL are used together.
> >
> > Ohh, so you have done the migration. Please squash those two patches.
> > Also if we want to preserve clean __GFP_NOFAIL for internal MM use then it
> > should be moved away from include/linux/gfp_types.h. But is there any
> > real use for that?
> 
> yes. currently i got two,
> 
> lib/rhashtable.c
> 
> static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>                                                size_t nbuckets,
>                                                gfp_t gfp)
> {
>         struct bucket_table *tbl = NULL;
>         size_t size;
>         int i;
>         static struct lock_class_key __key;
> 
>         tbl = alloc_hooks_tag(ht->alloc_tag,
>                         kvmalloc_node_noprof(struct_size(tbl, buckets,
> nbuckets),
>                                              gfp|__GFP_ZERO, NUMA_NO_NODE));
> 
>         size = nbuckets;
> 
>         if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
>                 tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
>                 nbuckets = 0;
>         }
> 
>         ...
> 
>         return tbl;
> }

Ugh. OK this is a weird allocation fallback strategy 2d22ecf6db1c
("lib/rhashtable: guarantee initial hashtable allocation"). Maybe the
code should be just simplified and GFP_NOFAIL used from the begining?
Davidlohr WDYT? For your context Barry tries to drop all the
__GFP_NOFAIL use and replace it by GFP_NOFAIL which enforces
__GFP_DIRECT_RECLAIM so that people cannot request atomic NOFAIL.

> and tools/perf/builtin-kmem.c:
> 
> static const struct {
>         const char *original;
>         const char *compact;
> } gfp_compact_table[] = {
>         { "GFP_TRANSHUGE",              "THP" },
>         { "GFP_TRANSHUGE_LIGHT",        "THL" },
>         { "GFP_HIGHUSER_MOVABLE",       "HUM" },
>         { "GFP_HIGHUSER",               "HU" },
>         ...
>         { "__GFP_NOFAIL",               "NF" },
>        ...
> };

This is a prrintk formatting stuff. This counts as low level
functionality.

-- 
Michal Hocko
SUSE Labs

Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9E366
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 02:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723949750; cv=none; b=mmSCeKzanhwucjcabDTBkp51gtMqduSagI7GrBaWsiZpkgWuE+c7mcNF/BydABsoGYsnvd8irYCrnyXOpED3JJimehiYaGvTsK5KsiHiDX97uupUJt+kTrX8Ne378VhEwJJs3oJQccXPUBpl7LDVVvm/Ca/vOeNPw4RVKVKXptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723949750; c=relaxed/simple;
	bh=+P+bxoHxpjjYPEiYNVVjGwixuqV9lh31bYlQUN50kMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anglAsOYocft7mOGbEetb9fHjp/mK5SlOWU4tCT6COEo9jcM/GdsCv56g95ql3oYqqf+/cI2uRiPIaYBZtVhbTlzM79D2QzhXbZzlm3gekLqA6XMf9XPy2wXwKyIez7ga9yRe7s5U+jGbUiMYJ9r/tueLy6ZA9RymP1+s0gXxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCj/p4Ci; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCj/p4Ci"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf99fee82aso738646d6.2
        for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723949747; x=1724554547; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7FAjbIWmnnLeDsFAqPZWRKJ78oaIxOyyfrjrwD/sSk=;
        b=MCj/p4CiAU3vcw+1/F7yxoEllmiMUHVqspMnt1L1VjHQjbSl4xE6hRzlZ450k0wOHo
         MKi4e3A23Twk3XHu9IxNracTtPFAQ64yANwupbCcMnGV1hyFVYlLvumWvCwnXo2YuGMs
         e4uTgMyBBttl7dzYNaX+hmdRMkJg7hJmQg8ukxxNYkrTKzfV6NJDaufVY8zB2ow+VxSk
         aw3cgP30PgT9KHNyBxiPPfGPzMIMcn+MD2YAbq5C70kk0FBYOrJtXGY18+YJQQ+jpG6G
         RhW5FBuNAU4nf7nBOhYtbmwiXnAsBvrK5iNvu6s4EciVp+bhMPahQpzfCvFhxzp+sKjH
         0SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723949747; x=1724554547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7FAjbIWmnnLeDsFAqPZWRKJ78oaIxOyyfrjrwD/sSk=;
        b=otOu2XyNlIWUvcSjyCt2We7FTMmwyOJrH4Ef6ngRtG0TEq4qywV95QXgPXOEof1RBb
         2K9oHzbIaNbF3m7VOvebkn4vuy1UiS0YBtVk8Z8pSusQlFoin7NrJtP3VJE86OpQd72t
         G949IbsO2JuiQdrzAbQINNJe8/XObnIT1ONQyd3ydgmd4kL3MD8s/mmtY10YuPl4Zco3
         t3pUEsrBB2I2xP9Uw9tDrVcfJgEyEkohg0iW366EYo8HTvVMA3XsQRuBnmsquBiIROIZ
         ZQregAUZ162kCgT0rj8pl2bP5UZF8cSYcSuxooqB//LUxkwXk4REYvjm6ltfehLmAYqf
         wHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoi8orB6QDKI71KNe/KGaM+KsEmbhs36KpCuCo5//pvb1js4QU0VvsVJZh2APsqNobzwdphVilDHt/NfPEJkDqk6QjCRXMSIDbJ8adD/Y=
X-Gm-Message-State: AOJu0YyecgB2Y4f36v/BUlBS1thIj+dS/5kNqnEk6flW1+Py8tAU/IHI
	48xRWQcVSIAi7FMWqo9NAd3sbXzzGfXRMNC5iWOdGeaadpAT7M1EK4DWSZFQ/I2jVretAWdlrAm
	8eQLnTZl/BQ5NYlK+vcrmYszvupE=
X-Google-Smtp-Source: AGHT+IHBV9d7TSGH0cnvkTXDtJjFYApR7PLg6RaABxXprpAuWiVpZgsyN4ru2X2D9leocVXnLWZT15KMZXOAK4RMGeU=
X-Received: by 2002:a05:6214:33c5:b0:6bf:8afa:6162 with SMTP id
 6a1803df08f44-6bf8afa63c1mr43804546d6.46.1723949746777; Sat, 17 Aug 2024
 19:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
In-Reply-To: <20240817062449.21164-5-21cnbao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 18 Aug 2024 10:55:09 +0800
Message-ID: <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> When users allocate memory with the __GFP_NOFAIL flag, they might
> incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> attempt and still fail to allocate memory for these users, we have two
> choices:
>
>     1. We could busy-loop and hope that some other direct reclamation or
>     kswapd rescues the current process. However, this is unreliable
>     and could ultimately lead to hard or soft lockups,

That can occur even if we set both __GFP_NOFAIL and
__GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is related
to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
design of __GFP_NOFAIL itself.

> which might not
>     be well supported by some architectures.
>
>     2. We could use BUG_ON to trigger a reliable system crash, avoiding
>     exposing NULL dereference.
>
> Neither option is ideal, but both are improvements over the existing code=
.
> This patch selects the second option because, with the introduction of
> scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct reclamation=
 for
> nofail users(which is in my plan), non-blockable nofail allocations will
> no longer be possible.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d2c37f8f8d09..fb5850ecd3ae 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
> -                * All existing users of the __GFP_NOFAIL are blockable, =
so warn
> -                * of any new users that actually require GFP_NOWAIT
> +                * All existing users of the __GFP_NOFAIL are blockable
> +                * otherwise we introduce a busy loop with inside the pag=
e
> +                * allocator from non-sleepable contexts
>                  */
> -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> -                       goto fail;
> +               BUG_ON(!can_direct_reclaim);

I'm not in favor of using BUG_ON() here, as many call sites already
handle the return value of __GFP_NOFAIL.

If we believe BUG_ON() is necessary, why not place it at the beginning
of __alloc_pages_slowpath() instead of after numerous operations,
which could potentially obscure the issue?


>
>                 /*
>                  * PF_MEMALLOC request from this context is rather bizarr=
e
> @@ -4434,7 +4434,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>                 cond_resched();
>                 goto retry;
>         }
> -fail:
> +
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
>  got_pg:
> --
> 2.39.3 (Apple Git-146)
>
>


--
Regards
Yafang

Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BC273FD
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247433; cv=none; b=SmxhypAeaTOFsoHGT6EoD3P4QMoroLV0HdkMA5WFpffDkl02YDdp2kXBXjrY6ciupM7eAhi8zvAtAeBdw/oH/bbx8IgKQsteTewn8wwZSmTFIMcMBN+IhL1Q9i8WX05t2uuhK3PA+oeFaFnbUAFbcjPVnM2a4pwgZK3ihJxyo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247433; c=relaxed/simple;
	bh=jfmhqWWWFaehubU4xq/q/y/+0BEKe59xw7mX8lbSlT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoyaVgpWLhr6sNXG7pllGIWJMKIeb2v07NBOuhZsqh6XLqFxxD3PmA7cTRODLXutj7xZikNSxBR7KPr91OlKekDlkCAHxDiFogYVt5C6/jJcYIB1LRqoPCNHYklWyGjM5EWTGVr7zIP8laX8ry5Zx2MAa6WFbw26FmuYAjP6n0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ced+2FpX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ced+2FpX"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso20353526d6.0
        for <virtualization@lists.linux.dev>; Sun, 01 Sep 2024 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725247431; x=1725852231; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JsOh4eJLw9lku1Yzzi6p3fIeNOQvtLY0PzxWcPBCq4=;
        b=Ced+2FpXALyr042l3xz1C+Ad6M1nC+AUkjHeb4Fh8W+jCF/STMrthOfoOHj55GVdpk
         bNEvcMZmqrL2yJXwz5RgjY2EmOUtFs/FpKiLNkDdAlgGURYlomrUUPArDiXWjC7mnNTR
         T6wGvgcyQ9n1gqS3TVTbFweSYMM1DcNXwQ7ejesAyYas6uisc/r862zz1RNL/GASNIPA
         VC2QltNKvEHexQ/UoFWldhptpTONeCQ9u07mxZjEB8y3IXiexoa5N4Vkj5s8MgfehG0P
         289Jjnfh97/mkMA6AReM0Rx9HNFO/9E2nV7oPzN0GTArMM+fe4CsBTjGQHtEcf83I4yN
         ZqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725247431; x=1725852231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JsOh4eJLw9lku1Yzzi6p3fIeNOQvtLY0PzxWcPBCq4=;
        b=jX4LYTiGJiyGDWB2Zpr2Rqg7hPrMppvzmViZFYgvddZMWuuJWY2Tpuurt6XPhZoRLA
         tjQFzzkWc3oKqOoecuDJn2odlm5V01PHoiyn4Kl4+XQhI6cdwz7ODRnWrGznWSrbRKDp
         YBWT0Wx7UTfrvbVEk3PRNL8Q1ZnV8/5B7oYBBLABxJWt98fk4FR3OoY07pMHN2BlAlVb
         wbgvOrtouS/XxueQBRuLHUdY1gQGn4TPylQCz2v1286s46DIFWrZm75zHVhTRs3VL6YB
         n1V2AnZWoKpRQfkAxH2LAQZmenLvJGRFxH8lZhNd+83R981Uy9TZZex6kBSle1oNP5nx
         WwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVETqhzaoUdDUYIYk1lEIov/HXBY0N5vwPs/YQGASopuLpMiMdiZJ+l/4c+SWII2YTpafKYj7IfqS3tf90CpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeC9WdqvJ96AluFvqiDXAtgNxrYPtRVv5xYjx0kOwVTO0HCaKW
	xH8qGDHDldqiRGwi/yMGfo/M+Qok2OylqlQMTHpQ8pvRpTCLXniK2JiHOHfbIA04Sgkg5HY3G35
	mKQB6ZuvcWl8E+J9WQpSuHSXVNfc=
X-Google-Smtp-Source: AGHT+IGy7CqgZwj0mhGg04pITnfOwEQyj/TqEXX5/qFSF7FOQgHEIu6BKRvj8+Ne7YHUc9gmoU/8iIAvRzSk5zK4750=
X-Received: by 2002:a05:6214:460c:b0:6c3:5f11:6e41 with SMTP id
 6a1803df08f44-6c35f116edfmr47806656d6.48.1725247430578; Sun, 01 Sep 2024
 20:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830202823.21478-1-21cnbao@gmail.com> <20240830202823.21478-4-21cnbao@gmail.com>
In-Reply-To: <20240830202823.21478-4-21cnbao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 11:23:14 +0800
Message-ID: <CALOAHbBpw20ma7=ccc3qotnqZ=v5KDkuisMKzwr0QSv_DvkWEw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, david@redhat.com, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 4:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Three points for this change:
>
> 1. We should consolidate all warnings in one place. Currently, the
>    order > 1 warning is in the hotpath, while others are in less
>    likely scenarios. Moving all warnings to the slowpath will reduce
>    the overhead for order > 1 and increase the visibility of other
>    warnings.
>
> 2. We currently have two warnings for order: one for order > 1 in
>    the hotpath and another for order > costly_order in the laziest
>    path. I suggest standardizing on order > 1 since it=E2=80=99s been in
>    use for a long time.
>
> 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
>    is meant to suppress allocation failure reports, but here we're
>    dealing with bug detection, not allocation failures. So replace
>    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81ee5662cc7..e790b4227322 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  {
>         struct page *page;
>
> -       /*
> -        * We most definitely don't want callers attempting to
> -        * allocate greater than order-1 page units with __GFP_NOFAIL.
> -        */
> -       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -
>         if (likely(pcp_allowed_order(order))) {
>                 page =3D rmqueue_pcplist(preferred_zone, zone, order,
>                                        migratetype, alloc_flags);
> @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>  {
>         bool can_direct_reclaim =3D gfp_mask & __GFP_DIRECT_RECLAIM;
>         bool can_compact =3D gfp_compaction_allowed(gfp_mask);
> +       bool nofail =3D gfp_mask & __GFP_NOFAIL;
>         const bool costly_order =3D order > PAGE_ALLOC_COSTLY_ORDER;
>         struct page *page =3D NULL;
>         unsigned int alloc_flags;
> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned in=
t order,
>         unsigned int zonelist_iter_cookie;
>         int reserve_flags;
>
> +       if (unlikely(nofail)) {
> +               /*
> +                * We most definitely don't want callers attempting to
> +                * allocate greater than order-1 page units with __GFP_NO=
FAIL.
> +                */
> +               WARN_ON_ONCE(order > 1);
> +               /*
> +                * Also we don't support __GFP_NOFAIL without __GFP_DIREC=
T_RECLAIM,
> +                * otherwise, we may result in lockup.
> +                */
> +               WARN_ON_ONCE(!can_direct_reclaim);
> +               /*
> +                * PF_MEMALLOC request from this context is rather bizarr=
e
> +                * because we cannot reclaim anything and only can loop w=
aiting
> +                * for somebody to do a work for us.
> +                */
> +               WARN_ON_ONCE(current->flags & PF_MEMALLOC);

I believe we should add below warning as well:

  WARN_ON_ONCE(gfp_mask & __GFP_NOMEMALLOC);
  WARN_ON_ONCE(gfp_mask & __GFP_NORETRY);
  WARN_ON_ONCE(gfp_mask & __GFP_RETRY_MAYFAIL);
  ...

I'm not sure if that is enough.
__GFP_NOFAIL is a really horrible thing.

--=20
Regards
Yafang

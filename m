Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C232564
	for <virtualization@lists.linux.dev>; Sun, 21 Jul 2024 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602884; cv=none; b=chkmY9VqkKoH3MAKXyoultB3N2xZU2Kj4e3gzWJude7qFOJz+E5BEshwnJdD+9SrK7xWTx4TMXvMGAmh3KB/ZK3T6b/+NC8z1FI7F96rfzUiAAPJnet4hfAqEiO3VnEFGkDx3uQNxs/DDruZUyFGdosMJZFASWKBdS/ytVhwFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602884; c=relaxed/simple;
	bh=qHiXy97WqrqdWDaxvMhPKIxEqFyPM5RjKT0hDBluGeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByMMf85nd6igTw0rVtpq3zzBA+frTaNgSmD9SJo5dbXbcZHj+8Lp4oqg70tswG07HM0SPrM6X8QhHj4QlD65odcrkd+JO4QDEuGD2wWMazhImigT43r1jiusqDkNtJhKR0eY6bXCXiHfLibk3ePVzdL0jfUXjgnH0B81yQgvMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQnxSo2i; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQnxSo2i"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260f057aa9bso2126852fac.2
        for <virtualization@lists.linux.dev>; Sun, 21 Jul 2024 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721602882; x=1722207682; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIk+tn4TdOmmwm70v6l/KFa/IUuNmPetDUKr3HxFV9c=;
        b=lQnxSo2i55WnL1My92ImvSbTamAOWWi/xlgx20wQxRATriUtwRDu80BXa82Jw9hrj6
         VrHMKp4xGI393fs3uchwIHPPadByu3CPCdHGOHQZujjKLLwOljxBLbeNnuS9wAYA2ASz
         TTEKgoPobpQz59ei+sOCI2JC5Gc7NyyB6WME0nL25eBQYko6tqMQ0UHSXM9tFYeBL3xD
         wZ/3kOp3XCtx2ZSQ5RhjoVZoV5SzqIVnzi+8z4RrP+R0tTcraXNzJ5V8AMJY7L6erasE
         NCFEwlXhhyACYDV2hAXsqBtSalhMr2jUKUalTKJvowDczwyHfd8wNVGcrAMEgBLQ9oLs
         YGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721602882; x=1722207682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIk+tn4TdOmmwm70v6l/KFa/IUuNmPetDUKr3HxFV9c=;
        b=A3bCpEu94dup9rw81Gu2Ehb1sX9dZHelr4xkomeeiHN6yuLMU5MjdJytOcFrq0zRyR
         9K32v6nUyu1WZJ0VxiC/6GHtSObTfJ2DkL9GZeBsxCHqU4gBFCQHr3wiJLUX7yQG7xQh
         /aapQVgUxHCDNZX5s4Dks/cVGh9dYew/DbdT6qLyDIXhmQSTXxlcYz6+qPNAbF2d4dTB
         l+XZAbBSZs3vvt4HvKGfKjpujXRzOOJVntXtQevjuVxirhG7DICJEN4PSSrgvZSPvf4i
         wBW/SAoulv4B6jEgAIgvNauRTUeCXuN/Wu2yCOfqMJg077K9NE2+abIIn70vueU7Vuwn
         BRmA==
X-Forwarded-Encrypted: i=1; AJvYcCV2PRvDdB/7dIGDx4PKKqF2BA8MBQUz209ilPty/gJdB/r+j4JLXYtzsa3Oj3AvL0xYEU0ilc9Yi/et3xuP5f3ONx5g5aa6IDbBKhj6BkM=
X-Gm-Message-State: AOJu0YyuyUHZAON/WGlxZosmQEORcreIreB98F4gXyMoVVeHwcovs7eX
	psBRA/bC59GgBWusGGtvPta1D8HgsmvsGiHuw9fYbds3D4Xc00GZ
X-Google-Smtp-Source: AGHT+IGwNeV9M4R4X6CjHDisDYMRllDiei577vEHLgFOqRN1d1Ou2AFcOHtsoQsriEmw3ad0i5Bs+Q==
X-Received: by 2002:a05:6871:e419:b0:261:236c:2bb8 with SMTP id 586e51a60fabf-2638de9db8fmr5167480fac.12.1721602882260;
        Sun, 21 Jul 2024 16:01:22 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff4b5cd7sm4270341b3a.69.2024.07.21.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 16:01:21 -0700 (PDT)
Message-ID: <8ea3f19a274c58cb7cf2ffa98fb41ee530f5a614.camel@gmail.com>
Subject: Re: [RFC v11 05/14] mm: page_frag: avoid caller accessing
 'page_frag_cache' directly
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, David
 Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 kvm@vger.kernel.org,  virtualization@lists.linux.dev, linux-mm@kvack.org, 
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Date: Sun, 21 Jul 2024 16:01:19 -0700
In-Reply-To: <20240719093338.55117-6-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2024-07-19 at 17:33 +0800, Yunsheng Lin wrote:
> Use appropriate frag_page API instead of caller accessing
> 'page_frag_cache' directly.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/vhost/net.c             |  2 +-
>  include/linux/page_frag_cache.h | 10 ++++++++++
>  mm/page_frag_test.c             |  2 +-
>  net/core/skbuff.c               |  6 +++---
>  net/rxrpc/conn_object.c         |  4 +---
>  net/rxrpc/local_object.c        |  4 +---
>  net/sunrpc/svcsock.c            |  6 ++----
>  7 files changed, 19 insertions(+), 15 deletions(-)
>=20

Looks fine to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>


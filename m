Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0FC133
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086141; cv=none; b=fEDvmQtLegqtTcGlCA4KdhtDDYBurc99/Kz068cH1/PsKX6/7CvhUr+G3dIYCZrEE//AeLf48dj7ietV3xLW1gHjXmpu0N12sEG5X+QCzBkza66lsjjmehypJvoEFX8iMWyzng7MEbVhWZyEzyu/ER7QaBa2r4ItHY1QJPPd8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086141; c=relaxed/simple;
	bh=p6xx58xWZKdfb6c1AAu8Mu+FmCVOdJIJVmtwQFvNPYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzTDajWk+xQ1ahrtp8sRBNVLzpXEb39R+XY8ohijbgGfbQAeJ9MHnDA9YgBDwMxLqrqZfMyc+o0P3efLD0OqX8vlH5up0m9TmKsFVrOdeVYBxXEOtaHCzFzOhjNR649jfQa5tVpW2rsXk7Bb8rIC81+ISMwuYwDnDOyf5C8Wc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SROHoQYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SROHoQYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723086138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb2Rpkxt3LSPGve30aAKDHxWvpSeSXCq/ixX+f0TGsw=;
	b=SROHoQYX/B7hS7RSDDnmJTwuEm4bBXnzV1X3VjBqS3gUywvVG/XElx2XT4RhHt8iCF2Gdt
	4hiHCuohk6ZSbOPzwcqJ1RBc6bL2oHf17n4VMtqHQ9+Y4dwTCu7rEErVsvRomC9TRUqE6v
	gqbJ3/DJ6pe76PcJ4ZMn96vlx7hsRZ8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-dTxJ2AQ_N7Kd5f4Gvi1ooQ-1; Wed, 07 Aug 2024 23:02:17 -0400
X-MC-Unique: dTxJ2AQ_N7Kd5f4Gvi1ooQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb5d93c529so668125a91.0
        for <virtualization@lists.linux.dev>; Wed, 07 Aug 2024 20:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086136; x=1723690936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb2Rpkxt3LSPGve30aAKDHxWvpSeSXCq/ixX+f0TGsw=;
        b=D/VUCba3X0bAhVO8A6S6GD+wNwvpm8am5/178D9+SfhGWHCDHlK1t6nXLyQBuZETaz
         FGmh9p3REtLghsk6mP85HyVuT1QRkIW+t+VnQdwJd0kMIctvmj+JhTqpgpbF1n//2T03
         JUKj7nZw6GxnGt9/axJ94Uc5iAR8ns7U/HHuy3lE9TOiIVK4aoXuI6txPc2ssEfGeTWN
         nK4lOVEtEn7CctXXbVnpaOFMGl+KXmewq3iCPrkaJFcMWE7jKKqtP7eYg5n7wlVbLzbQ
         SHEePVeJBjLaxc2bUPh7T6Vj/m1u+mqCYSAKmc0o9F0brKmUZqnqdwqNKVvRZQk/4fvA
         GJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCX+7Y+tFHc+8q7LLf7koXCNEEv9aWbpquBzBNqL3gjPxJ2DK2IVsMQWk7wudyuhWQwq991FaMFohYyHXu8ORsjU2SN4GP/UTg+wtkrAaLE=
X-Gm-Message-State: AOJu0YyCUVvqVxPm1smriVC0c5GmfCNbSmqjXKDRF/yST++Fx6lN76yz
	w4sVltJAOdXrIV085jccRG+u5u1xxgX+0sXA0RF/HGfM+2taECjZy4ElN+pYiVcjTUv9lhl8yAC
	NAnzcN5S4gRvob36yqtnovBWDKtsejGBScLTgPIwkymHbjLznrHZx2iQutKV5yXO3ku4YwplTl5
	+x+YhqlDCdu4BHIxGl+tm4Yt5f1jj4R28GUF/RGQs=
X-Received: by 2002:a17:90b:380f:b0:2c9:923e:faf1 with SMTP id 98e67ed59e1d1-2d1c3396a72mr713373a91.18.1723086136155;
        Wed, 07 Aug 2024 20:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvLiP+h2FOcxwnVHbI3oWaDXPgf/3hnuTAiuAbXo2hpysu/kx+KNhjeKucP6obJyqvU5B/srn4WX8udRClcYs=
X-Received: by 2002:a17:90b:380f:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d1c3396a72mr713344a91.18.1723086135668; Wed, 07 Aug 2024
 20:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CAGsJ_4yHU3hBZp2ub1qokf2rCvK7yM0fK9CXQUwxVLn5uaVpcQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yHU3hBZp2ub1qokf2rCvK7yM0fK9CXQUwxVLn5uaVpcQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 11:02:04 +0800
Message-ID: <CACGkMEtjGZQ1phKKSNK2gv5ZSyuXf7G=+OKZAzixBtJT53jCZg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:30=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Aug 5, 2024 at 8:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
>
> the current code will result in returning a NULL pointer but
> not a busy-loop.
>
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make =
sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, =
so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
>
>
> We have two choices to address the issue:
> 1. busy-loop
> 2. BUG_ON
>
> the below patch chose 2:
> https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.co=
m/
>

I will add those to V2.

Thanks


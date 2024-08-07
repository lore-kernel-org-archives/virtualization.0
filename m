Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968018D63E
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723005488; cv=none; b=flH4Qhlou62iOvQ8xVpvvevgqHV8ub7LJJ1oxszLy8K1JkR5dSYiQlZ2aiCfQQPjNKv/rvhCSj4YZ0+SeLNfxzxNyGZhf77NDsRlTmVH7QjMubH5q9JsC33hXJP4BLmV1ENk7dT1P3hyfcOgzQviOOOwtJ8uK1Qw8AQXjzpoLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723005488; c=relaxed/simple;
	bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWtcyfJRZE6lETVnBltA+eSsgro6AKUD52e1Wrq3odjnNkw30hTlAEaTdWzSw1rSpuuSieW973gD9ACUmOydV8qL459HMoHV3eKlkeZxCGCHIfGlbnF2VrfadpwUTNq/z/a56jnNf1L9ZjtMLrL9+RqI3QtgqwxCqUYB5k56e+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMEZ00mq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMEZ00mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723005485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
	b=AMEZ00mqvIQMe+eOPzdzc3C+6EKhFvhB8gDzsMo8ESqfJUCpHol0MDwDqkxm6pAIQKK/HI
	Wy31DKzDsRw1h0eCi0cFL0FrVTskAg4fxptZSq7C8eRFykyAfvSEaFPpYQ8VNP8gmRw2Tj
	3jV9HuiCFj7zYR6nDfftRRgcwFvaBmQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-ezY2R8VKNp2AaE41FGGxpQ-1; Wed, 07 Aug 2024 00:38:03 -0400
X-MC-Unique: ezY2R8VKNp2AaE41FGGxpQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb6c5f9810so1701760a91.2
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 21:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723005483; x=1723610283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTk7jZ7lYTXpfJXcUgVHfVoqgBIg4K0nO71lHrPFslQ=;
        b=Z3lfKFHg+Vpz5UzVezr3SE+OHBSjtjuXFTuUPg9PhXOqsJqVTU4BL1lkCo4MLZcg2F
         VvXTSQqZ6IZckDUCqWCf5KzmlrLt1h7t1Cw16g/hcTKVSnjJtxBUqNFcMvRHyxiEKip1
         eeDsStZ8bwM9E71TLma22S0q/LoHURouQLdtGH6Sr/btayG2xFlGuGrwtQ+Bii3ZNpmj
         tlFheuDoR9CtoKvtoCs+rmQe7af0+2BMXTVoONM7LRhTNyr/MutyYaIkmXZky2E+HpJi
         e3g5rSiXGlCooCYcRpFLbgrb43cHnhnu2vBt2lUpMPp/OHX6FV9iPKFpqAqxZHzb5SDZ
         FevQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjSaJlt76JvpdjHMmHmrLEz79oKDAFgYwG3B/c7/ykmNsPZvz9SG/nLD9/gm/j1it3gx3uKi2hDkCM6wrlSlJBmVuN91p07kXxH9fnuc=
X-Gm-Message-State: AOJu0Yyso4OUL5I9A9w7peWz9oXVuOD5YrxTE9Dfa3wmHCqFJUG71OfU
	KzDqieDnKH9Am8q/kMkarAlGNvZyFtMLAQe9tu/SJ7SmbMQDu9+REj0w5iWt241u9EmK2tx6MId
	jPy713+u33XQJTEvE1OsIwMnRAg4kDU5qNqCVPtckleE6mOr7deyn+7An8EkIt6rHiBbLTljuPm
	X/B2gO4WpPvjjtV6KN8B9/51vuBGu9FP6iew8Wdjc=
X-Received: by 2002:a17:90b:194c:b0:2c9:6f03:6fd6 with SMTP id 98e67ed59e1d1-2cff941b383mr16837658a91.17.1723005482660;
        Tue, 06 Aug 2024 21:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWh0FV7XdQ58365EjWwj3Cvcl8CaSImWJu6gpWLZusJ2hCGX1Lyg8ktnpH9LNewdRCOQGEpYnQKc+Z6NQWBw=
X-Received: by 2002:a17:90b:194c:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2cff941b383mr16837642a91.17.1723005482207; Tue, 06 Aug 2024
 21:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
 <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
 <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com> <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
In-Reply-To: <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 12:37:50 +0800
Message-ID: <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedance=
.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@byteda=
nce.com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > Barry said [1]:
> > > > > > >
> > > > > > > """
> > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Bec=
ause
> > > > > > > __GFP_NOFAIL without direct reclamation may just result in a =
busy
> > > > > > > loop within non-sleepable contexts.
> > > > > > > ""=E2=80=9C
> > > > > > >
> > > > > > > Unfortuantely, we do that under read lock. A possible way to =
fix that
> > > > > > > is to move the pages allocation out of the lock into the call=
er, but
> > > > > > > having to allocate a huge number of pages and auxiliary page =
array
> > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > >
> > > > > > > """
> > > > > > > You should implement proper error handling instead of using
> > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > """
> > > > > > >
> > > > >
> > > > > I think the problem is it's hard to do the error handling in
> > > > > fops->release() currently.
> > > >
> > > > vduse_dev_dereg_umem() should be the same, it's very hard to allow =
it to fail.
> > > >
> > > > >
> > > > > So can we temporarily hold the user page refcount, and release it=
 when
> > > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel p=
age
> > > > > allocation and memcpy can be done in vduse_dev_open() which allow=
s
> > > > > some error handling.
> > > >
> > > > Just to make sure I understand this, the free is probably not the b=
ig
> > > > issue but the allocation itself.
> > > >
> > >
> > > Yes, so defer the allocation might be a solution.
> >
> > Would you mind posting a patch for this?
> >
> > >
> > > > And if we do the memcpy() in open(), it seems to be a subtle usersp=
ace
> > > > noticeable change? (Or I don't get how copying in vduse_dev_open() =
can
> > > > help here).
> > > >
> > >
> > > Maybe we don't need to do the copy in open(). We can hold the user
> > > page refcount until the inflight I/O is completed. That means the
> > > allocation of new kernel pages can be done in
> > > vduse_domain_map_bounce_page() and the release of old user pages can
> > > be done in vduse_domain_unmap_bounce_page().
> >
> > This seems to be a subtle userspace noticeable behaviour?
> >
>
> Yes, userspace needs to ensure that it does not reuse the old user
> pages for other purposes before vduse_dev_dereg_umem() returns
> successfully. The vduse_dev_dereg_umem() will only return successfully
> when there is no inflight I/O which means we don't need to allocate
> extra kernel pages to store data. If we can't accept this, then your
> current patch might be the most suitable.

It might be better to not break.

Actually during my testing, the read_lock in the do_bounce path slows
down the performance. Remove read_lock or use rcu_read_lock() to give
20% improvement of PPS.

I do want to get rid of it (e.g moving the copying some other where)
seems it meets the exact "issue" here which introduces some behaviour
change...

> I will test this patch
> first.
>

Great.

Thanks

> Thanks,
> Yongji
>


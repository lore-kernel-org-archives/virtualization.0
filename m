Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2E18B47A
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115381; cv=none; b=qi2hDN4gWUePLXtXtiuwiyjQh5+ft2T3F2rZsnTuIW5Tisxqlffrt7Raxheh9oqcaGEHB1N1ADs436/Y3wbJ7XeMbXFEiBLcnXcQNXl8QSaDBg4r1k31Mwv/paZkXfVTa3JF61zSALQlgMz2xRMP+7ipi77H1hkwt+H/7trHJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115381; c=relaxed/simple;
	bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8pmfpDMJ3tEfINbGHNPUHpPnJC6D6nuB3uaOxgXimrsrzwlh2qFiOHXIm5lxNhdyf/dmTJ/z9OIICitEj2TlwChki0bCAlUaAcuJNIc7jJH+w5kz+4DhUtUnLTxBn82XVyuRHXbq5kiKmTzuvIpHxT2h0f/jp1/F7sz8nU/HcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=km4S33Zw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="km4S33Zw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so684871a91.0
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723115379; x=1723720179; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
        b=km4S33ZwVBY3RfDrAV6ZBb5lLlT1G7SCPl/gkHQ5BzD9gJQFcwsW81Kw8i50X7Fvsa
         tYWpZ65NK9tpqIMp0YWWf8tkMMFBWS/2eANJZKcf8DZThKTIa/Ha/5ztjv8kgyCCoQ1T
         YJQctUFHaggZMKgIyGzIOvtRFN51qDITUkAoP6kySozvwK7fYUtlbtuP9AkzmjQg9Rq9
         1gkwoBjkJIgUezTXCsr5nNewPYRJK5iUeUtnRSEfE/DyOQ38+z6cX231AuOnZVvYA7Wf
         U9UbwHXMQWwaxt4P6/OMggxn3xNaSVk2i29EhIXYvJUsb69H/aSDA8RbvUV+IFtf2VbL
         GjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723115379; x=1723720179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqREpNz2czTLdFvatHVsNu8CiTFdhUryn9i0FvgsMqU=;
        b=i4xVYxGkNVjKUegepUtGln0QJRgHou0DlcWe/nTStyBqfh6LZlaCGOlI4HxCaV6gBY
         T/pBHPNdie4/voTZWc2cP6N//ibAP1u5O5oFy6sbRGerth0wUpBPB0/lCdcHSl9aPR2I
         v79uVf7nAAp3YruF9rz6UqpyEhXI7xY6akDLxTs4OubSfKXTUo5lzS9hFds7fasdu9+A
         8GczUnAvhS/Au4YVaQZkp8RPeZicAX0IETht7V+gk2XeQwxZHx+en4cyWbArKPPKr3ph
         +jzpJ+NvQYguMv8eNmQLDkef2Jl26dotl9ihyGJ32tmVhaawpF2x8OnkMetJXNm3uFFr
         PrAA==
X-Forwarded-Encrypted: i=1; AJvYcCV1pEC1v72AphqxSNJGYibYbzymW6WTvbgb82t27SZbpQV1wijy4ccZDhTa3bmnxuRcPxme1h9BD6VturV8Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVCfQdZL5YaBRJx2bhB84vAqxZLf9XTz4NiYihe55xn8ABFb/Y
	BBfxGYWQzGgltPWzhtyRH3MwexSbduC+LfHC2d4lxRrQkCAwzjqG/j2Zm4xPj3VKJv2DhdzOlla
	0hxTBILc9trc13q43bJjib/dvYYFFTOhltDWB
X-Google-Smtp-Source: AGHT+IF1qBmPDPJg8OZVzV3ty1jXdjjg3Q9zRacN4Dxr2BvK/Rx+IyX9zIk1QFp239xb0EcMSZr9bHA2Raf4mQJz6hY=
X-Received: by 2002:a17:90a:ce02:b0:2c8:946f:5fe7 with SMTP id
 98e67ed59e1d1-2d1c33b63c1mr1551127a91.17.1723115378810; Thu, 08 Aug 2024
 04:09:38 -0700 (PDT)
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
 <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
 <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
 <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
 <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com> <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com>
In-Reply-To: <CACGkMEu+RrD2JdO=F9BySwhVY5uPr6kKWWdkcdG4XX6GN5b=Bg@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 8 Aug 2024 19:09:26 +0800
Message-ID: <CACycT3u-v+XkWzSPq39Mk9sdQftuNZvZqZyzDvhTecH3uyuk8w@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:50=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Aug 7, 2024 at 2:54=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@byt=
edance.com> wrote:
> > > > > >
> > > > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@=
bytedance.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Barry said [1]:
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocatio=
n. Because
> > > > > > > > > > __GFP_NOFAIL without direct reclamation may just result=
 in a busy
> > > > > > > > > > loop within non-sleepable contexts.
> > > > > > > > > > ""=E2=80=9C
> > > > > > > > > >
> > > > > > > > > > Unfortuantely, we do that under read lock. A possible w=
ay to fix that
> > > > > > > > > > is to move the pages allocation out of the lock into th=
e caller, but
> > > > > > > > > > having to allocate a huge number of pages and auxiliary=
 page array
> > > > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > > > >
> > > > > > > > > > """
> > > > > > > > > > You should implement proper error handling instead of u=
sing
> > > > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > > > """
> > > > > > > > > >
> > > > > > > >
> > > > > > > > I think the problem is it's hard to do the error handling i=
n
> > > > > > > > fops->release() currently.
> > > > > > >
> > > > > > > vduse_dev_dereg_umem() should be the same, it's very hard to =
allow it to fail.
> > > > > > >
> > > > > > > >
> > > > > > > > So can we temporarily hold the user page refcount, and rele=
ase it when
> > > > > > > > vduse_dev_open()/vduse_domain_release() is executed. The ke=
rnel page
> > > > > > > > allocation and memcpy can be done in vduse_dev_open() which=
 allows
> > > > > > > > some error handling.
> > > > > > >
> > > > > > > Just to make sure I understand this, the free is probably not=
 the big
> > > > > > > issue but the allocation itself.
> > > > > > >
> > > > > >
> > > > > > Yes, so defer the allocation might be a solution.
> > > > >
> > > > > Would you mind posting a patch for this?
> > > > >
> > > > > >
> > > > > > > And if we do the memcpy() in open(), it seems to be a subtle =
userspace
> > > > > > > noticeable change? (Or I don't get how copying in vduse_dev_o=
pen() can
> > > > > > > help here).
> > > > > > >
> > > > > >
> > > > > > Maybe we don't need to do the copy in open(). We can hold the u=
ser
> > > > > > page refcount until the inflight I/O is completed. That means t=
he
> > > > > > allocation of new kernel pages can be done in
> > > > > > vduse_domain_map_bounce_page() and the release of old user page=
s can
> > > > > > be done in vduse_domain_unmap_bounce_page().
> > > > >
> > > > > This seems to be a subtle userspace noticeable behaviour?
> > > > >
> > > >
> > > > Yes, userspace needs to ensure that it does not reuse the old user
> > > > pages for other purposes before vduse_dev_dereg_umem() returns
> > > > successfully. The vduse_dev_dereg_umem() will only return successfu=
lly
> > > > when there is no inflight I/O which means we don't need to allocate
> > > > extra kernel pages to store data. If we can't accept this, then you=
r
> > > > current patch might be the most suitable.
> > >
> > > It might be better to not break.
> > >
> > > Actually during my testing, the read_lock in the do_bounce path slows
> > > down the performance. Remove read_lock or use rcu_read_lock() to give
> > > 20% improvement of PPS.
> > >
> >
> > Looks like rcu_read_lock() should be OK here.
>
> The tricky part is that we may still end up behaviour changes (or lose
> some of the synchronization between kernel and bounce pages):
>
> RCU allows the read to be executed in parallel with the writer. So
> bouncing could be done in parallel with
> vduse_domain_add_user_bounce_pages(), there would be a race in two
> memcpy.
>

Hmm...this is a problem. We may still need some userspace noticeable
behaviour, e.g. only allowing reg_umem/dereg_umem when the device is
not started.

Thanks,
Yongji

Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A71A288
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000388; cv=none; b=rO9TBJWDUu4PyAlMajMY86xIZ4Uem8bpBeYnxPIGil/Ma1Z1W5FNShy3l+VpxOHP6yBl+KrodW+ql8ay/oQHtxlts8ofMGuEJJgPJjQsnnMVaKJ3LG28mHsnOzRGZwARQ896dzfPZ4BOhCWLF9SbmqSH+Z7uH5IaVCWW4d1dLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000388; c=relaxed/simple;
	bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPK1CFhAy4xcqYeZHFTqwfBbDQAOoOA8r7981BzVs4QdNFzJIgMFEfDQ+DZdRgmL8nBLZ17rIH6PqjyQTn2y0grZSkpnQvUJbrzpA9OvkZSAvWvYF5RA76nzWDc5kufpEbLZnOZmFW5+MUNk+W+cjDhQycySx/S6UITBJJXf88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MCsqT/na; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MCsqT/na"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1d6369acso352152b3a.0
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000387; x=1723605187; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
        b=MCsqT/naC2048Orh2lxfkgD0WggYZvoITr27ZAISC7P+lmH8zdH/0EqmtpVkj1KW22
         WB3eq8wkR5oXPFXb9IXEAyuWXKkYd6j88mpQ2qDbnUSHER7fVrJT4d9sM1rIlvWsIVES
         vcYlB7BBQlWP/+lg25Kz82/mh5kQSe4fsQ/emPsrzoGsDkDiLGsUWRzDdO9jdDOwiscP
         ECDoGAB0W9ZUP+0dwGG92L1Wuhs39a31V27If0IDfOhL3xW8co+/m4Kj24R0env8eYWG
         2SfqHQaOLochnj+PnA+5Nk/O+yR8tSIwLNOGUTusRz3TqmkAv0zHDxIUGesxOWorCBCi
         weaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000387; x=1723605187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
        b=ddz9z3StNzyfn4zy2ny9Xp6iRL1UhlVzQoJyYo0qnYf6pyE/KDCPR3+TfJ+/PLHbQu
         OmENXmOoYXFlcI6J1SI4yXYiM5tl1ooQgo98FYyhUU7b0UTl1CCCivM6X9taNCVpeiQp
         7HC1viLt39HR6mQVTjc019MIjagXLMTXGMFo31LYbAH3G5cm06KkISaBHaeY40EAdy+N
         00s4F+pTGylBoqWPJSNfk/BFOEH3zKx4c5xU7h+dyY+BaM6p/9lKfCDFcCTdSUme/OUP
         evbDD6xT5pHcUiU28Ay99l+FCGW+LJapBBBa+GIxalpW3RJQH+44qtbyYhx9Jm2trg7a
         sH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVwBF/Wv6GgeZSW29i2QEH9UQMemfMvFEU5zMSrqVNimJZTZiFsa8kQs+NI3vfAbLYyhcI/+qiYPpJDLsmA74KTV5bdHekKOrPEg73Th80=
X-Gm-Message-State: AOJu0Ywd0/vgmypn2A3z7q8kENm4KCM2EvxS2URV+JO75/xC98GkbxDW
	8Q1aFH0dnzdYG9bdIemCDzTY35KPaJp+ZMD4VTZ8xX7XwYkB//gzc1Tjcqfum39F4Z6olSz6odO
	K9t4OKXOhfSxNXb99gdZYboFtUk0HAePIq9qU
X-Google-Smtp-Source: AGHT+IH6TlONK/WU93+n550n6Q8wcSxTGK3Y8m7QMq+WwFosN5Gr5xEQ/ZLnf1CtFKEDOXWoK+IwxNE+go/HAnDIadk=
X-Received: by 2002:a17:90b:228a:b0:2c8:4250:66a7 with SMTP id
 98e67ed59e1d1-2d1b2d06658mr1306455a91.1.1723000386713; Tue, 06 Aug 2024
 20:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
 <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com> <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
In-Reply-To: <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 11:12:55 +0800
Message-ID: <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > Barry said [1]:
> > > > > >
> > > > > > """
> > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Becau=
se
> > > > > > __GFP_NOFAIL without direct reclamation may just result in a bu=
sy
> > > > > > loop within non-sleepable contexts.
> > > > > > ""=E2=80=9C
> > > > > >
> > > > > > Unfortuantely, we do that under read lock. A possible way to fi=
x that
> > > > > > is to move the pages allocation out of the lock into the caller=
, but
> > > > > > having to allocate a huge number of pages and auxiliary page ar=
ray
> > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > >
> > > > > > """
> > > > > > You should implement proper error handling instead of using
> > > > > > __GFP_NOFAIL if count can become large.
> > > > > > """
> > > > > >
> > > >
> > > > I think the problem is it's hard to do the error handling in
> > > > fops->release() currently.
> > >
> > > vduse_dev_dereg_umem() should be the same, it's very hard to allow it=
 to fail.
> > >
> > > >
> > > > So can we temporarily hold the user page refcount, and release it w=
hen
> > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel pag=
e
> > > > allocation and memcpy can be done in vduse_dev_open() which allows
> > > > some error handling.
> > >
> > > Just to make sure I understand this, the free is probably not the big
> > > issue but the allocation itself.
> > >
> >
> > Yes, so defer the allocation might be a solution.
>
> Would you mind posting a patch for this?
>
> >
> > > And if we do the memcpy() in open(), it seems to be a subtle userspac=
e
> > > noticeable change? (Or I don't get how copying in vduse_dev_open() ca=
n
> > > help here).
> > >
> >
> > Maybe we don't need to do the copy in open(). We can hold the user
> > page refcount until the inflight I/O is completed. That means the
> > allocation of new kernel pages can be done in
> > vduse_domain_map_bounce_page() and the release of old user pages can
> > be done in vduse_domain_unmap_bounce_page().
>
> This seems to be a subtle userspace noticeable behaviour?
>

Yes, userspace needs to ensure that it does not reuse the old user
pages for other purposes before vduse_dev_dereg_umem() returns
successfully. The vduse_dev_dereg_umem() will only return successfully
when there is no inflight I/O which means we don't need to allocate
extra kernel pages to store data. If we can't accept this, then your
current patch might be the most suitable. I will test this patch
first.

Thanks,
Yongji

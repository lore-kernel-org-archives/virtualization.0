Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE01B86DA
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013686; cv=none; b=fsgM/RNTS/vDQIHPmFZdzyN8lrNY5n+789uIHmQn4mWbicQj7AJ/+s2/5UkEgoP8BRSgtz5H5cNElwdg0gGpKpo84sjLu4qw5a8l5hvfy+uprsoX4L0k1RbQrbXCmvQfxGXSUwou9dJjDC5tjbroGgcJ2RnUHvrKb350mJVrjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013686; c=relaxed/simple;
	bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz13T3X3s95LO9NoT6RpmmpIJDZHf/qzbUGDALyfoa6fM4NSnF4WBiepVTIm63S50bdqUCbz9BqORlvd2SrLjTj02s3SX6uWd1kHUtmWlfVgr/IVlPsMJi6dF4ehOPcWmuR/HbXo8icvsUQ1nBFVQjIf9R0+916xk0KIBzqaqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U67bpJm8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U67bpJm8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so1067754a91.3
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723013684; x=1723618484; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
        b=U67bpJm8Dkh//qRKjgvyuJBe0O2sUc+SPwoEW5h3X4aXf+Hyb2Wk3NvQgpMDT5V/SL
         +ymbUFPQxyn9RHXWUSKlhpFDfFfwwgNNloiryIdvNtP+z1FaCQCvu4kPs9c/G8nxMVKj
         9ri1aqgHMX1hauc1Bp7ynuwoc5MuPe0O5VlnS9p6a3/G8AH+J82eRMy7hmQXXsMGb6jD
         AkyabzglIorkT4JuSoy1RTIw/jhoRgUy+2/0jP2tsnsvcyZ17gTYxJHfezzi/teh2Zj6
         kBjjWSaMMVmK960gilq8/WV1FtovUYhmTEM6531cw5F9gS4L8s8EG3zUug2svxD2C6W2
         uZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013684; x=1723618484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
        b=YsGJRbLw1O0Po2Ds32FTxLV6Hf2IkmNEr85hFDZt8YXNIHIuhQxuoR6ubU7y65R/+5
         tb5Mec/eq8P2RptH7YrBKMFqg+lA8hwg8ZXCRqfjJGD77aRwlCtebxGfMV1o3juTAqNj
         r4WREHJADtQaGGWSlh7lZjImP3y9Tp/wwtILgODw4DQahezojdy6r/vse4zQ0qEtlB1u
         nmOtNFLiJXbZyNXHlIXPRqn/7BSbIZJZdcGfSqxEkoFJW3ScygH5yR3V0u9CyiM9YSyl
         ouUKEL/iLVkLqyrkI9D43/gQkmMA/Uyep8tSpwzZPWxxZ0x/HCpaFtXYIzS0/ImEXdSJ
         wTZg==
X-Forwarded-Encrypted: i=1; AJvYcCVHeZTzyfhNoNMnbhVR+q4/h+2fEPVDX8v724I+Gr8Lxv9QJ1BpbRDgFaLylE4zE9V626PMIVmIUVCstGH2XMbhRjNIeHz8WZMHj8Lh8dI=
X-Gm-Message-State: AOJu0YxHBb1d9KA7VB3UlgOO7vDIjRWfNEUqs0EEuNq9x2vPxVaFgvAh
	HEn95T6/2LOKMnw/afAhOfkTA2g7FyH78bHDVoDluZiSrqRawupk1BxGjzfV03Zs4TUPxOuT1HW
	K5aQvPSCJT7XRkjJyXpMC7hbdFMXlA9gaV9lE
X-Google-Smtp-Source: AGHT+IG1mNC6LICu7gLhhF26znVEVtku9oIc0f72ydZPb+2TckdQNgA/h+OuyryMx1hoSf1rsaUxrBA3VcdDE/SnwwI=
X-Received: by 2002:a17:90b:4b91:b0:2ca:7e87:15ea with SMTP id
 98e67ed59e1d1-2cff9513044mr16717674a91.34.1723013683684; Tue, 06 Aug 2024
 23:54:43 -0700 (PDT)
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
 <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com> <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
In-Reply-To: <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 14:54:32 +0800
Message-ID: <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@byte=
dance.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > Barry said [1]:
> > > > > > > >
> > > > > > > > """
> > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. B=
ecause
> > > > > > > > __GFP_NOFAIL without direct reclamation may just result in =
a busy
> > > > > > > > loop within non-sleepable contexts.
> > > > > > > > ""=E2=80=9C
> > > > > > > >
> > > > > > > > Unfortuantely, we do that under read lock. A possible way t=
o fix that
> > > > > > > > is to move the pages allocation out of the lock into the ca=
ller, but
> > > > > > > > having to allocate a huge number of pages and auxiliary pag=
e array
> > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > >
> > > > > > > > """
> > > > > > > > You should implement proper error handling instead of using
> > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > """
> > > > > > > >
> > > > > >
> > > > > > I think the problem is it's hard to do the error handling in
> > > > > > fops->release() currently.
> > > > >
> > > > > vduse_dev_dereg_umem() should be the same, it's very hard to allo=
w it to fail.
> > > > >
> > > > > >
> > > > > > So can we temporarily hold the user page refcount, and release =
it when
> > > > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel=
 page
> > > > > > allocation and memcpy can be done in vduse_dev_open() which all=
ows
> > > > > > some error handling.
> > > > >
> > > > > Just to make sure I understand this, the free is probably not the=
 big
> > > > > issue but the allocation itself.
> > > > >
> > > >
> > > > Yes, so defer the allocation might be a solution.
> > >
> > > Would you mind posting a patch for this?
> > >
> > > >
> > > > > And if we do the memcpy() in open(), it seems to be a subtle user=
space
> > > > > noticeable change? (Or I don't get how copying in vduse_dev_open(=
) can
> > > > > help here).
> > > > >
> > > >
> > > > Maybe we don't need to do the copy in open(). We can hold the user
> > > > page refcount until the inflight I/O is completed. That means the
> > > > allocation of new kernel pages can be done in
> > > > vduse_domain_map_bounce_page() and the release of old user pages ca=
n
> > > > be done in vduse_domain_unmap_bounce_page().
> > >
> > > This seems to be a subtle userspace noticeable behaviour?
> > >
> >
> > Yes, userspace needs to ensure that it does not reuse the old user
> > pages for other purposes before vduse_dev_dereg_umem() returns
> > successfully. The vduse_dev_dereg_umem() will only return successfully
> > when there is no inflight I/O which means we don't need to allocate
> > extra kernel pages to store data. If we can't accept this, then your
> > current patch might be the most suitable.
>
> It might be better to not break.
>
> Actually during my testing, the read_lock in the do_bounce path slows
> down the performance. Remove read_lock or use rcu_read_lock() to give
> 20% improvement of PPS.
>

Looks like rcu_read_lock() should be OK here.

Thanks,
Yongji

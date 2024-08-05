Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4E143738
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845973; cv=none; b=Z2l0aEVcPUDUEqKt1KgtMLAppcbKHTaZi8XYHtaOEdK5lXQqQvjNf08BXSbXD2grkkbZAYFVl+FaHS5uftslHE43/vAMrLbAyvqyW5y/O2nyxmtz+S6l1UJWEaM7rRxkw+UYzIViBB6KJP5RXk03w76LEQuelm0IYkQvwt18RcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845973; c=relaxed/simple;
	bh=g+IntHaUbwkjKC1IfB5Zdnvi1DBuRYl5ekTYvQrip+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6Dy3T6ffD5sVMxdwv+hzChohgxgJoh+9wmffSB8iTUrj5TLw92uZftGjM/P7Op0fXNUUob1SsB4XP9mfoH60cfKfO7/eJPV+wcCFHw/VOVSF5MSBBDinmhwV8S99jvOAfPUFpmzIEuwbcGvglyIGMwuIJDPLHwBW8sCoTo34yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAI3zcXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAI3zcXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722845971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPeV1gsloDiYR3vfei+0mC3bzo4TVj+mZW32CL0XRQs=;
	b=dAI3zcXH/InGOrN5yUkG/Bpcxlwuw4pQ+FhhOhOTJiivopgQ3Qdj0q+kXLurclYDcEHOBR
	vtbJdWqjTHHKg3bjsdxuelWhsEOKU9ZvZS1Zm5M/jB+o/sTqD6EJ4IvZLecEPuboviL2R8
	aSeO+obhy6KYTc1ViJblndvVlJW7P0Y=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-MLGZF4nCN1CIpazu0pqIxA-1; Mon, 05 Aug 2024 04:19:20 -0400
X-MC-Unique: MLGZF4nCN1CIpazu0pqIxA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70f5ef74143so6743642b3a.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 01:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845959; x=1723450759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPeV1gsloDiYR3vfei+0mC3bzo4TVj+mZW32CL0XRQs=;
        b=mvfzLWHXBk+a7CrAZzmfkI+2+Es16UlLsgnmL6kqPkHIKyZzQOGpdB73+68dkxmB5M
         FTyceIQldDrliOEa/gOnaPI4p/c1NZoblxX3NAPYA7P8L4wy3w7PWeRJohI+WdegUKD2
         5I3Q+NBjk2Z72zwPrMHp8NvCQJVZNdfJij6RfqbFfqqkhQxabH2WEUiKwbQuU4mt9flL
         SfdOzFoTM46dNniqm2uzEzIxdojbLD2Nw6+TF9ba2iIzWKdDAEKF5wGwA24yp2ePV/4K
         8M5MjKVBYSaXiGjqzXPUl8mnxp+L1Wo7LyDm1HjF21MTs+/qwJ0dUMHZOJeXVnBTSUeV
         8S0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqEzwjX19UVJQthTYLfvz6UnRiod3ZdWvfcV76IKZv98SWn4aguaQrIeuZ7d3NyRkbW2HDP0gdXPjiCHVo1bYXyLiJF337gX/QVaH8WYM=
X-Gm-Message-State: AOJu0YzlouJOPGXX/J3kKftpyaXED5qpS3aDkyG82Fy1WiIXOmEpk62W
	LXFLvwTyq8fCKaD/E56BPsnXBqYRdBkrRpNFrBMe/qaDdZgg/6y4P1Wm1CimRFRip1+HWKh2ngb
	ozr3LAr8lRCX1tApapQUY/LhTuEym0hWjNsHifyxzZLKvdJuOh4iQ8JBIw0vI5jkgluowQdbBbv
	NhWCRcx8GcZLi97ZcDenm3/NMSuK8XUVrJoOMwmS4=
X-Received: by 2002:a05:6a20:1596:b0:1c0:e540:7336 with SMTP id adf61e73a8af0-1c69953c6d7mr11417885637.6.1722845959149;
        Mon, 05 Aug 2024 01:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCgBhtG+yOFYmHSFTJlmGmVO1awlwisnl4+298Q5sNjvlwKIWZTqtBD1h3Jrw4qpJK8bHVieJFMVTQ/lthEdo=
X-Received: by 2002:a05:6a20:1596:b0:1c0:e540:7336 with SMTP id
 adf61e73a8af0-1c69953c6d7mr11417853637.6.1722845958564; Mon, 05 Aug 2024
 01:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
 <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
 <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
 <a7276007-7567-4f8b-a9c8-e491e571c80f@I-love.SAKURA.ne.jp>
 <CACGkMEuqnkN2LUwUkRzmR4jQtDHBb02KJY0assOhc+s9wQ-qUQ@mail.gmail.com> <CAGsJ_4yJ1XO0_9OUW+jhosi02=6bC6yPFhRQ=P5tSckikSV3bg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yJ1XO0_9OUW+jhosi02=6bC6yPFhRQ=P5tSckikSV3bg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 16:19:07 +0800
Message-ID: <CACGkMEvjCZW65CssoBseZJg1R-eobb4Tvdwik8yhLyGUqm1OxA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:32=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, Aug 1, 2024 at 2:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Jul 31, 2024 at 6:21=E2=80=AFPM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2024/07/31 14:05, Barry Song wrote:
> > > > Jason,
> > > > Thank you very much. Also, Tetsuo reminded me that kmalloc_array() =
might be
> > > > problematic if the count is too large:
> > > >  pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_=
NOFAIL);
> > >
> > > If "count" is guaranteed to be count <=3D 16, this might be tolerable=
.
> >
> > It's not unfortunately, the maximum bounce buffer size is:
> >
> > #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >
> > >
> > > Consider a situation where current thread was chosen as an global OOM=
 victim.
> > > Trying to allocate "count" pages using
> > >
> > >         for (i =3D 0; i < count; i++)
> > >                 pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> > >
> > > is not good.
> >
> > Right, I wonder if we need to add a shrink to reclaim the pages that
> > belong to VDUSE bounce pages.
> >
> > >
> > > >
> > > > You might want to consider using vmalloc_array() or kvmalloc_array(=
) instead
> > > > when you send a new version.
> > >
> > > There is a limitation at https://elixir.bootlin.com/linux/v6.11-rc1/s=
ource/mm/page_alloc.c#L3033
> > > that you must satisfy count <=3D PAGE_SIZE * 2 / sizeof(*pages) if yo=
u use __GFP_NOFAIL.
> > >
> > > But as already explained above, allocating 1024 pages (assuming PAGE_=
SIZE is 4096 and
> > > pointer size is 8) when current thread was chosen as an OOM victim is=
 not recommended.
> > > You should implement proper error handling instead of using __GFP_NOF=
AIL if count can
> > > become large.
> >
> > I think I need to consider a way to avoid __GFP_NOFAIL. A easy way is
> > not to free the kernel bounce pages, then we don't need to allocate
> > them again.
>
> Let's try to do a fix for this patch as we are waiting for your official =
patch
> in mm.

Will post this soon. One note here is that I don't have handy
usersapce that uses userspace bounce pages (neither libvduse nor DPDK
did that).

I hope YongJi can review and give a test on that.

Thanks

>
> I guess, further optimization can be a separate patch later in the driver=
's
> tree :-)
>
> >
> > Thanks
> >
> > >
> > >
> >
>


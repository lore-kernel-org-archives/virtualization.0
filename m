Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544712E75
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911305; cv=none; b=DfbMuuWZmjqAsMV9xUfx73q6HEZjcPez8q75QX3RbNXTutWQTvkWzwWMK3zvluwbQ4naFTq8scD7ZKaXyiNgQpr5GpI29X04Oc0k3otCIniXyMgOheYJdP2IGpPP1iSZ5q8JHYT2gSibWEutM3CNIEMDro9LZGPwyitcrzws1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911305; c=relaxed/simple;
	bh=RCtr3tcm3DF2AUgHL7KDfXrJvYv0n7KejT7VoVCN7dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSv2ylWNWZi6ge+vv1FISWFRKFsJH6PyxP7Raqj/E2yIkBoVAernwySvGvggD6PN6/LYeWEnhFiWaWIgOGOMmljK71vTE6u7TfiGVV5fKJgdRrgOH96XNwcfnXEhAJX2h4t8sA3tT1hXaBiRc5t9E9GXnAniD7AiIK1/ANxLO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITc5KAT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITc5KAT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722911302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCtr3tcm3DF2AUgHL7KDfXrJvYv0n7KejT7VoVCN7dA=;
	b=ITc5KAT7rW/aY/T9xCoNSdgd7FIOeYhMIfcEwEDOunPZio1zk4xkExA2Dx+nUXwvSQBh2T
	mX17oS9T73kF7X7tASC/aHgMdRl8Z/0H8ZKEmeOegzCbId15ps8SOUfZVNsiEDvmobwzDW
	gG2UhwEOett9bETG9IU91sJrmFek0bc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-I9zgzsiFOPelTVOZgTctgg-1; Mon, 05 Aug 2024 22:28:21 -0400
X-MC-Unique: I9zgzsiFOPelTVOZgTctgg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb653cb5e6so162358a91.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 19:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911300; x=1723516100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCtr3tcm3DF2AUgHL7KDfXrJvYv0n7KejT7VoVCN7dA=;
        b=X2HU+FZyXPYpfXeFDyJP1fKT8W+5OMGMNrNrQzzwpbfOb+bYrpt/LG1ErSaOIPE4PY
         24db6vM+BLeWDIDCMTMy1k9/OS8IDZ0Clc9JFjPqnTr/TYvNHenBcvJA3kmJDgfLp71e
         0hZADuJ5jISKWvSwfsh7vCGVhf1yvaAL0FwEANidf/Vd9B9QwbeCJhMJCWMCtv+PTtKc
         l9EAyXo0Rwr67VM385XDz2ITHKVFkFEicY2UMsh0vVMQa0UR/DYjK2z5np3sP/9SJob6
         IgGyZIHwhVkCrIJkfNG0UZ9Y7nnaSpExeu7a95UiDx3juXnRH/LFF/7ldB8nmZoJMqe1
         zWlw==
X-Forwarded-Encrypted: i=1; AJvYcCVQpxry+XA9ZXt3cg2aHZyG6QOejKKMMAuz4uloWvhx01im5ueIhrnx0RWe0bVj/EO8AQ4OpQU3/Lg5R+RY6ZD7KqtVfMNpZPATwfb/ZjI=
X-Gm-Message-State: AOJu0YxaoMv6CrOqexIDHxzvcXsIVHOgLURS2M2DO8Mm+JYYjXIAWlIq
	rbQbtPdvcWnLNXHoGnanNvjt90Che4NBKlmOxLntbc8K0bYDi4C3D4DunWS0syf/BiQkIdqwPJo
	BbYtWFGddwqA9i9Cc3nPRkG0VHOFzaaz2DUGdJe9vbn1HEZs2a9/UItWKuLb/2qUhvLXl84uE/+
	U9MLrFrLswfFm8UB7MEpzp32FROd6XgJYqxhJzPe0=
X-Received: by 2002:a17:90b:1812:b0:2cd:3445:f87b with SMTP id 98e67ed59e1d1-2cff95298e7mr12474311a91.29.1722911299799;
        Mon, 05 Aug 2024 19:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCY2l2H8pECfx4W7Kisstu0pFCjpH1L26dAC69h0mCW8/2quAbY6FQIvUicWh3jktk5vb10nn5Wnd3lKIXd3Q=
X-Received: by 2002:a17:90b:1812:b0:2cd:3445:f87b with SMTP id
 98e67ed59e1d1-2cff95298e7mr12474288a91.29.1722911299240; Mon, 05 Aug 2024
 19:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
In-Reply-To: <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 10:28:08 +0800
Message-ID: <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
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

On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > Barry said [1]:
> > >
> > > """
> > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > loop within non-sleepable contexts.
> > > ""=E2=80=9C
> > >
> > > Unfortuantely, we do that under read lock. A possible way to fix that
> > > is to move the pages allocation out of the lock into the caller, but
> > > having to allocate a huge number of pages and auxiliary page array
> > > seems to be problematic as well per Tetsuon [2]:
> > >
> > > """
> > > You should implement proper error handling instead of using
> > > __GFP_NOFAIL if count can become large.
> > > """
> > >
>
> I think the problem is it's hard to do the error handling in
> fops->release() currently.

vduse_dev_dereg_umem() should be the same, it's very hard to allow it to fa=
il.

>
> So can we temporarily hold the user page refcount, and release it when
> vduse_dev_open()/vduse_domain_release() is executed. The kernel page
> allocation and memcpy can be done in vduse_dev_open() which allows
> some error handling.

Just to make sure I understand this, the free is probably not the big
issue but the allocation itself.

And if we do the memcpy() in open(), it seems to be a subtle userspace
noticeable change? (Or I don't get how copying in vduse_dev_open() can
help here).

>
> > > So I choose another way, which does not release kernel bounce pages
> > > when user tries to register usersapce bounce pages. Then we don't nee=
d
> > > to do allocation in the path which is not expected to be fail (e.g in
> > > the release). We pay this for more memory usage but further
> > > optimizations could be done on top.
> > >
> > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8Z=
Q2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8Z=
Q2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> > >
> > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce =
buffer")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> >
> > Note for YongJi:
> >
> > I can only test it without usersapce bounce pages as neither DPDK nor
> > libvduse users use that. Would you want to review and have a test for
> > this?
> >
>
> I can do some tests for it.

Great.

>
> Thanks,
> Yongji
>

Thanks


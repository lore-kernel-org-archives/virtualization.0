Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D198149E00
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854541; cv=none; b=Db7tFdhG0rmXzUJpOZqDgjM3NuZEuXQU55HlsuX6t7lqKvTIhCzK6u9Vj28szrI6G0OIlQHx9OIlmjwAP2/QR7LWzHFYt7KDr4l0J/XFQRUZLrj0UnEQb9RGq3w/WAdgSWSKx8WCEnQwsb23BWHQPWgweOHLOMvV3mTOpjXXonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854541; c=relaxed/simple;
	bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5gm057+UANGVRc6idr/FyjahT0K70DC9AacobeflJgBWzLd53/09fvIWOnhdkp7PmquLD+PWmAIn9nleoXy5PrUibmt9HN8pOkq/+Sv5cBlMAk9dmJ1yfUHc4dCSc7zYMyvot2thwR9laHEAGvL2AxfQ4+6k6cJ4EtS5oDUupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bqGQ2duR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bqGQ2duR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so7555401b3a.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722854538; x=1723459338; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
        b=bqGQ2duR6+KuSVuK4ZgTWc56/eg6KfnKPKRlTxySzZ07BRAiPgSEyVJz0ElWjE/e2k
         862RSinECm6EuoxyG4Fmaqhq8++WOdzakFZ1vTs6IdqiAusNQbD61/Injugx5qyyxRqZ
         Yohx728jcFbbJ/F4Mrazl73/wflM4u81BhEB4tc6a5zraMl1nqexwo4sh8shGuhUao6X
         tk0eRtg4kXVf8G3jMgE3JWN1aQTT8e1vIl0c29mRGbOSUk+SS5bVNJXpKNM/B7xCrgMg
         4ZJgreCLmCsvMdXp3opvFAmm1u1Q9wJrE9Wt8tLG8Dk8hKwGFv9Srd7C5DZVAyC6vlxk
         Wr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722854538; x=1723459338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FefjCS9JO0pgTqWLtDs1WkzzdqkkS+cMM43SOFPyy/k=;
        b=avtUpj+u9zU85SwP6tg1SMAzC0egImlj74qUFbEez8K+fVsqfRFmd++l6BYbUpDHan
         6+JMG3cmkd4kbEWShKvWNbEuo3p7cuG2UL/TYbF1fglPqP6rhX6uCoNHXRUZfpQJnqQn
         OwPE5SzGQURhbkUe/oW8Lfh4r9PnhSATfeEmDRtOa0KwB52Uf/MKePO01ZUXMRlrf5ZR
         XFaJNnEBZ/nuB1Y2dbHWTf+3z9QJoBnlQlRSGeKVrEt7EB9w0CnQzlxvhzN+qMVaxGti
         5t+26DnD2MRw+J9w+ZgXHanfCrAjDvk/0qYd3DJeTht0wuK2f1nIEII0CpuW22f3cT0J
         4LjA==
X-Forwarded-Encrypted: i=1; AJvYcCXnoXavJ78pnLhd6qs/iy343mUzsZAh9qpe8cjEacjkgFnA/ztkDl1E+KtO9vjgo4tJeJjNcGgMI1s2z49kcyQu6seqH8/8ZE8x81JD2yQ=
X-Gm-Message-State: AOJu0Yyx9kteDvAVupvU1cxMqRBSdNAa6L9jqC+1peOk45mUxc2jmv1T
	ID62x0Tbox8fI6wtfH6qVBg1vPmtqB/MLJlfzr6tDxxT/TMEV1GYPvzbTE+nsScR2CvMIJs2Ylt
	epQOTOAjkah7b+F9y8UYRo/WXDCZeYFkDhoWi
X-Google-Smtp-Source: AGHT+IFw4VZjzhffqjzriPK34h+9Q9/nNAVuqTGi+iy66jK9C2/MunTIueyB4IGjU77PXNHL75GZq3CubKPUdyD4hdU=
X-Received: by 2002:a05:6a20:c916:b0:1c4:8824:24cb with SMTP id
 adf61e73a8af0-1c69956aaabmr11279652637.12.1722854538144; Mon, 05 Aug 2024
 03:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
In-Reply-To: <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 5 Aug 2024 18:42:07 +0800
Message-ID: <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Barry said [1]:
> >
> > """
> > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > __GFP_NOFAIL without direct reclamation may just result in a busy
> > loop within non-sleepable contexts.
> > ""=E2=80=9C
> >
> > Unfortuantely, we do that under read lock. A possible way to fix that
> > is to move the pages allocation out of the lock into the caller, but
> > having to allocate a huge number of pages and auxiliary page array
> > seems to be problematic as well per Tetsuon [2]:
> >
> > """
> > You should implement proper error handling instead of using
> > __GFP_NOFAIL if count can become large.
> > """
> >

I think the problem is it's hard to do the error handling in
fops->release() currently.

So can we temporarily hold the user page refcount, and release it when
vduse_dev_open()/vduse_domain_release() is executed. The kernel page
allocation and memcpy can be done in vduse_dev_open() which allows
some error handling.

> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage but further
> > optimizations could be done on top.
> >
> > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2=
saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> >
> > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce bu=
ffer")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Note for YongJi:
>
> I can only test it without usersapce bounce pages as neither DPDK nor
> libvduse users use that. Would you want to review and have a test for
> this?
>

I can do some tests for it.

Thanks,
Yongji

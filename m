Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0991D516F
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469252; cv=none; b=b2MRF9gQCR1zjRRjxIENhf5RPQRv1A05j6wjXdQSLfHf0kT3JhyYAaL8+GnvOkTx5Gj3iJ12dxmL5ltkitKQWOX0ftaSXZPVc9DnZU1892nxNR8Bw3nBuYJjWHY7ekqmsBqIbaUBJA5MrrL1LgkJodmyBEDRVJ3RN0xh7B368aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469252; c=relaxed/simple;
	bh=INHCV9g7S0q1m2IVXiOJftwDpaPmTbEq/X94iWftqSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhafOGm8JUJh4Xe7MU0B8/kv5z6M9GnFvuKW4fZ8xo60OKuaMJqhkUTLeUWOZ8TcmyDNCyHdfHSSVNVeij5Rae0xKPrrhwhREf6pF+wS7pppaSKFDT5a0yo4yTm8jjGcT4SAmdUe1se6/wuawNzadQ+rhjGYjuJGBCbVU9s6dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEGWp3OT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEGWp3OT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso206078a12.0
        for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734469249; x=1735074049; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INHCV9g7S0q1m2IVXiOJftwDpaPmTbEq/X94iWftqSU=;
        b=fEGWp3OT/Jsy8VxTKyZSs2dr5NqkwSGJt0Ol/ioEOKMLB7rAdpXGmZgFQWt9/TIBak
         6Qo7o1PGBY7tm9vFqgI16SYLCczFaSdh96nec9avTjIyWrixSLi359YCyfDk1aKB+qdd
         4yHiqS2UdOZBQhqORBAuC0c1J6WzrDWC0MsUyJNukdSaGep19zBSTJ1Gn/TkDvH5e01p
         QpOe9hQ1Y9UdShTxYJIWunyGEFcrHvBiE3tyurb1MS4uh1LsFjJvLTdT23NODmb0qb4q
         YbA1D59m7f5hYFSfzWq5FWcfHiUxO0g0yPLXy2Ht/qSym0JAv74Yy0qPTEju0qA4v2A4
         ntaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469249; x=1735074049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INHCV9g7S0q1m2IVXiOJftwDpaPmTbEq/X94iWftqSU=;
        b=NVIXmc5Qvs01QESFIXRZP79Nif784Kaff0qhwopvvEn7DKgRzPPSObaCJ5OhM4O6Q8
         AETVMZGhm+rYFGoeg852WTYDIUOK7KiBvVo+DNx0RD0Z0FR4ysEkl45o0sNt957gRD/I
         D5g+wtzhlzt6YrBHDszH3KfgjGs6fPZwWopJSu3NVNzC9yUvAxLvsDLEF6FIdmWT6NLN
         CMiSa+yjHrQZjf0HKtCLdE7pm4NvL9+4NMqJB9l30qyKQXy2hNv3r1wPC85WFtBqipuQ
         1g/6TIfFpt5AbrRt0t1CN6C0tJ3UL6NXllj+j5VDvRd+sv6wRRGppUUDXYHmpiDnD938
         C7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXZhhTV5RCPcs01HgKjm3nlLH7Y1vrlLttniECHuEQ1AuSVg3iRSpDctH4OO4NbxQDieb1Nh1UZbTDc9MWxkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA+t9sAIC5Gxh3Meu+pD0OA84FxU9yQK9JUWo6hKwGf1Ykv+0D
	TitU1Im9jNeIrMbqHAvu4/kusF13stS3CmIdiXTA8b0IAM3CgUaVpEceY/mU7uN1iQ1WuOjyaqD
	alB0b3O4hepuuAgqAzV4qbURwKeI=
X-Gm-Gg: ASbGncuWC/IVkwK0/Dg7Qthx4FcKsYFUcV99Ob5RPKMdolZf+rpKwRoycf39qzDCb9g
	9p0IECd8Apx3HYcr0eJDiFm5OsDJSKKTV5JuY
X-Google-Smtp-Source: AGHT+IFHf4Fsj2G5kYDkmrWOuJ0ZbLbpmTkR4fwRt0Klc0NOJT0DyBzTmeB2D0VpGqL4MxzKPGgpgwaEbImDj00MlCQ=
X-Received: by 2002:a05:6402:354d:b0:5d0:7282:6f22 with SMTP id
 4fb4d7f45d1cf-5d7d56175c1mr5324324a12.14.1734469249108; Tue, 17 Dec 2024
 13:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org> <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com> <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
In-Reply-To: <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Dec 2024 16:00:37 -0500
Message-ID: <CAJSP0QWfSzD8Z+22SEjUMkG07nrBa+6WU_APYkrvwzNbScRRCw@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for virtio-blk
To: Jens Axboe <axboe@kernel.dk>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Christoph Hellwig <hch@infradead.org>, 
	Ferry Meng <mengferry@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 12:54, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/16/24 11:08 PM, Jingbo Xu wrote:
> >> That's why I asked Jens to weigh in on whether there is a generic
> >> block layer solution here. If uring_cmd is faster then maybe a generic
> >> uring_cmd I/O interface can be defined without tying applications to
> >> device-specific commands. Or maybe the traditional io_uring code path
> >> can be optimized so that bypass is no longer attractive.
>
> It's not that the traditional io_uring code path is slower, it's in fact
> basically the same thing. It's that all the other jazz that happens
> below io_uring slows things down, which is why passthrough ends up being
> faster.

Are you happy with virtio_blk passthrough or do you want a different approach?

Stefan

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1AB676
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911179; cv=none; b=kBpua1rMiOjecZ0liSz3zzsDrKgf9RKCECjDAewDxhryrZlzttqnfYGx2hArKhffiNV2LclDOeK1YjUkCkSPPhqmx/gKru+UQVbvPUxquErxCQkEiIOw0XBn5VMKKtSqpQgBeozrmMciKL6ZU6ia3Z6ZuHybvS8VEIEwsces+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911179; c=relaxed/simple;
	bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieQxc1gz1lqsiv/iIPc8WBAv6v5QMKf78HG18c9vBSzOxBqRanRtYceRaX/UX+bqnsjLqFV/+tgZWrMFhQq2kuVg5v729C584tQGb1uwc3+ErTZti+V8Br8UqJ9+E8YaIvbcB+GAT/ytNX5hWPaBDQJvwU6VDKuMm8pMk7BJu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPCJyPJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPCJyPJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722911176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
	b=bPCJyPJ92rmJBAACY3OGDVTn3MjfD53x/gFN334cCRgH4rMBAWdaJTu171rZfnuVKB9PH+
	XUZTXUqrt9w3AC3Sj8uW9arIvHplyB1KleQIj+EbCQXqmAAkixOFwLANt4Go0zBVDQwUlQ
	yZaqHd1QHKXf546D9In3a2DPBW44fP4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-JOSf0MXwNleUwUoqY_4uuQ-1; Mon, 05 Aug 2024 22:26:14 -0400
X-MC-Unique: JOSf0MXwNleUwUoqY_4uuQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70d2ae2e4f3so205713b3a.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 19:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911173; x=1723515973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6NTygJfYjeiDGiiM5Z7PFfl8zAiOPhgCZVHXHCb3mQ=;
        b=UGke3vFRuB8XDPZhv8TjGNTpvGQE/Lf/D/sTl288NHkFiw+IrRjQZFOgqryO7Lm1NH
         goX6REcgFnZmqhvy2Dz7SRZpcQe9KZLzQfs58q62NX9xGptaCn1OkmucmG+AwZl1bXdY
         o3EODk6xgG6BQjeshvnVAWUFQD5REtB9LYWX2uHXg9BAv0tfnzSpXbwz5LBgPgr0YgEb
         zJ8ZWVJIbnW68xYikiInfW9ugy2RL93c30sa7ItJVKNl4Hi6d49tx1sBB6qkSi/1P4D0
         DHZ9Bt4CXTJe2QOXH4TBZ86799kQltssSVz5r490gLsLYtjlHq4PC6FAA5yvpHTQGs8s
         UO6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXfNpkdcI6RMQBgzuLjTOffkDC0gjwxPOnx6UtfiHfniQV9SSR9s/v4ToQX0fX1QHXWeGdcS4YfY1vtyNqjvf5wFu+RRlmpQJWqn7P2ro=
X-Gm-Message-State: AOJu0Yxuw5fFjzM7sif5RLSpC6/eBXuixftpKurivbqPqXmtGe5K7kbV
	J8BPCH2mSfYVDZcFGhBbFxJlQDmLq6vRbSLv30LTHCkX54G5igLZHSrk/1A7p1XDFkjJ/5jkrN4
	quAAGPYKn2QaA1oorVr80+4jjho+GamElAH8oaon1fh9/IXdauSceRkaRGbhpZ8R48c2tsAxg4+
	j1sV6gAQA+rnK5oHdXxQo9s1877TAdAuP18UtABW0=
X-Received: by 2002:a05:6a20:72a6:b0:1c0:e612:296d with SMTP id adf61e73a8af0-1c6996a03e4mr18761545637.54.1722911173002;
        Mon, 05 Aug 2024 19:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfuGebwST7wXEt/UP+32zeyEU8M+cGevEYOCeQzf+mp8OawI/DOWjnqYlnHzgC5I4WJomU0+EyO3jX+bhI4VE=
X-Received: by 2002:a05:6a20:72a6:b0:1c0:e612:296d with SMTP id
 adf61e73a8af0-1c6996a03e4mr18761531637.54.1722911172504; Mon, 05 Aug 2024
 19:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <20240805042421-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240805042421-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 10:26:01 +0800
Message-ID: <CACGkMEvsagVFdqkZvoRWRC2sSSNkjSA=eFjnZU=yT_F=GvQNdg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	maxime.coquelin@redhat.com, xieyongji@bytedance.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Aug 05, 2024 at 04:21:06PM +0800, Jason Wang wrote:
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
> > So I choose another way, which does not release kernel bounce pages
> > when user tries to register usersapce bounce pages. Then we don't need
>
> userspace
>
> > to do allocation in the path which is not expected to be fail (e.g in
> > the release). We pay this for more memory usage but further
>
> what does "we pay this for more memory usage" mean?
> Do you mean "we pay for this by using more memory"?

Yes.

> How much more?

Depends on the workload, but basically, it's just the maximum size of
bounce buffer:

Default size 64M

#define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)

Maximum 1G:

#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)

Thanks


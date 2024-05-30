Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A4183965
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059992; cv=none; b=aZy9nWbBLxiEQ0/hCfoNK2T/8tY3xgz7C+a5T3VA500k+neyZ8ZvRKkAGmJj772HYNKTc1LS748oJA732nNXq+bQ9ze5j08kn1nB57hG6xm1ZZa/SLV13eeTybPNku31DZ6ZeLVRC5wAPQ8ur08TjoTwDclQoxKRzGCxEMi04kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059992; c=relaxed/simple;
	bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPcEI14gKr7U7FtFMT4Zyn75zfYLl4NIyE/btSthIMqHy5b6aUyIPNn/lpOc44MJW1mY5rJ0k1K4h1i27Gj811jxeb7pNRT7/mI1OoFrST8C7EpOAql3FLLyl3ADvJCg5k4mzC1S7JIszyd6CuAYfmYCFoErPXV6W9gzYJbaWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MRlf6Zsk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MRlf6Zsk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a352bbd9so102911366b.1
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717059989; x=1717664789; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
        b=MRlf6Zskr48cWUhk52Acv2YlI+lP+GQGsuNzU1VLsliBiESlkB62BdHvEGYM1T3t+u
         H5pVGCAxfBU0oTgzhvZG3sGx2dJeCW5f8U8RRNK7SJqCw5neHCkrjpBoeiSq8YOlk91M
         oxR7nrORrP32p5czafXdCfKfQoZD6UMjzwygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059989; x=1717664789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SlXO2clAhdignpywm732PA1nnVo+Es/NHnvGg91cY8=;
        b=JiCnDnuPistq8wwL6zLOg87ghOcdlt/xFeoPdl7XQ6M5sQq3H67hVIwTAs9bvOgVKY
         LpCXHp2/W5TSjJd5gqavCLkFitDxtXFJG6YzSpfdT7qcyN1sfjlge/5FFFwONa3UY2/9
         2z2bH1afZqwKwAZnuLTaJ9qH05xX02AQiY+KXMC4njeoy8Trbak+YImFRagUbgZTSp/X
         d3cByZVzN+4O0oIELiBt3dynygcnt4KYOVHD8u6IDVsL4yL5wusX2AZJiqiGGziLISah
         BPFkjWhWy/t7LhvPsg8ODb9pQViWw9ctkmCdkZZIJ012IG03vxZJz59eZiYuixBptGfF
         8t6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF1aR2PxZqj8k9f3tyfT1O76Qo1wjdkd4EfRKqlYPA7GcNvuv48nvVmxLD/hpB2xrc3lkQvRxXoP285v6HBTi1h0QdppxojjN4c3xlITA=
X-Gm-Message-State: AOJu0Yw32+2IP6oyXxeHMLixibJiLqRIR0wA2J0K549QI6pHanVFnOYD
	+EhLrp49TYzWgDmHmRQ+3pCC2KAENtFqBYegVu58uIf96GkJr6oFkohR1GOpVWeiDquNEIrSjBp
	vrZ5B+xFSeZESXn4q9KUHbpsmXDGBeFQfCQnUlA==
X-Google-Smtp-Source: AGHT+IF2ROW2D7QQi2KBd4btTcLT0IhYRKSDbw2K7YstlOyb5B/N8AQT7s7U5qGsYIeOkmkLJoZcgLieUKeLTzGCEfw=
X-Received: by 2002:a17:906:f2cc:b0:a59:c807:72d3 with SMTP id
 a640c23a62f3a-a65f0a68e65mr107437066b.17.1717059989102; Thu, 30 May 2024
 02:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <20240529183231.GC1203999@fedora.redhat.com>
In-Reply-To: <20240529183231.GC1203999@fedora.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 May 2024 11:06:18 +0200
Message-ID: <CAJfpegtWhTQcOCjwvPCsfO97TPPNu7+a3+0NAMqBUHfyAJYjug@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 20:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> This is a little scary but I can't think of a scenario where directly
> dispatching requests to virtqueues is a problem.

It would be scary if it was't a simple transformation:

insert element on empty list, remove only element from list -> do nothing

Thanks,
Miklos

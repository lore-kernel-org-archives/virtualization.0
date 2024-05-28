Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B64C97
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897576; cv=none; b=eSrEgFiQV3nMBrDB+Efkc7/jb+9XYJeITqxCx9i+i8L5T401A6sasOud7HPgyg5sVgo5m+0lYnCL4u0FhWWuwAqT4/49RZAJb5hxICG5+JLjIHcAe3jYHBBXx3UZvvZwDfk5RsL7dg5p+BIzPHIkO40pdrE4qoWoOF8Jr6fF1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897576; c=relaxed/simple;
	bh=s6g2xr75DPjwvTNFBy9wB2D+Bjws0UAhj7h2VOc4Eu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0tS2ogGKtIeLsUieB44dnHjcLHf6khhqnj9uaT1fYZURbVKdH3lSJGjC8joU0XdDQ00+nUrFupLGXFhR2DhxzJaJKx5qhZY/8w4UHIWm7by5Am0VJV681C9nbUmLJN/QCB2VR7BwXJD3dghtEXf00rgHBguiyF+YX35pBUr2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KrZB7+OG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KrZB7+OG"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a626777f74eso92346666b.3
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716897573; x=1717502373; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=THNN8GkzAmG9oL9YgeQemXCNW5SrSDue8NeUnoDMW0M=;
        b=KrZB7+OGr5Q/44RuCctpdsKF4qtplhRhduT1JMsOU2nFktOYvD9wC2BltzQUmMeMvd
         eaMWDeVbK+wh3xqyGfZT30TtGGVZkONdPN7zHOTeho5WPmfqExQIn3ibbkZKt1yIFP9S
         q3bViBuusX7/iJXKnCy1Y5/arU3yrHUW3jRzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897573; x=1717502373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THNN8GkzAmG9oL9YgeQemXCNW5SrSDue8NeUnoDMW0M=;
        b=OU+FuH8E+sBVKtydRuZ8lTo55wl6/agusytu/iyUZ/IYsmjc7pH6gmeMeiHx+soZIT
         b5LfjRdimFP+MRg9Pg4lfwT1aYgYRny2XbvTgwE92ez0ECJ3Ug7DxtL9ADzUyTJVcQtn
         Rgnw0x/lz+MMQwMHbYWCy2yZp0Rx6WPNrxy47HNbDYTR3sbc4ga6QwMLE/5O9rLkS6gB
         /+m0rL7ryP8mgADJsWYNvqcn9ttbyRb0/cZWYU7bmLD3Ca89jfZVioVQWghgjpv0QJF9
         dlzaNEucXfhX1H2zDbzOglsexJuPUmHmGp3OsDN+0wWda5I+1HKL9GoX2OWSMh/r/f+Z
         lb/A==
X-Forwarded-Encrypted: i=1; AJvYcCWGSn/aWT7hD4NnE4BH29p+qCMeEeCTvCBbDvIfHqv7jBrs0mFp5qUk77RGQCCunu2fYWUHN6ShItjQHwU9RJpooeUsut8GqeKIlZC6DlM=
X-Gm-Message-State: AOJu0Yz+XGoJFgXKA8Y8SFhYAUOFeHOAmIxD7giwjwVN4W+e6bkpePpb
	IdLWraxyZoZYYdhKwxL5uRu0W+sDoArQ1jc9apS9lMAq1a4x/fyODiR7b8jrcd7Lyo9d9UTXPpm
	xpQ6H+PziNfFBFuWZRRT/MqEIRJt1LEqcJIJNbQ==
X-Google-Smtp-Source: AGHT+IFoivlr9L3bEIgsjBISCwKV3YwgNkXHNn7gAr2htvM0x/PVzO450R6w6blHyzNF6fWf6x8Yu8ALWMejI+GxGYA=
X-Received: by 2002:a17:906:c106:b0:a63:598:88fd with SMTP id
 a640c23a62f3a-a6305989d03mr578701766b.62.1716897572737; Tue, 28 May 2024
 04:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240501153817.540855-1-pgootzen@nvidia.com> <20240501153817.540855-3-pgootzen@nvidia.com>
 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
In-Reply-To: <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 13:59:21 +0200
Message-ID: <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>, virtualization@lists.linux.dev, vgoyal@redhat.com, 
	stefanha@redhat.com, mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.comm, 
	gurtovoy@nvidia.com, Yoray Zack <yorayz@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 10:52, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> Hi Peter-Jan,
>
> Thanks for the amazing work.
>
> I'd just like to know if you have any plan of making fiq and fiq->lock
> more scalable, e.g. make fiq a per-CPU software queue?

Doing a per-CPU queue is not necessarily a good idea: async requests
could overload one queue while others are idle.

One idea is to allow request to go through a per-CPU fast path if the
respective listener is idle.  Otherwise the request would enter the
default slow queue, where idle listeners would pick requests (like
they do now).

Might make sense to also optimize the way this picking is done if
there are several idle listeners according to how close the listener's
CPU is to the one that generated the request.

Thanks,
Miklos

Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550216E893
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902592; cv=none; b=pSyq6mvi+SPsr/PSYKYNnIrs4lOpyuC3BZbw9A/sPATTJ9G0ulo026brejgcfWIcFDpbBW8vhdd4URK+E/7TMPpFaqS4dg/W3LWKUd7YhfqrJxI+A24S4gXBlR37zmpkFCrkTfBhBF7YY7IDVZ2iKWkdeq1KDuGo/gidZbAg+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902592; c=relaxed/simple;
	bh=DUPWtduwp8zdLSDmPTMi/nkBLwW3F9PjmBRfnnXZTZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acccKyYaArAS/xFviLb7lRk21BU712ujhQzRHtVMfVncY1fM1jPzYXrA9i3eWuay08StwTB5Qu59H6pp1nIrxlakQ2EhkiZX5GIhr7qw2DeEavZmJ4j3Sr8q+OKy5BpWVwVaoLv61SkD/V+8o9D3Hny3C9QwGjkbipYW0vkxhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AaxTDTML; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AaxTDTML"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso106153566b.2
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716902585; x=1717507385; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95y0vEjud7FjbUTny98W5RKv7IktelcJIICgIHz0yTE=;
        b=AaxTDTMLuxSXJEnaFRghHs6Q2w6MkAXH24mSV+fVtOEC8/s/lepppEqHXoCOu40Go8
         Psl7J98Pav5tMJvU8QkobzOTNCShwMwsULu9AQeFwU64gLISjfN5y8r0DTdFxBFmbR8w
         Ptm7AAbN1CE6p8DhI2JmW6U/xIkbwm4j6ehPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902585; x=1717507385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95y0vEjud7FjbUTny98W5RKv7IktelcJIICgIHz0yTE=;
        b=ffa+ppgCsOe2DUEXtO0qOGghf4L6U7fTzWptpS1PF6TdmNnSLJ+p60vgpwkldKBdNi
         w3Yt6yYI+mmLkP8AZuYaEhSdPOPn12hCyBOW19cECrVK2QHEMWdvaAUPyxZZsoO7MTt2
         6tzvf0TFWiuVWEUVDaBAJYF4KGW+XWTQPdwQ79zb53KdOdsnQBkN2M/XhN+yVUFoed7T
         b+RMmsRrD7q6PcCDdNZuoqTzc3nBvvBbMQi5Nab4Vott8cEH/JTiCOpLQkJtyU8XPchF
         0qrt50ehT7vzcztRdjzciUwE/3wU527Sbzrj9Ec1LRY2nZ7UfTi8p3+K684fSL/LTpHS
         L2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVpdACR/miyXlyUC+mrYn7QjAjCZvsdR5iMPrKca/iVoEGIGELcEF/cJQGXZN3HM4x8wyF9RwFAHTg27pvouDEdDBB2AJe8u51A4cHVbiU=
X-Gm-Message-State: AOJu0Yz302Nmxg/nACGvDKMTNL2pbjzTrjvIgZlTrgr8+3t22WcCfU1m
	5xuMeFhrS7eue/q5qf1JyZ68XY+qbm1GhzlqEIF5L0Gz8xR3shfeH6UooVa8iGUZEvlCIaES+MZ
	8z0Ygz5zTvFhchGpWOcJVLRWQ0e4iWejc3F2cjA==
X-Google-Smtp-Source: AGHT+IEuy2fYV3xKXM2nUqnxUca3YB5V8WOG0oxiAhP25lpRbZBoObWOsdgqKq+L1T6qtSdMgNI2OTyzup2szo6f4e4=
X-Received: by 2002:a17:906:2ecd:b0:a61:e825:8a75 with SMTP id
 a640c23a62f3a-a62641d9a10mr733127066b.18.1716902584674; Tue, 28 May 2024
 06:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240501153817.540855-1-pgootzen@nvidia.com> <20240501153817.540855-3-pgootzen@nvidia.com>
 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com> <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
 <4ac6b36f677c2447d1e4987435dc0f990fdbe996.camel@nvidia.com>
In-Reply-To: <4ac6b36f677c2447d1e4987435dc0f990fdbe996.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 15:22:53 +0200
Message-ID: <CAJfpegu8Yced7pXNTFpEpHWe+DMTdeEsQX2ukgGEquwOyJcKEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, 
	"dgilbert@redhat.com" <dgilbert@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Yoray Zack <yorayz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 14:39, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> I am not that familiar yet with the FUSE driver. What are these
> listeners you are referring to? If I follow a FUSE file system operation
> like fuse_statfs, I see a single-threaded path towards the
> wake_pending_and_unlock of virtio-fs via fuse_simple_request.
> Or are these listeners something from the virtiofsd implementation?

I was thinking of the regular /dev/fuse interface, not virtiofs.  For
the /dev/fuse there can be multiple threads that call read(2) on the
fuse fd, which I call "listeners" above.

The design is outdated for both /dev/fuse and for virtiofs.  When a
request is created by the filesystem it shouldn't normally have to go
through that fc->fiq bottleneck...

I'll see if there's an easy fix for that.

Thanks,
Miklos

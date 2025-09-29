Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859229ACDD
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124604; cv=none; b=R5CQPD1aMUGATROrpb7Ztha3z6cpyiBgQDr4gOgb7ytqD0LXtuiAtDQecgmKZrMU+iUHu/e93rdRs+pYWLRjesoh/Vqp2LJFFKF/1KUKfWSy+IGh7S/Ce5ZOl8V1d0sHEPwCks3nJ7l40ojL7IeKxZdv+AbEkqEBQWrnhqvf0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124604; c=relaxed/simple;
	bh=KkdQm9LnjT0oDZgSyvNFLyYVXfgAVdlyFZQg4ncaicA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUvmypUxOFbuAKDerI6A2p3kchfCR9w0BS2m3KTJFxKCRpF/z7L689kjQIMy68rtP4ioo34lboT2HjyVt15ZQbOLPW1yeyDysQxBw8UhtY1a82J03TI+N0291SsnQcn4DY722/mdlrlEO6lE/6xphGhkCyQFeCo/nRYlZ62xPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4SYWBIK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4SYWBIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759124601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLDJM/v1GnCONjQIRc/rqkZtzK/nAlZhViXrPHYBAQ0=;
	b=a4SYWBIKNl0+RB4rJnBzljqyHVCuaPpLfGQ6worWgLgYbO4b8uvMpTcNYLvkKTPeUI/Eab
	3iPfqHu2meLxpNZCwoacBac8WMp3baanW1KOQqs3CisKD17nQOGoPouwnSR1bAgJht+bLR
	9H385REQkrFGthMHVkr8/qdv+aij6pk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-KEyW7jt3OKuHrqzrfDIgZw-1; Mon, 29 Sep 2025 01:43:17 -0400
X-MC-Unique: KEyW7jt3OKuHrqzrfDIgZw-1
X-Mimecast-MFC-AGG-ID: KEyW7jt3OKuHrqzrfDIgZw_1759124597
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63541ee6187so5106141d50.2
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 22:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124597; x=1759729397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLDJM/v1GnCONjQIRc/rqkZtzK/nAlZhViXrPHYBAQ0=;
        b=dOQUOFoIaC00O9hK6h3cWJ2EUYK8fo3wbGArDf4bMU2vSxTK36njMyAFc0Fuu7K0NI
         ErrS388JFPZA1cd8XR0SItAYYGoAQK/hI9WsIWhF6F74wFrLxr6whEa67UkqFTHitCZB
         SEOs4ZSzeC/1EClLYMTxvC9s/qz35gnWaCPlkkCfff1w5rbD2OfkqGrSHo4+fsr0a6a5
         WNWpWFBPv+/0V4RPwVlY5H1z31JenexZOiFGbUZN7YuRC1mMur7bgYM1vqzmhMm/H+wp
         i81RIaGpTOxolJWp06K/6UeeWWg51ZyeC3UixbH4oueg2nZsGq2fHsK2G6Z+NJtw4XIB
         sT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAqeJEmgUKFZhM05bZlqMJlUEc02j9LyLjwQU19K9Lr2gyKBNFy99U0dQSKf+dIcvcAqbCJx/tUpwUr0f3SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYEPyRWH60mK678Boi2g85GzC4zf44ewKswXWJk/8ryRkSYAeg
	GL5e+JTwM2F98I9bHBawg7GIUQJD+U+oCm0lKH57WrNbSTaVHbm97xRg/T+YcuIHfEeaDaz6BNg
	M11xg+YaecAC3MhKaMLtl3K45IM5I7/jl7NIFVUfOx3IuNKg4Q8Bjkh8p9H4s33qdz23Khe0u6t
	qVuUnxAYQ36DIPFIpXIzwn91exKi07NNCq0eGY2CygjYs=
X-Gm-Gg: ASbGncvBhOrDyFWNOAIxuqldNqvV62foOLkJIlfTuQxlSf4k9bMWTNYpSoUX5Y8g2M1
	u92hDtZcXyw7tvBmuu1RgXdZny2QKLIJEb7vRmixT4MsrFBPUR+zaU2ss/mPyhyBwP7lNrla57f
	alQ2DJxM7p3SqVQXENlAj6MU+ef5xGx9dps41n8vLvav5wh3lt3Duhq2rhyLyhEBt0ZSpvYueJk
	vf9Z0gi
X-Received: by 2002:a05:690e:22c4:b0:635:4ece:20ab with SMTP id 956f58d0204a3-6361a873801mr13564068d50.48.1759124596994;
        Sun, 28 Sep 2025 22:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZRprYWH3GKFK0J+/EVnsfKtUL40W8QVLXJUwLVUPi9R0BTd57XmXjDp56sXiMQ2Op70w6PccJcX5wX4kfJoA=
X-Received: by 2002:a05:690e:22c4:b0:635:4ece:20ab with SMTP id
 956f58d0204a3-6361a873801mr13564052d50.48.1759124596652; Sun, 28 Sep 2025
 22:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-2-eperezma@redhat.com>
 <3e5abb75-2192-46dc-a44e-d66fed87fc63@leemhuis.info>
In-Reply-To: <3e5abb75-2192-46dc-a44e-d66fed87fc63@leemhuis.info>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:42:38 +0200
X-Gm-Features: AS18NWBlM_AwzI2-s0Otvy63KDuzlTLedZ6DoP5wCZ9FlMjm8eYezVLoJQUZ6gw
Message-ID: <CAJaqyWehjiVeq360A=1_+=eRSDjoF3zNsNF0Lf-45YeiT5Pk7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] vduse: make domain_lock an rwlock
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ATbN3Ynl6ngDBn_pvSfByO_FkYBSJB1SlH5qY_7tc20_1759124597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 9:01=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> On 25.09.25 11:13, Eugenio P=C3=A9rez wrote:
> > It will be used in a few more scenarios read-only so make it more
> > scalable.
> > [...]
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..2b6a8958ffe0 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/device.h>
> >  #include <linux/eventfd.h>
> > +#include <linux/rwlock.h>
>
> Lo! My daily -next builds based for Fedora using the Fedora rawhide
> failed yesterday on various archs. I suspect it's due to above change,
> as this was the error I got:
>
> """
> In file included from drivers/vdpa/vdpa_user/vduse_dev.c:17:
> ./include/linux/rwlock.h:5:3: error: #error "Please do not include this
> file directly."
>     5 | # error "Please do not include this file directly."
>       |   ^~~~~
> ./include/linux/rwlock.h:27:10: warning: =E2=80=98rwlock_init=E2=80=99 re=
defined
>    27 | # define rwlock_init(lock)                                      \
>       |          ^~~~~~~~~~~
> In file included from ./include/linux/spinlock_rt.h:153,
>                  from ./include/linux/spinlock.h:455,
>                  from ./include/linux/sched.h:37,
>                  from ./include/linux/percpu.h:12,
>                  from ./arch/x86/include/asm/msr.h:16,
>                  from ./arch/x86/include/asm/tsc.h:11,
>                  from ./arch/x86/include/asm/timex.h:6,
>                  from ./include/linux/timex.h:67,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/jiffies.h:10,
>                  from ./include/linux/ktime.h:25,
>                  from ./include/linux/timer.h:6,
>                  from ./include/linux/netdevice.h:24,
>                  from ./include/linux/if_vlan.h:10,
>                  from ./include/linux/virtio_net.h:5,
>                  from drivers/vdpa/vdpa_user/vduse_dev.c:11:
> """
>
> For a complete log, see
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-x86_64/09603789-next-next-all/builder-live.log.gz
>
> Reverting the series made things work for me.
>

I don't know how this error didn't shout out in my env, fixing it.
Thanks for the heads up!


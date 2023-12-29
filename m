Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B414AA2
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VYYZMeRK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F7EF4017B
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 22:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F7EF4017B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VYYZMeRK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZnstezF65Nv
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 22:54:21 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 59DF940128
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 22:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59DF940128
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a2699ee30d1so595719166b.2
        for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703890459; x=1704495259; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6m9VLF20O4X/KrY9sImyrM2z1XysljU0MX887Rj6Zms=;
        b=VYYZMeRKyNZPQlXJ+MIsaaTJZ3bA57sJswBlNgwGGehCrOGbKWQv2+7tW1jnY27W0v
         5fqShSRYHKmr0c2HJmdSeMJ+ca6bOe6DI2UcCVpPNCejYAJTK/5my3AtPwPVGG4hY2HO
         jAUeZWm4RqNkmUtOt4jkfmZPuZmFSGYFCrKVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703890459; x=1704495259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m9VLF20O4X/KrY9sImyrM2z1XysljU0MX887Rj6Zms=;
        b=xRCjG7EsVvxQ0K+n04cWcKfMOkgPqMip/PclnLksZEvjjS3XTxzN3MG5TnYXksRCH5
         ho8b4TdgAnjCr8k7iCS/eo0SRxtsQaczqOM/ulS5JklKu8zXSMMO4TUmjx30RusFqrv/
         N4NMH4CE7hFGxqlnyD0D8990TgNqpusoSBMEhjd439g/BHH4aMEOD6Zu7kwIo+mjPyRA
         pmSc0xCwgs4yjnjCz2E5N+ldi3guFl92zO7mXJ4uPgyMFY+G7CeTh5wsWIRwSLS9WAFd
         B+szHMHtzqx3QtoZnDtkmtv+H1h0jxMRXE9iov4Ts+xz072gK4uV6VCOOGpyz30Xstfl
         gRwg==
X-Gm-Message-State: AOJu0YzgyyszgMXpFCJItGWNUy2G3z0Wc7tD80LJfvZJDsx+0U4Hm0AR
	J/XfafHsp/lRuxoi9HYf2SgGwcY3XpBofMaYx4uUN/K5uc4H+dgF
X-Google-Smtp-Source: AGHT+IGr6PH0Zke7fmJPwZfTrX0FGuIpRp9oqeV7DrorI3Ly5HmFgGpi4bWfAhyv8xHwWvTdyKuERA==
X-Received: by 2002:a17:906:5346:b0:a26:fcee:e76 with SMTP id j6-20020a170906534600b00a26fcee0e76mr3024099ejo.66.1703890459370;
        Fri, 29 Dec 2023 14:54:19 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id my20-20020a1709065a5400b00a26af2e4d58sm7941375ejc.1.2023.12.29.14.54.18
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 14:54:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a27bdd05fd5so4300866b.0
        for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 14:54:18 -0800 (PST)
X-Received: by 2002:a17:906:15b:b0:a23:6084:d5c4 with SMTP id
 27-20020a170906015b00b00a236084d5c4mr6851817ejh.34.1703890457697; Fri, 29 Dec
 2023 14:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com> <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
In-Reply-To: <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Dec 2023 14:54:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3pHPAyNNaZ78u-RA=iwN8CPkfe69txoK=b0oKdKfROA@mail.gmail.com>
Message-ID: <CAHk-=wj3pHPAyNNaZ78u-RA=iwN8CPkfe69txoK=b0oKdKfROA@mail.gmail.com>
Subject: Re: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:56, David Laight <David.Laight@aculab.com> wrote:
>
> osq_wait_next() is passed 'prev' from osq_lock() and NULL from osq_unlock()
> but only needs the 'cpu' value to write to lock->tail.
> Just pass prev->cpu or OSQ_UNLOCKED_VAL instead.
>
> Also directly return NULL or 'next' instead of breaking the loop.

Please split these two totally independent things out of the patch,
just to make things much more obvious.

I like the new calling convention, but I don't like how the patch
isn't obviously just that.

In fact, I'd take your patch #1 and just the calling convention change
from #3 as "these are obviously not changing anything at all, only
moving things to more local places".

I'd also take the other part of #3 as a "clearly doesn't change
anything" but it should be a separate patch, and it should be done
differently: make 'next' be local to just *inside* the for-loop (in
fact, make it local to the if-statement that sets it), to clarify the
whole thing that it can never be non-NULL at the top of the loop, and
can never have any long-term semantics.

The other parts actually change some logic, and would need the OSQ
people to take a more serious look.

            Linus

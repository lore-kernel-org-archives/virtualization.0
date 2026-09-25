Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF044C64D
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321378; cv=none; b=cmUxQI2Re3rc+vHqTKEioAPDcZx/Syg6PM+7xlzKoIqs+B+8wA8SeMrJcC/M+GXHroP1f2OLjVRWbrKJLOZKZ1zGa/eyr/+5q2TVwSkHOws9ybKEXRQ1wGgjB+reMv0F2xmYWtcJ8/JDNHCZy2Kxunbma6qhsS0vColWtu8zhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321378; c=relaxed/simple;
	bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bff6VmYRBB4eO86yXyGfoyEJf5E7bhelP5MoXUxaYTbk0xMeuOk/4uT8OgOE3J+gsNriekw5Omo7qugpyreDTvhXaNXP7foPWQxrLyNMY3Bxu57D/kASoNxgDhCwREjtRcVIgVabzI1phW/Iy613lhQNZ4/i0haT6K0ml2vUcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTYsfua2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTYsfua2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso3522705ad.1
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790321376; x=1790926176; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
        b=mTYsfua2JlO0nadWfNNP7zIwxxyvfYNY1CH3O/IYeLFGhvTNhsadEVbsNUodQKKpou
         6r0enrWe7g3k1WvSOY+pMsRegZb0hZvKB5M5gVkbY3q3uXL+3us31TPB4MKyZqrID/Tg
         5dMvyeEisLO+Z0EnOrmZZnstcV3z7lgO+aWXt+NOK3iJCF0gWvuvRuvDg1xEHAfK/3jU
         aJalylsbqIML2LVoX5IuWLpo4GoKMkfMoFBD+4A2QyC3ZprvUyMI+Z9f8jnejhXF6r6D
         +xjdKe+4ODn23gmhQ0VBcI9zi6pbGGUCw/oNdB3HmBRwzYTaAgUcpJepFvZhxyZB/3hW
         DKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321376; x=1790926176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29x6ry6DooqP4iiczSQvTQsuf3lHHuZl/pxLTMWhZ2c=;
        b=a6yf6Nmtw5N+G0Afy+Mn3ohYh4ORzjahG3T6jSGZp+XJ92s5zIgVZwe5cafO8y7rHg
         Sz3c6jsPwgjlOf6TO0JwouCSWESBjiuG8WMShQ0RAUN4k5yc2O8Y1mAogR3T6AGrrWma
         UG9aAviEcpFC7pA8SZ8jhu5Z9+LT+PVVg+GORpGwzBbPR77TtUFew81lUxeRfexzSTl/
         AfVcJ5QSav+xtbe0tB6+fJ2fOIvnzFWjKWNY+JaVkFsXY96OIsEI+1a2NnRA3O9RsZT6
         opqHFrtHGEuWz6FMlNMkP+6i1EsBpSkoCkKqhlMxMlNSRJ1IvDGuyR1ovjCS1a8xBv3v
         0uRw==
X-Forwarded-Encrypted: i=1; AKwUvBxWQwyGlh1wuXWhj0P95cjgtvMPTRgtFyZenhE+9gIyLynbkz9WXEXRr5l8yqgZPJ3q14xYpF2dvwe06a1kDA==@lists.linux.dev
X-Gm-Message-State: AFuF++l17KwFxdcNk6cIRahyPwuvALfUYGiWYoIuwfbXFKkaxy/deqkP
	THV40RCg6r4dnOVaSJTkNalmjLG0ZhgMGrMuZIgNPijWL/WuVktQjtlr
X-Gm-Gg: AYBFou3XyWwhYPmSdNdhzotuCNbfYdiffknQCIhszeiPaAs5mBh/NV5bWq9/LzqCERX
	26xnbQVXNhy8gV/yPa7XyhzLLTFQkLmb2Fzakju7zvS2miP3EHNXfFKt7Ny1jy0hDw7+MxW9kYV
	H44VGo6od9CcuZO28RqFKs9dwF7c8WWB75IKEVbS+kRxfbfqLpCC4yR4aL+EFMMlwM2uWjTuOaf
	1kAW4ZNNGNYWH4cuC+0yebSAKuEqeZSGBMTCy2m/3IZspe+KRLJ1P5Lfinyr6wFYQ53nhAx5Ixr
	NIZaGwGR0/AUD5yIHtOh4rI7GWJ7lEmqu2c0mhBUtYgrrs7RGA/yBwmL8Eu4iCRM7Pd5NlwtcLc
	Pij+RBeK8cA6cbgEHrdltFHO5axpov2QDnYOhj38mmdSaSfHxMeIm7gxas97yE2OvTBegC/DALw
	+uEX4QCxBDa2W1MNXzv3BRRnl+71dePYdirbPMNojkgzyIbfE9Oj0Iutu4lB7VxkZSXKnI0fkE2
	UUpm2uh9cKJwJl7Vy2TWs8kck4EXdIZ4lFEtXTTpcmgFW4tZWP8
X-Received: by 2002:a17:903:1ac5:b0:2dd:c100:313c with SMTP id d9443c01a7336-2df7e24f8f6mr44115705ad.56.1790321375940;
        Fri, 25 Sep 2026 00:29:35 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444814sm5797475ad.59.2026.09.25.00.29.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 00:29:33 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	sj@kernel.org,
	mst@redhat.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Kairui Song <ryncsn@gmail.com>,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 15:28:52 +0800
Message-ID: <20260925072912.39496-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
References: <20260925054408.10431-1-lance.yang@linux.dev> <9f63d60c-913e-4e79-9d28-890dd48ef713@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Indeed, both directions are very exciting. virtio-pmem avoids duplicated
page-cache residency, while DAMON with free-page reporting provides a
practical path to reclaim cold guest memory and return it to the host.

This connects closely with the work we are already doing. We are continuing
to improve our DAMON-based experiments, and we would also like to explore how
DAMON-based memory reclamation can be coordinated with broader CPU and
resource monitoring.

At LPC, I plan to bring detailed data and discuss the follow-up design with
everyone. I hope we can turn this into an executable milestone, bring the
related ideas together, and try more scenarios as a community. Everything
looks very encouraging and gives us much to look forward to. With SJ helping
coordinate the broader roadmap and everyone contributing, I am confident that
we will achieve many more exciting results. Kernel work like this can continue
making the world better.

Thanks,
Lian

On Fri, 25 Sep 2026 09:04:41 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Free-page reporting makes much more sense.
>
> When I was at RH we were looking at this issue as well. virtio-pmem was one
> way of avoiding the page cache in VM entirely. But it has its own limitations.

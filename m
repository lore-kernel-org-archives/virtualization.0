Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845912;
	b=UTpm9jNPwaEeb3ml0f6Nww4N06psEv4N4/lRMudjeWXcDgL54r8x6wm1ESCf1j2wU6mv
	 HU+BGvjLXOnysOROxefzOpLcib4Oz7u9qXSGOUyELL9doqfagAA9s1Rqr37mnvr62klPX
	 UYnvq7mrkbFHJxyGNvkv0Yg0zBDjMv8tmiQGV9M68PUGPocG2AT7ofSgKrpAoo532Vs4/
	 GxuFc+z+x5otxJKFYXjwEFouz1HfFZ8DYecZyTXjpEzk12dlL1vTm0F4BpQtbul88kcUK
	 cLpg9wXEO3ouYkbet3tP1Mr8x5Yx1Td5X/WcITWUEeuxagO9JLdn97UDjsQ04gaQhOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BBLE+9+yWyusDlKB+5tR9LXP9RfzUs5nseTcOEGR6aA=;
	b=WJceqPwDDe3jv+DQxB7N+JS1duMSi7GH6/Pi/VECA/63S57Nu+r38TUcX/0Gl7wb3DYc
	 Jo8yi0fEqBu0BMaDdAsJBbptvrTPZGxFF2y8VecZ9s9krj8hxusDUY5YEuMn2ideadxnm
	 E++iGYgxhEpAeMzhRvilnwSbAgj7uuapho44VFhjSMZ213z3ZZrCe5PPFvH7pX+CxmOtA
	 41HHEK5duPpaqIraA/kkqeGitcG4Db3gggTyiFP3uLIroSE/MpbnKvyqT0yi/uwx2F6Ez
	 zgxWbPDQqo7VMJsMX+alIsR2063c3pasR2tIa49Trcq/liEiock5o0tQyDQAAzZUQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h4/2qSBF";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F3606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h4/2qSBF
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd3310348d2so73547a12.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845908; x=1794450708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBLE+9+yWyusDlKB+5tR9LXP9RfzUs5nseTcOEGR6aA=;
        b=h4/2qSBFNAjWBECTZpq7imoLgvtCpYzC8EUzOloQp1W1NvZbE4inUeX0kmKDUQFHBa
         pBunfgpQQXeGv7xq6LuAMSMhzG1jqphCf1dW7fUfx0etfx1NprlR+VAwRV9fe9UYMN09
         14shu5UZPf5rpaPHZw7+7e6zpHvAtlb47U3lU0Br6j+lwAwwxBvhoUsH8aBRVlR6RNpa
         4f0VY5eBLTKAOmuRCqsn+0ygXhIr4pQ59KW2DIZ0xrUEKzEAOc2sgPzzs1nhaoYz/7+v
         b4aVcavOWtpFLAtX+uXLA7WQLKKV570EAmYW+/Q68WJzDFD1ZildwLbnNX6YYs4Cu6Nn
         1HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845908; x=1794450708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBLE+9+yWyusDlKB+5tR9LXP9RfzUs5nseTcOEGR6aA=;
        b=V6nqwoIGpdEd5dtoBagc+zNLFaAHWW73eEB3cD522uZ8V1vm712uGaQtbZEEDodZkV
         LZo5fyFBTm1P2KuIWh7IYEX/zE70q7YvXuzyVFPblYsxNuOvP0SbLbV5tkb6olyJkkcS
         rU9MYvGOzf5nxEnDe4LvAEtcYDTo3YUawH0uKSg9GfwaXQEFj1uAfMlpg+pKj3NU2ZdM
         a9noJSLIrtxRvYx1VGH2RGwZVefFM83cfJlW+5d52h1Mi5EWQcvYgcJ/u9PMHi5QrsPw
         hPbtgXp1T84Ms4LI2UukdYqLp3mBCvemYFkqRb0hgSoMrZDRSuF1gsZOn5gujEy1UhzR
         5gQA==
X-Forwarded-Encrypted: i=1; AKwUvBz1GGO+MmcOoGEjLEpEQnYS8FJYSOnicYB2p7T7AEq4SuZkeERQKsATZuChylCNYQ3Yyh/HN1icX3wzf6tFGw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+TOTEUaCRicVtlPqFhXRJvODdDH4q9DlKrMM9tCJ65mVZ4dbP3
	Pef986i8iw8LoBgeFHYx7H9iMDgp1v8sqMwoIqYsgybOowcD0bwO9MIp
X-Gm-Gg: AYBFou3isAX9Sen7CRIUzHMRrkbIdDi0I1rzwlvFPEzztMq1FO+v4XmuXdTZ01ZhSr9
	XDKALWTOaetkckLu2n8mBfJJ7j2L8cZSLbRuovPaMWgmrw87JLjvhANX218cOuizn+k32z839kL
	70RMv/6Sqwg5wqh+G7goNq6Y0uwwPh+rFR3P35AdDcsbAgLaQKOb8YheV6zdsAK2EzaI98utEbr
	aPQk+pofuNxV87HFr+XkNEX8ZDBvaUlQVJ3QKiNFw7QNjwN9ogJY194SjqEAtJuAyO54ULCLy26
	EzYbnw5021thcYM2OgxUxcFZ26o6a+PBX19BMaT0TyXHNvzFlLxCA9YRu/cWBoR0BMf6FbC2/Fg
	uoCT6/gJha7ATyI5a7r3ymaycCxcGb7r1u4NZIwClPT37++A7CvaH1H84emymgU/6P1ikd5ENv8
	vlavZsOpEH2/MGigk/qG/1Gs5Z1OQjpUCF6RrnRXQaw8BBhifReWzjmdKfpvFfBU9gKQ2sA/PM7
	ARfw+Ih9PQXCHhHBlr4OM63uL4E8JfoNIv0imHlcVMHzPvppJCuyoVWndTrKTRTS30dmcLWM5Uf
	WHkWTzlNG/gecxdm49Bx7QQ0AjshPONXbvtq+wS+E7dlCX0TXB41Nv3aN2QinwjJ7TEf6vNd7NJ
	GOJIvFzdqVsh1uxlY7ZlJCD0NW5QV5x5+IDZa1GEhQ/hpApo=
X-Received: by 2002:a17:90b:1c08:b0:3b0:9409:6970 with SMTP id 98e67ed59e1d1-3b0afe01674mr954771a91.26.1793845907457;
        Wed, 04 Nov 2026 18:31:47 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.31.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:31:46 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v16 00/12] ALSA: virtio: fix capture lifetime and accounting
Date: Thu,  5 Nov 2026 11:31:28 +0900
Message-ID: <20261105023140.18373-1-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Takashi,

This revision addresses the two Sashiko findings on v15. The series keeps
its twelve-patch layout and the same base, a4311e9447bbb219044db38897f95be112f46a8a.

In patch 7, ordinary capture completions must match the next physical
ring slice before advancing the pointer. An empty STOP response retires
ownership without advancing it. A gap or out-of-order full completion
reports XRUN, and later completions only retire ownership. This path does
not reorder completions. Valid prefixes, empty tails and ring wrap remain
supported.

In patch 10, staged pointer and ACK callbacks require a prepared capture
epoch. DRAINING alone no longer permits access after RELEASE. The explicit
PAUSED/RELEASED pause-restart case remains supported.

I reproduced both problems and checked the fixes under ARM64 QEMU with
KASAN and lockdep. The completion tests cover seven cases at patch 7 and
the final stage, using real returned descriptors with test-only ordering
and status injection. The ACK test uses raw userspace SYNC_PTR calls in
the post-sync_stop window and after an injected prepare cancellation.
The pointer callback check is synthetic: ALSA HWSYNC skips that callback
for capture DRAINING. Prepared drain tails and paused/released access
still pass.

The six changed stages build with W=1. Stages 1-6 are unchanged from v15.
The combined build also passed 70-second RW and MMAP capture, RESET and
reopen tests in ordinary and staged modes. All fourteen captured segments
matched the QEMU sequence oracle. A separate v15 comparison confirmed
that staged paused RESET already discarded the old partial tail; this
revision makes no new claim about preserving that tail.

These runs did not exercise physical VZ devices, NOMMU or KCSAN. The new
reproduction fixtures are local and have not been uploaded yet.

Previous version:
https://lore.kernel.org/linux-sound/20261105000915.15177-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

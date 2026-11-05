Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837362;
	b=beF4I4salDp4rqVxV8aqtGxMor/b52nwAti2dKQJ47ErwhssY+n2P7O3MXOXtSkFezkL
	 9Ys5cf7F8D+DCJ80ICij1bKVXlScKr5eiEscTRfERqdwWDGfz4j5bh9D3RYEfM20cE42q
	 6HPyu3QNCgEeDh+9w/in0yS4yFTtRyqmAbnS9x/eubdP6RKFlDopAp7HhaavZ9ECjHVvM
	 6A2yfa64frwj/FWnxvxA0ka/c2NtyX82JIWIgASszi1/A+E7E68U3LePw3NPeQBWmjeZH
	 MRo5amr/qPW3v2G6j21GLz6jt/BGZDgGfBW2IbdgviB4yS7MxpeF/aO/v6fJ+wBAmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vIwsFQ9mq4AE+G3auhIPcX8ZrPg+4PCX1f2mZBFZYXw=;
	b=Ve52QIk6kIMrktYoq42XPpp53XkWjVNjgU+Hgo2vx4AnVG8dX+cGlHTdpI93KkyNzZQh
	 Q6Fkbfg3TUFRaEfOgxbW84Md3lkxKChLoXmwEFGtfh/jKZ5ZHuTs9QrIIUwwkAdtzxJ/d
	 LU+FLVGSTX6BUfunZDjvJQm2suJwPi+gxFsE0IMZWe1FhYsGRJThcB2+FJLLz8Bc1zoFs
	 0bmI+LkT6vnoOUMFmF5d+EqYv/Vi1vPKxJQgEvXf6InJPjCYI0BsrrvgaRkKkZRrE9Y3y
	 QSaDq3lUeIgVV1ACMwGEQ7Pgabl4cMBH0KE1w0pd1SuD9nFAwDmpak8ApHoMqMiLFNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZ2lU+rn;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC4606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44EC4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TZ2lU+rn
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so745896a91.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837362; x=1794442162; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIwsFQ9mq4AE+G3auhIPcX8ZrPg+4PCX1f2mZBFZYXw=;
        b=TZ2lU+rnwYXzcrF3ZMnbqHx5o7yVkiX30A6izVkftouErEFVa0ZhMHT0d9stc38oeO
         yU8W2yBnTr4iK4qrjjbUAxsnp7EHC6LlSu+vb6vX4N3xu5EGTlxffHMs5BRscag4F6ws
         eK53aZjaMkN4L9ODHMr2NWLTOvJrrTMBQFoi+ZOL2Ik5qEkokVaZJ7wJ9mFzPQYp1sWX
         eYz1mCpGJOlyJOJ7l7U9tgEViX7YKAcX64v7h/Y4ngTkR9XnSkv7uknfpPmFXSzrNRR0
         +02JrYS+cZqJEndRLIFF5O88zEJY4NKLyKzEekZpYRz8UOLeVBNEnJkVCNiyBXhoiIZi
         F+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837362; x=1794442162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIwsFQ9mq4AE+G3auhIPcX8ZrPg+4PCX1f2mZBFZYXw=;
        b=Fc2yv7f6D3sgq2DMqv9zls3qZvc3NNoSmNrczUO+0q+dJAOqdVUTlTw8AkC906Cm2M
         1J8WA6YQ5Z+yoCVclDKyJjxXTYij65BsDcLk0+JXCqWJ8bjwJnTwb8zwy+GnYduDq6qY
         FDVdsy7ECuTVFgAL947K9rLyNVNjVd+k0B26bh8+wGr16eAstIXqFEVCopQB8AH6izQV
         ECkPJqn85mD9EzwYk7H73L1oNrsXCiQ3chqrzOMWgUxtVX2uL8jr5XS3FaA/mikQ/8kg
         +ElJ7KFVeQh1gLTIVouOChJlzSxMGnY3WbWefUQ6t8RhsHkI/JDnyCyUKUDrerv9ujaZ
         0lpw==
X-Forwarded-Encrypted: i=1; AKwUvBwTslPOTzyE4XVZAOI0JVwaH8TLu4jYtiw0SfYa2nJEx3ALXU9QLLBLWQMvpHOsvsnRvPae500wZykMHK3BHA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9H/bkzPpO9YF4x+bW+Gk66ouFB483hxsElfDj0potDumuaLwBp
	JVDyXr+uU2hlvMWytu6Why8cYP9LQexmQsY75i5tkNqpmfnEJJQM+e3S
X-Gm-Gg: AYBFou0rpsuslrun1DmFHLgeygxK42AyGfeoCxSZHI+ALKMvDBtt65xSIr9I4Br+jP2
	rczl5DzQuXa0AeSiCj3j79DKnXexoPJPik0r28nXmphlol0Dq9e6W0GCMchd4ky7UUHABnxA+EV
	VVUWGQcv19mvSSwuNUFKgfeG8q5S7Xw6wYgj5BBImaZbL7uQhewv8UfhVG2RZ84IXpBZaNsE56F
	i52D6+GzelIl5dPDV5xvHoVBQPKnncZ7ac9PxXsauAeveQLCIpkoX5yyhBe+e8Jx0oL0THX3ZQU
	i8MawX4wd6M9WysdEhuwrURR6YX1kAjriU/xoKkny6vBCsTKSHZoto4EBYMgl6eEbl0oCvGDBii
	dPYxMlln7rPiiuruFNXK58egC3AekYS2/FUkqy+fpSd1+NNGk33D0LKvBDzBgUEainUGrSjDlh8
	+0sdNw+Rg2bXk3ibkymp9EeMY+lRxYB3VZaGs42cCggrPyBSzko4CP8S0sxPK4K0GXfD3y0sXm6
	KomPoCzn3zCfCDKEqViArmBcozUBtIlwi4KXfgElqpIn2cyVh/Q9Pshpn+nOZlzQ7vmDtPD9Spv
	LPmuUYHTMn2S8U6D0Nh+ADw1FeGm4+AGV04EKXbVtEFa20B5Pi1/7pNot/t+bh1XpocyojAhHHU
	Oe4VhjiyYNnAtz6Kk+1+s3dcjz1ROTqLerwwp1e3gP/Rr/is=
X-Received: by 2002:a17:90b:2e07:b0:3b0:9e2c:9b5f with SMTP id 98e67ed59e1d1-3b09e2c9e85mr2639557a91.2.1793837361622;
        Wed, 04 Nov 2026 16:09:21 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:20 -0800 (PST)
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
Subject: [PATCH v15 00/12] ALSA: virtio: staged capture recovery and PCM ACK handoff
Date: Thu,  5 Nov 2026 09:09:03 +0900
Message-ID: <20261105000915.15177-1-mynameisjune111@gmail.com>
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

This twelve-patch series replaces v14 and is based on
a4311e9447bbb219044db38897f95be112f46a8a.

The follow-up closes a PCM ACK race after the core clears stop_operating and
before sync_stop finishes. If a substream is already stopped with a transfer
XRUN latched, playback and both capture ACK paths now return -EBADFD before
they can re-enter the XRUN path and re-arm stop_operating. A transfer XRUN on
an active stream keeps the existing -EPIPE behavior. A capture tail remains
available during DRAINING when no transfer XRUN is latched.

I reproduced the race in playback and capture. In each baseline run, the ACK
returned -EPIPE, changed the PCM state to XRUN, and re-armed stop_operating.
The candidate returned -EBADFD and kept the stream PREPARED with
stop_operating clear. The capture comparisons cover a synthetic stage-04
fixture and the real virtio-snd module at stage 12. A separate instrumented
stage-12 QEMU run placed playback ACK in the core sync_stop handoff window;
its production playback ACK functions match the candidate source byte for
byte. The tests also checked the clean DRAINING tail and the latched-XRUN
case.

All twelve cumulative stages built on 7.3.0-rc7-virtio-next-kasan. The six
ACK/XRUN race comparisons and three ops regression runs completed with exit
status zero. KASAN and lockdep reported no diagnostics. KCSAN was not enabled.
The stage-04 fixture logs include ignored notices for five module parameters;
these are recorded separately from kernel diagnostics. No physical-device
capture or suspend test was performed.

The harness leaves behavior_passed unset, so the reported behavior is derived
from the guest serial markers. The attached evidence records source, build,
image, module, fixture, and serial-log hashes.

Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

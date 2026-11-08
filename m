Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182105;
	b=SsBizJNG3gUHvyOHuJPHJyf4ZR5edCCh3kUoetLddWJ51O0335LrvjkngsxVp76P8row
	 8QHd1juQF7bPC6/igv94D7KQHgtXKA3Dwa0rLFpm5x4HIcSVmBNuAi86x4vNQBgUGU4i8
	 OULsHQEkRHnmJb1GQI9BBZGXvFg0LfsnqEUIykDJFcmnO5neXcNaRQXdQG6b9DIeihX1K
	 Syu7fj9lKds5N6NpNknb9eBplmJOzv4QWNcs8cBJMP24++dHHwXE8N4SEsSAjglWNfuJy
	 xy8cyWA5CF2r2QBsf5NkvIs21C25TM6O20QieWUowPn0KToHTilD1vGsXONMiAk9xgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kE0ZWbTzn+IpvDi4kY2FVWWgcmx6tW3ivlKQ8gzZvhg=;
	b=IrB4B1DND1u1vgxKGETZkbB1sRjIDo7gfZR+uGnQFv/kUXtvITKDtHtG6kTeowhsXOKJ
	 zBDabRNy5Q3vubBFrJQhCX88th0mUKt+kmbS2nvV+zTTjoEooes4oYhCf4QfKp64bK4KV
	 BiiItLScvFRW4bTBOjrbhne4lA2lcEmara8WXsAtvve5JFznStOCqsnrlQLl53/2wjiNS
	 F6XuwJRsiCaRuJScFy9xF30LsJsp4Av4eQbIjNsMml8p5NY5teCq5c1O4M0Y46rl7A0ys
	 7rczvDEHYRKl8EB9Ta3gRqTyEbBguMtt7Lp/KLzRHs3Xx+2SnA6s5e/pER6VUSUFbOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUttI9U9;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CB606A325
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 941CB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aUttI9U9
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed2b4348fcso998335ad.2
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182105; x=1794786905; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kE0ZWbTzn+IpvDi4kY2FVWWgcmx6tW3ivlKQ8gzZvhg=;
        b=aUttI9U9P+C8Q663BuqnVnlgHK4TeY1EQ/8R5t41CnPNaX2LQILnpYijrpI6n4Ezmn
         VnVdkX9R19qxSz/oUa1fNLNyJxyhxtNnzQHWtl+SyTWsk+rz1IBsgEiX1xlF3HhurX/u
         3P9JzXJvexwve7KgmxspWkjHRgWn8BG0vagY7HIN4nDAOt5S1v2SDWtx1QFj2gPmY888
         zk88qJhexEN3N1QQqWXLpBSISirXMRCABQZUfwWXZUgCjTyA8PMy34pFWyRSlkw5WoMF
         zyKtvtHHXycT3puNyin+oRzUnTuuvoEhBaIkYHSGDF212bik7iOinlisi0KjDFtmDIez
         AZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182105; x=1794786905;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kE0ZWbTzn+IpvDi4kY2FVWWgcmx6tW3ivlKQ8gzZvhg=;
        b=DgigpZtumiHBKH+VcfSlMAN/NB/LQj+zi/qxb5edSESy9K5p40VRb0RF0oREcUsjqj
         k5rhP9EUxXmHYTY6wIE52VcRsUeevpOLOIr+uAB9nmfIrFVMYVCHsU6odw/0BxfQH4uW
         c1GEzctT6K2mIdbDFZdQwUPd91pkbIVAwv6smKJYvhT9fM++8hGloEpBPHdz/VkR1hiu
         XEKIqIPI1B1gJe1caNlQyLYBDNi+s8AhuNzNQt/pUFdduLOAYwxdYHiGp38GRmFCLfhG
         BFcHuc8bT8qH0oJE6AZ3RJ7Y55HGr1Twe41AFtTbCjrIqU5EcFxw/8NVYp8WApNWbgwp
         so2Q==
X-Forwarded-Encrypted: i=1; AL+hErEoo4BJzz/Fn+2KcmPwnevcru7x9T+tBqZHXW7cc4f3Ht7bc5V8FzfdzOYUlz7dE4ss+7XTQ9ahH5SLYfeaTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+OjYypIRbzKegMcrdOeWkDp8oMF51EZzd1q+opjNMssk8xOTu7
	InEN62Kxs//iF8x43nieEJNDjf999FFla0JH9zNuk4jl8sWKzCCvY+vq
X-Gm-Gg: AYBFou2XcRyKeU01P//7iqJ3oPj2/Xq2ENyCEwZfCHxsOddeMJUvPzI6ys6zBK40npq
	I1SVwGvaDVj1DBOqJ5T//+/Hiusa0oTB2lOCSyCFu+mZxHTbBm+HYzDLCWjJwvMAmijYYZ2YbTV
	dYe6B84vzTTzoSGlUa0zujZH5GUELokwdu1ZArAE/qrdANdI7wTnpaHoGBKRCsr2vx7BUgzn9Bu
	PrJJ1aGej+yM3p7Qivtcw+FVneCqCWZRbd9LwhZ5Eb7fe58Oq4uUZjDYyJu8suj13z2V2K3iQ7H
	P9Ip8bo+D5Xnb7iKT/VoEexsFY7LF3/xKnFxi5Y27lIvQm+jkhuPh9ZDQSQKfP4qnOCuIoH6Mn8
	lVRQ5rKLndScB3bjFA5SP6iuiSs72FgP/nLq6ZKdP5t+02Kp5mcrOqCJM25kxzhICnpCZe5uHQz
	/4XjwNwQJyjxGbVm2tfTsuS2rXCtjYgUXflv7bkHLIiq8b2/IS16ke3Yi7ufOP6BliQHR3ZCC7e
	sc56HtbgQiIA3vxhhbcJ+4zRdSv2y2i7nW0146kF3bi5Ui4fEJOPnKrxPvtvPd/mhzc6iHLG5eK
	SzyIUGsTKrUa1G6g73QK/ShWWQx7M4k5AOiW5IBKCz8nev9ywF6R5zuT2GSNJPe+w4iA1b94Q3U
	e+oZbptg2gxuCmih1b8LQVJ15EKUMtKiE/YVa9d6S9uC8NFw=
X-Received: by 2002:a17:903:3846:b0:2e9:7719:4104 with SMTP id d9443c01a7336-2ed833c45c7mr24963405ad.8.1794182104822;
        Sun, 08 Nov 2026 15:55:04 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.54.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:55:03 -0800 (PST)
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
Subject: [PATCH v21 00/12] ALSA: virtio: fix capture accounting
Date: Mon,  9 Nov 2026 08:54:45 +0900
Message-ID: <20261108235457.12688-1-mynameisjune111@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Takashi,

This cumulative resend keeps the twelve-patch series on the same base,
a4311e9447bbb219044db38897f95be112f46a8a. Relative to v20, the source delta
is in patch 10. It gates START and PAUSE_RELEASE while PCM prepare is active,
before deferred XRUN handling, and repeats the admission check in the native
queue and pause/restart helpers. It also retains the stop_operating teardown
marker for a stopped stream after pause/restart RELEASE has drained device
ownership.

Validation:

- ARM64 W=1 incremental module builds passed for cumulative stages 10–12
  with KASAN, PROVE_LOCKING, and LOCKDEP. The stage-chain build used an
  isolated copy of the frozen v20 build cache.
- A separate candidate-only hook build passed five bounded lifecycle
  assertions for prepare-time admission and paused teardown-marker retention.
- A clean no-hook QEMU capture-only run passed RW and MMAP pause/resume,
  DROP/PREPARE/restart, and close/reopen flows.
- Ordinary and staged capture passed RW and MMAP reset/reopen runs. The
  14-capture oracle matched the QEMU sample sequence.

Lifecycle attribution is static against the immutable v20 source; no
vulnerable-baseline race reproduction was performed. The combined lifecycle
and playback healthy fixture exited 1 because its playback probe failed at
raw HWSYNC with -EINVAL before attempting pause; that run is excluded from the
PASS claims. No physical-device validation or KCSAN run was performed.

Previous version:
https://lore.kernel.org/r/20261107143422.29319-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation, and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461693;
	b=GmlrG4GM14ym3JpI3efO75PxyOAAblANzArK2aWozGa+Tz0oOUtLxm/2JnGEbQiT1R1q
	 GhqOzskKQrKdHlw7t3vHTZACvfVyTjaOSdHmDA/h6KmpscBQ/j7PVo//vyuucIdG4rP6m
	 BBA5crjO7VRpz9jM3r5VM36HUcdhXakUnpO2jhX6vhD9u4MYONC5dESfdGQorqoBtW6nR
	 4COIrwmaIZNEPtPBIYi0iHSbNKUyGpiBXFZtcjH64cYlDFiKUdnqP/oOHhw4JpyVlI+dE
	 pMjeIECw8OSx6xiWP1Ze1e4zyk3bObkoaW/0Jm9P7tpG1I2yi8N8uIjkdSuuW2fTVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZBzb0jWFuu4WC1vXCF6cW6GE7gHM+sCU4Tmo420Ip/c=;
	b=jSE0kYD3G2vshIKtcTwdwum9LKJehHRVdp7qyDXOCgVhvjHagDw/mfhf6ltoyMk6GNZy
	 jLbpkqsMcmLriRexYXSk8KGgHWmhMT3Wg9tV1BUUnazdrUQKBy6zqxIyUbGJGGnrTmd6c
	 QyH1GbkeEdWdZsscXpOiZKnla1tYvbtEPZ9SkjIWHhwTNVxw3Mq25+RZ7ENeVnvqW0AfY
	 d7kpAzkxbqTvbZTAVIvx0QI/vmb0MneXOuz9UZwoOYqPJeIa5UzsbMS5xR0HAvMXdMW8T
	 iqykHy1DPVpZzLt/ghJK2owTAoLUYyTu020Uy6PW/YGgM8nJkzjpYZFezvabuBbiBwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SkZrmoK;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A8606A323
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SkZrmoK
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso5495794c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461692; x=1795066492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBzb0jWFuu4WC1vXCF6cW6GE7gHM+sCU4Tmo420Ip/c=;
        b=0SkZrmoKgfFo1EeqE6Gpu3gHfBZkje5JUXmv66mDrVqWFCvirP1Lh9/bYb+o6mtYo1
         UyXfpIdKeeIVcfubG3/HBTobzApMJhfCLkA01urxJjOxB1LGeaUwAXhQkdM5pwjQMH43
         3QQbqXv80wzcRpIdjye34g+0OTpXllsXczPMNJGUpgdotVLNLaZdKXdTmPnIAJbCBuMN
         B5BC7anu3zFVeK+OJG97eS057YFjcrQCJwe8GQr5cIjk11gdoLKFyRXgn/FyiiLOyVVi
         ogZjza6Ub7KJoz6KFVpKeQrEooezpejaL4rR7r7AQmT0hesC2bT5poJknOReLigi2su/
         1Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461692; x=1795066492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBzb0jWFuu4WC1vXCF6cW6GE7gHM+sCU4Tmo420Ip/c=;
        b=WPJbREMt0IJqpknwnKELTumPCi+iGfnJdV337L3eGY2WU4IQY8kfY8ykLS4naJDWBJ
         Oto3JqakT/3KxS2402WdAJd11OCe9LjJDaltXOJyczvtujayyCWuP4s6J8SR+QjccoyI
         +6xootcyASU9I0Za38432S6oCDzrPHAhzfKtXhzHkVGO9V4A+SmcS5aPHJl8OHLoPua6
         1tsDWtpp27xiwB2sHgvZrKr7dD+rCZGEtL1X6WcfmukyDue/qj9+jR6l8JX6RnS6bKUT
         OcZkwBVjEEpqrJ3mEMhboXgqCzWqNC+epHboSqNmzMjwq1VrVWUEJObIMPkZT4qASG9M
         0fGw==
X-Forwarded-Encrypted: i=1; AL+hErEtmFmENzjQPMIwDgrLC0uiSQR/2/VuxVNujQWY0nwaS7uS/zyWvWik73wr+aUwW04p3cnRi7LVHpFRGcrg9Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8GxK3UIQju30q1/HysvCnTXWkL9joEqSCvKfDm89TBqkRro7CN
	CxH/DBenQMFU25KkKA0Ih3aQIsaDz/jFtQ+InRx27us3TAyKdyrNa+vrcBNRNA==
X-Gm-Gg: AYBFou03Xigd++osPAOtHBrH6+dzc7Ty4ejz6mTsyog0pPqiixvfA9iRcL1pQIjKrab
	5auWJ9nDc2dttDFBX4L1a/QfxJz1B0RUh9RhXf45ZG/zgXj5Jic29fbPIVd1l55+o3IRPKWuCpb
	0+PbxAKPCT0uUgIlZzTbVT8x40Ik6MnsnuDjOPlYSMSnpuHa8AGSziZnaaMgP0Z3SMpowdjbHIH
	D4zFQSkhO1GEB43f2ASh9qqfm+Oskluh4b7dgmJ/i/8vROcN39MNeR+nflkB0yWNbk85eeaB+vY
	chh5PgCIGVkgE/zC91q2akrokkIz7WobLeT2bUgmPoiQIHh1qX5wSRnpCJ2E1LbVyAAbkVG6G6p
	SkUGBSEYcEWqkRkFFGYCFoNabShhvrhfd4BtN/UCkwPAjei/7UXkcLq5f9E/ldKvW4XIih1vjM7
	jJTlTgvVXxOrdBKarSB/8FM9le2a68NfLwojOsM7248imHKKX2cBVmGu8eMyBDi5/5qOdr8TB/Q
	mkPeZpY0erp6v/UD8Igd6yFpBlGm1eBocZPNFziNk6sSx0EUbaXYB3DkeRn1wsUmMSjIFbKPisb
	sYThIDY8uur76UJMXxueICgnON6aDONYpnEC24XAKX+ONkX8ZF161DMkIla9RbkU74muL7qv9UK
	r/Mg39IbBacvNrrA0qA/QKEyVbqcLJx+Ao26xBDIlv056a12kq8VZ4wbKcpBMSQ6EFWnS
X-Received: by 2002:a05:7022:b0c5:b0:1a7:7160:ffc8 with SMTP id a92af1059eb24-1b3c27a7bc3mr2652841c88.10.1794461692054;
        Wed, 11 Nov 2026 21:34:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:34:51 -0800 (PST)
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
Subject: [PATCH v29 00/17] ALSA: virtio: preserve PCM progress
Date: Thu, 12 Nov 2026 14:34:29 +0900
Message-ID: <20261112053446.73504-1-mynameisjune111@gmail.com>
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

This resends v28 in full using mynameisjune111@gmail.com for every
message. There are no code or patch-description changes from v28; the
existing human DCO trailers are retained.

The v28 documentation patch 14 was rejected by Gmail. Sending that
message through my Workspace account made it available on Lore, but
Sashiko grouped it separately from the other sixteen patches. This
revision sends the complete series with one From address.

Previous version:

https://lore.kernel.org/linux-sound/20261112043516.37010-1-mynameisjune111@gmail.com/T/

The following describes the changes and validation already included in
v28.

This replaces v27 in full. Apply all seventeen patches directly to base
commit a4311e9447bbb219044db38897f95be112f46a8a. The previous public
version is at:

https://lore.kernel.org/linux-sound/20261112004704.49758-1-mynameisjune111@gmail.com/T/

Changes since v27 are confined to patch 12. The other patch diffs are
unchanged.

I reproduced both capture findings from the Sashiko review. If request
N+1 completed before N, RESET could leave N+1's already completed
payload eligible for later delivery. After an external XRUN, rejecting N
also left N+1 buffered until generation cleanup. PREPARE cleared that
state in the control test, so this does not establish a permanent
recovery failure.

RESET now marks valid completed payloads present at the pointer
observation as discarded while retaining their ordered placeholders.
This lets the commit sequence advance when older requests return.
Transport-owned requests and data arriving after the observation remain
eligible to commit. Repeated RESET preserves the discard, and invalid
response status still reports XRUN. Rejected completions also release
returned buffered entries without resetting the sequence of requests
still owned by the transport.

The failed native PAUSE path previously reopened the queue with the STOP
quiet boundary and capture_stopping flag still set. A running stream
could then accept an empty completion without the normal XRUN check.
Rollback now restores the prior flags under the substream lock and
checks the reset epoch before reopening admission.

ARM64 QEMU tests use the actual driver functions with test-only request
ordering and STOP allocation-failure injection. The v27 baseline fails
eight affected assertions; the candidate passes all thirteen assertions,
including normal reordering, post-observation delivery, invalid status,
and STOP empty-tail controls. The running-observation test invokes the
actual pointer-observation helper. Full RUNNING RESET ioctls are covered
separately by the production regression.

The production driver module was built separately without those hooks.
Its ARM64 W=1 build and eight QEMU regression runs passed with the
matching v27 KASAN/lockdep kernel and core modules. These cover RW/MMAP
capture, PREPARED RESET with DRAIN/reopen, RUNNING RESET, and playback
PAUSE/RELEASE, HWSYNC/poll, DROP and reopen. Capture includes 70-second
RW and resumed MMAP phases. The independent backend-sequence oracle
matched 7,104,000 frames across seven capture phases. No KASAN or
lockdep diagnostic appeared.

The kernel image and core were reused unchanged; the modified driver was
rebuilt. Fresh KCSAN and physical VZ tests were not run for this
revision. The earlier v27 KCSAN and Scarlett results describe that
earlier build. The controlled tests use synthetic requests and a known
STOP failure before submission; they do not qualify transport
timeout/uncertainty or demonstrate out-of-order completions on physical
hardware. Intermediate patch stages are application-checked; the fresh
runtime tests cover the final candidate.

Review addressed:

https://lore.kernel.org/linux-sound/sashiko-outbox-210240@kernel.org/

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

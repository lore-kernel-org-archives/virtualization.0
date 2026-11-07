Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062068;
	b=KzxeRlZmUcgKEgWSXjWw/JewNcyGpwF9qLVAyt3pNqP8hue0bjFe1iHX0i5vnGFnrgXx
	 2iTRnWJu4Bic4NRs3NrpscpnShWRAFew+YZJ5uSBwQ4MAefwxgMnUwX9oFAVnrD4tlaZC
	 n5FxCpFP7059Oym60rIkXtNLe2qoUjTxANkqTKkA+bne0phZV77pHgomVwE6uWyiLcyvH
	 aKw8LAFdBCpI/J6tOMpx471JdGO55/tO6WO1GBWkjrOOOcUiSeFHj7lUVW2/NZX1tjZjn
	 LzW2TMHRDvJ8YeiutHnl80IdGS0hQb1FYq3LbWdUP9B4iBLiNKLymcHjrHG+urwC5ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q9IhTrICt6K+NOkiZzpJZQeSi8q6GVOO7e1Gifk4LmM=;
	b=xENRvSnauWtGKJuHHABpWQf5Oo7uDHzNlH8fbsBp6E5ZbDTgQA8nETkdLZQMq3kbN1E1
	 dEhBUO8FHgTj/ZOP2MjM7w1U9ZnDzaLgmsZYkjRar5W8vjxLUCHisPkEE7qnYTSN9W1+I
	 R9YLKF2MXRqB0LvvU97i7THZUMo+B+YGjpXQt9tb086uRInAtvXKNPEZ7KHZBNXJXrfcW
	 RR4KSePCr9WGOvQidl+imYDRhIiqq5ouilvia9zE5olQnN9v70kfd1ZLRduYd9eKo4pzf
	 Q7iJyEOPFAvykuJluO/XLHWfCBjPgXRq/Ryrjy636pSQUq4NcCO4QkNQSP4oI6YXHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6l7zdaL;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41230606D81B
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41230606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6l7zdaL
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fb88ea38cso670699eec.1
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062067; x=1794666867; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9IhTrICt6K+NOkiZzpJZQeSi8q6GVOO7e1Gifk4LmM=;
        b=I6l7zdaLU24uO0+IAJ9FqXW6PQJcl9GVbaDqzWh0giRKfnzcKR4yJZQh0u230ydjSb
         g/S8QqDIgSF8yNVDDXsu4zVXHThvLd8GNfvm8LiBSpwmbYQCzeEhYI0pTKuvmNjWnTIR
         sXXCnXBw9EuYvmK816HtmzZ3ktPyadY88D86i+fOANBgAR/nHHXPQE5WQjMMshkupIXY
         BrcE34JmF/AnPSJifzVeqScUqkoNay7/TwgXYP13NGkQKABqDC1xubOSsqWoYr9wsTnZ
         eeVCBoiLyhpKYEvXNWmudKFzk1+/CnQQND1a1JiDWB96wYtRsTyuD289Tbv7uxoexPrs
         WwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062067; x=1794666867;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9IhTrICt6K+NOkiZzpJZQeSi8q6GVOO7e1Gifk4LmM=;
        b=mFAi7Zp1U8ZZe+wIiF22vAqrK+wrJtNR+I86jnGOzCdZAJW8YDyKYxjzmShsQLkXvF
         KpklRqpbo1odFn9OHQL6pBosELkBplIOSIKksovsW06XHsTQPgbKoZR4xREBJzvLXrBg
         5btKXDoGuhuVZ9TlwuRrpsMAXjWAQmhPJe9czpJ71KpEI45qDxvjJmOwrhZOUD4DKZqk
         BshsKt9yDOF3FHUuYfeTeSJimvn7cUhgYOwTbq9xtQv5DZ0PlSpOl1EMXFKSaNumdWYO
         XQO5Gztu9xE+1yI5z4pDhpNEMDLJb8uARq+SBcvWy7Bsob61cuNIaOQBOP5WKcny6gQf
         xwKA==
X-Forwarded-Encrypted: i=1; AKwUvBwoQtB7aU8ZTZ/DBTFUiiYPCOQ/lEobHArB375FrwhsQhoSsnqhKSQ9FQyxu+Kr8p0EdcFOccbhvMpTSdT/DQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RU6U3zsLJ3H1LzY397bSrM40eC4BcOQuU2bl/DCxBH/1fHEXS
	0COrlQmPsWamdVbSxbENzunxTNk7sSpjk1crCxdCDt54QBvlxcns89pJ35DJGvW/
X-Gm-Gg: AYBFou1W6h4JNvB3Z1x9BjYYwfa90N42Im+IhyfpELVvEmBr01u6mdDe8DWj7oN7xcL
	geEU21x24fE51TcwZwrnF9DSTThsmNJzQkXDdiLXIvwIV7ya0Mw4SLQuvibP/yPe717HicfLQTr
	bbFZPZT5HvGaWx4MnBhsIhx1c81E7IYys0Q1G+T9ZRsDSSbTDyvFRF2Qut3tHe7uUMypI3QBYzE
	uH2e2JdBGTeB08mepPlicwp7SgAJ0/RasFsTVX+6osgTuawhym47bJV2sgvU8PRZZrYUWmALZBD
	DKJ6g7T+Dyqul5SRnLwZKbw05e/Yyme3ecU+/WNns7EK0DUKpnISn4xc9HSUrxI+spd4qMRQQlU
	0bVTCZ5LXWUIvQ30zMoDfDw7ISYk+IEyqjmz3BrmPele51aOnmEwv6L8YO6xFgeAhFXWE5qg4D3
	Xetu70TJhVKT8kPxBGFgf6IsqG+iz7Eq4hXgorrNWT+Csac/Sf6+sAuFqct9zifIRcoAP5bdknL
	gmYBdpdihP7SwCLecKwP2FauHTK4shinmROECRNo1MOVgVTVBNWlIo2Howv5/bMjDN4FqMObzY3
	eIxJIc5GM4exaIN9dMUJWfZnzqbZneSKYLrntXxtg/Zbe78gCYOzhjB1hjXxDQMe3LGXq9SmYrH
	DSDQxEl8G1FGKsNx18YqauqbelpGLm3L2SmrnfYr/VEQVwg==
X-Received: by 2002:a05:693c:8819:20b0:36c:dbfc:ee6f with SMTP id 5a478bee46e88-370f6ec412cmr3070962eec.14.1794062067100;
        Sat, 07 Nov 2026 06:34:27 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:34:26 -0800 (PST)
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
Subject: [PATCH v20 00/12] ALSA: virtio: fix capture accounting
Date: Sat,  7 Nov 2026 23:34:10 +0900
Message-ID: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
a4311e9447bbb219044db38897f95be112f46a8a. It covers PCM stop-threshold
sampling, locked partial-progress reporting, the optional reset operation,
VirtIO ACK error propagation and recovery, PCM and control DMA ownership,
signal-safe teardown, staged capture lifecycle and work prioritization, and
capture parameter documentation.

Relative to v19, patch 6 moves the virtqueue initialization summary into the
commit body and removes the unsupported event-message ownership claim. Its
source diff is unchanged. Patch 7 also rejects ordinary indirect capture
appl_ptr advances that are not aligned to runtime->min_align before converting
the frame delta to bytes.

Validation:

- The final ARM64 W=1 build uses KASAN, PROVE_LOCKING, and LOCKDEP. The
  cumulative stage build checks patches 7–12 incrementally.
- A synthetic exact-validator case rejects an odd frame delta for 4-bit
  samples before indirect accounting changes. An aligned sub-byte delta and a
  byte-aligned frame delta pass. QEMU does not advertise IMA_ADPCM, so the
  sub-byte case uses synthetic runtime geometry rather than a real stream.
- An actual S16_LE capture accepts two half-period ACKs for one completed
  period and then recovers a full-period read.
- Ordinary and staged capture passed RW and MMAP reset/reopen runs. The
  14-segment oracle matched the QEMU sample sequence.
- Inherited v19 raw SYNC_PTR and paused-lifecycle evidence covers the existing
  accounting state machine. The transport timeout and PCI evidence covers
  unchanged control and teardown paths; these references are listed in the
  manifest.

No physical-device validation or KCSAN run was performed.

Previous version:
https://lore.kernel.org/r/20261106161838.94308-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation, and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

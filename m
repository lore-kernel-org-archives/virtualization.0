Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466176;
	b=xjih28L8bBRuYP0I6Jc+qFo6Joae+dWtK8OV35vO7AJ90cthghZ3AOppjqvVJXLbTFWX
	 +dWcyV9cWvpMDFw6Gf8e+D1aoCgfe6THeUaFZitPe0o4D3A/olK5zAtft+fssruXEMArn
	 U15s7q5DS5mbmsrxjT4m0VcZp7K1/ixkyuLWp9ddUbQkbWbYp2DYSqXUM7MGOnnaGr2pz
	 XlmWm6iYjFZSYkCf0ic3pjTXqTo5orFCAm0SNqqMHOkW6nFKhVHxXR6y1mNat+VBckitc
	 OfzugpY6LUVLn+cTSsObvwT4NipyB1fMAIT2gYyyNW0o7Bl2h6oIBnYAE20aXv3PM8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CtM4Km47FwSZ7A2ZhTWLoLh7n5nVkJgAgMwOn7ZBsV0=;
	b=rLQmLyXKIILeNEQer4Hhc1jRoI035mte0JHQVWu8tL9S9bYdvEBd6msIlLhiPufHcdfp
	 nBEi2X64VapgTIRwZ6BW1542+WT3ivzx2nCyphOuMrped4rmE2tAijxU2CCBxhTiNgCud
	 baoSa37IdqyxyDR7QrcyDxYO3QVYdYYUlh5n6CUQK2xKb+krkw8wr3s12KOTJY1zR1IuI
	 KIeAmmMvkn9nI3ROSmWUuXFANItG/vOdslJhTz0xqBxuSAkkfM1vMXnsD1mxNZjmFE669
	 FOujv/WYFTgKKoQLf1JsdX1J+cG1rxV+MxSJwP/2r41UuecP5VIVp3f/WMTFs0W1Org==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsOhkZ7A;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759B606A32A
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4759B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hsOhkZ7A
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b271e573adso1535952b3a.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466175; x=1795070975; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtM4Km47FwSZ7A2ZhTWLoLh7n5nVkJgAgMwOn7ZBsV0=;
        b=hsOhkZ7AWbTIHWE8/oa6JkrM/IuYSLoP54cIy3DoZNcBkTdydaoes56SKUgsGzY0Fx
         XMg3UGFkQl0Gr6Uz0HPBV3rAVSFK0WVOk1Ww1XPYy40L8j3UCQKgdrJf+xK5k6uagIvm
         hZLzH5n6mLtqJGv47nrdUz93SzPNEJsdyVEuFsuGOBTdrEZ4x6h9LcqkJbD2WckjagFs
         8iYQc+OE3aVrjwF7Nbyf41aqpOFfB4ggq1fq+MQ45MitHHqVxxXdMILXlcqRcd1UNi/s
         mnANLGKjDqvv1lvqOJZ8OyTfqXWAN/nEdmY/r4sYnfUDVAtMMPj1OKAb4yI8HaEUjldX
         Af+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466175; x=1795070975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtM4Km47FwSZ7A2ZhTWLoLh7n5nVkJgAgMwOn7ZBsV0=;
        b=Hkuk/EZjyXHbsjQhHkSDAi0YZYn6QkvcheY0CIqRkzplMnrgefyftjUiNgN/BSPHR7
         KBcQqLxgA0Km6fBBY5uhclXzdApaOfsgYD2QBwX12edIBRIKadfkkCORUS/ZVd0Yf+/X
         EPlfVK0Mc9YloFVZZAo7cv8cc76qrbkSE8kwwtTDAwLxvTKLPmqGIkcRU0EsZ8SNkiEk
         fPGqBMXIfoUxzAafWKMazi0131d2kPcci6H3Oas7cbvY91NfkB3NKkL5BaxqNt7QiRTQ
         zoX1OLdqw1zk9PtHW+9H4ILqmUuk3EpxyUTZ0tu9RoIYXlLrHu3f2Vcr1+7F92Q3m29c
         94+g==
X-Forwarded-Encrypted: i=1; AL+hErHDbvXPsHX4dtZUgsw61B+DWrX8lz9BiDHiZ+KS6/oI5zCT3jqaYpsfqmol544ZA6tJ/SytS9loRRBA+H48gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9YnJuv9HJlD+aWnSkLawmnDjgs8NidLrAvsgCj+QxD4s2BLWj9
	2oB3iMrXya2aG4ZItr3VL/PRxckQ/8IStt3jMOP1NzrUJxVjQT0XXxvA
X-Gm-Gg: AYBFou0jdI5bPVU6PkccmY/nltTkzppYnJ1+Jmelil1dnRYBva9GYkiAUCV/kBA2roT
	ewml4CJv0mXpSjqCiSAYry5jnwL2HORSwYymsJnH6cTDATTutbITG98uoeE6wwe0D/tasrL7Gra
	y0pKGkWzOQEtIet94w47iPT5jSYuK09iMWO4Kw2WFDHlO77et42naPLezq6F8LSmHDmgeo/Beah
	sR1PJdaTvVbn3iCJwbVn5H7PU/C7C2QD6/oT/77W8Kh5DhfN/ozZ+J8m9LVLgO/3DG27zQvpI7g
	3clcjnqdrtDwz6kGQAlLv0gtywcIYHMJg2B3feL0nfJoWKGpk69/grWLVBINeT9VWKUXYRTfwHm
	9bk+3crsKzA9zJVjv1G3UfzHClexf/fdJDAWS6vuEB982BdY8MNiP3IoBXYt+RogULfcmQoM+52
	Cgd4YxYss99xgIj0K20qeu+HOMg0xG5jmEfEsBJ/So7HdgTGV9LejdQ02lVJv4sYDooyb5ULcQX
	P1qEs9NBQQfi+sR5hQrJZss+ocnixp93UPqIAJNpo9zuEgkf6aCDpiJWoYXXCrNlhXKqz8dWCZm
	QW226ox+I0Y/YM/tKjJrcHI55GUByk8D5gYtdlMXexpFmyzwPud0i8sSe7CyI8y/TnU8lWTcz0f
	SvJ9revpkeaLZa2uh/jbTP+VbDFCKdzk4AXELUrLsKi86DMVi2zXiVSUMajEUOnazZGRW
X-Received: by 2002:a05:6a00:1786:b0:8b6:4eec:f50d with SMTP id d2e1a72fcca58-8bc1c49c6camr4569616b3a.12.1794466175471;
        Wed, 11 Nov 2026 22:49:35 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:34 -0800 (PST)
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
Subject: [PATCH v31 00/17] ALSA: virtio: preserve PCM progress
Date: Thu, 12 Nov 2026 15:49:12 +0900
Message-ID: <20261112064929.11211-1-mynameisjune111@gmail.com>
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

This resends v30 in full. Gmail rejected patch 4 after SMTP accepted it,
leaving the v30 series incomplete on the mailing list. This version has
no code or patch-description changes and retains the existing human DCO
trailers.

Previous version:

https://lore.kernel.org/linux-sound/20261112062446.159-1-mynameisjune111@gmail.com/T/

This v30 revision resends v29 with no code changes. Patch 17 clarifies
the commit description and moves qualification limits to this cover
letter, following the review. The other patch messages and code are
unchanged.

Previous version:

https://lore.kernel.org/linux-sound/20261112053446.73504-1-mynameisjune111@gmail.com/T/

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

Playback validation limits: The one-period reduction in the TX queue
has not been qualified for worst-case scheduling tolerance. The tree
through the preceding playback-completion change was inspected but not
run separately. The playback gate tests used ARM64 QEMU; they did not
include KCSAN or physical audio. They do not qualify the full series.

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

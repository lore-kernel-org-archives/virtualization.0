Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464693;
	b=jKFtRX95XGVyho5k9dE9P0KMciAhPb+IDTFz/KyXh9mRzssFvS/ChKtiOuG/7GqY3IV3
	 Zs4LQ0ueJzIgAf5R4eeRQROQ9jvY1+mypF/iNp0teNY0ScqtqZbovaExpERRf2z6gslDN
	 Pb4Y87ah3SYQjd0tOrfYr5IxZgpELJgpHjusM+arnYQq1CxVTXBc4MVAGW4wRIxgwqUz4
	 PHhSkBIyjlS4lgfNQLMcf+sDwvD9jQLbjYhDjORw3CS/EyhOiZ8VADhn/P6AvHshNz6SM
	 6C3THgmEuJ4CgNZvjuehM2MWZeAJ0cIYrREG6Ae+inl7HLNu3iw7midgEidwNQStl4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q37qpXEwMyyzIQB5U811Z5lpryLHK/HfdcL3ssQu8Qo=;
	b=ZdySOSQ6GVQugq5p7dYlLgNWOMjbNVKD8a1/rZHRw49A30Z+WgZxE9yS7zeBbxTmqMHz
	 VqLcNIFBtj/1tKhbwimq8A+wDlJF/VxdY3VhdiECec8WXPPPjZvdJXSEtLopEKbrioGGv
	 k2UpON83VV80IhFzTNhjFAtQlX36GY3RTLODccxbS9kzQS4bczviRC+ftO3HMfFPih/77
	 2uKpHQUSlIEzUgiPk0zqvHE3Vt7BgCaWSxCE6kFmqIt9JSs14I5FtkxmtjszfVVB9Mb7f
	 LftOwoxygnBSEkdM+bUV6SHMX8d+7vskqi/UkPeNIL6jy1jIwRvXEEuV03N50AD9dtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sI5ZIINk;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E996606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E996606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sI5ZIINk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb18f4da15so14979205ad.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464692; x=1795069492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q37qpXEwMyyzIQB5U811Z5lpryLHK/HfdcL3ssQu8Qo=;
        b=sI5ZIINkMXHhpmBuuX8m2Nz9gqiHA+BYcx9sEsQ4IBUHMXkYkzplgsc+1s9jeFaqah
         DqygRRToajMr7FWDF4lgXijcggvLzmY9vNd4oO4NUu+JxEXme9Y2fnwEqXKesly2WPFL
         S7Ed4tYHt1tw0vegT2DdG58QIChLNKau20PXtGnGO40thCXsq7nIBOtO6y56lsG3GPZP
         SRi/lQI6Hgn9of+zttNd52IrSr3KEG/N0+3rc7VleR35PkYoIaxnEwNF4trMjX5PYjgl
         nPjKmyRyZYBm1eCAtjiFX3LLYQfcHqvEGPwZOu/18m02XL+QHoOVyZE26lqNhBPGFR24
         ICew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464692; x=1795069492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q37qpXEwMyyzIQB5U811Z5lpryLHK/HfdcL3ssQu8Qo=;
        b=lKFNpjwvvJWE/EoqS7yDItCjuce/1LJ1IZO3MikFYyrHHKtDutWVOOx2tjXIBMze4P
         GhVDPKUkdJqjEq2Sz7METevTFa02rxge3E/vKH7kql47fVX6nfrUaEwbZXJdmBRAxtUx
         5rqUd8/D4hMkX3kDWtFQufUTbdA/6/i0DcwfmTE79WMUOmyk33lkRoh0GssTQA54d3Uj
         pSFbVYCt0EWpRIvpIOdEJY7is2Wx1uz0VGtbhzYWnn1kYcJCewo845mY72gdy53t2D0W
         rCy9SZGn2ZJmoyM+d+RJXdghE100WNpCCF0dbn+xsRHmDeRsHDsZt+dWlX5j3eib0MNW
         wS5A==
X-Forwarded-Encrypted: i=1; AL+hErE8GfasTiHkIFa7hpZ9u1kEfOixYtRfnFTSh4jXDUeza7fUVmoSuCzhI1KqMXn0gGTSu6vGQP858onFgRo48w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5nSdNAvMBWBofyN3873KJ26H380MbYmI1xZwq8e/HpVz3i8wt
	HuY0BxjXGFJ3nEpw9axlft/dS5nCCHoTrQK4A7FlP+M8JgiLhbD6xmbr
X-Gm-Gg: AYBFou0leVtTFQHNeZCX0gjd0wd2SJ7huE3iMoweBIKc/HQTT4z1gKEawb5yOqh+EKS
	sq8JKG+0pAef6gLmDyJw5MGOuguykC8PT8E+dVPAis0UFAhrMMqCiQmHbJjUcM+Hh6sE7Vytf8i
	NvLIbhZ8dnic4udK13lpdIuSeW65qI3qCAgoe7q6WcrD26bBKCio06yrMXsEFJDr2Zvzz9mBL87
	oAalasBzudss6bl7NI28P35QkmXo8djKMzNCQp8KkF2uGNpuE84CNYQoMFqEKyTJFmU1y31T9J0
	2ypyqxmz8gEDSJup/bMvrIK6+oHsHiV0INpCXd2KzlFPQcdZPo2l/t96GbzKv9osgtnjhBXfbPr
	VxownTPD2GTgWZHH9IVk/n89LW+yj2dJ04ZM60CDsc+sD3YFgJfCMsmhUbfxv2RxPtioaaqbkVF
	aekRb6Tmudv6pUijOOp5idZWawLgvorAuO0hg5rPc6UK5Re2tZYV8Zl7JoR612c9xLilqGqzego
	qL1ne3npXKtOoduNySBiXAX1brEAqzG44vvyYsbfh7e/7DhATie/NKGMPiscaO8EmbYbxZm69Bn
	1KC5fBgw0XWqYk2GJz70tHvwoRYr2WK5FesKhDoSx/qiDQAJfCFluQlcV6wiJ67Ck/4a1kp+nMK
	tM6i6rsn5NQ96PRaWabisb+3eyoljnjoujwURSTXS82lMi6Y=
X-Received: by 2002:a17:903:1a26:b0:2e9:4e83:1969 with SMTP id d9443c01a7336-2edd7b394cbmr42229315ad.34.1794464692369;
        Wed, 11 Nov 2026 22:24:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.24.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:24:51 -0800 (PST)
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
Subject: [PATCH v30 00/17] ALSA: virtio: preserve PCM progress
Date: Thu, 12 Nov 2026 15:24:29 +0900
Message-ID: <20261112062446.159-1-mynameisjune111@gmail.com>
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

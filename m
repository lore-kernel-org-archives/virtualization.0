Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758673;
	b=AisloabdIU8BdK4gcigvoOjJe6S1CydgJCDmeDtqZBw4JjD5v2tt85QMlp+piyeTLGyq
	 T7LlV993NZLOFQBPmLFCCBK2ilSealQCxzoXPaGUtLBicq4l5XOaXGs52acSINv9Wf4XM
	 hToqL84GAz1xO/xnaGJUQBSflwSLOZvTN8msVt6MKnH+A/kUv7lOA/HAYmTGmJIJr+vEc
	 4HXbFs/+MtKQPG2Aqdk492sm5R84UbnUK0Bkk3E/8LYwnTBdmjQxxRQu72AT/SAYtk9IQ
	 TxS6pAJShmYCwJIKblwj2KnicbekJZc7xAlwsblw2L7rH8ob3BpHTHluNs63JJN1ceQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BSQ05M0oQxNJQnOx02JpbWwvcminebtNWNNkIq7Oztg=;
	b=HzLGS8+OqPCDd2PfwYvZmIN2WQLEiNjbUnerkI7NfY2YnfsKD4IQxxG0U0akDqo+cYiR
	 qaRFjYNyJdmsfjotetxzYkbgwpJEFwTGahjl+Ng7URphJ2nQMAr7xjIsMDmIszJww9OVV
	 n49QYPaUTO0NTmMfnUeQkVXbcVgYuTeztcLzHHzgrJcPZREanzODpeA1NN7cJUjPcZ38F
	 avoEtmbahBaQ552TkUhaYuzhlJsToVSfSvPyVxGKoT+uJmC8FX5WNBKOpUT2dj6C/4ViA
	 cCenLCw3Be7zUvkZlHhqN1yk2tneS74ALpAv3UMHXzjLKquMO8Ehh2YS4odFKwW8uAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbCCYz6G;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3728606A329
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3728606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jbCCYz6G
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a070755c8cso135828b3a.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758672; x=1794363472; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSQ05M0oQxNJQnOx02JpbWwvcminebtNWNNkIq7Oztg=;
        b=jbCCYz6GqSJT+6jZNWaKVcRsSZvs/zcFAvNb8IncvgbvbIr+HPtcxKuP8QPHN0R7sl
         vwPXora9FySiAKEI85UXW3O0Gf31NLYpilmYKk2PYoe7Vb0dtnjXrb+bHwGdYOyz5zLJ
         qUQhQ9/bL1x4Wp4PnTLGurx86aDwywzzc4FBNBO0SzK6R4hs19mKCvNB4v+PsJNiv0f6
         5iQiiqBzRPlvgLVeKaYuu/g0hdqFT4NzXDfmFvCzy5cLj9sc1Cy8nbD9oUKTrbuP0xzS
         lgvsdAeKyiWfbYeBa4Xy5Ydc4pBJ3gQqKP2RckVkrB+RxBIvJzoYaWZHt6IgOdg3Et11
         Dozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758672; x=1794363472;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSQ05M0oQxNJQnOx02JpbWwvcminebtNWNNkIq7Oztg=;
        b=vOpI44qXlrvtjLf7+Ot+VlnOIy6Qv3uFvI4wm32I+qcJhRLFYuJzRDB7aVAQen/rAS
         LgavrhUfApw9evkvuYt4PCVXVJ74i7j6pHPJDnC2WX2AuA2PLAaxSgeTmAxrXa/pZ9wK
         Bqi6HClwUl2MGyOLD50LfRrvA8tklfmyhMj1MOK2BUHwnaAL0WceJHzIqq6nCRhTuF+/
         Y4eYCiQeqnqJ4+HOimLytQ5iet1BOIm8U7+fx45ssMd3hyT0Q/VVWUm32UAUznsQSH8F
         fs+z6VlWqW2A2FiP5XLJ7IdJvVKdzVqL0loFczlQ5juAeUdJdZMzazu7GixuTH6vo7gf
         0+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxeZy2iY1OHXrmQm4omn2Et9AvH4GZs2d1gEVo5Y0MPmPtbSg2JzXsXsvDmiE5iTFy4USX1FczeY+dEFSPF6g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8HIVml5oOtDC1tYkOYG7YkYSr8qwozkJ89Gz4ehP/Dec5fZU0b
	CNq4Hraz/Mbw+zPyZpIWUBySiMBCAYej+AhibKZR1w+QFIZxz2TxzOEE
X-Gm-Gg: AYBFou1x56KJFuAQo4t66LrSJzSC2CgHXBqS2Wfxk3bwqOFYNemDnbXjRaL07+xX22h
	AzTceLijx8OesHJh7yYRCJguVHUN0g7Fu/9bDSa+YvjmWsH/wAYmR4g5Cxsg8ICuusKtV1kUtHd
	jtZBKhHZRF7TyyA1iiQncRIpYIyVrjZZ3D/CcRQ/a2VGWbN6TegvJT5mLGMnUUWoabNzaONTW9X
	JeDm5ZeVgEzz+2u5ml80SRP1lwujPCLYrPDWapDzkLf61WFgxR71qiPDcdlePbIC0VLYyV3qdJK
	BhzSqIzOuQfcw33qj+nOErK3nz+JsWxnsCW9OocQaUAyztym6nS9y4D6B/sggOU10VT79BdojOO
	sPBLYx58qjTiXkRuButeOIAPdDBSodoPt8inLjDvrAxjcbDYZ3gwmYqranq7l1lKovGpqADForg
	dkVWt7mbl7ka8vth4Rlr/6AgTqwc5ox68/A6bF+vbjamp1cYryq2oyaZv2wBEMJrYkHY5UmiCH2
	rk1Pfe/Ib/T+ZyKnTAv8bbm9kRwlKCCr6NDMl78PoMxZJ34qk3LO+q+3AJM7pFK/X3m66wwfYzf
	tZZ4dz4KkVSsvKKlPjzmGzNLAnjbO7CDcAoMdfRSt7ZFbzbzXDSJmS5PXlqU/CBjf/uVsHQohwd
	fpM1ZDJxRRf6887lsuRh1EITJw+cM060lFyXL5AEK5aepejWkQlnwSLF+sAzQ9QMbqwTpGQ==
X-Received: by 2002:a05:6a21:4903:b0:3e2:8fdc:a6c4 with SMTP id adf61e73a8af0-3e928d14803mr13026535637.31.1793758672044;
        Tue, 03 Nov 2026 18:17:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:17:50 -0800 (PST)
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
Subject: [PATCH v14 00/12] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Wed,  4 Nov 2026 11:17:33 +0900
Message-ID: <20261104021745.57733-1-mynameisjune111@gmail.com>
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

This v14 series replaces v13 and applies as twelve patches to sound.git
for-next at a4311e9447bbb219044db38897f95be112f46a8a. The patch order places
the ALSA PCM synchronization prerequisites before the virtio ACK and teardown
changes, so the driver can keep ACK admission closed while the core resets
the PCM pointer. Targeting 7.5 or later works for me; I have no urgent
deadline.

The changes address the 16 raw Sashiko findings from v13; several findings
share a fix and its validation. They close ACK admission before teardown
waits while keeping prepared runtime storage valid until device-owned capture
requests drain. They prevent event delivery before ALSA objects are ready,
preserve XRUN state through recovery, and keep capture accounting consistent
across RESET, short RX completion, sub-byte ACKs and NOMMU post-STOP copies.
Failed-probe cleanup reclaims event buffers without dispatching them into
uninitialized ALSA state.

Playback RESET returns -EBUSY while TX requests remain device-owned and leaves
the pointers unchanged. DROP/PREPARE retires that generation before retrying.
Linked PCM RESET retains its first-error and partial-completion behavior.

Validation includes 21 selected QEMU runs with expected fixture exit codes,
module hashes, unchanged inputs, VM cleanup and decoded kernel diagnostics
checked. The callback boundary suite passed 24 cases; ACK/START failure to
DROP recovery passed 18 cases; the forced ACK/teardown race passed 12 cases
under KASAN/lockdep and 12 under KCSAN_STRICT. Fourteen ordinary and staged
capture segments, totaling 14,208,000 frames, matched the independent sample
oracle.

Separately, all twelve ordered v14 stages built, with the recorded source
hashes matching each stage. Four targeted intermediate-stage QEMU runs matched
their expected exits, module hashes, unchanged-input checks, VM cleanup and
quiet decoded KASAN/lockdep logs. The linked-peer checks accepted baseline ACK
3/3 and rejected candidate ACK with -EBADFD 3/3; three control cases per
version and six candidate recovery cases passed. The stage-6 event probe
dispatched one enabled event, blocked pre-init dispatch and passed rebind I/O.
The stage-7 short-RX case published zero progress, latched XRUN and reopened
for 96,000 bytes. Capture-stage host checks passed 15 assertions across
stages 7–9, including the teardown gate's prepared-state lifetime.

Two physical VZ runs used a Samson Go Mic at 48 kHz mono. Each run included a
70-second capture, three five-second reopen captures, RUNNING and PAUSED
RESET, and normal shutdown. All recordings had nonzero input and zero XRUN
errors. These VZ runs used the experimental capture compatibility flags.

The NOMMU post-STOP path passed 22 assertions in an extracted-function host
shim; no CONFIG_MMU=n kernel or device run was performed. Event admission used
synthetic events; physical system suspend was not exercised.
Docker Desktop, other input devices, and broad load or format coverage remain
outside these results.

LLM assistance was used for review analysis, implementation, fixtures and
this explanation. The patches carry Assisted-by: LLM.

Previous series:
https://lore.kernel.org/linux-sound/20261103080821.16983-1-mynameisjune111@gmail.com/T/

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

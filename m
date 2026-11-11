Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365823;
	b=uYu2heB99J3DcmOf/dIZRi1pt5da7ObWSkibqJR2IVomorkwd8j9rcQHdOQcfv7qOFOr
	 89p1k357XWN0CqIezKVlfaITITlSHDJrnUXMSdXrRRHnUeFyCoruDyhIGfqOdgZsnJ/cM
	 2A0QoEqn5JouoaMSCdXgS7HlRuoZBzUK+SRy2GXfMVZb+mKnJd/qhbcMB8+5TF2KRensU
	 ae9xiiiNSUG5RC8m1xStGYMEE0ToeFaIsnQxG33Voipoc8ZJoDq8z4nfVr14vf/8ZQzAQ
	 rZfLdw7SCSHvy+YsnXwD6qgciFrJhMRGbCEpCMlJslGZ23lhyiCoOpfsZphVNHAY+mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qp80d0Wb9ndtvBEt6iVPc1UqtP2sqVWAkNfJ3zdnMcI=;
	b=w4iFBZ8vZvUMxgwOsf6gdFJqx/MmyHE44VLhckGAnYwc3R/VCRPsIZXQBU51WPMnP0NO
	 afnKmB24AtUGJ1DutS97Yn7Z7X6SqLbFw0CqVl1KM+ZTcKXMRbnypp324Zd+y8X5benKl
	 bB2NlQP4N/G23rqPToO36hsThHG+hr2lxcedaKyPjCalglaqe+SRcVPz2VbAC3EA+1dU5
	 6EEG9EMLi/SL9V5ZPORNwazi2jEavbnAaAsY/3PX975+6s7OHBhY+8112ZMsSl1zyIb3T
	 2zJiEkbMqpIep6SOBt3dVCJONgEnLPRY7DVfnxE+YN6asU9eVLvXEY4zyp8eb7ygGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRMePCTf;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC2606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8AC2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRMePCTf
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3712b6d9843so2587944eec.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365822; x=1794970622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qp80d0Wb9ndtvBEt6iVPc1UqtP2sqVWAkNfJ3zdnMcI=;
        b=bRMePCTfhS8R4r2JtDr8JkcyBTAJofLcrhz54/MJcJ5sGTtCpW8tETtsldSb1w3PI0
         7fyxecF5hy4SVcKlz1HSbSVJ1EeStC6zdN4eC3vIG/VhXA+UcrsClXFXHIGV6NFh5C2q
         XCI4x4tbJL68K3JdYZUnCwmzDIHapwoFhTeCtdnZsJxp77aFQYyov/qirmjT8AR9IJjK
         mUtwU8XuOXksPJo4XzuvAm/YSy9Sb/8i2hlocNx4RurMA1WJ0+eUCLhPbKWUa/YZOERq
         phkYe4J/Il2/S6B4OgEU0fqrdpBQMcNjmeaO0vUcSAYIML1caH1Lbl9yxn+2UV63hmbk
         BVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365822; x=1794970622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qp80d0Wb9ndtvBEt6iVPc1UqtP2sqVWAkNfJ3zdnMcI=;
        b=RZS/yWHDaa2OgQx9eoiVbu9wu/nKMMlxQCXXS8ZSY8j3+HWNDBOn56fpdX1G/PZR+y
         oTgSZyYe1TO7Lr63OmJ9ZTnEZuXHQ/YJ4No7AxcVXD1rTvxRmTuh0n0lGoORWJApC+YK
         dCXmNq60cfXpg5VrqC6OsxFgdfDXgJl1Z1fgCnqLjprG2gVIX9yEMH+7jyfMs4EizFs0
         qi+Txxub38PBBomD3lJZq/Pm3W6I+ubT6Kp9VjDZF0fzrl0DFWCAUnB+W+DGAPaUrrTn
         fWER1hmt76OzPeypthG5Yi9PktCyf3lXj+NxSpEsggH/kpsdjkp5DifgmAyg6NAHMPOg
         jbQg==
X-Forwarded-Encrypted: i=1; AL+hErH/l2fqxZCzBONdUyGgSFXkXt3raqXTubAqrTE2F9Rf85VG1VxRiKRAq1B2uLgaXxdM5m7N17h39qFZT1X2GA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8a3aSDEkvm62OamdsduUbyZOYRPwOV53cbQ0mqzOjJNWtjXMf4
	sHfjNp93SRpsspAq0y/JGMY6C+1HtQVpqvLoYPoQDiCmx0zUFy41RI3h
X-Gm-Gg: AYBFou2pfaC2ZGb1EwezB1YGqLmQLzmOe3TTLaIXBHzms4ZxMaRNAJMAIzNQJ5EvGPV
	OHGeUklUvcImoEGQloSbg/un5XsfBRziNWphTfde/hYEfzclLr7IqY5mAUGaWN3TZ7TpBcck37u
	W2rOMGcT3jp4q1vClWaRf96JxRUMtwL/7oCZYSTnNPhTZz5Sk6ZThNlnXun1IjKWv4I51je+wwh
	XnpXtHfpQkgKaBeQWdRXuEyWbwDVZTQs7Yu9Fotzf+LxyvX6ExodRK6NEawxnGOqVuARCmDvUre
	A4YZinjATNn9A7CDpooZ16Ttz0964WIINh6buXd+oRdiWwUAQ4XlawKJ+iRYbt9MF5LXa3P230D
	Cx/wDervZtSbqYqpfyLU6l26hlc8y2AhKcv1r7u3cTJKUE6UClAZdmARCA8z3mn7KKsGRO5XIOz
	nOCIEcLFG5ig0taAjhwmmfXCIFWIYQ261G2cKh7uj5kNFh7O6P9XNr/llBR/mBTxkpCM+qG3EfB
	FndPVsPzwnVelwepLhVFkx/LrpNzDmY/Z/o208mAbr0/6dLTOa/CqkhhFHd1qX7i6yiGz0KrxWg
	3dnXRVc2Mw43X6TXdtHpnijEmHutZXs17NiviNgUWE5zqPVzEQadTDc6GFoYLQHCyMnCPh4Gdjq
	uob1YCxRrB1/DrjUMWulU7RMVIryq+tkeL39UBLpvAGW4qD8B3mD3LkaTNAB0rVKFDEikhQ==
X-Received: by 2002:a05:693c:808b:b0:36c:a390:8907 with SMTP id 5a478bee46e88-3768646897amr1766149eec.21.1794365821641;
        Tue, 10 Nov 2026 18:57:01 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.56.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:01 -0800 (PST)
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
Subject: [PATCH v25 00/16] ALSA: virtio: serialize PCM recovery and preserve capture and playback progress
Date: Wed, 11 Nov 2026 11:56:39 +0900
Message-ID: <20261111025655.63951-1-mynameisjune111@gmail.com>
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

This series updates ALSA PCM recovery and virtio-snd request ownership.
Capture receives into request-owned buffers so valid short completions
can be appended to the ALSA ring without leaving a gap.

This replaces v24 in full. Apply all sixteen patches to the base commit
below. The previous version is at:

https://lore.kernel.org/linux-sound/20261111000543.28550-1-mynameisjune111@gmail.com/T/

Changes since v24:

Capture DRAINING keeps a full buffer readable and reports progress
beyond capacity as XRUN. The read loop refreshes availability after an
unlocked copy so a tail published during that copy is included before
EOF. Playback drain completion is unchanged.

ACK checks the core buffer-access gate before entering the transfer
path. The existing PCM lock barriers in prepare, RESET, hw_params and
hw_free wait for ACKs already admitted before the gate closes. Internal
RESET pointer observation retains its separate bypass.

Playback period work checks for new progress or a latched error under
the PCM stream lock. This prevents work queued before a paused RESET
from publishing a duplicate period after resume. Prepare and RESET clear
both the cached device latency and runtime delay.

The capture allocation and copy description now lives in the ALSA
configuration guide. On MMU systems, per-period page rounding can make
additional memory exceed the ALSA ring size; the request buffers remain
allocated from hw_params until hw_free. Pause documentation now
describes STOP/RELEASE followed by PREPARE/START. The ACK
error-propagation and teardown wait patches carry Fixes tags. Patch
descriptions state their changes against the pinned base.

Validation:

The pinned v24 baseline was rebuilt with the saved KASAN and lockdep
configuration and the same builder. Fresh cumulative W=1 builds cover
stages 2, 12 and 16. Each passed with no new warning lines in the
changed audio builds. The full baseline build retains 517 warnings in
unchanged ARM64 files; other intermediate stages were not rebuilt.

Matched synthetic ALSA PCM tests compared baseline and integrated
candidate. The candidate preserved and read all 8192 frames in a full
capture buffer, returned EOF on the next read, reported 8193 unread
frames as XRUN, and returned both a 1024-frame prefix and the 512-frame
tail published during an unlocked read before reaching EOF. Playback
drain still completes. These fixtures exercise PCM core behavior, not
virtio transport or physical device DMA.

ACK probes on baseline, isolated candidate and integrated candidate
verified the baseline admitted a gated ACK and queued TX; both
candidates rejected ACK with -EBADFD and queued no TX. All three also
verified completion of a pre-gate ACK before linked prepare crossed its
lock barrier, and the internal RESET bypass. The integrated playback
probes verified stale work across PAUSED RESET/resume and clearing of a
synthetic 256-frame device delay after RESET and PREPARE. Clean
integrated RW and MMAP capture runs each lasted 70 seconds; all seven
segments totaling 7,104,000 frames matched the unchanged independent
oracle. These QEMU runs reported no KASAN or lockdep diagnostics. KCSAN
was not run.

The default RX path adds request-owned memory and an IRQ-path copy.
Packed status and RELEASE/reprepare pause are opt-in and disabled by
default. CPU and worst-case IRQ lock-hold time remain unqualified. The
playback queue cap reduces buffering tolerance, especially with two
periods. This revision has no new physical VZ or KCSAN qualification.
Uncertain control timeouts can still require device reset or reprobe.
The deterministic review fixtures are local and have not been published.

base-commit: a4311e9447bbb219044db38897f95be112f46a8a

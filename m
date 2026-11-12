Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458122;
	b=BBnuJMl9z9FEHCORPAF7xDUky7ecDBDsRqlmfSQ1tTb4LkYPBdY2CBzbE4IuZ/PRvfgi
	 RTl+WXbycJ5/bqy/IieBBh/lppRfjGBrp+gkZLQKI7yU/lNPSsm7+T4a171GU5jYM4+6N
	 7rbjI210r9y2iNP/UCwNnxaWN/FEnrlP5NwWSSKVzI+MkrcHFYBiI7eDI5dZgnlpdTA2F
	 FSeEYF8MxMeVySvdMRlWOzKJT4oReJLzO3GbFWwCijavGfmGl+DT6qGGI6nKYuE02fgyB
	 yeVXIeWKBhqgCZqe3v4x8Ypa14Xtl//wTWNZz7+QRLIaSqZyh+woUJ/9vp066TatC1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8sGdYFLdFjnn1Tz0kkUDzZd2/WGgELAl+I1C7alcxus=;
	b=Xky/2xFz51OFaHvVY2eL6gVoT7e3nJz98+/IhOC8+eIiPoRTTGbN8HOPx0RRLvvk/Sbr
	 pb+hzf3d1fBG2BHa9PnA1rCKEbk7vtgN82IjjBl/Lj3VZeOxrrIJraXV+xaBwzwvncedP
	 Sq7CaP0u7lpstKD7QuZkteZ4004ggFhEsjlMki1PoUGZott/zN9/ukJfPJ0y3mzmbxQO/
	 6992zQKKW916fPJWojqYoIPjKGAQkktXUJHyLD5s3RkiGMu6mYSNmly5TWHDuwG5pdneH
	 fopUGw8pSv2K75U7YMw7qC3t7UO5T7aaAqLk0+YndGa+6S0BOOCtzKUZuzB9aI62WIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOwJUdiG;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B09606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B09606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOwJUdiG
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso2856545a91.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458122; x=1795062922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sGdYFLdFjnn1Tz0kkUDzZd2/WGgELAl+I1C7alcxus=;
        b=BOwJUdiGC6+JG6NLl2/p/INar50kAaQt3mligEE9AeGF/N0dQ3eCOgSr+0PV8NJWM0
         RSci0dCH+2iq/kEdXS4J5mWnun0I/1NE+PQcMlXWkfYNa/nifjDv7INQKbTZ1XP5lPGS
         BN1G3zeRRFy9ubnuMJ2fOhHsfnzMmOOdyEsufONvFj1HuGf1J7m4i4gGGhkm/ZZ0B1oO
         AAA+ly+Zp44KgQXBha6eeQHYWNusQuhouXE5YB8zohGN/X3x+m6yi6ZJgwf1oOxVDDec
         dk6qiac84E4z7vCt51enCLMx3MIK8KgsdL1vwfKdI5APS4AB9pp338jZYDqSkz+Ece35
         eMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458122; x=1795062922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sGdYFLdFjnn1Tz0kkUDzZd2/WGgELAl+I1C7alcxus=;
        b=adf7YqNZC7iZL2o6t09ua0WpUWcveW4xRwuyAy2cxGZt480YUtiHpHJGU0uRssTzjj
         DZNqGGeraiOEB+GR3UdOoBcskXQQZ7AF4PaHn4DZlJWyJyH+lk+RCqvJbsS3U4TFkYJo
         BUy0yWwb0uclEHW+m8MgwR+tePdGighKJcwQ8vkqSZWWNBnSB4lhLvfPXXxNqCPIAguR
         qWkdItNPZFjzt28wSIiQJLtec1mVzFLld2u2YyuKJUsbQBo/EeKHXRj71ru6NBD+F1E9
         EDd13MDXgnig+tirj1y2ciou4o9JMrFvXwm8TD0lAdmOY6cE0xpXSMgPR3knkRfcjRYA
         8o1g==
X-Forwarded-Encrypted: i=1; AL+hErGjUhaoBRrlo27iimlgbZ6Dcc47dAi7ROu4sw/v9UwKaXT5smjcUBnAKLf6GGxCUdArHp5yCpxtm0w+enen9w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8a4wtz3qaGPO5bOFCnlN1YVtMiJjjeuzdf+/XJSNqRlvPN2Kc2
	DimT+tzTxMvfwzT5sRr8YBoa4oaTlxwPKSELJMCA+V0AwJShyBI2pQzN
X-Gm-Gg: AYBFou1X+BOwJGAsVffBDy8LKL7FPNz7Y5jH9xlg2vmmnk0x2/mQI7X70TogaaUXNEJ
	3AZangpDzadQrKlwXCrrjvHZU9YRcwJk2La3fS4REnaEzEJ/26/2AMNPXtVCyERT9b9a7T13F/l
	ZJZBNWBqQJe8I0UsHKAQce/o2frJWj9MYZT8eAuKekuJ1lBcPZGufM8Q9TAZR9tS8rscUYlkuLa
	BOIhUT7nA+pl6rG/+tEjTjVWIMLoUyayyQK7fHaKWrhK9JqyElrOr3kU5gwhlUWF1iRjA8FET0c
	TOZUQI63VuTpz8NtXam7eflZv1JYySyOK5+RCSZr2doy0JuOiWx0M3SPld+ut99QuZwFS8Joral
	XU7emcgM+3tI8rndSeI6Bl2llwYDreHlTQMdaqPBrfdzrfRXj+L7v3e9xumTJKpukyuf2KaiBKg
	ulD3T4/VMI4xJYNpDKWmvxwjsCE8LPmCOzTmTkZ0lPGvyEtCDU1jAJyokkseKdfHAthB7fJ5nK2
	P+s/OB8Lj2udla/7MlbViQKzGxVgGS2RqELx3arwV11bnV5WEDMj1G52dhrw6n9HJe3czQl364l
	tzJnZBKeVazAHJCFyBLySAvY2W/j2ueFnyXi8F4dhzDvhwQKEwKYqXjjSaso1CtQra4U0bqxpzh
	VUrLsLP+Nyhm386voFJ2adK0oTAwPJ1UplKGWUidjL2oMXaE=
X-Received: by 2002:a17:90b:510a:b0:3b0:9cc6:62bc with SMTP id 98e67ed59e1d1-3b182efaa1emr4409006a91.37.1794458121795;
        Wed, 11 Nov 2026 20:35:21 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:21 -0800 (PST)
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
Subject: [PATCH v28 00/17] ALSA: virtio: preserve PCM progress
Date: Thu, 12 Nov 2026 13:34:59 +0900
Message-ID: <20261112043516.37010-1-mynameisjune111@gmail.com>
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

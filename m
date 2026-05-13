Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629E377018
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691018; cv=none; b=EysZy1qnyFBLW5HwhLP0w0ZNz99icJV3ZVWGzU7XOTW7ZktMt7iEXx5ggSIckbqotTboS7cSTMWICSGEg44t9wbcJ38Eo4vpFLO0jT7N+YZSpJ8/dspGKw/ScfKteJipo+kij6YBhegaMMwQyU3juJ41kkJMDVZVJCiR9bznaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691018; c=relaxed/simple;
	bh=J5KWjkitWaa+zQXzjM8xPWkBFBQtvwfJCJCRx/KA3es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAKd+n6nD/y/IVLjOiMgNmmdR13buKVWg55FGM0i5Jn9TC/4K6veeYmscLQAndmSq+8Z7M/2fZfzIjH86Tyy4v6RuOVdntSY7Hc4p74+aYWkQN7wCWqg7VH1j0uc7kXzofHFQh8gCkIGAcN/01jVeO/2ofK9OB2fmHqKuo2Em8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XIP40PPv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XIP40PPv"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fc496c8baso66146211cf.3
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778691009; x=1779295809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZukIZMATp2JtRDTJ//Dl/unJCRFuE8eMZ0H6/2Yk9z8=;
        b=XIP40PPvT9jo8CYA4P5SABw4diIaC1YiZpiIYN53tlOJnoHbOO5dmwQ+9usP2TbvkV
         7ffNMA/e7TiTHT6NDTFeGHKVXF/06X8ArrNG9keueYdfukxEzhmptM1I80frrfM8XSv9
         65OSGHSouPt84yzHKAbh7iOlXXxH40CyLgtGmHMMGzq5Z+sZb0de/6a/EtC1cCMs0qrY
         B1xKBBM1AOTJoS6aGvct5w6keq2c7PaONsyM9LHkGRhkFAsUGKVTeqjHAUQ6Nbuxa1wN
         1D1mOR3ZwxJpPhNvXY8h6RH7pos1TcholXwFVev2GfY+E/GE4kp1y/9DkEgOddFGxMgV
         604Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691009; x=1779295809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZukIZMATp2JtRDTJ//Dl/unJCRFuE8eMZ0H6/2Yk9z8=;
        b=VhThJ24Z9hgBiWgMPL0FO9ZgquMmjqY+GR98meFrQRTx+4Q4vf7p0H8Z0ohlq5QA8A
         kpuqgLykBTkOYojKE1BwtVgjpSLXsVG6dazsAlcKWsnGKDZ+4UgL8jvzbtFQTpuK2AKY
         o1z0mkC8D15V11KRdccuQqNsoqLLsXXbD5xxFLIQAIyOioV2copzreFbUYB59eYZrDEf
         xNuc3QuArA+h2M8F5MpuElq2d5zjrvEypfP4eHSlJBxU05KileUboNV85rVc6FHmyrA9
         YOUP6LxProQsnp4xsX/wsRNE+6PnLY5fKPi8cZ0CWj0wsKOJAaZ5Ww8V5x1HnUNoGg0c
         +dYQ==
X-Gm-Message-State: AOJu0YwB4NwsFmgareawhA4MbFKrPEJ5j29rAqXq6uJ6Sfq1fX9Av1k5
	rfho/LUX7moMLE89q8qMYVPvbVSMo5k7037hPbkSHImSr2azfgzSL23yxHiz09FGhtZUjSsfe2T
	Bz12T
X-Gm-Gg: Acq92OGwz/pfImdBt1oRECGiEY6gzskRSBfqUDy/RQlGpyYiUcEd9YYXw1kPO/u4hVT
	MPAtOYfT9I4FSIXWw91H3b1yEguSMNBR/02krzTvRgzYi6Sx7Yc/neGB8N6FmFZyFCnHg9PrQA1
	uJZYYRZ5OqMh9F8DyqODpMNZuaqtU7BtfRKeShVJ+aK8zjL+lPx7q2WpjlUimqBMNjgARwMhHC/
	0dOPVoZ/LMnsbHO0MYlYjBd7Q/Yp/d73VGcDwGPFbAgtufmpTaLCR0ctP9YCaDuhojBZRNifMzy
	zIWjmHy/LrHILEGXRB4GE4wyXweQsdicQtU1vzqW089z/+N3C5B2Rl8Bchvp+0qxTBRvWwFw/Jv
	ZxJ44+rZClhg4Iyoy7MgpaasXcbOCEHda2s2EW7uqsGwXOFzsEEmGAF3sVj4t512l3S3ScC2/R9
	shB4Fruilgj3g3wf/Mb2EVN/S9D/74eyLOq33SJ75ePyrbLYHrNfp8nIhxE3nl7Z9ho7mwiPA9v
	32gI9nHVXN4xe/IEw==
X-Received: by 2002:a05:622a:6185:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-5162f443304mr54244261cf.3.1778691009483;
        Wed, 13 May 2026 09:50:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e677e63sm152498891cf.12.2026.05.13.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:50:09 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mst@redhat.com,
	david@kernel.org,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Subject: [RFC PATCH 0/2] virtio-balloon: extended stats and push mode
Date: Wed, 13 May 2026 12:50:04 -0400
Message-ID: <20260513165006.2790857-1-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the virtio-balloon stats virtqueue with new tags
for memory composition and pressure data, and adds an optional push
mode for guest-initiated stat reporting.

Patch 1 adds 11 new stat tags to the existing stats VQ.

  These use the same tag/value format and require no feature negotiation.
  Old hosts ignore unknown tags.

  The new tags provide data needed for better balloon sizing:

  a) dirty/writeback pages (more accurate reclaimable estimates)
  b) workingset refault counters (balloon overshoot before PSI spikes)
  c) PSI pressure stats

  Also exports psi_system for module builds.

Patch 2 adds VIRTIO_BALLOON_F_STATS_PUSH.

  Stats push is a new feature that lets the host configure the guest
  to push stats on a timer. The host sets stats_push_interval_ms in
  the balloon config space; when non-zero, the guest pushes stats at
  that cadence without waiting for the host to return the buffer. 

  This serves two purposes: 
    a) latency-sensitive consumers get stats at a guaranteed cadence
    b) absence of expected stats provides guest liveness detection.

  STATS_PUSH requires STATS_VQ and suppresses the pull callback when
  active to avoid racing on buffer submission.

Gregory Price (2):
  virtio-balloon: extend stats with memory composition and pressure data
  virtio-balloon: add stats push mode

 drivers/virtio/virtio_balloon.c     | 104 ++++++++++++++++++++++++++++
 include/uapi/linux/virtio_balloon.h |  33 ++++++++-
 kernel/sched/psi.c                  |   1 +
 3 files changed, 136 insertions(+), 2 deletions(-)

-- 
2.54.0


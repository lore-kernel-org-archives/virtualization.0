Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2C33ADAD
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713085; cv=none; b=G03dsGcb0DL8dEr4jBoCDQbAhympD09RaHjdAxi2vGsn/fKJzisRmiFwZZ0+2GDY9q5P5lLUqwxTJO4iMMC+4ZDD5vgz/k3jNs33OxXzK16nLgQFhnD7rSdHeaE/EKi55PxdzOQHq0q6PJeiYeR3J7uFXeptvnE5obOeHoe3Ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713085; c=relaxed/simple;
	bh=Aesj1I0kJQZgOgIdvH5avRNPlBnXr3FQR5KqX1cV+9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h4xJ91b/Z4exTe4cUWPYMso2sIz0tHrv5RSZUYRBP9VCPF9kJqSEgdCl7ZN2nW5TUFW10gYGfcp6Rs57U+kT1PgGluWlk0xgQT/t+eeEmHJCEY5Vei2SynVqBcHJ2tvC4M8xrq4e+kmuiWP4MiG7mBqxA6GVUGQHC3dhG310CYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEZFRIJ2; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEZFRIJ2"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11b6bc976d6so2580970c88.0
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713082; x=1764317882; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZCkaU4b3LRtOfKRzVYrWDpKmG/Intyrls11rwoypKw=;
        b=YEZFRIJ2MyWeTXruAEnDjppVhIl5moI48loxqP8JC+sAErlNvU3CiOk5WegzA2vebO
         zIIcynrSB4PnO14X5zfJccVYCdzYvtWe07FVsbK50Zcmibr0kbBbZ0PETBNumBtxO+ib
         mT9+TdsnN6T7q8X1WJV4/vt5TEKDcZWDMUBKBDBL6+V/+Vwo34KmNTbTNIDgBzrJdQP6
         cPiRW4xUUycXKkOyQ4/yT+YzSd80zJb9vij6QPKBfwb/YMqcA7rsizFy7YQ1OxOJ5ba3
         A0ZdWXzlrjVseLYjqHnSU/vKvXpLSPddikkSsljuCq5kC8QbBM6W7XPbQ0y+rsZn0p9Q
         jQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713082; x=1764317882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZCkaU4b3LRtOfKRzVYrWDpKmG/Intyrls11rwoypKw=;
        b=KDXPDCYGFEghqsqWzmFH2rj6a9b4xM9a9P/AIZSH+VZtYhHxD84L1QHgsvGKVbnUhD
         ewjZqDhJ4OpOM9+8UxudWZOpFfxheDCtfsfqyX4RSFBKIF6kt1fVJkP6lpVzNdJ+db0U
         i+/zb2ZQ+4W5SgrEdtIWd/doZGkwvfnGbBC5lS0RxjpN4DiHyV4woJy0cGwmIgghUOgO
         o7DeGVUeJkAqmyZLOpysXNWdG+iZXTjS3baoxZSrPtN55GB6fAjTqHYc4S0Ls+RltSEw
         Z+KTDuDAk8mST8CLTDAqiSsL4N/hztgqAoqK8dSJnAQAlP7YpNH3bFr/RDey4RcVcWCj
         wRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU/GAnLMBBoZoBnPpqmtzGpVQY5fEhSzhO3fojFoBzSoZIruNJIfzEMyCJ8u5KerB3nBDhO/BBmmhZcbHOKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys+LIshefcrRDFnhyuB/VX7E2/q+ILGRe2ZpfetGFfXNNHrAHT
	CPqYm0njVTGkeoAM9HR1qCEOS9yTgwjrCCO/imqF7u3TasqRZUNnPFil
X-Gm-Gg: ASbGncuDRjbUmv+5hWXpURkPeqGX4wGFCmxgJE4kpZnvzgNT/ygZUZBam8KW7H9FPmI
	kpGck40ZXMUFjtr4UmqhiGNOvf5fmxFyVa7/HEyt4GLdPoGnxkGr+AQjAqvW3GlQrC4eDu3/aW4
	l41F0EBQ381maTqsXAWtMxAStyuSI49twjDuUW0GZZCeslU72ZEHuXGnn37Bq1EqftD3VcsYqhu
	GN/K7xeU9A1e+L+8mgMks5EW6Wi7cD3DqjaPF1iG8esJ6E9xePaMcsEqBk1uAn/SLHfw1tfEiVh
	/tR7qIPngZz7nnBOFZVkOJB4uU3T/frrCoEunppjFxGiGhozEHWBGyVUwpAN/bEV5zz8t5Ga34T
	1873+CA2fF/EF0tkteOqBeTHi+eY7LtY6TWks7kP6JwYx/SRGFJoO+X7iwgHoPIUjHkGd5WdnoW
	vq4GaB2hDmwiWiyEH99/I2LCm1pqV8YRCkr4Vg
X-Google-Smtp-Source: AGHT+IE6TpNLTdqJhjkLhKVLohT6o1vUjYsRLYbuQCplrHZnwWvmxZgKeOeAEDl0LIesl5PjIoxoYQ==
X-Received: by 2002:a05:7022:4591:b0:11b:9386:a383 with SMTP id a92af1059eb24-11c9cabc7b4mr475750c88.22.1763713081645;
        Fri, 21 Nov 2025 00:18:01 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:01 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
Date: Fri, 21 Nov 2025 16:17:39 +0800
Message-Id: <20251121081748.1443507-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hello everyone,

We have recently encountered a severe data loss issue on kernel version 4.19,
and we suspect the same underlying problem may exist in the latest kernel versions.

Environment:
*   **Architecture:** arm64
*   **Page Size:** 64KB
*   **Filesystem:** XFS with a 4KB block size

Scenario:
The issue occurs while running a MySQL instance where one thread appends data
to a log file, and a separate thread concurrently reads that file to perform
CRC checks on its contents.

Problem Description:
Occasionally, the reading thread detects data corruption. Specifically, it finds
that stale data has been exposed in the middle of the file.

We have captured four instances of this corruption in our production environment.
In each case, we observed a distinct pattern:
    The corruption starts at an offset that aligns with the beginning of an XFS extent.
    The corruption ends at an offset that is aligned to the system's `PAGE_SIZE` (64KB in our case).

Corruption Instances:
1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)

After analysis, we believe the root cause is in the handling of chained bios, specifically
related to out-of-order io completion.

Consider a bio chain where `bi_remaining` is decremented as each bio in the chain completes.
For example,
if a chain consists of three bios (bio1 -> bio2 -> bio3) with
bi_remaining count:
1->2->2
if the bio completes in the reverse order, there will be a problem. 
if bio 3 completes first, it will become:
1->2->1
then bio 2 completes:
1->1->0

Because `bi_remaining` has reached zero, the final `end_io` callback for the entire chain
is triggered, even though not all bios in the chain have actually finished processing.
This premature completion can lead to stale data being exposed, as seen in our case.

The core issue appears to be that `bio_chain_endio` does not check if the current bio's
`bi_remaining` count has reached zero before proceeding to the next I/O.

Proposed Fix:
Removing `__bio_chain_endio` and allowing the standard `bio_endio` to handle the completion
logic should resolve this issue, as `bio_endio` correctly manages the `bi_remaining` counter.

Shida Zhang (9):
  block: fix data loss and stale date exposure problems during append
    write
  block: export bio_chain_and_submit
  gfs2: use bio_chain_and_submit for simplification
  xfs: use bio_chain_and_submit for simplification
  block: use bio_chain_and_submit for simplification
  fs/ntfs3: use bio_chain_and_submit for simplification
  zram: use bio_chain_and_submit for simplification
  nvmet: fix the potential bug and use bio_chain_and_submit for
    simplification
  nvdimm: use bio_chain_and_submit for simplification

 block/bio.c                       |  3 ++-
 drivers/block/zram/zram_drv.c     |  3 +--
 drivers/nvdimm/nd_virtio.c        |  3 +--
 drivers/nvme/target/io-cmd-bdev.c |  3 +--
 fs/gfs2/lops.c                    |  3 +--
 fs/ntfs3/fsntfs.c                 | 12 ++----------
 fs/squashfs/block.c               |  3 +--
 fs/xfs/xfs_bio_io.c               |  3 +--
 fs/xfs/xfs_buf.c                  |  3 +--
 fs/xfs/xfs_log.c                  |  3 +--
 10 files changed, 12 insertions(+), 27 deletions(-)

-- 
2.34.1


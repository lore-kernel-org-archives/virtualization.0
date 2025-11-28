Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A042E54A2
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318760; cv=none; b=EU3K7yZ77mx3ce28iYOB+8PIsw4n1CpyE6Js9lOLvNrX8PfUsqtdk3LEbBaLe7iEZK61uMCnVLQ84gL1giccBAcBAiPn1k4hHo+J3eBedKn22t1yDvA3w//i5RzybQoepbJhIE6kRnm9JIj6k12aSCRvyT47A1H5t6JAB+pwcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318760; c=relaxed/simple;
	bh=nXmk28ARgCcn+VciidQA11ELnwMOW79oTG8rwah+rkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NtFjSKBH3Hh7n5D25VT5sJxm/fmN8BNHRgFl9xRR0JdXJtFG76hztCLS7QnlRPrn6as4VBV9rmFNMoZGHtvx8u2kJByU74T7NujciZ/ReYZIIWj/aHe8FZJc1mb7scBvVype3qHF7NawBEYVNaNJZUyoxU4PFUvkxtROir5mkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUH8Kl5y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUH8Kl5y"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1388967b3a.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 00:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318758; x=1764923558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=jUH8Kl5yPbTHHmA8UhMI+1t5T/al5pZFyH+5kVWeLenfkKBtm2F6xkjJNrAiFL/qsJ
         G+tIkwkrreNF6FQCMhzcIGbd1kYEGeCGZVSmuT/AtKRQGe90kv1bnnt+720s+Mdj/Xvw
         dchkgOzrBmpfmRoBQUMlbwjKyZW5Ywap4VAfD71m0LTaKNHpyebv3nvwkIYakuPIbQ/H
         w7dF6XBScFFC5UxFPBQXxp+3+t7RX0w56csB1ZmRx10xm6NeHrxZLdvBPziqAmF9VruJ
         NquHmq8+Zt1XH56rB6TZxBnxIojG2LBj2np1sWQ2C99q2azy7ADhHZ9XY5OgWvSeRn+M
         tVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318758; x=1764923558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqrU9sAvwHlZJQNnImTr6s/wIfO8kcl//WUqMA/q7Cw=;
        b=rxDgOUCvB06zlBsokIr+kayHsUztMIsXX1aTvg9QB2AxqahE1nxGu+hftx4lahpEZB
         hNez152obE3v9A+Vj3M0SsY8FWlt1YaMPh3aEmQImMxIMoy7tnbCnYoQy2EzptyN1QhY
         5o9/RKzYMxlUMXsTObO1AjAggaeU8KFf0ICmw6C7dsRqsQVCwoUkonaCpufpG0Ze1gNr
         7K4sAmqwOMP5xW8GzfcVeJxDnCRh574qVhCYdvwDMz7By53KLhLCKz1IJ2DwMaQkiW/z
         u7Am0O/c7usIfOaWVPG9/GQd6xzhscS9lUi4J1qssYL6Ctp4nK3L0MbbQJRP58skXf3i
         rEkg==
X-Forwarded-Encrypted: i=1; AJvYcCVnjfgkOrKXgmsEt9cclg/OaSdUDhlZ/GRRL3/NhB72xRvnIoP0oyble9MOt0P0Myh00KMfkU/YKLEpqbCVNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsJxpP41+NC8z7FyrUC9enIHRxI8P18KyiDcLEjd/m7EPfNhxl
	Oy4t8zUFGrL2NM/x/H2vrawx4jEaXz9HUkqCgaMX7Om234TAVZQM6LQc
X-Gm-Gg: ASbGnctLEmjR6LqHD5lv+3Jm2wZ9u07NGTW0eoVgtonLwI5US3bqFWie7Btg2lH2dvD
	U7X7SfiKCzM6B5cMjhC2a2g+5QtdGTXcuyPAHKSJ+WZCBNdMjbkSjxgSsa2R8V+6L4EDzYHcMki
	B6wmLTKYiNLrzmmuwnUrzaELPzSv2qBP2Y8LRuIMVoJFXMzydQnEEyAoUthcLryxFPFg9GzPcRJ
	o5ujdChd+y+g6ANUZ3faAKX8V7xdb5d1sy/sESnlumAlg2HylGqMQPCsENGxL+w55N/bn6D6DTy
	5hycFfmGZ/uJZ9MLAe30IenzRMdHlvPNslCGodcw+pwP/fHTENk3JGpk1dfkLX+Bp3BfA1brrAE
	IFznsl4pUzUM1a52u9h2AeckjBW+7Dwe+mZUyhFHYydFkGF+jrBdBN00EGF0cmHd22tmV1EoUqG
	iLhRS2+dWaKjTBnjnQ9oXlSy/U+w==
X-Google-Smtp-Source: AGHT+IHdakmTE4ccsFNQ1yLU+VXJurH34ar1nC0le8zm5bpThSihG4vDxPqEawqzf6sYQkBphfQIBA==
X-Received: by 2002:a05:7022:ebc2:b0:11a:e610:ee32 with SMTP id a92af1059eb24-11c9d85f282mr16086363c88.25.1764318757636;
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 00/12] Fix bio chain related issues
Date: Fri, 28 Nov 2025 16:32:07 +0800
Message-Id: <20251128083219.2332407-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

While investigating another problem [mentioned in v1], we identified
some buggy code in the bio chain handling logic. This series addresses
those issues and performs related code cleanup.

Patches 1-4 fix incorrect usage of bio_chain_endio().
Patches 5-12 clean up repetitive code patterns in bio chain handling.

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/


Shida Zhang (12):
  block: fix incorrect logic in bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio
  md: bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: export bio_chain_and_submit
  gfs2: Replace the repetitive bio chaining code patterns
  xfs: Replace the repetitive bio chaining code patterns
  block: Replace the repetitive bio chaining code patterns
  fs/ntfs3: Replace the repetitive bio chaining code patterns
  zram: Replace the repetitive bio chaining code patterns
  nvdimm: Replace the repetitive bio chaining code patterns
  nvmet: use bio_chain_and_submit to simplify bio chaining

 block/bio.c                       | 15 ++++++++++++---
 drivers/block/zram/zram_drv.c     |  3 +--
 drivers/md/bcache/request.c       |  6 +++---
 drivers/nvdimm/nd_virtio.c        |  3 +--
 drivers/nvme/target/io-cmd-bdev.c |  3 +--
 fs/gfs2/lops.c                    |  3 +--
 fs/ntfs3/fsntfs.c                 | 12 ++----------
 fs/squashfs/block.c               |  3 +--
 fs/xfs/xfs_bio_io.c               |  3 +--
 fs/xfs/xfs_buf.c                  |  3 +--
 fs/xfs/xfs_log.c                  |  3 +--
 11 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.34.1


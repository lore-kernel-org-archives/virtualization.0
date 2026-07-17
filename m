Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316341A8F
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247884; cv=none; b=VGsyIekryNMw4mG0xyIcg8R/dRS/S8nRAjQ7f+ot7asiaeFa+H9g8vD5GRxwKzmWuzV9K+FbpCgFmeXavr2sSQ2V1PogH42cNWZeb5cdBRESB5OPLYAKsBKu2r2XNX+8Rwhy7GJ3WbE/MSSj25phV5Zyg028ZbV1nVz5hXEYd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247884; c=relaxed/simple;
	bh=cdCr0MkoZXXDY6+4oOu7E8hYSXKiQaFOn3x7nj2N1lU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QqOgA56NcOS/DlHoaAgHSqj7w7/e4evWmko6SC+pJ6m78trf382lHjKMhsIHV7nyOejNNNuX0vC6XGJEBQa4gHmoxF06eia3jCGKNVYA5n9TK/rRMod2HU3kGdhjzBX6xv6TDbXv8YRtV2jmrJ1pwllcUJuf0+sjmYt95yDJGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhYv92D1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhYv92D1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88da04b719so3565239a12.2
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784247882; x=1784852682; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YNf9hW6w/Xci92rbeL0bZAjWiyrFwINX6SeGZd4Qiuk=;
        b=NhYv92D1pPz4aremNk8yxak7GwBP1G4U7PHx64Gt4iujcHT4y6SFUjV2NcKdpmK1EN
         0x9et6hUiuBFPlDo17nDilp8NX26TRDVwQagGHh9WGUxgfe4G5VwJMkBaI4W/VUTGTa3
         ksoje1lwZFk2cYWRgYjAW/xypuv4di3EJLI/xB9LsD2F019EEr1j1kovc9TBFe17r9pH
         CyJbkuEaA8YwoGTSY3UVNg5WTYdHApb2XOdJj8RnwxeSrtWmvr3YNNEqYOLyicg5XzDH
         LAKL6sSbXtZR3UvqorngOErpJiDbGbmc9z9FoAWw1MjH92o4bWxCqKT5deMlO2Ai9bxY
         /gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247882; x=1784852682;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YNf9hW6w/Xci92rbeL0bZAjWiyrFwINX6SeGZd4Qiuk=;
        b=D3eJjcRObl1nH/e2YsQOWV/uKD+m+51BUy9yKSlJDV1w/TL/oJrgtMm4Tx2h4bjz7T
         hEwSnSzOOcA7UN/D/4A/NR1jonudQU38i3VNKbrgpBpOkCCsRpMDZvoyix1a//vA3kbK
         iRlGbjoB2mnlYgpnlvPcjdtPwavLk2M/eWMamjIzQQwqrZDeviHdK0OiZdgLWyGJ21Rk
         tvX1HAKjnuqw4EEdOVZ50DOguuD0sPFGk+9fnJ6rKGQT+8nmTRj3bOGU6UWFW3l7GGLw
         L9Hn2rqsqQGEaDOhmc4MJJcmoZ1/IUhBemxzMBcgiXLVe30Xe/+eb9D/2VyGQ+v7d4Rg
         +YHQ==
X-Gm-Message-State: AOJu0YxXw/BkZVUx571yEuf2xAy9w0C3LUwK+Fk+SpDyB4rgoq71+hNp
	Ap4ALXdYkJ1U9ICkLwl1bPvVHb2xav+ugc7PtQbkGhgC521M6lHF6cQIbdw8zN2xI2+MPtxZ2WK
	ezQ==
X-Received: from pgbfe6.prod.google.com ([2002:a05:6a02:2886:b0:c85:6deb:ee45])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d4c:b0:3bf:b0b8:58b5
 with SMTP id adf61e73a8af0-3c3ada18310mr197568637.36.1784247881450; Thu, 16
 Jul 2026 17:24:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 00:22:19 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717002311.681748-1-linkl@google.com>
Subject: [PATCH v2 0/2] virtio_balloon: fix Use-After-Free bugs during PM freeze
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series addresses a class of Use-After-Free vulnerabilities
in the virtio_balloon driver that can occur during system power management
freeze (e.g., suspend or hibernation).

The core issue is a lifecycle mismatch: when the system enters freeze,
virtballoon_freeze() resets the virtio device and deletes its virtqueues.
However, several asynchronous or event-driven components of the driver and
related subsystems (Free Page Reporting and Shrinker) remain registered
and active. If they trigger during the freeze/suspend process, they
attempt to access the now-deleted virtqueues, causing kernel crashes
(General Protection Faults or UAF).

To fix this:
1. Migrate Free Page Reporting to use the system_freezable_wq, ensuring
   its worker is frozen before driver freeze callbacks run. (Suggested
   by David Hildenbrand).
2. Avoid shrinker execution while the device is suspended by adding a
   suspended flag to struct virtio_balloon. Wrap lockless reads of this
   flag in READ_ONCE() and writes in WRITE_ONCE() to prevent data races and
   KCSAN warnings.

Note: The OOM notifier (virtio_balloon_oom_notify) is also registered, but
since the PM core disables the OOM killer (via oom_killer_disable()) during
freeze_processes() before device drivers are frozen, it cannot trigger
while the device is frozen. Thus, it does not require a fix.

Testing:
I have verified these fixes using Google=E2=80=99s virtualization infrastru=
cture by
running continuous suspend/resume iterations (40+ cycles) while=20
churning memory using stress-ng (stress-ng --vm 4 --vm-bytes 60% --timeout =
1)
to constantly create free pages for the buddy allocator. We also set the
page_reporting_order parameter to 0 to make the page reporting worker
highly sensitive, forcing it to pick up any 4K free pages. This=20
confirmed that the UAF crashes are no longer reproducible.

RFC: https://lore.kernel.org/r/20260709224330.946683-1-linkl@google.com
---
RFC -> v2:
- Switched page reporting fix from unregister/re-register in driver to
  using system_freezable_wq in mm/page_reporting.c, which avoids complex
  restore rollback logic for that component.
- Switched shrinker fix from unregister/re-register to using a simple
  suspended boolean flag to avoid complex rollback logic. Wrap its reads
  and writes with READ_ONCE()/WRITE_ONCE() to prevent KCSAN data race
  warnings.
- Dropped OOM notifier fix since it's already protected by the PM core's
  oom_killer_disable().

Link Lin (2):
  mm/page_reporting: use system_freezable_wq to fix UAF during suspend
  virtio_balloon: avoid shrinker execution during PM suspend

 drivers/virtio/virtio_balloon.c | 49 +++++++++++++++++++++++++++------
 mm/page_reporting.c             |  6 ++--
 2 files changed, 45 insertions(+), 10 deletions(-)
--=20
2.55.0.229.g6434b31f56-goog


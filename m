Received: from cvsmtppost12.nm.naver.com (cvsmtppost12.nm.naver.com [114.111.35.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A338331F
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278553; cv=none; b=N1O4WO9BWP1A/JwKef/SGsHHkkerAWoDk8o4v8IWVzCaqP58JZQrcjQS5S5dgEQkPX9rQR3Sk6EfblJqV9KoPtcaZSY+zClDduuBC854X1XXWITxuhUKkIKPal9k1t1UPJk/IFsM+LmvekiPtdjXabDylDOT/F8o2/43TgDHhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278553; c=relaxed/simple;
	bh=Truap0XSIFPQhcLA4S8k74uDvdi356L5WW7QR+Cu/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqTvA5oNowRS1hO7z1l81bT/PhmfPrlc70g/HDXpQCXycvldbDGzdrPxA2Fu0x3NfsZKO71im9sQCost6d5gRCS4ekq4i2NBYfupJHqgE6aKhsZx1XNK0Lzpppp7GtO20Dvat4FJQvSu3iSW8agY78D3v8NgfdM3eI9bnAzQA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=mgxPzxei; arc=none smtp.client-ip=114.111.35.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="mgxPzxei"
Received: from cvsendbo019.nm ([10.112.22.34])
  by cvsmtppost12.nm.naver.com with ESMTP id FpLTKEz3TKKW27aj2WLKnA
  for <virtualization@lists.linux.dev>;
  Tue, 06 Oct 2026 09:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791277936; bh=Truap0XSIFPQhcLA4S8k74uDvdi356L5WW7QR+Cu/MI=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=mgxPzxeiJdWHpXVZkAPCE7dGWXIRNm9CgLDWqvk+1aE1I0nYvhMLMeoFdLkV+5ZyM
	 LQBj0zdNae0Fr+2CRIF4h4bgYw2K5fNgQ+/TXXXVEeNrGWyIyRwtabBmotZchXccLn
	 d0Z+Haeq7gTra0SDKB3zb1tnQIkc5q2RvrJYTJCsJMXcwoeeOc564xSViJgbkNAYBr
	 cJQy+xz7OXUbc5UfT0c0zwPrWhl0GvxshwwUYuYuTbq8Wcq86TAEG+BI/HD0te9u4x
	 FS/8oygYiQaw/t+R00PFoQoFgQyZdffAo3n8tkJZ+eEA5/EBV3g/EEEyye7rsuKniA
	 jZHe1iUorjDaQ==
X-Session-ID: PlmYEZ4FQbeJBl0Ag3SPpg
X-Works-Send-Opt: OPewpzGdjHmdKHFOMr39Ko3YKHmXjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: /qYdKoulFqJZ+HmrKqE9+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp05.nm.naver.com with ESMTP id PlmYEZ4FQbeJBl0Ag3SPpg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 06 Oct 2026 09:12:16 -0000
From: sungbyeongchan <tjdqudcks0424@naver.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [BUG] virtio_ring: VDUSE backend can corrupt split-ring free list
Date: Tue,  6 Oct 2026 18:12:08 +0900
Message-ID: <20261006091210.828229-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found a split-virtqueue free-list corruption issue reachable from a
delegated VDUSE backend.

virtqueue_add_desc_split() records descriptor flags and next indexes in
the kernel-only desc_extra array before publishing the shared descriptor.
During completion, detach_buf_split_in_order() follows the shadow next
index but decides whether to continue by rereading the backend-writable
shared descriptor's NEXT flag.  A backend can therefore change the
detach length after publication.

I reproduced this twice on commit
ff47652a4b66c067c765a7ad464d930b5a9367cc using production VDUSE,
virtio_vdpa, and virtio-net paths in an isolated QEMU guest.  Initial
setup was performed by root, after which the backend ran as uid/gid
65534 with no capabilities and no-new-privileges.

Changing one published RX descriptor from WRITE to WRITE|NEXT caused
the host frontend to detach the adjacent active descriptor.  Completing
that adjacent descriptor normally then detached it again.  Six valid
completions increased num_free by seven and the following refill
published descriptor IDs 5,4,3,2,1,0,1, demonstrating deterministic
free-list corruption and duplicate descriptor allocation.

Four controls were clean, including no mutation, a one-descriptor
NEXT-clear case, an invalid used ID, and mutation after completion.  I
did not demonstrate an out-of-bounds host access, chosen-address access,
information disclosure, panic, code execution, or privilege escalation.

I tested replacing the shared flags read with extra[i].flags, which was
captured before publication.  The same forged workload then refilled six
unique descriptors and the normal control remained unchanged.  Build,
checkpatch, and fixed A/B validation passed.

I performed a best-effort public duplicate search through 2026-10-06
and found no exact public report for this post-publication NEXT mutation
and split-ring free-list corruption path.

This report was prepared with AI assistance and is being treated as
public under Documentation/process/security-bugs.rst.  A tested source
reproducer, logs, configuration, and proposed patch are available to the
maintainers on request; the reproducer is intentionally not attached to
this public report.

Assisted-by: LLM

Regards,
sungbyeongchan


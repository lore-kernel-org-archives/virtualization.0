Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349271;
	b=mmOw4x7HFj5Ym3VFmITdJg9GDmtUTbeXJtxrTAJVG++Qq/MB9CsrPGAfAkWcLoYHQfAs
	 LggfzwOqb4m9E4iSWJ1cnkqR9ohw7VzED/xxepB85sS4eBsYkYiN4s8vbpOBsIOUYEel6
	 MPjcmjdeOA/Z29t+QKwJkyOJKqJWeQF+me+9Nrh4sUEqvkROS2e8Mgtjlc0px+2cBFwq/
	 s6f0kLO2+Yneh4MEy7ReP0CgjeS6s8TlcSUwEGSrenlL9bFXRjr+mglUWyPKiZhzMsfzi
	 OBGxms1o7OHyPrt7oPV80+M9Zwa9EIdirwfWyF8ilXpPgdG+ljzbo6Tbp3LL7vg+mTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349271;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rtaUv1PCCQkmTHqeMIkl1TNHeUjhBKZRZZlSb84aAsw=;
	b=TlCEPKweUZR4nKMMFjNc4LGPmWYC0+62vl5S1hJrlkeXYhal58TCWK1WA5BFAWoJAnXy
	 BAtrGxNnDAYl0SO7VHIRu4gkX2uQuajAxwQwnU244ABqR0oDBOwvPTMT1E3PRP8hqTD4a
	 +OAykbGMEzcoN2X7VngSbXb0ak3z/aopTqiBVnsm7Aie3amlUE6zMmGF0w1bqS0K2Ix8B
	 mfjGnR2nvfsJh+1s0lsavmvfLJUr5+I6SpvmIR5VtzQRYt8Vyc2LwYQ/GlAKfQGL2jWX0
	 LTNa7DwM7T40Kb5VbhaFgxmqSmu9WItnTHdocS4pidJX0G1WF7ZKJYY/zpQlhietmyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AX6oqBhA;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090F606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5090F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AX6oqBhA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rt
	aUv1PCCQkmTHqeMIkl1TNHeUjhBKZRZZlSb84aAsw=; b=AX6oqBhAvAkvhU6PxC
	E5XtxjDQm9V5b6NgY6bWpXWA0nZzEPnsOGExhan45KtTGgHNPnHv8crSrd+qky/E
	vr2OO+QHHgenxaYhNkVMMCCxFxQhAxpVJN3Msg6wcdOWRVGp/cS+7TGR6+ZmIQic
	81UjW4WuXNeY2F5PTvCByfyyc=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXRXl+VuRqCoKSCg--.15983S2;
	Fri, 30 Oct 2026 16:34:07 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH v2 0/3] Add virtio_balloon operation tracepoints
Date: Fri, 30 Oct 2026 16:33:57 +0800
Message-ID: <20261030083400.66005-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:PCgvCgAXRXl+VuRqCoKSCg--.15983S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr13JryxAr17Zw1fGF45ZFb_yoW8CFWUpa
	93Cwn3Kw48Wr4IgFWfK3yUtw15Zws3GrWftFyaqw15Cr43CFy8JwsFgayqvFnrAr1xJr9I
	vF1IvF1UCr1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZjj9UUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC+wCJ6mrkVoDmOAAA3e

From: Qiang Liu <liuqiang@kylinos.cn>

When a guest does not react to balloon size requests as expected, or balloon
operations stall, guest-side balloon activity cannot be observed. Existing
feedback ("Out of puff" log and host memory stats) cannot be correlated with
specific requests or host latency.

This series adds tracepoints under "virtio_balloon":

1/3: config_change / inflate / deflate: log target size, applied pages and
final size to see partial balloon adjustments.
2/3: host_ack: measure tell_host() waiting latency with vq and PFN info to
distinguish host/guest latency.
3/3: free_page_hint / migrate: track host hint commands/outstanding blocks,
and balloon page migration including balloon_lock -EAGAIN aborts.

Tracepoints are inactive by default and add no production overhead.
Test by enabling events in tracefs, triggering balloon resize, compaction
or live migration, then reading trace_pipe. Verified on QEMU/KVM.

---
v1->v2:
- Patch3: Trace vb->cmd_id_active directly to match the cmd sent to host;
- Rename outstanding_blocks to unreclaimed_blocks and fix its description;
- Wrap virtio_balloon_migrate tracepoint under CONFIG_BALLOON_MIGRATION to
  kill unused-tracepoint warnings.

Link to v1:
https://lore.kernel.org/all/20261030025834.19160-1-liuqiangneo@163.com/
---

Qiang Liu (3):
  virtio_balloon: add tracepoints for inflate and deflate operations
  virtio_balloon: add tracepoint for host ack latency
  virtio_balloon: add tracepoints for free page hinting and migration

 MAINTAINERS                           |   1 +
 drivers/virtio/virtio_balloon.c       |  43 ++++++-
 include/trace/events/virtio_balloon.h | 157 ++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/virtio_balloon.h

-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus


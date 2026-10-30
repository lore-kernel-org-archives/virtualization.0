Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329143;
	b=4QGNvofePS/0KHddQ8jS9Kr+1CsWDtBSchU5nL9HfnvmC9rtQ4KOHCCRxe2UqJ1M6CEg
	 zPJj2huNUPWfhr9XbJv1jdRGnOcajB6ue5IIW8c8MWfnMbnl8cuElCAzHAPE1q8AikNJU
	 Jw7k3ylUHQggTWHlnx0kZhh2+vD3WVelVInkYGaRwlorqiAzcNpTlmq8iJrjAFEg+9Z12
	 PNLSJdGSJuEYpuz4Jb5Q2BjvEksq9Ednnwf1K4rqpFC53aQxNfIkqzt/JYSEdqctn8g6m
	 SdGKRNoFco2MWVoI+hNtkh4o+G9+JR/eKaTHjDRYr9Fuf8a39zD+jJOPp5ucGloeA0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329143;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ysHEHwdWnef8TczcWYst7gxhG3lb99c87OeAH/9ccd4=;
	b=M9LagmFFFksZCWX6lWoBIUI5r3m37aK4/DxbnmXW+Q83zFhDnNVQJqPsmDaPSJKHaCBT
	 v75nwHGoUAYwr0jPsWZVTOWnTPnjmFSGHSBHzWe9T9yAjBOHgjUedUITxaDb5sG7Fw9oS
	 4q8yq/4YT8xOU5RafnLuJbk7eA045DD5km07bPMbKrFrLFcl6HkCxG2Fx+BUCPxLBZbDq
	 aYTxwRHOeuRijxHR4qWBMjsCom28H6i5mVQqrbylL9kb8RK/d/hyr9v/1JLgdLMrtLrXR
	 Xi5wzrYlPDPtJN1UzeMnyPC/mqZKl9WeEiFj5puXMpoeRt4j/AdVQUxaLpSiIfd2IOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=guc453SH;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91700606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 02:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91700606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=guc453SH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ys
	HEHwdWnef8TczcWYst7gxhG3lb99c87OeAH/9ccd4=; b=guc453SHGgmuEO9s23
	qzT+Vx8t7XjlRFEU2gMeqgscut2/FScD7AI+E9h0xmT1dNcP5tHky/gEGK5YeTGB
	vTps3lYqfpaaAs3zXaXjMERyM83B+uz9m2S0UDwiVbr4DRca+SfQROV26RXWtqZg
	5TEM5SPH04ZsiRFYgHB30i198=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnZfjfB+RqfTvxCg--.40090S2;
	Fri, 30 Oct 2026 10:58:41 +0800 (CST)
From: liuqiangneo@163.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH 0/3] Add virtio_balloon operation tracepoints
Date: Fri, 30 Oct 2026 10:58:31 +0800
Message-ID: <20261030025834.19160-1-liuqiangneo@163.com>
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
X-CM-TRANSID:PSgvCgCnZfjfB+RqfTvxCg--.40090S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr13JryxAr17Zw1fGF45ZFb_yoW8Wr4Upr
	Z3Awnakw4UWr4fWF4fK3yUtw1rZ393GrWfJFyaqw15CrZxAF18JFnFgayqvF9rAr1xJrya
	vr1xtF4UuF1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZ0eJUUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC-AHNL2rkB+GgAQAA3W

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

Checkpatch --strict reports harmless alignment warnings inside TRACE_EVENT,
consistent with other trace event headers.

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


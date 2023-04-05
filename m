Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EDDC76188
	for <virtualization@archiver.kernel.org>; Wed,  5 Apr 2023 20:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 454CC81FF4;
	Wed,  5 Apr 2023 20:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 454CC81FF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=UxbfPa4n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otaRRVn70bm3; Wed,  5 Apr 2023 20:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDDE181AD1;
	Wed,  5 Apr 2023 20:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDDE181AD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9414BC0037;
	Wed,  5 Apr 2023 20:14:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA2D8C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C414C81E53
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C414C81E53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFiOotx5FDpc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B864D81AD1
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B864D81AD1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dwlsalmeida)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 63E7866030CD;
 Wed,  5 Apr 2023 21:14:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1680725667;
 bh=v2OezC2eOoKmX+pqSD+mVfxyCEzS9XKNpWmxKSDdPnk=;
 h=From:To:Cc:Subject:Date:From;
 b=UxbfPa4nKsc8IT7K38/+QZoKPGeSO33cym7VJPvwXMLJQboCJdKGYeCZzoLvFwAB/
 Ki6KVuioJ81Dx4HoZP3E3r58c0104VG2zms2QHsqQ+6ppYY7goIkEPYBm7imu83IAH
 XZ/NL5wgA4dYxI/ejlOHCYPVLfNTI3YrsGJ75P4+XWheHkXj0RlU/35JzebHLwt8W1
 MTfh/hjZtqF/0309g6IxmMCFa4nvfJQMUajl6hgqvZTfPblL6SHGlu+pQhoqWCkyxM
 PF5yTCJH6up83YRVaBapmI2eZC3OLe15ZvxsPJXWJ3EW3Mjs6JZfPCwQvBTtDMdeuF
 iqI37j9a5CUOA==
To: wedsonaf@gmail.com,
	ojeda@kernel.org
Subject: [PATCH v2 0/2] rust: virtio: add virtio support
Date: Wed,  5 Apr 2023 17:14:14 -0300
Message-Id: <20230405201416.395840-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Daniel Almeida via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This used to be a single patch, but I split it into two with the
addition of struct Scatterlist.

Again a bit new with Rust submissions. I was told by Gary Guo to
rebase on top of rust-next, but it seems *very* behind?

The first patch does not build on its own due to a dead_code warning.
It is hard to not have dead code when one is adding infrastructure to be
used by others at a later opportunity. Let me know if you would like to
see the patches squashed into one to fix this.

As suggested by Bjorn, I added a small virtio-entropy based sample.
It is a very bare-bones clone of virtio-rng.c that only sends a
single request.

Changes from v1:

- Addressed review comments by Miguel and Bjorn.
- Added a scatterlist abstraction
- Added a virtio-rng based sample

Daniel Almeida (2):
  rust: add scatterlist support
  rust: virtio: add virtio support

 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  25 +++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/scatterlist.rs      |  40 +++++
 rust/kernel/virtio.rs           | 261 ++++++++++++++++++++++++++++++++
 rust/kernel/virtio/virtqueue.rs | 126 +++++++++++++++
 samples/rust/Kconfig            |  10 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio.rs     | 195 ++++++++++++++++++++++++
 9 files changed, 664 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs
 create mode 100644 rust/kernel/virtio.rs
 create mode 100644 rust/kernel/virtio/virtqueue.rs
 create mode 100644 samples/rust/rust_virtio.rs

-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467005;
	b=CSbbmD8vPX8RZNYviTh3R5jdVE/AqYF4DLxD16Ymxi8yVBQTmvBAh3eW3fWEXShuKemr
	 zwxlknL7wT0dKVvbMKjivTKw/ORdagwBiyZ0zBpsMU6UbrdBV8knhy8KYoNbY6SZmiuZf
	 ceJ/H6KSdUsXZUGOjq5owqCfaKgoV/2AEXm6Z4ng0sWCO4KRzsfQrqowVxzVQyEEEi1hl
	 X8oDk0yPi7NRohoDLAypvS/DiNV/ulUctBlsRS0QD+OIFfipI6PD6bzCHSi6P60qlqxsm
	 1HTbpuYAiVYpAvgnShrwMkKbt9rhNI0Vb6dvwSlsNBQKvTeePl6ioY8VPW3YLPRg3HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467005;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qL6/UfhT3u4W8PbzEli8B3NlJ3DOGDnwkv9jQm3h2q0=;
	b=cVgxT8tdC2POyLQJrh6kVGu88m6sKMVjoSu3w1aywpKvJ/wgCpgMdPt7RrW3kA5OfEAc
	 tR0WTwTuwvbWJk2kRjJTi3bz7OefoNoM35Frzg7/NtvU9hmKJnTfDmQ6Oj1xlfL2S39Mr
	 yMgxLlRafCrm+IWd3+MkIjVmdaGC6WwHQwR4buz1aivPptP6KD0IW1ydxrrhoqKq2eTLM
	 nrkyysm99mfnD5Ckt7h4OsQ8rC4geq6gq5HjlQBE66EM2ebL+3x/Mxpxjum1J1jJ9bB2w
	 kt+pqddU+vl73BcwtOgy2+1HMWR6j7sSbypNhTrFzZ4cRWwf63WSpWjkJyUhnJnitLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OVUbZdRE;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07A606A31A;
	Tue, 20 Oct 2026 03:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C07A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OVUbZdRE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qL6/UfhT3u4W8PbzEli8B3NlJ3DOGDnwkv9jQm3h2q0=; b=OVUbZdREdSDMnIsEtNwjtiCogK
	0y3mEhf+/CXCFKZpnZwX5+45gAfs6sd8ARmGqj9zHYqULUIfGpMquVfLSCbBm6UATpjvVwVBwj0JE
	gB6th4jErShWLxElzD2bdREL2cIlNKjhOoFt4kIEkPJN4+DFSFzhDDJk0rEOPtPdJZeJhM5ts5Zvp
	6/9oqyfXi8y1xW8VmCxskR05GbPgICrHlcWRGgV7JF9FPqfKM+4t1WtW7ebXqHP6ZB0w35eT7wnTR
	iaSjo2MsnwuAosioxJQwl6sUROBOm3yi8oXRHOWk4XNuSQCP4HLTJFusNnLj+sjZwP1CFNs2s12h7
	Mc1wdvsg==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ0Y7-00000008nFF-1f14;
	Tue, 20 Oct 2026 03:30:03 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett (Google)" <liam@infradead.org>
Subject: [PATCH 1/2] tools/virtio: add a shim for linux/device-id/virtio.h
Date: Mon, 19 Oct 2026 23:29:57 -0400
Message-ID: <20261020032958.1930203-2-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020032958.1930203-1-liam@infradead.org>
References: <20261020032958.1930203-1-liam@infradead.org>
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

include/linux/virtio.h takes struct virtio_device_id from
<linux/device-id/virtio.h>, which the tools build cannot find.

Add a shim for it beside the others, pointing at the real header.

Fixes: ecca1d63c1ea ("Replace <linux/mod_devicetable.h> by more specific <linux/device-id/*.h> (headers)")
Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
---
 tools/virtio/linux/device-id/virtio.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

diff --git a/tools/virtio/linux/device-id/virtio.h b/tools/virtio/linux/device-id/virtio.h
new file mode 100644
index 0000000000000..3c3e8c514c8d4
--- /dev/null
+++ b/tools/virtio/linux/device-id/virtio.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <../../include/linux/device-id/virtio.h>
-- 
2.47.3


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467005;
	b=ATl3Su+YUvWB5231ZaiHDCEP23D3p0m83cOAgDEBQrghMz01E6T7DO4oZ516oTq3x9h3
	 mcsoRmtR4oa3jsCsvSiV4aNmb1npoi2Zh0o9imXFPG151PxczOgqNfGhrfL3B4MV4540O
	 UdqPiRE5nlD9HpLNXNvkFSqNPDLLYFKuQlAf154t6VbkxPLD0ktzvH4s101Na1yC82jYp
	 ++3vA6AzI1ZIMYikupnb2uJQX3aQKRxeNZ6mskUl9U228TyYnDEgV9twBcp+SxaWh1T60
	 kH5d3fyU8SaBY8cyhWemLtoM9HDwzZJqY9z9w6/vNdoFQYwcvFM/UWQUTvyT9X5fPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467005;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=asMh+o2gVQeH0IC3/QPVkAC3HWMmbRDpc5a0pt+Ow68=;
	b=O8S0ZTsI9K1r9sVTBrQnJANJl3CHcpb30XJ03TWoP0A9BLDxlde2/OIzUVbhHZld+Bm4
	 H0y1SlrUFiKJD0Knblg2IDMVruugDplgt9QlLL6XLX7CLmJAkVz9Jp9ftjiynnDkXxNVk
	 kADpU+8u6xNuwV1+M2BvEwibiTz1e/dPoPRIrdzLObr11aKywm3iKCPTqHEKDN0doN9BU
	 2JgMshNjHYwgFNfR43JyMyNd916XovIDBhp4SQSjVoLUTGfea/2nYXl/gxZHh0faGO96/
	 j5DCvjk2FdJ0dVvbm6flO7xU8rQwbKMCDE6hjIcDG1fD1PrO4Z86d0ONPeizcB2j3JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PhjR0r1U;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1C606A319;
	Tue, 20 Oct 2026 03:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73A1C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PhjR0r1U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=asMh+o2gVQeH0IC3/QPVkAC3HWMmbRDpc5a0pt+Ow68=; b=PhjR0r1UN2ZRLvW9ZPRbqenUbn
	y5MZ3CvXcvL0NimMd4gJ0itfp9t+Lb8Oe8yFwE9O2gP1BAKufHuzJcsAK1ScFr+FrLwS1W556NZQJ
	/jhsc9NBNpO/YgSJ3ZZIUUsM+j6pa9ipYKkinAx1SFDF1bUFFxT1JmABHOWK5zJRgdPExTUAUm7gi
	y2cNOvu5lRGjJsAyrL+X6S5719+weee2I6dQsuCdh3KHCBJr5rB4dDV0ZkLXN5/XmTDEoKr6uvw13
	hIFmd7aoWXq2HZ7j17vU7F7kEMrtkmFhXPT+mCpbeVdqAb9cWfUukLFZwB/llPXn/elz6O9B9FHBd
	0QvFAvOQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ0Y4-00000008nEe-3sBH;
	Tue, 20 Oct 2026 03:30:01 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett (Google)" <liam@infradead.org>
Subject: [PATCH 0/2] tools/virtio: fix the build and the posix_memalign() checks
Date: Mon, 19 Oct 2026 23:29:56 -0400
Message-ID: <20261020032958.1930203-1-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
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

Working on other tools, I came across the fact that posix_memalign()'s
return is not the standard negative error.  Scanning the git repo, I
came across the virtio issue with the return.  Testing turned out the be
broke as well, so there's a patch to fix testing prior to fixing the
caller.

Liam R. Howlett (Google) (2):
  tools/virtio: add a shim for linux/device-id/virtio.h
  tools/virtio: check posix_memalign() for failure

 tools/virtio/linux/device-id/virtio.h | 2 ++
 tools/virtio/linux/kernel.h           | 3 ++-
 tools/virtio/vhost_net_test.c         | 2 +-
 tools/virtio/virtio_test.c            | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

-- 
2.47.3


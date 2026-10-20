Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467008;
	b=v6wDIpsh+/4DfE77uCuCXZa4vmOaxkT814LAjX1PINo1s5AWl4MB/KHrxyE+H7Hy5NX8
	 Q10Z+zeVp6tj0y+wJ7OERJ8mdj27UKObddn6vS+E9ywO9TSfHa6GKaT8tvD0+UDXFjETe
	 4cyHTWc/aCennQOfuBzw76ZHaeV12T0UmC8Vfm7SO07/rQZwBmhKMqtSmpxq1gEOnaIWs
	 6Y7eQBmidgmnz1uXq/um+swOnuuPUJfjC8kuS8uttna0eDsBJQYWnsK1KjgZssApNeD7W
	 liSP/Rn/fyN23zHzoMt8cgVOEK2bkktq4fNJo2N/h15YplOZznlsDwJi0spYW3JwyiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467008;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0F4URRGRgV4E81h1KRPQl1dny33AJbrMWA9ADHkiS6s=;
	b=V1eSIAe3hQPrjtWTFrOS5IthDJMUbwkim4KM3ev6nxdu9s+BHqC1eJJQ45gp5Op9B9or
	 AFgGVvguXR/hk+4go/Dg1F9059w8Hvzpc01+9SMzKDvekJ8eI79SJ0aRXjSFgyWHDksUO
	 AS5BZEABCmpUvAPcVEYbMJcXaJBpICh2JzqPVkLF8mqgli9OUhGa0tuamXWkNMiNzcxvL
	 B34cGYTQ37U0RgInG9VKgTwpe7m7Cw6ysLdaTbRIbOggzbpfwD1iH1gARCf5/4S1Bq1sy
	 mdCBYzqLf6KkqUSRx0SrDAWzlcwYgZxkgKT6n/8mRc1+YLLUmw5nGaO5nxMc4RTnZfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="bvAcZ3/u";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104A606A31F;
	Tue, 20 Oct 2026 03:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6104A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bvAcZ3/u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0F4URRGRgV4E81h1KRPQl1dny33AJbrMWA9ADHkiS6s=; b=bvAcZ3/u+ZTCleYWPuEEqqwbO3
	OhS8dRwC9gdi6n1Qp1pjGBRoL94rjQf1dxELGKf32LaczbBKK/SIt/GGe5tIqFakPc7UH08vu93+O
	udAZqTn2ulg8LIj8BVaY6Go8TDe9Iqz5E+8KLL44bNDY4KCXyudv8+cxsWP3b9bUmCDIaHuWAOkjZ
	ZTFMXovNetAUbbGTKoaOMxHetYnb8EMeWv+zSKQJ1+UX+7Qsmhoa2UFvHgVbcg411uzyVWZczm4a0
	bClHInnpdOf4FmL8daB0in0GXMht32FlTYWc7QIVBeZoH7JEkSETvz39vBUh2c7lW/qpPKVaG1RvQ
	4ML27JkA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ0YA-00000008nFi-038H;
	Tue, 20 Oct 2026 03:30:06 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett (Google)" <liam@infradead.org>
Subject: [PATCH 2/2] tools/virtio: check posix_memalign() for failure
Date: Mon, 19 Oct 2026 23:29:58 -0400
Message-ID: <20261020032958.1930203-3-liam@infradead.org>
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

posix_memalign() returns zero or a positive error number and does not set
errno.  virtio_test and vhost_net_test assert that the return is not
negative, which will always be true, and the userspace __get_free_page()
ignores it, so a failed allocation continues without setting the pointer

Assert a zero return in the tests, and return 0 from __get_free_page() on
failure, as the kernel's does.

Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
---
 tools/virtio/linux/kernel.h   | 3 ++-
 tools/virtio/vhost_net_test.c | 2 +-
 tools/virtio/virtio_test.c    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 104abf9d1aee5..3497660c690a9 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -106,7 +106,8 @@ static inline unsigned long __get_free_page(gfp_t gfp)
 {
 	void *p;
 
-	posix_memalign(&p, PAGE_SIZE, PAGE_SIZE);
+	if (posix_memalign(&p, PAGE_SIZE, PAGE_SIZE))
+		return 0;
 	return (unsigned long)p;
 }
 
diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
index 566e15420bb65..3122ea0970568 100644
--- a/tools/virtio/vhost_net_test.c
+++ b/tools/virtio/vhost_net_test.c
@@ -197,7 +197,7 @@ static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
 	info->idx = idx;
 	info->kick = eventfd(0, EFD_NONBLOCK);
 	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
-	assert(r >= 0);
+	assert(!r);
 	vq_reset(info, num, &dev->vdev);
 	vhost_vq_setup(dev, info);
 
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 028f54e6854a8..9d61463f6e09b 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -116,7 +116,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	info->kick = eventfd(0, EFD_NONBLOCK);
 	info->call = eventfd(0, EFD_NONBLOCK);
 	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
-	assert(r >= 0);
+	assert(!r);
 	vq_reset(info, num, &dev->vdev);
 	vhost_vq_setup(dev, info);
 	dev->fds[info->idx].fd = info->call;
-- 
2.47.3


Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361323AB88
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776524795; cv=none; b=taGWiSsAqLKEzuV4IESTU8l6gSmv6lrY2ohwDEEOK7zAdfuE2ozMDmYxQ6Wj+GYsyFaaweBygLhdjJNlRQUDrsv/fLbEpQ31FVgUvmmHSnBDA0YsE+7Q+siFXwC5TLyayVEfeZt8Q/gnVPeNUSASsM9IK4vp8OVY8dKYnuZTdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776524795; c=relaxed/simple;
	bh=1V6cC50xQESnLX0KQm6PhvdXPiTmwapBJ75OKMWymPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W80j+gtZrS6QcCYU0Hv/654Ah8GNkveu3T129qXZFii53PSwlQL8IdBgKq7KqC2TmxxiSbA+G8ruw1E8oVQIrgEzGHmuaPx5L2LVvMxl7e/hoAbYqzCjyg4KDgV3TbiaxPGlbA5QYQVMNdMkKbjx9F1nR0BBBz/iOxiZ+Y9fvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsrCuJhL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsrCuJhL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a049a767c3so28452176d6.1
        for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776524792; x=1777129592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz+44MQRchfmC+0bOJjAntAmbV8iNZQ8sftK5LQnA8Y=;
        b=NsrCuJhLskg7XMRWDg6Lo4aMtnK58O9mNT2SZ76whS0qRW1NgnGWSkmrl6R6xPeHN5
         MyxsF+/zGX90kbtLwNcoqiVIo+2dkwpiNGOix+omUVpLlsYcVWvNMw2CbZiKwDpfmI1X
         6HvSAdRTo9cENAjEu2YtqA9ob6X3cTWS0XxecjpGBu4zXinFF62JARVg7cm46SCqrhdE
         FSbXc7fEq1z6MD4SQHJX14cDqog524tRwZAt4IqsCHh2Dqq55YXpc21i9ayWmX5OA9dc
         YXzkJvXJExf51MiE3YZXH2oxH1pJsp9YaRMXwcBW7pI3IyU6OC41ibgo4SYh0xA7qhNt
         1oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776524792; x=1777129592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yz+44MQRchfmC+0bOJjAntAmbV8iNZQ8sftK5LQnA8Y=;
        b=nLjpu3rCk1UFPv90XncSQYSsRb7l9n7JFDhj/7LdW7oFDtHv5hKwWRvobY0BlwcJ2l
         k7t9Dr13iQmD8L6vLgzELwFj+DfgMrWEP9X7Qrr05gqn64MOEnMBjhrU2mYQ6Ads2LQo
         dLz4hE8VHUp977gTshmbEZ7vPi83UOr0nV2SlPrIuMjavOfxOOIcGzyoDvAnnD21y2Lf
         mPcPWMiT4wbI6XZuXltnkVkQJThSgCB9Ct8ZWDaBc7nQho8H96UUNnZN4lwbR3/QHMn5
         iEC8aqlglUSH9xm1e4LNabtgoVes0jVawUeAHT5MPfn5JSoI+Rmj80FH+ONrTRiI09Rj
         BMZw==
X-Forwarded-Encrypted: i=1; AFNElJ9xzsHiFsY3S8Q45m7CUCR0qNbOTbx5A9Qf088mTlIu11nOZUXfW9lpO4pD/142jKuoTGA8Z5pdksZL5W+fQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh9gj5lmFkVMEBEJDAtc8Cf/WPEkJ0YTAFa3wQPHFRYdT6a487
	kAvE3YmZ72dpy7s6/kjUhiofEVGIEftZVF5KSTabMjs+K/xjPc4z6XFd
X-Gm-Gg: AeBDievY9gd/4IF7Dzvy2xRSoduYq18ZboHofTeEqN9LJ2TUoRkugcMdmkw0A498+Xe
	AeO4OKwgwUR93WdvSd5/vSTcDLCYZbYjP8KQ4lRcng/pfkEsPcB0Lju5jIfE5j3s5pq12+TsKwF
	proRemSxQbA9K727BqeKjvmbOmWt9m4AoCx11Bz9HKERDBe8PaETP4UbReovqy328fRrtJDULIq
	Delr8wUsDcT2A15R6BT+TghAEi3bruwR8Kaaeg/vnjX1iUYUNdbA0RFktaZsleH+spYAL7lh6rJ
	su5ARigO5sFhdIEqfxCZ5amqWz5/1rQ2S52yCF1l/9faiIskr4BmH6g+FP2fdUOLF3IQCaQ+uDn
	mxBN6jX+X9iZJob6GXRsnKVYTggLXLeaF3nqqdWPvw3UD6CalOJ7/Sl3Vo12TMcaGpFCMYce2uo
	8uanai8UB1qq+2X47XF81nheGNyIV/W52JwKiWTj8hHdqvWuiAOYvG+bJjio1PYFYVgU054ycX/
	a/3EuKSv5Vq7oztPllaVAyE4CHJg1Q=
X-Received: by 2002:a05:6214:4993:b0:89c:869e:4972 with SMTP id 6a1803df08f44-8b028471514mr93381016d6.10.1776524792131;
        Sat, 18 Apr 2026 08:06:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c44esm34256396d6.27.2026.04.18.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:06:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwrng: virtio: clamp device-reported used.len at copy_data()
Date: Sat, 18 Apr 2026 11:06:13 -0400
Message-ID: <20260418150613.3522589-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418000020.1847122-1-michael.bommarito@gmail.com>
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

random_recv_done() stores the device-reported used.len directly into
vi->data_avail.  copy_data() then indexes vi->data[] using
vi->data_idx (advanced by previous copy_data() calls) and issues a
memcpy() without re-validating either value against the posted
buffer size sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32
or 64).

A malicious or buggy virtio-rng backend can set used.len beyond
sizeof(vi->data), steering the memcpy() past the end of the inline
array into adjacent kmalloc-1k slab bytes.  hwrng_fillfn() mixes
those bytes into the guest RNG, and guest root can also observe
them directly via /dev/hwrng.

Concrete impact is inside the guest:

 - Memory-safety / hardening: any virtio-rng backend that
   over-reports used.len causes the driver to read past vi->data
   into unrelated slab contents.  hwrng_fillfn() is a kernel thread
   that runs as soon as the device is probed; no guest userspace
   interaction is required to first-trigger the OOB.

 - Cross-boundary leak (confidential-compute threat model): a
   malicious hypervisor cooperating with a malicious or compromised
   guest root userspace can use /dev/hwrng as a leak channel for
   guest-kernel heap data.  The host sets a large used.len, guest
   root reads /dev/hwrng, and the returned bytes contain guest
   kernel slab contents that were adjacent to vi->data.  In
   practice, confidential-compute guests (SEV-SNP, TDX) usually
   disable virtio-rng entirely, so this path is narrow, but the
   fix is still worth carrying because the underlying
   memory-safety bug contaminates the guest RNG on any host.

KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
virtio-rng backend has been patched to report used.len = 0x10000:

  BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
  Read of size 64 at addr ffff8880089c2220 by task hwrng/52
  Call Trace:
   __asan_memcpy
   virtio_read+0x394/0x5d0
   hwrng_fillfn+0xb2/0x470
   kthread
  Allocated by task 1:
   probe_common+0xa5/0x660
   virtio_dev_probe+0x549/0xbc0
  The buggy address belongs to the object at ffff8880089c2000
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 0 bytes to the right of
   allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened
usb9pfs_rx_complete() against unchecked device-reported length in
the USB 9p transport.

With the clamp at point of use and array_index_nospec() in place,
the same harness boots cleanly: copy_data() returns zero for the
bogus report, the device-supplied bytes after data_idx are
discarded, and the driver issues a fresh request.

Changes in v2 (per Michael S. Tsirkin review):
- move the bound check from random_recv_done() into copy_data(),
  so the clamp sits immediately next to the memcpy it protects
- clamp to sizeof(vi->data) rather than substituting len = 0, so a
  previously-working but buggy device that occasionally over-reports
  used.len does not start returning zero-length reads
- add array_index_nospec() on vi->data_idx to defeat a speculative
  out-of-bounds read given the malicious-backend threat model
- expand the commit message to describe the /dev/hwrng observation
  path and the hypervisor + guest-root cooperation scenario

Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Cc: stable@vger.kernel.org
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/char/hw_random/virtio-rng.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048..5e83ffa105e4 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -7,6 +7,7 @@
 #include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
+#include <linux/nospec.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
@@ -69,8 +70,26 @@ static void request_entropy(struct virtrng_info *vi)
 static unsigned int copy_data(struct virtrng_info *vi, void *buf,
 			      unsigned int size)
 {
-	size = min_t(unsigned int, size, vi->data_avail);
-	memcpy(buf, vi->data + vi->data_idx, size);
+	unsigned int idx, avail;
+
+	/*
+	 * vi->data_avail was set from the device-reported used.len and
+	 * vi->data_idx was advanced by previous copy_data() calls.  A
+	 * malicious or buggy virtio-rng backend can drive either past
+	 * sizeof(vi->data).  Clamp at point of use and harden the index
+	 * with array_index_nospec() so the memcpy() below cannot be
+	 * steered into adjacent slab memory, including under
+	 * speculation.
+	 */
+	avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
+	if (vi->data_idx >= avail) {
+		vi->data_avail = 0;
+		request_entropy(vi);
+		return 0;
+	}
+	size = min_t(unsigned int, size, avail - vi->data_idx);
+	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
+	memcpy(buf, vi->data + idx, size);
 	vi->data_idx += size;
 	vi->data_avail -= size;
 	if (vi->data_avail == 0)
-- 
2.53.0


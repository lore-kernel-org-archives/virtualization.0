Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419C33D6F8
	for <virtualization@lists.linux.dev>; Sun, 31 May 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237398; cv=none; b=WZu0keCBqlNFfUA0Feg+BVklWTvO8kPpS32HIUzELVnBfQHzDdwiZ1gQ/+uVFmP830NEhPEaoLrJAyHIxqtszoeKM2LUYn/IP01nMjW+XgAurp47su0m4XwPmljpYjHkok/tOW4jevgHTfBjBpSnzCYADnzik/XPBA44oOmfG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237398; c=relaxed/simple;
	bh=9z1lDO7WVRwOEqS8leOsAWQHA9GkNdjVjksm5OmCH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+Td78jVXh+NwknI2K4X99o1vrtPDh+BTjraXMt9uqUZ3TsgCuHwynVGbB8zccOIG4QQBVt6aMKesfhFfd+DYKOQ8p6BNQScgdXkwDT6yjuOy93cleNUzzCrIYywUWuL1uC8/gl0KZHINzFCQLCCdLMob2z4d8QHeX60OSwOsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THYq2tsx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THYq2tsx"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914c5898245so679356585a.1
        for <virtualization@lists.linux.dev>; Sun, 31 May 2026 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780237395; x=1780842195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDDIR+RflfCxQnybr+lZETyzlWzPcM4iBOlWecmvA2w=;
        b=THYq2tsxqcCWtYWf5sf+pElolhd/kgaFRkdGWpeFa8j5NQLYY1sC2MmwvAFklE9caZ
         hABkMRiUFGS4ZM5RpX4aza1Qb65yVEE+9f+FWD2xXgTb/LjWpAL3Q3Zfc0LCGmuFkvmG
         ORGn8PnB9qxZRRV39oEHvHFlZAEzEa+kA1NwEmtcOXaFzKSTui3EwvYJHnvUdi7wLDOz
         9ihoTx4FVJWKLY9d8mFq+vqO4hzahGu6eLUQdXQHtFJP0TRBKo+iHAdhbVXC93osdFHV
         17whAeKyeM2W4PYjGAb64YvCp/hLVNgV/0VsSu2zH3zhOs1grmnEezkZSaZVArWqmudc
         ey7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780237395; x=1780842195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDDIR+RflfCxQnybr+lZETyzlWzPcM4iBOlWecmvA2w=;
        b=dpNfc+q6M1NFJDujEG0Cb/YjaBiuNG0u5m0LkOQ9u5N0G/f7aA31pn5ssWg/sZ8Vv9
         g3/qIfuOqL6KwPHhLpum6wuCPO4vuM0t7nYjWFf/X9gaorXHbfBiOONebyX305KwE5Wp
         oPMTLQShX4D2EYLjHSOnP/1jijWG1Bemn3v2xXMuHo1Db2I8UtdxKkvMQKxtEHk4C0tH
         29xoWPvFjnr1LsJwNEJudnnYUlga+pq9CFmPz/Q+IsT1Ek8r7yF1/bK9SbXBmFnN6z74
         hsscEbmWVcO+7KoDpvA0i5oJbaEP3wqq2NETBMgLtKQ0tOH8tfXIbEtZoDoSR0z8Gojk
         p7dw==
X-Forwarded-Encrypted: i=1; AFNElJ/hgrtU+e1kbmWiHzoDkXDqBlh76GbVQsNpZ2fNX5rph2zV7+IXep0dlCu/Nlv109OlALErQgPWFBoNaIcICg==@lists.linux.dev
X-Gm-Message-State: AOJu0YynbN5unDqmh95CJCrvRfd7vFvHxwC/FFigYoUCHvbWAnPtho2D
	akBVqPztrLIlr+0w0TLrqvS1eiEWp2sl96o4eYGAt0apV/mc+xMm5Kex
X-Gm-Gg: Acq92OE6xVNUY5Wm2iL05KL0H63zqRqTJMXjH99xPdAYxQtM/I+qH4HphLhIFtWfwOn
	XLGSNEaGKsr7YSzgL3+HuN/n6OHLjXE/vdbaLJG2duh2zENKDI0ZArxcWJfHfkRyMZtVTSmpnze
	wIlFHbpO8/EmO7IgpQacGHZmdZhhI29QTn6Ei7+XGlv3+AitXoNc3x5+rjuceEOed0CEzGY/DER
	chSQQNGpgRP7wiL67M4luxrcfxFYjyfl3qDArRGfT8sRaLjIPcwObBTubiElBaxDYNevBdD7Pks
	xQK0yXDaOhTCWTUUkqWnQC4UrBzVefzkPQsEejj1ZpXc5aPSVFKqCwZdfB3otW+wsZJ38iZKZe0
	Dgi5tqlXT94qV7dDLDe66ddkXLnHlBlQ+Y1UNnDud5HOQ25BHUpuTaJrqumoK8hv+chAqLYRI8q
	oWatLVqZRScyxjPXDYIa3JVDgilF46DRJUlskJHvr/IKr5k3zhHmodV4iAcmbXFG8ZEZgirmkwT
	XnAMtTCMs5KxCF/z1XH02uBRfb0BZM=
X-Received: by 2002:a05:620a:c4d:b0:910:db3a:7bdb with SMTP id af79cd13be357-9153d9fa2c3mr1132560685a.32.1780237395122;
        Sun, 31 May 2026 07:23:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153249370csm769221285a.19.2026.05.31.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:23:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwrng: virtio: clamp device-reported used.len at copy_data()
Date: Sun, 31 May 2026 10:22:51 -0400
Message-ID: <20260531142251.2792061-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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

KASAN confirms the OOB on a 7.1-rc4 guest whose virtio-rng backend
has been patched to report used.len = 0x10000:

  BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
  Read of size 64 at addr ffff88800ae0ba20 by task hwrng/52
  Call Trace:
   __asan_memcpy+0x23/0x60
   virtio_read+0x394/0x5d0
   hwrng_fillfn+0xb2/0x470
   kthread+0x2cc/0x3a0
  Allocated by task 1:
   probe_common+0xa5/0x660
   virtio_dev_probe+0x549/0xbc0
  The buggy address belongs to the object at ffff88800ae0b800
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 0 bytes to the right of
   allocated 544-byte region [ffff88800ae0b800, ffff88800ae0ba20)

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened
usb9pfs_rx_complete() against unchecked device-reported length in
the USB 9p transport.

With the clamp at point of use and array_index_nospec() in place,
the same harness boots cleanly: copy_data() returns zero for the
bogus report, the device-supplied bytes after data_idx are
discarded, and the driver issues a fresh request.

Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Cc: stable@vger.kernel.org
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
Changes in v3:
- No functional change from v2.  Reposting the v2 clamp after the v2
  thread went quiet on linux-crypto.  Michael S. Tsirkin reconfirmed
  off-list that clamping the device-reported used.len at
  sizeof(vi->data) addresses his earlier concern, so this resends that
  fix unchanged.
- Rebased onto v7.1-rc4.  copy_data() is unchanged since 2023, so the
  clamp applies as-is, and the KASAN reproduction above was re-run on
  v7.1-rc4 (stock splats, patched boots clean).

Changes in v2 (Michael S. Tsirkin review):
- move the bound check from random_recv_done() into copy_data(), so the
  clamp sits immediately next to the memcpy() it protects.
- clamp to sizeof(vi->data) rather than substituting len = 0, so a
  previously-working but buggy device that occasionally over-reports
  used.len does not start returning zero-length reads.
- add array_index_nospec() on vi->data_idx to defeat a speculative
  out-of-bounds read given the malicious-backend threat model.
- expand the commit message with the /dev/hwrng observation path and
  the hypervisor plus guest-root cooperation scenario.

v1: https://lore.kernel.org/all/20260418000020.1847122-1-michael.bommarito@gmail.com/
v2: https://lore.kernel.org/all/20260418150613.3522589-1-michael.bommarito@gmail.com/

 drivers/char/hw_random/virtio-rng.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048e..5e83ffa105e41 100644
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

base-commit: a1f173eb51db0dc78536334729ef832c62d6c65a
-- 
2.53.0


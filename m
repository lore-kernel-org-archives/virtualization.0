Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CD30F7FA
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455222; cv=none; b=kpvMBlZR2ZTnkx9YIpabMkLbqi1InopZl1WMDCABpNB35uR1cuu12C5LjQ/VYy9yZruCoUR71Poy53h/Jq4MfrpvNNs9GUGhgn5w+ekNbeWmy69C6C4zA1Zqwe1D8z6G3kMNSBrHlhquuQY8gVUYqOXL2v0H1Jm1IpJ01c13cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455222; c=relaxed/simple;
	bh=Fl17u2X0k2HvhstQYApk5Vd2HHVjRBxN1PcydW4xlWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPq8/a5iKo5eGOBOSKU8Zu1raKWsQdDA+tbMfYB5TYcvQZ7mB45OqaJn3fWrHMCx9jR6iqscP6yoiIGhREML7sSoYA5IyDRMnKoG4D8r70Wtz0L4Nx2e9e5sjpmiXxnHBNOZZxD4G//BGR+Ruq3dekZF/JG8pwrd17eAIs2lnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhOjC+od; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhOjC+od"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157d3f2098so295119785a.3
        for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781455220; x=1782060020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBJHi5Hr1M/eo0hWqSi34rs7l71h5awOF/MLLNcZ4ic=;
        b=PhOjC+odt5xB/PbX4hLSaNTSetuHryiNbk+1ZUoplfIjcfL4dyw3DRhdJ5yIylJRoO
         dJbdL/75aRjqkuYgByjxp97RzS8oPabmTFdDh3vURDZPrC553niZL+qs+NU9xx5iao+u
         1j/HJxR2XK29QF8NqHApfb9J147eRg0nwZmDxqT4rI9DgX65d3XcQ3XHNXm0xYHxyP9h
         v7ZikN1PR9v5+PW0PljW5nrbRlhNVZrAgh+9lHFtSMthnPX1BIjNcQjXggUKl6oyC63u
         8us2TazfuVlT9oWEdjtZwRPb7LW2GNLp/Gm7xngXLO1lk3/3qX2nxUsv7vtOKgDHXpFM
         Hmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781455220; x=1782060020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBJHi5Hr1M/eo0hWqSi34rs7l71h5awOF/MLLNcZ4ic=;
        b=LY+BtDINMoeDA5lIaoIqh+D09bCs5y5DgMfzLWPAAgo4m2OjwojMSavS2lJePWGhde
         pJOeQQkaSVpZotAia9yF30+HC4TLPHcWQ2tra48pCbIwW4j8bMEMDL1Nu9b5f0Eftc8J
         Cle3RDbEHYOkahOfj7uwsfm80fSVMFedf77CZFs6DeuVkkEUfbqMDKKulHWl9c3GxlBD
         uW3Qt1UDiBWW/b31n+PJsSWh5uyak9b2qer1thfHI2/+Nc0c1SUOCYCiyviEsFqmt9uW
         vV7XdL7SjTxIs7A3i2//cwNSsQYNvcSZ0qFFCn/ZYL6nj71Chker9cwcLktlMNUszn+a
         Ffsw==
X-Forwarded-Encrypted: i=1; AFNElJ+mxkgbQQiK8RKCDPFSsc4hj6V7ljAJbt8B3e1rDLGLaWEHgj3I+5tfQZWOpLQOoh8blzVnjA9nu6xsxdhq3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVTAGKLsGJTKFOTOh/cLVyeiVplT3h3JLV9KCNtIDRWjn0Lwju
	abkUCxIakf5pyeNRn1snHybfrLN6AXeh3Y5bGaRbubHkV51rlBlxeoin
X-Gm-Gg: Acq92OE7QLm4FFONft0uMDIsuQdWGYz9vcIH9K5lLBLkLwrLJ36HstEgfCSBh9IXSgh
	SOyghlufsmcQaXQ5ejtZgwr2oE+uMdVHnWwP0af03aQDKinIBYYDWnA9lAaTYvq0ok7S9iSM/e3
	mTLA4q2SIpdP/5/C+U3Udl4SW17eV4SAIQIiV79W1O/CSyVDUr1zFFmyRiP1Z/gUDJs1WWA/Zax
	lNF0fPEEWvO8Jh2E/1YM7/99qqeAuZh5RdC53ryGNoM04pd0h2VKr0Jw7DqQG7C+xLsDN3vpgoX
	bYvK5U2g3EBvrGwyTlapZHONRO4r9Ag0kzOHWCTZlK8NVRfcdSK/sQg8AmORMDKdP8EXms8HxSO
	YO9Dj2W+zGAg6hLy0rvUzzdFN64yBT5sgjaAbEckQhmeIJxsih4vKKux49dAZPM01RDA9Dd/E3p
	2mY5aZf5Qq7eaQJGFCxN/1H22Vfdnhpea97vDPfxsD1T4P7Yk+P3ecpXV6+OoaQlt098XTUHZXk
	Sqo1OlRWq1WT0gdQ9pva3qU2OjHTixqx7oNGOialuY=
X-Received: by 2002:a05:620a:390c:b0:915:cf88:1e3b with SMTP id af79cd13be357-9161bf722a8mr1707654585a.47.1781455220006;
        Sun, 14 Jun 2026 09:40:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f1c851sm805290585a.16.2026.06.14.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:40:19 -0700 (PDT)
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
Subject: [PATCH v4] hwrng: virtio: clamp device-reported used.len at copy_data()
Date: Sun, 14 Jun 2026 12:40:00 -0400
Message-ID: <20260614164000.3343777-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

copy_data() trusts the device-reported used.len stored in vi->data_avail
and memcpy()s that many bytes out of the inline vi->data buffer without
bounding it against sizeof(vi->data) (SMP_CACHE_BYTES, typically 32 or
64).  A malicious or buggy virtio-rng backend can report a used.len past
the buffer and steer the memcpy() into adjacent slab memory;
hwrng_fillfn() then mixes those bytes into the guest RNG and guest root
can read them back via /dev/hwrng.  No guest userspace action is required
to first trigger the read.

Clamp data_avail to sizeof(vi->data) at point of use and bail if the
running index has already reached the clamped bound.  Same class as
commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport
layer").

Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Cc: stable@vger.kernel.org
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
KASAN on a v7.1-rc4 guest whose backend reports used.len = 0x10000:

  BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
  Read of size 64 at addr ffff88800ae0ba20 by task hwrng/52
   __asan_memcpy+0x23/0x60
   virtio_read+0x394/0x5d0
   hwrng_fillfn+0xb2/0x470
  located 0 bytes to the right of the 544-byte kmalloc-1k region.

With the clamp the same harness boots clean: copy_data() returns 0 for
the bogus report and the driver reissues the request.

Confidential-compute angle: a malicious hypervisor plus compromised guest
root could use /dev/hwrng as a guest-kernel heap leak channel, though
SEV-SNP/TDX guests usually disable virtio-rng.  The memory-safety fix is
worth carrying regardless.

Changes in v4:
- Drop array_index_nospec() on vi->data_idx (and linux/nospec.h) per
  Herbert Xu and Michael S. Tsirkin: data_idx is driver-maintained and
  already bounded by the check above, with no demonstrated speculation
  gadget.  Clamp unchanged; KASAN repro re-run (stock splats, patched
  clean).

Changes in v3: repost of v2 after the thread went quiet, rebased onto
v7.1-rc4.

Changes in v2 (Michael S. Tsirkin): move the check into copy_data() next
to the memcpy(); clamp to sizeof(vi->data) instead of forcing len = 0 so
an occasionally-over-reporting device does not start returning
zero-length reads.

v1: https://lore.kernel.org/all/20260418000020.1847122-1-michael.bommarito@gmail.com/
v2: https://lore.kernel.org/all/20260418150613.3522589-1-michael.bommarito@gmail.com/
v3: https://lore.kernel.org/all/20260531142251.2792061-1-michael.bommarito@gmail.com/
---
 drivers/char/hw_random/virtio-rng.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048e..7413d24a67a9d 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -69,7 +69,22 @@ static void request_entropy(struct virtrng_info *vi)
 static unsigned int copy_data(struct virtrng_info *vi, void *buf,
 			      unsigned int size)
 {
-	size = min_t(unsigned int, size, vi->data_avail);
+	unsigned int avail;
+
+	/*
+	 * vi->data_avail was set from the device-reported used.len and
+	 * vi->data_idx was advanced by previous copy_data() calls.  A
+	 * malicious or buggy virtio-rng backend can drive data_avail past
+	 * sizeof(vi->data), so clamp it at point of use before the memcpy()
+	 * below can be steered into adjacent slab memory.
+	 */
+	avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
+	if (vi->data_idx >= avail) {
+		vi->data_avail = 0;
+		request_entropy(vi);
+		return 0;
+	}
+	size = min_t(unsigned int, size, avail - vi->data_idx);
 	memcpy(buf, vi->data + vi->data_idx, size);
 	vi->data_idx += size;
 	vi->data_avail -= size;

base-commit: a1f173eb51db0dc78536334729ef832c62d6c65a
-- 
2.53.0


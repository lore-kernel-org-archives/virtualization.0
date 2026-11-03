Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699472;
	b=hfYM5rkO8zGGw1AEUFHUuo5dNIPM/ek0tFGX4nkGsMH1LnGHtI2SscfCfi3uw8FTfvMz
	 gA1Qmt2/H6mGlmZa1pR8ii7l30IRb227UH2xwHeOU9/NDzn5SEzmkc/lYJzx1WqGOBgwx
	 9o1cAw6UBJ7/60R4h/T9RvUno6jDJ8TxHK8FJxdwhe4adNbrBaJUltzXQqdBxWpTnppgl
	 ksWDHmG7DHQWUvpqIwJ41uphvh9CSgoO0DYzJXtdzr3zRx8IFPQU7blQ1OdvRenNHL4K+
	 5sE8PZynwq+Gcjcc3by3H8ETjSkSd4ohHOQ9lReIRRFRhX2q58RMdCFpKvzglUsixug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699472;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HxMHbHcW0bcCswFq9k6faxMAZ4OoY4XSKBUYGTUqi5I=;
	b=FFmixaWG/TprV6/k3IMDZrPQebWYHAfA/V43RksHrMIBcj3GIuQBgcRlC408T63TrlEC
	 IhtliTFIBzsK/zznAJfRhqE2ASl5jj967IAs0QHO04ck1n6QjNRpvFm9PD+nQnvyyhJKf
	 L99jPGg4oroWZIp/Kaw/wTs/gpjBJEm96UJIDqM2WKyctiWRqM9XmIhsYtQy2oobao6vJ
	 MWclFtw0no44ssk5vCAFAJAsdoaX0x9ML3Uo+YtXb0Kjs7YeBmQNagZs1YLqeFZkmg9IR
	 uPX/Iy5beY0OQF8+sVD37fAfAu0cuOxPMRnTU3nXfp57vepX0f+RDRU9FSca6MGQ3VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=karaolidis.com;
	spf=pass smtp.mailfrom=karaolidis.com;
	dkim=pass header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=eunwfoT8;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72B606EEB5
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E72B606EEB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=eunwfoT8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1793699469; x=1793958669;
	bh=HxMHbHcW0bcCswFq9k6faxMAZ4OoY4XSKBUYGTUqi5I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eunwfoT8ZlTWcs007nWnsW8Oeh/g4tEbRRD2T4dNh8mWyi2aQO6YA/vgKlXVU1PM6
	 +hqOAII1KuJ1jCtohrrD5RKvuS1B0dosYXEog8p7EVT2CMIk1ur29lR3NytoUpNthy
	 J0Or103AMhcWftJw8rQscbghBnKYCL9pDaq2DkZeQ6ILXE/sVgQXlTNpyp7+LdWLoN
	 Uu/hpJm84SuMSzopzxghFnTBsGdfpCH4Y5yLSDpRqF+WD5sID6UBWShwHOVG4gtYEY
	 lsbfQd32UcyGlLp4R4bazHIfZsarLOrfV0sDpgc00b5PqysggJn22/hUl5enuDMQGX
	 BLGs99EQeBY6w==
X-Pm-Submission-Id: 4jJkNW1X87z2Scj6
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Tue, 03 Nov 2026 09:50:12 +0000
Subject: [PATCH RFC 6/6] Documentation/admin-guide/mm: document virtio-mem
 memmap_on_memory
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-virtio-mem-memmap-v1-6-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
To: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
 Hui Zhu <teawater@gmail.com>, 
 Georgi Djakov <georgi.djakov@oss.qualcomm.com>, 
 virtualization@lists.linux.dev, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Nikolaos Karaolidis <nick@karaolidis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2275; i=nick@karaolidis.com;
 h=from:subject:message-id; bh=9Fmh5NuyL8RhhgKP+TzDpDGr/90k+nu1z+yyKGLv62E=;
 b=owJ4nAFtApL9kA0DAAoB2mjImL9M9YgByyZiAGrprniVRbgFszd+tPH1XcKsBEFpdpjWocrOP
 chMaIO9Ut5PsYkCMwQAAQoAHRYhBLMZG7EWqsMYjymWX9poyJi/TPWIBQJq6a54AAoJENpoyJi/
 TPWIJRkP/1HyOCbdgqUgCgsDOEG0drBO5bgCHQOZFrl1Iu57GRvZWBy88fgRkacVoxcrRFGASrU
 xqIlqUVcmDamlsgH0IJTTHFqf3uBOBNe8l2Qu6KOW+r+c4GkquCdV/q+NJNYmQXCdeBCHtjFGM7
 z8RBCHWdGFsQlIBTE/qP5NBdT5mImNKrEPg94g9w+aHAY8szKVpCvEh7GXnB29bTK+cVS9liF2o
 xaWiT/m/tVdN7bJFNCIHTyY2yWr3iR++p/QcD/skVPXBkvx0ZaicZnu2YuaC43kgVl6ZpSTTVck
 42vENRHxgj4lDpz6sfRunj1XLXIZfYZ+PC6cE0mMCaBodfydU8qLnFFvc59+qUr66hGbH+YZLYm
 //de+riD0roZ2p46aJUvbqMcq9rToblaAKPQFFNm0aPsmtutuOxJ2DLf3xYuYZswySJR7X4KF8u
 DffHhhhBr4Gn4lTmkvkD3gvvvRwoO31Sx/F0rnaVczRU/vLXTex0UKe8tTN+WD2EHcqGfaO4HYg
 LQnEsc8y6A3fy41641Wka9eV0PxKH4C82huYoxI4C9AcA2MuOX18Fyh0ZsaidMLGv2tLMz9pqLf
 en7FdPfXT1WQ1q6LJbtcpV0XocD4kyM2d7K6qAysfLrVfXVNl5tgYfVeB1gUybibhA+sfcW3gwg
 VIVwiCo656C7OBys4+zksFg==
X-Developer-Key: i=nick@karaolidis.com; a=openpgp;
 fpr=B3191BB116AAC3188F29965FDA68C898BF4CF588

Document that virtio-mem only uses memory_hotplug.memmap_on_memory with
virtio_mem.memmap_on_memory=1.

Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0207f8725142..b0f895766fb5 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -454,6 +454,10 @@ The following module parameters are currently defined:
 				 architecture does not support the forced mode
 				 in all configurations.
 
+				 virtio-mem additionally requires
+				 ``virtio_mem.memmap_on_memory=1``. See
+				 `ZONE_MOVABLE Sizing Considerations`_.
+
 ``online_policy``		 read-write: Set the basic policy used for
 				 automatic zone selection when onlining memory
 				 blocks without specifying a target zone.
@@ -628,6 +632,20 @@ ZONE_MOVABLE, especially when fine-tuning zone ratios:
 - In certain DAX configurations the memory map for the device memory will be
   allocated from the kernel zones.
 
+- The memory map of hotplugged memory is allocated from the kernel zones,
+  unless ``memory_hotplug.memmap_on_memory`` is used (for virtio-mem, together
+  with ``virtio_mem.memmap_on_memory=1``).
+
+  With virtio-mem in Sub Block Mode, the subblocks containing the memory map of
+  a memory block stay plugged until the memory block is removed. They count
+  towards the plugged size of the device but are not available to Linux:
+  plugging 128 MiB into an empty 128 MiB memory block makes 126 MiB available.
+  The plugged size can stay below the requested size by up to these subblocks
+  of one memory block. Sub Block Mode only uses the self-hosted memory map if
+  it spans complete subblocks, for example with 128 MiB memory blocks and a
+  2 MiB device block size; otherwise, virtio-mem continues without it.
+  ``virtio_mem.force_bbm=1`` can be used instead.
+
 - KASAN can have a significant memory overhead, for example, consuming 1/8th of
   the total system memory size as (unmovable) tracking metadata.
 

-- 
2.55.0


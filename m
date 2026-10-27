Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069812;
	b=LiTEefrAk+Y+vVMe7eJuZz6bKf8ZduJrBkStaHXMHWyn/pF5vskvpVJpmPvtehfyAmbh
	 ueH8r6Cq368GFlp1We71OzsHAVg10bp2n6Nu7qavcIsRXpQjQi86lqNlPlP/fJqgbc7Gy
	 oSgiMxymraNtuo2Lf+STJKbP5Kg/qD3dCTF95hfzN8+4g9XPPs28au6ac+hu15DKo9fPD
	 elVJ6/UYoqHjVDBXXVrcnO5aM9SosA6NbUu3aBkK1TKvCNQlMR+DlxAR15xLYxJZue8fm
	 swBEcaPGXa7WX75sHAyEn3UbVUZnC1/blREwC3oKMrKmhw2gPezwlMDd6IPkMg7M8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=n7o+pR7kIh2/FhhUqUS8VpzKzJ7DErIKQHWtYktZq/o=;
	b=tGjx61p6ieF5ABjjqZek1yrebkS2Ok8OfyUds3dwD7gELvCi0z+FPA0SNKLrF3myLiSl
	 Is7sP2t8ZFHkhzOGlgEPPmG64I6yvv/QXzjHNgi69m0gqkdmqLCN1lan+0YmMlJN6TVVv
	 29nSfq0JTcH08w6y9+HtxjPp3hlBWNHxj6pn90QbfDWB2gWvqtzmdd6ZncLR6hn4McLiL
	 YRO+Quljuth8I1CQY17N4eyKaOn2f1INTPJqduhtxw0JxZyhqS57En/UAx+URQx40hb2o
	 rKHgI43QlBilOJTb3Vd1lgx4IS0LBtlErpYjrPlFOuWgmhrji8aFlnirI0pOD88P9dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3PXg+kf;
	arc=none smtp.remote-ip=209.85.161.72
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C229606A331
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C229606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B3PXg+kf
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-703a37d970eso5005034eaf.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069810; x=1793674610; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7o+pR7kIh2/FhhUqUS8VpzKzJ7DErIKQHWtYktZq/o=;
        b=B3PXg+kf/MebL99B+gc4SnFN1kfKicuvsmBALy7oNwV00FYLpKOVRGvqYYfHzdKAdx
         BlOkbDNk+yDfRbQFULDvAbvcX8uXtIeLQuqkRiVYyjWG7vkqR500VZs2Oat2U0rlBeIh
         XkCXBMYcxNxtOJS/V76U2lzNIo+QMAK4e1GjfwSUeY1btLfyYKw3w/in1EpooWSLewsn
         1kjmtEnN2mceZ6hRRXiXfrTiWdfx95CkmSsVdP0Wtx3yTn8TdcdFocy7GIUH0ZSpa92E
         UTtK9c3ssO6XS6AY6kJaC8gE7xwaV2OAG4QsmdI53yz8tCiUbxMg5DMbwc9BLqkjDwRd
         I+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069810; x=1793674610;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7o+pR7kIh2/FhhUqUS8VpzKzJ7DErIKQHWtYktZq/o=;
        b=SAb2FRkUqVi5tvvQY+sZAEj6DK/1kz6s+xRBUCvRO40H487Q0cN/6XUCPAoHP4tlJZ
         xUGx145hJqdcWeY04mrJxI7TvZIFMKygKkQjWNnE3LcDFGqY7vbOOKLxP02ANZM5RcD9
         U+XhKdB/CgjQaWcBNAT1GSskl2a+kvnJ8uhGTa7ye9Fvg1hH58XMlry6S2YIpV4csCIv
         kCW4DFnqrrOM7z0zwbK2nrhrWA9aeZi1ju1NFhU/zLCctvo3wsjPlBn1N6BnGXlNn5Ya
         0NK6QJRI2O65km9Yk57tYC2B9WI/A3/wQ35Od6snmtJ0IaLdzHfafjGJKjrEw5n4C8cC
         2pNg==
X-Gm-Message-State: AFq9FYI1esDWLv5jKf97uML1oWlB4Li1D02qbgJT3YiYpUV0/yMrArlS
	sPvrb1PTkf4FrTsGUhLBIXgBnhjYMTcVeCSY8q45+/lYTsRz8ZBYvAOpV8JyCv9nuIsWt91m2vm
	MvbVKgDuJesuQslEocsl+j7d22MlzW64t0w==
X-Received: from ilbdx1-n2.prod.google.com ([2002:a05:6e02:4201:20b0:51a:af50:87cd])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:5601:b0:6c3:19de:d1ef with SMTP id 006d021491bc7-70ba0da3184mr2895148eaf.20.1793069810059;
 Mon, 26 Oct 2026 19:56:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:09 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-7-kevinloughlin@google.com>
Subject: [PATCH 06/13] efi/unaccepted: add mark_memory_unaccepted()
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce mark_memory_unaccepted() to mark a physical memory range as
unaccepted in the EFI unaccepted memory bitmap. Use
unaccepted_memory_order() to query the page order matching the EFI
unaccepted memory unit_size granularity.

Synchronize mark_memory_unaccepted() with concurrent accept_memory()
callers via accepting_list and only invoke arch_unaccept_memory() on
sub-ranges that are currently marked accepted in the bitmap.

On platforms with dynamic unacceptance (arch_has_unaccept_memory()),
load_unaligned_zeropad() across page boundaries is recovered via
EX_TYPE_ZEROPAD exception fixup. Thus, skip extending accept_memory()
and range_contains_unaccepted_memory() by an extra unit_size guard
block to avoid corrupting the acceptance state of adjacent 2MB blocks.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/firmware/efi/unaccepted_memory.c | 107 ++++++++++++++++++++++-
 include/linux/mm.h                       |  12 +++
 2 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 4a8ec8d6a571..128bc1b113cd 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 #include <linux/crash_dump.h>
 #include <linux/nmi.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap and accepting_list */
@@ -86,7 +88,16 @@ void accept_memory(phys_addr_t start, unsigned long size)
 	 *    if 'size+end' is aligned on a unit_size boundary. (immediately
 	 *    following this comment)
 	 */
-	if (!(end % unit_size))
+	/*
+	 * On platforms without implemented dynamic unacceptance support,
+	 * load_unaligned_zeropad() across a page boundary into unaccepted
+	 * memory causes a fatal VMM exit rather than a recoverable exception.
+	 * When dynamic unacceptance is supported (arch_has_unaccept_memory()),
+	 * load_unaligned_zeropad() is recovered via EX_TYPE_ZEROPAD exception
+	 * fixup, whereas extending the range by unit_size would accept
+	 * adjacent dynamically-unaccepted blocks.
+	 */
+	if (!arch_has_unaccept_memory() && !(end % unit_size))
 		end += unit_size;
 
 	/* Make sure not to overrun the bitmap */
@@ -191,10 +202,11 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 	end -= unaccepted->phys_base;
 
 	/*
-	 * Also consider the unaccepted state of the *next* page. See fix #1 in
-	 * the comment on load_unaligned_zeropad() in accept_memory().
+	 * Also consider the unaccepted state of the *next* page on platforms
+	 * without implemented dynamic unacceptance support. See fix #1 in the
+	 * comment on load_unaligned_zeropad() in accept_memory().
 	 */
-	if (!(end % unit_size))
+	if (!arch_has_unaccept_memory() && !(end % unit_size))
 		end += unit_size;
 
 	/* Make sure not to overrun the bitmap */
@@ -215,6 +227,93 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
 	return ret;
 }
 
+unsigned int unaccepted_memory_order(void)
+{
+	struct efi_unaccepted_memory *unaccepted = efi_get_unaccepted_table();
+
+	if (unaccepted && unaccepted->unit_size >= PAGE_SIZE)
+		return ilog2(unaccepted->unit_size >> PAGE_SHIFT);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unaccepted_memory_order);
+
+int mark_memory_unaccepted(phys_addr_t start, unsigned long size)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, range_end;
+	struct accept_range range, *entry;
+	phys_addr_t end = start + size;
+	unsigned long flags;
+	u64 unit_size;
+
+	if (!arch_has_unaccept_memory())
+		return -EOPNOTSUPP;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return -EOPNOTSUPP;
+
+	unit_size = unaccepted->unit_size;
+	if (WARN_ON_ONCE(!IS_ALIGNED(start, unit_size) ||
+			 !IS_ALIGNED(size, unit_size)))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(start < unaccepted->phys_base || end <= start))
+		return -ERANGE;
+
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (WARN_ON_ONCE(end > unaccepted->size * unit_size * BITS_PER_BYTE))
+		return -ERANGE;
+
+	range.start = start / unit_size;
+	range.end = end / unit_size;
+retry:
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+
+	list_for_each_entry(entry, &accepting_list, list) {
+		if (entry->end <= range.start)
+			continue;
+		if (entry->start >= range.end)
+			continue;
+
+		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+		goto retry;
+	}
+
+	list_add(&range.list, &accepting_list);
+
+	range_start = range.start;
+	for_each_clear_bitrange_from(range_start, range_end,
+				     unaccepted->bitmap, range.end) {
+		unsigned long phys_start, phys_end;
+		unsigned long len = range_end - range_start;
+
+		phys_start = range_start * unit_size + unaccepted->phys_base;
+		phys_end = range_end * unit_size + unaccepted->phys_base;
+
+		bitmap_set(unaccepted->bitmap, range_start, len);
+		spin_unlock(&unaccepted_memory_lock);
+
+		debug_pagealloc_map_pages(pfn_to_page(PHYS_PFN(phys_start)),
+					  (phys_end - phys_start) >> PAGE_SHIFT);
+		arch_unaccept_memory(phys_start, phys_end);
+
+		spin_lock(&unaccepted_memory_lock);
+	}
+
+	list_del(&range.list);
+
+	touch_softlockup_watchdog();
+
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mark_memory_unaccepted);
+
 #ifdef CONFIG_PROC_VMCORE
 static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 						unsigned long pfn)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6882ad400935..27bb40651c85 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5362,6 +5362,8 @@ int set_anon_vma_name(unsigned long addr, unsigned long size,
 
 bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
 void accept_memory(phys_addr_t start, unsigned long size);
+unsigned int unaccepted_memory_order(void);
+int mark_memory_unaccepted(phys_addr_t start, unsigned long size);
 
 #else
 
@@ -5375,6 +5377,16 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
+static inline unsigned int unaccepted_memory_order(void)
+{
+	return 0;
+}
+
+static inline int mark_memory_unaccepted(phys_addr_t start, unsigned long size)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
-- 
2.56.0.307.g5fe7bd680c-goog


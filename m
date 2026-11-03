Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699466;
	b=qQdg6z1ves77vAQDJFu9nnw0te+lSZ1RZ0M9e6XDggCtbThAwvbi/sfAfZJJERnUu2Vo
	 P3Th8XAi+q8OZKAjCTq1Dj58d/6R3/TtUJUYpCgCQsOl/xJQRpuJiN1Ub3AhLquWypeiW
	 l/aGK73FvuWYqEwuqD4VtZNSCd9PjRXtqO1vckkRPW0RhATKNj93UqR8/bwDa+TV/aO8i
	 LJY9jrosGbmQ+j6OOagcgwr0Hi2dBVH7kf7ViThcwjVQnNvHokjS38Oov2Mh2SZ/TfdtO
	 l8kT07wXBRNeU1zHbhcsB+B2edKyT2q3WEoRH4nUtBdqeUeLj8jji4/Vg/gLFPzSj7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699466;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OBdI6sTn5K4OgfmCVF/8zIHq3UrF3Zy+wUPm5MAIdzg=;
	b=g/5ZtUwf78GOTCvujgzHrkSi8OSo1WBxmmoogk6KYvzODyCemmzhvZgNirbQuS2SUCBV
	 KvTdRNIEOzyIQ5cFeEPVv6U0P1xvm2RlFtUDUFjlSWa9sOsvYumpsWTTnz1BGyTroBOoK
	 tOY/AKW7kapjbrWbKczrBldIMqTmkpwAex31PoPQ75ULEZr+eg7lCyQkFVGK7YIx9MKfp
	 rBDxV5GcOxU9seR3KdoyIP5jTiMLHOk86VXH11dxwZg+UqXJz8AgCjx42s0bcyQhScurT
	 DLfYTfqTqdYhiJWDRGoS0rn1JZQDHyRO+y0HvUm4XdTjElk8mtGQMvgzowB/2qK41pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=karaolidis.com;
	spf=pass smtp.mailfrom=karaolidis.com;
	dkim=pass header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=RTFB8Kme;
	arc=none smtp.remote-ip=109.224.244.106
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190FF606A32C
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190FF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=RTFB8Kme
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1793699458; x=1793958658;
	bh=OBdI6sTn5K4OgfmCVF/8zIHq3UrF3Zy+wUPm5MAIdzg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RTFB8KmexjksUk20HrjmyS1e1SwZL4VvFQR020kdzu5KmKV6ahtxVkSu6cytKVo3x
	 wRpNDXXhsjvXTbd/nIBNQp2KB5cwMzGj5pTLY7I4BCvzXbr0v6MzcNQFxB0AOH7Q9b
	 +YFtelNTADrcMBdsyiVS4Xhu3EVuhBjIRxy3SgdB2jcemj8nDtMtH3wMvw+myjiW5Z
	 8aqIhC1E6on7pT0iKPKld7GIqpjJN29HtvfKtrrwZjF0MBHOT3hjZ66PCDNK/o9ADl
	 H8jwHr7GGELk238IfaWXQly2UROvFAi4GfzSVrfyN631PN2v37vvS73oiFI6thOwCO
	 4/b/lg+nNCynw==
X-Pm-Submission-Id: 4jJkNH0h9pz2ScjC
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Tue, 03 Nov 2026 09:50:08 +0000
Subject: [PATCH RFC 2/6] virtio-mem: prepare memory notifier for a
 self-hosted memmap
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
Message-Id: <20261103-virtio-mem-memmap-v1-2-308ae1da6240@karaolidis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=nick@karaolidis.com;
 h=from:subject:message-id; bh=TO2CmbxVRk5IIxBT/zUC8sOXtYzHOqzh3B7e5x1oZ0Y=;
 b=owJ4nAFtApL9kA0DAAoB2mjImL9M9YgByyZiAGrprnfulwaXR03O2p0qJDHLazzry3QLpv4Ia
 U4y+Pitk66ahYkCMwQAAQoAHRYhBLMZG7EWqsMYjymWX9poyJi/TPWIBQJq6a53AAoJENpoyJi/
 TPWIRpEQALF1yuzhT+G9+r/UaOZj+ncGcwkxjmTohjHCy77NkVXvj4vAzd3+Y7HPpD2AaqYkchw
 g15fGpkaHJGslMRxczn5mCczJOj6EjzsmThGmSQNIk++5GLtopumrnPrtR3WHpP/cIQv35P3oGn
 Q0KOw8IVZ3XR7yZDMt3MXy9ONcuAkYT8HIpl490imwmZvW6zvJTNGLwU4ebtqqLE6PrXqHPnmas
 VRIi/bwtPAvPxOXNLum18q3ixX7KFlV0bJV5bHH6mB/+71kOhV6SKo06ocN1yeScE2suNdDYpwX
 SKvLtTNE3kWGQA/0ckSj7t5y5WyYE//WoBOs24j89Z9Pm2vWhDSPVOF3T7P8UTr8W6/sHigPrwc
 mk6nHWBcxitvRp1l8NTFG3EiTkjpnq4o8rpR6pg3OZ8U7IyWO7CW7l2/4XGGk9uFS4mmtC1wkc0
 vhrbjxLwJDC6bpZYXyNWj7skLCJmDiL/23MuL4kuE0dg98x66IqZc6UsF3D9CYA+koiBhn4zxmc
 +XPIJi/WBmAEJkYlVZLhV6cbiD8u1wrsPtJs6akIbjv1m9AI44vz5z8hGv/+fln34JqsolDmubH
 4IkZb6zcMvg/0h3gA5bLrj7B6G1kYyOO1+66BPyM4FNFIr7k9tKI6b4wvIbaI0Eyj5zrpfRVXOK
 L3rqdJjtcLV0CIEJzyBs8FA==
X-Developer-Key: i=nick@karaolidis.com; a=openpgp;
 fpr=B3191BB116AAC3188F29965FDA68C898BF4CF588

With MHP_MEMMAP_ON_MEMORY, the core excludes the memmap at the start of
each memory block from the range passed to memory notifiers. The
virtio-mem notifier does not expect that:

* In Sub Block Mode, it rejects any range that is not exactly one
  aligned memory block with a WARN and NOTIFY_BAD.

* It adjusts offline_size by the notified size, while adding and
  removing memory use the full size. Every onlined memory block would
  leave its memmap size behind in offline_size, until the offline
  threshold stops further hotplug.

Track the memmap pages per memory block in vm->memmap_pages, expect the
notified range to start after the memmap in Sub Block Mode, and include
the memmap when adjusting offline_size.

vm->memmap_pages is always 0 for now, so there is no functional change.

Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---
 drivers/virtio/virtio_mem.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e18dd736f2ec..ab06adbc0342 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -158,6 +158,9 @@ struct virtio_mem {
 	/* If set, the driver is in SBM, otherwise in BBM. */
 	bool in_sbm;
 
+	/* Pages at the start of each Linux memory block hosting its memmap. */
+	unsigned long memmap_pages;
+
 	union {
 		struct {
 			/* Id of the first memory block of this device. */
@@ -995,21 +998,23 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	struct memory_notify *mhp = arg;
 	const unsigned long start = PFN_PHYS(mhp->start_pfn);
 	const unsigned long size = PFN_PHYS(mhp->nr_pages);
+	const unsigned long memmap_size = PFN_PHYS(vm->memmap_pages);
 	int rc = NOTIFY_OK;
-	unsigned long id;
+	unsigned long id, mb_start;
 
 	if (!virtio_mem_overlaps_range(vm, start, size))
 		return NOTIFY_DONE;
 
 	if (vm->in_sbm) {
 		id = virtio_mem_phys_to_mb_id(start);
+		mb_start = virtio_mem_mb_id_to_phys(id);
 		/*
 		 * In SBM, we add memory in separate memory blocks - we expect
-		 * it to be onlined/offlined in the same granularity. Bail out
-		 * if this ever changes.
+		 * it to be onlined/offlined in the same granularity, excluding
+		 * a self-hosted memmap. Bail out if this ever changes.
 		 */
-		if (WARN_ON_ONCE(size != memory_block_size_bytes() ||
-				 !IS_ALIGNED(start, memory_block_size_bytes())))
+		if (WARN_ON_ONCE(start != mb_start + memmap_size ||
+				 size != memory_block_size_bytes() - memmap_size))
 			return NOTIFY_BAD;
 	} else {
 		id = virtio_mem_phys_to_bb_id(vm, start);
@@ -1062,7 +1067,8 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		if (vm->in_sbm)
 			virtio_mem_sbm_notify_offline(vm, id);
 
-		atomic64_add(size, &vm->offline_size);
+		/* Adding/removing memory accounts the memmap as well. */
+		atomic64_add(size + memmap_size, &vm->offline_size);
 		/*
 		 * Trigger the workqueue. Now that we have some offline memory,
 		 * maybe we can handle pending unplug requests.
@@ -1077,7 +1083,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		if (vm->in_sbm)
 			virtio_mem_sbm_notify_online(vm, id, mhp->start_pfn);
 
-		atomic64_sub(size, &vm->offline_size);
+		atomic64_sub(size + memmap_size, &vm->offline_size);
 		/*
 		 * Start adding more memory once we onlined half of our
 		 * threshold. Don't trigger if it's possibly due to our action

-- 
2.55.0


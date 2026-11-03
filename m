Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699466;
	b=C6gL/mtJwBpKfg0f4nlxxQUG9D7EQa/GXO7lW5YWyJIxuKUGIVajwMJyjFT2r0eSIGPp
	 5BNMVNo/b59MzaiAOIX2hCNj2BIIKh/j3agT1dwwRyCY68E+k26hw4CcPgKi+UkjAOfYw
	 6mDlQhrhMTCIjqVrbALVxRAQWgPQI21SJfUXHyhEPdnLe64jzYiao++6ClzO9E8vY/i7V
	 HrXrmMQFTbtZGXF7Hh/PfLmdEBd7demugd5aKbC8nENchZ+6/KGivRHEYeozw2997OGMT
	 1//u2KLRAS996xv4V1Z/R86YcsUHGTHNNYvANxyz8NNMalkO78W4xJW7DwsknNuPzVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699466;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=M8mDAdHjens4fLiFQccbP/0Y8oUck8pzo9WB/WyQJwc=;
	b=UfPI4OCjU3Ota0/vrU5wk94hfsQjXBnedIku9IhfVp8xi8YHu1ofVrlWXnuGL2saRDnq
	 f+TsVH1MJbSRi/dW9SYd7ZDck8DBLc0UdMKq/p74Xlc/G8u0V+hG0zvy9ExPRwFexD0qi
	 ddDrXixdJN04xWUG9GCzgRAlVTJ6107bgRPFsxKMD+Mx+pJX0UGjH5mAHfsvGmMF5MF6b
	 CnmKvOYI2Xgpgp7ho8lkIpS4AmKXkQa6wQa+M5Dfo2UnkjmwJso2XdgEUZcTjuuU1BNBo
	 QK/QCEHttPR/AkHbgZJhVqWJZU7wDw5GePRJYhOPwouGT5wgCOSkngXPgKunmVldJuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=karaolidis.com;
	spf=pass smtp.mailfrom=karaolidis.com;
	dkim=pass header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=A4zWXGhK;
	arc=none smtp.remote-ip=79.135.106.111
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A10606D827
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A10606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=A4zWXGhK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1793699463; x=1793958663;
	bh=M8mDAdHjens4fLiFQccbP/0Y8oUck8pzo9WB/WyQJwc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A4zWXGhK7fPCcUFId0bIyVWNAGFLf+Tih0RWhej2GZkoqyDUuQfIiwemw0pszZyZZ
	 Zcxc8PKz56Bd8UtbPB8jkRIV+zkh5rwH7+xkqsUbNBAt+Um5qKVwTbm/KMdshxckN1
	 ZPAVdHU1DpVGH160Cgru0oQ10RNv3Fbjx0HDb63eh8P5gp8hWBXNuldGznBzPD3t7L
	 XDTv//gMM69uPD6Xa5Zh8Yt4fd1ijYHGv9O+4qzHiwee0raLEEOhsZq3I2H/7OD8lJ
	 k7H5qcdMfxoaXT28AyLpWhpmXBwzSXom6rN2DwW7PZPAM6pye1HXqgCzXmQVyVRf7Q
	 YmVfPaYiv0qgA==
X-Pm-Submission-Id: 4jJkNP0KKSz2Scj6
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Tue, 03 Nov 2026 09:50:10 +0000
Subject: [PATCH RFC 4/6] virtio-mem: move
 virtio_mem_sbm_try_remove_unplugged_mb()
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
Message-Id: <20261103-virtio-mem-memmap-v1-4-308ae1da6240@karaolidis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=nick@karaolidis.com;
 h=from:subject:message-id; bh=GU2oa106EeH8dI11q71ORgUyNnPj2av4Aihez49DNQA=;
 b=owJ4nAFtApL9kA0DAAoB2mjImL9M9YgByyZiAGrprnc/6ByFXuJChDmSsarYLCIu+Kp2XDzMr
 lxN1joAcbphnIkCMwQAAQoAHRYhBLMZG7EWqsMYjymWX9poyJi/TPWIBQJq6a53AAoJENpoyJi/
 TPWIE70QAJpnT8Qz/qvNyHuWszstgMQamGr6va87wXLS5+gKnCmAPou+fN30tKYLqRR2nIBnCjj
 UvgMXUQ26+Fw7jcr4PimEuozX7cwly8ZTdQ60ngPI8XMV0xbN26ayd5jaRAd1pBLmtrgbS6BM/7
 OzLC2uu5Fw9OKG3dsj7TZrbMSOQlDP3qjKf7V7G7AbkzzJgKYeA0Q+B83ucwqqw2xKDGNNezQ67
 PS0jcdzFs0MQji/X95qL8FCw29Nhh3Qz9iRtc2TN9MZEWhoJPIyJcV8cCX0HIfU1ayqAtfRMiMz
 d/hCH4Q7u7dVciFK+xygmO7gIyleSLzTYBFk7J1EUsVdfHpQ0AEwgcjOgNPYYP3gqfV7CNn+YbK
 dxX7JkcX3zmXKAsgi9zPP223qfmr0uYYolNGWwwHARzT5G62hzvWy2sgJMpsGvDkr8NQhuc0W5Q
 ZqlqqCJd87kgps7a+LiQbZhSEnF3IQXqrAAysaSM+sZLTRqsbVl3+QaOfc9VXiBxJmocUiwBX7y
 idjtWa//M8BQPQPaLOXtAW14WkewCxDVmYiWKsgAbiahwW8ZKJhVEHhZGL1xdYVryS8F/kqDCrP
 btORLY9AX8HlX9mEmngfA2Xsmq27lX9n/aQ5RQTpeALH4NRikRPsZgVPYnRHm1wMvNBiQsAtQJ9
 r96NGUpvLFPWNVTg86m4x2g==
X-Developer-Key: i=nick@karaolidis.com; a=openpgp;
 fpr=B3191BB116AAC3188F29965FDA68C898BF4CF588

Move it below virtio_mem_sbm_unplug_mb(), because the next patch makes
it call virtio_mem_sbm_unplug_sb().

No functional change.

Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---
 drivers/virtio/virtio_mem.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 034d07207e44..688c178c760f 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -791,34 +791,6 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
 }
 
-/*
- * Try (offlining and) removing memory from Linux in case all subblocks are
- * unplugged. Can be called on online and offline memory blocks.
- *
- * May modify the state of memory blocks in virtio-mem.
- */
-static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
-						  unsigned long mb_id)
-{
-	int rc;
-
-	/*
-	 * Once all subblocks of a memory block were unplugged, offline and
-	 * remove it.
-	 */
-	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
-		return 0;
-
-	/* offline_and_remove_memory() works for online and offline memory. */
-	mutex_unlock(&vm->hotplug_mutex);
-	rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
-	mutex_lock(&vm->hotplug_mutex);
-	if (!rc)
-		virtio_mem_sbm_set_mb_state(vm, mb_id,
-					    VIRTIO_MEM_SBM_MB_UNUSED);
-	return rc;
-}
-
 /*
  * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
  * all Linux memory blocks covered by the big block.
@@ -1648,6 +1620,34 @@ static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 	return virtio_mem_sbm_unplug_any_sb_raw(vm, mb_id, &nb_sb);
 }
 
+/*
+ * Try (offlining and) removing memory from Linux in case all subblocks are
+ * unplugged. Can be called on online and offline memory blocks.
+ *
+ * May modify the state of memory blocks in virtio-mem.
+ */
+static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
+						  unsigned long mb_id)
+{
+	int rc;
+
+	/*
+	 * Once all subblocks of a memory block were unplugged, offline and
+	 * remove it.
+	 */
+	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
+		return 0;
+
+	/* offline_and_remove_memory() works for online and offline memory. */
+	mutex_unlock(&vm->hotplug_mutex);
+	rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
+	mutex_lock(&vm->hotplug_mutex);
+	if (!rc)
+		virtio_mem_sbm_set_mb_state(vm, mb_id,
+					    VIRTIO_MEM_SBM_MB_UNUSED);
+	return rc;
+}
+
 /*
  * Prepare tracking data for the next memory block.
  */

-- 
2.55.0


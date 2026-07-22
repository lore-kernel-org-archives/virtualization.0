Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2D2F3C37
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702181; cv=none; b=liTBmU29y/f4ATKh+/hT9hK8OChzYR2TRqjt+qmpB0+FfvOsjASLgmBvmGylKOpFzc9giWylU1uwxHUKbvsH4G5myFXI+PQM/suXu1lN7pd6mLOH76LADxUS3nEbwQUJT29FqEOKlmGQ+drJuXKy7fW5DRX6xnQJfvZwtIro5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702181; c=relaxed/simple;
	bh=xsmEthjq16+kC+Vph+G1U9fU4ClDR58MsihFmYHvaU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g2CRdhmnkCYwtdVhiX6aB/lYZz3ex+3+MVZHbsh06w54d3lrdvdWNfwR4jdoHfRkDkixUb3BKJAgaEAmqRL92tKoEn1IHZI+Q/DqJ0niHjnYpP6RHtvvjRANZvxvpWbZ9bHQCQLpjJjvlw0etO0YPoEdUZz0g9TGfF/8QIxX+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkEYLgOM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkEYLgOM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso76178585ad.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784702180; x=1785306980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kO1PiIP2Hl5OInAMYdlLbjh+bJ0nA/ItDty/+1ZP4t0=;
        b=PkEYLgOMz8QIzqlS2xLj7ket5mS8LwivSCLq+FoPuCYxT7XIRehzLj8bI/ndlipKAz
         QQ5XT/OhDHEUZqRe0qT9sUxRexk98pPZd8ufSIQJpcJ5RuIdfw4AK6Q9cvk+hnIjnZK+
         UH8afBwJXE68190964V+qaGlME838g5AWtYMu6xAI+KSHEXeufT42dbiIpf2hpy/+Gcx
         yvGlR4iXMeZQYW2AyWtngcAA/oUxJWeEFzlxsdgEqk8+ztUtWagt7xH/VbZFDKcvVq3/
         JFSGUmqvhEtFDYIQm0xHfn6DHD0v8ayiu+zLKcxf5Gqs0DPoY17krHy4GV3epTwFj3Eb
         /rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784702180; x=1785306980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kO1PiIP2Hl5OInAMYdlLbjh+bJ0nA/ItDty/+1ZP4t0=;
        b=JHVUqhD4rZzqPP23MVTzB9NMwQs+QpN49vKqJHYVLndk9rzmyfdpWaL4hGIS2vtr5v
         lM07rNcbHT2nWyC4oIC9M5r1MvbdFzC10sNhwxWCDDWRowmy48tcHLvTlQQFVQbVcEUE
         mbNQei/8Wt6PWJ9xn1NNfo316IeLMiiwprYvSOGigq3xdzJEqbx6dePjCZimatQ3tg8A
         xZ/lX80sd4gqZDvj0ZlJ2gCp2QiZW8OjqxlrTE19w4bOJqHguIimLHxG6mBi8lA622aC
         Feoi7/r6msYYAE1kBJ9EHw6aFGgYv4J4a631RPj3nLChpOeHyCfUS5AwOkxOvLRzjCfx
         lzhA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1wHjHRABcJVyUNp2uIuIkxFSqxavrRNuZeJS3Juw/9bV++SIMMqyUp9zigX3N7DvHpLqsvJr7Uk8t0l1Z5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxntALzxPJYDZkept0jOUj9qPD9HSxB+xVzAvDGa2Jc56Azk8Hj
	O5HTNqXu9jgKXy5aeK5p/NsmED1aCht6zaf4wqu6CWCJwwup5EwAVrISJacyNGFg99MlaA==
X-Gm-Gg: AR+sD10B99ZwXmSnI7tJS5RhXydHmGC/5VjYhRIaAfQYjveX5VaBt8mr4kbWfjnS6PV
	ygvc0kBg28Y8U5eH64uHhcy4ajcS5oepaZZT3xs1rF89+7LOKBRTXovK4FBmUMJpbGnHuk3AeTm
	9MolZznnFPaFQQucnKJ1Pr8B6OSl42G4/++3b7TEQvZvVKnqTuh5XW3JPC3KxebgJv7GYWEdjKO
	Q4quhqiCU8NthkWVtYZj6OEzYN/r9SXctrHixPuO0UasrIsc98p5Je86QWrlI35MwzfvvUOclTE
	Fpl4L3kaQD4a4UiYmP9v7nymeqqiCU5gadOoxXs/8S9hbLQ2e4BRjIH7onvy5eeQzNgj7zv5tOd
	J2pLjXnR1OoZ4tl81XtsJQawEckIzq28VAU+gs2nmj0YifB4ybk16B5kVE20nDsv5kBumhMAcJ6
	ENsw==
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2cf3481b77fmr230776485ad.2.1784702179371;
        Tue, 21 Jul 2026 23:36:19 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f38a40fsm8908685ad.78.2026.07.21.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:36:19 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vhost-scsi: fix T10-PI lifecycle hard BUG after endpoint
Date: Wed, 22 Jul 2026 14:36:09 +0800
Message-Id: <20260722063609.1546421-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_setup_vq_cmds() runs only from VHOST_SCSI_SET_ENDPOINT and
allocates each command's protection scatterlist array (prot_sgl) only
when VIRTIO_SCSI_F_T10_PI is already set at that moment.  Command pools
are not rebuilt later.  vhost_scsi_set_features() may still flip that
bit after the endpoint is live: it updates acked_features and returns
success without reallocating prot_sgl.

That is a feature-versus-resource lifetime mismatch.  The broken order
is:

  VHOST_SET_FEATURES(0)
  VHOST_SCSI_SET_ENDPOINT
      setup_vq_cmds() sees no T10-PI -> prot_sgl stays NULL
  VHOST_SET_FEATURES(VIRTIO_SCSI_F_T10_PI)
      only acked_features changes; command resources stay as above
  submit a T10-PI WRITE with a 129-page protection payload

The I/O path then follows the new feature bit while using the old
command objects.  vhost_scsi_mapal() (static, inlined into
vhost_scsi_handle_vq() here) does:

  sg_alloc_table_chained(table, 129, first_chunk=NULL,
                         nents_first_chunk=inline_sg_cnt)

With first_chunk NULL, __sg_alloc_table() sets curr_max_ents from
nents_first_chunk and calls sg_pool_alloc(129).  sg_pool_index() then
hits:

  BUG_ON(nents > SG_CHUNK_SIZE);   /* 129 > 128 */

The kernel reported the following call trace and register state:

  Call Trace:
   <TASK>
   ? __sg_alloc_table+0x1d8/0x250
   ? __pfx_vhost_run_work_list+0x10/0x10 [vhost]
   sg_alloc_table_chained+0x59/0xf0
   ? __pfx_sg_pool_alloc+0x10/0x10
   ? vhost_scsi_calc_sgls.constprop.0+0x43/0x60 [vhost_scsi]
   vhost_scsi_handle_vq+0xf02/0x1700 [vhost_scsi]
   ? __pfx_vhost_scsi_handle_vq+0x10/0x10 [vhost_scsi]
   vhost_scsi_handle_kick+0x37/0x50 [vhost_scsi]
   vhost_run_work_list+0x8e/0xd0 [vhost]
   vhost_task_fn+0xe1/0x210
   ret_from_fork+0x348/0x540
   </TASK>

  RIP: 0010:0x4
  CR2: 0000000000000004
  RSP: 0018:ffffc90000dbf940 EFLAGS: 00010202
  RAX: ffffffff82396810 RBX: ffff88811dc28b80 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000081

The host worker dies and the machine stops accepting network service
until reset.  The missing object is prot_sgl after a post-endpoint
T10-PI enable introduced by commit bf2d650391be ("vhost-scsi: Allocate
T10 PI structs only when enabled").

I also checked the other feature bits handled around endpoint setup.
Only T10-PI allocates this endpoint-time per-command resource and does
not rebuild it on a later SET_FEATURES.  LOG_ALL uses lazy tvc_log and
already tears log storage down when cleared; HOTPLUG does not allocate
prot_sgl.  So the chosen fix is to refuse T10-PI enable/disable while
an endpoint is active, rather than adding a second rebuild path in
set_features().

Return -EBUSY if vs->vs_tpg is set and the T10-PI bit would change.
Userspace must CLEAR_ENDPOINT, SET_FEATURES, then SET_ENDPOINT again so
setup_vq_cmds() can allocate protection SGLs when needed.  That matches
the existing "build command resources at endpoint" model.

Fixes: bf2d650391be ("vhost-scsi: Allocate T10 PI structs only when enabled")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..000000000000 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2219,6 +2219,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
 	struct vhost_virtqueue *vq;
 	bool is_log, was_log;
+	bool is_t10_pi, was_t10_pi;
 	int i;
 
 	if (features & ~VHOST_SCSI_FEATURES)
@@ -2234,6 +2235,13 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 	if (!vs->dev.nvqs)
 		goto out;
 
+	is_t10_pi = features & (1ULL << VIRTIO_SCSI_F_T10_PI);
+	was_t10_pi = vhost_has_feature(&vs->vqs[0].vq, VIRTIO_SCSI_F_T10_PI);
+	if (vs->vs_tpg && is_t10_pi != was_t10_pi) {
+		mutex_unlock(&vs->dev.mutex);
+		return -EBUSY;
+	}
+
 	is_log = features & (1 << VHOST_F_LOG_ALL);
 	/*
 	 * All VQs should have same feature.
-- 
2.43.0

Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362A31D759
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864648; cv=none; b=WprYCX3oICkmOQFVy9KMU+okpKx4KK2QNcZ0kVqTeaDygI0oqd6I8CLhpyKN2KevIJa2E2I7Yewm+4dU1Fn1sGXn4H9j1dGVcaTcAkRqd4jRQ0Qohs1iqrvJBFgM8sy6x4LXa6e1hx+HS+dm7Kct06YiPFm2PswsQogPNvjWHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864648; c=relaxed/simple;
	bh=xJlJwMlZqQOc1MeDeLM7Ds5ojKq8KazDXodYNMxiQLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRfcFVPktgu8nEtv05f+TgUZ/R8KLy1xk3yye/aAKEDNbcBI4+LkLqj5jDZFGT1kMtJ6DavaG1dpwKMLxDB5xZPue6JTNdS57gNxv3YVj3+/ejqfViIvc33bJ76zBl1+bf6JZlwC5wMoz4pIouCKfyWAjTAxXOGsugd1W77Wpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmH3XX8M; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmH3XX8M"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca12086c06eso7827a12.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784864646; x=1785469446; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjSrN5U+fixNHZuhLquWtTETqgon0l+Qo4BnxexgPeo=;
        b=LmH3XX8M0Fo2Tjelk7W9YduzcpHnGAqh3JPUYG5SUl1YI9CoQi1bnMCMmqugHPQqEv
         hsfVThSRfvzVfLcPefsrNqFYcj2Tw6l7vHTIt86uI9vOnw5ILHK4KZUNfXjfAD/ubupY
         ev9UxRazhsbpoI9upTDKw1UzMGrTdU4UjxGraup8j4ndJES4eF99QG/Be6olxZuXN6cF
         zvNT8w0XqtEIIOFXYcaPWjbQxBCFYHlz6mIp92ZYD+trqmWX0zv1//6PDyFVoTVEIh4R
         7f8CQZnl+B28cY8MIldIpgs8SVH9qHmvviWAobE1rSMHUq52DaS/KEsyVi5tFCBlI+W1
         4d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864646; x=1785469446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjSrN5U+fixNHZuhLquWtTETqgon0l+Qo4BnxexgPeo=;
        b=YrA/0od7rIZ50kMfq52fRGRf/yt598Z8v8PthwcEdnjJEQ4SDWPcC6D1A1hsQPGoj8
         NNdpxnqOMJgawhWuEVWo5W5XOwwDEiZu75Kaa7fABbok4wS3/6c7JSzkVp6cs42M7OI3
         EjmjfrtDI3Pv7cMxNxtbgnWd3fNgVhd/ri+EaBLY4OlaNpTpIaK5/e/MGPzxOqeO25YL
         t3LC52ktEuTyDzBsvApr22v3iB3aYOgbjqC+KSi+VPit+0OwiHyjZWM8ZWehk9BT1Stx
         2otM7lO0yLdwahCPXtdrQwLdvNLTp877Yxd+LJZeaq1XgI4L1gMUFyexhh3K+MVIiIxc
         6OcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYdqTelb1fQoYigmjM5UemCMQjIZbS6ur4uNGxLVX2d+dW9iAv3PKRXVSJ/GBbyF/hvN/FANVYIIp/zjSmWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yybp2Mdhg7pfP1l0hrMNGioQOaANVv78znQvtT2hDAxBO7uGCxc
	AfGV+0kJYJYqlI9efs2IYdd3k14fjZSxozAGAu8fruQlfeMrUJeUKrVu
X-Gm-Gg: AR+sD11ZFurtZyfEKnTJcBuVk/X2gFFXr5hSHC6TOdBlzXSIyG1lKQ4mTyn9ludAJju
	VDUKeLqI6feqbISIWAJezWqOr7TxwiSB0J5PN9AH3YqN6f2iuSgp97fjCIxwNUt3ERWZF0V8Gye
	xyerlMR++4bb15fReTzxtq1g9LJaDI2KNnR+7QB0b3WAg7EQsd0vpxL+pi0XiHA/7iVS7YqNECG
	dHiU5mKWsSM5ie1BVcAsJtR501TrTRBSsBYt8QkaSihY+LmGBdFG2WddeZDAoVYLeKKXmnkgqSE
	F6rW7bIBj0KSKszXqxAflILApPx9Pn6vIDo+C6aX2dvW5JGbIZVyqVtvtDXbTCADETkd/7ipVCF
	iGfMh/Z6pkg5kzrIpo423bmMmW/1gX/VlTwJoi2jIJ7nmYj0bg4Cc83yTlRGuXJmSDAmiY/5ka3
	eTQ+HG
X-Received: by 2002:a05:6a21:1f8a:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c44b051802mr6868812637.33.1784864645799;
        Thu, 23 Jul 2026 20:44:05 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm41749064eec.1.2026.07.23.20.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:44:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@gmail.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: reject feature changes after endpoint
Date: Fri, 24 Jul 2026 11:43:55 +0800
Message-Id: <20260724034355.1568036-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
References: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_setup_vq_cmds() runs from VHOST_SCSI_SET_ENDPOINT and allocates
each command's protection scatterlist array (prot_sgl) according to the
acknowledged VIRTIO_SCSI_F_T10_PI bit.  The command pools are not rebuilt
when VHOST_SET_FEATURES changes that bit later.

Although virtio feature bits must not change after feature negotiation,
vhost_scsi_set_features() currently accepts such a request after the
endpoint is active and updates acked_features.  Enabling T10-PI after
endpoint setup therefore leaves prot_sgl NULL while the I/O path follows
the new feature bit.

For a 129-page protection payload, vhost_scsi_mapal() passes the missing
first chunk to sg_alloc_table_chained():

  sg_alloc_table_chained(table, 129, first_chunk=NULL,
                         nents_first_chunk=inline_sg_cnt)

sg_pool_index() then hits:

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
  CR2 = 0x4
  RSP: 0018:ffffc90000dbf940 EFLAGS: 00010202
  RAX: ffffffff82396810 RBX: ffff88811dc28b80 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000081

VHOST_F_LOG_ALL is a vhost-specific runtime feature and remains the only
exception.

Reject changes to any feature other than VHOST_F_LOG_ALL while the
endpoint is active.  This preserves the existing runtime log toggle while
preventing feature-dependent command resources and data-path state from
becoming inconsistent.  Userspace must clear the endpoint before changing
any other negotiated feature and set the endpoint up again afterward.

Fixes: bf2d650391be ("vhost-scsi: Allocate T10 PI structs only when enabled")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes in v2:
- Reject changes to every feature except VHOST_F_LOG_ALL after endpoint
  setup, following review feedback.
- Keep the existing runtime VHOST_F_LOG_ALL cleanup path.
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..000000000000 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2219,6 +2219,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
 	struct vhost_virtqueue *vq;
 	bool is_log, was_log;
+	u64 old_features;
 	int i;
 
 	if (features & ~VHOST_SCSI_FEATURES)
@@ -2234,6 +2235,14 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 	if (!vs->dev.nvqs)
 		goto out;
 
+	old_features = vs->vqs[0].vq.acked_features;
+	if (vs->vs_tpg &&
+	    ((features ^ old_features) &
+	     ~(1ULL << VHOST_F_LOG_ALL))) {
+		mutex_unlock(&vs->dev.mutex);
+		return -EBUSY;
+	}
+
 	is_log = features & (1 << VHOST_F_LOG_ALL);
 	/*
 	 * All VQs should have same feature.
-- 
2.43.0


Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44E25D527
	for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077017; cv=none; b=edl0CZk4Di3TEbZwj4zfYuvwiQqKOWcZSve0XvPDvdKqcuNpUJ7pBH40wFMxuyztquoKfhP7eIuTgKN7ERuFWccy4cWC01O9IDgaxcNPZfwSFxuVWum13/s0WZIg99h5F9IDDZYYOrjEzlL+NpPes2pyBew0kj2iMvZ7G+C8uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077017; c=relaxed/simple;
	bh=urFn2lf1yr2e4/zmFZtHljImz+Gvs/n+ivlMYOXJ1Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BdMQGzB71Xn3amSTiEepFSA8vAgj+CJ3XICp421C5P14au1sWmGKs43fW113FGcakx4lcuz6pGlmNYuhh1p/ZYwsfZ2SDknHfYNr9Cc4+9WPFqWH9qnAQnXJ4T9KP3W6dWLNE6ehMspc/CCliy5cICUd9D7taAg1ioPSNacBwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv6lPJXO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv6lPJXO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1515252a12.0
        for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785077016; x=1785681816; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8tnokq5piWSJeHnGq/Tb/6JZPo0EjC0d3idL2CeItMI=;
        b=bv6lPJXOELUvYjHj4SUFKKWm+BloVaxToPm/RvcRqrdH7TIekTtZMhP/dcLbFI4TQk
         6+rp7TtgZDCK824OtgRQO5C6QmIDmyDjjERYhg+ZWcBdKijEEoua5khC/22IQaDdo84t
         1zdunEoEPOk8MdvazAn493lU0NlNfWORdCcM0/IhrUkS9hwQ2QG7vIZ9UP6Wn8n9LdG3
         IisYfnki6F6J4xn26YbuB9grFQanp2t2Xh8fXevlYGCcn0pjTd57dQws4j1WYG0qlk5j
         DqY+tfL/52ZR+tPLW+1ZxYW9Mrt37jPM4htW8BApUZ1RwcTODWUp/bV4HX808nVjLkoC
         2DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077016; x=1785681816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tnokq5piWSJeHnGq/Tb/6JZPo0EjC0d3idL2CeItMI=;
        b=f8YbkC5aKeQ/nHHlH5/V1iexuAzIY+qt+PuTMKGYK0TcUZKiwUBLeUPFxPyfysxSnW
         A5eusioQSsveYAyR9/jJBHG3pHQz/UT2ZgyROgheZwIb+ZoRBDksuJeDUlWLUa5f+eAH
         P3g40j5dYGIPqYSTE4e/jRH5wop2qoR7BVVHsmQew0m6agsR8xbvSr4tL8l9KZToGRHf
         WF4m9UhToZebQctCfFDih7KuJ3bGiNU5m5GMhTN6Iv2Qsf72dGElk69xtJ0ZhhFp+CmS
         E79l6EvTKuuiAUK0KhHrPyzmlsiI7C8vYNlQfOnYi06hzoIknfkyCKHugaWWt7jyWvnw
         nAhw==
X-Forwarded-Encrypted: i=1; AHgh+RrySTf4K1IAK2y41UKMb0kuAZ4S09fxAMfpU6B/FgEAAlnbDy9FUkZLgYtrH/BTZtuucHfEm/OwXIrs21basg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtgY6q0oD97Y0XR352N4X3r3BRCqtjYFqtvUS8Kl21TbesMRKU
	1SmBPxlL+oV8iGSOrPtYy13h1DewcLpr3hUjSGc4NkrBZefBB8ZvDlz+
X-Gm-Gg: AR+sD10mj4t+GglniVPusDHf2V5fZuDW3w3U88gY4trwU51g+oOjYgw1FDO6MOyBwGa
	3s4Lzwp4uy+mp4R5s8cz3lI//AhHdc6aOFTCs+iFkRluxLLYc0mwgOH+me3ocmaIFfmnEbBrRPj
	2xvCdjv1tadeZd7QX5HmNWDSl0B29EB/gDYx1obnXtsYLi4kXBSrvGRIbYm++utOod8b5LYViVu
	vvosch34EeQG0KeWw58W3ThU7kpjseONCAlJWH91Rr7nFt61mSYr8Ws/CEPZckEltHVCEVuhaol
	bNVW5DynVHFm9G18KdtKsgBJ6fRyOlzdE+tPqFqBurR1I34ME8txvuQ/6l9z+iPEbQGpe+JCNdC
	S9oO0m88bC7AMtTSHg0x4iuQtplYGgRx4fPvXEPaXkRhxk5X5xpiyQZOERndDUPPz46nFL0znLN
	huGw==
X-Received: by 2002:a05:6a21:68c:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c67df7c5f2mr4832845637.50.1785077015436;
        Sun, 26 Jul 2026 07:43:35 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc579127sm19101361eec.21.2026.07.26.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:43:35 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	physicalmtea@gmail.com
Subject: [PATCH v3] vhost-scsi: reject feature changes after endpoint
Date: Sun, 26 Jul 2026 22:43:14 +0800
Message-Id: <20260726144314.1652934-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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

Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109152236FD
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791683321; cv=none; b=BDJlZr7diIqaCviLCnOFqo8b9KNUN9PjQ1EelGDdmq14HSxTEsxgMe9BfmsLHQgVqDe+8DGwKzMVfnQIYamFDYGPI9WtG4jy5gkr3Bdw7OyMGddtCQXQOEAdTNXZR98l95wm0CwJV2pBnq+YMs3HNugamVQOKs4xPlfUYQEH09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791683321; c=relaxed/simple;
	bh=iNfEOTki28mG8+E/q+jod6G13cAmJ5gfKHCYNhNQfFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9dHqXT4ENwRE7j9JDmM1x+rdqQVCG13vWDpoPZTxQctfYbgftdfTGCYRCpNTy9nEXJHM+K1Fe3G+TLRLk+KXN/o9T3CNKD+i8o+VGj+XguF+Ru473mVX61q9Ov4Hrle79Rsr+NARo03ECuUWuO0vw0mY9zdjL8rES57qdmOEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpczkCNs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpczkCNs"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc758830601so546922a12.2
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 18:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791683319; x=1792288119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4ioZwXLugL7a4JvMdl+hzI1AKbv2zUcDeCQrSIJAnw=;
        b=XpczkCNsgEfYX29amlKXuPLDKR7bd7yGpl1DfhSsz78FwARvJaLMriDpTXBWLyTXZQ
         qyoMt/CeLFh56aHutFCg++pII6rdfKk19i6tdufPP92WaiFR0S9x4nydl0AdZT5ItIvf
         +J+ka97i8PoceFnBcw9FqWI97H6f5mBdIWnuIf4DobUbbpm0Ejsz/kiVqKWLzPUNQL7K
         Tf6+2pMUVbvawgL0H5i+2ReshD6JHT4i0TpAfd4RwHAiUEbcw3c1Txxo472muRMGpBJU
         amhmINUEvV+20Nacu9vZyZ2ImG2LpCQC4/z5y7YHFA0NY/UcaEMTJbFeMiykjphjQbyj
         fuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791683319; x=1792288119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4ioZwXLugL7a4JvMdl+hzI1AKbv2zUcDeCQrSIJAnw=;
        b=qnoY6LJ1OnhLA/j+4NIz7cBiiGbRqapmm43/6rlSC0+fcYH1hKXywCxzZohdqGnqU6
         RXHuNyOB4bo7kc1xTO7h3KwStGc42L+arfgMjz/da6JA2g7Uyz9UMy72ehxyxzajdLn3
         8Aqg/zg7g04lXEztupA2dSXEkAIm1xsRxny2ABXihtle+iuB/YyGvgPCcST3JRUlKUj6
         fZiYGHnX8TWZx3BTIZHl1fuIqlEdLBpFZpXAu+y79PXCu2veN6LtcedPfyYXClq4ExAq
         EGLGc7IBpWg6X7h6eg/UHac7s5O5xJ8++JKYJypXuqT6Tb1/5qhlIpt12tf8nGQo112K
         lLZA==
X-Forwarded-Encrypted: i=1; AKwUvBwiFi8ErDwEoKLHl7qWHDr0Cz+I4QKj3MyzN8EDsODUX++V7sIHZVrti7bWx2sIQpxUrpaJPRELThTawcsUtA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIX7+InOtftHyvIybf2ymVjEPcpV2X/fuESGuvuHdocAZznarHu
	g1rHVsPta2pe05mHx1K2WKMA88Shz87w/13LyTsvzRvKeie+f2JEeaHg
X-Gm-Gg: AYBFou3lQggJLwyO9iLOOyhMl2mIefMTAad1worIqza78RPpwHuNIBkyYslQ4/4DHNy
	B5FbJrhdiW70vYg39AyvKnrH3C47Gm2A8t/CSxEeLb3lgR6PD/iCQYiCVPKTOlj7T55nh5H61X1
	DS/KWwRezWZKFO8ogLkvWKmLiEm/m5LxFak9wVvnVPLww+cB6WL/wiJHvwFjH2c4ENwd8hCDr5w
	BxvDPt4KCDJ1LfOmckQeLZEPWNcyZWxEY3GFWm2F4kS6H5iFzdQpkM+aXkU0DmR4Q4lbIS/UG+3
	ehUFbtqB1eAK00iynsdQRg9FG6Z0e7oFBQhtcZt9AYR0ko/lYFyN8Bm1beLEcomhKwNt7fTX8Y0
	6tSmRoyfKMORUauMuzAc5gAVIiheSzX/dBiK6F5lH8abZO4ASyxF16dCrS7IWpuyPGXovHw3AtH
	/JZMlusGt9nEGpiygdx/rsJIaRkqGShsCB2vRmLfIv6XM9PGGHFyD3Bpxwackm7UVztlqBpg==
X-Received: by 2002:a17:90a:d008:b0:3a8:49f2:8ddb with SMTP id 98e67ed59e1d1-3ab3ae36cbcmr5697749a91.60.1791683319116;
        Sat, 10 Oct 2026 18:48:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm8496023a91.10.2026.10.10.18.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 18:48:37 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
Date: Sun, 11 Oct 2026 09:48:03 +0800
Message-Id: <20261011014803.100454-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
protection sgl and subtracts those bytes from exp_data_len.  The length
passed to TCM is still exp_data_len + prot_bytes.

prot_bytes comes from virtio_scsi_cmd_req_pi.  With
VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
data_length from the CDB only when the protect field is non-zero.
target_cmd_size_check() leaves a write's data_length unchanged when the
CDB size is smaller, so a command that does not get that replacement
keeps a data_length larger than the data sgl.

The KASAN report is a MODE SELECT whose header had pi_bytesout set.
The data sgl held only the parameter list.  spc_emulate_modeselect()
walked data_length and read the next physical page.

Pass the data sgl length.  Protected READ and WRITE still take their
length from the CDB in sbc_check_prot().

KASAN reports:

  BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
  Read of size 1

  spc_emulate_modeselect
  __target_execute_cmd
  target_execute_cmd
  vhost_scsi_write_pending
  transport_generic_new_cmd
  __target_submit
  target_queued_submit_work
  process_one_work
  worker_thread
  kthread
  ret_from_fork
  ret_from_fork_asm

Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
  - Drop the claim that target used to subtract prot_length.
    9f977ef7b671 cites 14ef9200, which is not in the tree
  - prot_bytes comes from virtio_scsi_cmd_req_pi

 drivers/vhost/scsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..4bd29c2ceed9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
 		 */
 		cmd->tvc_vq_desc = vc.head;
+		/*
+		 * exp_data_len is the data sgl. prot_bytes already sit in
+		 * the protection sgl. Protected READ and WRITE replace
+		 * data_length from the CDB in sbc_check_prot().
+		 */
 		vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
-					    data_direction,
-					    exp_data_len + prot_bytes);
+					    data_direction, exp_data_len);
 		ret = 0;
 err:
 		/*
-- 
2.53.0

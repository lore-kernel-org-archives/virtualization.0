Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77A3AAF49
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801627; cv=none; b=mf9bWfdRyvqHk/W5MJKPLQhkV0ZZWZbRyur6eZz+PE8+1BWuQZbUqX01SGcsrkdMCRax3aJypbcozT6pN8KPr8buGQsSoC41JSJgyfMkExjG1t325Ux0s+H7A0gsdOyB85Lvwgmjqbz5jAS9YLZ/PVM7uG5S243kUVBFg7VteW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801627; c=relaxed/simple;
	bh=vFkCRtgxGCnpOhlZA7FYzY49jEv/8nkM8zfXlvjQOfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faYLlsXM377KMsNh9vMig81jPXG+fX0fsSJuCGUWObUqDdU0yd48qXTP5yVfOBRj+zhiCkdz13h0OyDauqVNpFZH49FT6gJ8xpW80FEhCZYb8LhDuf6eCpK+Wlcqt+v3ciF864onj6eJLOs9+IoPRMtKTy1aqeFTLecb39WMIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlqq7lf7; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlqq7lf7"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5948769eec.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791801626; x=1792406426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3l61iXys9UAgeiq6Qoow/JEP0G8Esaw8ppQEGcd0fNQ=;
        b=Jlqq7lf7PAPJ9dwtWgAKz5VeV/vaBwaGEPZLLRr8qRPS8ox63uXQJyqfVtkXD4LDda
         rTdR8WeG6U/gwXxAnD92G+IH0TNMedQoqwrjq8hq1ObaRbbavZfmnP/qdTK94G0g27/w
         547yxgqiZuxOUF4DVXNyQh3TyWQTYl169c2OFkeIWjAexCcnHx5lUVoUdWCqX3xz/5so
         WvByoNxvza6CRO0HoGEJOzOZn62WWHwOz6v6uxdgUPtAyHeL87twt92LTBnGVOE4s4Co
         uTbNAitiWWD6RWABGHfhKS13Bw89ZrfSNotK3gBpM1m7ruEAvKx3RT5N8AE2rCe9VSyt
         ZTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801626; x=1792406426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3l61iXys9UAgeiq6Qoow/JEP0G8Esaw8ppQEGcd0fNQ=;
        b=1Ad2Fr8X6c/61oRgtmMiXEodkHm+zdRVoRW/q6cr5j84L4VYvhbw7kuFX7b+b96v/c
         6Dc/FAdSlbg76cHIsMKnjlbNvsp16ZYe6uYaCytSpOUnRYEY8ZeS3ys3KuqF1mHhtlMX
         +ENoAvj+j4YQPYtoAEreIckyF/bQQpZ03oZ+cvyJD7ew0HVpzs6rh/3fn4NEv5smEMbU
         l+fIwRF48y+T5id5C5JefwX2kDvlGIub/+jojBmHfV/B9l1c2JgUk+XsHKhzkx2bp/UU
         enZybvpbFykOYnursyL2D6d12P4IulRFsW6zZ6Ckt157TA7nODTzk9ag9bvFCbNIpxBb
         iiZg==
X-Forwarded-Encrypted: i=1; AKwUvBx+BkrNqtaGWpbwj2j6b4TNSK1cuHHLPMGLnAvGZ+2aWWMj/IO0Rg8R11dnX8iAOU/6RNU/ox3IPu58OROH7A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRRgvoNeKBhr11cDxkQvsKq5wLdWMlgAFjujwmBu4wB7KEPjFt
	zsI4QfDX17nxvn10qEAY2U/to4uliFpNRDd2v0A/AUd6CyRPKvRVRpah
X-Gm-Gg: AYBFou2o2ABXitNxJZlv8JUNX4u+meQKtKgeMYwKOLLy0Ken+DwdEnMhmFpPEVi/kr9
	T5PsiOyGMUsRf6K/YEt0S+Soac7U4PfirKiaCjVqRR5NSHiSHUBI9U8TZhsme9ObsnQQFqHF1M4
	JG579yu8t+bnkOXItS8zsQCcmUZN7IdhAucZ+Hp14LgPNYqlctxGv5NN7itGwB9ZLORjGg99Ipw
	/Kn0VX+nqu2DCrDp7Y00A9cnWFIRXkUL1SLdx2QfnrEQjD8blP59QnGEt+M0xs0mqsBwRG6xyFV
	7EFqZH8j/PGpWb45Y2z0sbeduHGlsS1eLvQvQ+1xpdAOBjTGV9LAZ8u58KTUe0FQt8Dizt7szBO
	Yo4HRFoealLQomKVaWScIhLDNG2H3zhfWWMahDaZj5w8fewltgNEdiGkKeAfdSBNXmvV94TdOBb
	1URpxL2pGs6vpAghnvboOoiIi3VjRmayOwDyOn7nauANF7dAHac4QRu/BRDDaM9rUU4uoHtA==
X-Received: by 2002:a05:701b:2058:20b0:15c:20b8:7964 with SMTP id a92af1059eb24-16a63386d86mr13548313c88.27.1791801625139;
        Mon, 12 Oct 2026 03:40:25 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm31434866eec.28.2026.10.12.03.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:40:24 -0700 (PDT)
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
Subject: [PATCH v3] vhost-scsi: do not count PI bytes in the data length
Date: Mon, 12 Oct 2026 18:39:54 +0800
Message-Id: <20261012103954.136698-1-physicalmtea@gmail.com>
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
v3:
  - Rewrite the inline comment to distinguish the data and protection
    SGLs and explain why TCM receives only the data SGL length.
  - Note the related target-core patches for PI tuple accesses at
    protection-SGL boundaries:
    https://lore.kernel.org/all/20261006093338.27342-5-physicalmtea@gmail.com/
    https://lore.kernel.org/all/20261006093338.27342-6-physicalmtea@gmail.com/
    https://lore.kernel.org/all/20261006093338.27342-7-physicalmtea@gmail.com/

v2:
  - Drop the claim that target used to subtract prot_length.
    9f977ef7b671 cites 14ef9200, which is not in the tree
  - prot_bytes comes from virtio_scsi_cmd_req_pi

 drivers/vhost/scsi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..4bd29c2ceed9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1534,9 +1534,17 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
 		 */
 		cmd->tvc_vq_desc = vc.head;
+		/*
+		 * vhost_scsi_mapal() maps the PI bytes into cmd->prot_table.
+		 * It maps the remaining exp_data_len bytes into cmd->table,
+		 * which is the data SGL passed to the target core.  Its
+		 * expected length must therefore exclude prot_bytes.
+		 *
+		 * sbc_check_prot() derives the data length for protected READ
+		 * and WRITE commands from the CDB.
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

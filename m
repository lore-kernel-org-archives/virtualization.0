Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C853D5259
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274921; cv=none; b=ekKF+MdWrPFzhbz86bvp696MpX/HZTi40HULZxgtpa3HwtlOeezJ/Pli5gzZZ/uXJRIVDLzSuhSmHUKwKzyjDlVLIEdS5ZlBOjnRmfeqC6UocJRD8rmuBcAlCXE5OM339nGGzW0y0VrmoTs+wml9O6WnSzqYv4YZ76laanKPHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274921; c=relaxed/simple;
	bh=8obgukGNW7ky7Kk/hIb7Tx1nD/UtTtHjcp92oif6oK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fe5/AFzsJuYcPWR+u0ZSIykdfUS+lAxpAAeNqK5jFXWuhmwrI459sArIPIdpGcg+z6ZeiJc7BODgqdiDtlT5s+LqL79dKX1vuf1mRrEW7itXw5aidbuM4Nb3tw4qy+7eoUIPlMpJUOrV+MyTTpLtbzVpAvFFzwj/u2WJENB7RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evdlIgKP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evdlIgKP"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso162425a12.0
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791274920; x=1791879720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b8u3Yoco6qaMZId6V3SXGgwbYt0UtNsiNUBPhWK2nhU=;
        b=evdlIgKPqBGiMolRUKHwO1XDyCaGc1i7lsP5GJe9YuPjEAc6xWbD/TrF9xRpOBxCTI
         fqSgihg18rirDfW5LSS+kvUa0hltFSl+pp/blNOd/PqWT+d/mDWgRgD4ZMScAJhpUhoH
         kMtCh0mM5z3F5HNxlaxIncZayVnuFP+iERbbSXdzDlA7d/QRtLdNpdxs+1heHphLQvzp
         Rf1/R0siObFPjYWaaXIfr2P7zYUhOpKMEAVoRKmbJteG2a4DrPfggS071HlhBFMZJ3t3
         6ffo5UTEaZAmFuMcuVPG+Vhjdn/XvGbJHclM5mRC6lUKvI4mU5qsnf/iGn07xbrK9+a0
         QvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791274920; x=1791879720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8u3Yoco6qaMZId6V3SXGgwbYt0UtNsiNUBPhWK2nhU=;
        b=nF2g/OXWr9KeQTocB1Fgn627sqZq10zO2QMH0WI4Az07ODOKSe+TfOp3WYBSuNCdxZ
         Qpx2CtMS+kChhyp+IMO0gVPogt3nRbXK81I6Zrmi2nTzJ9voE5J+WZ4gfnyhsOL6ZyzL
         Lsm7cs1nV4tojDMVSJo4GW7RxvzDAjLOLNbRe7hqQ3Ys9fxxXxhlHVtntGTd3Du+vxLt
         WeDDUbI0XH20xXnCawbvBt67sGEkp032VIlhTKoCV6h4m9sICXWoU5/jYBQPfs94BYVX
         qgBcRxRn0euiwvx2TVhegvT1wawqkWTGJi0DazJz6K4kQ/Z+R6AIbiIqFo96CJr983Wv
         ebDA==
X-Forwarded-Encrypted: i=1; AKwUvBxnf7MBoGoSVTai3ZufRntkeJC+ljA4vJh6Ykjslo2tb/QdV/lYWzxxFHMSrKd9SfEywjkq2s0MMyZ1+qoKlg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKUfbu45NNSZS+d4yFrllxyxhUXrA0mbHfwdowb2Y1Ej/I3OP42
	opD6O4NJtQSZOXmV+HS5I4ZcBhEa9Ub8e5lKDxj6ODtVO4pfg2JaO5gr
X-Gm-Gg: AYBFou0vIdpKHXTKAfeRJjlUgAq6TmXdhDWiv/Fi8ebT7ITPMf5kgeQ5Cr5/ln9tuHs
	0AOhQah9iwjWAg1Bi9oqJxKNM8lfkrt3C6JH4jqw8fT/4rEzcJSDuQhGMOZnHTbc1rTVPIIUvmM
	kROh8SSYHYpoIfHAloQ0bh11hj4MBYTWFDUbEjXSo3liahwqKAXbcYTrHWpt0o7KpG9x+lxNtUt
	hHTr2IItl0j+IN6fyaLJwWomnaupfrJMKk5uWmZlZAjSoqEBDQuwdnOCVbVRdqAgWU/22mwXqEl
	kXkmfMISKSvV+XaXCQhmSw65TIQz5LmaiBgbschpg8adzsmJaPSbbhSuFBxBvgXf8bYfU0GcTLA
	6vK0XlA0W/vPZlr6A/tMhj5S26k/WVkepri2C/EI6bKBk2TUEkE/WgIj3gG84NLHguR07vInD4D
	P6+mCmp6FVkvL3r+Tr9pmVbxI8PQq26RRYef9AtZspo1JEQGQYGbNFC0djPh286qz5DTTb+PM=
X-Received: by 2002:a17:90b:288c:b0:3a2:b036:ed62 with SMTP id 98e67ed59e1d1-3a8733c829cmr301292a91.37.1791274919752;
        Tue, 06 Oct 2026 01:21:59 -0700 (PDT)
Received: from gmail.com ([188.253.12.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cea0f1sm3628152a91.15.2026.10.06.01.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:21:59 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vhost-scsi: do not count PI bytes in the data length
Date: Tue,  6 Oct 2026 16:21:02 +0800
Message-Id: <20261006082102.27085-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
protection sgl and subtracts them from exp_data_len.  The length passed
to TCM is still exp_data_len + prot_bytes.

That sum matched an older target path which subtracted prot_length
again.  sbc_check_prot() now replaces data_length from the CDB only
when the protect field is non-zero, and only for READ and WRITE.
target_cmd_size_check() leaves a write's data_length unchanged when the
CDB size is smaller.

MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
list that ends on a page is followed by a read of the next physical
page.

Pass the data sgl length.  Protected READ and WRITE still take their
length from the CDB.

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

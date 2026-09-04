Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551F19E97B
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483228; cv=none; b=E5yaq6WXdwQB8AhPdZssHYTZ5uiru9zFexW99sXWNJqXsc2tX6lPANGx9mgMHoFyubwhUYZgyv9LKe51M4OgK2VWj0UBttcfaAcSR3+2rrprPPxutNMh5pr/yUi5nS6cSs6MJF2AQHwGBwm5n7+zLwJj2lQfw5bbtA1VGrh15ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483228; c=relaxed/simple;
	bh=0ZpfWwRDAHgu1mRcWZVQMtXirmVz5qsYIzeHiB+CHr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RikJkuJGTtbWpEfADw50mBF9Ow2Zr4oCKF+4viuErMHfwXbPw3820V3AJR8rf61+bePd24cwZx2LUQZnWKfSHzTYL51ugk9QZwE0sl+gnceRmjbUES3F58Xr1+lYuE4OLHTOiAOo+/bUIV0Zv+FRhoXYzdZyhD6kVD/rJmq2sLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc7HM5eE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc7HM5eE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1538948a91.0
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 17:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788483226; x=1789088026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=Pc7HM5eEzTZ03YvAvnaSqvf/9UrNInAJzaQC/O/8+bOk5g86qhUGMHOZeuD8ODmNDY
         qRte7N1YFrsqxXU35c6NEBRTdyG5qhmStSF3uq61HKlWsFK2NRU9W1/Aq8+PZ/H1wUJv
         KOFCmuuxB9s7Isq2WYhopAX9BpKU+D388CjjIyTsazcdsPOItg4t9mlGIHcF2zxjAlEj
         XzTty8HfDqsnn95LSGdieAnlLkWBBYnjLOZ3V5PlzaPzHVKFvzOiCE0No8YBwmK79czl
         698jp8VojhK7WzAwpwH7106t0Ht9CtBaF9sz0Ixwk0+TNuoCLo5oa0YR8ySjvnK9bHiW
         3w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483226; x=1789088026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2el8XyfB2FMbOrmCud+3jZOtrXhR6MDItbmJqyOOTqQ=;
        b=qTMZCV41Wh2rSgulMwrVB0IN0bh6EuEVPncXL/EWUsu94ErAYh/846HBlHkUkel67x
         WDaQVTBA0sNVxCGs/FEV3EwUkIhGnW0h2oBpMWXoxTYF5Zpmp37oKlSTsZjWebEcHwNT
         MmMo7U85y+huCOVA+qwZwGJhWZetxZn3Zx9E/eYrEiJmhuLKl9CbkrVsR8WPZI4NqYN7
         lnR1DhzSrr3QCVDMEVnG/LpAdvyBJylvW/4HfByIzON/EfUDGIXtDjV4ceNjhcD7KsEQ
         XcB6xzUelzJg8ZsLcs7DQp4rIaylwdXzquY9v2p/UhG6gJAYwOLkZ91wmetRtydOXkKg
         oyNA==
X-Forwarded-Encrypted: i=1; AKwUvBw9x+kHA3NdPamU2zmh5kJFNBBXJn6kgpKuBLurUfMN5rqpWHvwLO2OY0+WQaNE1kpjD/XXDyfXqnptfIkZUg==@lists.linux.dev
X-Gm-Message-State: AFuF++l2Pkv9bqBrRvAeAO2ugyuAgbsFeIkG/v0gm8fygaHNNXEXEQsd
	lOhWWhRJZA6YMLih+YvF7E0i4z3acyAQFcSdHh7EqbD7KdJAflbRESjl
X-Gm-Gg: AYBFou2SmS/00r249t7S/U8Y+nWWhp9+U5zzFd1YyThM8hL/Jrx1HUTjprYF8Cy0Lt5
	mQ+Rm80yuJUf4oEo2rlbLs7LrNOK4aKxSVgq4nEy+Ht67zJ2QN4D+o/CavG4TH7NqwPCPY6kUV/
	CLSQ7T7EGSdTxoR3rgDEg86PStAN0FIx9XsYqRMi/tcR6QqKGHF9/CJYfs/LPjicEh5KGskfVkE
	G6Edm1tPm/CSobuwNy7NMfK5OuBp0goq1wFGmSIaVuKhSyBN21ybxAH2UfTH1gAc2tpSK3Hu7JJ
	M8OlrYD0A6d5QQqNw/3XhzWye44mDlbw0igfF6YK2BCYRU8I5T+MmUbrDQjqHN0yCnZTzhwn+TD
	0KtcTwBWQVLU/Yox9esHPQYyJPrmkQiUdae6qpAMUUjA2q7k8nwqg+jsjHkkw5Q2P/N4603fc0y
	RxEx83YUfNdG/kNszU1YCXObldReOoSl+p/arX4EZk4zYOy5DALO3W70PUhTI2
X-Received: by 2002:a17:90b:4490:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b279ad968mr1194020a91.0.1788483225951;
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm7701712a91.6.2026.09.03.17.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 17:53:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jaswangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Asias He <asias@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: fix event queue iov out-of-bounds
Date: Fri,  4 Sep 2026 08:52:40 +0800
Message-Id: <20260904005240.502787-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_do_evt_work() uses vq->iov[out] after vhost_get_vq_desc()
without checking that the descriptor chain contains an input segment.
vq->iov has UIO_MAXIOV entries (1024).  A chain of 1024 output-only
descriptors yields out == 1024 and in == 0, so the length check reads
one past the end of the array.

With a host-side harness that sets VHOST_SCSI_SET_EVENTS_MISSED and
kicks an event queue filled with 1024 OUT descriptors, UBSAN reports:

  UBSAN: array-index-out-of-bounds in drivers/vhost/scsi.c:611:14
  index 1024 is out of range for type 'iovec [1024]'

  Call Trace:
   <TASK>
   dump_stack_lvl+0x5f/0x90
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x39
   __ubsan_handle_out_of_bounds.cold+0x50/0x55
   vhost_scsi_complete_events+0x55f/0x5a0 [vhost_scsi]
   vhost_scsi_evt_work+0x17/0x30 [vhost_scsi]
   vhost_run_work_list+0x8e/0xd0 [vhost]
   vhost_task_fn+0xe1/0x210
   ret_from_fork+0x348/0x540
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Require at least one input descriptor before indexing iov[out], and
treat a pure-output chain as a missed event like other invalid event
buffers.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..9b5f07f52b0c 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -608,9 +608,10 @@
 		return;
 	}
 
-	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
+	if (!in ||
+	    vq->iov[out].iov_len != sizeof(struct virtio_scsi_event)) {
 		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
-				vq->iov[out].iov_len);
+		       in ? vq->iov[out].iov_len : 0);
 		vs->vs_events_missed = true;
 		return;
 	}
-- 
2.43.0

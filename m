Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944098;
	b=pEdb5RMjjtXL1JsfNtc4tfdp9cKv8rCFuIABYI8tccsUjRetBwVGVbrmwOgKk+uoZnws
	 m7gj9GkmDQmGJJdBIvoYuFHHaJZSaYHCz0dHdmPz8NWs6KjzGCV2Q3e16Vu+nx/WlDgN2
	 y4x9uwVypB9SdNWqcH96wW1RU+T75WkQwIXO0SAAu/rkDQMPqSUpujB6ebSaZd7o4ZpCL
	 fMJkgMVvDUKjnBuznFtDW9J59/9b/U1EvoEVP3L1eX1z3a7ZY9BJZZ0u1ClrlH5gb302B
	 Bgro3x76nbw5SPd6+P7NB52RIZwplY5zq5SdSF/UfWTR2H1xJvJqquJ6EQHGbi0FWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
	b=3rC+0Ru42wd4T/DpXCDr+yL0SnTxRI2WghsGprll3H4912UK/9lfbg6MbWpWZaKabIMF
	 jI1bIag0PKFUf1mkluhdN8MvKtSm+pQHxxxTXNKqyzkq7IrMjiyfbPrmarfqQoDYSyB5d
	 FXg5J5MG6KTbHjocfEJ0SpTWLYK1Q6JwbnqFYgbTDH9oKoX1vZYuRIPdlycst21LpZsH1
	 y5WBsdHpEti0XaPFnoVtkIctl445TiHlInKNU3OI+Iyi8DLo16lBrCVqqm7b4xVec0Dg8
	 h8RFhsmEy5BkM5x6iiXBaX2zvhZT6w4Cn/j6W2hvuXjI5qqNNShXDNX/dgBCo/yssEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0w0bJdL;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93D606EEB2
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E93D606EEB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0w0bJdL
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5366463571cso2782341cf.3
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 21:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944097; x=1794548897; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=Z0w0bJdL4Z61WuvGmj9g6YdQsTo9tznA7c0oEEl9T/uySCg4i6sFI6tDbaChK1sHBo
         Wi+ymdHQ9vHl249DVtAW9mFVEK/TyCH7V3czTwzBMgSduMC3txz7S1Aet3gY1j4P2lrl
         YA42Wqye81Yz69TsxiboUuhg23lARVrV//HIGZ7H3gp8uJd4Fx46eljnW/q6p9wqgkgT
         CuiX6ijHa1vgtJzB8KRNOqNkbnmIvvNRRdbkxa0IlM40hQjgU4Gbj0MXH1OIM8a63CLk
         8jtsozPS3xyO1BgArGOQ+KCvSEEh5gJMvbEDdMhlUZWInAByL2OXkgJ6tKhAyCdLyUU8
         rMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944097; x=1794548897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=iDad66Clj7v/rEy+RiwBlrcfzB5zlH9rFQ8dINyqevB9SPyHLZcoLMoqCyUXkRYmmi
         Btv2KoB0fpAgdZhQALEd1ZEfP5wLAgjVzKDZsJI5Clu0VtXRhTicebAXfaHVyhox6sE7
         I42gp1UOmp6j5UKMAgRJ1QCdSZM0VqXDcqRNGfR/s0+1GYsPEmBoxUOs9azHCEs4w5u0
         7ke7EAiii0zBldwymrnEsZHwa1X/SaYelrBW+cmGYo8z/7wZpR2Y9KLxa2HPzB/UsZFY
         tWqVKYdCggzZSEVvTMDRMZB69mU85oHHZAcA/Io5IzCC+5iPGh2fFEU4LhbhAc/weYf6
         kqTw==
X-Forwarded-Encrypted: i=1; AKwUvBxHEEBKss8r5wS1LX9G3imthT/kkdzwAxXI4UKGzS87CBe/Pa3iLt9joz1x6WfD9XfboxR0puiyJyfPW1tBpA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9wIXWAJuLFmsiwlyqrybX8fGjLn7OOyG0JtRSjqWMb1ilmFPQE
	Esy7rzleQ4qjjoIRDsdK0mUKcncuORdKhzOIK3t6R3LHNGfJTBnnjKN5
X-Gm-Gg: AYBFou2yc0Div0o9VvckhoajqKQ6oiZO7lmiSSRRbqkTjAzh3McWrw9HzZ3rH7SbSAB
	rzcjEAK15NdRhyLQuNvNf1ma6ChAut5apg8Igg0+iWONoAFWG/blvP1PrTuEuOslxFgWnrHTga7
	SchrTQMFGx/a2BhrbuLieYfMOZ7mnPVBqiyfixH85E3L3L8qI0zO9c/fkD1lMkTx2vzo+sV/ETo
	8PDTy3VAA1Oogt8z9sPRhsmi/BXMJdKUF4Pd7TGLrbvTBswOSyuI0JxhCzzUwdVZfWD3IBLyQEp
	0Iacs2ql06tzd5zP5ZtSJ7BOC/n44KxPYTcWlWH+Oefxo4vmQ5G3sV5a0ilqZ6uSr7mUOIe58fZ
	aB+ruMcbpEefKIKrUe/+lJqi2ztpYmOmPxXl0oAXTMyD/m3D0EdiN+nyzTymEjJbAXdxNLr2wJC
	c19XSQENhCtruY5yE6w/MbVNbphtphGGlmUMhkJ8i7hSawCBmwuwIVpgg4sbDjgg7K4h92Lyjyi
	PZ1Z8zQ+cTlLrYNTIUi//m6KvqL1zCvqPQROyINTWqZlWlS1POJV8Txf0w8xFSgpVfWrGmv9x93
	J1JGzoXtMrVqa2N7CSb7vRPFsVFBXL7VUhg1Ssgh40ScQIg35oY7
X-Received: by 2002:ac8:5c8a:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-54e100e5abbmr22180261cf.3.1793944097227;
        Thu, 05 Nov 2026 21:48:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26f1bd64sm11903521cf.23.2026.11.05.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:48:16 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vhost-scsi: do not validate vrings during endpoint teardown
Date: Fri,  6 Nov 2026 00:48:07 -0500
Message-ID: <20261106054811.281798-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_clear_endpoint() checks every virtqueue with
vhost_vq_access_ok() before disabling the backends and waiting for
in-flight SCSI commands.  If that check fails, endpoint teardown is
skipped.

vhost_scsi_release() ignores the error and frees the vhost-scsi state.
vhost_dev_stop() drains vhost work, but it does not wait for commands
owned by the target core.  A later command or TMF completion can therefore
dereference its saved virtqueue pointer after the virtqueue has been freed.

Vring access is not a prerequisite for tearing an endpoint down.  Remove
the check so teardown always disables the backends and waits for in-flight
commands before releasing their state.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/vhost/scsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index e44044449cef..f0966f25b09a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2194,17 +2194,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	struct vhost_scsi_tpg *tpg;
 	struct vhost_virtqueue *vq;
 	bool match = false;
-	int index, ret, i;
+	int ret, i;
 	u8 target;
 
 	mutex_lock(&vs->dev.mutex);
-	/* Verify that ring has been setup correctly. */
-	for (index = 0; index < vs->dev.nvqs; ++index) {
-		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
-			ret = -EFAULT;
-			goto err_dev;
-		}
-	}
 
 	if (!vs->vs_tpg) {
 		ret = 0;
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146320;
	b=SH6HF2nOdJAfmt0ws+oB2YzSW5hBet/a+GcvyNk/n3v0H7nrENh777h/OP6U3XJ/pnlR
	 yacpDwnE7ZqD/gcVhJpFDioMZpWvikLvFUOCB7zUTlBdRsqcAQAH9wi1cu3PU96H33BO+
	 qk+xTMB77TCwaIUVEVRWglJNsnFhR0lMfdgJ7U/OmEqXPaQMeY3nZGrsPq0jJNT2cYJWN
	 /NQ3F9QpXL67YYdvOtSjXDTaiQJewmoXlJK7sa5leWPkID1+nyD4cXPUyGYaoCSmAZctJ
	 w8X123xrEprKPaLa83E5pwZ4SnIRRii2OAJHkuITAVi8CvmA+J1vD04wL/dWuTuE71Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
	b=LJNItqGkG8d/ZY65VUBT0LJ/NdYOJvJdoFrbIo/ksuvIJ4tNKUE5Qtg0YDLlCAtnPFEY
	 GCoXFOqG/8SJGyMjUWmoyTDKQvhQrNDa1Oo77GECFWPrQ0/8k0EEvUvc9pGTfBJL/Pg0X
	 /+nA5x/HnFYgurJMVLeQrM2VjXUl98NCTLsQJoKm5uyLCKThN9O13tsIQRh7hO0PZsNH4
	 Kp7oTXQ1jTf06dkwWOlOf8VaoEp+nJccsse7kgnHUVATE555ddmyH++AzbdkN1LoTQYCr
	 G7Va85GOxHvtVhkTrfjuuzJJpUfhAguPjNQd74gSaWwEqdh4wWfIj/4qEqmr/afzKXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQkYe8Zd;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544A606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 13:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A544A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQkYe8Zd
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2fcaafb7so6228a12.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794146319; x=1794751119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
        b=EQkYe8ZdPkUeGqboo2iK7mGeLqDzWCoAGng3wkiYi877Nf8KuE5auFTRr5RIyDRRUf
         PPq/NLwrBQiNwh+slCOvOj0N/G2z7ryveVPh1cUQEUdGkYdMleXhTsyO8JO2TtCo46sP
         mbGe3hFq4RLgiIBFSI5RSRUibbVrSqW8wrvv5a7lg02/gaKUODQNzLk9IHgHSQYwVX8l
         v6H6fF6VyaivYzjFQSh5Ft//rBeec++HJPWSjtvhFksglGEaQVfjX/jZSKjXlCugwvzh
         NCJ351LMPAhFjigP6IcuRHfUiZTP9z4HVZ5cTddTb/kmZRso4nV5PTv8TlSdPMBjF5kG
         nuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794146319; x=1794751119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
        b=kZPmz7riamEXx1TlNSS8w76DiwHCTE0bpybAqi9fci4M7e+rzVusivLMhPKjzb91/j
         WMbA1PUdpTcNUDxEfSpEsUapeDHyyC8m4W9nPGvrovbgtbWJQmWwpkNlNdULD6+EgF/Q
         XAm3sdvxi2FkPex+o7wVQ4FDulI8E7VwAc+1M1zgIi9euObCAiZmwaOnJfJ89YReoLEZ
         Wq+wBgeGY3iPJ3fGpAG5b9FtJdfi8sMNNseofEgYeOqyOM2WFzI31QClwTmt2Vf+oSra
         UYABzCE3WIGsjv6lADNKUByBGrSPdBSYvMIFioCNEdZ7/XdkgDBwgLe7BtOoGtlrj7cf
         ePqQ==
X-Forwarded-Encrypted: i=1; AL+hErHwVxsBL5YncBiSnDNdw/C4A6kRNtoynLIq32OUORIq77gWBPvY3fl1nWkvFbbr1Bq1Jus1tFAMw1tFTkWLFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3S1uqs+Z8DRaf0QWi1eFbFXeij3sZYBT53tim4KkJZ2X5eVp8
	lTOGPEIwnJ0uTVnjnsWV4QjcYKXO0uMLvasIac6ADk7A37Gd1GRAIAg6FGhRPHBsFbEUXw==
X-Gm-Gg: AYBFou2g1OkeBGvZsI45ihTREaKLvQF4ieS7LdUHev5jvIegcqEb1TPDLTQz4BY9Sxc
	jYaagp5kNdJaNYJb1gMKJulOcQwlDPHGkUarfZx6YfDDuh4crCZPgx42XbMxpT8pIO+ujyjF94i
	/kQ4SuVDV9lFc4uNdvn38Cjww3da7bJRefvmVlKJgH3fzipUEPKUo64GpYbTJ+X20U5gB53CAnw
	13ceIfRdHI6XEaDSlSH5KWbnEjup1ElggAEbrMp+vEtG2GDvdJDKHWBR4d2rhN5mcflqvH0+gtm
	oNf1uqiFQOePwBopreh7KoAn5od51pNnPbWKk+JJFjS+eYKNgK2cM8wwjyIHQZE/ifaO93M+LBh
	8IJ9r2hS0ylkvl4MCgPPkbFWiYsLykrv9oHrMEZf6MfaEJzhAyq8JLc+PCdSUcfGHoIcJWNzdjc
	BnFvDSGfh+HSQaJ+7NrV+eKsgF7o6FP4xdsASYviL0Elh4fZmYGZNRUdxX+ejWxzxG6f5FpdKcW
	Btb2ALiCL5pIe27x7aMyycOODNGh3qt6nyFk23QJZlyLxR+s8OwTyD13CxyHxCoi84H6ptlMIk/
	ShWTzSuAgnO+OIZBIL4N2eilxy/NlPumXZm9H8ezcrnHC4ZauQEh/ggni27+HDeHJ9ctV+o9WpP
	OgmAGKYZwRyami6mfOILz7DA=
X-Received: by 2002:a17:90b:3912:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b12d4c5f3cmr2106208a91.6.1794146318912;
        Sun, 08 Nov 2026 05:58:38 -0800 (PST)
Received: from localhost.localdomain ([14.150.132.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96969220sm647168a12.27.2026.11.08.05.58.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 05:58:38 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fuse: virtio-fs: stop new requests before draining queues
Date: Sun,  8 Nov 2026 21:58:30 +0800
Message-ID: <20261108135830.29924-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
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

virtio_fs_conn_destroy() drains the virtqueues and then calls
fuse_conn_destroy(), which aborts the connection.  The abort ends every
request the fuse device still owns, and each ended request is freed as
soon as its waiter wakes up.

The drain only covers the requests that were already counted in
fsvq->in_flight when it started.  A request submitted after it returns is
not covered, but is still handed to the device before the abort runs:

  CPU 0 (umount)                     CPU 1
  ---------------------------------  --------------------------------
  virtio_fs_drain_all_queues()
    /* in_flight drops to 0 and
       the drain returns */
                                     virtio_fs_enqueue_req()
                                       virtqueue_add_sgs()
                                       inc_in_flight_req() -> 1
  fuse_conn_destroy()
    fuse_send_destroy()
    fuse_chan_abort()
      /* ends and frees the
         request above */
    fuse_chan_wait_aborted()
                                     /* the device still owns the
                                        virtqueue descriptors and
                                        DMA-writes into the freed
                                        request and its argbuf */

Stop admitting requests on each queue before that queue is drained.
The flag is set per queue, but that is sufficient: each queue is
drained after its own flag is set, and request admission,
virtqueue_add_sgs() and, on the submission path, the in_flight
increment are serialized by the same fsvq->lock.  A request is
therefore either rejected before the device can see it, or already
counted in fsvq->in_flight and covered by the drain.  There is no
window in between.

Rejected requests use the existing -ENOTCONN error path and are ended by
virtio_fs_request_dispatch_work() through end_reqs, so no new request
completion or ownership state is introduced.  Nothing has to be
discarded in the completion path, and fsvq->in_flight remains the only
state that has to be tracked.

The new state is not folded into fsvq->connected because the request
queues have to stay usable: fuse_conn_destroy() sends FUSE_DESTROY
through them, with args.force set so that fuse_simple_request() waits
for the reply.  Clearing fsvq->connected would make that request fail
with -ENOTCONN and the server would never see the destroy.

FUSE_DESTROY is the sole exception while aborting is set.  It is sent
only after the first drain, and its completion is waited for before
fuse_chan_abort() can end requests, so the destroy is the only request
the device sees after the drain.  virtio-fs exposes no userspace
/dev/fuse fd (and no_control disables the fusectl interface), so
userspace cannot inject another request.

virtio_fs_start_all_queues() clears the flag, so a mount that follows an
unmount starts with admission enabled again.

Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
V1 -> V2:
- prevent new requests from reaching the virtqueue at teardown time
  instead of skipping completions of aborted requests
- keep FUSE_DESTROY working: it is the teardown request and is waited
  for before fuse_chan_abort()
- drop the per-vq aborted flag and the completion-skip branch
 fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac6..c6d2120157340 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	bool aborting; /* reject new requests except FUSE_DESTROY */
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -348,6 +349,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		fsvq = &fs->vqs[i];
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
+		fsvq->aborting = false;
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -1226,6 +1228,28 @@ static void virtio_fs_stop_all_queues(struct virtio_fs *fs)
 	}
 }
 
+/*
+ * Stop admitting new requests before draining the queues.  Admission and
+ * virtqueue submission are serialized by fsvq->lock, so a request is
+ * either rejected before reaching the device or accounted in in_flight
+ * and covered by the drain.
+ *
+ * FUSE_DESTROY is exempt because fuse_conn_destroy() sends it after the
+ * first drain and waits for its completion before aborting the channel.
+ */
+static void virtio_fs_stop_new_requests(struct virtio_fs *fs)
+{
+	struct virtio_fs_vq *fsvq;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fsvq = &fs->vqs[i];
+		spin_lock(&fsvq->lock);
+		fsvq->aborting = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 static void virtio_fs_remove(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs = vdev->priv;
@@ -1479,7 +1503,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	spin_lock(&fsvq->lock);
 
-	if (!fsvq->connected) {
+	if (!fsvq->connected ||
+	    (fsvq->aborting && req->in.h.opcode != FUSE_DESTROY)) {
 		spin_unlock(&fsvq->lock);
 		ret = -ENOTCONN;
 		goto out;
@@ -1669,6 +1694,9 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
 	spin_lock(&fsvq->lock);
 	fsvq->connected = false;
 	spin_unlock(&fsvq->lock);
+
+	/* Nothing may be queued after the drain below */
+	virtio_fs_stop_new_requests(vfs);
 	virtio_fs_drain_all_queues(vfs);
 
 	fuse_conn_destroy(fm);
-- 
2.54.0 (Apple Git-157)


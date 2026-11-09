Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192009;
	b=w65D7oOihZ/LCMumLdIzOpH67qx6R2dZHz6dklCaHSO7KGWD83grHYGuQzsGtl4SUa9q
	 6ib6FWjsYgCk+AkI3U9oak4CTMvZMxu19iJL94oo0YCFzm4EqG6yP2uduQ+U02GfL13Oa
	 2aUB6Q5k8Z9gZ4WaxUyD7tVTDopsZn6UZH4MuLh+OkQ9RRAYhvZBLHBepK0BTcIDI0uMe
	 jyyYqTW2LTCxari5Kcr8zDyjAA/qI1IC+isl05RrvZ3JfOlUDowPynZ4mVFNrUYOrhOMQ
	 RrMcEYbhbtJmRQEb/9WRZdgbJ94xqLyZX22OaiFX/Fo91bLWnHLFFyTkns4z/bdOJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
	b=WLQW+0F8kUSxD3RG3fJ7tJOHKDnC2tiY//eQB3v9IlCrAFq/y0m3mLplddRz/2BIydR/
	 pbLlzWRUJdO2KFRT6L4XUpSY/rB2y+8RcSM+nnRsSZVL6W/csZZIL6G2veD2Q+zu3HYKq
	 90b+fkqr76GGhgZ1XP7GeHlkEkQxKKAGCPCleOQR9HgUq4athro4luvYAgPYARqSh+7Tu
	 YPAMvG3bYxzzRn43lSf+AZYPK+8o+e/RyWlNiIbo2O9AiRvRjH0JrjS31i4MwT3ssf/eb
	 4NXR4snT2Ub4YJCltOMqrNqEQixEDkHUaU+lRZthXbJwMALjjz+7RkyYm7ihFHCNS6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cFAJ4/cH";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFA606A331
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 02:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DAFA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFAJ4/cH
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea63087d6eso625645ad.3
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 18:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794192008; x=1794796808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
        b=cFAJ4/cHaVHD4zi9cuk65SvBwQz/gqSHQHDyWYKnBdi/or+TZ9nytIT2YangvE30GN
         nWkSvFTx+hEou6Gs8xZjq608AZwDpKTa+V+MxbYmaF9mpW1yN7e4uGdp0YFaUL416MJs
         z6f7QFlRxX63WHhS6d6UWFtPd0Ke18bwolyUluv2MQOuGzFvpsdo3OZ6DTXSKVUxS0Rh
         1XzbslPsw9KNQj1byBVkRM/WlC1maAlbDgFeDvwodm6dHHH2RMakFjFVsXhVymSPk2cj
         i99+UPVshHV28PEtH9HLNr52jIk3hOhg99T6nq/dxukqpKT+IR/UH1JhSjKKtnf/4oox
         wNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192008; x=1794796808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
        b=TJpcXnEROxOewXXxysYKozl3HSXnBuEVJelORZhzrBClM6e6x/XCIQ73K+4JzjUqai
         hYKl2LOmA1jxkq/4KBtpBWRRvyX7zGc415NnuUI1/CWUnlqi39QCq9Rh3z5xsXHl5XEK
         qxT/GOCoHx7eKRg+vsyQE68usF3km+qG2d0c6e4HB33aEseS9NXruyOEDUyEnsDTFwbd
         uR6YS+OU7DzQOZ8l0Ftrz1+CNTXnanAJVRE7v9G9eVahtyJumzSWHB9p6c90vCGQxO/6
         CbbVmXnITLG/p15r4pRiwYKLZ69lZ/Dh0ZK5+BXmgGWJb2RD2mUdDyIDs5aq7keud2N+
         BEDw==
X-Forwarded-Encrypted: i=1; AL+hErHPdQXbe/vEAucg63RYwxJnoulVJC9rJmrx7HDh+oxa6SsFiG8aJL77HGMB2If/rY2ugmBw3FNK1FMN+JrkgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+WJPBmQQpSAF7GYJoKKmiZdkRv//Et+KGNYmPukmRzS6nyNKEY
	wXPOE1jMU3kLRqZofxuGEL+krgHx/vbgVomwFSH87947PiJuTND8DV6S
X-Gm-Gg: AYBFou3IQjgRDOX1ebUuWqkQxUksXs/nSM+FbOhaYMfHt8ceKuX/ZeJRYkp7qIz2f14
	0/4l6mXtdCEHHUwNRVZdiL86nMxnLj0tuPEnjObWL2GrFAD8xXDKiSsyLrEk1jVET9bK/hwPl8A
	eibh64iPhUSkl/Ghf7mBr4vy8HbCIrAkIJLM2xVAJLteyIeMOYKLE8rv29w/z20y3Gj6MwV93hy
	HRngFveV7X3WjQnM41ofzD/Fc1L0mZHinJ4TRA3jngyyCQA5FNfypkTjC3l+P3wZSXtHKZ6ayGl
	kEg59y0l8HXAz5M2kbkY8XEV3tNpNT5iDk34ISNjC+kKTp0WgiuNklC/13sn+7n4S78l3Ih2zW3
	TCFsNUbqH+EiYMkzu8VV1ijUNqvajukyahn6nTUK6oO8Vuhv9gYWj8rPmpAD6/t/dSfJVjgUgrv
	V4MvH7CfdlqnW9Dw5AWXrDoqBEXWDDOQrq/NQNJxdWxnE7EgZSNqqGpdbkG1FhslzEESanZAo5r
	+VBg5Modjd3c4oKMxsHAiw/HGEsABATq+8so+7lNiRbeOUWVtDrOHRRoBuO964c5qvoR724nC4l
	glQgTZqpRRI+Myj9AUTwUOWwpc8YFjtqf5oacBZAAlSRGU5ULjQeRagRRRyt7yeWJEhuthBgKWY
	Z26tcup0+XX4RewQV
X-Received: by 2002:a17:903:2289:b0:2df:8ab7:fe3a with SMTP id d9443c01a7336-2ed83786890mr43450945ad.4.1794192008326;
        Sun, 08 Nov 2026 18:40:08 -0800 (PST)
Received: from localhost.localdomain ([139.159.170.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81600c3esm6172515ad.34.2026.11.08.18.40.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 18:40:07 -0800 (PST)
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
Subject: [PATCH v3] fuse: virtio-fs: stop new requests before draining queues
Date: Mon,  9 Nov 2026 10:39:57 +0800
Message-ID: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
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

Stop admitting requests on each queue before draining begins.  The flag
is set per queue, but that is sufficient: request admission,
virtqueue_add_sgs() and, on the submission path, the in_flight
increment are serialized by the same fsvq->lock.  A request is
therefore either rejected before the device can see it, or already
counted in fsvq->in_flight and covered by the drain.  There is no
window in between.

Rejected requests use the existing -ENOTCONN error path and are ended by
virtio_fs_request_dispatch_work() through end_reqs, so no new request
completion or ownership state is introduced.  Nothing has to be
discarded in the completion path, and fsvq->in_flight remains the only
per-queue accounting state.

The -ENOSPC path needs the same admission check.  virtio_fs_enqueue_req()
drops fsvq->lock before returning -ENOSPC, and the caller queues the
request in a second critical section; teardown can finish in between and
leave the request stranded on queued_reqs, which nothing drains.
Re-check connected/aborting before queueing, in both the submission path
and the dispatch worker.  After aborting is set, no request can newly
enter queued_reqs or the virtqueue, except the explicitly permitted
FUSE_DESTROY path.

Rejected requests are ended by virtio_fs_request_dispatch_work().  If
their end callback may block (a DAX release), ending them inline can
deadlock: the callback may issue a synchronous request that needs the
same worker.  Offload those endings to a separate work item, like the
device completion path already does.

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

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
V2 -> V3:
- re-check admission before queueing on -ENOSPC, in virtio_fs_send_req()
  and in the dispatch worker, so teardown cannot strand a request on
  queued_reqs
- offload may_block request endings in the dispatch worker to avoid a
  self-deadlock through fuse_simple_request()
- add Fixes: and Cc: stable
V1 -> V2:
- prevent new requests from reaching the virtqueue at teardown time
  instead of skipping completions of aborted requests
- keep FUSE_DESTROY working: it is the teardown request and is waited
  for before fuse_chan_abort()
- drop the per-vq aborted flag and the completion-skip branch
 fs/fuse/virtio_fs.c | 104 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac6..a46536c9fdc8e 100644
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
@@ -97,6 +98,11 @@ struct virtio_fs_req_work {
 	struct work_struct done_work;
 };
 
+struct virtio_fs_end_work {
+	struct work_struct work;
+	struct fuse_req *req;
+};
+
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight,
 				 gfp_t gfp);
@@ -348,6 +354,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		fsvq = &fs->vqs[i];
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
+		fsvq->aborting = false;
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -551,6 +558,39 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	spin_unlock(&fsvq->lock);
 }
 
+static void virtio_fs_end_req_work(struct work_struct *work)
+{
+	struct virtio_fs_end_work *w =
+		container_of(work, typeof(*w), work);
+
+	fuse_request_end(w->req);
+	kfree(w);
+}
+
+/*
+ * A request rejected during teardown can have an end callback that may
+ * block (DAX release).  Ending it inline in virtio_fs_request_dispatch_work()
+ * can deadlock: the callback may issue a synchronous request whose
+ * completion needs the same dispatch_work that is currently blocked.
+ * Offload it, like the device completion path does.
+ *
+ * virtio_fs_request_complete() cannot be reused here: it also consumes
+ * argbuf and drops in_flight, while a rejected request has neither.
+ */
+static void virtio_fs_end_req(struct fuse_req *req)
+{
+	if (req->args->may_block) {
+		struct virtio_fs_end_work *w;
+
+		w = kzalloc_obj(*w, GFP_NOFS | __GFP_NOFAIL);
+		INIT_WORK(&w->work, virtio_fs_end_req_work);
+		w->req = req;
+		schedule_work(&w->work);
+	} else {
+		fuse_request_end(req);
+	}
+}
+
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
 	struct fuse_req *req;
@@ -570,7 +610,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
-		fuse_request_end(req);
+		virtio_fs_end_req(req);
 	}
 
 	/* Dispatch pending requests */
@@ -593,9 +633,17 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		if (ret < 0) {
 			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
-				list_add_tail(&req->list, &fsvq->queued_reqs);
-				spin_unlock(&fsvq->lock);
-				return;
+				if (!fsvq->connected ||
+				    (fsvq->aborting &&
+				     req->in.h.opcode != FUSE_DESTROY)) {
+					spin_unlock(&fsvq->lock);
+					ret = -ENOTCONN;
+				} else {
+					list_add_tail(&req->list,
+						      &fsvq->queued_reqs);
+					spin_unlock(&fsvq->lock);
+					return;
+				}
 			}
 			req->out.h.error = ret;
 			spin_lock(&fsvq->lock);
@@ -603,7 +651,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 			spin_unlock(&fsvq->lock);
 			pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n",
 			       ret);
-			fuse_request_end(req);
+			virtio_fs_end_req(req);
 		}
 	}
 }
@@ -1226,6 +1274,28 @@ static void virtio_fs_stop_all_queues(struct virtio_fs *fs)
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
@@ -1479,7 +1549,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	spin_lock(&fsvq->lock);
 
-	if (!fsvq->connected) {
+	if (!fsvq->connected ||
+	    (fsvq->aborting && req->in.h.opcode != FUSE_DESTROY)) {
 		spin_unlock(&fsvq->lock);
 		ret = -ENOTCONN;
 		goto out;
@@ -1551,12 +1622,22 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 			/*
 			 * Virtqueue full. Retry submission from worker
 			 * context as we might be holding fc->chan->bg_lock.
+			 * Re-check admission under the same lock that
+			 * increments in_flight: teardown may have started
+			 * between enqueue_req() dropping its lock and here.
 			 */
 			spin_lock(&fsvq->lock);
-			list_add_tail(&req->list, &fsvq->queued_reqs);
-			inc_in_flight_req(fsvq);
-			spin_unlock(&fsvq->lock);
-			return;
+			if (!fsvq->connected ||
+			    (fsvq->aborting &&
+			     req->in.h.opcode != FUSE_DESTROY)) {
+				spin_unlock(&fsvq->lock);
+				ret = -ENOTCONN;
+			} else {
+				list_add_tail(&req->list, &fsvq->queued_reqs);
+				inc_in_flight_req(fsvq);
+				spin_unlock(&fsvq->lock);
+				return;
+			}
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
@@ -1669,6 +1750,9 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
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


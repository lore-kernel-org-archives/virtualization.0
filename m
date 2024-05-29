Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31C149E1B
	for <virtualization@lists.linux.dev>; Wed, 29 May 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997940; cv=none; b=Xr3+EFphhyVR1qJKlVmES3rmHarG5Xb8zVVDhRIncdwEUXo7HfeYAvDi6YClmgfw+vwFazr1gVVqMxHD6kUGEND0MazRe1ns/Q5ZClT3JveAc63x68xs0SoIrCchs79hUufCXjh3Iq5V9ipQ6WZdW/BQXbYZYnOUsWZagnLZnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997940; c=relaxed/simple;
	bh=p8Tb3gshbO3BSSTq7C6N9XqmIAMLUqoqzFs88UdaLCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyjq6W0gxej88zILPkWLBZ1ocgpFyYdhnTjMJZF1fMYnRzfdsRMEaXJAuLcjFfgTf/IUe27o24kNhff504IFpuGmjreWqq0w69iYnwdCPmzTfFmpNGJWP3BnCDxW16ru94x5SGwocrfKRGQZVgE3SdEiOqTEcVjGMtVDH4jFVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMD2+41r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMD2+41r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716997937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H9Uoik3NzbmkkQclNlS42pyk0/WlH7KPv+sK60a0CCI=;
	b=bMD2+41r+1DcF7UTspqbMrq4y8Zwf6D05a4sxlY7L3z0ciZJHb/eFDWoGw0Z0MsdZ/Aq5J
	A7/pVHVcLtAyTyaZ+dkFckl4oMKYYf/FKGNrC7HVG4vwf6tNqSZqEI4wAS1GDE+5n0fNuT
	U0J/XbFFxjjAK+Z6e8UGnc2lkKIUVTo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-96KBZVf6N_aqpPaesmamhA-1; Wed, 29 May 2024 11:52:15 -0400
X-MC-Unique: 96KBZVf6N_aqpPaesmamhA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e95a1f049aso16815211fa.0
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 08:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997934; x=1717602734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9Uoik3NzbmkkQclNlS42pyk0/WlH7KPv+sK60a0CCI=;
        b=gzgYwH7E4cuM6s2eLGGRjQ+oGqknVP6mVlJDSBxR+yRhxjkQspKsL7m5F/lxfyrrEe
         OhSsHP66rjsh2VHE0CEWEY0JnyiW49cqe/Vyvq9+VYlx0ibaxHIckhSy/sCiv57MF9Ve
         MzntQm75r9lc86t+AeTW1uUvt6GBDiUMbNTQ09XpPBRWCfPXVbHnHFNLWHENZRWJuqUe
         uVvKa8mPaDn/k0/Dk43SnUTd4d2aXzqnBSrd0POP6HhUSFV9bRCi09vs4bnNLXTrNvqv
         38CnHVPCj+TlBUnUIqxH8EC8nt/LCkaVDPuWWrIoMlFK0K+t/oj7+GraYT21IeC01kH1
         smmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpgFvvLExQfULvYVapBAAXsmhqLV9IPcjo3qrPi8svywUvhC7rdf1n1bX4AaqTju+Kksumq+Md3wIpNaSEH87jMYRBQkNLZVTwo+VNxio=
X-Gm-Message-State: AOJu0Yy0nAQEjvhrjH5aB6M0tNzD3jRReHOaOF64Fmd5ESv+XrkXBrMz
	n+opmROjO4kW6lFKuzatz5Kl0V+G1X729slYsv6dWTlEuAo7BmQe2nfnovKnxj2iqLNak3ioYbP
	s0zFfCfaBwMJqmoLbR1vaDfIs7xmz23Zh0dHIEIR8fo2wiapEhDON23crA8yhSnmW
X-Received: by 2002:a19:5f54:0:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5296594cc1cmr11250853e87.16.1716997933689;
        Wed, 29 May 2024 08:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHemKxhsnwAh97zQdmrHsA1/gBzB3lzh+mhZ4ag3314JuPbgcAdQOIr9GpbPgn0Xpm9UZ6Lew==
X-Received: by 2002:a19:5f54:0:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5296594cc1cmr11250827e87.16.1716997933143;
        Wed, 29 May 2024 08:52:13 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-156.pool.digikabel.hu. [89.148.117.156])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a64a03e574dsm81532666b.14.2024.05.29.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:52:11 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yoray Zack <yorayz@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] fuse: cleanup request queuing towards virtiofs
Date: Wed, 29 May 2024 17:52:07 +0200
Message-ID: <20240529155210.2543295-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Virtiofs has its own queing mechanism, but still requests are first queued
on fiq->pending to be immediately dequeued and queued onto the virtio
queue.

The queuing on fiq->pending is unnecessary and might even have some
performance impact due to being a contention point.

Forget requests are handled similarly.

Move the queuing of requests and forgets into the fiq->ops->*.
fuse_iqueue_ops are renamed to reflect the new semantics.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c       | 159 ++++++++++++++++++++++++--------------------
 fs/fuse/fuse_i.h    |  19 ++----
 fs/fuse/virtio_fs.c |  41 ++++--------
 3 files changed, 106 insertions(+), 113 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..a4f510f1b1a4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -192,10 +192,22 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-u64 fuse_get_unique(struct fuse_iqueue *fiq)
+static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
 {
 	fiq->reqctr += FUSE_REQ_ID_STEP;
 	return fiq->reqctr;
+
+}
+
+u64 fuse_get_unique(struct fuse_iqueue *fiq)
+{
+	u64 ret;
+
+	spin_lock(&fiq->lock);
+	ret = fuse_get_unique_locked(fiq);
+	spin_unlock(&fiq->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fuse_get_unique);
 
@@ -215,22 +227,67 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 }
 
+static void fuse_dev_queue_forget(struct fuse_iqueue *fiq, struct fuse_forget_link *forget)
+{
+	spin_lock(&fiq->lock);
+	if (fiq->connected) {
+		fiq->forget_list_tail->next = forget;
+		fiq->forget_list_tail = forget;
+		fuse_dev_wake_and_unlock(fiq);
+	} else {
+		kfree(forget);
+		spin_unlock(&fiq->lock);
+	}
+}
+
+static void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
+{
+	spin_lock(&fiq->lock);
+	if (list_empty(&req->intr_entry)) {
+		list_add_tail(&req->intr_entry, &fiq->interrupts);
+		/*
+		 * Pairs with smp_mb() implied by test_and_set_bit()
+		 * from fuse_request_end().
+		 */
+		smp_mb();
+		if (test_bit(FR_FINISHED, &req->flags)) {
+			list_del_init(&req->intr_entry);
+			spin_unlock(&fiq->lock);
+		}
+		fuse_dev_wake_and_unlock(fiq);
+	} else {
+		spin_unlock(&fiq->lock);
+	}
+}
+
+static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
+{
+	spin_lock(&fiq->lock);
+	if (fiq->connected) {
+		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+			req->in.h.unique = fuse_get_unique_locked(fiq);
+		list_add_tail(&req->list, &fiq->pending);
+		fuse_dev_wake_and_unlock(fiq);
+	} else {
+		spin_unlock(&fiq->lock);
+		req->out.h.error = -ENOTCONN;
+		fuse_request_end(req);
+	}
+}
+
 const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
-	.wake_forget_and_unlock		= fuse_dev_wake_and_unlock,
-	.wake_interrupt_and_unlock	= fuse_dev_wake_and_unlock,
-	.wake_pending_and_unlock	= fuse_dev_wake_and_unlock,
+	.send_forget	= fuse_dev_queue_forget,
+	.send_interrupt	= fuse_dev_queue_interrupt,
+	.send_req	= fuse_dev_queue_req,
 };
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
-static void queue_request_and_unlock(struct fuse_iqueue *fiq,
-				     struct fuse_req *req)
-__releases(fiq->lock)
+static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
-	list_add_tail(&req->list, &fiq->pending);
-	fiq->ops->wake_pending_and_unlock(fiq);
+	fiq->ops->send_req(fiq, req);
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
@@ -241,15 +298,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
 
-	spin_lock(&fiq->lock);
-	if (fiq->connected) {
-		fiq->forget_list_tail->next = forget;
-		fiq->forget_list_tail = forget;
-		fiq->ops->wake_forget_and_unlock(fiq);
-	} else {
-		kfree(forget);
-		spin_unlock(&fiq->lock);
-	}
+	fiq->ops->send_forget(fiq, forget);
 }
 
 static void flush_bg_queue(struct fuse_conn *fc)
@@ -263,9 +312,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		req = list_first_entry(&fc->bg_queue, struct fuse_req, list);
 		list_del(&req->list);
 		fc->active_background++;
-		spin_lock(&fiq->lock);
-		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request_and_unlock(fiq, req);
+		fuse_send_one(fiq, req);
 	}
 }
 
@@ -335,29 +382,12 @@ static int queue_interrupt(struct fuse_req *req)
 {
 	struct fuse_iqueue *fiq = &req->fm->fc->iq;
 
-	spin_lock(&fiq->lock);
 	/* Check for we've sent request to interrupt this req */
-	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
-		spin_unlock(&fiq->lock);
+	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags)))
 		return -EINVAL;
-	}
 
-	if (list_empty(&req->intr_entry)) {
-		list_add_tail(&req->intr_entry, &fiq->interrupts);
-		/*
-		 * Pairs with smp_mb() implied by test_and_set_bit()
-		 * from fuse_request_end().
-		 */
-		smp_mb();
-		if (test_bit(FR_FINISHED, &req->flags)) {
-			list_del_init(&req->intr_entry);
-			spin_unlock(&fiq->lock);
-			return 0;
-		}
-		fiq->ops->wake_interrupt_and_unlock(fiq);
-	} else {
-		spin_unlock(&fiq->lock);
-	}
+	fiq->ops->send_interrupt(fiq, req);
+
 	return 0;
 }
 
@@ -412,21 +442,15 @@ static void __fuse_request_send(struct fuse_req *req)
 	struct fuse_iqueue *fiq = &req->fm->fc->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
-	spin_lock(&fiq->lock);
-	if (!fiq->connected) {
-		spin_unlock(&fiq->lock);
-		req->out.h.error = -ENOTCONN;
-	} else {
-		req->in.h.unique = fuse_get_unique(fiq);
-		/* acquire extra reference, since request is still needed
-		   after fuse_request_end() */
-		__fuse_get_request(req);
-		queue_request_and_unlock(fiq, req);
 
-		request_wait_answer(req);
-		/* Pairs with smp_wmb() in fuse_request_end() */
-		smp_rmb();
-	}
+	/* acquire extra reference, since request is still needed after
+	   fuse_request_end() */
+	__fuse_get_request(req);
+	fuse_send_one(fiq, req);
+
+	request_wait_answer(req);
+	/* Pairs with smp_wmb() in fuse_request_end() */
+	smp_rmb();
 }
 
 static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
@@ -581,7 +605,6 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 {
 	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fm->fc->iq;
-	int err = 0;
 
 	req = fuse_get_req(fm, false);
 	if (IS_ERR(req))
@@ -592,16 +615,9 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 
 	fuse_args_to_req(req, args);
 
-	spin_lock(&fiq->lock);
-	if (fiq->connected) {
-		queue_request_and_unlock(fiq, req);
-	} else {
-		err = -ENODEV;
-		spin_unlock(&fiq->lock);
-		fuse_put_request(req);
-	}
+	fuse_send_one(fiq, req);
 
-	return err;
+	return 0;
 }
 
 /*
@@ -1076,9 +1092,9 @@ __releases(fiq->lock)
 	return err ? err : reqsize;
 }
 
-struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
-					     unsigned int max,
-					     unsigned int *countp)
+static struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
+						    unsigned int max,
+						    unsigned int *countp)
 {
 	struct fuse_forget_link *head = fiq->forget_list_head.next;
 	struct fuse_forget_link **newhead = &head;
@@ -1097,7 +1113,6 @@ struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
 
 	return head;
 }
-EXPORT_SYMBOL(fuse_dequeue_forget);
 
 static int fuse_read_single_forget(struct fuse_iqueue *fiq,
 				   struct fuse_copy_state *cs,
@@ -1112,7 +1127,7 @@ __releases(fiq->lock)
 	struct fuse_in_header ih = {
 		.opcode = FUSE_FORGET,
 		.nodeid = forget->forget_one.nodeid,
-		.unique = fuse_get_unique(fiq),
+		.unique = fuse_get_unique_locked(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
@@ -1143,7 +1158,7 @@ __releases(fiq->lock)
 	struct fuse_batch_forget_in arg = { .count = 0 };
 	struct fuse_in_header ih = {
 		.opcode = FUSE_BATCH_FORGET,
-		.unique = fuse_get_unique(fiq),
+		.unique = fuse_get_unique_locked(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
@@ -1822,7 +1837,7 @@ static void fuse_resend(struct fuse_conn *fc)
 	spin_lock(&fiq->lock);
 	/* iq and pq requests are both oldest to newest */
 	list_splice(&to_queue, &fiq->pending);
-	fiq->ops->wake_pending_and_unlock(fiq);
+	fuse_dev_wake_and_unlock(fiq);
 }
 
 static int fuse_notify_resend(struct fuse_conn *fc)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..33b21255817e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -449,22 +449,19 @@ struct fuse_iqueue;
  */
 struct fuse_iqueue_ops {
 	/**
-	 * Signal that a forget has been queued
+	 * Send one forget
 	 */
-	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
-		__releases(fiq->lock);
+	void (*send_forget)(struct fuse_iqueue *fiq, struct fuse_forget_link *link);
 
 	/**
-	 * Signal that an INTERRUPT request has been queued
+	 * Send interrupt for request
 	 */
-	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
-		__releases(fiq->lock);
+	void (*send_interrupt)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
 	/**
-	 * Signal that a request has been queued
+	 * Send one request
 	 */
-	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
-		__releases(fiq->lock);
+	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
 	/**
 	 * Clean up when fuse_iqueue is destroyed
@@ -1053,10 +1050,6 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
-struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
-					     unsigned int max,
-					     unsigned int *countp);
-
 /*
  * Initialize READ or READDIR request
  */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1a52a51b6b07..690e508dbc4d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1089,22 +1089,13 @@ static struct virtio_driver virtio_fs_driver = {
 #endif
 };
 
-static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
-__releases(fiq->lock)
+static void virtio_fs_send_forget(struct fuse_iqueue *fiq, struct fuse_forget_link *link)
 {
-	struct fuse_forget_link *link;
 	struct virtio_fs_forget *forget;
 	struct virtio_fs_forget_req *req;
-	struct virtio_fs *fs;
-	struct virtio_fs_vq *fsvq;
-	u64 unique;
-
-	link = fuse_dequeue_forget(fiq, 1, NULL);
-	unique = fuse_get_unique(fiq);
-
-	fs = fiq->priv;
-	fsvq = &fs->vqs[VQ_HIPRIO];
-	spin_unlock(&fiq->lock);
+	struct virtio_fs *fs = fiq->priv;
+	struct virtio_fs_vq *fsvq = &fs->vqs[VQ_HIPRIO];
+	u64 unique = fuse_get_unique(fiq);
 
 	/* Allocate a buffer for the request */
 	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
@@ -1124,8 +1115,7 @@ __releases(fiq->lock)
 	kfree(link);
 }
 
-static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
-__releases(fiq->lock)
+static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	/*
 	 * TODO interrupts.
@@ -1134,7 +1124,6 @@ __releases(fiq->lock)
 	 * Exceptions are blocking lock operations; for example fcntl(F_SETLKW)
 	 * with shared lock between host and guest.
 	 */
-	spin_unlock(&fiq->lock);
 }
 
 /* Count number of scatter-gather elements required */
@@ -1339,21 +1328,17 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	return ret;
 }
 
-static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
-__releases(fiq->lock)
+static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	unsigned int queue_id;
 	struct virtio_fs *fs;
-	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
-	WARN_ON(list_empty(&fiq->pending));
-	req = list_last_entry(&fiq->pending, struct fuse_req, list);
+	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+		req->in.h.unique = fuse_get_unique(fiq);
+
 	clear_bit(FR_PENDING, &req->flags);
-	list_del_init(&req->list);
-	WARN_ON(!list_empty(&fiq->pending));
-	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
 	queue_id = VQ_REQUEST + fs->mq_map[raw_smp_processor_id()];
@@ -1393,10 +1378,10 @@ __releases(fiq->lock)
 }
 
 static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
-	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
-	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
-	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
-	.release			= virtio_fs_fiq_release,
+	.send_forget	= virtio_fs_send_forget,
+	.send_interrupt	= virtio_fs_send_interrupt,
+	.send_req	= virtio_fs_send_req,
+	.release	= virtio_fs_fiq_release,
 };
 
 static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
-- 
2.45.1


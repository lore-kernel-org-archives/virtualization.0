Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504441;
	b=wR+T+oAvPrSmRG2gKvWZe4S0Vl94j5mxc2j8aPK32yIhm+CIG8w9q1D0SXQ/jMWBwbi5
	 JCls3gpT6tTdPv3PLh97Z08/GOKwK2LdeydMeNag8pOHTu6dT9xsIhG9v951CxeZvW3u8
	 eUeJxuqD6KvuRgTDQtwdlzHPW5+1rs5mnZYgK2pw8ipKxwP2GMQZQcjF2sIBVsM3O4euT
	 ADY7Le6+JZE++pFmxhAn+hQ2jx6mYO6mMuv9Jt7ldwiqbXPVxFzCCMsf4xpxCd0PjSWy8
	 IQ7JKSc0QNQ84ID+bEB8a/OqZLkseD3nhycMno4d8M39YyaVjOEQIcLBrCWk16TDHpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
	b=jbYUfKKWEGdTd+M01YhFSCp4OSCZ9+ART/rKSkO1F2FzR5KWH+peHIyI7Bu47McNqmiZ
	 B6NLxfBBXz/9XyJ1TnoXuj3h25ZGJSD9LJ3d6eUtyKoY/a9bOHTO7SEI3k6uA+7P945CW
	 6gYToNZh2XsLI0wv1J2T7qh809IwLdfJ9AMYnEwrEpgvKO38YuhOcWLt66EfT2b6GsjOt
	 S7y51N7DP7zW8BS5uwaDBrFptDSu1RhrJJUsDKxcrmyLPE1G6ZoscDT22PL/I3P4gnTAo
	 ndbqzEjIMDCmf0Q/AN4yyquQuBvFmxX/8DUwdDxKnU5aoL59K+WH90V6TO7XxullUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XH7UcQPb;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA6606A31D
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41FA6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XH7UcQPb
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so401587a91.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504441; x=1793109241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=XH7UcQPb/4tXeAWoiinkZ3Y5x4+03KTpP//AnEu12t+irxE9zKuFvyPrdViABgEloU
         i+8HuotWx+6f4pSdD+ECU98FoQa86Bb7i05mqNX+0++7gsImyqWCetnU6nWFSHT0grBv
         RAVfWNnGDRvv3B8dNla4a5Dut+6csnIo168SiBW18aLhIrCC743oCQ3x9ahSfPq/pUmO
         iMm1a3qCFW+Riour2BbKwIEUSLFGcc9/kZue5s+PsAU1uvqhdqmApTuET75VY/vxs6/X
         6Fxbz/y9Wh+8Sio+QIqtc3Z+zdiTemv0tLOmSbBZk02tSx4eYFK8uYmk3cVswDErrrVN
         TPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504441; x=1793109241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=j9ymikJbYxUrvG+EeY7HirekvXwzBfJ5TK2M7p5BnIEYvGlWnKCtozJ765E0/mDtBp
         2jjtSzvQrfzT3AfGJbJ0aegNmU7z9EwWkKl42jhd/R+qQE3rJgPw0PFnH1piSdWOdJCg
         yCzbM2eUzvWxhowdbe3Be/6CZjuBrvKsO0Wo/0fwyV1J7OX94tfwcWa7lpUk3bbnBkiP
         kInfSj3tlofX6y3COOpbyp6BGk7+JJSBOpwd88bWvinHvDO3RkSi775YVCH7In0BMTwR
         +n+rOiTJCXlzy1jJ5wv/WfNsboHQDe6ywEIgCaWn3hLcmSinkq3XOHYj2WjCjjRS8OEM
         c+Kg==
X-Forwarded-Encrypted: i=1; AKwUvBxZHLySniLiV/SRJpdauSR55N8Lu1fOmr3zbfBFunyNTjCR0AW60lLvH50wrdSQEiBgSQcCIEIcRssktbhLFQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLgVXqdjLK+95RIibF2TQLgdBvtsM8Qh4ZtjWR0uwzq6t4dtJDl
	gtcANR3f1D3enT0YCVZAp1NlbrggNSyR/RiLuHMBJ/TUaute/h+RQIYR
X-Gm-Gg: AYBFou0qNbH4CyM2pAGPZLp0+rn2CMs286TL4aASODdQQMaI+o5pi6WzwueZq5Tf9Zj
	PHQ3Yh08DSXcQE1EMBxqCEmqy7tV7fpbaMkOXnyIOUvIGQEXvXztSbWdT+Aer2zpeaJX57QaDap
	G5r8lpFh5nEkFGto1KOzQLsYugBIOSW7naYAAlMszp3H7tofV8IF72c7B2wnRmXCe5va5ozkuQ/
	C8m6dvNLqg5T4uvOPhPsgM6EfLvRjE/3x21Gi6YKYbSmoSA+ohMCSJybbPugA0Ilzxa7EP9OiyA
	w8jZlbqRCdFSQZLPYb/y8ivmn+Gtjszvf6xB+40D5Iqc0SLE75SlmghwjXs3YgINiTOarGTLSuw
	wple2kURuR3+zuXNId+Nkht/XaTowUDW4uUhjo1v7Q/anxYdxZuH4quVvce8bT8yeRJ989YSx0e
	NmtmVxFYBCzpXmR0xX6mb8H4UBWoHQDdGHoH80zGKtASXL47EwKT9uPeYE3BBuQBJgHoN136vLI
	a//CI0BonluyYj3gM/5n2A6ideTLMoypG3UPoTHrO/wYi102UEz+VvBI4qz3m5hrkpSPs1qVRux
X-Received: by 2002:a17:90b:1f8f:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3aceec4ba18mr14269919a91.3.1792504440611;
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df894sm3604548a91.10.2026.10.20.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH] fuse: virtio-fs: don't process completions of aborted requests
Date: Tue, 20 Oct 2026 21:53:50 +0800
Message-ID: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
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

fuse_chan_abort() ends every request on the processing lists with
-ECONNABORTED, but virtio-fs keeps the request itself as the
used-buffer token of the virtqueue.  When the host stalls a request
until the request timeout aborts the connection and then completes the
descriptor, virtio_fs_requests_done_work() gets the already freed
request from virtqueue_get_buf() and moves its list node
(list_move_tail()) and reads its arguments (copy_args_from_argbuf()),
a use-after-free in the guest kernel.

Let the transport know about the abort and skip completions of requests
that the abort has already ended.  This is safe because any request
still represented by a virtqueue token when the abort starts must have
been queued before virtio_fs_abort() set aborted:
virtio_fs_enqueue_req() checks connected, adds the request to the
virtqueue, and puts it on the processing list while holding fsvq->lock.
virtio_fs_abort() takes the same lock before setting connected = false
and aborted = true, and fuse_chan_abort() only splices and ends the
processing lists after the transport callback returned.  A racing
enqueue therefore either completes before the abort and is subsequently
ended by it, or observes connected == false and returns -ENOTCONN
without creating a token.

in_flight is transport-owned accounting: it is incremented when a
token is queued and must still be dropped when the virtqueue completion
is consumed, even though the FUSE request itself has already been ended
by the abort.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 fs/fuse/dev.c        |  4 ++++
 fs/fuse/fuse_dev_i.h |  5 +++++
 fs/fuse/virtio_fs.c  | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..90b30c5034c4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2178,6 +2178,10 @@ void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 		spin_unlock(&fch->bg_lock);
 
 		fuse_chan_set_initialized(fch, NULL);
+
+		if (fiq->ops->abort)
+			fiq->ops->abort(fiq);
+
 		list_for_each_entry(fud, &fch->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f..47697adf0eb6 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -148,6 +148,11 @@ struct fuse_iqueue_ops {
 	 */
 	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
+	/**
+	 * @abort: Abort transport-specific state
+	 */
+	void (*abort)(struct fuse_iqueue *fiq);
+
 	/**
 	 * @release: Clean up when fuse_iqueue is destroyed
 	 */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5..2db5faf5d865 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	bool aborted;
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -842,6 +843,15 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (fsvq->aborted) {
+				/*
+				 * fuse_chan_abort() ended every request this
+				 * queue still owns; the token may already be
+				 * freed, do not touch it.
+				 */
+				dec_in_flight_req(fsvq);
+				continue;
+			}
 			if (!virtio_fs_verify_response(req, len)) {
 				req->out.h.error = -EIO;
 				req->out.h.len = sizeof(struct fuse_out_header);
@@ -1541,10 +1551,26 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 }
 
+static void virtio_fs_abort(struct fuse_iqueue *fiq)
+{
+	struct virtio_fs *fs = fiq->priv;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		spin_lock(&fsvq->lock);
+		fsvq->connected = false;
+		fsvq->aborted = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.send_forget	= virtio_fs_send_forget,
 	.send_interrupt	= virtio_fs_send_interrupt,
 	.send_req	= virtio_fs_send_req,
+	.abort		= virtio_fs_abort,
 	.release	= virtio_fs_fiq_release,
 };
 

base-commit: ac86e1112a6a
-- 
2.51.0


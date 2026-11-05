Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891393;
	b=j2FlnB0NkDN4QuB9aYmYLqtVHctOeom1BcPpRttbSwAx9KLpa9etj/GHD/JBJJHjpc/I
	 iE2Y7zwbEeUUhY7BWZmL+1y2FMhcceKxBvIIOssAguHhAmi6wK9zEaZ95/Q7502iFL7Cy
	 oWW0mUjQ7kF/Lu8/l+np8SgAMVr+2LTmOqGNB2ucyBo0E3A66LRDLVgg8mGIFitJkDuf+
	 HB+FztCCtMuMivTagIgFpq4eUpMSz8X8hPZVoID22oxuvtfFJtD2rcQOaCrfW7ggixNV2
	 F2WA+aRfkj+WBssJd2pt7KxXgeH/2fgpdoFxtSuBItVhK6gyUEkO4tGtcHeTs0HllyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891393;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=LOGmXt5dkQ9qYZQNInukOa3xIUze1p69S3CHfPjI8CI=;
	b=R61FwHOozaOWbasYig7aAQ8oTuNiZwyBObmxaBvRGyHOHFFRBILHuSzc8VUsnidnFjXe
	 hiRVx3PrNPR3QqdhyltRIaoEa1GuZmVrZVJ32uOPj0Dm/cvTqdNweywWJb48JGrbAGtSC
	 7ueg9ERf1DFaCsvUmQzgVnpbvUsXBHOtZUNXh0VRZwBAfRAPG6HyxiNg7V1QEg9nV40/v
	 BGv+Nvg3nvZxOYb8FrgBAR0BTFAyVQEEUsDfPyWgxkGp2ZTJilST12LpwJz5Rdew8jojL
	 xN5uu0I1mYAk7VShqyDrFZCNTlGscgwBxIjuWn+KhJRgJp8zn6rYkxYq/xsFwxxvXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ds3Hmt35;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3B606A33B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB3B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ds3Hmt35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793891392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOGmXt5dkQ9qYZQNInukOa3xIUze1p69S3CHfPjI8CI=;
	b=ds3Hmt35ezga1RXP9Iic2xn4C6VrwcwNWxuHKZv7S2dCFstMimJF+dN54Sv8SRaBH94RGu
	fI77YAXepT7+oWmkc80wxN2pxIi6b1ZvRVQsWACRJXpAiQeCZ2C0SfM7+HXKpQ4IukhOLT
	dq69969txjsj0rn1wyxvSCFgzBA2zmk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-dDN_0JzcN2WEZgdaoFatZg-1; Thu, 05 Nov 2026 10:09:51 -0500
X-MC-Unique: dDN_0JzcN2WEZgdaoFatZg-1
X-Mimecast-MFC-AGG-ID: dDN_0JzcN2WEZgdaoFatZg_1793891390
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a210f93860so16804145e9.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 07:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891390; x=1794496190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOGmXt5dkQ9qYZQNInukOa3xIUze1p69S3CHfPjI8CI=;
        b=XtBbmyox4FW8H3VIJuSQMpCICFez39YJ5O+b7NCFi/XQgbX4yo+8iEoJ+SeS9NzzET
         ZtKN//3FVDKptQRLZ4t2nG4gOYBIykmYxmbSBn7hcvKtaTQVpLv0C0XY8IgAaJi0Wbp6
         XDbcCPx3oM4jpaF99he7J4uZ1raDR//CaYGAeBV7SriuTWmnk08EaQQd3Wya+DOpWwLN
         g4mWXn5+npZO+Go3DdeZrO+kqRCrZadzW8M3iM54KondNm+u5z0mTqgWuFVME3SLeMPB
         hly6UwtSiDVfQ2smlwLPiAk9JJ91EZF/dpCjq3wx58QJJUif/MGFSXxX+i1aG5NWNWOy
         yY9g==
X-Forwarded-Encrypted: i=1; AKwUvBwR31UC3RTe+QyvCHfqTKI7dWNw+gODOTvcAVZ3aw/oW3V4kqcFC9M1V++6/nr56ayxRQeZfuws9SONy2/rcA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8GS/ar/urVLP3cs+ZCXCs96PFxzef/zOVdBzisvVLHMfj/MVvc
	ywky+ihr7pjwXjS7vpxK2gWqYDlh+9TE6ZejJNfnQ9qXFSZKKQ63UEgLIiHx+pXTibp1dYxq/dF
	pRS5htrZHkcY29TIcI1ze0qvHeD0Rgs0v39DnBoNy6rT2dCYZCh42UW8aIrTo2T0zC9p+
X-Gm-Gg: AYBFou1w9IJFW9ctsw/ZiqfcA3q5e4nrhHUnPbDGv1qRUVU2YpzFiShUG0yQz2YKILp
	qa987yr89l/jETnK2zz2S4ZglGN7JbUgOfy3gEofIGkCNQNtn7HlvzUc3ythK1SB0/ByWuJBMda
	EByl+e21yEcb6ufpsGnYJJEZ4Pspbn35QNL7oDYWq/d1c1LvIyYgJa5axKqABn3TYFDRQ6TDQq3
	1HAtMZD4Qfa+snvZVcL2HSh5X15r1WCFfGUDi3IJtW01U5CdLQBsnxWQ+VF9RX90L0cUa1LEqRW
	aX7k6E7TywBjApQpmlQQAUDUWUxR6TcS2hqLvJCZshqN9LqwBERwkvybupHbAhgDg4R3py/mXYw
	RGqlhcewQYJJrE1tnHRhZZrluy3bKvVA8WecnTzmi3nrZmNc5qCF+sDnh6x/kVwnzLRn5jQ/tez
	bUbv2xeIl4Cbrf/jjjNpsytnk+cODiC0yMxZxdaB3jX0U=
X-Received: by 2002:a05:600c:541:b0:4b0:9803:dc8a with SMTP id 5b1f17b1804b1-4b09803dd63mr180693275e9.26.1793891389708;
        Thu, 05 Nov 2026 07:09:49 -0800 (PST)
X-Received: by 2002:a05:600c:541:b0:4b0:9803:dc8a with SMTP id 5b1f17b1804b1-4b09803dd63mr180692765e9.26.1793891389253;
        Thu, 05 Nov 2026 07:09:49 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm9961340f8f.52.2026.11.05.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:48 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 2/3] virtiofs: disable request timeout
Date: Thu,  5 Nov 2026 16:09:41 +0100
Message-ID: <20261105150943.86650-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105150943.86650-1-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xXcPJAyAIp-wgXuf9opbhjHgl81AtSHJ1M4AkRNuR0I_1793891390
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The request timeout is implemented by aborting the connection:
fuse_check_timeout() calls fuse_chan_abort(), which splices
fpq->processing onto a local list and ends those requests.  Ending a
request wakes the waiting caller, which then drops the last reference and
frees it.

That is safe for /dev/fuse, where the request has already been copied out
to userspace and nothing outside the kernel retains a pointer to it.  It
is not safe for virtiofs.  virtio_fs_enqueue_req() passes the bare req as
the virtqueue token, and the scatterlists point at req->in.h, req->out.h,
req->argbuf and the request's folios; the device still owns all of that
after the abort.  When the device eventually completes the request,
virtio_fs_requests_done_work() gets the freed req back from
virtqueue_get_buf() and passes it to virtio_fs_verify_response() and
virtio_fs_request_complete(), which dereference req->args - the caller's
stack frame, long gone - and kfree() whatever req->argbuf now reads as.
The device may also have written the reply into the freed request or into
folios that have since been reused.

This is precisely why virtio_fs_conn_destroy() drains all queues down to
in_flight == 0 before calling fuse_conn_destroy(): once buffers are in a
virtqueue, the only ways to reclaim them are to wait for completion or to
reset the device.  virtiofs already disables the other two paths that
could abort a live connection, via ctx->no_control and
ctx->no_force_umount; the timeout is the one that was left.

Timeouts make little sense for virtiofs in the first place.  A timeout is
a guest-side reaction to a wedged host, and the guest has no recourse: it
can neither take the buffers back nor make the host answer.

So add fuse_conn::no_req_timeout for transports that cannot revoke a
request once it has been handed to the server, set it from virtiofs, and
use it to skip both fuse_init_server_timeout() and the
FUSE_REQUEST_TIMEOUT negotiation flag.  Skipping the former matters on its
own: without it the fs/fuse/default_request_timeout sysctl would arm the
timer even though FUSE_REQUEST_TIMEOUT was never offered to the server.

Note that this is not a security issue.  virtiofs inverts the usual fuse
trust relationship - the server is the privileged, trusted side and the
guest kernel is the untrusted one - so a server intent on corrupting guest
memory has far more direct means at its disposal.

Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-8171ebf0-ef01-4ccd-943e-8633a8d54239
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h    | 10 ++++++++++
 fs/fuse/inode.c     |  9 ++++++---
 fs/fuse/virtio_fs.c |  7 +++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec5ccdf18a25..a033b0bc4576 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -418,6 +418,7 @@ struct fuse_fs_context {
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
+	bool no_req_timeout:1;
 	bool legacy_opts_show:1;
 	bool syncfs_capable:1;
 	enum fuse_vdax_mode vdax_mode;
@@ -698,6 +699,15 @@ struct fuse_conn {
 	/** @no_force_umount: Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
+	/**
+	 * @no_req_timeout: Do not enforce a request timeout
+	 *
+	 * Set by transports that cannot revoke a request once it has been
+	 * handed to the server, since the timeout is implemented by aborting
+	 * the connection.
+	 */
+	unsigned int no_req_timeout:1;
+
 	/** @auto_submounts: Auto-mount submounts announced by the server */
 	unsigned int auto_submounts:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed..3c0a629cc2fe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1451,7 +1451,8 @@ static void process_init_reply(struct fuse_args *args, int error)
 			fc->no_flock = 1;
 		}
 
-		fuse_init_server_timeout(fc->chan, timeout);
+		if (!fc->no_req_timeout)
+			fuse_init_server_timeout(fc->chan, timeout);
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
@@ -1502,8 +1503,9 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
+	if (!fm->fc->no_req_timeout)
+		flags |= FUSE_REQUEST_TIMEOUT;
 #ifdef CONFIG_FUSE_VDAX
 	if (fm->fc->vdax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1820,6 +1822,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->no_req_timeout = ctx->no_req_timeout;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ef58bedc3941..c824916f0a9b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1592,6 +1592,13 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 	ctx->destroy = true;
 	ctx->no_control = true;
 	ctx->no_force_umount = true;
+	/*
+	 * A request handed to the device stays referenced by the virtqueue
+	 * until the device completes it.  The request timeout works by
+	 * aborting the connection, which ends and frees such requests behind
+	 * the device's back, so it must not be enabled here.
+	 */
+	ctx->no_req_timeout = true;
 }
 
 static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
-- 
2.56.0


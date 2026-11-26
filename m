Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704448;
	b=rAhouPOIatcGwcmSohMhmEYazknF6xFa1grZBBo4iT9BVajuuBKAU1VAojWg6QecpZ4y
	 TotFU6m+WBtv5v+t/HvQS8FB3yg1tUQsi/hAoaQmH09ldR/uWUouvwKlZDBvwKV7Ofi0G
	 GcdmhyTrvCMNp/5f8T4FI9NeIfIcwQE9r0pTMfHJYmgsJgdPajH9Y+Rxz6smFEnKbcgaH
	 dgaZFBGEukD1lMm7T/T/QuKpNZryfq/Tt+rN5fcOPtaALzPbToqV9cf+cdg1wz+PJ9vwZ
	 6IVkXuZIjoMuJeVf5JVY3jBgz210zAuD2mMXpzyYSoSq0h33QosuYHE/q6Gp/zIT8Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704448;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=oPelpeMc/+MkSLr4S1p7e6tz+07RqqWkjj6mkjgV26Q=;
	b=Yv8UnAwqVsL9V2eq12mqoBCsxcRRCwan5ENrDKunfOTdrSSkHT0cpkF/+JeC9ZkVR6aQ
	 /z9dRZp8d46FPa9n+bkRy8SSYjbS9xjsOt9E8aRjtQ9JL9soBYz51DNFSm4lS1qoB170Q
	 T5byl95//3IBHtbZl8Ist4kj0+/N4MuA43D6bJbcimT1rIM/XE+juL9Uk9EqVf8UxUCLo
	 mTsbS1zmFUhRC2scHR5amLxyClJTT1TrK2e6kSQCgG3i/Bj0fjCQlWozKhMuAQQTb7qry
	 76u3BZ6Ajkc7fDrGVq9L46U5UFKvJWz8tOhao7yWJtS+LBVuffbYR+h9K5Ho66lBt0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gTJ6R5Ft;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35676606A31E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35676606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gTJ6R5Ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPelpeMc/+MkSLr4S1p7e6tz+07RqqWkjj6mkjgV26Q=;
	b=gTJ6R5FttLMZB10/H506Ay1GnzReBPROUhbeiCFUBiv/fMa2nRJGYPLJ0kuI/LzqFmauGQ
	0cjL3NyGBKS1eyS8SzUM9pvgv17VkykOXkprHUS6Wx6/9wGV1hRcHzv4TAmiz/0pzZRg4l
	s6OvibOan9qPEVqYnJpDOKptbBOhNFc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-pKR-pQZMN3ilZh8LXlNjjg-1; Thu, 26 Nov 2026 14:47:25 +0000
X-MC-Unique: pKR-pQZMN3ilZh8LXlNjjg-1
X-Mimecast-MFC-AGG-ID: pKR-pQZMN3ilZh8LXlNjjg_1795704444
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso4157518f8f.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704444; x=1796309244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPelpeMc/+MkSLr4S1p7e6tz+07RqqWkjj6mkjgV26Q=;
        b=kZQhDKuU+97uc2D/clvWbXbU0Hfo66/y5XojNpV3fHPNYeJ9Gh7NAeOZrXMKLo2/Bb
         lt0HsLDpR4cM1BT5qP5rAloP8YEoqx12zr43zMjWxg9eqbt4m1Yg4AwcpQAC/U0RoNUF
         QhG8Rr45s4SIBAURS2kz9TjvTTWKHvSB8Qnqs1pTYhP8SjSAB4vMMSB0awZ6rzrQ8xwi
         nHAw5COAcprmRKvkx+evkd6dZCKuxE8ebi0PKUw6oB0C+IPUs4oOXW0wY+GDMnr6MgZe
         D+OoH+Rx1l79i5GtCyJDKMsDhLPtNAZQ3dWgaH9NR0IQJYuidjCLU09iF0H0x31omrFb
         DSkg==
X-Forwarded-Encrypted: i=1; AL+hErFWsKQqkIqcKiZGTCsYesCSmnlNlgpQVJCyaTBhGZ/sHCMZfG9QjONlK/wXdZ54ceOlBFmyy5wpcn4Iguysjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/fvSr/d8brvy2ZkEAOFgwgJZpTkjrZD5BdEuD1NPR39xwBVbGa
	V3ZWw8RS4tsDJbmNmiDtEBllrwLeVPlv+siYcHUQDMAGJcrbi3TmuFBJ8820MrO0OyLj1nEhESV
	A0g3rtUpEN4SLk831SLQp23nU0I7Vk13EAAdWMREb6rkGSRf/PaCi80h810MTXPqDc0pp
X-Gm-Gg: AZFdTZfT4FrDNZBAPUFjDET5aDWMaM9BRzd+OfGG0PwKFp9rYOEcTJxqxnZxhfGOkpV
	3WqHDqXlGm4T0KvCMkkmNW1yJz9GYpXYqzhy6wDwszL8qN2W7iIytNpnK+bpCGRPedGKi5StJGK
	jrOowBIJxM3v9jgTpA0iINmRSKCKjsDgVpvvD+aJpTzcOM/Shpco5O5sPWuJrI06GAxE39KWbsv
	IbQChqWnfOzlKYdIJvgsfyPPGAgELZ4kWqwLyXBZsd1KK38NBHo2mYuziXhW+bXWgXE+3VvDY53
	96nQ92hRxzNRcW/xQK0a1dYC3P6hkKtAOsKH/nyphGMGpJCHls9FkAmCm/e3qGazSKJ8g/IePsE
	QsGeZ+sAiLKVM9cs4a/a65nZhnmUmh2+elBe3uqf6o3RChUyDtxL2vFZpLuudm0GAIbRErba7Zi
	Lj5L/Zka9HhDc7rbhCUGeT5sg1i6uqMwrw1YGVErR+
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr454871695e9.14.1795704443914;
        Thu, 26 Nov 2026 06:47:23 -0800 (PST)
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr454871155e9.14.1795704443442;
        Thu, 26 Nov 2026 06:47:23 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (193-226-214-34.pool.digikabel.hu. [193.226.214.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm388114905e9.0.2026.11.26.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:47:22 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev
Cc: Li Wang <liwang@kylinos.cn>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/5] virtiofs: retry request submission from the worker on -ENOMEM
Date: Thu, 26 Nov 2026 15:47:16 +0100
Message-ID: <20261126144719.232329-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126144719.232329-1-mszeredi@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tcjjgJDBdKP9r3MrnU9UGahrcHh5NwlrEHshQjjgVhE_1795704444
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

virtio_fs_send_req() enqueues with GFP_ATOMIC, because it may be called
with fc->chan->bg_lock held.  copy_args_to_argbuf() allocates the bounce
buffer with those flags, so under memory pressure a request can be
failed with -ENOMEM even though nothing is wrong with it.  The buffer is
as large as the request arguments, so this is not limited to tiny
allocations: FUSE_REMOVEMAPPING, for example, can ask for just over
4 KiB, an order-1 allocation out of the atomic reserves with no reclaim.

A virtqueue that is merely full is already handled gracefully: -ENOSPC
puts the request on fsvq->queued_reqs and virtio_fs_request_dispatch_work()
retries it with GFP_KERNEL under memalloc_nofs_save().  A failed atomic
allocation is just as transient, so treat it the same way instead of
ending the request.  Unlike -ENOSPC there is no completion to kick the
worker afterwards, so schedule it here.

virtio_fs_enqueue_req() queues on -ENOSPC only after checking
fsvq->connected under fsvq->lock; do the same here and fail the request
with -ENOTCONN if the queue is gone.  req->argbuf has already been freed
and cleared on the error path, so the retry reallocates it.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8bd63c6165d2..6ddb2f181a16 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1586,6 +1586,23 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 			 */
 			return;
 		}
+		if (ret == -ENOMEM) {
+			/*
+			 * Only the GFP_ATOMIC allocation failed.  Hand the
+			 * request to the dispatch worker, which retries with
+			 * GFP_KERNEL, rather than failing it outright.
+			 */
+			spin_lock(&fsvq->lock);
+			if (fsvq->connected) {
+				list_add_tail(&req->list, &fsvq->queued_reqs);
+				inc_in_flight_req(fsvq);
+				schedule_work(&fsvq->dispatch_work);
+				spin_unlock(&fsvq->lock);
+				return;
+			}
+			spin_unlock(&fsvq->lock);
+			ret = -ENOTCONN;
+		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
 
-- 
2.56.1


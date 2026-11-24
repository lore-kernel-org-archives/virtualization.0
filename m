Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506854;
	b=0L+Yssxt2majLOG8TyjEW2eSFdtVe3A9QDHHv5QR7ClcnkfsDtGbYAYYrrhZOB8kCzEX
	 eUcDZuywJZfSl0SbnkxgQ71F94Spg4mfwcokpnREEKGCq3Ja0LkzRlugUmD3os90rYd2Y
	 I/Xxyp4V0BOKrjDrnOMUO+VJrj91aIFW6BlBJ4rWkMFziaS8VptSb6mwKviSjTnCsQD7j
	 9tzJp3fTq62MjxEO31uhG9AFc3ECTRDURzaRitoeujBk8tlHBTLvcx+F85EOacT8IdZYS
	 wIi0ZXIc3GPsWLgjGLYWo1VMXl4o4yfXp5gYi4M5scP7qDRvaHCcvLw7+RDYJUTwtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
	b=W5QITiNUq5Z5Yj+5pdf6oaAWkzlaxLXQvUJaolggMjbBE2UjAXnZCFXt5bOgctJpNvfh
	 mTPK8e5NdYUvAkpvgxIwZotdaLIPOYy2Ld3MjRUBvCV70QPZ9cKjIBvC/3qc3d+pNDMVV
	 TQIVeMhD41iseFf0NH2FbhfvTtQsp8Lk1vbNGzFXN4yoKCoC5dXdF6sHc+Bscy+Ydbxtg
	 0zxpLXtMFjjggjAbEr+neLMebgDb9y/E35QX+00WPwYihkKFAKnzJGo299dMHIH1JFHgc
	 y8FC2piAmrN3VKhDkYx0Nl0cqUi4e3CF+8RItAVfadR4zwyoBvA+Q5sMxYMcy/77kog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GV8fZXFk;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DB606A32A
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 07:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09DB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GV8fZXFk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1765830a12.0
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 23:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795506853; x=1796111653; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
        b=GV8fZXFkDjPhAt13OPhXoondOv6tr8W0GGVdVvkrFaJ9pQiGCGifG9qRZwFsl3spnO
         rPTcYS92anRyJr0hgRD8wMEYNYQdT059sVGiLWWc1UkLNaEkIBKsJb7J2Np503DzwQk9
         EIaz6PPDNFIuldfd4CvEw6Gqiv1kCXmSmulUgYvPuk4HiXw8CA9xfbflxjYxXnAeudmw
         BCsgTUVKfxyfuG1ViZyEAheYIJAoE7/rBHNYB5EGc8PCVbNON8xoJ3PbCG4l2tMhyCxK
         78G4Az1rD10QZ59Hs4YX3chJfVCrYdX7jqRr7gYXwiQXYQy4mv1qBvNSLCGHaSqVk/ba
         mjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506853; x=1796111653;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
        b=Loa5Noi+NnJqNt6ls5gJ+Xg7Jj5NL9BdvuSZ0cswiykE8V9vVM5FuHmeiKchOGxT8b
         9H0ZO8mh/ZUgpW+/iR4vOXE2QS7NSL3DKVq4mcg4H7W0mxxWeZ2T8RZYIDC0B/ip6Mqu
         pRDa+QKg1bBJAX0v+9wXohIVKbfPgM3rXT5BA/f2eeHUp57vadwScSNDm8giLKrGoXM2
         yNtEEWvlkxDfo1n6GHyRSfGec4U82mk90MQCc7WC0czCZ73dgj1TpOp8q/Uic8K9hxXO
         VgUmpkDm3sht+du/DSB9Nuhc63nacIQ/QmV4fFObOf5K2bowlImnZbqmTyYjNWaVU0PX
         4jEw==
X-Forwarded-Encrypted: i=1; AL+hErHCwyv10HB5z5+vkkm3c10TKT5TYfHk07woOE880ZC4qw7i6HmbILnpjsjH1NKki8DeaUtw4J4OblNYuRgCVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9/Lr/aef3n3zOfFfZUq7FmybkL/L2u3mQTfKKW0GmuWRI0GEcG
	G1uq7It6L5s3078bN3DYeQfv2ZvSVmJq6bXVbZxJ8nP+9p84effm9fEXuS0aIYjfspjUQTOp
X-Gm-Gg: AZFdTZcDgr2Zw3lL+8jjzLkEw5Wc6UOVMEDY5bb4Hfe56PZs9LYltjQ32Rg9KDxNWte
	aRr3N3q/UlKAQN+22lgQ8UfyaLw89PZkt/9tm8fSODfr79PHTw1M8Q+TiX3QTEnw1/m7R5TBcj2
	3cLeG2Tdj9oNAJpcthTkd2r+3/l3yl0iCdzmstHqMtW/uO18lPSSlv+vWY02YFhr19S3VEvmRL4
	GgQ8VjRbEnW0QNrKpfJrv8pFArNf17XqzuMJvIuTlUpNM3ZwI8ZCG0tyJlvXXS6pKpdoPHmoBH8
	BXbRPeuFLCg7CUYVHEjc8jkajStBiEIEtj/uHaKAkTptyoZSz99uXGl8lzsYujr2lyMvk+DXUAE
	q500WnigNUHAA3rUyx45OtdlVLu8oRzdEOOdlOpG6/dkS9tOHnJ2SLZ/AIss/+fRe7VE/iH0aBq
	SY81FtDu3W3ncHK0xtULcEkRlvBHo3IVE+ICiMM8/EFWncONj58HSJLUeJ2hXFgS3qbA2Ov50iH
	vjgSB2SiHzjZ9MMVB6t8ijVsdUBQ/eCN7Z+MU5GVvwPwcaruf0qpfWzLlH+DaYuoWYpGqziWhgp
	iqYg4xB65ilQa7fEpyS1XvnlkGBKE5FBXNHiyQhUrWXkFIiBHkSBCmHjSBx+VM1p73ADNP0iNfw
	G9Pcf4KB3RdBhPYt7IVpks0G5hA0UP97nnL9W
X-Received: by 2002:a17:90b:3e48:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3b41c98a343mr10773859a91.22.1795506852965;
        Mon, 23 Nov 2026 23:54:12 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm24871009a91.10.2026.11.23.23.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:54:12 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: alex@shazbot.org, yishaih@nvidia.com
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v2] vfio/virtio: read migration buffers and f_pos under migf->lock
Date: Tue, 24 Nov 2026 15:54:08 +0800
Message-ID: <179550684893.38679.618538654837589800@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

virtiovf_resume_write() reads migf->buf and migf->buf_header and checks
filp->f_pos against vhca_buf->start_pos before taking state_mutex and
migf->lock. Because virtiovf_pci_resume_device_data() opens the file via
stream_open(), FMODE_ATOMIC_POS is cleared and concurrent writes through
duplicated file descriptors are not serialized by f_pos_lock. A racing
writer in VIRTIOVF_LOAD_STATE_PREP_HEADER_DATA can free and reallocate
migf->buf_header under migf->lock while another writer still holds the
stale pointer captured before the lock.

Move the buffer pointer reads and start_pos check under migf->lock after
checking VIRTIOVF_MIGF_STATE_ERROR.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of virtio VF
live-migration hardware.

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
v2: resend via direct SMTP without line-wrapping corruption in the diff.

 drivers/vfio/pci/virtio/migrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 4b1e5502f0a..5e47f349511 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -918,8 +918,8 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
 				     size_t len, loff_t *pos)
 {
 	struct virtiovf_migration_file *migf = filp->private_data;
-	struct virtiovf_data_buffer *vhca_buf = migf->buf;
-	struct virtiovf_data_buffer *vhca_buf_header = migf->buf_header;
+	struct virtiovf_data_buffer *vhca_buf;
+	struct virtiovf_data_buffer *vhca_buf_header;
 	unsigned int orig_length;
 	bool has_work = false;
 	ssize_t done = 0;
@@ -929,8 +929,6 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
 		return -ESPIPE;
 
 	pos = &filp->f_pos;
-	if (*pos < vhca_buf->start_pos)
-		return -EINVAL;
 
 	mutex_lock(&migf->virtvdev->state_mutex);
 	mutex_lock(&migf->lock);
@@ -939,6 +937,13 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
 		goto out_unlock;
 	}
 
+	vhca_buf = migf->buf;
+	vhca_buf_header = migf->buf_header;
+	if (*pos < vhca_buf->start_pos) {
+		done = -EINVAL;
+		goto out_unlock;
+	}
+
 	while (len || has_work) {
 		has_work = false;
 		switch (migf->load_state) {
-- 
2.50.1 (Apple Git-155)


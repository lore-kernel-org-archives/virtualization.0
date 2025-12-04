Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9E2F8BD0
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873976; cv=none; b=rhGijQ9hPmv+RIBbE0LRp7CjSGBykmymZKMdaObrqrP70opvkNO889jeD7uKl70NGdIbTywydesSdjNTu8WnUhryZiyBvB1hix7JkaavDCFbYnuHf9KjKZTe58xzuMW/7QWnZkcLwBRESGB69GKhQRqLOIdQHufESYf7+pzPC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873976; c=relaxed/simple;
	bh=ixOIT7gBC1pWKudTEU86DEyzo4ic8BfL+pH3/rjQXu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jwjaKPE1OOz91adzAusAyGnvf6q93+R+qmcF/FGAhAAnvGHXcM72KchTUM4jhLoBvwg69B2kReWEyVu1/5fXBRXl33uNEa06CJVO0AzqS77oac27bLEU/7dJpDI+XFIwItjPR3N9sgn2z9nO6QcnbfDQqwXGoNqCUfA2NKbz/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGXdEBGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGXdEBGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U891j5e3VoLi4h2YlpGZwyu+rI6YPUZxSzeS/f8yY78=;
	b=RGXdEBGrXu0hoWYyrQQCLw5zqv9/LLuAc5c8O/2a5UY/UGLPVwxdslRjiB1DwbigI76XIt
	ksRQ62MMNoRWXsXAGoxpuib23BHiesCtgckIOLZ7shXngxtH4rDKXfub9qCjXWU2SzE4H8
	btXJMx3h9ZyJKwv5I41JshonsWXUp28=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-8AYNHIiQMdqL8lhFFlsrAg-1; Thu, 04 Dec 2025 13:46:10 -0500
X-MC-Unique: 8AYNHIiQMdqL8lhFFlsrAg-1
X-Mimecast-MFC-AGG-ID: 8AYNHIiQMdqL8lhFFlsrAg_1764873970
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3155274eso582016f8f.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873969; x=1765478769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U891j5e3VoLi4h2YlpGZwyu+rI6YPUZxSzeS/f8yY78=;
        b=spHufRInZ5F8wa2SYBrMfkBe74luwzwy2A8AUp+gbB1/8TxcwJTrvb2jLx45maKfYv
         v/FHgvzAIFKM2YVfWFz0RQeXceNX+v0z1R5UhpykvI3h1uoauHdsMRymDQ09qbv5uNBp
         exW8ACYq5E4hxwjHAmKOoPKp2LY9MQ3t4QU6s54LVXjMUytqub985XZBl1jMEA/Cfl8e
         /RPPPx+BBfrw7RTtzzabV4gNnakTXVP7+SkHVcIVLqxzgaFlkwjWAX6+CXtlJJVT+KVn
         xcJY8AfGEBAmy2aFfZPiBlJ5agOEIXa/BwAEu8sW49q9KFsqry//vvYSWgUHc0K3h/Gk
         MYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUd8/0mWGyPm0/z6P/xu4ZmXpEd9x8xg7giipCbbDdhvq68IoiFq9BJ2qX8J7V/0j23142RIH1X5YDG4ObgMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNZ/62pz3AtGHEMVkT9MuupoyYRsvZJx0OkjrEQD33Vb5lJnds
	3HIRhtQqrqDcE9n0lzTfwrBC+5Yny3y115WCxBUfpzTZ1PyEJ6W16nJbhpxuTSLtJICUAUJWGuE
	GUycV/SdmdBQt+1qp6oR43cshU6It9+xPi5wzaKzBlXiMfT72ps4UAcFFIsAwfb62ASbU
X-Gm-Gg: ASbGncvlwCeESMIyIMac/s1nscU3WzGyB732GC6PQ6RDFDoEdFNZef8ZUQyfOioHKko
	if/E5OsQEwg5Ghe6QANmQH/xFGJG6WTfkj7Fasc7FYJ74CA25Ag4y6ovk8Qg9yP5kxgp0dpfOm1
	5DfYQ2rXTxTVVppyYVhNPBqnhxHjbXz/UDfJiivXrVTQJNUWkjZwBFUErqKMb/kIuluWHzU/IGx
	iNJLOdHPWch+eCN3trloc+H7nb6YrWlCEKWov11sDIUXgt4P0Qbz599bukDUmBKVFrVFahbsB/3
	bdBiXGAOKPdiL1LiE2T3tnTzSf0Uj3hMa230+ra7jXsA3JP7OJSDZkqz5oHBIDZAQOAS8uBk3YU
	=
X-Received: by 2002:a5d:588e:0:b0:42b:411b:e476 with SMTP id ffacd0b85a97d-42f73171f8dmr8142743f8f.9.1764873969329;
        Thu, 04 Dec 2025 10:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhWokhsrGnJYroHp2metFwEXS1iM+whRYWv0A2+q9F3Y9mz8+yw3WteBIXNycAlKqwIm7Q9w==
X-Received: by 2002:a5d:588e:0:b0:42b:411b:e476 with SMTP id ffacd0b85a97d-42f73171f8dmr8142706f8f.9.1764873968835;
        Thu, 04 Dec 2025 10:46:08 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee5bsm4560090f8f.16.2025.12.04.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:07 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 03/14] tools/virtio: use kernel's virtio.h
Message-ID: <33daf1033fc447eb8e3e54d21013ccfd99550e37.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TFZfJ_tswM6VEm8aeLU2H8vR1J7g_30D2QdHQ1_S2lw_1764873970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace virtio stubs with an include of the kernel header.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/virtio.h | 73 +------------------------------------
 1 file changed, 1 insertion(+), 72 deletions(-)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5d3440f474dd..d3029c944589 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -1,72 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_VIRTIO_H
-#define LINUX_VIRTIO_H
-#include <linux/scatterlist.h>
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-
-struct device {
-	void *parent;
-};
-
-struct virtio_device {
-	struct device dev;
-	u64 features;
-	struct list_head vqs;
-	spinlock_t vqs_list_lock;
-	const struct virtio_config_ops *config;
-};
-
-struct virtqueue {
-	struct list_head list;
-	void (*callback)(struct virtqueue *vq);
-	const char *name;
-	struct virtio_device *vdev;
-        unsigned int index;
-        unsigned int num_free;
-	unsigned int num_max;
-	void *priv;
-	bool reset;
-};
-
-/* Interfaces exported by virtio_ring. */
-int virtqueue_add_sgs(struct virtqueue *vq,
-		      struct scatterlist *sgs[],
-		      unsigned int out_sgs,
-		      unsigned int in_sgs,
-		      void *data,
-		      gfp_t gfp);
-
-int virtqueue_add_outbuf(struct virtqueue *vq,
-			 struct scatterlist sg[], unsigned int num,
-			 void *data,
-			 gfp_t gfp);
-
-int virtqueue_add_inbuf(struct virtqueue *vq,
-			struct scatterlist sg[], unsigned int num,
-			void *data,
-			gfp_t gfp);
-
-bool virtqueue_kick(struct virtqueue *vq);
-
-void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
-
-void virtqueue_disable_cb(struct virtqueue *vq);
-
-bool virtqueue_enable_cb(struct virtqueue *vq);
-bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-
-void *virtqueue_detach_unused_buf(struct virtqueue *vq);
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      bool ctx,
-				      void *pages,
-				      bool (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq),
-				      const char *name);
-void vring_del_virtqueue(struct virtqueue *vq);
-
-#endif
+#include <../../include/linux/virtio.h>
-- 
MST


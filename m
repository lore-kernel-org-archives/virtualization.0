Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61A20ADDC
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316923; cv=none; b=Pl1ZKzpdRtnvUtltyVf8fH8ae/CdQj68BqcimnPZTcqcW13c4V3CikG1HLItjVLBe/5bZfey7UsRbz2FgBOGbLWKh3ndTRz4uYM2AVo8z7FQQ6tnttoFJej3J69HlkSS6zVZxgADR2VYbc93zGo80O31suNKpwTnClLAqgVBkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316923; c=relaxed/simple;
	bh=saVx3j66yQi6SYE+wOeyLCRXDHSMKU0oWoMw4xOdqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O4E7iET+InMf8u31LftId9ugUmCqqa2NlcnbCZnAHd1qTrkQoXUszvOWYwTf0G27iGddvY5wJuxGfeOCIF0iCxEdU04Mx4zHX7S81FH8mKJUC4U1tpDBo/vSGXV+wWcJeSRoMuKZXBDWPP89d4qfs46QweGF7DD0XsLsWR41JyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev0msI2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev0msI2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
	b=Ev0msI2/1xKiqR0Qvg2LLwuFn/3Da2fR1/x+quZTxdgUwaZLX7GZ0rIlrJZJzDU0PMe3j9
	LsmFVZsaxLwDxru1TJu3JAgOxeQIMEN9vOIx6YPD+KcBlBq0QxZVGYJHkKC1/mORtNoEMc
	tfqe01et3HH5/NlOhLG6IyqvB1aq778=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-__9PStAYNX6tFa2-Ga3AoA-1; Wed, 04 Dec 2024 07:55:17 -0500
X-MC-Unique: __9PStAYNX6tFa2-Ga3AoA-1
X-Mimecast-MFC-AGG-ID: __9PStAYNX6tFa2-Ga3AoA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so62527295e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316916; x=1733921716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qWcPvM3uPJNBlH29eIda0Org6XNMptmimUFcDc8wZo=;
        b=B0u0J9DKBI4L3J3Ry0G0SM0AjVTBNHxCLwNiHYr5ik0NQyZ5JAVHNLqeX4sRyIE6ja
         AQhnqNiPAU4B6hnpRpZy4rQ5VS6cWWOspa0DXzLp/gwBNTSjtVzr4LoEepTSbXSCCBV1
         mKY4oHmfHo4SR0hb39oFTp1qqJ0SRVYarsRSxseveTWvmrkCSmJvt9IXTQqBJ4IsUhIT
         QvmrRcMHqBNLiYC4f3CPZHXFOK6n+5qNXvuUvG/4M0cNZJSR9XvfYFJCwvm3aMtEWTrL
         Z/EEIxfqtMInNIhCt3KY7JVIWYgYLc/NIbQQYvEB3gL6GSNvcVnpG2du1vY+qEIHFlwM
         h8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkWk0muSeutbHu0HhYxX+fdBLiHz+O9arocEtoILuPQTHV65nsy0Cm1rINUes7AModANw+OYgRlOLjrJ8tCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDxLFuTBe8T02u/pVmIjbgJYmHda3xnJV+IDSL5ImFDSTif/yX
	prchknyNZrS0mS0JV8jHwWQ5hDMbvvg9VFh9xWbuTkCxmKUNHUiWfN9GUsKEhYZVNpc5DxeOAqW
	jYy/sRZjfGgP0KQ7wkJ+Zn4oyLSvwc0u82Y/FOhAYa4Kz6OdZKJkzm7b+vS+LQFpL
X-Gm-Gg: ASbGncsvc7DCZd8CGcLFFuH3BggmC7/0jnDHoEPkyAq0tjQmIS5TDg3CuW6XYBkokf7
	ufsP1QMpkn6tw8qlPgSxwbVh/k4PDWDybVEgvteSlUTrNGICiVeYd36AjdL2y89Db6hKhsFTA4y
	Xc0Hx0LLQVghg7MIEosGCXELAwc6kvWB7U3Uuvmx+42YHyZaqzPuaWg8yfq55AT7EjZazHxq3+f
	U8AyM+OeVVDjg6euSqf69Ujc/OO91H7/fQB0xBxJSTyyCgod4xFKLccnmlqCYEz/kN6iOEw5FoC
	kLPF2VOAkLOtc6ZcmIDhWyuRR3aOBVLQRVw=
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58499995e9.8.1733316916551;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Ukl1ZPphCA+wOQqYI2PG+9UegKLtZCsee5cNCt9biGs2cCCF0gJFsDeKmcsipWxLJl404A==
X-Received: by 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434d09c0faamr58499655e9.8.1733316916209;
        Wed, 04 Dec 2024 04:55:16 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52a3139sm24274545e9.28.2024.12.04.04.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:14 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 10/12] virtio-mem: remember usable region size
Date: Wed,  4 Dec 2024 13:54:41 +0100
Message-ID: <20241204125444.1734652-11-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A7L70oeCnlZ_PhkzlM-b8jc1W5PSqR3t_aG9wAZDLAo_1733316916
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's remember the usable region size, which will be helpful in kdump
mode next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 126f1d669bb0..73477d5b79cf 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -133,6 +133,8 @@ struct virtio_mem {
 	uint64_t addr;
 	/* Maximum region size in bytes. */
 	uint64_t region_size;
+	/* Usable region size in bytes. */
+	uint64_t usable_region_size;
 
 	/* The parent resource for all memory added via this device. */
 	struct resource *parent_resource;
@@ -2368,7 +2370,7 @@ static int virtio_mem_cleanup_pending_mb(struct virtio_mem *vm)
 static void virtio_mem_refresh_config(struct virtio_mem *vm)
 {
 	const struct range pluggable_range = mhp_get_pluggable_range(true);
-	uint64_t new_plugged_size, usable_region_size, end_addr;
+	uint64_t new_plugged_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
@@ -2378,8 +2380,8 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 
 	/* calculate the last usable memory block id */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config,
-			usable_region_size, &usable_region_size);
-	end_addr = min(vm->addr + usable_region_size - 1,
+			usable_region_size, &vm->usable_region_size);
+	end_addr = min(vm->addr + vm->usable_region_size - 1,
 		       pluggable_range.end);
 
 	if (vm->in_sbm) {
@@ -2763,6 +2765,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
 			&vm->region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, usable_region_size,
+			&vm->usable_region_size);
 
 	/* Determine the nid for the device based on the lowest address. */
 	if (vm->nid == NUMA_NO_NODE)
-- 
2.47.1


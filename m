Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213B38B7D5
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441517; cv=none; b=M1tQsaQqRrVFhX8LwMlM+D6spyZKeFC5NSnksLlF8ki7yDF480ZKyclCr4zdV6beVYhggXo/TjLQcV42+LWRQRev3EBp2VfYzxT8V/vXga8XhIdTHmJXjMUTg5/qYQ3fO+mismAG5LwMcK8UheLbRNwb/ZQqEdm2qItBJtKMnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441517; c=relaxed/simple;
	bh=ejoxH+LGsx0lf40D7kcEz2BR8ZKftH4l7JfUa0+NqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HvxsmcZ1r1nfces47KqEwWOAZOamQ9nKpZ8ApRxCfqLiyEbOjtW4DG66wued64Gf61v5nurdwtR8kwsGYIp20Or7ZHnp2e+SHvc02E6hPJ5TMgLMfMY3vUyNYGj/ctf8EkXPMg2AFPXqlvmD+NtYNTgzh5+26FJqCuXO0fe60HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp9Obh7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp9Obh7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772441514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Z9WT3KJPKaJS7kZ732QoTptenX1xk5GVKXR5OHJOtrk=;
	b=bp9Obh7nfrHbjYjVYv0f970o+ITLfuFKNDREhM4a2PiM4zMEC2sJWNn6/GDcV+Xx6GRPH6
	UY8mCi5PZoSYAG3TXEt6YqN1hId5G5ZvCfJ2BxesIN2OCWMQcoCc6LpV8UBpco1K4K8gUs
	anpl0QXLZmjlcWX13YpDl2konnofQt4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-NBzwS75oMyqbGJT3wK39eg-1; Mon, 02 Mar 2026 03:51:53 -0500
X-MC-Unique: NBzwS75oMyqbGJT3wK39eg-1
X-Mimecast-MFC-AGG-ID: NBzwS75oMyqbGJT3wK39eg_1772441512
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso20714135e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 00:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441512; x=1773046312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9WT3KJPKaJS7kZ732QoTptenX1xk5GVKXR5OHJOtrk=;
        b=fOwSCbvY5YPWKt1HeAW4ThvTd3rZmeUvfIDhoTp7StuSkuU4j0o1KxlPnXhqN0o1hD
         N9LZLXW+rwWwAsKjXwHXtLTkr60eTwJxzK/sRNTfeUoVz26GMmDLwrmCvbU0YVflVpRE
         ES6cteby5hfU8azakTe9Wm3N8RqZNa3ohk36tzNVz+AiPMYIk5xL4uSFifm3eCLn5xdb
         WWHiv/fxos47cG12aW0jC6ZABHCQGE8NiQ3SeeINgJuZxsw/YQF+GO8ZB80XXFqD2W3D
         nqHtvVT9RBBI0OfcXK/p9rxtaVkIeXoO2Ldzw2fqlI6CPSgGrtLJwSlihNS1ml8Ary6c
         kLIw==
X-Forwarded-Encrypted: i=1; AJvYcCUgHIFamuKVIlVmT2CEPjgxdt33Mz7CkemdtDX9vMfN/c08/ozCQBnjlhOerhEX3g18K/T+kzpTyPv4jAM+wA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn7V9GmI7fCRc9Ethdw74TXcO+JZ+JFWXDZGHan0WlZQR3utax
	w10iLQcnos+BQ1+z9sSOwU+Sfr7IaqI3zsI78CROnJ7K95iO2CMCEc6X2pt3GkgiFKxmgQoYk4A
	8ltklbxz4Gh6bK1S4xbVMGuQ4dK2aKk7bE8FdSYtmiCZpzF8JaiWsdjeNfbDF89u4/6lb
X-Gm-Gg: ATEYQzyLNSUkNcFDQc/eukT4R2kPLEBrMdsfJtzGBJRHjnzRnqWbyNfsqu4pcsm1iL0
	XXl4KZX+Vxz3PgnGrB7OzUwQ7xW0DQQRNIJrlISIf15BguVS9VEAdx8HJzvmCAnu4FQIOIq3zWK
	ADMhC/OIsbVgWO3+PRE8fEQA5nRuqHe0E8Ss/Y6RkwOYhbQ6TIUi9U6h9NIbgqZP4AGlI7X+PYU
	t9p4Gh6Ub26rrZW9KNoe2rtQX7ev/hjK1Y6TVameKVnWfpyrHvfsk29oXLZ6nWo2LXw/4mLNcWm
	Ib3fu3nweRkDnYx4NrbmDjNYgQqTCUKQYumH7uuKwrxODbFcby5sSTJP47cu1nMjQ1b+gJDRGKE
	8X07/ol2QAXiFB6oj7B6plIVumBu1odYugpOz3kin6OMYvA==
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr228267905e9.23.1772441512160;
        Mon, 02 Mar 2026 00:51:52 -0800 (PST)
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr228267415e9.23.1772441511572;
        Mon, 02 Mar 2026 00:51:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbd781sm233836855e9.8.2026.03.02.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:51:51 -0800 (PST)
Date: Mon, 2 Mar 2026 03:51:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ShuangYu <shuangyu@yunyoo.cc>, Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ON5yrNjBwUz-vUr4WED3MKSVMJ_4KMCJEhbhYY0wMRs_1772441512
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

vhost_get_avail_idx is supposed to report whether it has updated
vq->avail_idx. Instead, it returns whether all entries have been
consumed, which is usually the same. But not always - in
drivers/vhost/net.c and when mergeable buffers have been enabled, the
driver checks whether the combined entries are big enough to store an
incoming packet. If not, the driver re-enables notifications with
available entries still in the ring. The incorrect return value from
vhost_get_avail_idx propagates through vhost_enable_notify and causes
the host to livelock if the guest is not making progress, as vhost will
immediately disable notifications and retry using the available entries.

The obvious fix is to make vhost_get_avail_idx do what the comment
says it does and report whether new entries have been added.

Reported-by: ShuangYu <shuangyu@yunyoo.cc>
Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested, posting early to simplify testing for the reporter.

 drivers/vhost/vhost.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d20883..db329a6f6145 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
 	__virtio16 idx;
+	u16 avail_idx;
 	int r;
 
 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
@@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 	}
 
 	/* Check it isn't doing very strange thing with available indexes */
-	vq->avail_idx = vhost16_to_cpu(vq, idx);
-	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
+	avail_idx = vhost16_to_cpu(vq, idx);
+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
 		vq_err(vq, "Invalid available index change from %u to %u",
-		       vq->last_avail_idx, vq->avail_idx);
+		       vq->last_avail_idx, avail_idx);
 		return -EINVAL;
 	}
 
 	/* We're done if there is nothing new */
-	if (vq->avail_idx == vq->last_avail_idx)
+	if (avail_idx == vq->avail_idx)
 		return 0;
 
+	vq->avail_idx = avail_idx;
+
 	/*
 	 * We updated vq->avail_idx so we need a memory barrier between
 	 * the index read above and the caller reading avail ring entries.
-- 
MST


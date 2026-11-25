Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593260;
	b=Z/n3fPSqFaj/Pxtobnyf1uLAsFUnjCIQwlAqA4WmTIYxsdS9NHZn1TfQAXdv9mL2ZSsT
	 y3HCJyoqNjz/NRNHF84ejlRG0I0f0K9CdE8fYUD2FKff7QaoFDX21ugcp5VHKVbFk32mJ
	 xA8Oi/p9ok203aYZgV/naHHha30t6l3UMVviOgpUniRTYV+uF+VQz7ffi1mRHGEJOYQe9
	 qlxtIT+6+eKO1+p2sLU6c+gtbl+/RgAY+cRAXXBxdyMYPOd+RZ5pPWs+oSKH00XHz0olH
	 dfs2V9Ovgbt9XAt92MuCGYouU5HJeDYjn5t0LVClmvlIU6jbCM51+/+gIP//OTMtMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593260;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=nzfuELwfbCWCG9kJTniiJOjkP4vR0DKnq77Jf0as+ns=;
	b=y2o6+sVA99hyMa6nmukvok7MJdcBJ3XKeYA6j+TCJEqDdKgyGMAOoQlVDepBxSMF9zdV
	 idHHS56yjb3uZHB+qlTB6g7P4ugAMKpUP1Pc85o62qCe6GBpYzCIQKfF9xFYsWtjNkGQP
	 YjRwb9LVPRnMhO2lPtn8jq+WApmmF0ys7x3jQr7PngMI1rAcC1E5YR5gpF1ThrkcmmEmb
	 bwA1lRQdWULYSxbRog4dvHKjVl6NU3GtwhQTNSFyPmriABwenGj49ZKiZSzMARCeqKQdN
	 gmRsfImojBep375wlmTGGWsZubQVcHiyPxUuT2z9I/omLLokRceeubiBf/0JBuh6Nxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="IifRLJ/g";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0A606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 07:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IifRLJ/g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795593258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nzfuELwfbCWCG9kJTniiJOjkP4vR0DKnq77Jf0as+ns=;
	b=IifRLJ/gPpIthsCMR/qNLzUl2hE2QidTC0lA71DL6o9tZ+0eZ7eatrXlnGVRJsaOHRY+OH
	9+0Er/Jc0gsirnRsHlvq32wHGHepg8t3L2pVEYgxrBAoNg8zIQmZZx9eXQ20SmZe/XrTXV
	SOhKGGRjbzG6v6o111iwZXrLoqTZVII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-VATS0YWgOSuX37SXgcce9Q-1; Wed,
 25 Nov 2026 07:54:16 +0000
X-MC-Unique: VATS0YWgOSuX37SXgcce9Q-1
X-Mimecast-MFC-AGG-ID: VATS0YWgOSuX37SXgcce9Q_1795593255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48C67195608E;
	Wed, 25 Nov 2026 07:54:14 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 352771801971;
	Wed, 25 Nov 2026 07:54:09 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alberto Faria <afaria@redhat.com>
Subject: [PATCH v2 0/2] virtio_blk: add FUA write support
Date: Wed, 25 Nov 2026 07:54:06 +0000
Message-ID: <20261125075408.226762-1-afaria@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7edZIZcO2o1r0Cs-KrvYx8IgSlAA6CGvVFpz4q6BV-Y_1795593255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

virtio-blk FUA write support has been added to the virtio spec [1]. This series
implements that by adding the new request flag uapi definitions and
corresponding virtio-blk support. It also enables vdpa_sim_blk to handle fua
writes.

[1] https://lore.kernel.org/virtio-comment/20251112055113.62207-1-afaria@redhat.com/

v2:
- Check for VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA when handling requests with REQ_FUA.
- Don't advertise FUA support on zoned devices.
- Restore BLK_FEAT_FUA in cache_type_store().
- vdpa_sim: Reject VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.

Alberto Faria (2):
  virtio_blk: add fua write support
  vdpa_sim_blk: add support for FUA writes

 drivers/block/virtio_blk.c           | 28 ++++++++++++++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 13 +++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++++++-
 include/uapi/linux/virtio_blk.h      | 13 +++++++++++--
 5 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.56.1


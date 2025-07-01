Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF9148832
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331858; cv=none; b=SeJkzHqF61kZefiPJ9J4T19VfLYHyaThVhAqwA3FF5jbXUfNc8NbYU7E7oeXLH2uxFjY/UKPNnbaUWyvHndSCVy3CmayPqVB/TkNr+La9kRy8TNaJCnzyS26MwRGMLPfSX9q1+5alrSncRpTZ0kS3FFu29sPxGncbvJEt7Hkbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331858; c=relaxed/simple;
	bh=6Rp+qY4bi3OIJNgIFwbTBBauHQgz4JeSoKsIyezoA9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEqr0OP8EVIxzWGjCzwha+cM90VzrEfnsAucj8VXUPAkJZAF0gbDTsle+BVip3nT4dYe5HJea833iVrUO8JuazZ0lTg0IpEfAAlxIH78nZ7KFQAR+1nc1IM/6A7CBLrs8BBOmuQNyAx7UH9wIkzu9kW1sHK+vyXP3oYZfiQnhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/9Fvha7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/9Fvha7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751331855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0hveexBlmnX8iDFyB5xczfqbkbK1IqQtF2lc4urTvQ=;
	b=b/9Fvha76BFoXW1KpFQgafudUJAW3jDF8Dyg7jNAHGeXvHVYL81BHtmsgAkUDYuL6k1frq
	3BfDi2LOFZFfEq94w8r+86BP68OfteryhvYzbUvO+yFvjJSYBsK58Dn01daJzodw+nZk6A
	L/y9YfyK7gjQCBglP0p8o/liTOv3h98=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-fc4yjD4nO4qAjr17fPS4Lg-1; Mon,
 30 Jun 2025 21:04:12 -0400
X-MC-Unique: fc4yjD4nO4qAjr17fPS4Lg-1
X-Mimecast-MFC-AGG-ID: fc4yjD4nO4qAjr17fPS4Lg_1751331850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 260141808985;
	Tue,  1 Jul 2025 01:04:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E923518003FC;
	Tue,  1 Jul 2025 01:04:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH net-next V3 2/2] vhost-net: reduce one userspace copy when building XDP buff
Date: Tue,  1 Jul 2025 09:03:52 +0800
Message-ID: <20250701010352.74515-2-jasowang@redhat.com>
In-Reply-To: <20250701010352.74515-1-jasowang@redhat.com>
References: <20250701010352.74515-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

We used to do twice copy_from_iter() to copy virtio-net and packet
separately. This introduce overheads for userspace access hardening as
well as SMAP (for x86 it's stac/clac). So this patch tries to use one
copy_from_iter() to copy them once and move the virtio-net header
afterwards to reduce overheads.

Testpmd + vhost_net shows 10% improvement from 5.45Mpps to 6.0Mpps.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V2:
- fix the data_len calculation
Changes since V1:
- add a comment to explain there's no overlapping
---
 drivers/vhost/net.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 777eb6193985..9dbd88eb9ff4 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	copied = copy_from_iter(buf, sock_hlen, from);
-	if (copied != sock_hlen) {
+	copied = copy_from_iter(buf + pad - sock_hlen, len, from);
+	if (copied != len) {
 		ret = -EFAULT;
 		goto err;
 	}
 
-	gso = buf;
+	gso = buf + pad - sock_hlen;
 
 	if (!sock_hlen)
 		memset(buf, 0, pad);
@@ -715,15 +715,11 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 		}
 	}
 
-	len -= sock_hlen;
-	copied = copy_from_iter(buf + pad, len, from);
-	if (copied != len) {
-		ret = -EFAULT;
-		goto err;
-	}
+	/* pad contains sock_hlen */
+	memcpy(buf, buf + pad - sock_hlen, sock_hlen);
 
 	xdp_init_buff(xdp, buflen, NULL);
-	xdp_prepare_buff(xdp, buf, pad, len, true);
+	xdp_prepare_buff(xdp, buf, pad, len - sock_hlen, true);
 
 	++nvq->batched_xdp;
 
-- 
2.34.1


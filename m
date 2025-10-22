Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDB2D24AC
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104683; cv=none; b=N1a6OMa2f4JW+CL/mOL9Jh7cyzJ47vnN5Dtns6Z4+fuH6gKv83JnQZM2djosZ61RGlZSgzjd9eidxKl8E2LfomzNlAxsCgqavLj2ioPNze/LyndKdAFhyVOCkb//1SByJ/qonEyAbv42E0BTWd22QMvK/V7Wn7UTmdlcO2sOvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104683; c=relaxed/simple;
	bh=GSf7P5eeM6DUVSbiDUnm9pzJvTlKHLcPcHgt1685c6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=p9qLAN/h7czkmrBPgEdDQxr/JsRjYJ3xDpbbJ1heUskY2p235PbEsAMCt3SKabxr6DDaUUFpWT1owXtW4y6z9ZGbe2vTQA2HsgNBZPU00xeDczcG/13Pk+ck0pjVyO/5FJ640NpFLeJXrF6g4qALksZxAGOKUz2rlmXl/iWF6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCu1DHKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCu1DHKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4YJ9DUknv9IQ4DZMUZL0RfnKpN3mq1st9g8ZzhMtYo=;
	b=QCu1DHKienHe5NhN9gWlD0Ka52kqY5Yybfp3EFmoYxx6s2+SzvPciutD8oIQQDCo7M7IQP
	6T27jHnHViRq3w0IhsFzGXRyn4abBAlSDaqxRRfFxHNn2D5/hCYZGh7gUz63R/xCm1tboH
	FEmrrgu9FFGMW3CHuJd2epnUjb9eLyE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-N4HUP1niPQSCwWAd55P3OA-1; Tue,
 21 Oct 2025 23:44:35 -0400
X-MC-Unique: N4HUP1niPQSCwWAd55P3OA-1
X-Mimecast-MFC-AGG-ID: N4HUP1niPQSCwWAd55P3OA_1761104673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED0118002F9;
	Wed, 22 Oct 2025 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D71A219560B2;
	Wed, 22 Oct 2025 03:44:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net V2] virtio-net: zero unused hash fields
Date: Wed, 22 Oct 2025 11:44:21 +0800
Message-ID: <20251022034421.70244-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
initialize the tunnel metadata but forget to zero unused rxhash
fields. This may leak information to another side. Fixing this by
zeroing the unused hash fields.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4d1780848d0e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
 
+        vhdr->hash_hdr.hash_value = 0;
+        vhdr->hash_hdr.hash_report = 0;
+        vhdr->hash_hdr.padding = 0;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
-- 
2.42.0


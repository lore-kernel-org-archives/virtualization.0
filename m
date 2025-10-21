Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8ED7DA66
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019329; cv=none; b=TtP/U/ywfhmbVkFeo4+VtGMPIPyJYv0geCxHNjTLp7TKmhCE8LRuIFBe6ePBeVjR3FPMb+8019XoQb5RTE6VLCyvXFR3VKiVvfTc/hy2tAdf3yaUo8cKnojTK005VzBiZJ0onmpSwozOnfO14ps0PUoinvzPBG7aaCwWOccB3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019329; c=relaxed/simple;
	bh=wDzEUsxTs0HUyl+iDwt3UIdWCbndTkElyHk0pfl57Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=o1QOmSZjTaZt8Ii4b9EUYVpaQZsSO/ndE8ETW1FZItmjU8sueWNUboXAOHSX3mhKvJ7FKG+PxijuUy1tgErZuOc5/yr8fNYclbLZbXTuFuJTisVoFWSPwJYbzvNbEdEDTZEJX6teWDOHkTgsdtiYU8zgLXtr7+bFFSLCfsst98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuE67yGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuE67yGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rL7lFmSI7S3KHfZ01SLxw49A4U6D/hN5WOkCgf3+TU8=;
	b=QuE67yGTvd4fJiyhzHTNMCTYHIsE6LcdrnhRQ/ntRVXt3oUdfGfDSPcY7X7hun5MJY83xF
	79y2qtCBr7ESAVoqmr3FII5BsPQs4vlXlYYiosfhnVdpr59q7qavKXom85Th3JRlQ2tzaL
	EZk6hRBGsDcE8k109QvLvdr8yjyYRMU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-_oBuolmeNYyF2XXsrfOPCA-1; Tue,
 21 Oct 2025 00:02:04 -0400
X-MC-Unique: _oBuolmeNYyF2XXsrfOPCA-1
X-Mimecast-MFC-AGG-ID: _oBuolmeNYyF2XXsrfOPCA_1761019323
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 035751800365;
	Tue, 21 Oct 2025 04:02:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.71])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 958F11956056;
	Tue, 21 Oct 2025 04:01:58 +0000 (UTC)
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
Subject: [PATCH net] virtio-net: zero unused hash fields
Date: Tue, 21 Oct 2025 12:01:55 +0800
Message-ID: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
initialize the tunnel metadata but forget to zero unused rxhash
fields. This may leak information to another side. Fixing this by
zeroing the unused hash fields.

Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
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


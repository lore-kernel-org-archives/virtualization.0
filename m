Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CC23F296
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482899; cv=none; b=I84u587d2Nt0bZLIB1raMCe3B/46qLvtUtaUpkCFCqEineCHFluPZHAr9BUIxpX4DM+DwY8uIECvFL9T9BUMtDl8+g9NFi15ti6udnoiASBUrOONZWC43e2RrBD/PVgUrvMLh5Jhj7jtFgdyFngqcq34b3esh2iy6/HWO+NF7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482899; c=relaxed/simple;
	bh=U07cQxAmAHW0l8o/qdYSoRO4Bi1qjKGeW+p5fMARMQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6KsLID5tauvcrOIqoZ2goP/lTwKHjwkLnStFynidY/+QeVrFml0242L0UA2FNOBp3j30QtDwrfVYw3Xk866YGK0CU/Y25od+DJrt9vbKKBjM8YZFZmA7a5GcdtBehgr9HcsFx2qkkoosEmd0polAJALJEKPoddKlp1jh1WG/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIOiBHzK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIOiBHzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752482896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwtbBiuZ1OgDvhN1Fwx3QN8iamrnQZ8Wagomy6Ufebc=;
	b=gIOiBHzKnGVXy16qBUpOnn+nY0CpeJgJWy3l+lv1InZsfSvFadSHmkVVgU9JfYmciCQw4y
	dnYHnAbBob0nQgMsyIY9nniqfDINu6yuGjoXr9e/PxGMqFJcCyLcNJbdoGw1fiBZRgBeuu
	b4axc5YuZViNc0tN+HbZGu8hwRWG8IA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9hQ_uzYyPzGEpOhpKRDbcw-1; Mon,
 14 Jul 2025 04:48:11 -0400
X-MC-Unique: 9hQ_uzYyPzGEpOhpKRDbcw-1
X-Mimecast-MFC-AGG-ID: 9hQ_uzYyPzGEpOhpKRDbcw_1752482890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4EF91808985;
	Mon, 14 Jul 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3EF51803AF2;
	Mon, 14 Jul 2025 08:48:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: [PATCH net-next V2 1/3] vhost: fail early when __vhost_add_used() fails
Date: Mon, 14 Jul 2025 16:47:53 +0800
Message-ID: <20250714084755.11921-2-jasowang@redhat.com>
In-Reply-To: <20250714084755.11921-1-jasowang@redhat.com>
References: <20250714084755.11921-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch fails vhost_add_used_n() early when __vhost_add_used()
fails to make sure used idx is not updated with stale used ring
information.

Reported-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5ebb973dba..d1d3912f4804 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2775,6 +2775,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	r = __vhost_add_used_n(vq, heads, count);
 
+	if (r < 0)
+		return r;
+
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_used_idx(vq)) {
-- 
2.39.5


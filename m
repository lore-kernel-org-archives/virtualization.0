Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8A215F5C
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957314; cv=none; b=Fxo79SI57rYymr+MpLEBGkq2Ppa6LppJg8Cc3L1w+7i6agruzYE7vtXTFCmFjUBWQ+xE20pesCls3hbmDp6I7EZ/KvTviN5pJkmTHkOF/xZlPk97t4mJKZdhk6h9g+zBbUtGclQ2vrfY8qaqn16tJoUT5k4nfa+i88Y8cpFfWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957314; c=relaxed/simple;
	bh=yGVJxfUZE1KtHEBfNS5jt0mdIntrUHouPZnqSr2FpaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucVi2qNTrRq5Tpxb6fiLDE/b9d8dibL7Nri8TFiY99M7unAvB7UdyqTRMqsPygbk1jMK1/TXKhw7JhomHURrg3jtLGvwR9jJjdCyzWh0YZTjAQPlAsE3WpsMWftC8HskU6aXZ450C6zgp+XCyVsvyr5U30+md5+eFnTCIjOmFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU1XO8ax; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU1XO8ax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751957311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsum3ML/FjoVgbok+3MjXVB4I8gHTKKd+8yAm4t36GE=;
	b=QU1XO8ax5nFZlH2bgYXAjp/KGy2LG0heHWsPiVJxcn5raWjFTP7dPYjz5v0MnNjUbtR8Jc
	YyYn4psHzuRLMFcvnhH0m7v8HqUpX4QKT7VN0AeB4TTr0ysN4VN2QCk3IMXkow2w9vX6dy
	pxQlNGPmj8X/YwsjrfFM03PtLEOwtig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-4pB-6n1FMB-tQg3X6MkRvw-1; Tue,
 08 Jul 2025 02:48:29 -0400
X-MC-Unique: 4pB-6n1FMB-tQg3X6MkRvw-1
X-Mimecast-MFC-AGG-ID: 4pB-6n1FMB-tQg3X6MkRvw_1751957308
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740891944AAD;
	Tue,  8 Jul 2025 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.173])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F218219560AB;
	Tue,  8 Jul 2025 06:48:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: [PATCH net-next 0/2] in order support for vhost-net
Date: Tue,  8 Jul 2025 14:48:17 +0800
Message-ID: <20250708064819.35282-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi all,

This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
feature is designed to improve the performance of the virtio ring by
optimizing descriptor processing.

Benchmarks show a notable improvement. Please see patch 2 for details.

Thanks

Jason Wang (2):
  vhost: basic in order support
  vhost_net: basic in_order support

 drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
 drivers/vhost/vhost.c | 121 +++++++++++++++++++++++++++++++++++-------
 drivers/vhost/vhost.h |   8 ++-
 3 files changed, 170 insertions(+), 47 deletions(-)

-- 
2.31.1


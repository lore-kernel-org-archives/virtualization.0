Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5122F76E
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482892; cv=none; b=Jh9xY2JTxNg0JX4BSCyOiW+xnD8qO/w8YnjUyiVK++vGDDZhnlioFCI9xniHg9WSA1Ur73j5HFCXkPeXPD/8BobT+N+9ngBg5d968bJLmuU8MVrKPJw1F7AXQYBknGiEQkqPyJVjVQhWxozZTgnn1rGhCX0wMke81QJUEqiTtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482892; c=relaxed/simple;
	bh=2niaVsTmWeDEc1GLMp2VpCA/RTFr3wbMcCJdr+ANmuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGgHTzCHbQRy29ig6XHppK87ib6t+8aiP8CRHJi6swpA+ZI2sXx4c3mTFYGzcT9gaLvbn+TT3ItPGt9PNLpoaD536WOg1PFRe623u9Ko0b1NAE2YLtwoWk/YX10ucLjSanrNb/GDqdhO6oDWA0URZ+4laKbXmLBF+dW/QH7EMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdjwQZCK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdjwQZCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752482889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2gVoPhyx6QmIeHT3O2/lEXU8D3dbckG15WcXenmrf30=;
	b=BdjwQZCKWthsI/qRBrjDawUOzRWRfFE6PR1IzHtJUkYrk/5lmLxKzpnxSUxanRnrB25ABR
	9p7LIKWaKFBBsStWxAQLdTykbhDc0t9GlDsLQuytqFs7/jAzqFt1TwO3UV9zD9CXbbnZR+
	kuhAjOsKDxoZ7pU+z6o/GrB268wqiBY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-h7jNacrzNwGlmuqQFUoXGw-1; Mon,
 14 Jul 2025 04:48:06 -0400
X-MC-Unique: h7jNacrzNwGlmuqQFUoXGw-1
X-Mimecast-MFC-AGG-ID: h7jNacrzNwGlmuqQFUoXGw_1752482885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410711956089;
	Mon, 14 Jul 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2568218002B5;
	Mon, 14 Jul 2025 08:48:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: [PATCH net-next V2 0/3] in order support for vhost-net
Date: Mon, 14 Jul 2025 16:47:52 +0800
Message-ID: <20250714084755.11921-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi all,

This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
feature is designed to improve the performance of the virtio ring by
optimizing descriptor processing.

Benchmarks show a notable improvement. Please see patch 3 for details.

Changes since V1:
- add a new patch to fail early when vhost_add_used() fails
- drop unused parameters of vhost_add_used_ooo()
- conisty nheads for vhost_add_used_in_order()
- typo fixes and other tweaks

Thanks

Jason Wang (3):
  vhost: fail early when __vhost_add_used() fails
  vhost: basic in order support
  vhost_net: basic in_order support

 drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
 drivers/vhost/vhost.c | 123 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |   8 ++-
 3 files changed, 171 insertions(+), 48 deletions(-)

-- 
2.39.5


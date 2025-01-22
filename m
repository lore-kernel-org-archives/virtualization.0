Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994C1684B4
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526589; cv=none; b=Ok2KL+0P+y5pFq1zFW4azwCvxnX0q9cYDrcaO+O1rNV1+Ivh9XhJunldygKkc04YaMccxUmvrAfsz3Gmydee+oqX8vnolMpGZmBdwxEpNVFMOKU0KTICqETSPot40w1Zbp3Srkd/HIt5f38ZCek68Ldfr5SQtjQa6tGKn0vBrII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526589; c=relaxed/simple;
	bh=5uxtqZMfHCev+JG6XrIgLTHL5fLil3E67cwwPRm0LA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjHeTWnvfReYd8Xuj+McSBTobS8h2+LUUVZIDokBd8igzTO0RhUEISxDd9oPbOmf1p2xAOhEuiy7eNlp53NE+mJX5b7G0VVMlZ6I2kNLpzWWrp+GYWazCW61QFVH4kMlZPtJGMli8vpu1IVJ6MpdbSsMaWC22CpKmZJTAm/PvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QP1vS9Jm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP1vS9Jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hr9kjAOl5Zo07A2Y7Yx2gYOn95HiryxvxLZNJycD00I=;
	b=QP1vS9Jm6ezHSZ7WUpGuQaExgpUu3tlgdHJoBezb2YJHYqlaNMsLV2l2e1gVghUU1ZHZ+n
	xRYkil+RFwUd8iSTylpYtAodn4S3cutttrK8B/ym/A+HNxwfmfF1S/kAxorP6Ozu2spfzS
	IObGGbo5F9tUWuoAnxW7nzZOQfakQZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-0wK6emrzNx-ouvt_v_isJQ-1; Wed,
 22 Jan 2025 01:16:21 -0500
X-MC-Unique: 0wK6emrzNx-ouvt_v_isJQ-1
X-Mimecast-MFC-AGG-ID: 0wK6emrzNx-ouvt_v_isJQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69BCA19560B8;
	Wed, 22 Jan 2025 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.209])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FAC3195608A;
	Wed, 22 Jan 2025 06:16:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC 0/2] don't clean packets in start_xmit in TX NAPI mode
Date: Wed, 22 Jan 2025 14:15:58 +0800
Message-ID: <20250122061600.16781-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi all:

This is an RFC to try to speed up TX by avoid cleaning transmitted
packets in start_xmit() when TX NAPI mode is enabled. This increase
25%-62% PPS depending on the setups while keeping the TCP throughput.

More numbers could be seen in patch 2.

Thanks

Jason Wang (2):
  virtio-net: factor out logic for stopping TX
  virtio-net: free old xmit skbs only in NAPI

 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 13 deletions(-)

-- 
2.34.1


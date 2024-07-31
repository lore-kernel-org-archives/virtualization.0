Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34E1803D
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395835; cv=none; b=SzAf2M/RmicwSaCHCANiqr9/22qkPMloxBYHqcDRSai1b9JPz6HgNCVZGaxmFqDI0FBgopAnGSgqHwdgsczsTrqxV6K3DqIvL90uawj3QSxft7ZqKmYdpY5S/kfUgmYIpVBJ3QcoBiFf+BpUUAu+57ETnAB1ecPv7uwfhoQtMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395835; c=relaxed/simple;
	bh=JkBRTB0ebER9e6F0wnfv+1oao0kqLVhNaXL7YIZG5VY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FeXGIScrf5jkFHpsVOlLQ2/uiQrcBG6OWfXXaeMbagjERuxY6LZTMZocLqRITW0GGkudZiOEIFDV8EUe8n6JRrS2PGGLQkBo8OOySZoC8aIf0W7LR/doVSa1uyJtak1WBjstZ6RCjxaLWxgcHUb2el8eNS+awPDTYYhZyM2iW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR6ATMOg; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR6ATMOg"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0949401EF
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KsJ2-F5dj1iz for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Jul 2024 03:17:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AC483401D4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC483401D4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NR6ATMOg
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC483401D4
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KK/99rFb/OJa+qbI6cUHEnX47Fd/3MtoZJKyHfCgvOE=;
	b=NR6ATMOgsuCaLFvZSmv0nOenVgWGla2aeI+apE60bZ9V0V0b/NpucLBbXI6a8YOOV0pK0T
	G/JjWjvWvMsH4wnRqOSEPtawm82YnSHlsRaotv+0mHZ6P7vyiXZ0cIB3kzJUCh4wSn4DLf
	vuEl+l39dDc8iwY11OjFDsua3V89qtA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-nVVNNzlmNjm10iqHNzMEoQ-1; Tue,
 30 Jul 2024 23:17:07 -0400
X-MC-Unique: nVVNNzlmNjm10iqHNzMEoQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E2221955D44;
	Wed, 31 Jul 2024 03:17:05 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A610C1955F3B;
	Wed, 31 Jul 2024 03:16:59 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] vdpa: support set mac address from vdpa tool
Date: Wed, 31 Jul 2024 11:16:00 +0800
Message-ID: <20240731031653.1047692-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments
Changelog v3
 - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
 - Add a lock for the network device's dev_set_attr operation
 - Address the comments
Changelog v4
 - Address the comments
 - Add a lock for the vdap_sim?_net device's dev_set_attr operation
Changelog v5
 - Address the comments
Changelog v6 
- Replace all the memcpy of mac address with ether_addr_copy()
- Remove the check for VIRTIO_NET_F_MAC in vdpa_dev_net_device_attr_set
- Remove unnecessary check
- Enhance the error log
Changelog v7
 - change the code to reverse-xmas tree style
 - make all patches pass the check of ./scripts/checkpatch.pl --strict 
 - Address other comments
Changelog v8
- Change the fail return value to -EOPNOTSUPP
- Improve the error log
- remove the  unnecessary memcpy
  
Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 79 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 137 insertions(+), 1 deletion(-)

-- 
2.45.0


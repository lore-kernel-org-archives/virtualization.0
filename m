Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404B824B5
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928655; cv=none; b=hR1qCPn0zGQ63q7Ew1vcb+tzvO4ruVDD4xhGl2y9N7pROEQCj36lcg8ZUL4ljiWqpuOpiXTvSaqrbKGQFJhncUJFTKJvMeY7sia3oAjuYwOay67lwOUsH10Cb9VTw3IerhqaLhoaFXKWQ8/xG0bRtehic+dNFLcBYRAxZ3h/pmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928655; c=relaxed/simple;
	bh=dos5mFR7OGlo/0+OT1mBqy46jgg02Ze4GK+u8PA+3W4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A+zvoBhSV1xkGSsVO+mKrAC+BVOVCerGnRl0WVfHGJlDcIm3x9HYA6bsY8eatZK/6B8DQViquf3YnblwoEXNDDQyemMd1BoNqk8GR/GYucNCfSgesf93gcFDT1bP6IHU/1FScBs/VlHQ/+ZytUaYhkRkD7kWX9yuSakB9EzSw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbXvTvV6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbXvTvV6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 027F560744
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Im3RGq9yP3Dz for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 13:30:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 39F0B60743
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39F0B60743
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbXvTvV6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39F0B60743
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vN5LU15jD5iu/2/mvrypQik1qqqlfRZO/11n/IoWnz0=;
	b=VbXvTvV6mmoRge5+en3vrHyCueepo8qKpOmYd/po/uVot4wpBABIR9Ze26FwSpU5hHqmKr
	Hz8f6YHiGAkJrhc2g5+DtEOKlrwhPE0lEGTyGzAyilJkTxMg4skoK0oErgk2rAV6O6ABgx
	SxhJ6jvu5eckEpZ6sLDD3yFU5ggeIsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mnuFJhWMNgacB_b7a-sh5Q-1; Fri, 12 Apr 2024 09:30:48 -0400
X-MC-Unique: mnuFJhWMNgacB_b7a-sh5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A42FF104D503;
	Fri, 12 Apr 2024 13:30:48 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A74F40C6DAE;
	Fri, 12 Apr 2024 13:30:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 0/5] vduse: Add support for reconnection
Date: Fri, 12 Apr 2024 21:28:20 +0800
Message-ID: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Here is the reconnect support in vduse

Kernel will allocate pages for reconnection.
Userspace needs to use mmap to map the memory to userspace and use these pages to
save the reconnect information.

test passd in vduse+dpdk-testpmd

change in V2
1. Address the comments from v1
2. Add the document for reconnect process

change in V3
1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchronize the vq info between the kernel and userspace app.
2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get config space
3. Rewrite the commit message.
4. Only save the address for the page address and remove the index.
5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
6. Rewrite the document for the reconnect process to make it clearer.

change in v4
1. Change the number of map pages to VQ numbers. UserSpace APP can define and maintain the structure for saving reconnection information in userspace. The kernel will not maintain this information.
2. Rewrite the document for the reconnect process to make it clearer.
3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS

change in V5
1. update the Documentation for vduse reconnection 
2. merge the patch from Dan Carpenter <dan.carpenter@linaro.org> vduse: Fix off by one in vduse_dev_mmap()
3. fix the wrong comment in the code 

Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (5):
  vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
  vduse: Add new ioctl VDUSE_DEV_GET_STATUS
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  Documentation: Add reconnect process for VDUSE

 Documentation/userspace-api/vduse.rst |  41 +++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
 include/uapi/linux/vduse.h            |   5 ++
 3 files changed, 171 insertions(+)

-- 
2.43.0


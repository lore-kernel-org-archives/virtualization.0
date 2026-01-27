Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7B2BE034
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503190; cv=none; b=pEnTOolJAN7ssgIsgu9K9P74ihiifEBbn/Z5xBD93G5qmwP1V1mIeYdFmfrcQmws2fGBnGdOVbuWugYDWwwRak2qpZrnRJNcQJbYh5S/f9senFKoQ7R17zxcKhkdu4a8diS1X/XQ9LYlmzEMwadpP1kPpxsbWoeVYkNKCD9u2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503190; c=relaxed/simple;
	bh=cl0LxVeQsTQ+ltQm4lRuxvR5KGXg1pbRIYI1LfN+V5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkWHika8zLIo9CSHYUxJ9toqcfZvw0opq6RYTmveXSIYaN7VdBoBdbde6NujWxCDyhe06BgKvTHytoTLDnZi+bYUTern+7zVh/XCD+DsQo+0yJ55/XOFSqDzDEPMPHASR2oAnrcgYj1BcragAIs9m9eI7srUjxaOv6v/MyoSH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aYwfLktW; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aYwfLktW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769503187; x=1801039187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cl0LxVeQsTQ+ltQm4lRuxvR5KGXg1pbRIYI1LfN+V5A=;
  b=aYwfLktWJEg6NOYMvNBz+ooLatGdBTUdwWwKBVVYMgRC1j//eRLBemJh
   Zi/cAwEExJ3SfRUODLOubDHsYW2XtZnrUGAj/7WJV3WH64AehyWp6Q4UH
   MWWFke/FMtT8D0ttkJdm5RMzTyAP4g77aTsej1HCIDr6LUB81mHQ21jnt
   SrizGQRE3m3qpWpuAA1JZMFOd1G+6tmZYeG7seNrD0A4RDjlmgekNBY5Q
   IetqmMgkvTIVGxnPkdVmrabSc8xgDLRDrqla4uQwyC5XqtSj73ToMV49y
   gOxuXZ91Cj9TPtxIiLvs8/0DO3B3h4YERTvXPLuk9IZ9uum/iRiEYB3yQ
   g==;
X-CSE-ConnectionGUID: +MlJ1VOlSnuz9zfmy1pSyQ==
X-CSE-MsgGUID: c1dIzyFkQASIkS9pioCbQA==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="140205735"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 16:39:29 +0800
IronPort-SDR: 697879c2_1QX8iAj00m6hGqZYaGZcFjRClxjkef0dc1M5PyXDUcOZIqK
 m4v+twlqvNIPYpNJrkU9UkulREe65Id43lMy+Pg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 00:39:31 -0800
WDCIronportException: Internal
Received: from 5cg02580n2.ad.shared (HELO neo.wdc.com) ([10.224.28.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 00:39:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: Alexander Graf <graf@amazon.com>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 0/3] virtio: silence KCSAN warnings
Date: Tue, 27 Jan 2026 09:39:23 +0100
Message-ID: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting a Qemu VM whith KCSAN to debug filesystem races I
encountered a bunch of KCSAN splats in virtio.

I suspect them to be false positives.

I decided to send this as an RFC patchset, as I have no prior knowledge
of virtio.

Johannes Thumshirn (3):
  virtio: silence KCSAN warning in virtqueue_kick_prepare
  virtio: silence KCSAN warning in virtqueue_get_buf_ctx_split
  virtio: silence KCSAN warning in vring_interrupt

 drivers/virtio/virtio_ring.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.52.0


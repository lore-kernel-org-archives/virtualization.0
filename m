Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85A35B63F
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527541; cv=none; b=iPGVxw5xbQcpD76DNb5NJxGqjDl77vGjY8bHmabdOJlSO/XZNgDHPNMK5Smhc6gHYRZGwXr+dCATO2ta6o1zYFABj/3KrI+2MbNdlh601kN8uzpFDpFeVDBUsjvSsSatXCKCzlHurHletDXKd5oHJQNvE5enSLAShaJ+cTZMTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527541; c=relaxed/simple;
	bh=llsVGLncDbzB0r+ES+Lyo0qzgyhL7Aea89flyW8GFCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zrp93g4+duwPcBhvRJuk2wMFg1HgrR+PqOY0C9PT3lY4MsnC2JB/VWPOy/mFYDp2zMdCC5sHH3CyF6pdsdTj4hju3PC7v/AEaq2/vQxj2jS6hBLfjQc9HLzwZR/pxr7qxU1crg+hGyigXdv7EoIkGZVGefkanDGouSn9AJdaotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qjSGV65Y; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qjSGV65Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769527539; x=1801063539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=llsVGLncDbzB0r+ES+Lyo0qzgyhL7Aea89flyW8GFCE=;
  b=qjSGV65Y0SkmJ5EaAFZ9fHE9bdufqP5eaMcAighKjxxss5nrhOfs+TGc
   diauyashwsC11HY7vcnubuIyWB+arkPUn9avNW5tgcPHQFFVUWGLppmmh
   Wx8UWEGtl+pSw13imhIY/W/IFVY9F6fAq2S/FYpsw3a+tOjrow1ZAIHeS
   O4P7PtIkVGZC7ocE6jMnRLYqiejnWMf4SuE2WQGvV9dCe3BIjbutjzpeW
   SdNt4BWG8Rwiap9DqMu4QLSZdI4jajj7miz8P584FooEV+rDgC5HbGBuh
   sM3z979swCjjUneyoTKXQqR3h+GcmuNzcOQXy0z7/EeWxB+JexoXYMGum
   A==;
X-CSE-ConnectionGUID: 6GBBNNrjSNuIQztOah1Q2w==
X-CSE-MsgGUID: fwh5e71MTy6ddhiClDIuBw==
X-IronPort-AV: E=Sophos;i="6.21,257,1763395200"; 
   d="scan'208";a="139288697"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 23:25:32 +0800
IronPort-SDR: 6978d8ed_X4QVlxKETPBZeoxkfe38fON/NSF6aEofpwxSE64DL+zc58l
 mWqoe8w0IRMC+2Pz+fx/pt6WS0vcVxmKYYBbfrA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 07:25:33 -0800
WDCIronportException: Internal
Received: from wdap-nm5iivsczy.ad.shared (HELO neo.fritz.box) ([10.224.28.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 07:25:30 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] virtio: silence KCSAN warnings
Date: Tue, 27 Jan 2026 16:25:21 +0100
Message-ID: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
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

All of them are false positives, as the racy unknown origin is the
hypervisor.

Alex suggested to annotate the vring structure as racy for KCSAN, but
the __data_racy annotation turns into "volatile" and as such it cannot
be used to annotate the whole structure. Annotating every structure
embedding a pointer to the vring turned out to be way more invasive than
annotating only the few sites consumers.

Changes to v1:
- Annotate the return of more_used_split() as racy so both call sites
  are covered
- Annotate vring_avail_event() as racy so we can condense two patches
  into one.

Link to v1:
https://lore.kernel.org/virtualization/20260127083926.865555-1-johannes.thumshirn@wdc.com/

Johannes Thumshirn (2):
  virtio: silence KCSAN warning in virtqueue_get_buf_ctx_split
  virtio: silence KCSAN warning in virtqueue_kick_prepare

 drivers/virtio/virtio_ring.c     | 4 ++--
 include/uapi/linux/virtio_ring.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.52.0


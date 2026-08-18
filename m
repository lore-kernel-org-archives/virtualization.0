Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9433C1B7
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087703; cv=none; b=uRcUR3V5CCEigr7fY/AWcFPdRfu+DQuhqJUrCI0SUboLN5lMR/au5yxRSIxVLKnPm+V4omRENeekFFfmZuJ9ZgExXa4IpQJ0uCX/5ghac/q677Uagg7JAztJKmy5UlqgaRn11wG2lPrgDfhtP0ZIEuou0Qt1rNQQ+LShPQuwYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087703; c=relaxed/simple;
	bh=DOtZuqAqGJk8aUckmMgq+SYf6LC9arD5VkbIhaWxhpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R743PPLE3fPBRQj2Wv264OvN8XoHzbvxtgYOPo8fZ3qLOkGnUNdCsc4F1nqcNo3mzfJTwqQbKwDCYcOO1M8VsoS3YhM7sFHVLlqvHA0bnmE4H276R4+iZLZwhYKdGgtBRA32Uxdk8p3OdL8Uo3RDp0Bms9oeAqZSj3OggF3C7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PU+nGaEl; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PU+nGaEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087702; x=1818623702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiFNnChS/jY0CB6sQcXpqUx9HFfhZAKx64wlQSeff6U=;
  b=PU+nGaElDZ7lAf31TaULbDVjf54xgdwQktitEwt9t1lpgMZl3n5rN6JT
   7rTXwR2uExYM294aU7uGfmFg1xsms7Wy1aOsZHex+gGQojv4/jxI4d2Im
   P/r8cd9jAQimpfjLrADOrTYRgloVlu72lT4bD8zsCH8T4fAlfmIA//8CT
   8S2g3GZ+rWczTS41hS3UkIMgOh6nWD9uDn1a/NXitaQvykIB4N9mMy9Nz
   xbYj8eoRmrWokbGS2WkIPiSf9jdVOdjebpLicjHH7xhf/hjTBgtvG6Zmg
   5h1WXMkHzMCC97Mzqbx3DPbzOmnmc6iHBYi5ok0X2HtfISH4/mDRy2mu7
   w==;
X-CSE-ConnectionGUID: QO0YUdWVTyGuDB38mbDguA==
X-CSE-MsgGUID: xK+OyAvTTfSnv4faNHC8WQ==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="25815623"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:14:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:9801]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id ffd00c48-584f-4a82-9ddc-ec3682504bb3; Tue, 18 Aug 2026 21:14:59 +0000 (UTC)
X-Farcaster-Flow-ID: ffd00c48-584f-4a82-9ddc-ec3682504bb3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:58 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:56 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Alex Williamson <alex@shazbot.org>, Feng Liu
	<feliu@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/12] vdpa: drop the VIRTIO_DEVICE_F_MASK example value
Date: Tue, 18 Aug 2026 21:14:16 +0000
Message-ID: <20260818211425.91009-4-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The comment above VIRTIO_DEVICE_F_MASK spells the mask out by hand as
0xfffffc000fffffff, which was correct while VIRTIO_TRANSPORT_F_END was
41. The bound is 42 now, so the macro expands to 0xfffff8000fffffff and
whoever reads the comment to check a feature mask against it gets the
wrong boundary between transport and per-device bits.

Correcting the number would leave a comment that has to be updated by
hand every time the bound moves, and we already missed it once. Drop the
expansion instead. The macro derives its value from the bound and needs
no change.

Fixes: 838bebb4c926 ("virtio: Define feature bit for administration virtqueue")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/vdpa/vdpa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 47c6c3d23f5c..395ca549573a 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -548,10 +548,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 
 /*
  * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
- * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
- * all 64bit features. If the features are extended beyond 64 bits, or new
- * "holes" are reserved for other type of features than per-device, this
- * macro would have to be updated.
+ * through VIRTIO_TRANSPORT_F_END are unset. If the features are extended
+ * beyond 64 bits, or new "holes" are reserved for other type of features
+ * than per-device, this macro would have to be updated.
  */
 #define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
 			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))

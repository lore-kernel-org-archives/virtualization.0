Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76B373C1A
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299622; cv=none; b=ANR3TaklDzsZ/bpIuMOlhyizEYbo9F1ggl0pLTG44KgEQjSKyMD6YYD8h3zM1D/cemcLwtcf16PRqabCT+ghLONNAHIFUPznXcgjX4VzXp8Y1oz+GYA5OtdE+fDlTdE9fBeNeOXZFvepLChaaH/IVxboN95YbspUgiy9/9K6Yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299622; c=relaxed/simple;
	bh=zdpFl4MtmzbUgJL7zsohL1qYs3UZChN8OMZanTHyZXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7ro/h39c89NqgGoUedSjEbC3aGVAb53fA4piEDVXLU+o+HYFawpCUvsfpGEcYTH+6zxA2jKh67H8yxNiACStMrtjPU5ijfvDJ8rXRyMWr7ticHrBARmfLl1GoYv2ZIHBdCcLbKEkMXTBnADp/jwbuTUO1XjiIuQUSPZvFg5/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e6AaKOmK; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e6AaKOmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299621; x=1817835621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDl7UEafOpm77w6dRDFK3GgIysZX3WlQtTfDhkiiqiQ=;
  b=e6AaKOmKZNPFBlnI1yaXRei5S8hnVrN40Q+Nkgy5SQ27VdE4kbyaL85/
   DON2EBa7mjLkQ8BVAySaf8lKhF7Bx1mBGJ6dU76zFBfDgFnDTyfo0seSE
   XWPV2dgyCRY0kmU5pC1ZcT7ieVQAokxUbinO/P0Mg/P6Imm2hm/E/k3gW
   DIztQ7mwSsjCz7CPgQygIhEWR7gGc4CcE3Ayo6G4xs3L7DuBt9M02iGfE
   HzJ48yX1UdfFhd3zqFNNnjhtl48FQnldhK8vP/A0qQYLDZKaJhcIQNsDH
   I5JroD7I4XVok0UGqEN4vlSymNdt1hgmTOvlR+m6YPQVA0mpgfdAqZnRf
   A==;
X-CSE-ConnectionGUID: +AWlV5KeSQeAZ9+skUf8pg==
X-CSE-MsgGUID: zZ5u1sG0ToqbMtHSGfqZRA==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25283671"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7862]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.172:2525] with esmtp (Farcaster)
 id 0b959277-6977-4a99-b734-84217a11f39c; Sun, 9 Aug 2026 18:20:18 +0000 (UTC)
X-Farcaster-Flow-ID: 0b959277-6977-4a99-b734-84217a11f39c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:17 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:15 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Feng Liu <feliu@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Parav Pandit <parav@nvidia.com>,
	<nh-open-source@amazon.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: [RFC PATCH 01/12] vdpa: correct the VIRTIO_DEVICE_F_MASK example value
Date: Sun, 9 Aug 2026 18:19:59 +0000
Message-ID: <20260809182010.32931-2-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The comment above VIRTIO_DEVICE_F_MASK spells the mask out by hand as
0xfffffc000fffffff, which was correct while VIRTIO_TRANSPORT_F_END was
41. The bound is 42 now, so the macro expands to 0xfffff8000fffffff.
The comment is the only place we write the expansion out, so someone
checking a provisioned feature mask against it reads the wrong boundary
between transport and per-device bits.

The macro derives its value from the bound and needs no change, so
correct the comment.

Fixes: 838bebb4c926 ("virtio: Define feature bit for administration virtqueue")
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 47c6c3d23f5c..1757a33f298f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -548,7 +548,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 
 /*
  * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
- * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffff8000fffffff for
  * all 64bit features. If the features are extended beyond 64 bits, or new
  * "holes" are reserved for other type of features than per-device, this
  * macro would have to be updated.

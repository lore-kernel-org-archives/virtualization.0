Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F24361670
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125432; cv=none; b=duS1uq6pRZFNkTB6kLEbZ8Dn4CqsIuAbJKRkFW/5ob+vXDJwGkvMOPuaozK3bSpuTUmGaJvs6kGKzerzoBn2BSKtZV1wPc2YuYXvpuQzAo0Dgx9PU/yHmZwn4D1dEuF07SxZ7D1RUiHC3sm3XXv/WC0xj9M5QZv+N5xd+kWvjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125432; c=relaxed/simple;
	bh=OXRFGV3ZEKm5uHkzNSyrA0yPgKg3XtU9cJdegrnuOko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU97vgDhz+gQgYPHNWAf8/78nWM2zf7X53WivZIcVRThZEXBWHArx2gV1tkbvvezt21Jv51KdtDcMRrLE6EQB0Yp9ooQy9uG0Y9+Btjpg25LFRNpQTz7dwJwwyf1OnQPWyBVbVTv82ViuyOBVvCHz2zsUzRJT38mL41PK2bcwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAd0shrs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAd0shrs"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so5764135a12.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125428; x=1784730228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcxZytprafatkbtEcF/4Rnu8N7mYkaazUCNyoFvFkKA=;
        b=LAd0shrsJ6c5pACLJqFRo+qyw8a4N8oR57H2qGTXPFcFs3kfkTnO5snTx6AuH+Da4I
         ilaUmVSyj6QapSiA1gE385FunduABM3yhZkl4hpnpCTIZ+GP5+e7SyjuVCReHCrPucoL
         XbsOFvtbpjjTxmsmp5hx0I963V5AYDBjfX867pQ/cyIaG0oeWo9gyW6WEMhvnvlaHQ+0
         8OC8kr/uoBr5pdSSy+QFUMkUdo7rE4q08gVrsaymP23ClI5OxXrmeCEOBBgYY+m8R4Un
         rrZC5HW1EzTJacN+TA0EEIFbpk3+VU4VzR4K5MgQoJGVzjBfjjm99//dKHnHcVkJ5tuT
         DRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125428; x=1784730228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcxZytprafatkbtEcF/4Rnu8N7mYkaazUCNyoFvFkKA=;
        b=TvKhpFbc3AckX/qHyOdRjLbEnn6/0A/0EI1vTbIcgmGoyThe20frYO8uJFJcaPt55N
         DwZxHq9vBxsX0+gnrgxp6+iHpgBLJZLbcleM4t8SOEr3vXLoFOQgq/0aDhofSqf5hm9i
         Sl5R4k9IPeocuH4J3l3zcLQ0WyMrGWNF0AHazbDfwVx2HIrsy0UJksX8ML2BasuzaFWn
         DDRE1TtUn455u/rBW+viqviXbqjSn4HVlzeSgHj9kEWQwuOwrcgyFjh+Dwyn4xmNp1vS
         FwqVXyqRU9QESUZEfsY74HIl8j34Bb1j9VKodDxi3M/QbtttejZnFCFcM7lOALkhwHZW
         R1Yg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/+oEViRiOHJKH0/J3754MlThbVSVc7knHNCCN0QHzGcYQUi+z8RDaXSYK6qFv0bMXCVRx2iZYQZs6bkDiFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVslagj1cXUx5Ia8+IiESB/ohwbly0Db/UyRMGBB2OVYSy+ScI
	jfA6nKvlhqANnpoeu9sDq/syGxmltpzylAuRTZqloc36oqcP+MoTeQOA
X-Gm-Gg: AfdE7ckXWKECa1gNfQBCTkeiUnATIUcFrPomcJlKnHmqk9rw02cijbktadPeVZDzlPc
	803BjS+iXsl0tc2vTsGNogls66apRbZWlht6Pn6PkPN6stuNpCGb3b+e47Wvnub0tflHiuNpb9l
	MK5fs1epwAZFd+2o99P4/FvAIQFnym5EX/NrOdwUiRWf6EVfz6NpVcLNvvvFLkBr086DCH59OuK
	ut6nZzy92MiZzymcod6SkvTVlvdYqaAwf1/RqO779sKr5rgZsD2B/uv8HZBsk1TnWJ7Jhen70CY
	0TrL6wUmhl03if0VDoKzWjVTiI/CkYUQOwu0v64sgz9S1my5oC6v30AMwXjOarI8OS0GXv6I7jR
	8wVdLreICEklKcASHanzTkg8pueTvL0F6VznwD1/ca1Ymqq2o/kXxHVg1nHAgqv0N7HjYwzMLSs
	HCXhd19VhRtgcFFvCwR27A108BHxUFCvXFtE3zIMzZIok8/3I7dljszm/0vfuTC/Cguw5FAeqI/
	UcH
X-Received: by 2002:a17:907:f815:b0:c12:2946:ffc4 with SMTP id a640c23a62f3a-c167940e68emr197974766b.40.1784125427700;
        Wed, 15 Jul 2026 07:23:47 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:47 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 0/4] virtio: validate device-reported values across drivers
Date: Wed, 15 Jul 2026 16:22:39 +0200
Message-ID: <20260715142337.22811-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These four patches harden virtio-mem, virtio_input, and virtio_console 
against untrusted values coming from the device/backend side of the virtio
interface. The fourth fixes a use-after-free in virtio_console caused by a
missing refcount.

Hari Mishal (4):
  virtio-mem: validate device-reported block size
  virtio_input: validate device-reported multitouch slot count
  virtio_console: avoid NULL portdev dereference in in_intr()
  virtio_console: take a kref in find_port_by_vq() to fix port UAF

 drivers/char/virtio_console.c | 18 +++++++++++++++++-
 drivers/virtio/virtio_input.c |  4 ++++
 drivers/virtio/virtio_mem.c   |  7 +++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.43.0


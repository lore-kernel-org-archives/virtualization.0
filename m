Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E552222AC
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565108; cv=none; b=AVhtN3W0iXYgmW3j5pG8dFymGoPsD2glvZmZASnviFg8GsQOHLGfkJGvkNjj1Hrd9tPENwC+G2xKlFJJgHDf9des49nLjuP/8Konq1oqFGV8J5k9vaT5bzULscOxG0KqHKBWucSrQ28yOnpDKOslzOV/WlQNN3fBYGVafs+Ztx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565108; c=relaxed/simple;
	bh=0Ze69pOVYWCyP97tOm2XndYB5S6jNW2pRESISwXWI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/AikElsumgN1jWUQ4aqh5s5+QOo/uIBSPMkHsc/GWR8eeKA8NCplBd61JxPDGo75uj5a4wJOxx7lezouK4PBp+hnhjsjv73cu2iIN7kJ4wHrsnynLGUlRgicmVN36mWlfXGZS72i3PmGROnEPl0NayXg+5Q5aY1bIVaDzGk89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPFp06oz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPFp06oz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22928d629faso20255965ad.3
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565106; x=1746169906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtMjqZ/Ns16pRT8iEFKMxWMmeC23SEmlGerRJL9o71w=;
        b=dPFp06oz9e/ARBZAsjFlo5FAucdD+HyFx5B09RQV7J59dEJeC8wnGWY4k9WZlwg5eh
         ciVfixqyS0TUafOx5cQNsfAXxIY59OF5PImPmlevs6Oi40ULozvElJgPEaju3Gqe9vkl
         38fDVYKJMuKhxxRam/T69W3YuIGqhbFhsA9cjlm1vo5xho30ppE1xVqHT24KXTR5JV2V
         UrWYyF9N56TXU8244UlUOqZCBQWSZKA/9E1hvxqS/2vjVj9yLQeY3ceempfXWZOAYH6Z
         X8oeU10/Gj65wB8Zp9nqExR4xVkmcXB5GBXAfWhSn8mh6Jwb4h3x464uLrw43ORxBlXd
         Bfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565106; x=1746169906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtMjqZ/Ns16pRT8iEFKMxWMmeC23SEmlGerRJL9o71w=;
        b=nAe9ck85SabV3ZjsSfV+W3kRg1ypTB2ebzQszX1v3OFM1zewSUoqGj2CRvbG3PHBzr
         c1KacZyTXOFPbzdHVtnWKwYR+4WQ6aX4FLi80WZpLDFOrWQIX1KmEyz0xhApbVhkbKxD
         6pWRVfC+t2g3qLQyDtPBUNZ2x45RfnFwytQvZEdtGy2kdR7t6jVjxoEvHjnUuLIwjr9o
         StljK9++6qqGoYVoJIKi+cxulRiJK9xQ18GrHOl5kDMUtmxkDyhKCxwTFHF5L0JyJ/cL
         s8GiDPpdiCOh0DlwpFScHf08N4r90MVUdN8ea4K7gq2QrCSbScNWeS9cY/EmrS4J3l8n
         p76A==
X-Gm-Message-State: AOJu0YxzPpX2TEnj94ZBdbLXjGth4pwVB5G7T9X5s7+MBAniWIwvTc8W
	eu5M3aiJqlLgFSQ9pHkg6wWbIIFXXGY9eTrm1/UGYta/TrOs0FoU1aZsRwIxieo=
X-Gm-Gg: ASbGnctyj2ZwMu11Wgt0wi/z8rxl5wCQY/T96H9gaHHtWakdlPJ2sfnFM9FK3mRWjII
	P59JNMZnjJb9a7DLRzuD3TSyZsCDl4mRS/V0CMpwpOdfBSW4gvzZSlcCVrB4IAri6h2h8Rus3rz
	m178IhBzdrW+BUwBjlROzU3Yp+gmFcjKz9CHrwnpkJ865Ur/so/NoC+dGfShvCqOCPZTJCZ4jqT
	jwSCYGeTzUrJ/vbpnEpDw8SToDdZb2qwR681ZnX3z8Eo+7OzFTUmaMlMS58S4l9w5u56n9Kqj88
	PSDj3EcCkT17D0qP1k2zY24ufGdSCcDvrEodXcms33Sqt33DIruOpiQk
X-Google-Smtp-Source: AGHT+IHQBCORaP5MawLRFbQfek2IOmsMsFyZUNMLFw+FlPP4B+F/1Z2uUqZZUzD+g/PLxtZRDST5rQ==
X-Received: by 2002:a17:902:fc50:b0:224:1781:a950 with SMTP id d9443c01a7336-22dbf5ebe7amr20344645ad.14.1745565105709;
        Fri, 25 Apr 2025 00:11:45 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:45 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
Date: Fri, 25 Apr 2025 14:10:14 +0700
Message-ID: <20250425071018.36078-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This only includes the selftest for virtio-net deadlock bug. The fix
commit has been applied already.

Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Version 6 changes:
- Rebase on net-next and resolve conflicts
- Move the retry logic to xdp_helper

Version 5 changes:
- Refactor the selftest

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (4):
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: retry when bind returns EBUSY in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 .../testing/selftests/drivers/net/.gitignore  |  1 -
 tools/testing/selftests/drivers/net/Makefile  |  1 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
 .../selftests/drivers/net/napi_id_helper.c    |  2 +-
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../selftests/{drivers/net => net/lib}/ksft.h |  0
 .../{drivers/net => net/lib}/xdp_helper.c     | 39 +++++++++---
 10 files changed, 98 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
 rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (78%)

-- 
2.43.0


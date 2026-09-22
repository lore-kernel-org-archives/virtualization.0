Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957F434996
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080205; cv=none; b=KVXemZfASK3gYjymy92OscpBspL3LTrAz1kvaV9vixJ/AqHoT7CtqUt7ay5OS6Mlw33YUIZvVNvM12OoDt1u1nDuUPx0dEKcKBbwF5k3P8Et44UIvN/u5EYp90kOONodHe6/Q3uCpTmk4nzTJtICKu2DFWm62UtIloWqeDWV2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080205; c=relaxed/simple;
	bh=PrMay2PDMio4LPM/Stxs8Q0612AEyOHv2dZQKcrIV8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/1gWW1CjElSz4ufdconoBpcHd/kHdDOFMW6eox6XoIPWr+Or07SLICRoGOK3IkPSbXnJNJUkjq16qyc2T5Llw7ZhgG9K3rH+6/+xiKnZD7xfT3SiFe1cISIBeUtTmqoPpH2fDL/wsCWf2pOzugNnGfzDX980waQeuwnVhuxH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Ng9k4T0L; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Ng9k4T0L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790080198; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wIvs6Bzn9Mhp/rPNaBk6Z8IGAyJ/9Lyz4gAF5i82P1A=;
	b=Ng9k4T0LT9ePd1kU9A/wM1eZCBQdibgDcXA+rtaVBA1JlIUnkdjWmxd+GtS9qMfgGj8pA611lDcl3ZW3prFeZAwAoXrofNzZpzKiOOXkfdWQnu7YxB/Ff3fMsxqlhjyf11F0huKgsTNetG1lYfNmFVTadbpjA70pULAEPs42ubI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09716257|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0150629-0.000352776-0.984584;FP=2088973265481694556|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jK24y5D_1790080195;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jK24y5D_1790080195 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:29:57 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vringh: fix infinite loop on cyclic top-level indirect descriptor
Date: Tue, 22 Sep 2026 20:29:53 +0800
Message-ID: <20260922122955.69433-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vringh_iov()'s F_INDIRECT branch does `continue` before the descriptor
accounting block, so a top-level indirect descriptor is never charged to
`count`.  When such a descriptor also carries NEXT pointing to itself,
returning from the indirect table resumes at the same uncharged descriptor;
`count` stays flat and `indirect_count` is reset to 0 on every return, so
neither bound in the loop check can ever trip.  A guest can keep the host
vringh worker spinning inside __vringh_iov(), causing a host DoS.

Patch 1/2 moves the accounting block above the INDIRECT switch so each
top-level descriptor, including INDIRECT ones, is charged one traversal step
before the walk descends.  Legitimate chains and indirect descriptors stay
within vring.num; a cyclic indirect descriptor is now rejected with -ELOOP.
Patch 1 carries the Fixes tag and is Cc'd to stable.

Patch 2/2 appends a regression test to tools/virtio/vringh_test.c.  It builds
the offending ring: top-level desc[1].flags = VRING_DESC_F_INDIRECT |
VRING_DESC_F_NEXT and desc[1].next = 1, with a single-entry indirect table,
and asserts that vringh_getdesc_user() returns -ELOOP.

Verified against v7.3-rc3: both patches pass git apply --check.  With the fix,
vringh_test --indirect observes -ELOOP and exits 0.  With the fix reverted, the
walk re-enters the same descriptor without making forward progress and never
returns -ELOOP, so the assertion does not hold and the regression is caught
either way.

Fang Xieyan (2):
  vringh: bound top-level re-entry into indirect tables
  vringh: add regression test for cyclic indirect descriptor

 drivers/vhost/vringh.c     | 22 ++++++++++----------
 tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.50.1


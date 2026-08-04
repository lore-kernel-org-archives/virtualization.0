Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134042E8DD
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830500; cv=none; b=hUVN85E+LqfdoQnfCTElVrr3e38wt6UCMSblXLuw9yASg9HNOqcEZYluf2fS9AKvw4fhiXDL6KQrUQuc+UaNEc24oD2G2POI8d4kqMFJ4oBF/9RUoJJO4rQ1nQqtGT2UV7wGGXNa0ls6OPga9KTJ30kr39l/7Dc/x7aOb5gccZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830500; c=relaxed/simple;
	bh=pmfC9F3/57YenoadxswyylYhd9FVkW1wr+UpdS+6N+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc9Zf6cKDHTIx4ONG5QYvEpouWvRptk1+n/OlyrYHa7MTtH2pVFb6/Yvc8tGbwgZTr6eiyetp018RYq6VZ1oFmSrADALDlAcnavIuQ0TTI7ujkvTjPgaAvW1DqPQsLOabMCessp4FdqJ3lwkf9vWfJn5qYF+TA+dQjvEfDGLtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hGn63ijY; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hGn63ijY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x7
	yK+qZQLI1bzYXZwwISqqMPghuv6sAHsFvdqTFRsxo=; b=hGn63ijYggjhTqoan+
	kHCMMzwzgn04XsLtlerDeDI0Ykii8+vYohLWFWU5gXehDQkTnL9pbsYIucQxkqTf
	9zlPJo0Y0pdgpHu5kMEqM2sYb5Uyhy96l9Uw6wHWOMVQO5+bIBAKqIYMHERh2ebM
	m6Vk7nTdPiUXOSpVCWzJZ3SXk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3+bZVnHFqQsQvLQ--.12248S2;
	Tue, 04 Aug 2026 16:01:26 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: virtualization@lists.linux.dev
Cc: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH 0/3] tools/virtio: exercise VHOST_*_FEATURES_ARRAY ioctls
Date: Tue,  4 Aug 2026 16:01:22 +0800
Message-Id: <20260804080125.79403-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
References: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3+bZVnHFqQsQvLQ--.12248S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWrAw4xXw4UKw47Cr4rKrg_yoW5XF45p3
	yYgrn0yw4UWr1xA3WfCa1Uu345uws3Aw4jgrn7W34UC3WUGryUA3WfKa1UtanrA397ZrWF
	yF9Yqr18KFWkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6KZZUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbC7xg0qWpxnFjT0gAA30

From: Yufeng Wang <wangyufeng@kylinos.cn>

Hi Eugenio,

This series follows up on your review of the vhost/net GET_FEATURES_ARRAY
fix [1], where you asked for a switch in tools/virtio/vhost_net_test.c to
exercise VHOST_GET_FEATURES_ARRAY and VHOST_SET_FEATURES_ARRAY.  The fix
itself is unchanged from the v2 you Acked [2] and is not included here.

Patch 3 adds the requested "--features-array" switch.  When it is given,
the test programs features via VHOST_SET_FEATURES_ARRAY and then verifies
VHOST_GET_FEATURES_ARRAY by issuing it twice with the same count,
comfortably above VIRTIO_FEATURES_U64S: once into a zero-initialized
buffer and once into a buffer pre-filled with a non-zero sentinel.  The
two reads must match on every entry: the kernel fills the prefix with the
device features and clear_user()s the trailing entries it did not fill.
A clear_user() with the wrong start address clobbers the prefix instead
of the tail; the sentinel buffer then keeps non-zero data in the trailing
entries and disagrees with the clean read.  Using a count comfortably
above VIRTIO_FEATURES_U64S (rather than matching it exactly) keeps the
test correct as the kernel's feature-word count grows, so this is exactly
the path that [1] fixes and the test doubles as a regression test for it.

Patches 1-2 are build prerequisites needed for the harness to compile
against current headers: a device-id compat header (since
mod_devicetable.h was split into include/linux/device-id/) and an
__must_be_array stub (needed by struct_size(), which the new test uses).
With them, `make -C tools/virtio test` builds virtio_test, vringh_test
and vhost_net_test cleanly.

Patch 3 depends on [1] for its GET path to pass.  Tested on x86_64:
  - without [1]: ./vhost_net_test --features-array aborts in
    verify_get_features_array() (the GET clear_user bug);
  - with [1]: both ./vhost_net_test and ./vhost_net_test --features-array
    complete RX/TX with started == completed == 0x100000.

[1] https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@163.com/
[2] https://lore.kernel.org/all/CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com/

Yufeng Wang (3):
  tools/virtio: add device-id compat header for virtio
  tools/virtio: add __must_be_array stub
  tools/virtio: add --features-array switch

 tools/virtio/linux/compiler.h         |  1 +
 tools/virtio/linux/device-id/virtio.h |  1 +
 tools/virtio/vhost_net_test.c         | 70 +++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 4 deletions(-)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus


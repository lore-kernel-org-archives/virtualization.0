Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5D3B2FFE
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830499; cv=none; b=sCc/4mxlfdsef2mCJmG/l65ca1ogECXEM2uZpGTmIMIUrCCodUJZJUN7+nN27VYWfYbbymopKXJnCdRf2WPIHEKX/QANfEaL4lsw2rPjry+b89F9uM04wMRUbzUn1YssKzWJrCZ5i9azSEIxNoYy7JC32l7OrgpnS4dxdIP7GR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830499; c=relaxed/simple;
	bh=4ltpcuRttf9/xr0mubqBbCQuLlPMdkVNmsXuyfenKso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUYbwN4CxFH/b2RghdTlbegzrbDBRbB9ie2htKRCGB9LuEHDVWCDuNO6Ajl1tzfRMRsbZlZNZAfPv5zu5L2NBE41U8Vl78CnaAG4sn+Zvu7IPoTyh6h/XoBJu38uDFb+2/ZI7G+kfeAWgSga0Dz0WXqlQ8ylNdYhISQ2MXvrLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G+XTHHrx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G+XTHHrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iL
	VaxcPkj4skGi7uPuGNvRNq5L8a7XcBkn06NEpQJNI=; b=G+XTHHrxtWE97Koiyz
	wJyEWxZmnXm971yJcSzJuLXUiE9vKpXmeVKlwzU9gdiA4lH8iwqveCHpQmWWOAAV
	sj35x1BVpq6r2PAbdsMwSSxgtAvIbSbG34/dmdIRuSf+fxn97EBwL5SfvDO0ilU5
	S98hFbDXoOyqNUIPmYmnXFLCU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3+bZVnHFqQsQvLQ--.12248S3;
	Tue, 04 Aug 2026 16:01:28 +0800 (CST)
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
Subject: [PATCH 1/3] tools/virtio: add device-id compat header for virtio
Date: Tue,  4 Aug 2026 16:01:23 +0800
Message-Id: <20260804080125.79403-2-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804080125.79403-1-r4o5m6e8o@163.com>
References: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
 <20260804080125.79403-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3+bZVnHFqQsQvLQ--.12248S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyDtFyftr15ZryUurW3Jrb_yoW8Gr4xpa
	1DCryqk3y8Ga4fAa4fW3WY9ry2vwsrAw4Svry2gr1UKF9xtFyDXrs3CrnFgwsrZr4jyFW0
	yryfWF95KrykZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7AwxUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzhg0qWpxnFihbAAA3Z

From: Yufeng Wang <wangyufeng@kylinos.cn>

mod_devicetable.h was split into per-subsystem headers under
include/linux/device-id/ (commit ad428f5811bd "mod_devicetable.h: Split
into per subsystem headers"), and include/linux/virtio.h now includes
<linux/device-id/virtio.h>.

The tools/virtio compat layer has no counterpart for this new include, so
building vhost_net_test fails:

  ../../include/linux/virtio.h:10:10: fatal error: linux/device-id/virtio.h: No such file or directory
     10 | #include <linux/device-id/virtio.h>
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Add tools/virtio/linux/device-id/virtio.h, which includes the real
header, matching how the existing virtio.h compat shim reaches the
kernel's include/linux/virtio.h.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/linux/device-id/virtio.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

diff --git a/tools/virtio/linux/device-id/virtio.h b/tools/virtio/linux/device-id/virtio.h
new file mode 100644
index 000000000000..18e3338158eb
--- /dev/null
+++ b/tools/virtio/linux/device-id/virtio.h
@@ -0,0 +1 @@
+#include <../../include/linux/device-id/virtio.h>
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus


Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A342E8EA
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830505; cv=none; b=pO2SEfyvun8TbufMv+UrnkVoXLOaRkTtbJ7JY7bK/OmGXhWe17mn2jGoB7+lWLDWaAoFsSbbgCqNx3mXMU7uHg7voZ0LDkgHja2ZwNzXdc3VaFPKI1X8BEwqcYxbtOzYZ7g0amXSjbEuSwcUUdMuuRWxdNSN8ijcQ/0Ctp3KI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830505; c=relaxed/simple;
	bh=XVsZHnCudTLeRuVV1elnZGe6ET8j4KF26RMgoOqlizo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oeu+rcS5eCWKuJV/7bjU7Oo+d/P/KTrSGyY6mYgbYlEL5qOHA51KM4eYpYxI0zxe4YOzOQ2tyR5Ac9KHN3Vb9+O94C45eJZFrRUbI3EFDnW7C19ZXKYd/338FqlVaf3KPYecxWTD3v0a2z+jQxOKZ37/fR+rU0l850g6FxtxicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QBW3RmvQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QBW3RmvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=C4
	R4R9pywm2EpuaFH/SxTHSerE/d1aZMpdI1LeEfYSI=; b=QBW3RmvQAPR9nGRZk+
	2UeJ/KSH1YdHfrpcIvckFby81NLQq2a1McnBNkgYBMx4iGnvR6695XsODj675AUg
	7fGJ5csqHq0H2/d1MJn1rcP813LESBZzqFqMVlvQV4yga/EB0d/SB+x7xx8JEuKO
	VlaAvaHK0O3bmK4XvJMUWiqFs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3+bZVnHFqQsQvLQ--.12248S4;
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
Subject: [PATCH 2/3] tools/virtio: add __must_be_array stub
Date: Tue,  4 Aug 2026 16:01:24 +0800
Message-Id: <20260804080125.79403-3-r4o5m6e8o@163.com>
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
X-CM-TRANSID:PigvCgA3+bZVnHFqQsQvLQ--.12248S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1kWFWrXF4DAF4UXry7ZFb_yoW8Jw1xpF
	nrWrn8Ka18ZrnIga4fta4fur1Uuw1fAw17GF93W34UuF98Jw1IvFnFkFW3K3y3uw4vgF1I
	gryvqF1xGFZxZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URwZcUUUUU=
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbC8Bg0qWpxnFjjKQAA3g

From: Yufeng Wang <wangyufeng@kylinos.cn>

struct_size() expands to flex_array_size(), which uses __must_be_array()
to assert at build time that its argument is an array.  __must_be_array()
is defined in the kernel's include/linux/compiler.h, but the tools/virtio
compiler.h compat shim does not provide it, so any use of struct_size()
in the test harness fails to build:

  ../include/linux/overflow.h:161:44: error: implicit declaration of function '__must_be_array' [-Wimplicit-function-declaration]
    161 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
        |                                            ^~~~~~~~~~~~~~~
  vhost_net_test.c:258:32: note: in expansion of macro 'struct_size'

Stub __must_be_array() to 0, consistent with how BUILD_BUG_ON() and
__must_check are already stubbed out in this environment.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 tools/virtio/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 0f25db473f55..3fa035296fab 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -40,5 +40,6 @@
 })
 
 #define __must_check
+#define __must_be_array(a)	0
 
 #endif
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus


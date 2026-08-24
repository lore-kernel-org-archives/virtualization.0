Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF183EDE78
	for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562824; cv=none; b=Ul4QY4WdB5uxAI0XxmfnKKZpiieX64qZ4Q8JYb+pRcd+5BxEliagk6DdgkhZvkagVntyNxOK2pMJbO3by2PqCuB+sjfQzYFoklc6tuiPgBdhd+IVyyLITWYqth6++KL2NjbyglPQvJS+E2zb5nTZVOqd+FVLzG0ERR7D0Nb3mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562824; c=relaxed/simple;
	bh=+nOV6NkIgUqBKBqIy66tJwhBsmV6pwSIrq/6q0PXurs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKIjA8PmRjIyta1W9+TDPWKYVku5OEHU0/Mv29yXdy9m10EtBbyUtETWrgx1NY3WoRUC3OHmFGmipBtugbOU7eYNLskgb5gJGRyMaOwgIc1IJVf90uFgXFgXR4apCBaNC5Xi95nj9uVsdQWf8t2aCtHYIUzSS5e9poOK2GvGgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SgrloLNY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SgrloLNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xz
	6Zn8pKxyQnTNAKDy7+cGCULMrW3RLqW541vFp+R6k=; b=SgrloLNYJQXLOoFJyO
	rwRCIMTXiED56NMsB61/HstWJoVezBqx0WW3QmnKC2g4Cupy2khFuE7XazDy8etL
	wU8OE71da8l7DzoM8bN0yuc2AmBUR6xKB0ZldcPCaPg2pyk9a765XEG7TO3Tu+Nv
	+2PGHFMwDQSd9OicUVw/ZLD8o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDX7osaC4xq61QtRw--.13833S2;
	Mon, 24 Aug 2026 17:12:59 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v1] vsock: validate buffer min/max size in setsockopt
Date: Mon, 24 Aug 2026 17:12:57 +0800
Message-Id: <20260824091257.136269-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX7osaC4xq61QtRw--.13833S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4fGry8CrWrKFW8AFy8Grg_yoW8tF1kpF
	yakrWIqw4DJry2q3ZYyrn0qay5Aan5Xw4UWrWxtF97Jr1DKrZ2grW8Ar9xKrW7AFs3Ga4r
	Xr98Wr1vk3Wjq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-huG8WqMCxuyTAAA3a

From: Rongguang Wei <weirongguang@kylinos.cn>

SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
do not cross-validate against each other, allowing userspace to
set buffer_min_size > buffer_max_size.
When min > max, buffer_size is silently clamped to an incorrect
value. For example, setting min=512KB then max=128 results in
buffer_size=128 despite the user requesting much larger buffers
via SO_VM_SOCKETS_BUFFER_SIZE.

Reproduced with a test program:
setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
	   512 * 1024, sizeof(int));
setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
	   128, sizeof(int));
// User asked for 1MB but got 128 bytes silently
setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
	   1024 * 1024, sizeof(int));

After that use getsockopt to get the buffer_size = 128 and
buffer_min_size = 524288, buffer_max_size = 128.
The buffer_min_size > buffer_max_size and the kernel accepted
contradictory values without error.

Add value check to fix this issue. Return -EINVAL to userspace
when setting MAX_SIZE to a value smaller than the current MIN_SIZE
or setting MIN_SIZE to a value larger than the current MAX_SIZE.

Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 net/vmw_vsock/af_vsock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d381d..5faa30ee8745 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2050,12 +2050,20 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 
 	case SO_VM_SOCKETS_BUFFER_MAX_SIZE:
 		COPY_IN(val);
+		if (val < vsk->buffer_min_size) {
+			err = -EINVAL;
+			goto exit;
+		}
 		vsk->buffer_max_size = val;
 		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
 		break;
 
 	case SO_VM_SOCKETS_BUFFER_MIN_SIZE:
 		COPY_IN(val);
+		if (val > vsk->buffer_max_size) {
+			err = -EINVAL;
+			goto exit;
+		}
 		vsk->buffer_min_size = val;
 		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
 		break;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


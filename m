Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA836A01D
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997137; cv=none; b=L7SWUstIjcovQXgDLVhcrmFXg/qATVmR3JqKVovnSJTm71bMDxy/YP7h7cVi2YAY1H18MKo2VvR8uo391Cradm6nofo5A9BxLi35qXh5o/M24TJQWgfCvAMunPOPgwNJI519GkM92rRAzHuXezp9TAwsdy5aK8a8lxNvD6OTkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997137; c=relaxed/simple;
	bh=d4VbmbbaOI/gSPSawqZ2IBhJhYvI/XKykeJyrxsulTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irwPdbI76rPGjhnaij/xVx62vhdAExyjf+giSstuxji53Osod+e8UjgytZuXYXcEIGx2hzzJwMECE1cs02JHfP4XlcuSd/ejqfDVfu1xuWmPSOp602yFQgAViRNa3+800DLG10hX/+PUmA+UmEk94JrFfkbO1BN7moYjclveX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ur2jik1h; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ur2jik1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=73
	kxuBBnS5Osz3EKHjDUAF1+djAyyrDvjsvXYmU+ohI=; b=Ur2jik1hzZZGiCfX5a
	h4T40aUn23a+/bWYAXPOsJgNJ/Jful6KSHfZI6rzzdTCAmHNDzY0d/4M3xveL+Ao
	L67+FlXF7+sLYUPx7AWGtzdKNqqHAm3wjQ5XOWMR31TKgak4HBXMsbsCm4F0giME
	m8XgLiORQu/LQacXtEBjg3X2E=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA3hhvHolVqRSmvHA--.58087S2;
	Tue, 14 Jul 2026 10:45:27 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: virtualization@lists.linux.dev
Cc: alvaro.karsz@solid-run.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa/solidrun: fix typos in snet_ctrl comments
Date: Tue, 14 Jul 2026 10:45:27 +0800
Message-ID: <20260714024527.188645-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA3hhvHolVqRSmvHA--.58087S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryDCFWDuw1fZr4UKF1kGrg_yoW8GF47p3
	s5Ka4UKryUZa42yFsrtw4fWFy5u3Z7Jr45CF9rKw13Zr45ur95Wry5Ka4rJ3WqkFs3tw1I
	934j9w1xC3WqgrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwl19UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0gfJUmpVoseR0QAA3U

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "readind" and "the an error" in the DPU control path comments.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/solidrun/snet_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index 3cef2571d..e284c3a06 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -124,10 +124,10 @@ static int snet_wait_for_dpu_completion(struct snet_ctrl_regs __iomem *ctrl_regs
  *     reading the in_process and error bits in the control register.
  * (2) Write the request opcode and the VQ idx in the opcode register
  *     and write the buffer size in the control register.
- * (3) Start readind chunks of data, chunk_ready bit indicates that a
+ * (3) Start reading chunks of data, chunk_ready bit indicates that a
  *     data chunk is available, we signal that we read the data by clearing the bit.
  * (4) Detect that the transfer is completed when the in_process bit
- *     in the control register is cleared or when the an error appears.
+ *     in the control register is cleared or when an error appears.
  */
 static int snet_ctrl_read_from_dpu(struct snet *snet, u16 opcode, u16 vq_idx, void *buffer,
 				   u32 buf_size)
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus


Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B347F3AC
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236220; cv=none; b=NUAy/gT5s5voTIPzzWWD2uxpoOSritq8fgTQ8oHRKwFLfo74rT4L+PJPKf4AMyDeNf6hUW5hkKx32dGQcWgNaf+Mb9EQnir2pKDJ8R2KNaPiBO4+hZ5CstuvhrdyLSnIeUKpqk9CH5T23iWCbC06lgT4Li3k6vbCynJG1qLGUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236220; c=relaxed/simple;
	bh=Lm6DznaiO0RY4Yyx31Xrxi52JEZFpmQE0Pv27A94B2o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qJJEmXiwlzAAMCdS3Uv7BGwU38MysiQvH6uyZcNhLyzriIh+M7NwGCGLOPOy8TplzQt6seLdfDqlFEctUgKDqf8R4LG/x9ay+/LaUxySRHMTtTqCEWcGt0BRFDShv/wl5TD07sIAP5889o2ltpzaPqyj4xTzlV8XPTWk1pojByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iSiyC5df; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iSiyC5df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789236208; bh=vomO+3jeJyZXKN3tJwW/9OYIvoPjrn6hdESX7g154m8=;
	h=From:To:Cc:Subject:Date;
	b=iSiyC5dfRYcOIdXkZwgKW91lHXWOVb9mkRQTByNf0RBPNdjnzijs/jb4qZNji49mi
	 Tb6BJeHB8R2FeYE3oGhwUjtEeDTciqrmskFeJFK41meDDaEWu5pQMyEIJoWC8K/C8K
	 ibzx5TMSZbw3sQwul0wyjfzMTT+6wzjpO0QzDd5U=
Received: from localhost.localdomain ([223.212.4.66])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id DAB76FB; Sun, 13 Sep 2026 02:03:26 +0800
X-QQ-mid: xmsmtpt1789236206tifuyklpe
Message-ID: <tencent_031B923A83E0DEE884BD05D49030890C0406@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLuNAnsyIc64WeowhM1D7pNgX8wy5BTQMBcS0Nwz+49/ghY6wHta
	 DDqE2lRb5o9P7rZNJENICUd3DiGTaVECIyvZ/3P43m0stDQprS9M5ZbzCy2atCV+49745dqMG9ia
	 Ghloa91+EM2Ivx1FgOszdb2AewHq5jtP7zT511WeHcwpKlgTAuAQczK7+Yma/lASkNODQwrwknqR
	 rMMT/zb6rMzipQpHwgrZQx1tisTv9cHUu/LCcExa7PAUhiIU8/AEiziO6+Yb9KDjOvgnufpcg2sx
	 xGpzK+vsZnWRwcC9RoZiQbsaH4n0+wjM7W7nahwluz83gn17VvJnjWQ0AoRfG7kcN90Uw43OgmsF
	 AyZh9ynAvxKrytJJZ5cttn3Ro31i/79SpxJqwPlc+kaHrTHqvujPJLW5xTuYln4VT2TXFoQnAoFa
	 957+weY1Zv97cFpTapGdal+DT7Iej3z2pSLIQ+rH0rTONPtnZ9Q6EyiwZaqzc75+7IeZjB67lqZm
	 Ymor/cBQIk11lnJ17gapokRf+KIM9oAA4oMEVtNIxEJPyNsm+U8QbuFftDvmwPd1ytRT6osD18aH
	 XtOl6Zyp0ehZ5EjjP+vsh2SfpoUVfR2rFuxLeWh+o8gmZ61Ap4HIIDTyDFoJ788j6kimARc2xBq5
	 c8OPI1oBjD0zeuTlB4QKto9BE6qXIe0Uh3lz13dePAbB+JlWiM2LgIaylvZg53GndIAEkFDfkt9j
	 An7VDdXLJiG9DJxZngU+ttvB1mFCCV4IMuFGSxCLWcbinD2I9ZUm6a19PtmSLZLfkhZCjgM2jcQQ
	 wEsJqfMr3gm8DVtVBjP0F9aOxT61xArD6r5y55SChQ/X410OJfj5CPzL0isHyGzsQIeC+O6oOuFT
	 m5JhOn5W5jJtw1o7PSO5Q0e4u21EVEqm+m8aFrEB6Lg2F8w46DAETJxu39T+l/QJdcKPRkBMi20a
	 6XnISSap0CNwpHWcfGH4qthGJmArUfwt+yF7WBdSX45aYO82USrgsg+dbtifCiKKjYM1eBRSMppJ
	 2Xi7b01rjdDtZq1dq2QSk2re5Poo40hz6I4prCjVx/Gjpzsy1UZAFqQIpwYk1C6+BVT0MDTKBP/6
	 WR5+W+eCy0EF5khsod7nFlMypOPMrZdNfVSx9Q9YSCfXN2pMQ=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Maoxia <2312891301@qq.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Stevens <stevensd@chromium.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_pci: add missing newline to the pmcsr error message
Date: Sun, 13 Sep 2026 02:03:21 +0800
X-OQ-MSGID: <20260912180321.210091-1-2312891301@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error message emitted when the PCI power management control
register cannot be read is not newline-terminated, so the next kernel
message is appended to it on the same line.

Add the missing '\n'.

Fixes: dff4fa0e5785 ("virtio: Add support for no-reset virtio PCI PM")
Signed-off-by: Maoxia <2312891301@qq.com>
---
 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b90c174450b2..24af84b0c6ad 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -633,7 +633,7 @@ static bool vp_supports_pm_no_reset(struct device *dev)
 
 	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		dev_err(dev, "Unable to query pmcsr");
+		dev_err(dev, "Unable to query pmcsr\n");
 		return false;
 	}
 
-- 
2.43.0


Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AE40B6FC
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120177; cv=none; b=bO4A1BIaJkwBqksYOGPovKheEyP35uixiChjaPAeI4JMnEsvabynS3H8Pj4XjtTJ8nk8uCN7nmf0DA7MOHc1nJLTEng3H25hHsqvP7WmM7PI5CWq1a8r4yd51MWsNhR9ec60uRejJxskFabnGghIfZpkc/aaizzX/+wgRA9tTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120177; c=relaxed/simple;
	bh=Jc1KCw4PS7kSTbxiHStSFaR3kFALt652H8w/cv7GtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bR6I7ikezNuXXSglsav1vXjyDLKgYZxIx1aAcDA3JlF7V9+FOR+p5gvgfhU89CXJtFo9Fk27WPtb7nDrISXiGJ15i3+1MHjCTrwWdRLkE3JVjI/DQc1VliavhcDv2RM1+8gIpr2i57NvGoPKw7XUhLsNvNhIVFdgcl0T9Wm3dPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=pifSszUl; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pifSszUl"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 96BE4C51A6
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 18:31:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ba7:0:640:dccd:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9729980D13;
	Thu, 26 Feb 2026 18:31:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8Vkqhh1GMGk0-wRfDlrsE;
	Thu, 26 Feb 2026 18:31:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1772119888; bh=9u+hw7P1kZrxGYw4H4TMvbi/ck0cvcuM+YKL6lqFTQo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=pifSszUlb2N/rZIVP+qPjlC1mTVLnGQ+aRmMCUd0EMVWv+lDjZEr8EPNi6shDDHhn
	 AVTXYtpAvv1hL7QnGdCeD62wWo9sPP9ztWQFT2kYkBa5nUH7tWc/THp1QataVcsfs+
	 BBuIH0Csbof6gtSyHXiCymRbThXXJaK7riUut3FY=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	lingshan.zhu@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
Date: Thu, 26 Feb 2026 18:29:23 +0300
Message-ID: <20260226152924.38790-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_set_name() may fail and return an error, but its return value
is currently ignored and overwritten by _vdpa_register_device().

Abort device creation if dev_set_name() fails and release the
device reference to avoid continuing with an improperly initialized
struct device.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index d46c1606c97a..ab6d6ab3b3d8 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -734,15 +734,22 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		ret = dev_set_name(&vdpa_dev->dev, "%s", name);
 	else
 		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
+	if (ret) {
+		IFCVF_ERR(pdev, "Failed to set device name");
+		goto err;
+	}
 
 	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
 	if (ret) {
-		put_device(&adapter->vdpa.dev);
 		IFCVF_ERR(pdev, "Failed to register to vDPA bus");
-		return ret;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	put_device(&adapter->vdpa.dev);
+	return ret;
 }
 
 static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.43.0


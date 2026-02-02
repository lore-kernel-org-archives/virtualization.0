Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C028B4FD
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017239; cv=none; b=e4sgwRwYf0od9uikS9wZkb9AXVS5yXSpOwt6tXaIvjG1jp7IoZjjvRbXMLCM5vUeiqG0VGinjGrEcgmdzcDP3A+AYCCl7g12a0Au72IcqNRDdXFEX5uyG7trWMnZ2gTi5Wl92igm1fI34q0zkcBZu3t2UYU3X2lvRhs+Bmj+zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017239; c=relaxed/simple;
	bh=uBDI6vCLVayNa9JEpUxQbP6AJj9VHRh0JPtcRkORuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/w/7cNgE6U026TAPkLm1iJSmqdiXRl4bUKvZTlBYd1+1+wbwGywjxovdlmMLXLUxxlRwe0NGck6qWd+BHsOrzowFhQ4ceQCUFBFsWllZpxqezqAE90Ybf5fEZipczcJ34f8tDu+c+3zNBiQKy2ccC2zwI0Lwm6oUMKNVKsNxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DE3YDajf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DE3YDajf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823081bb15fso2113565b3a.3
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 23:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770017237; x=1770622037; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M73OcDWXDbjnvZuhTobLpl4M5OeahGpDzSfF/B7/1g=;
        b=DE3YDajfA2EZJ2paRWkS4tZgcb/ZCAYV1UCwSR6mRwU57CTlV/8JOygumQOkUu296q
         vQb3FWN3GXSup4wEVEZg9OpExubeQZci2LuKkqAeSrACWDx7WHusQSXDis7wCXEJW9FR
         +0aX+5CLWSUg+b8oNkYQtyiFy2QaEF/HZs1UScWGepe4+wgXNaG1YnBvS0qdf8UXoDEu
         TiTH+s0U/tWQlTiLmQL83YPf2voZ1iDGIVPCH4Fxs0E1mbP5NWbgY7k6gbCUIYGB8uDr
         +qEu3hK4km21aHXtvCqFe5ob96OWUmMYADFePu8NiXBSAlEUODj8qiCbZnNoZG7lcPio
         nYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770017237; x=1770622037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0M73OcDWXDbjnvZuhTobLpl4M5OeahGpDzSfF/B7/1g=;
        b=nwPNWfZvyK+/UHafU9Nv25sLxvCsanX90F/aFPatUIfBgZJfufJ6r4k2U/CCan/Ty2
         DpfXHx0JvDdIJtzga1sNImUsyNiAtC3TkZ6kmWF2loW5FZEC3rHUaPvDSfhNtNWOM2ZS
         mGqtU2ctsWBODe1kj6ZH4BdnYiaTyoC6RCvh58sr+5xly7mJqj3EJe6OxcxND5hjNPTK
         bVR5ty56F52Msh1GTZ0gigjyqAhYDn8lZ8KYXKdGWqSBBKpxVr6MhRJGcSkLb2858BwS
         UE/K2fZfQ7ySLLLpXpEujS30CC1BA0h6KhbRKbutOnRNoLMUNZx/JTpwBaPFwnA7BE5a
         MEtA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FZMgkAVkGYDZTtSXjGY4BkGiMVan3INXLaPPHxTWLTxOBJ6wLgT5hjjFH4IG3keudWPz0tNE+H83I3L3bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8ptEDsxioR3LzDdiJxhrcxDMEpQoDieimAHcd5sH9unb0lW6M
	/BomImuK59d84V6OBGv4793s6gOoEjCE578iPvPpeiCR/pKAQTfe2gswP/dofgfekMk=
X-Gm-Gg: AZuq6aL+Uo2o9ThYdI27l4PDA1B5eHoby62MPFrmcWtana196TZV16IS7l2NCwitG4x
	3edp6ngQq3xR67zzM2VlxOJ7jV+ZqBB2RYaawfPd2z178yf3WrWZG6XVJC2nWRor2f0v8a/HD3n
	63QQ8w9XBbp+4/hWa6w9KSCKukgTKtfBrU2qzR5dQmX1uiEBMsn67Ir3f04DXRh+P+DogNdiLCN
	og+ph6wF09FY7JACw5qnDDpinJJFWIsSHTGAVkkKpiWKRTiA07R32X3sEtzG92C03VD4TaAoSuE
	FOc7ywYAjLWu4ul9hb06IKZfBLOVbJW2sgQ1ZfsWJbJ6OW8Y+OjX4rsQU73vUkhyfVANs+ElnYW
	eTgXcZOdnzss4HRkYVVScMiISEjWpS15Qpi1B8oXwYTj6toZGPG1RvcwUNbxAA148tDeCUc5aTl
	5yWTHFEEYPVcnqzltqS8upl59CaJYfmE66RvEfityeApPjw/78i4L/UaSG
X-Received: by 2002:a05:6a20:3d88:b0:38d:fc80:3e22 with SMTP id adf61e73a8af0-392dfff8f86mr10526845637.4.1770017237208;
        Sun, 01 Feb 2026 23:27:17 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d88f0sm145352365ad.67.2026.02.01.23.27.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 23:27:16 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	marco.crivellari@suse.com,
	anders.roxell@linaro.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v3 1/2] vduse: Requeue failed read to send_list head
Date: Mon,  2 Feb 2026 15:26:54 +0800
Message-ID: <20260202072655.95143-2-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
References: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When copy_to_iter() fails in vduse_dev_read_iter(), put the message back
at the head of send_list to preserve FIFO ordering and retry the oldest
pending request first.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ae357d014564c..b37f18a0ce6fd 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -194,6 +194,12 @@ static void vduse_enqueue_msg(struct list_head *head,
 	list_add_tail(&msg->list, head);
 }
 
+static void vduse_enqueue_msg_head(struct list_head *head,
+				   struct vduse_dev_msg *msg)
+{
+	list_add(&msg->list, head);
+}
+
 static void vduse_dev_broken(struct vduse_dev *dev)
 {
 	struct vduse_dev_msg *msg, *tmp;
@@ -354,7 +360,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	spin_lock(&dev->msg_lock);
 	if (ret != size) {
 		ret = -EFAULT;
-		vduse_enqueue_msg(&dev->send_list, msg);
+		vduse_enqueue_msg_head(&dev->send_list, msg);
 		goto unlock;
 	}
 	vduse_enqueue_msg(&dev->recv_list, msg);
-- 
2.39.5


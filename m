Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA46275861
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867803; cv=none; b=IQlaailpS6Q8duPh8qkcl398Wo/DCKchHC7Y24eCiOirS3uNathAdvlJQ3eLlKHm+mOxAitiM4t5rxabGg87sjfQTAizWUGW0eFDEW4cIC+YBS5QEJdZeIgMkxUkYjnG9bjM3hGZ7qAimjceMU317l2sVHP+PUmNEUmTO2aTvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867803; c=relaxed/simple;
	bh=5dgm8QJmb1y3lQDQkDPV0FaZsW33rfPUVwIw+yQAhQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS47DSm7eQdm1Yby6a6uCbKCmaR7UGPmrQ9osMPaFkfU9NurA2J3F1YX6vOs6HBJ3XDXZJuk0kMkavVDCD1dDy2pbdaETtWUoRksmBWE0w9sJq/b/l0zLcB+wGmLbOOSBIjlNFMmhpbUy6OWmK3hidRIsK6GKSh04Hd6pQ0vK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kM+sI2zr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kM+sI2zr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-240763b322fso17753445ad.0
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867801; x=1754472601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu+M0/uIPWDSjTwSlyDMCHQ4E58hfAmwYKc2WXq227M=;
        b=kM+sI2zrn/HcaVQVsgNiXgJXTgBHkyG3gVW1q4pT0TYDYerDlBkOV1CfJWQYierrGm
         XnzUGhQx+pm5BUebOf0qqhbP6mTpooKOuZe4qthkQjotEMhbCpFP/XVGtxDlg0SCKxxK
         GTzLBWv2PDH5vHr+kGZEz2Xefti+djc2gaxtjAZC/xOAWUxxAIoyzbsflz7WxO/5fx+0
         kNlpoY0RuOnidHvjpGEsDXXpLAjdGnCMz54V8DKVgOroJhlyKQMId/qly8f8j6YLIAvE
         eGI+qEzpz/xh/oS1Gkea5KkINZW+RftQWF70fDIv87yCq32+PeArJhxveSSt4cMz6xpk
         LF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867801; x=1754472601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu+M0/uIPWDSjTwSlyDMCHQ4E58hfAmwYKc2WXq227M=;
        b=X5cx8WEJfyaHnH3Jvg2VEiu3nijMr937rR4FRxW3hiOXxJYKaKk9dPBiugg+NlASed
         hzz5TSQVrvgqSy9suxuEKdD2SZLiKcPM1nxgfbIJRHA7m2JBmc7Qnn/CGBj6rC8A+Fuu
         3hbApvwjGxwhXADdYbfdbIIDJR4irJDy1TjQ5y40c7Pbxr1w4g8NLsXrtxQds59wMKJ+
         ibVr3vHuCVbNm+iDC5qMZXb+C293ip0X5j+8gSknL/AKA+elbnxFMtu14bK2pBOu/F78
         7O712XH6uDl5puR79YpG0tQdaquaY06gTUnMaNzOu51wg5h7uF9JSCPNOMh2G30YXx8e
         RNHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmBWdfR5KtKiGNsh/WNu4UiZMSxbV04W6doObUduTbgGq5x2df9S4i2G+wf2/MUpftMY0wHWpJkqcpExZB6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWD0lfJ1w81gzsems+ZeX4uE/3I1L2NnVrKKncaGE1BjuD31CJ
	+QOXYWzdqVOV6UNySzZVSJ6+5qfY5NfEeQpD/bB6arwI+igxgKsRU4dc1qi3zt5ajPI=
X-Gm-Gg: ASbGncsP8QzMWLSIQq/fMMuj2S04RJnRoUi5KnZYiySn+x2wUwgjxynl8A/Nk/zCBe0
	Bn3dsF4hbIMnXEEj4RZuYz7jG530je2xCgJhYtrtx1PbH8RHS9/HzR0khSnIlmlAnzv6ft094aC
	EH5IuRhuvRJmpNPOQ33F59G1rlmPGFC4eCHSdQNO6YIXZAQxUpUvNnl7EQ70PD2DoGCsFq6yQG/
	mLiZ69fQ2YOpgtVEYVU+EEds+WpbJdDNVZunhV4aKnFc1hAZxrz3wwzenXUkRQzYqSEZME3E0he
	Pjlxsxv+022tgufwdiJhR6V1mB3fTYZt1zjum1K016vnw/SsEqV7fRmrUPEJKbv3glrIQWedz7w
	gXBsEtf85U2AZKBQNph5vBME=
X-Google-Smtp-Source: AGHT+IEaqMhp9wt/vc4KBbRw+vOpiZc3CbcTUS+/uPYT7mnw3RyDbEwb+0HDQqI/sNr/Say0lfIuDQ==
X-Received: by 2002:a17:903:4b08:b0:240:3dea:b269 with SMTP id d9443c01a7336-24096b658a9mr39237495ad.48.1753867801249;
        Wed, 30 Jul 2025 02:30:01 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24009e53876sm74902245ad.2.2025.07.30.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  1/6] of: reserved-memory: Add reserved_mem_device_init()
Date: Wed, 30 Jul 2025 14:59:30 +0530
Message-Id: <88dbf7486b820bd713598f20efd51e327b9ff755.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds reserved_mem_device_init() helper to attach the specified
reserved-memory region to the device.

This is required to attach a reserved-memory region with a non-DT
device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/of_reserved_mem.c    | 64 ++++++++++++++++++++-------------
 include/linux/of_reserved_mem.h |  7 ++++
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..e0a86c3fa656 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -606,6 +606,45 @@ struct rmem_assigned_device {
 static LIST_HEAD(of_rmem_assigned_device_list);
 static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 
+/**
+ * reserved_mem_device_init() - assign reserved memory region to given device
+ * @dev:	Pointer to the device to configure
+ * @rmem:	Pointer to the reserved memory region
+ *
+ * This function assigns the @rmem reserved memory region to the @dev device.
+ *
+ * Returns error code or zero on success.
+ */
+int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem)
+{
+	struct rmem_assigned_device *rd;
+	int ret;
+
+	if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
+		return -EINVAL;
+
+	rd = kmalloc(sizeof(*rd), GFP_KERNEL);
+	if (!rd)
+		return -ENOMEM;
+
+	ret = rmem->ops->device_init(rmem, dev);
+	if (ret == 0) {
+		rd->dev = dev;
+		rd->rmem = rmem;
+
+		mutex_lock(&of_rmem_assigned_device_mutex);
+		list_add(&rd->list, &of_rmem_assigned_device_list);
+		mutex_unlock(&of_rmem_assigned_device_mutex);
+
+		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
+	} else {
+		kfree(rd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reserved_mem_device_init);
+
 /**
  * of_reserved_mem_device_init_by_idx() - assign reserved memory region to
  *					  given device
@@ -624,10 +663,8 @@ static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx)
 {
-	struct rmem_assigned_device *rd;
 	struct device_node *target;
 	struct reserved_mem *rmem;
-	int ret;
 
 	if (!np || !dev)
 		return -EINVAL;
@@ -644,28 +681,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
-	if (!rmem || !rmem->ops || !rmem->ops->device_init)
-		return -EINVAL;
-
-	rd = kmalloc(sizeof(struct rmem_assigned_device), GFP_KERNEL);
-	if (!rd)
-		return -ENOMEM;
-
-	ret = rmem->ops->device_init(rmem, dev);
-	if (ret == 0) {
-		rd->dev = dev;
-		rd->rmem = rmem;
-
-		mutex_lock(&of_rmem_assigned_device_mutex);
-		list_add(&rd->list, &of_rmem_assigned_device_list);
-		mutex_unlock(&of_rmem_assigned_device_mutex);
-
-		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
-	} else {
-		kfree(rd);
-	}
-
-	return ret;
+	return reserved_mem_device_init(dev, rmem);
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_idx);
 
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index f573423359f4..3933f1d39e9a 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -37,6 +37,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
+int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem);
 void of_reserved_mem_device_release(struct device *dev);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
@@ -64,6 +65,12 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 	return -ENOSYS;
 }
 
+static inline int reserved_mem_device_init(struct device *dev,
+					   struct reserved_mem *rmem)
+{
+	return -ENOSYS;
+}
+
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
-- 
2.31.1.272.g89b43f80a514


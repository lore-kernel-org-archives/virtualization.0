Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C526C383
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867808; cv=none; b=XfhWTO6WQmQMNIHo0dFarHirR+bubVYp9+uIwL5o2KKwPlM2p4wAeJ9sqIGMT2UtxVSFE7xSFdNHO7UaAnBzpb0+gfeaqInZsmIRb+78z8qupu1m91MzllnqyUijgQTYhMGtYV06SYJZYrqik8BdhUPD1khae/pZXrxMcbUzwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867808; c=relaxed/simple;
	bh=AMFrLsSdDLsWD6Yxv/Xp7y8nsNQ2tGUP+On1wCM+8Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrrdJ/GpUIFqSGOUhbc1xApn/RqDdChzCzeQPMi7uRGzkyGR2fK/kD/lRGAbU24y4Zn6BZsnth9IqEFOOZrlUZr5SGV4X7l0EYnffNdE/pimLOux54EV0abWTW23PZ8O1KwMAadjLao/+IP6rgMTUNX2JpYjEfB76QfKF/HOrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rm/G+bKC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm/G+bKC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e378ba4fso8398518b3a.1
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867805; x=1754472605; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4sv190EzN/L51InyJ6GGaDg9k7LvZRYe9Fp2o+cKoI=;
        b=Rm/G+bKCOU6dpDb3tq8okhQHt/W35wNz9QplI0KWGPRywTPYZAED8UmQEVKyxm5aWX
         MxoUH745ng4WsYTivdlDrJVuXnUsgsfx7m5j0zEwMoXqsy3TUHGqRiRwGhDwYhNAABqo
         OyZfVvCU9FjWH1ac3/dh506qaT7T+Kcm0UOKGGUXJrhNOHujlqUBaTdzUnhQ4lpGHyBO
         dnGJOo7rq/s65GMI/CzwdxNCVxP7c1b5Yh4BBApCCoQshO2k5x+UXDI44fjuM0+XtLVh
         hzhc+3RFHdJHSiLKsxjkpqkGgDpCWRtB4VLY58g4eHn4FuTPEahwOjuVnszu453p2qnr
         2V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867805; x=1754472605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4sv190EzN/L51InyJ6GGaDg9k7LvZRYe9Fp2o+cKoI=;
        b=GIxkwQrXHjwdJToMHWa2Sj60AR7yTg6xQqJakzBn/j7Ye7ZlPpQvKtjpWFBtVatlGc
         FlxvRnR1g/NG2VB6MwaervI02IwW4MJ8Xhnjzk44vVUBfg5istZUlr1NDPRb8L2cbzoR
         FKv6wHbXZXTMNhWdhAuuoK5ARND9mfh7VAEWRWkfFneIAYSX81QiBz05QL7KJ5TiB4ov
         m5Ytii/uDkyvRgWYnxgBper157f2ThBoyyjsmWun5HP3gH6+9xmBDoUBPm+TncMhUpYI
         Unqxte7lYQu+TAeHyded9lTAumgVD2ivX3Gt/bHq/SaXWDPG3q9ULFzbhbVizNfKoKHV
         i8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVF+Qbnhyltavf5que2Uu6YwP2GnyhzYDt+MbFmvdtqfNkte0a0yj0mkFIcS7i/rkG8K0xQATR30OGNuPcS9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyjc0KrQc5lQQ1TE9tumgghfb2QwV7rbBDQO+XvF51gTtIrI3T
	Hq6rE6GenLu2hiEq9JKR9entPSRkVDTaEQn36fWWAUbHCEAkfSMdjNmXNOYhTAHQHwc=
X-Gm-Gg: ASbGncvyhXlSSMf0XFvT9IttIRq1LaJuIUyVbcXRciyovOMdq+Hu1c0PXIba6aQ30Gg
	DNjeepqZ40OjmGwPxKQlVY1zqfbr+Hodkv0Nv8+y11hdIFsolc5pSF8xOeGmBwuXUMk/cODUI8s
	5K5aTNf8vHBxsTgAG1LTG+BtDFEpPNDCENQH3aG57NBmGPOjsnmX0yeyllV/BQq+EvHYekaGfne
	QezmLy5lY2Hv5quZvEkKFp2sn8FBl7effIQlohN9GCbZytK5r4K6U0sT3JAoa72QioCUzjr43SI
	6KvF8jpYH9RJGFPYU0E7U+exl+XLRYHJkOUzxItM6G9j3hEhonVi0aYQdo2ClUZ3vO8EB9jnsdm
	73YErU2fAEPVIZkbSPHOHu/Y=
X-Google-Smtp-Source: AGHT+IHFAGP1HJe5a9qKM+/ZDWC7kbnIisWwtDj1bGJ4lHuGMD0cLNRjCqCmnmGMtsYPaHtgs9ZyQw==
X-Received: by 2002:a05:6a00:ad6:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-76ab2b55c8dmr4076130b3a.11.1753867804853;
        Wed, 30 Jul 2025 02:30:04 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-769b53591f9sm3880810b3a.35.2025.07.30.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:04 -0700 (PDT)
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
Subject: [RFC PATCH  2/6] of: reserved-memory: Add of_reserved_mem_lookup_by_name
Date: Wed, 30 Jul 2025 14:59:31 +0530
Message-Id: <feb4591cc48c70f9790c3f4d37c149fc336c3110.1753865268.git.viresh.kumar@linaro.org>
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

This adds of_reserved_mem_lookup_by_name() helper to get a
reserved-memory region based on the DT node name.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/of_reserved_mem.c    | 27 +++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e0a86c3fa656..b94c3b1d14b6 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -758,6 +758,33 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+/**
+ * of_reserved_mem_lookup_by_name() - acquire reserved_mem from node name
+ * @name:	node name
+ *
+ * This function allows drivers to acquire a reference to the reserved_mem
+ * struct based on a reserved-memory node name.
+ *
+ * Returns a reserved_mem reference, or NULL on error.
+ */
+struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name)
+{
+	struct device_node *np __free(device_node) =
+		of_find_node_by_path("/reserved-memory");
+	struct device_node *child __free(device_node) = NULL;
+
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	for_each_child_of_node(np, child) {
+		if (of_node_name_eq(child, name))
+			return of_reserved_mem_lookup(child);
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(of_reserved_mem_lookup_by_name);
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 3933f1d39e9a..d6d187597b7f 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -41,6 +41,7 @@ int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem);
 void of_reserved_mem_device_release(struct device *dev);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
+struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name);
 int of_reserved_mem_region_to_resource(const struct device_node *np,
 				       unsigned int idx, struct resource *res);
 int of_reserved_mem_region_to_resource_byname(const struct device_node *np,
@@ -78,6 +79,11 @@ static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np
 	return NULL;
 }
 
+static inline struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name)
+{
+	return NULL;
+}
+
 static inline int of_reserved_mem_region_to_resource(const struct device_node *np,
 						     unsigned int idx,
 						     struct resource *res)
-- 
2.31.1.272.g89b43f80a514


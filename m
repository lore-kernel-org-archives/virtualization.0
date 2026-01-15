Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECA2517B9
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444982; cv=none; b=munDvDnWF/fPbJUSJ51cTrGQHx/LClcQ63L+sHEF+iC0pRAbsiPn9K4Id0vhBcTlhAkhZ1bSZU3j73Am0pl34I/8QKrLVWBe3YRQzMyDqFRzXBQc3w8+tdYXwODw038AM9Z1cG37mU1uv/6rPN7qGWBBfloLHr/1CPFW/hxpQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444982; c=relaxed/simple;
	bh=fDcOEzdBe5xRENpKlXhSuHOhCSlbP++yhs6h6KsFKQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfd+fFkuCVop8L9AEFcnbuH5hIxItLU4GqH3iSW+AziX8wroXZu2dA9WbJVn3cHEV3nUFMfT5b6eyXVpoSYEC+GK7XvcqSxzhVv28kqyMvM3Xu+JRGCtLSkHgtQG7cZc0xyH7AS6P6nPazFGInjPpMcAeJ8pzJBtFJ4GdyButJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CtW8vpQ/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CtW8vpQ/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c655e0ee70so32467285a.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768444980; x=1769049780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcW/hY6JWQg4aPWEmrNXUmJDtQucQInwfAPavQZW27U=;
        b=CtW8vpQ/6PTYJfu0rCGPuakez84OF3jyjpbaN9iOyv/RapC1r8+eW1lR6yGLgpjUvs
         UIdpHRvEVQ1V/zBebqPuK/pCD5KTEmd46gkhnKgzcRsY6NyCUaVR74RaqkdUeC5WkyCR
         pXbQvejeelMWPZrTTKdqeVIcXw0147AShxNqf58vQ1R77aK8Qk3XMUkAobQVTpaMP1Cg
         OMkRG54jYiwppCNvlKuHpDrTGm3rwjnn92XQ3Th7omm1jZw2TDw/AkJaLV8thE9j8NBs
         MGEOxchXHkVBsNkSFwru9orWIme3BaFk9OYfraELb0eGg6UbKzzdCPd5OIXg/syoZIEW
         ANsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768444980; x=1769049780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcW/hY6JWQg4aPWEmrNXUmJDtQucQInwfAPavQZW27U=;
        b=vgacsI6sViD4o1jFxvIEv9VD/p/+n4vIEvfI2MTpu1QFWkXDy2ywf3rpMmglLXoxUp
         Jjak5AspNViViC+ESJ02IXqXVoJKPepO2DJhu9RuNEhqqIZr5b2Rdrhri/Selwyl9G5m
         51wBhHriBsjAjkZaETJe+Uk4CKNuYng8XDuW1EicjOj8FtldDbPBr0u/dRirNjqWvcZm
         iJmSIWvr/Ad5Ee5TRUY/vaAagthMWzi1MOire3PAzbeIMuMmRP9fcQYRIiZ4IkSdRQkQ
         z0TdiyF/29lNX3g94PiD4ia1P+0Z7DkloOOdOSRxiepa1KWAUjwtvyRhepNleovQ3PrU
         EMow==
X-Forwarded-Encrypted: i=1; AJvYcCV7M5ysWGtLCyCD6pQXDw5rKcNq5y2T3qkbe2y/rG0DuCBjgSN6hpUpf1nm769RKoCB6iNQEpYCBmLE+WqJYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJpk3FHlHyCssCxzG7gzwRMuvPGhyypuMWe1orJxcBUeAdXrWK
	xxts+ITG4jJTWQT3GqXEs6I+dY8IXFY9Dq/Rve+UYFFXcSLxlt6GcLHrQt6Y8W0ca8w=
X-Gm-Gg: AY/fxX7NplBh8OyCAb+dwhzhQt7HC2fv58K/ax04+vr8EMfaZvE3kzLSjTpy7/Vylac
	8+QoOB5nm0mI0Sb1UGmE40ggz8J0Svss9acBLWBj5i6qy9icTwGyFq5tfqvY5kjQVhwyGC31gSs
	Rgqyxeo8oUugqqU1QUHb9NaAQA4ixhQg0m09tvnLa0tgufLcP8B3C8OsP1YK4unQ1aeKIpj4ORR
	9ngtUT5rW3QRYuF/ZbgOmwsn1JcyFeSaeXuyM29sycUacTRdZ4A/40EGUyNC2w1+tBB8LIBKpyA
	9AwslZlIGp1I3gY1Xre8I+vrl4JRVE7vLcUZPAo16qAOh+NO0LXlseTI2zw1ySSJr+UAQ7EuFcb
	Wg2llxwzQeJuV0dXRMnAeI5SmmE4ANYjmzI0nnIS361bUlZiFI4jtx1rvtlGm2xZ9oP4Fe3GPn7
	d5fy8w57IwgiK+EVecETKiZgOMVDj+j25XNzWK5q8nc7zxqN3nCH+bGYURdPYgCxyYIB31cVkTQ
	Ow=
X-Received: by 2002:a05:622a:1f11:b0:4ee:4a3a:bd05 with SMTP id d75a77b69052e-5014849d291mr69984841cf.74.1768444979611;
        Wed, 14 Jan 2026 18:42:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ee050esm26853761cf.30.2026.01.14.18.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:42:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH] dax/kmem: add build config for protected dax memory blocks
Date: Wed, 14 Jan 2026 21:42:22 -0500
Message-ID: <20260115024222.3486455-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-6-gourry@gourry.net>
References: <20260114235022.3437787-6-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this protection may break userspace tools, it should
be an opt-in until those tools have time to update to the
new daxN.M/hotplug interface instead of memory blocks.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/Kconfig | 18 ++++++++++++++++++
 drivers/dax/kmem.c  | 29 ++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..cc13c22eb8f8 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,22 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_KMEM_PROTECTED
+	bool "Protect DAX_KMEM memory blocks being changed"
+	depends on DEV_DAX_KMEM
+	default n
+	help
+	  Prevents actions from outside the KMEM DAX driver from changing
+	  DAX KMEM memory block states. For example, the memory block
+	  sysfs functions (online, state) will return -EBUSY, and normal
+	  calls to memory_hotplug functions from other drivers and kernel
+	  sources will fail.
+
+	  This may break existing memory block management patterns that
+	  depend on offlining DAX KMEM blocks from userland before unbinding
+	  the driver.  Use this only if your tools have been updated to use
+	  the daxN.M/hotplug interface.
+
+	  Say N if unsure.
+
 endif
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index f3562f65376c..094b8a51099e 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -184,6 +184,21 @@ static int dax_kmem_memory_notifier_cb(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+static int dax_kmem_register_notifier(struct dax_kmem_data *data)
+{
+	if (!IS_ENABLED(DEV_DAX_KMEM_PROTECTED))
+		return 0;
+	data->mem_nb.notifier_call = dax_kmem_memory_notifier_cb;
+	return register_memory_notifier(&data->mem_nb);
+}
+
+static void dax_kmem_unregister_notifier(struct dax_kmem_data *data)
+{
+	if (!IS_ENABLED(DEV_DAX_KMEM_PROTECTED))
+		return;
+	unregister_memory_notifier(&data->mem_nb);
+}
+
 /**
  * dax_kmem_do_hotplug - hotplug memory for dax kmem device
  * @dev_dax: the dev_dax instance
@@ -563,13 +578,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (rc < 0)
 		goto err_resources;
 
-	/* Register memory notifier to block external operations */
-	data->mem_nb.notifier_call = dax_kmem_memory_notifier_cb;
-	rc = register_memory_notifier(&data->mem_nb);
-	if (rc) {
-		dev_warn(dev, "failed to register memory notifier\n");
+	rc = dax_kmem_register_notifier(data);
+	if (rc)
 		goto err_notifier;
-	}
 
 	/*
 	 * Hotplug using the system default policy - this preserves backwards
@@ -595,7 +606,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	return 0;
 
 err_hotplug:
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 err_notifier:
 	dax_kmem_cleanup_resources(dev_dax, data);
 err_resources:
@@ -619,7 +630,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 
 	device_remove_file(dev, &dev_attr_hotplug);
 	dax_kmem_cleanup_resources(dev_dax, data);
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 	memory_group_unregister(data->mgid);
 	kfree(data->res_name);
 	kfree(data);
@@ -640,7 +651,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
 	device_remove_file(dev, &dev_attr_hotplug);
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
-- 
2.52.0


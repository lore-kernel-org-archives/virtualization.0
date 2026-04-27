Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCB37B019;
	Mon, 27 Apr 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301930; cv=none; b=tDiiqbSepTodxpxVPfOXDqjZEPLD99ReCGh0L9XzHVaSaU8I0CPa+URpdh2/IcXDZgcToOwmGc+++PYQPZa6PO9cMaWsAUXTE+m68mdeskwypow1hjbJweKTHeVanwkvh2i606M9mHNNudrGmeUouTxowDBrZ487cTUsnd6HXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301930; c=relaxed/simple;
	bh=+NTQq4xpBbgLkASh7hj0+PrTgY0Wsh0P5ylrq7ek6QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEyg/aPbVHDWkcCFNY1baT2iXUPxZ/jirtoTrvoQm94qX6NkCeIVG7bacLz9CRYbryEND26WB8T7lfb2584bsYyPRJj7z6gHTsMro5zn8lOO1SnynVy7/Je5DjUZKgiGhp+R0PSZjqfnuesSRH7scd4db/h+8AQ8RFJocyVFgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEKMulDi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEKMulDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE43C19425;
	Mon, 27 Apr 2026 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301930;
	bh=+NTQq4xpBbgLkASh7hj0+PrTgY0Wsh0P5ylrq7ek6QE=;
	h=From:To:Cc:Subject:Date:From;
	b=cEKMulDiQZCliws/YM9QAmNp7rYUP+JWQu2eTUjvy+gIUl0I6Tc3hUzAmWLsRKvpk
	 k+bL4HAIM9A5gLnvMWpZOvuJ+cJUCnogzvVG/SLh9EvSBaWhIyWzhfdydiGsaLSNKl
	 3EyKCM96y+7Pd/ulYaFlDLVslh4XM1LLjzWkldGbo/PYLlKvVHL2RE2UxKC9c+qHmA
	 HPkdyAwyu0Marikp0xmELBqmVYr62lCEgvTnUH8MJj1Xqkbcje/LvjS/18/azgXOkk
	 1tPmLcnWKhcv8l08+PKH0od6mVVH29XKNinISa9UZ790ir8dS4QbW50zKw665GFBau
	 5gy5gVeioMP2w==
Received: from johan by theta with local (Exim 4.99.1)
	(envelope-from <johan@kernel.org>)
	id 1wHNQ6-000000004I4-2589;
	Mon, 27 Apr 2026 16:58:46 +0200
From: Johan Hovold <johan@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH v2] virtio-mmio: fix device release warning on module unload
Date: Mon, 27 Apr 2026 16:37:10 +0200
Message-ID: <20260427143710.14702-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be allocated dynamically and complains
loudly when a device that lacks a release function is freed.

Use __root_device_register() to allocate and register the root device
instead of open coding using a static device.

Note that root_device_register(), which also creates a link to the
module, cannot be used as the device is registered when parsing the
module parameters which happens before the module kobject has been set
up.

Fixes: 81a054ce0b46 ("virtio-mmio: Devices parameter parsing")
Cc: stable@vger.kernel.org	# 3.5
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - add sanity check to vm_cmdline_get() to prevent root from
   dereferencing an error pointer when reading back the module parameter
   through sysfs should root device registration ever fail when the
   driver is also built-in


 drivers/virtio/virtio_mmio.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..510b7c4efdff 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -662,9 +662,7 @@ static void virtio_mmio_remove(struct platform_device *pdev)
 
 #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
 
-static struct device vm_cmdline_parent = {
-	.init_name = "virtio-mmio-cmdline",
-};
+static struct device *vm_cmdline_parent;
 
 static int vm_cmdline_parent_registered;
 static int vm_cmdline_id;
@@ -672,7 +670,6 @@ static int vm_cmdline_id;
 static int vm_cmdline_set(const char *device,
 		const struct kernel_param *kp)
 {
-	int err;
 	struct resource resources[2] = {};
 	char *str;
 	long long base, size;
@@ -704,11 +701,10 @@ static int vm_cmdline_set(const char *device,
 	resources[1].start = resources[1].end = irq;
 
 	if (!vm_cmdline_parent_registered) {
-		err = device_register(&vm_cmdline_parent);
-		if (err) {
-			put_device(&vm_cmdline_parent);
+		vm_cmdline_parent = __root_device_register("virtio-mmio-cmdline", NULL);
+		if (IS_ERR(vm_cmdline_parent)) {
 			pr_err("Failed to register parent device!\n");
-			return err;
+			return PTR_ERR(vm_cmdline_parent);
 		}
 		vm_cmdline_parent_registered = 1;
 	}
@@ -719,7 +715,7 @@ static int vm_cmdline_set(const char *device,
 		       (unsigned long long)resources[0].end,
 		       (int)resources[1].start);
 
-	pdev = platform_device_register_resndata(&vm_cmdline_parent,
+	pdev = platform_device_register_resndata(vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
 			resources, ARRAY_SIZE(resources), NULL, 0);
 
@@ -743,8 +739,12 @@ static int vm_cmdline_get_device(struct device *dev, void *data)
 static int vm_cmdline_get(char *buffer, const struct kernel_param *kp)
 {
 	buffer[0] = '\0';
-	device_for_each_child(&vm_cmdline_parent, buffer,
-			vm_cmdline_get_device);
+
+	if (vm_cmdline_parent_registered) {
+		device_for_each_child(vm_cmdline_parent, buffer,
+				vm_cmdline_get_device);
+	}
+
 	return strlen(buffer) + 1;
 }
 
@@ -766,9 +766,9 @@ static int vm_unregister_cmdline_device(struct device *dev,
 static void vm_unregister_cmdline_devices(void)
 {
 	if (vm_cmdline_parent_registered) {
-		device_for_each_child(&vm_cmdline_parent, NULL,
+		device_for_each_child(vm_cmdline_parent, NULL,
 				vm_unregister_cmdline_device);
-		device_unregister(&vm_cmdline_parent);
+		root_device_unregister(vm_cmdline_parent);
 		vm_cmdline_parent_registered = 0;
 	}
 }
-- 
2.53.0


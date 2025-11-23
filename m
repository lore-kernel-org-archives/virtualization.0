Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AC2D6E6D
	for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763920692; cv=none; b=kVNq297xmKELn04Ve26GTjan5xRqv//a1qMPVWR6l0ArjXbdSgDPa7htPK7IlR8t43rYAdrSEHo+0Cv9CB6peNErD0R991dV9/dR10QOAiXmx6iDxEjEWlpWgjejJ/IuE9oB4aAc+iHrH8pWQv3VyaYhfFwwMDMIrukpYcJoUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763920692; c=relaxed/simple;
	bh=y7J6v3zCvZlT+LHUAYO/2xbi8IRJtDPRAbPSVJZKoEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFvtKFnaO1pd4EOukBdEmh4E81SycwNBsihvStQbj1g+j4/WYe4YOhwgSg0KcB3yPTPM7TK0lk/JzyeOt13jpyIt/6ysG77b1NS9wnERRDxC+UjCSY7EuYmuULkbabG+bf89FV+ueihNu5EtP1H1i9Qxfe9aGrjvMWpiB/y0HW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J41rYG0s; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YHZ0Y5Zf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J41rYG0s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YHZ0Y5Zf"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dDxWb1LJxz9spL;
	Sun, 23 Nov 2025 18:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjc0aWNFNsV5l7EKzxLKf0zkHg2HPDKuuRPcOFmsQ14=;
	b=J41rYG0s+J0g/Qjm6wtWsA3zfqMOX7yl74vaULRJii9sk3TzBgFdx5cKkTVCgK5MjQn+QI
	MZi1Jg1DanSRhF3yDDjZUBhVrMSbhfi2roOdNdTSjQeob9dhw2B2cXDMDFsjpLkJ/qEhpc
	B79Kno4Dy5Uc3n5Q2yqz5AGQGfQzBmYknKEHPlGU0eKtl1mNZo9g5riBIoCbvQQR0EmYxo
	qJfLObp0MS4Y8fRz4xFt8KuKIZJIdabVkkW/9mpAJmYtXq2bQJbIoTnr2YPTPjmDJV3ZlL
	TiCf3r0LSqy1CmXzlIoI8cKr2XHg+1rUQQw3pft2pQXnISvwFNzH14FxkQvRlw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjc0aWNFNsV5l7EKzxLKf0zkHg2HPDKuuRPcOFmsQ14=;
	b=YHZ0Y5ZfxfvqAng3hdIzUC8FFdJt2Lh/RtuI3nvz7bV1nyzd4Nmyca8qj7dzo5WL/Qw6fj
	X9GqIDOl1fqFTnvv5wvRPcp32XaQLcfmUwhGIXhsjD6OXw0SXsQLTHBFjPmYKtfIfTFxKM
	6rXBtQoBIlRK9zP8ofSj0zVpgqiUTMnH8NLDovtA4tLQ3LjIN3HoRprXZlAgZaE2FRxVzg
	qESM62vKsjUDkK40EU9KuOAvXX1QMcD/9oGCT9ZZhbCq5fRT61nrcinNzx65O3NXBCmwfO
	2gDoFet54EMtWrhxnXCB9JPJzROvvAd+fI8sKjhhNDnngvi5QOtsiA4FImDq0g==
To: david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH 2/2] virtio-mem: Destroy mutex before freeing virtio_mem
Date: Sun, 23 Nov 2025 18:57:49 +0100
Message-ID: <20251123175750.445461-3-mhi@mailbox.org>
In-Reply-To: <20251123175750.445461-1-mhi@mailbox.org>
References: <20251123175750.445461-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4a276b6c63f95b4e1e4
X-MBO-RS-META: amaespxjkc9eokwnsiq8ta6z3fdr3rw1

Add a call to mutex_destroy in the error code path as well as in the
virtio_mem_remove code path.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/virtio/virtio_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1688ecd69a04..8107988dcb05 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2975,6 +2975,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 out_del_vq:
 	vdev->config->del_vqs(vdev);
 out_free_vm:
+	mutex_destroy(&vm->hotplug_mutex);
 	kfree(vm);
 	vdev->priv = NULL;
 
@@ -3067,6 +3068,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
+	mutex_destroy(&vm->hotplug_mutex);
 	kfree(vm);
 	vdev->priv = NULL;
 }
-- 
2.50.1


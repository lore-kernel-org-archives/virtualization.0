Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD874DDCD
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420359; cv=none; b=oqWjPPgO8Xa0jJYo3baP/D9jbbc0bLGns/7Cs/TStsrr3H2IbdlAIJJpn2SVKiBQ6zByN28LhyeZJOvcfwEWfwHGdTbqQGxsQvL2NQyezIhfuSwobAYJUPuLuuPf3UYsfG1ZjSoFRzTgCq+5dvZ3kbhGrS/bDNWlVLEWXdQHcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420359; c=relaxed/simple;
	bh=i7U7k/F42Bi8LpEeWcbtiwQlBBwyKe9OTJzHbVwvb/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnRWBTd5BU83yYzqiwEB6WvzgjlkNa5t+CoLn9cYhnqa4CfBalulYNyH0IyJMxtn0vYQRKVCz7s2dCOk+RBmkx2jDGZ2Gxkrz4cl8xSaM4GvpzM7a6837xhleSepamRhH3joeZ8fjATIvRHDXZtC4ahJgEOJu59nIy0/rjvZV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=xhgt/7uP; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="xhgt/7uP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420313;
	bh=i7U7k/F42Bi8LpEeWcbtiwQlBBwyKe9OTJzHbVwvb/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=xhgt/7uPTBLZdK25GhmRTIRjlm57rGAGDmmGFaJKfTmtPFWzr1tAnHEU21RwaFiEy
	 Hz7p+6xlSlII80NLpmsyKebmzv5LiGUcUSRQR6Ps932zUrnjoGxIBsb469cC/mRTEn
	 YuZz+BCzFNL8s3cO7jW1dl7R4TNxtkv7RZnF9wRonqDe0WJdmQX0l85+vBavn+Ci7B
	 74RdQQCSg/nmIMztsNULkkoek2J9OaHDDNIO60TaC58SYDqZYhptPXJt+gKcyDRSYj
	 +QDBRzfcCCYzWkkPMxToTq55z7XU5UC9PXmrh3a5arxLVh/HFf1D8+3vScY0ZJqEJc
	 4le8uM4LTKoqr7kjRmUEcgpH5KLYRjVbxEmo+OBb88ddNq8QlSseh89CKgHJT0ovzH
	 zIjCxFUn7wzxIF+KtrQGXLr2AMZn9iiqNpOZz/v6OKOqQUiOkDtYsKLM7cAF4C0o+u
	 YiCJLB2qzm8ki6EQZt1mYC9eXjReOLZnTP3L70Zc14DkOKLWriumPUYkGrD3g8DTxd
	 jSxG2HoCLYD3d8TCCL/gaZvan/zUmDV1gZFdwTv6S1WbehecHAey4zUcMxmbHDgWA1
	 23/Ux+dokboyZnUeUAN6HFNXPPSoL5ja2aXfaGo4/4HbNG1DP3XhE6b9rTvYdt/U27
	 yVoFB8QbiC95ZT7FolT3hOMw=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:15 +0300
Subject: [PATCH RFC v3 2/6] rust/helpers: add virtio.c
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-2-1427f14d67e1@pitsidianak.is>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
In-Reply-To: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Peter Hilber <peter.hilber@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos@pitsidianak.is>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=i7U7k/F42Bi8LpEeWcbtiwQlBBwyKe9OTJzHbVwvb/c=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBTTGdCOW9kT2ZoZUdrR09pRCtQTlVEMndsCkZOYi9vVjlML1F1eXFBR0l6
 R09KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1VnQUt
 DUkIzS2Nkd2YzNEowQ0JORC93SlRKZ2xjOHZRN2RSOVp3Nk1JVVFtamRwMkxYOVlPQWhpL3VqTQ
 pMY2dJK3Q0OTFyc2E1QzdWYnRyaEJEQUxQT0JzMUg5R0lwSHFxb1FlL01YQjBhUFRlWHJBVHp5M
 ThXbkN4SkMvCjRsQ05zSWZZV09sSkdFRmxZclV0a1Rsc25idGZXWm9TbVQ3TGUyMVZhM0krKzVq
 cUpCa0tiVWQwdnVRdjd4TXkKV0pzcXBqc2dYSy82a3pYdXhkZ3BoWmI2VWk0Z3U3V2Y1eloxZnd
 qZWVTaWJrVnBvY2ttVGdaM0wvTzhZU0ZrUwp1Q0hqeEtLcDNFNzdLT2oxWU15THVFajBLTzhFdl
 hEWlVFZlVaSE1WcDFHV1ZicG11dWNEa2FvQklpM1p6WmJTCmNHdEVWbnNScUtkWVhkTG1oKzdhY
 Wx2YzdrRXFRN09yRGJWZ24wb01uajgrWFg2VmU2U1l1UnM5SGZoZFl5VW0KdkQ5VEIxMmZ3c1hQ
 RGhnTk12TE9GbFpuMG1LUkhYRTNDM3o3U1dKb1NCcUFFZkNMcENWNEFjQjFjL0lyUm43UQo0MHh
 pMVIxZVJ1VXBTTGRyQ2VjUU1la1lhQUM5bEcyamFHU0thSDIwM3dWdGxyZzVHTmxJUW83Z05NWH
 crQ3ExCmpvTmFNM0FQbjhyUGpRSlFEMkJncFhWYi8zcEhkQStzVTI0SXpjdC9aRWZCVFVjbUljQ
 zNWUDB1NW1HNTc1c0QKc3hKU2NZNEl3WHU5T2RBNXo2bXJ3N0lVdGdDa3NKUkMzanpURStOWmx1
 VzFwOUs1U1RuRlR5Nm5JSFJRRmtvMgo5bEFxNmxRSXdmK3V3L3FGWDQzd1BVaDRoM1NHbmF1UjF
 CaUl4N1gyZStVSUc4VTVuaXhhaDdkN3BwTGFqL2QyCnFnWXVvUT09Cj1lNjR4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Some internal kernel virtio API functions are inline macros, so define
their symbols in a helper file.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 MAINTAINERS            |  6 ++++++
 rust/helpers/helpers.c |  1 +
 rust/helpers/virtio.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f004da89b1aa339116908f642e894..48c9c666d90b5a256ab6fae1f42508b789a0ce50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27930,6 +27930,12 @@ F:	include/uapi/linux/virtio_*.h
 F:	net/vmw_vsock/virtio*
 F:	tools/virtio/
 
+VIRTIO CORE API BINDINGS [RUST]
+M:	Manos Pitsidianakis <manos@pitsidianak.is>
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	rust/helpers/virtio.c
+
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux.dev
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a0990bea81ebce6e99bb397ce7533..5dc0d2f2ee6bd2ae8e6abfe4baa247c1963967f6 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -61,6 +61,7 @@
 #include "time.c"
 #include "uaccess.c"
 #include "usb.c"
+#include "virtio.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/virtio.c b/rust/helpers/virtio.c
new file mode 100644
index 0000000000000000000000000000000000000000..46aeeb063158823e66477777b3cd4bd1525df330
--- /dev/null
+++ b/rust/helpers/virtio.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef CONFIG_VIRTIO
+#include <linux/virtio_config.h>
+
+__rust_helper bool
+rust_helper_virtio_has_feature(const struct virtio_device *vdev,
+			       unsigned int fbit)
+{
+	return virtio_has_feature(vdev, fbit);
+}
+__rust_helper void rust_helper_virtio_get_features(struct virtio_device *vdev,
+						   u64 *features_out)
+{
+	return virtio_get_features(vdev, features_out);
+}
+
+__rust_helper int rust_helper_virtio_find_vqs(struct virtio_device *vdev,
+					      unsigned int nvqs,
+					      struct virtqueue *vqs[],
+					      struct virtqueue_info vqs_info[],
+					      struct irq_affinity *desc)
+{
+	return virtio_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
+}
+
+__rust_helper void rust_helper_virtio_device_ready(struct virtio_device *dev)
+{
+	return virtio_device_ready(dev);
+}
+
+__rust_helper bool
+rust_helper_virtio_is_little_endian(struct virtio_device *vdev)
+{
+	return virtio_is_little_endian(vdev);
+}
+#endif /* CONFIG_VIRTIO */

-- 
2.47.3


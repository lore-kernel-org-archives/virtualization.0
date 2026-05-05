Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3C30E0F5
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968860; cv=none; b=rDLtzSlxQek7ToOYbFMajsXwj0WcRRUPVagO1XZ8xQkTG4thZs3FJVbv8UlSlGUD/R/UhUaGFOA7m0ig8ZKJN/v29WtPVVIWZ00Iua11eRpyhrA7J4AxO2tsEoYRGAAeI9iB+VG/+/gFq65xdlWbaQh0S++l98VozMMnIsQ9qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968860; c=relaxed/simple;
	bh=UFc9kfWsblC+PG6Wl4DteBPxUyIgijd59/joXPqaXEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgHD4nng26kkcIC2KyuXYC2xA09TDUYR/e9JACubYL3hpqDFbPM8pFGpW98ibxS6LnO8a1QHMx6svcQ+zQrHWtSYAZwp1vVPDzo2AM1rigFxT18TEUBcW6yCm7NYLgJV7DuGTMfDFgFCxOnhQYpU9OnS+Sbbsf1ncXFbFvhEvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=yworXja0; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="yworXja0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968857;
	bh=UFc9kfWsblC+PG6Wl4DteBPxUyIgijd59/joXPqaXEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=yworXja0we+PIGum24JEeBgzktdR5jU1hU7viwLoyJNo2Ph1U4gE/AslV+ULYEJPB
	 QX3qYZxIqyFr/nfTcK4RDmrKeRSeThFC60VmJWxFQgi2Lr8hBaN3vhTpRlFQeqT04H
	 IG1F662Iych11Xubt6aFhOd82KRaIYn23cji5OTPaCG9JwGcU6Mxi5QBNV32DGqXHo
	 sBpcrcbTYqhIJ1/LR4fEGjAu++XOyg2zxzJ5T+aMvpdJB+jyWvPjrRTRVFDEQJ69G9
	 iYDQxqCsYf1kCc78UxNWuQv6lHqIX9SWesYPv1cLAFtP4UKyjO+1GSKk5MQh5NngIn
	 C8uKySJUafVma7EE+rA+IShF7qyaiUADJxjbXQiQdydOrEnLy26BOUTD7jvnulLg9S
	 7uKWb9UK3JqCeeFSnZaHwbxfsmg2H2y9WwR4V3QpYbBblzRWPqdAi27e2TDPr5pusq
	 gU6NBWqVZkD/Jm4sqnJ8jiR1hS+5I5MB2yyn5mELOJADqJrg2sJQEcv8mfG/GGMd9p
	 3MEEbOPxsrPkMKEchmHcZH6zB6dfIrqXnfErT+pn+xKAmAlGltCdszTbMKe+nm7Pcz
	 sNxzZAEmqeBKZpSdT1YrpH7vUo73xURLro4I6K7THCL2w4AGSPSPHnGxVgY1uDzqaF
	 aYAZ2ZR2yLmv+aSz//fdHADs=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Tue, 05 May 2026 11:14:02 +0300
Subject: [PATCH RFC 2/6] rust/helpers: add virtio.c
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is>
References: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is>
In-Reply-To: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is>
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
 Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos@pitsidianak.is>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=UFc9kfWsblC+PG6Wl4DteBPxUyIgijd59/joXPqaXEM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJTVGg4bkFwd25Dd3ZNbnNvOUZRYmlDL2dpClNyQTVPYXo0MTNMTi9uMWh6
 V09KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTBnQUt
 DUkIzS2Nkd2YzNEowSkJwRC80anhkK3ZIWnEzbk1sVzNTOTVuNnIvU01CVnJJeHpaVS9YNHBsWg
 orRVdpMkZ6dkF4VFppWFZoTVJURTYwUUpIZTkySUVRYWtrRmVEQkxtUnNnelFyWWM4ZTZSMUtlb
 VNJbjBzcERwCjNrQ2xPN3BMNDQvYmdqdmJkSVd4TzVxMTQwVTJvYWdoZ1ExWmZnd0dSN2dTS2hJ
 L1krTmJxZ2lBbmVGd3hpcVkKRnIxWDAvK1RDOGRLWUhFL0FEMUxVWlNzSVFOaks5Zi9YbnJiWDN
 1dkdxZWJaMXBFWFhycEs4ZEJsZGt5c1NqYworQ1VOUjAzd1Jhclo0cnJvNmFWRjVrclpWMXBGQz
 drRksvTGdwTlBMUVFDSUVmUDlMVE1wZDFNNHFOYXBUdG00ClNNc2tIS21hcWdjdkpPNzB6eVpIb
 GpSZHcvNm4yNkJSNlFmcmdra2JsNDN6THI5L21vck80aitZMmNUV0d2czYKUm84NjZ1b1J5dmVE
 eWRUenlrVWJvQ2lmR3pEdnJrMG5uam9YcFFyUFdEMDU4V1YwWEtvS2hHamNTOTltTy9zUQppSUl
 sUGV0dG91MzNUd1htZC9HUXFwSEVwUHloK1lrMHNZQWRNQ1JWa2YxS0Zsb0dCWXpGcmFMQjV2MT
 ZWdThPCmNiT2xJc0NRZHpXaXY2YTdIak9MU3JqSlhPS2NiUDFsdFpBQnQrTUpBalJkTFJUc0xUb
 3cyazhGY1d4SEJMM1oKMkkvejRDZDlpZFhXNVpOb1ZUdUdjRFBDa0ZCUHNLSTczakJjK1Z4NlNY
 Z2g5YVp4b3FKYnhjclFqaHNpVWVQVQpTU0diOG1pNjV2ZlRlTG5aWHNqWWo1ZkhvYUVyLys0bWE
 3K1poRFNPejBaNE5ZdXdQVHpNVjUzN3V1T0llNFBKCkJDNlpRUT09Cj03NXpHCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Some internal kernel virtio API functions are inline macros, so define
their symbols in a helper file.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 MAINTAINERS            |  6 ++++++
 rust/helpers/helpers.c |  3 +++
 rust/helpers/virtio.c  | 35 +++++++++++++++++++++++++++++++++++
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
index a3c42e51f00a0990bea81ebce6e99bb397ce7533..84b54690d95be37699ef9a9c4d7cedec0bbae6d3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -62,6 +62,9 @@
 #include "uaccess.c"
 #include "usb.c"
 #include "vmalloc.c"
+#if defined(CONFIG_VIRTIO)
+#include "virtio.c"
+#endif /* defined(CONFIG_VIRTIO) */
 #include "wait.c"
 #include "workqueue.c"
 #include "xarray.c"
diff --git a/rust/helpers/virtio.c b/rust/helpers/virtio.c
new file mode 100644
index 0000000000000000000000000000000000000000..cd8a811d59960e7b6aea1c08016f4154b29d5a97
--- /dev/null
+++ b/rust/helpers/virtio.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
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

-- 
2.47.3


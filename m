Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8E36655F
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338066; cv=none; b=ATy72i32xz8l9gqvRPTWCuhoOjjUzL55vAEcEupjb2708Mga8aWycoh9vnIri2j1LxoTmoykfIq10B/KeLLh+c+QxvPodhK9xdIYdIc6edt92NGiTrpblZR/Z6/Ndc/I2ucajORARoDvZ+Cuxs5hkwcVU+HC1hpPATpgtSumjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338066; c=relaxed/simple;
	bh=rSVMrHdXXMPOdNSzrMYHYbcWyiA/ND/D3nfYFJ1b2Bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvyKvCbCoAn4VFsH7mZu3uhDhueOkAqgZpRF2j6IjL8+TZ6BWwQbHihAKVrwFPotbLIe3+YVyPDy94APne6Rf53WSeg58fH10FSXKrqu1R0JhMKdUP/1GezC5ADMHtceYUrayXNlek9vZy81zvLmdmxOd1/xh7XBp7OxEfOaEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=wBPLPVks; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="wBPLPVks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338057;
	bh=rSVMrHdXXMPOdNSzrMYHYbcWyiA/ND/D3nfYFJ1b2Bw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=wBPLPVkssrX+lU+fe8Z6SpIssvJflNfNz+56bvRhqvoQ29K7OL2k08FT3Qf15mbO9
	 ieGMGNF9IQwNArNB0FJ5WvYvCfpBdN4vMsQlgXe+etzkTkU+DjbkCBfgYuJqHzVBIb
	 mtrbc+ajaKUmErsLx4rMTEYdkKmhyaEQw9eecS0Eh59lTsGwcgSHMKHBQZU/8e1dTI
	 C/IWpyQweaw5lUkWPry0mEykmsc8I6g3oo5qLbjuQDS1aqhjB/o01B+8/Nifc3pvD+
	 MJZQt8psdrGydsk15+8hlx8gqdxlWd7JHlIFa9PctdUuT0g3k/AAgVE/mJodXwnfYX
	 LohFPaS7TCJWUluALg35lXyYUM10Sjsh7LzIe6TTSmTWTMSfEjoWclwiv+Xne/kCOs
	 itpdtPd0JQOPT1PZBpyB8obGuvqqwvmsD+AJ8LXb0vBu1M57h3+zPijDP/sMTMYpoM
	 TXPdU03rGrTc62CJ9zopTEk9vyySe9vEsAIWqsHdWHjI11nuUNytOrRAGkwpM8MIH0
	 wD4fzWSfi7N8ue2AT9AcQ2GthAwFHi5ej54ZVaYyPUeu1Fi0+rvaMtmKVbDM4y2/1W
	 MNiAA9+PJsxsbTHjH+uTlp72Wfi3s43zri4mm7qqbFSvvJgTMePH/pGtXUyaT9pAmS
	 1Iwg6+ubWbQvQsOhJVLrG8BM=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sat, 09 May 2026 17:46:56 +0300
Subject: [PATCH RFC v2 2/6] rust/helpers: add virtio.c
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-rust-virtio-v2-2-c1e30ec2bd21@pitsidianak.is>
References: <20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is>
In-Reply-To: <20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=rSVMrHdXXMPOdNSzrMYHYbcWyiA/ND/D3nfYFJ1b2Bw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtDR1N2V015WlJlRHRsdWp4TVZyOGlHdzFsCnJLYUtMa1dqMEJmT0ZySy9t
 NFNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkFnQUt
 DUkIzS2Nkd2YzNEowQkx3RC85c3p5dlJVSHpHMVBWNHBIVHlFeWlhQTNoYWRIZ0JIVGlKWUVnNw
 o2NU1YZTB6RmpEdE9SRFdqZ3FwV0IrVWYvMlZhM3dxRUtwVFZmbkptS0xkVGpaa2orODZRL0tKQ
 TkvM0NiVDZkCmZEaU54UVFBS2U1Q2hCcFg5eXJJaGIybU5JTTZKeng2dmFBQnJ5a2w1UWpTdlcw
 d1Q0VGNLVUJkM0lhckMwZUsKTVl2dnExWU13SjlhaERITmxSZlFRSGxHQ0JQMkRsSm81Q3RwM0R
 acmlXUWlNN2V0OHFYeHVsY3JWL3l6eTA0ZwpRNzloQm1wTE9abGVKb0I4SEswNlg0SmZiYUE2an
 RSUEhHMWlPZ2xQZmxZeGRHMFU4ODZHRHkrQ2c2TE4xcnIzCnlsYU5GWDZQY0p3aGpDNS82MXpqK
 0pJcy8wTW1TSGNCV1pKamVpUkU1R0U0UFVkdC9FMFg3bWpwWmkrVkNsL2wKeHEvMGNoL1F4UU1I
 SUNtT0ZFL013SFUvQWJjOVFwMDRyc2xCbmI5alBFMjR5YXQ0V09oT0ZTNmxtcGl2R1lnZApBYk8
 yVmFOTDFYNUREcHBqbzJKU0QvTTJLYVdIdVpGbTZYcUMwb0dLUFMyaGdCK3NJNjYyV1kxU2p3Z3
 QxS2RJCk1WMVZPTkFQQzYzclFncW91WWpLUnplY0xkaFJXVXBwU1FkcjZqTUgzZXhGWFNqNnR2Z
 Td2bjJFcTZVSXdkMkYKaldNV0ltVFFxRE8rRklaV1kyQ3EzelozcU5sZnQrRVNCRHZtd1AzZUxC
 ZWlwcU5qc2l3SVJxUncwVDVHSGoyRApEcjBDQUd2UWdhK3VQZU1PamJJZEgxVXpKOUZWaElkM1Q
 wZ3FrVXFOT1JkbElHeE15dG9sSWF6ajV6ek8wNnlNCkRIbXV6dz09Cj0vSG9zCi0tLS0tRU5EIF
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
index 0000000000000000000000000000000000000000..92185d7b8bd97b66f7b7b825390fdd1173de313d
--- /dev/null
+++ b/rust/helpers/virtio.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#if IS_ENABLED(CONFIG_VIRTIO)
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
+#endif /* IS_ENABLED(CONFIG_VIRTIO) */

-- 
2.47.3


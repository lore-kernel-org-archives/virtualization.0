Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9253E92AB
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968859; cv=none; b=VGhSYvcBnYj34x4OaQR2/po3kASNj4OAwS0kvRrXvHOTKAhL7SX101cly4mKTmS8s1iSAsfN8X0DkdMeLvIuXg3jbmW6P9wKTcMN82ShA/uRFxh4+QT+aXAhM9t55tT2+iZUWg0d1wXen8iDDftXKFgwiCLWvXOr0MzA+OkBsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968859; c=relaxed/simple;
	bh=lunnIEDIwUnQNvPG0VVtgNP08wmfg3dV+L6Z49Gti7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyX4HjcAbMKhC7hQPj4+OH4HctXuPnL3tFZWU+NA8Q4mGv8f/3t/cepBnPi3vYxoz1BKjUdSrAPBvOTxjTzn0Ii9bISmRk+Vm06S93v+Hh9ou8hjVN2oLdi8NYBq530W+yWFXoFgr5Fv39kvG43C8HIYlz5DOO9wv0TPiZKjGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=0Nrp3QXG; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="0Nrp3QXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968855;
	bh=lunnIEDIwUnQNvPG0VVtgNP08wmfg3dV+L6Z49Gti7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=0Nrp3QXGSWlz8UVAVt+fQRNid/2cZ7GXlY7qjUxba3zcDFXxirjx8T4oegUSzH5MB
	 XVOuuCBDjslapcuS0O4Rl/DHCfmlJNWonc6dmIhxOp/RYDll2u0TZsXc/yaQVBLA8V
	 R16K+uvLD7BB6Of8I0vHzFnUKaVt/I32v4E5bZCRSedywhZ6Nrdj6fz5xDJrJ1S3dK
	 UbHaDTwzDiJPkzGCJfAFsrlTrlOIeY8lkFpeb4huIPW89QWPLlSHRppJ6AwhjOEdc7
	 lgOC6OVb7LktT50pyz+bI46jD6aGQBAAN8fcOpMqzW1QTiAEypQPm2zYHNvqvStZlL
	 2KV/ruTtrGyCkKUaaiNpqFZ4+860JtLMQlSnRLKDeqwD4lhtbH7WpWwScHm573Fwgj
	 d40xUEm/K7I9n0MYOedPbpNPbsEbDBzxQfKaRsK/lp+SUWShCmwhiNblkrnCIWGes6
	 SZA8o9FXgxOFuRmegz+B0lXCblAsuB2zTe8OPpINaB1ak8Fjliz0SbGpv9ROtSC7Dq
	 keGShllL9GltqckswbEyduLsI6BfB4ZgqgAHzJ9/wj2zPX3P3VKA19pii+wyGnzWkO
	 cfDWJJtWNtT64a8aXryY+QpF7A/3z1pmz0ye5kQFAjRhg9Z7kSBvnh4sqHblY/jCS8
	 ltFM56jnBqmHsP1bDW6YK1/o=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Tue, 05 May 2026 11:14:01 +0300
Subject: [PATCH RFC 1/6] rust/bindings: generate virtio bindings
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rust-virtio-v1-1-9563383909e4@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=lunnIEDIwUnQNvPG0VVtgNP08wmfg3dV+L6Z49Gti7M=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJTdTFsSklWWlJSb1lGK0tLTzRBelNJWUdYCmptd0pxd0tEVkNVcGlwckFH
 VGFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTBnQUt
 DUkIzS2Nkd2YzNEowQUQ0RC85b09VZ201QlNYWk5GeVBZQmk1aVN0cnVQTWxHVFVwRHloN3JrTw
 pTQ25Wc1VvM0Y5cFJOdmx4ckNvcTA5QndqTnREeVF0REtKQXlHc2pMSlp4anhwYWlrNk9WWW9oR
 XBLNVFhS0IxClhJbUhCQ1ltOUdqODhqaks1SVlyVGR6VXNJU3ZseCtHQUFIbFNPeFBzOHlJWFE4
 cGlsRWNzTE5yWnpzVnlsU3UKcVVCdnNmcHFoenJNSkZDUkVTYy9Gd3hqSkJZSndEaTRSQnB0MEs
 3WHdFdmV5U2hNaWthZHF2bTJva0ZEbmZMbQptL2JVZWNZbDVhWmgrVGg0ZUppRmN2R3JydG9rSk
 dxWkpLcmFWc3djQ0lBSGxkNHRMbTZOWVhzL1FZelRJZzJhCkU4dGpUYmJWSFhjaE9Ib0xrYUIrR
 3JhSzA5V0hubWI0NEZVN2dTMTljWnVwL3pqdnhDUytES0I1aFc3RzYyUmUKbFRFTWc3WG9OTVJl
 REtJVHVrejZRbVNVNDR5QmlMZW5GL25nNjM4SE1DOFdpcGx5dWYxWFNTZWY0RWtTRTlONQpDbyt
 XNDNTOW5URmZyeVpvckdtd2hCdEpUVmNzRmw0MlFOTFFYa2grbkdreDJtVFdwMFRubFNERXF3Yk
 JBRXdWCmpzWTd4UEpicGFXQWQrMHRpQ3A4RjI0S3F1eFdsY3Y1TnJvVUhMTFZDOHV2YTFvSzZpR
 1lVaE1EZXRUb1hIN1gKME5HUUFFVmdqbko4M2xxTmJPazlzVEtlOGZRT2ZvbE9jU2JabG1kMTI3
 RzRpMG5VOTJ6K0NaRkc2cE81cWdEVwpVMUx0b3N2UnYyMWdZaE5qdE5mNGQzWjRQdzR2S1JqaEE
 2TjEzdWRXV1JCelEzek1hNE5zaUlKaHhndjdUT1FaCmlDQm10QT09Cj16ZWdXCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add virtio headers if CONFIG_VIRTIO is enabled.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/bindings/bindings_helper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952c2b29ab82d5d481063a1cf48bccf..2b0a3cf49fdaf14517afc88688c545aaa977b5c6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -151,3 +151,8 @@ const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 #include "../../drivers/android/binder/rust_binder_events.h"
 #include "../../drivers/android/binder/page_range_helper.h"
 #endif
+
+#if defined(CONFIG_VIRTIO)
+#include <linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
+#endif /* defined(CONFIG_VIRTIO) */

-- 
2.47.3


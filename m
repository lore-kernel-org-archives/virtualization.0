Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439338F633
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420317; cv=none; b=tYH6e1ndT5Zpwqr6tz6JDpHvEV/+1MlIcgDnNArjgLE7/bruZMVchZDep4rWlc3GltYY8N7FqXjiQuY9nfGHMqW/ean9kTsSKD34lb3LZ5TxtDkMCvLruBG7I0C5Rs6OzEKdz57l7iKBAW9gquRAvnPCqUJk7RWr750R8gVwFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420317; c=relaxed/simple;
	bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAh/I1F2D+H1rZqx8R87m5Nuq8hy5ZXXvH+5jgZUjfkj2EpEOCW1F9gwkrBEkY0B/U++CQ1nySyaMJhQYRB7JmrhXX8Jniaww9NQQ06b078QBc1Yh/krHlqgGf67EE0VS11Pc9GQ0sxXISL6ClXXUcViyBzstRjcgOTUvEpGIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=jJIMakZc; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="jJIMakZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420311;
	bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=jJIMakZcxlbV8Ybl4Auad0TDT3lBvL/RKO9V6WwdXme2Q2hfootp44qFASSeyHSOq
	 jyQmYPxwz7HOYwtq9ExGlA0L6CoV5ILOTCWUb63qrPtrBjHNpBjLtcrPl8gv6BXSHD
	 IEWNShN3D3yYl8F449fexjjLsUaZ9/zhum4ckwNClZyq5RiQvcqJUnYFRfxQy5okJh
	 OwDCZupK9Kjee5k+bwqFrcR62w0cNbAEQXQkEsWmradN9+91skF0arltt5C0IA8Ojh
	 M3FdzyayIlSzUkxwB8PbMsRBcyTRS22eVSF6flFdkxkM35dg1pP+gDSTWU40uGELLX
	 1ium59N5c1NYF6kNTT/+VzBQP71t/7MQkOZWF9I83epv7hMgTJO5EK5BNJ70Fo4efd
	 gtLm27J3RPZw92pX62HZYrMQIg/eE2cl0wluIXNv5j1oVu0ZzM/n6az4nRrtGsVPae
	 hgRJkuJyeeFscR4isjOQjJ5pIJ68ksO/uDZMGo0ktSWU0BvMdi6zOL2YO8o+n4ECWJ
	 hC6XFqXVpgUxO6rXFJtO126tn8AgXcgE3HtsI0iQvNTQiFDgpGIWsRdPuqPP+gPBsi
	 Wr/g5mD1qY1a4GoZoWImMvwEXH5gGlnwVVDcWXPkfqFn40jHtiUth7L+anN51ZRd7W
	 8b21CzZyocL89UtLm9gqUr/w=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:14 +0300
Subject: [PATCH RFC v3 1/6] rust/bindings: generate virtio bindings
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-1-1427f14d67e1@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=jbzi2Emj0Xf9BmoPlY0PU4j/8PVZ/5uK5OX2z0vqwIQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBSZk1GbzVEdFd3eWc3WEIrOSt5elYvbTR3CkJjSzZnSkZLVFptbUY4OHhi
 dWVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1VRQUt
 DUkIzS2Nkd2YzNEowSm5SRC85WVFtdlhCTDl5a21iRXhhMTVHZ21odlNWRERSNVYwa1duUk01Vg
 o2ZUFFeE9YWm1BK0t5eUhRNEFLellIdHBXS25hbjVwT01NcTI2YkhobTJHTUlFUVRlc2hRYnVwa
 DBKbC9VTktQCno0anFUVUlKRkc4MTRzR0hGdEZFUi93L1pNMWJiOW9mMVlJL3JpT0xta1RFbDRM
 ZVFwNE9GN2h6WTV5aXllRW4KTjdhNDhuOU1wVnkwbTE0THdTcWlLOEloQ3gycUJFTG9wUDdjOFF
 yM1FqWloyOHhzdjk5WGxEZUxkRkxaNHdSbApwZm9yU3JKaHNBQ2JkcWRkeUFJOEVwUURTb1Uwdl
 BZNGxGMUYvT1B2RE4ydzhFWkloWGFHTXBGRG5XUG0yODJZClJ4Y1RmK1h1N0dsTDNXWERWYkVEb
 VVHaGJwVk9jb3JRUldLZkxGSmFQZitTWUd6Q2h1UXU1WGF2U2dYVkZSVzgKZGtycWZTMXN2K29R
 SFFTR1hnVkVzQytZT1dPZ3VqbWk4SXQ1ak55SlV0dVUwNDUxT1RhdEhUQ0pBWVFCdmtOYgpkTDB
 BYVRQbGJ1UjhrcTV4cjlIRUQ0VlZhbTdOQ0Z6UkFySEFjaWd1ZVJzQStURGlBM2tpYVMzTzhIWU
 I5eE1hClZ5S0hpQnBmOHNGZ3YyemlwU01zNDZJWmFYajM1WUNyRXB3Nk9BUW5DQkIwc0tjdDVyS
 HF5TzluY3d0bWZsVk8KaGNTK1EyZ1dGSmd4RDl6bDBKZzVOYVFRVzhETlEwZkpDdXNHcStVZnRN
 RnhXRjJzZVZjWjJzMjEvdmRJVnZobApoRStSTi9KUjlBSTZLaHk2UTVOSTQxdXhPTGxhcm5YdVh
 LVjVhcjRST0VSM29UNWdyMnJpWVo1UVU5WkpHQUJHCkVXaFFSdz09Cj1xQ0dxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add virtio headers if CONFIG_VIRTIO is enabled.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/bindings/bindings_helper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952c2b29ab82d5d481063a1cf48bccf..1cbe1a4b5647fd646c1be3c5c80fb24ae7b97a4a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -151,3 +151,8 @@ const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 #include "../../drivers/android/binder/rust_binder_events.h"
 #include "../../drivers/android/binder/page_range_helper.h"
 #endif
+
+#if IS_ENABLED(CONFIG_VIRTIO)
+#include <linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
+#endif /* IS_ENABLED(CONFIG_VIRTIO) */

-- 
2.47.3


Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACD38F65C
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420322; cv=none; b=XkfvcTOBOB8mq8XqvosBylODD/YvbtLA/O0x6zMnLbjmzVEIbilWipGqw07DLVrlBKWF8aKwrtkPDK5Ge0R0Io3RXU1HuC65S5olVEjrYeGKrhcNNSqoPMCwo51gPiKnleZUKZMUmACmxBSLXggTBzC19lZzlnPEYbDkO62evqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420322; c=relaxed/simple;
	bh=hcTYlDg84gZsUt1opDAEy/hJk/exwjLlY5Z3TwHRPGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5g3kt0lHXYo8G0Ou1B4xfmcBcV2UX0Tl7VVo4JOlUpLwLCmuO8iIxkbaifDdXX0QFSz9izUrTd5sEUNYe0lNN9URWM3eqPJUev/UjjAClPJlFRU8DscamsTnXE5VqtVn4fPuFYRek/6A/tmKzSC+pKRqoiqSFUCOPivLbbpOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=tPEShpZz; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="tPEShpZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420314;
	bh=hcTYlDg84gZsUt1opDAEy/hJk/exwjLlY5Z3TwHRPGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=tPEShpZzjQzwhkTB5MUsoX4PaeYFzQAUxy2cjTA0rOJRhtsgzZDJYMiCxfshvDfj/
	 o3JQAs3vVh/nDvWQFhplIrC43zgmp6W0n2IlMsRiTD2sQonOXwW1uUzhCHlOZ+qurm
	 qbq46DWamJfe5Esd8WoI9cVOkyQ2WR4j6aIV7ZKVB9/2PqUvfUKOmLNt8MQqGe6O52
	 EIDTIPS+jJKU9Zu5vaNIDzU5olAGZ9N6B33jbJrWGYuvWVPwnlMx1t7hFxquGURVxQ
	 3OCUBf6Y439S2UumliFY0Dy+y7aIVyaRQXAap/qv3jTRaMOzvclIZBw1MxXEm0u2oc
	 JgRv51KXIU8nTu0aZeV/SY9R9qxqflbtPpepqFO3B7a4rAswO/YFLZZxVjYV+Wbh/W
	 HAgKN49gzL5fuKi/KfVsjRzvGrrJ+6TPLrvXL19Q1mOyHr9LA02TeLAaqOkv3BsS3o
	 vRaCpW1+AUPKLnjFfiovHGvW9DewWnsmOIiCByBOc4YQFDjdNjgzdplD8TZSTq2Ais
	 P1X5eC6GKcBvMDNjF+hjcKPQ1hy3QivqLyR8XH9Eb4moawb3vhneFhebSZ6TBtGK6g
	 EfjqG/Uqf1TpiLvup312PQwNk6mkyQLRmjBHle862poe45vXBxWIzzAkLLZris/sqE
	 miFjup22BCzQY3P8A7fZTW/0=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:16 +0300
Subject: [PATCH RFC v3 3/6] rust/kernel/device: return parent at same
 context
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-3-1427f14d67e1@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=hcTYlDg84gZsUt1opDAEy/hJk/exwjLlY5Z3TwHRPGc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBTY081VG9jamluSWVGRlRXS3R5NUtWaUIzCnZhNmZpSkNXajZiaThzZHYw
 c1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1VnQUt
 DUkIzS2Nkd2YzNEowT29FRC85bmZaTCtmVm9DeHpFWVdyZ3Bpc3JxUzN5Q05HTUpKTWZKMXdKMQ
 pWVi9NZG9rSVppU3pjdXJvZnhZZ1NMNUVRWFgyZDNKTmNDVWh5dzBCdytYNHIybDEwMFRnTm5QV
 TJyOFVNYVo4CkZoSCtaNFFORTNZVTZXNEZseDlVZWxNYVZMcWJ0dDRJK2p0MlI2TFdTc21xMEVa
 bGZnSHYyZlVxb3lsTUNsaDQKS0c2Y05Kb21hODNwelVheDVQME1zZXdJY2hKVTRvMCtUbklMcjd
 HOXg2ejQ4SHczb3U2N3FzSHNWVFF0MXhnawpNbkdDbVh2U3VVc0dxSkdiUngrMmZtVVdXTUNLMn
 VYMFdZNVhDTmlJeXpBeVlxNXNPQnhNU2pidnhaVnZWKy9kCmhIZzdhQzFSeGVxck5VaStxM1B4L
 0hKYVMzWWdud1F1ZG95QncrVDNra29LZHpiRzFMa01PL0JCZE9zMkhlNE0KZmN4ZlZtTlpTNlQ5
 TzJDKzFhdjdPMDUzSFIxc2pyZmtPTWFZUVN5M1V3amhBVkRPQmgreEE1VXFLejd2SnlHQwppWWt
 CU2EwbmJGaGFiTy91TW5GNk5ya0s5eTlFbG0rZDlwcVNMVGxaWTNxUklQZCtMZ24wODc2bHpLaG
 k4NEhqCkUzMFB0V1k3OFZVMGg0ZDhNMmJhVjhiS0w5bHVXOHM1YnFMRU5UdG96TEo0ZW9HQmU0Y
 UJQZnJmYTJNOHpKVEsKY0ZVZkd2M1djUEdTNGF4alNXcERoOUkycldZOHlReGhDWUZ5YnNtVER3
 QVcyR201dndveWVOdGloNithYWRrRwpyTlRaN01PUXN2dDRRdUNVTVF3NVJzTzE0VDcyU1RhQmJ
 2Y0IzRWdodTVQRFNmclk1V29ycVFzbjExVzJreVNaCklqZXNPQT09Cj1PVGlxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

The return value of `Device::parent` method was defaulting to `Normal`
context, instead of having the same context as `self`.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/kernel/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 94e0548e76871d8b7de309c1f1c7b77bb49738ed..07d2f1225cd87f4fc091a5d6cb626726ae175894 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -341,7 +341,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
 
     /// Returns a reference to the parent device, if any.
     #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
-    pub(crate) fn parent(&self) -> Option<&Device> {
+    pub(crate) fn parent(&self) -> Option<&Device<Ctx>> {
         // SAFETY:
         // - By the type invariant `self.as_raw()` is always valid.
         // - The parent device is only ever set at device creation.

-- 
2.47.3


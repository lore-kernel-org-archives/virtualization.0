Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A683EAC98
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968864; cv=none; b=IFk/Xt8HYX0r5un7ChzOCLAKjMPNV+Nz5ClP9JW3dDsOOEiazDLTs2Zn6KhjGLDeuFuEFDocS4Y1cqEUv71TCV5Xad8Fam3ihhsPe1XoWOaf55ldErNcZ05QsURxjY+rNlqQrwfwRXhg/qYMs3XJyNh50FqTwot7K5tSxtqQKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968864; c=relaxed/simple;
	bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7RgNT3tWYy0vhl6twwkcHm+qNUnKSiOFhnAV/UovRAPsFpNqbk+BEDcFeKeJ+icMZNifSoaOuVYdbLnbF/xULMoxA8dFhkdzytn594wr8jBMBVJMK9NKwHQp0APyfmyr/BM0WpNdRkfv3uHxQVAoszzDgP732NJvMJZhMg9POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=C6dS7Ggu; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="C6dS7Ggu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968859;
	bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=C6dS7Ggudn106qSECnCYEnw6zPdpuMkaMKISzw96hxICj3Smn/i23RwM2xeVpD7VR
	 VcrMEfy0VReJN75gSU8KDQ6A68wJxTGxkESAHTeatlc3zv19DLPkO+NJ93/KHCEB/L
	 qKNVa7KqHC8hd029QLBXfhmQqfAIS6M0kccBdXAhq3dGGvPC6bxItP0Iyti56GlfKH
	 fv5tnrKqhWth4uG/lhp8BoTBj4/8HW+7X4H1ZYy71VFH2672agSEwRSvIwZitgl4fo
	 3m0J+tVRmnU00sqkHt/5hy6j8U3pU4vYquDNf3wU/P4C1ilPwhOtCVs19CNH3wNTCD
	 HxamI4emAZFDfZMAOoiDC5LXPh8BW0FaFfvXnonTEcEBLG72H786lf6vqIF6SPGpY7
	 BGgGIim2Xc+t/ES6MEMDAMH0ZJpkoCScqspyyu8uzrGMaReOCZsqOGxtRi0PJyBR50
	 2t9NJKMxze8ETwLAl2aWjCZFL/OyTUe369MAPkE6MqUeQWInMH10AQesB0ewQHO+5C
	 MkIYwa/E7CPnNKIJ4ZF/7O5KC4RDfhkv/HSXeEeozXWBVm3DCP1+FhqGOIR8r6ISb0
	 DgXzpEczaNS+eyZloA7vLiBMCMybR3wp3CcZOm6GuQDEoGjwEfBS6yy9FTPvv/LFhu
	 31rUTyh//+4zgzEvJVjop7ng=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Tue, 05 May 2026 11:14:04 +0300
Subject: [PATCH RFC 4/6] rust/scatterlist: add SGEntry::init_one
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rust-virtio-v1-4-9563383909e4@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJUQUhMbGhZMXBuajBuNFlFTWZOT0x2NGQ5CnFLMEpPc2xqSFIwbWJ2Qlov
 M2VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTB3QUt
 DUkIzS2Nkd2YzNEowRWk3RC80OGZLakEvTHV3Vkd3ZkdYeXlHQW9uZzdkS042UjhWbVNtMEhiUQ
 pOWHpZTERjelM3elBCTVhMNkJLOFVXS2lqMVNKNTVOK2N3SDF5eFdpWDFzZ0t3V1N4NHZ1UzRmS
 2VlT2FvRmhhCkV6SHE5bCtsRC9kYzZkUU56UnJ5RFJNci9Wa1VUVjUyUk8zd3RPMUh2U0UraXl0
 OHRBTGdZazVPRVc2R1NiZjAKaGp5ZDhmWDFvaWtMOFBHMnJlWkdWMGtSMENtNURhY0lHbklVam9
 tL0Jrc0c2QUY4NnF4QnBrSzVHdHVMQ3lKRQpjNGNic0lEaVA5L1JSR0pvMDNKUWo2MkEwT0k1bU
 swaC9MejdqV1FwaTgyY0RUM0RMMGJ4Q1AraW82WkpwLzFnCmU4RVpuNFQ3Rkhtakd5VTlVdnhUU
 i9yTUlES1NFQXlud3pMcm9YZHFKK0owNXRKTTkyQ2RHVjZxQ2hUQ0dtSHgKWTFMdUlweGtQdUJO
 YUZXbEUrL0RaN290RmRMVVNBNll2MXBnbDh0WmlGTHp5Uk4xZHFzTjMxbUhpcm1EL1NWawpTZ1F
 4ZmwwWThSOHNYWXN0T1NnVGtOUjlvVzhpanF0dVB5MVdMOWlZalpNNVB2NG9FNHJEQVhWMys0Yk
 JMQVVHCmVDWDh5U3hQeE5JeEZ2ajlJZ1E3dm4wQloxWmxWL3R6N1lVaDZsbDNKMWpZdG1jaFI2Z
 1VyTEZvTGZUVGZHMWkKZ3h4MGJGYXhlaldDaFRhVFUrRldVZ25KL1VpQmxEYkllbWNEdys1RTFE
 aEFNODRmQlo4SmFDQXhmUEZIR2UyUgorV0hHU0NkSllyYlJueEgyZU00bmxsOXhmUXIxRGd0TG9
 QZWY3L0VmcUpkT2VXcmdxOGNWQWI1aDRKeWJXWGszCmxraEdsdz09Cj1PaDFvCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add a method to allow creation of an SGEntry with borrowed data.
Analogous of `sg_init_one` in C.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/kernel/scatterlist.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 146e738cbd4351b41c11dd39a45e20f404c5cd64..b065762af1a734fcdd5d3acde89199f1a626fd89 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -95,6 +95,24 @@ pub fn dma_len(&self) -> ResourceSize {
         // SAFETY: `self.as_raw()` is a valid pointer to a `struct scatterlist`.
         unsafe { bindings::sg_dma_len(self.as_raw()) }.into()
     }
+
+    /// Initialize a new entry with borrowed data.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `buf` is a valid pointer
+    /// - `buf_len` describes a valid allocation size for this pointer
+    pub unsafe fn init_one(
+        val: &'_ mut core::mem::MaybeUninit<bindings::scatterlist>,
+        buf: NonNull<u8>,
+        buf_len: u32,
+    ) -> &'_ Self {
+        // SAFETY: `val` points to a correctly sized `struct scatterlist`.
+        unsafe { bindings::sg_init_one(val.as_mut_ptr(), buf.as_ptr().cast(), buf_len) };
+        // SAFETY: `val` points to an initialized `struct scatterlist`.
+        unsafe { Self::from_raw(val.as_mut_ptr()) }
+    }
 }
 
 /// The borrowed generic type of an [`SGTable`], representing a borrowed or externally managed

-- 
2.47.3


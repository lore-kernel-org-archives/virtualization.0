Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43C39B95E
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338077; cv=none; b=b7rwxNaxb05N7AJKnW7LkcE23H4GdYk0eSkA8t6vuBBNhF+LAJiGMYT7ttgO8mWr8kNhV8CuabjXi4KX9gR1+c0m25RGRJcHG4oLFf53PFO/a2R6S0Vtuwp2CXnAm8/wS9d7E53kyRwiSJbT21sI0seleawaKbOTMMMNb/IFWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338077; c=relaxed/simple;
	bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYEdSsrFJfZJUigpJOthGb5Ew/DqNPxtCQZeSggJiSuAarP1VL/0siZhb7j01vHOexG6zYz/1Bpiu4RYr2YK1f4Ofn22EduPeGFvNaDLp97Ib4LB4J/u2V9PuWI79j8kDYMDF8e1oXpdcsSjXZIR49VWJZCsnkqrB6sxCzMQywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=041vrqZW; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="041vrqZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338059;
	bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=041vrqZWUzBncqPBFlJdGBaf3dfDPmwxTpDAISVR7NztU7ysAFahCK47tD1PwryF1
	 mducX7RaJSVRH7qAViJWfauPSR5dsSFXThHfYb4j4BXv1xicmwQOU7dqmVtt5IA0Lq
	 OdDNiElXI/BmgK1H/ONaviGaVbWPPgoaRNzykUMzm5GeWheT6SApDWVF2jCvOG67Yu
	 r55k82G6XI8Z8n613pEK7Nx0G7Tq+aiSbbbSX88nPHczcY47AxOuftKTWVs/lmeFCU
	 QG6gFypLWqDHlVMY+cOkaa6LzAePzvcNt46XvLOf2xamo3GXw4PCipTHlOshpTdwlG
	 F7++jPM04aQy/1ogRe5HFpR1aI+53tB9Jd3ZUBD0unbgO2qWGTxOc5Q9hk1NCmMiL8
	 /LGjYHgKR+je0/X4hgNtqztapwwX/OggNNRs7PKrFRY6xh2sWWeiJig6aC/3En6SRG
	 k/OUZhva4p/sB4K4iLrg/QxCReZmt38L6eeiQvyHm1jrnh1sTKPk4cv3BiRPbHSuwn
	 /vu592zLbCj34neeELnlbW55K7VDGCfGgHTzm0dAOUZvP4da5pUviXxo3CF/nYCG4d
	 jdWHuiq95E7RrKEkDeRNHqaVc+XCiV2ITvClhJOC79A+sB68Mwf7FRjLXuu7PNgoYs
	 JXiUknRouRR+q6YR1SM5cPcA=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sat, 09 May 2026 17:46:58 +0300
Subject: [PATCH RFC v2 4/6] rust/scatterlist: add SGEntry::init_one
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-rust-virtio-v2-4-c1e30ec2bd21@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=ueMYbnhP380gUpqP1QHJlQrrjstYCaH5Rry1n19OITA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtEWEpWU0t5ck92MUF3M1d3d2JZQnBZeHVBClpRVTJlanNMK2djZjVSdEth
 bGVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkF3QUt
 DUkIzS2Nkd2YzNEowRTRtRC85Z1M4dXpFZ0tzSGV2bXpxcGhoRzI0bmY3MkpIaFI1MHlYQzMrVw
 podkh4RFp0Q0Nvc1NTM2k1VHhxMFB4Y1BjYU1VV09pTWxGbm9RMGVvWEhZNGF4VnVDNFhQY2gwM
 TFMS1NhVHpOCnk0TGVSay84SExRUjV3Vlh6R09xbWhzVzlicmF4SmFtTTNmSnJQQVQ4dTZlaFcv
 Q3BOcEZFQy9rWHExU0FjOEwKNVV1SjZkNWduQm5DSUcxVlQ0OVRCTklIYmVnVWxTVlVqeDlCRnF
 PTllRcHRVc1NBZ0tLVTUrYUJjbmtjL0pDcgpGTHArUHhhTkNiRTVwUmxOR0FOamZoNklNTUo0U2
 VDT1Z1VGs0ZEZIMkpBOU5yV1VuWVlNa1RXdWhDWHc1cytUCnlNT3JlRGdqaFdzcHNoYjVCSGw4R
 3ZEdUQrMDQwT3F4ckxtb1k1T0pYSXU3MnBqemlwd0wrSkFrclNhQ2grdDMKczZrcGc3R0l6Q0FI
 b1paMUV5V0tsWjZmMHQzVms0QitsbllYY0owYTlNSWRFUUtBVGlnakZiQUUyVmI5aFF3Rwp2alF
 QaGdwMk5MZ1U2VDNydkVyNGpydnRFNzYxVG1wVzM5ekNpM0VOcEF1ZzB2OHB4R3BzZkMrdGg2aD
 MyOUo1Cmx2R2dCTTNyOVpjM2NhaVR3dGxRa2tIcVBHVGpReThJT25xeUY0UDYyVytQNXVRcjBYT
 GhaQ2FxM2x3aDRhZC8KMDdLc256cDluUTlWbTAyM1kzUHR5TFdjK2poYjI0ZjFaOTVvaDYyVk1C
 TFVDUWUzQXlTRkw5YmIzYlhoZEpFdAppY0wxTUJkazJPS3lyY0lqWkRBc2Q0cVp3ZkRUZ09LVTJ
 YN3c3QTI0QjFpYXM4RUo2djVFUHRqRmlhcmN3dXFXCkVDODZ1dz09Cj1mSVQ5Ci0tLS0tRU5EIF
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


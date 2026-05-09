Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C63932ED
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338069; cv=none; b=FD2DtLglZdg6QB9VRHerGWVWEWBPjartZQj2B+5eh7mWa7zc0HHNGVtfOJ8805hDA4nJtRqgmAr0tlksXFaWAuq/zejUusIaXSmnlKy5a3246XkxjtrxfGrQzdp4ZwcO/NtjQwPGDbePAjhFJesmdSe1jet8IhJuw/Uz8JpdrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338069; c=relaxed/simple;
	bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r17+zJ1981ebzmbxZnlJGROpxlG2JZ5m/p6q2TvS5GK9XQJL/V6a4Ou/Htz/7lcGSXUBnjHIluvAUeWIOR2DM0ED43DHSrYkgTibBrYm+BsZwpDohqYVMkGT7kvn6drZRLaE/OVNEcDMy+wQOrYxDKK+LZ3Vz9Au3pA9qJdk4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=f8/lrKaT; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="f8/lrKaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338060;
	bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=f8/lrKaTMcCTii+rlngRlNh/U5wabTkAP2Xy90gmNKBbCkbcQ96TMsjx5BZ7XGzxj
	 QlOCZaOh2H2wPFuRFQfvOJ3FXlYvEg/11tPpq1GmIy1/QmiTMisVQ26O+PCPSnKvC8
	 RB4rW9dZP7wzfpoOgpExQAuLi65Xo5SzM+IBKFMH6hXFVQUfLVhZWth0lMZX5zGKGp
	 zME9LgNYlmq+8LQ4ndTtKZSFFSjv7SlqmooufOhPRPbmDnycYXuDkDLXyLkVjhVKGt
	 h3P1EHZ1XKfHVPxTBacUc64xm5by3FQZZNTV68XZpTp0acDqr0yFqI0q5lgP775hRW
	 3ancI9ssStIaHUeoXNf8IaXKLDiMz1J2736m95b43znv/2Ii+oXLHLPaW+8d+z4OxC
	 Z83/GVeCj5eheWylMjgnaTOshBBCUBK5wCkKpwYTlnsVVeuq8Q2qjrGj1h3UwpBuV/
	 kqutD8jZvNavXnjAA9VTocqbJdVEdPNtVYwlTDTeljTzeiUpfdGMfBx2GyYzv13BtK
	 Z6SEGfLbqPl/i/rglOPMKwsZf1X5Sx7Fr1FfDupCTC4i1IqH3WM3DcaknKPuDXNno5
	 HdZukFeW93srb5/mF/gUYBAgMXseSJo2PC/2Kb9femNejXwSAOXHpwYDiNk+1UdvDs
	 da9REoOXH3wu8AS3+oG4I+vk=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sat, 09 May 2026 17:46:59 +0300
Subject: [PATCH RFC v2 5/6] rust: impl interruptible waits for Completion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-rust-virtio-v2-5-c1e30ec2bd21@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtFRUtzTG1uKzN2dWVTZ1RyQU9UUkRFVUduCjcwSEsrQktpMWdJU2RxWFNo
 SGlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkJBQUt
 DUkIzS2Nkd2YzNEowQ3M4RUFDUXI1a0FENTIrQS8rOHoxckRPalhoTG56U2FDR2tUWFZpUUJoOA
 ptT1lOTDRpbFBuNkZ1UER1QWtySkdYRDM3elFJNkhkaUI2ZEVJa1g0VFNsTXI0MG1Sd290TkZjb
 HRBU0xtNU5jCnlJK3gzWitmdUFtRVFWbUUrWlFMWnFPY1VmU0w4Mkt0VEd1eTZSNFFRWFVqUnly
 dXl1Q21IMW5KcHpWRXpzSHcKQmFCT1VxMmx1VUR1L1J4OHM4Z004eGNJNVRPTThDZ3haUVl0R3J
 KNk1VKzhkNmdiMU1QSXgzWTZFS3g1emdVcwovUDNzNWlGQmNTYlh4QzhsakJFK0JkaEt5S2ljZE
 syUE1WYW5YamtwYnRiWnh1bFZ0V0VvTnNnSWFoTGZieE9NCjJkNUFoNncxd0Y3eUFrTjFxUFRjW
 TQyTUxkU29zcVI2L1Q5NDlDdUpDS3NlbFp4c1hqWjhlc01zRVYvc241bEsKbGg5bHI5VGVFSkZZ
 dkNDemg2bzBhYUJpV2dXQjNUcmsybEl2ZEdqcXd6S0FqU0pNSlNWeTRnaWF2SVVZZ0t5TAp2M3J
 2YVR6VnJxb3QzQ3B5VVNyaE8zU0MvVkIzUm8rRzh2R1gwUWcxSVRXeG4vOVpHWURXOFBBUnA1bW
 ZMampnCjV3Vy80TlNzRUtZbG1JMkhWQkFtYytjY3BDNUc5cngrS1ZVSWFSaTVjMDlTZlE1dFdxL
 zhscEl4MzBtVGJaUXMKanluNUx6SG1KVDh1QkRnS2swdWhMZXNTeWpENUhmdHJ3Q1ZSN2lVN0VF
 R3NyaG1INHJEdFdUNW85NytWVit5cgpsV09OTmJTbHhpK2RycWJsN3ZzQWJHRThEOHZyYkdncEd
 SbWpDQm5pVFpKbm1zVnBoazdpR0RBamFLYTcxYnovClpOeCsvdz09Cj1IZk5iCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Allow Completion to wait interruptibly.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/kernel/sync/completion.rs | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3c7a3e0edf302c8f833bdc4415200..17c9e48a5359c0c885be9ebf6843e74d5abe56e5 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -6,7 +6,12 @@
 //!
 //! C header: [`include/linux/completion.h`](srctree/include/linux/completion.h)
 
-use crate::{bindings, prelude::*, types::Opaque};
+use crate::{
+    bindings,
+    prelude::*,
+    time::Jiffies,
+    types::Opaque, //
+};
 
 /// Synchronization primitive to signal when a certain task has been completed.
 ///
@@ -109,4 +114,39 @@ pub fn wait_for_completion(&self) {
         // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
         unsafe { bindings::wait_for_completion(self.as_raw()) };
     }
+
+    /// Wait for completion of an interruptible task without a timeout.
+    ///
+    /// See also [`Completion::complete_all`].
+    #[inline]
+    pub fn wait_for_completion_interruptible(&self) -> Result {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        let err = unsafe { bindings::wait_for_completion_interruptible(self.as_raw()) };
+        if err < 0 {
+            Err(Error::from_errno(err))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Wait for completion of an interruptible task with a timeout.
+    ///
+    /// See also [`Completion::complete_all`].
+    #[inline]
+    pub fn wait_for_completion_interruptible_timeout(
+        &self,
+        timeout_jiffies: Jiffies,
+    ) -> Result<Jiffies> {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        let ret: c_long = unsafe {
+            bindings::wait_for_completion_interruptible_timeout(self.as_raw(), timeout_jiffies)
+        };
+        if ret == 0 {
+            return Err(ETIMEDOUT);
+        }
+        match Jiffies::try_from(ret) {
+            Ok(ret) => Ok(ret),
+            Err(_) => Err(Error::from_errno(ret as c_int)),
+        }
+    }
 }

-- 
2.47.3


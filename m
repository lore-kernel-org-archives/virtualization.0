Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCF38F638
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420326; cv=none; b=qQ8l75fZCs99/je7ob+rANeqsFICoisaIll2aLSKoP/Trg09hygFjk5yHHlP49wzXH9CB/oepi6AmxnTfkzTzEcdvrUhS6vHcApnQ+H4PDJrr84aMgqTxt3KVcK7O+Dk1ZDUVuujuOSMYrP+mQ3GTJ/0HolkvtDJ/lRD/JZ9jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420326; c=relaxed/simple;
	bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YifQcD9PHB0JV2ZKgxboml6D9V5kihbIrR+TpJXRDcSOvK+p7IYpGkpOmt4DRCtbAOMzQwwA852S5bFQ1+oloFvLNRgNAenUBjG/r9PcJBfc+pjhDfMaj2BRvXNksyTDeBaMe20FD8cTil3hBOxbc3bPdtw8Bk7ldpgs/iy+ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=gLj+oYy4; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="gLj+oYy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420316;
	bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=gLj+oYy4O5i+m33NxYSFhA0eIGBoRBt6XpUYtMiRzEgkFRWNfC88dvUzvdchjg5Os
	 bYjT409u+zjnVrAmVm4AKXhKTmpTrbzB+nXZmFq8oi8YH8eM1qPEXGlkIP28AhxT/m
	 pBF7DCnnmod51igXs0MFZDtS/EqbTVhbNCqs8Ex1fAi5LMGQEw2IEkVuzexA7fxtU2
	 lULwiWSZNT/OlqzbCbLq5bcEkeotQ+jlxKpm86N4yhCwasL8vapgyexvyu4tWAn/go
	 mZyQZRfUeAjDDgqA0fEgOaL9joCKjehzk/AGWeWJ7fu6jjzYklcf7QYzv8oYnGNtc8
	 lgG+qugDTdEpgLEbb/bc1UBMesirur4yQByjGd7CpONu+Q0TuSZ4N5QLGagTFUvLbp
	 OkwC3CcBuQYUCXJMX53um51f6dPJ8z3KLyfVUOoOgd6l0acyJEzgbfpiQIHG5lKa2O
	 bq6ghgmPgRJUv9JHPxJ0Gr5+2MkPHKyeUnsqCS4Ac88lD5IshamK6Pg2P3mEXyBNXn
	 0G1KGd1rguQ3QCYFdZA5+T8dFzsZvfg6fvcn0/LLwwGJvIqpl59RrRfPB92XkNFthe
	 +nUA4kKoEsth/gz+o0fc7CFCWy7lsDdu4sDVAkIlGDzEYTaoCXWHsBvmqI0U6aJIVX
	 EoutaNAKlpozT6GCaMzXg4gA=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:18 +0300
Subject: [PATCH RFC v3 5/6] rust: impl interruptible waits for Completion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-5-1427f14d67e1@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=msIA3QDkNRl5CiYMJuFdB8gcwSF6bQ5gs2Bh4tXdmNA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBUanRweDRET2FzWmJPa1dkRDAydU42eEpVCk1wMFFVV3RVWHNrWHdXZWhz
 QldKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1V3QUt
 DUkIzS2Nkd2YzNEowRWVORC85UXdiOFJuU2J1Zi93dkhDekJ3L1J4cWdicGg5SjBZUURRR0lHNg
 pQazJGTnhXTVE0K1JVVTY4NURFM2ViTUdnbUxBL1NSUWFEL0ZkNkJrQzJTcll3dHl3NkVJYnNyV
 Wp2eWVzWHZVCnp0Zk53WWl3ZEgwZTVORjJQR1VaaXdDZkx2eFdFYTMxZk55SENyMTgzR2h0RHBU
 NU9mRUN5UXUxRXZpN2RkZlUKS0d0V2hweGhSYldMSGdkR2IvRncvNTErY1NEOWpzb29SYzVaQkc
 0cTlsWktFeWRBWXdsSHk3bWxUZUNORisyKwo1bjZHWXdYR0tUNjZoTkd6ZGl5N090MnBPVFZvbD
 lDODVYUnBKTUd4Y1ZWT3dmR04rbVdrOVNZSnJQRWx6VTdJCkh3WTg0d05UWmFoMzl6RGNYRDNVR
 DFEVEp2dmhTL0V6ZFFlSlNOb1pqbWFuTmp4NjlLL0NDeTE2NDB4enBUOGEKZWVNZ1FzU3VFRlRK
 dHRDNzFZbEIrak83bkd1Y1ZRbkdzWXVtalp3eXQyckVlUlR2Z3JiRHRMTWs2clJzeDkreAptM1d
 KUlRiY3FmQlBSWlkwb01Uei9mcVl2NDJrS2lRcjBvMlNQbUd6MmpNeDlZNi9IK3VoV01LMVNpdy
 tjMnU4CklCeW51WDZKYlZBbkdWOXFGM2czc0NYYW94N2F4MGRpVHRUS3FEMnVVNUN0a0JvcFdwQ
 1RlVUtGanpINHU0dVIKQ3VjQThkazVqYklhckRnYStTM1orbXZaL2piMjdWY2VPTEFRVVZKVGRs
 SG9UTnpDdE9SMmdlNHk4eGplaEgyTQpLdUdJZjZWUTlFWFJ0QzVVcUdBdVRwb2RkUXdXemtCajJ
 DMTB1ZE9EQkg4MkUvTndFYWp3bjFWcyt3dks1Wk96ClVnN2dTQT09Cj1MemZGCi0tLS0tRU5EIF
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


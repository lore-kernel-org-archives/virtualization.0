Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4F3EC2E0
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968864; cv=none; b=qFqKd4qEv4V2ujfVjGPsNELEbOl48CAUnFSHNIr7+NIJFjcckp+7A9C+AsRh/MpAk3ZLMjJwMS78+eN9VLOoPNqtAMEbdyxS7+X/lcVAkMCwCLzPTkD86kC//ki0GvWgh+k/B+Rck1+TXSPAHB3xl7jA/LAywGipZq/VyY5nVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968864; c=relaxed/simple;
	bh=kgKzIAsgVjpYWlipSjiAGnVMQwoh2Eyh3sSKdi6XpN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVu4Tx+YMtioRgAQVP7/lo4SUNCJFKpo4rI3LvdBYFwNpN49gfGd6NMdu+xlPDOG3vbjAEj5zU7Fs3SnjXYT2uxx3bkL9Hnls3PjO7RIspmupc2kRO9595FSHue3rYo5LGabDoEgW3bhvpBAO0TrQaWCorSnriT7kFhcr3kHJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=fmFKW74O; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="fmFKW74O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968861;
	bh=kgKzIAsgVjpYWlipSjiAGnVMQwoh2Eyh3sSKdi6XpN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=fmFKW74OaftEZbgGt3jLLjJEBdLTCZaqOlxp35uwnHxDQO4cHCmOvySCSfBw4WHx2
	 2NrxrCtHF6v26R7wwH9aRVqjP4V7oNLGmOav3oAcqIhpy+l5TZ8d0fW5VHJe1/LTuG
	 +W91OXczkWzLDWOwrgEu2euhdy9MvrKjVFKo2spFWxH4FHE0r0Hdhvpx/V1DXz/8Gg
	 1Bd5A+h9WIxiBV9EA4fbeHpITlbqhKUbx493AE9IgY6kAye2J7sWK7LO/XHWkF19VB
	 2Kmr0WdBCFlEGLZ0FF00aUXDarx2sWoJZcFLsf4NaD4ktUnmsF5RPvcEBs89mQiXcs
	 8wQ9zPOfuz0GZ8oYdEnv5jYk0PbIuC6ySNxgZsMit/53NAOLbq61YQ74jYCAa4joo/
	 ey0X2PQZ3/3bm+E2cXWSpB6hZO/jTrBThbP3qGkLWOm+drqXBg4pgso6Vs4MfFTbC0
	 aQ8/R/i1XmqrQ0wzuDa9JOYc9Pijwojwqhkz6iMjLwSst1CdhkLZfwpx7A0abLj0OR
	 jIzXGIoSk7eIgmDMC4dDMAinhV7rbczVnBDNyzHR40zjZ7b5AweouJzMkNNpk9gzY2
	 2bdVcv7qmMC4Sk5aXtoE1RHrKPG3SxsS3gDyo/I6z8Ch5IE/d7VZapDQceu4DQu2HL
	 k0PE6a3W3ifGx77d4EQRpjHA=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Tue, 05 May 2026 11:14:05 +0300
Subject: [PATCH RFC 5/6] rust: impl interruptible waits for Completion
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rust-virtio-v1-5-9563383909e4@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=kgKzIAsgVjpYWlipSjiAGnVMQwoh2Eyh3sSKdi6XpN8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJVUVZ2Y0t0c2hKMEpZR2NlZm0zd0VFN09KCnp0TE56ZzQxQkliRzFmbCt4
 RENKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTFBQUt
 DUkIzS2Nkd2YzNEowTUNrRC85YnZobERZZGpCZGZJbU14aGdjeXkrU24yQk5IUG5JUmw4ZUxuVA
 pNRTByNCtZeGJ0UG5iMDJnZzdWc0Z6RkNXVnFoalVFc1haVEx2cWxtTjN1Q2V2V1dLeC9ZNHdQT
 1lieHdHOWtBCmtqYlRyUkFVOU5HeW9YRm1OejAzcVJGQ254UjhOWmdTV1NjQ0p5VmJqMldnZUM3
 U3M3bFhybyt3eXgyWkg0TjcKTnptNDVHb0wrazNCa25md2J6VVBSSHFRWWxMRWVwNmtOZ051WGp
 GK2wvd2dBYkhBeUVvL2g1SnVBbXRkNlMwTgp5QzV2WGFMeUwzNE9QSXlCQWdoQnFWYSsrcnU2R0
 RPZkY5MXVVUTRjL2gySUhhcTlYa2ZHNGhHa01RcldOWmtjCllEVTUrNVZXZkFIdXo4YTA5aUEzT
 TlhZ1FpWXRjZXlXSzJCQzhDMStvVWxwZVVSSlB4bzJmREZtYWtESXYvY08Kbk5VMVF5akhBQ0ZP
 RUFiU3dtZC8xZTFoRXd5dFhSY1hlOFU2N3BrcHo3Q2Fqb1RkTkFCOU5oaWJaRkcvM09qUQpMbGh
 Ob3BOVk1yV0didGZEMC85aFhrQ0xTYkJDSlhRcHJrWjdyZlJwaWVrSVE5K29tRklyZGxnVnJGdm
 4wc1VoCnZmS2FLaDV3anhESjhKVkFyd0RHRlRiN21xZWxlSk1VK3cvYUZFRVBmTFdYbGd6ODh4K
 1JBYUtsUjdWYWdIQ04KZlp6akxEM2pXVy84ZTg3MnQwaGZZbVE1Y1ZBU3phT0VCZzhxQ0RQNDBj
 aU9VbEdsa0IxckcrNlIyWkF4Ti9KZwpvWE9BaW94Qk8wYzZJdC8zR3JGaWc3UHQwS2JuTjRrSEZ
 Fc0FwYnBBOVI3eElGVnZZajQxVC9JRUxzR2VRcFF1Ck9yVkN4QT09Cj1TOFFlCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Allow Completion to wait interruptibly.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 rust/kernel/sync/completion.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3c7a3e0edf302c8f833bdc4415200..958e26f00a8e645ab080cb5d8529e31ac3042dd0 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -109,4 +109,43 @@ pub fn wait_for_completion(&self) {
         // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
         unsafe { bindings::wait_for_completion(self.as_raw()) };
     }
+
+    /// Wait for completion of a task.
+    ///
+    /// This method waits for the completion of a task; it is not interruptible and there is no
+    /// timeout.
+    ///
+    /// See also [`Completion::complete_all`].
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
+    /// Wait for completion of a task.
+    ///
+    /// This method waits for the completion of a task; it is not interruptible and there is no
+    /// timeout.
+    ///
+    /// See also [`Completion::complete_all`].
+    pub fn wait_for_completion_interruptible_timeout(
+        &self,
+        timeout_jiffies: c_ulong,
+    ) -> Result<c_long> {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        let ret: c_long = unsafe {
+            bindings::wait_for_completion_interruptible_timeout(self.as_raw(), timeout_jiffies)
+        };
+        if ret == 0 {
+            Err(ETIMEDOUT)
+        } else if ret < 0 {
+            Err(Error::from_errno(ret as c_int))
+        } else {
+            Ok(ret)
+        }
+    }
 }

-- 
2.47.3


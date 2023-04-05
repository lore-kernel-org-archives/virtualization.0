Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439CCC76188
	for <virtualization@archiver.kernel.org>; Wed,  5 Apr 2023 20:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA9D84191A;
	Wed,  5 Apr 2023 20:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA9D84191A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=aMR4Oy+K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBsD036UGvaG; Wed,  5 Apr 2023 20:14:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0AC6B41903;
	Wed,  5 Apr 2023 20:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AC6B41903
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D98C7C0037;
	Wed,  5 Apr 2023 20:14:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002EAC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C238E82009
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C238E82009
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=aMR4Oy+K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlFAKAESAtIz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 182FB82011
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 182FB82011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dwlsalmeida)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id CF81D6603197;
 Wed,  5 Apr 2023 21:14:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1680725678;
 bh=Msw7QEEtZ+8jJUyb1J6l3LyE9/JSE7aFA2Xyrz/Kgk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aMR4Oy+KKxBNmZ0CKywbxKCyxfmHAvw+OZpqyGSCE6giSTjWLCxnIF8/Kq9m8mRYi
 3AjwJ6PMX56bADWvFvXhAwRbhEaIqFOZb9q+OpBGGdPwFpUHXsFicCNv3ghXnsIzz9
 gqxk1Rv2UwJ1KCU2Gpg0KdhYQoIfBD4EDGwHGBdJyN4uzJNMpWqN1m6AkCbmirvIN0
 f79FUdQrEt3VRydz2Z/EJSQPNR9pk7OQu389uyBGU+TkmkPXElnsJDx+kUEQ/Xx2PS
 fFYL8mVVo2Gi9ji6GzIKY3PgxILygTY6Q5TChsrV7p6SkXwrCTkDLCqMVj6QD7OEU0
 nfKIVafuEwGAw==
To: wedsonaf@gmail.com,
	ojeda@kernel.org
Subject: [PATCH v2 1/2] rust: add scatterlist support
Date: Wed,  5 Apr 2023 17:14:15 -0300
Message-Id: <20230405201416.395840-2-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405201416.395840-1-daniel.almeida@collabora.com>
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Daniel Almeida via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch adds a scatterlist abstraction. It is then used and tested
by the new rust virtio sample module.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/lib.rs         |  1 +
 rust/kernel/scatterlist.rs | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c20b37e88ab2..b23be69919cc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -71,6 +71,7 @@ pub mod net;
 pub mod pages;
 pub mod power;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod task;
 pub mod workqueue;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..fe036af13995
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist abstractions.
+//!
+//! C header: [`include/linux/virtio.h`](../../../../include/linux/scatterlist.h)
+
+use core::cell::UnsafeCell;
+
+/// Scatterlist abstraction over the C side `struct scatterlist`.
+pub struct Scatterlist {
+    /// The C side `struct scatterlist`.
+    inner: UnsafeCell<bindings::scatterlist>,
+}
+
+impl Scatterlist {
+    /// A wrapper over the C-side `sg_init_one()`. Initialize a single entry sg
+    /// list.
+    ///
+    /// # Safety
+    ///
+    /// Caller must ensure that `buf` is valid and `buflen` really
+    /// represents the size of `buf`.
+    pub unsafe fn init_one(buf: *const core::ffi::c_void, buflen: u32) -> Self {
+        // SAFETY: There are no references or function pointers in this
+        // `Scatterlist`.
+        let mut sg: Scatterlist = unsafe { core::mem::zeroed() };
+        // SAFETY: we pass a valid sg entry, which points to stack-allocated
+        // variable above. `buf` and `buflen` are presumed valid as per this
+        // function's safety requirements.
+        unsafe {
+            bindings::sg_init_one(sg.inner.get_mut(), buf, buflen);
+        }
+
+        sg
+    }
+
+    pub(crate) fn inner(&self) -> &UnsafeCell<bindings::scatterlist> {
+        &self.inner
+    }
+}
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

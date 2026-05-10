Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E21F78E6
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420334; cv=none; b=UxSdTs8EcXn/JeS6wNV+SjzD7xeR76eYdukvRD8raHJ8NfaoQn/ywMZNIjJSrS4fJnEej+cntWNkInGoJUFu0euPm11KabnWDEqq5B+u4lUFC2zXyVv9RpFx3Wr+RSx6Y4CGkmvYMzAi6vo2ec3RhW2JQaI7s3ctJ+sGWytvcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420334; c=relaxed/simple;
	bh=izTjslYQ1hggeS4KUt9UbBQEx214atZEccKQMZepSbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iz/5oNAivTtAxWIwA/m/gi2wsQv2xMhlQJodZreJ7F7WOvO2RYwcQNOfltZRH61CYWxtjkWDhurCfkARYnAjydB3d15AwO0uRB06VZDaId/g2xWrPH/ra9w66faF7SVFH+Zdr9I54Whh+FysEDyBeaH6r2R2UZXCzx82hXCamF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=G59d1N99; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="G59d1N99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420317;
	bh=izTjslYQ1hggeS4KUt9UbBQEx214atZEccKQMZepSbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=G59d1N99Ntymc366RcCFcGbR1AgrEB+gDbWlHeEP5lu9Ch02oQiMruehowPJ96M/H
	 kYUauCiMnmserbt9/XbgYK+qWJgQWkQJxk0W+EJkgsFwHke2Kv039Qi9N3tNeqHP49
	 yje+NQLnwo07OXXQ9JZGDc758pvGAmxCmRtKuCLMIM0M4qiD7ud/xHhA32+xz2Nj47
	 epZE2C6sd80NSeaOTJdJrXl34BYyjpiBLemUxQEGgTY2hdggf3I9m6M/9YtggdW11J
	 RC6bSl5sLOm8OWGx4/UGwkd/S3Ghdqupy1ymjHy6kv4S78IcA4DznZyKsMo7Fl+Kqz
	 asS7d64klRDoWoG16DPflH940uSseoaPC+a0m8MaXUutissLnoGu3V5MSxVq7OCjM9
	 y8EXsnryeF/N0CrI6U0U0u702U6Z3glfVjBvYz/0QTut0wPeIsiK3STZ8UTxPdSF0N
	 /Ov/Q0ufbMyVoBfu+l2QGUkLHuF0srv0EjXBlTu3DUddk5/X1fuaW8fj8dp3EjBLdp
	 7FNliig9D2Wpt7r6zP2LWhWSMdIezdNxPtJxXuvo5jNEV1RYPKDP6c8tY73R5GhXUJ
	 esVV7adMWiPcytpcIi1UsFaRZPHOjgfxiN92+aJa+NSGOfgog21zNGXwEUf+E81jYO
	 n+3ZVIF8QiIr+7p2FvjwNXU4=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:19 +0300
Subject: [PATCH RFC v3 6/6] samples/rust: Add sample virtio-rtc driver
 [WIP]
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-6-1427f14d67e1@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15020; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=izTjslYQ1hggeS4KUt9UbBQEx214atZEccKQMZepSbI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBUSS9QN29xUEJVeDV0UWFTbzYvYSt2dWVLCkw5NCtOMkR0RUxuUm9rQ0g2
 eVNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1V3QUt
 DUkIzS2Nkd2YzNEowRE83RC80MnhvMGZKbkYrSnhiUE5BSDZGNER1L2hFTUlqQUtqdGlGYXlWcA
 pnRjQ5ek5HOUhBcmF2ZlE0YjVlNXhMY3hsNlFMYzVzdmNhVzh0T0MxV3JhVXB0T1ArTmprc0JWR
 VMrUnUvWDhZCmZYc2dNbklxSHVkSGlab0txREJGaitQV0tIQnNNNFFqdjlkZ3dsUTBKTnV0TjAx
 VEtBcE4wOEZkVmtpRXkybTUKa2hLLzZTU2M2SHVFTkxkUXFQRTVGUWVQdXhWK2V5NHE4VW5haHp
 OcFArUnNHRFlGaW9XRUxQbGl2Umd1NmU4RgpYcndUM3c2WURtZ2V0RFM0UXlENHlxTmRnb1NwWk
 pDczhEREhLU3c5amMzeUxReHdDRFVkdUhkeDdVbG84b1NHCkhPK0grOFdZbyszbXAza0JBZW9Za
 0dDcldUWjFvbXFnZWxPc09kY0RxZHROZEkvOEtzVGU5NUtMc2JMUlVTcW0KeXdXekpEYmVkKzNj
 dUZrWkV1aEhjVWRzbTA3ak9pY2lTSTg1SER6Q2luMVcwaytpNXdyd0R4SWp6aWhzK2YrQgpsL2l
 JQTVJcmZPbVpxWTdLMElnakZqNUFqeHVxM0h2dTAwdmQ5NXFzZmZ6V2ZpOS80SzBNMzcrTTNMNk
 VRUFRpClVNVXQzdU1kaUJlMEdwRnVITE1idnJNR2xIZjNHQUQxdy93Ty9Gc0ZoQXdacGxkMzRCY
 243NjcyNHFkc0djd1AKU0pPTUhZajFaS0JnakVsdUNVM202WDhuYXNiT3FUUlcvR1JaQWhaNnZ6
 ZFUvZi9IT2lLWTV0MS9KYU1BNmloMQpQOVkyeVUwd091OERnNGtuaS9KZjdzbHNZSmlLTWg0aVN
 2TFdaVjZodUE5MzFzMFRCMmJlUHlkQk1SaTZHTGJlCm03M3FIdz09Cj1Ic1k3Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

While the driver queries clocks and capabilities for each clock, it
doesn't actually register them yet (TODO).

Until I implement missing functionality, there is some dead code and
some missing SAFETY comments.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 MAINTAINERS                     |   1 +
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 420 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e8012f708df5d4ee858c82aec3269e615fc8caad..3ed579e8d3cc64d1749cf261cd68f6338a830c4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27937,6 +27937,7 @@ S:	Maintained
 F:	rust/helpers/virtio.c
 F:	rust/kernel/virtio.rs
 F:	rust/kernel/virtio/
+F:	samples/rust/rust_virtio_rtc.rs
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c49ab910634596aea4a1a73dac87585e084f420a..96a16aecc27198fd99f4ffd0ecdf0bc0876860c6 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -179,4 +179,19 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_VIRTIO_RTC
+	tristate "Rust Virtio RTC driver"
+	depends on VIRTIO
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	 This driver provides current time from a Virtio RTC device. The driver
+	 provides the time through one or more clocks. The Virtio RTC PTP
+	 clocks and/or the Real Time Clock driver for Virtio RTC must be
+	 enabled to expose the clocks to userspace.
+
+	 To compile this code as a module, choose M here: the module will be
+	 called rust_virtio_rtc.
+
+	 If unsure, say M.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 6c0aaa58ccccfd12ef019f68ca784f6d977bc668..0142fd8656bb8cdc95b7ef54e3183b5e51358954 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
+obj-$(CONFIG_SAMPLE_RUST_VIRTIO_RTC)		+= rust_virtio_rtc.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_virtio_rtc.rs b/samples/rust/rust_virtio_rtc.rs
new file mode 100644
index 0000000000000000000000000000000000000000..81f8b377f6c92716c17ea11542fb4262cfd90e1c
--- /dev/null
+++ b/samples/rust/rust_virtio_rtc.rs
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust virtio driver sample.
+
+use core::{
+    ptr::NonNull, //
+    sync::atomic::{
+        AtomicU16,
+        Ordering, //
+    },
+};
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    new_mutex,    //
+    new_spinlock, //
+    prelude::*,
+    sync::{
+        Completion,
+        Mutex,
+        SpinLock, //
+    },
+    virtio::{
+        self,
+        utils::*,
+        virtqueue::*, //
+    },
+};
+
+use pin_init::{
+    stack_pin_init,
+    stack_try_pin_init, //
+};
+
+#[pin_data]
+struct Token {
+    resp_actual_size: u32,
+    #[pin]
+    responded: Completion,
+}
+
+#[derive(Copy, Clone, Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_req_head")]
+struct ReqHead {
+    msg_type: Le16,
+    reserved: [u8; 6],
+}
+
+#[derive(Copy, Clone, Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_resp_head")]
+struct RespHead {
+    status: u8,
+    reserved: [u8; 7],
+}
+
+#[derive(Copy, Clone, Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_resp_cfg")]
+struct RespCfg {
+    head: RespHead,
+    /** # of clocks -> clock ids < num_clocks are valid */
+    num_clocks: Le16,
+    reserved: [u8; 6],
+}
+
+#[derive(Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_req_clock_cap")]
+struct ReqClockCap {
+    head: ReqHead,
+    clock_id: Le16,
+    reserved: [u8; 6],
+}
+
+#[derive(Copy, Clone, Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_resp_clock_cap")]
+struct RespClockCap {
+    head: RespHead,
+    clock_type: u8,
+    leap_second_smearing: u8,
+    flags: u8,
+    reserved: [u8; 5],
+}
+
+#[derive(Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_req_read")]
+struct ReqRead {
+    head: ReqHead,
+    clock_id: Le16,
+    reserved: [u8; 6],
+}
+
+#[derive(Copy, Clone, Debug, Zeroable)]
+#[repr(C)]
+#[doc(alias = "virtio_rtc_resp_read")]
+struct RespRead {
+    head: RespHead,
+    clock_reading: Le64,
+}
+
+#[repr(u8)]
+enum ClockType {
+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC")]
+    Utc = 0,
+    #[doc(alias = "VIRTIO_RTC_CLOCK_TAI")]
+    Tai = 1,
+    #[doc(alias = "VIRTIO_RTC_CLOCK_MONOTONIC")]
+    Monotonic = 2,
+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC_SMEARED")]
+    UtcSmeared = 3,
+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED")]
+    UtcMaybeSmeared = 4,
+}
+
+/// Send a message and receive reply
+fn send<Request: Zeroable + 'static, Response: Zeroable + Copy + 'static>(
+    req_data: Request,
+    vq: &SpinLock<VirtioRtcVq>,
+    timeout_jiffies: c_ulong,
+) -> Result<Response> {
+    // FIXME: This lock should also disable irqs.
+    let guard = vq.lock();
+
+    let req = VBox::<Request>::new(req_data, GFP_KERNEL)?;
+    let mut resp = VBox::<Response>::new_uninit(GFP_KERNEL)?;
+    let resp_ptr = NonNull::new(resp.as_mut_ptr()).unwrap();
+
+    stack_pin_init!(let token = pin_init!(Token {
+        resp_actual_size: 0,
+        responded <- Completion::new(),
+    }));
+    stack_try_pin_init!(let req_sgs = guard.reqvq().new_readable_sgtable(req, GFP_KERNEL));
+    let req_sgs: Pin<&mut _> = req_sgs?;
+    stack_try_pin_init!(let resp_sgs = guard.reqvq().new_writable_sgtable(resp, GFP_KERNEL));
+    let resp_sgs: Pin<&mut _> = resp_sgs?;
+
+    guard
+        .reqvq()
+        .add_sgs(&req_sgs, &resp_sgs, token.as_ref(), GFP_ATOMIC)?;
+
+    if guard.reqvq().kick_prepare() {
+        guard.reqvq().notify();
+    }
+    drop(guard);
+
+    if timeout_jiffies > 0 {
+        token
+            .responded
+            .wait_for_completion_interruptible_timeout(timeout_jiffies)?;
+    } else {
+        token.responded.wait_for_completion_interruptible()?;
+    }
+
+    if token.resp_actual_size as usize >= core::mem::size_of::<RespHead>() {
+        // SAFETY: all response types contain a `RespHead` header at the start.
+        let head: &RespHead = unsafe { resp_ptr.cast().as_ref() };
+        match head.status {
+            0 => {
+                // OK, do nothing.
+            }
+            1 => return Err(ENOTSUPP),
+            2 => return Err(ENODEV),
+            3 => return Err(EINVAL),
+            4 | 5_u8..=u8::MAX => return Err(EIO),
+        }
+    } else if token.resp_actual_size as usize != core::mem::size_of::<Response>() {
+        return Err(EINVAL);
+    }
+    // SAFETY: we have checked that the device wrote the correct amount of bytes for this type and
+    // has returned a successful status code.
+    let resp = unsafe { *resp_ptr.as_ref() };
+
+    Ok(resp)
+}
+
+const VIRTIO_RTC_REQ_READ: u16 = 0x0001;
+const VIRTIO_RTC_REQ_CFG: u16 = 0x1000;
+const VIRTIO_RTC_REQ_CLOCK_CAP: u16 = 0x1001;
+
+struct VirtioRtcVq {
+    inner: Virtqueues,
+}
+
+// SAFETY: `VirtioRtcVq` is safe to be send to any task.
+unsafe impl Send for VirtioRtcVq {}
+
+impl VirtioRtcVq {
+    fn new(inner: Virtqueues) -> impl PinInit<SpinLock<Self>> {
+        new_spinlock!(Self { inner })
+    }
+
+    fn reqvq(&self) -> &Virtqueue {
+        unsafe { self.inner[0].as_ref() }
+    }
+}
+
+#[pin_data(PinnedDrop)]
+struct VirtioRtcDriver {
+    #[pin]
+    virtqueues: SpinLock<VirtioRtcVq>,
+    num_clocks: AtomicU16,
+    #[pin]
+    registered_clocks: Mutex<KVec<()>>,
+}
+
+#[pinned_drop]
+impl PinnedDrop for VirtioRtcDriver {
+    fn drop(self: Pin<&mut Self>) {
+        pr_info!("Remove Rust virtio driver sample.\n");
+    }
+}
+
+extern "C" fn vq_requestq_callback(vq: *mut kernel::bindings::virtqueue) {
+    // SAFETY: The kernel called this virtqueue callback and it must have provided a valid `vq`
+    // pointer
+    let vq = unsafe { Virtqueue::from_raw(vq) };
+    let dev: &virtio::Device<Bound> = vq.dev().expect("Could not get device");
+    let data = dev
+        .as_ref()
+        .drvdata::<VirtioRtcDriver>()
+        .expect("Could not borrow drvdata");
+    data.process_requestq();
+}
+
+impl VirtioRtcDriver {
+    /// Submit `VIRTIO_RTC_REQ_CFG` and return response (`num_clocks`)
+    fn req_cfg(&self) -> Result<u16> {
+        let head = ReqHead {
+            msg_type: VIRTIO_RTC_REQ_CFG.into(),
+            reserved: [0; 6],
+        };
+        let response: RespCfg = send(head, &self.virtqueues, 0)?;
+        pr_info!("Got response! {response:?}\n");
+
+        Ok(response.num_clocks.into())
+    }
+
+    fn process_requestq(&self) {
+        let mut cb_enabled = true;
+        loop {
+            // FIXME: This lock should also disable irqs.
+            let guard = self.virtqueues.lock();
+            if cb_enabled {
+                guard.reqvq().disable_cb();
+                cb_enabled = false;
+            }
+            if let Some((token, len)) = guard.reqvq().get_buf() {
+                drop(guard);
+                pr_info!("process_requestq got buf {len} bytes\n");
+                let mut token = token.cast::<Token>();
+                // SAFETY: pointer points to a valid Token that we have added to the virtqueue.
+                let token_ref = unsafe { token.as_mut() };
+                token_ref.resp_actual_size = len;
+                token_ref.responded.complete_all();
+                pr_info!("process_requestq ok\n");
+            } else {
+                if guard.reqvq().enable_cb() {
+                    return;
+                }
+                cb_enabled = true;
+            }
+        }
+    }
+
+    fn clock_cap(&self, clock_id: u16) -> Result<RespClockCap> {
+        let req = ReqClockCap {
+            head: ReqHead {
+                msg_type: VIRTIO_RTC_REQ_CLOCK_CAP.into(),
+                reserved: [0; 6],
+            },
+            clock_id: clock_id.into(),
+            reserved: [0; 6],
+        };
+        let response: RespClockCap = send(req, &self.virtqueues, 0)?;
+        pr_info!("Got response: {response:?}\n");
+        Ok(response)
+    }
+
+    fn read(&self, clock_id: u16) -> Result<u64> {
+        let req = ReqRead {
+            head: ReqHead {
+                msg_type: VIRTIO_RTC_REQ_READ.into(),
+                reserved: [0; 6],
+            },
+            clock_id: clock_id.into(),
+            reserved: [0; 6],
+        };
+        let response: RespRead = send(req, &self.virtqueues, 0)?;
+        pr_info!("Got response: {response:?}\n");
+        Ok(response.clock_reading.into())
+    }
+}
+
+impl virtio::Driver for VirtioRtcDriver {
+    type IdInfo = ();
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: virtio::IdTable<Self::IdInfo> = &VIRTIO_RTC_TABLE;
+
+    fn probe(vdev: &virtio::Device<Core>) -> impl PinInit<Self, Error> {
+        let vqs_info: [VirtqueueInfo; 1] = [
+            VirtqueueInfo::new(c"requestq", false, Some(vq_requestq_callback)),
+            //VirtqueueInfo::new(c"alarmq", false, vq_callback),
+        ];
+        try_pin_init!(Self {
+            num_clocks: AtomicU16::new(0),
+            virtqueues <- {
+                pr_info!("Probe Rust virtio driver sample.\n");
+                let vqs = match vdev.find_vqs(&vqs_info) {
+                    Ok(vqs) => {
+                        pr_info!("Found {} vqs.\n", vqs.len());
+                        vqs
+                    }
+                    Err(err) => {
+                        pr_info!("Could not find vqs: {err:?}.\n");
+
+                        return Err(err);
+                    }
+                };
+
+                VirtioRtcVq::new(vqs)
+            },
+            registered_clocks <- new_mutex!(KVec::with_capacity(0, GFP_KERNEL)?),
+        })
+    }
+
+    fn init(&self, vdev: &virtio::Device<Bound>) -> Result {
+        let num_clocks = self.req_cfg()?;
+        self.num_clocks.store(num_clocks, Ordering::SeqCst);
+        for i in 0..num_clocks {
+            let mut is_exposed = false;
+
+            let resp = self.clock_cap(i)?;
+            let (clock_type, leap_second_smearing, flags) =
+                (resp.clock_type, resp.leap_second_smearing, resp.flags);
+            if cfg!(CONFIG_VIRTIO_RTC_CLASS)
+                && (clock_type == ClockType::Utc as u8
+                    || clock_type == ClockType::UtcSmeared as u8
+                    || clock_type == ClockType::UtcMaybeSmeared as u8)
+            {
+                // TODO:
+
+                // 	ret = viortc_init_rtc_class_clock(viortc, vio_clk_id,
+                // 					  clock_type, flags);
+                // 	if (ret < 0)
+                // 		return ret;
+                // 	if (ret > 0)
+                // 		is_exposed = true;
+                dev_warn!(vdev.as_ref(), "CONFIG_VIRTIO_RTC_CLASS TODO ");
+            }
+
+            if cfg!(CONFIG_VIRTIO_RTC_PTP) {
+                // TODO:
+
+                // 	ret = viortc_init_ptp_clock(viortc, vio_clk_id, clock_type,
+                // 				    leap_second_smearing);
+                // 	if (ret < 0)
+                // 		return ret;
+                // 	if (ret > 0)
+                // 		is_exposed = true;
+                // todo!()
+                dev_warn!(vdev.as_ref(), "CONFIG_VIRTIO_RTC_PTP TODO ");
+            }
+
+            if !is_exposed {
+                dev_warn!(
+                    vdev.as_ref(),
+                    "cannot expose clock {i} (type {clock_type}, variant {leap_second_smearing}, \
+                    flags {flags}) to userspace\n"
+                );
+            }
+            let clock_reading = self.read(i)?;
+            pr_info!("#{i} clock reading = {clock_reading}\n");
+        }
+        Ok(())
+    }
+
+    fn remove(_: &virtio::Device<Core>, _this: Pin<&Self>) {
+        pr_info!("Removing Rust virtio driver sample.\n");
+    }
+}
+
+kernel::virtio_device_table!(
+    VIRTIO_RTC_TABLE,
+    MODULE_VIRTIO_RTC_TABLE,
+    <VirtioRtcDriver as virtio::Driver>::IdInfo,
+    [(virtio::DeviceId::new(virtio::VirtioID::Clock), ())]
+);
+
+kernel::module_virtio_driver! {
+    type: VirtioRtcDriver,
+    name: "rust_virtio_rtc",
+    authors: ["Manos Pitsidianakis"],
+    description: "Rust virtio driver",
+    license: "GPL v2",
+}

-- 
2.47.3


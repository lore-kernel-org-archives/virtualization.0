Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5266229B12
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338069; cv=none; b=oSb/MB0eD5DnnLGhYsnOoQtWvnrw50u7fcsT2/95J/8GwJAS02KTdjK4RY/LuHRcE5WfG1hS6WXEyzoqD+2JHQQDoZesriHynyadaliqedSlqGTh9SNLh/TxSK2YxoyvqY8AZCq6MZkGb2smgB0gWQ8PZ5okpSTgxedw7AUqnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338069; c=relaxed/simple;
	bh=qckb076ZLmkTQMnhHO2Rcg5+MGTrGKXQy+PoUjxrU9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jU+lpqc6j7i3PCAgwAzB5aDUb03vciUxCpb2nwnbP1bnThVOXE6aynz9VT6JxM6SXbfaL9U7NE445G/O4gwF0KHfa/NJ+E0SPokdJkmIssTb6QR4tz+gnIA8dYsjULEdTEymitonr2OJkUimP7LelP9TsO8ZYdjGqeQ8WYYCN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=bdk9jD68; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="bdk9jD68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338061;
	bh=qckb076ZLmkTQMnhHO2Rcg5+MGTrGKXQy+PoUjxrU9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=bdk9jD68JrO/z3i34PuuuegbI3dondByP+6XagvCs945CbpbRJMDpjDlJdZATBevc
	 2jHcRXT9gZ+4Wq3gCO+g+YuYpRGWkwY9XWrsmzNRQnoRpz5hVx1T5urPk5oIl+aEXP
	 /xOBnnAVQqXYrXUwY/jruqJ9Afd37gA4sIVHPKUa7H1FS53ocLzb31vjhMdztDpLum
	 ZXumQCn4njkqoPSijkp+gEI9BT2APz9LY7XxQZjUoGTNOn2vQCoinij5hJT0Iq4Vfs
	 p65AqurQg5ckQXGL/lFAjhjc6rYeZxFTiLWig5ccYvG8q6R5mveta5/xfW6v4A/A93
	 IQl74MGDsJpaWjdJ2QE3UsxHXPijNCxp5d8CP55329DMzn1jxs9HHq/6678MLG6ajD
	 lVZmAbWQAV0TI6iQTik1K4uIzGDh8aH3MJLFF849KkU6lC48c+iJz4h1VKZEF5PPD+
	 Q9LUnCHo9sHbOBpFKtSTqq4s84SvreMhluJciW0fbjjCkspvBD8yDKxVn/GPv7KwNj
	 2r3yfO0eyKgNr8wqWV+5KQVRceTZB7OaawCIOR3ZLUwt0oqGJfOSNLwafmBT2mY4Bp
	 mdne5N99ZkHJSqii/Ubvgk25Kwmg16/KM+4Vlmios2MimPjoRewJ/CXMwnG068NGoE
	 /AfqXTaVNMufgcl5Vv7ttf48=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sat, 09 May 2026 17:47:00 +0300
Subject: [PATCH RFC v2 6/6] samples/rust: Add sample virtio-rtc driver
 [WIP]
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-rust-virtio-v2-6-c1e30ec2bd21@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18156; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=qckb076ZLmkTQMnhHO2Rcg5+MGTrGKXQy+PoUjxrU9U=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtFVmNEYnNZYUVKR1NjcmJrN0RQL1h2Z0ZnCkwwZUlmbHR5dENLNCtiTXNQ
 V2FKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkJBQUt
 DUkIzS2Nkd2YzNEowRGN6RC85dHB0RVQvN2Zlb3FlMEJqU01ITG5DVEtTdU10bWphdGZiZnpDTQ
 orbHhSNTAvYkM2SW9wK1cxczVvdk42VFFaWWc1TmwrWjNaOXhtNTVyWUxhSTFIbFRuZXVYeFpZO
 E9JdnV3TU53CkkyWllScWVackRJV0NmNENhMkdvaU1TNGo5VUprUzN4bmdsdnNZdUlEOHNYczZ2
 N1kzQWNQM25mQ29VTVAwdEQKSHhzamFab3ZWdDdsYzZWNEJ4YXNLVU56NElZSzZXczBKbUhoZEx
 mN0NqS0YybmtMaDNYWGZUcCtmcG9YRXl3UApJek9yTTVjOXo3QThCdFp3WU9PTDlLd3JoSU85YV
 RFazRqMGpqLzQvL1VManR5U1M0TjAwV2Y4Qm9pT1B4QlgxCmNnN1gvbk5DRG5OUDJVNGx1UUNkc
 Ws0RTU2MXFXWlo5cFBlcWtEOXgyakh3Wk5Ib3Zra2t1ZGQ4dVdoMEg4WGcKZzQwam0wSUxJdXVh
 ZUJJaW9LM0M2eEYrY3JtSXc2MUFwQkdEeXVydkZlZW5uZWl3M0I0V0VwMkpPOXhWdjErOQo0d2t
 yZ1FtT3lXRVZzaWVrcXJCZUtneFRRSEFmdnA2bHVJYnM2K0VXc2NrMVBRL015cTlWbkJsYW1ic2
 hVdm9pCklJczRIMlVzM3B6RmplaUpuamFHM2JVVzRPRmpOSW5aN2h5ckE4YWJma3FRZEcwRG1MN
 EpEU2l4UU5iWmJZZzkKdXdhd1BhWHNENzcvUXZCNlBzOUxxNEIydGUvYWZOMTNDMi9TcGpRa05I
 UXdyZmFNSzVrSnNKVkVOREFpcXY4TgpTOUZBVUJSRWlUeUduVUozdUZGWWtNbVZ0cDB2RmFFWGg
 4bWRCVkdHbGhQaTQrL3R6SDNxQ3NsMU9VTHBEYjFCCm9lcGR2dz09Cj0xT2ljCi0tLS0tRU5EIF
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
 samples/rust/rust_virtio_rtc.rs | 491 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 508 insertions(+)

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
index 0000000000000000000000000000000000000000..b12b188d4b1e91546a0c23558d747033747ff3a9
--- /dev/null
+++ b/samples/rust/rust_virtio_rtc.rs
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust virtio driver sample.
+
+use core::{
+    marker::PhantomData,
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
+    page,
+    prelude::*,
+    scatterlist::SGEntry,
+    sync::Completion,
+    sync::{
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
+use pin_init::stack_try_pin_init;
+
+#[pin_data]
+struct Token {
+    resp_actual_size: u32,
+    #[pin]
+    responded: Completion,
+}
+
+#[pin_data]
+struct Message<Request: Zeroable, Response: Zeroable> {
+    msg_type: u16,
+    #[pin]
+    req: KVec<u8>,
+    #[pin]
+    resp: KVec<u8>,
+    req_ptr: NonNull<Request>,
+    resp_ptr: NonNull<Response>,
+    #[pin]
+    token: Token,
+    _ph_req: PhantomData<Request>,
+    _ph_resp: PhantomData<Response>,
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
+#[derive(Debug, Zeroable)]
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
+// SAFETY: `Message` is safe to be send to any task.
+unsafe impl<Request: Zeroable, Response: Zeroable> Send for Message<Request, Response> {}
+
+// SAFETY: `Message` is safe to be accessed concurrently.
+unsafe impl<Request: Zeroable, Response: Zeroable> Sync for Message<Request, Response> {}
+
+impl<Request: Zeroable, Response: Zeroable> Message<Request, Response> {
+    /// Create an initializer for a new [`Message`].
+    fn new(req_data: Request, msg_type: u16) -> Result<impl PinInit<Self, Error>> {
+        macro_rules! alloc_buf {
+            ($t:ty) => {{
+                let size = (core::mem::size_of::<$t>() / page::PAGE_SIZE + 1) * page::PAGE_SIZE;
+                KVec::<u8>::with_capacity(size, GFP_KERNEL)
+            }};
+        }
+        let mut req = alloc_buf!(Request)?;
+        let mut resp = alloc_buf!(Response)?;
+        let req_ptr: NonNull<Request> = NonNull::new(req.as_mut_ptr().cast()).unwrap();
+        let resp_ptr = NonNull::new(resp.as_mut_ptr().cast()).unwrap();
+        // SAFETY: `req_ptr` is a valid Request allocation
+        unsafe {
+            core::ptr::write(req_ptr.as_ptr(), req_data);
+        }
+        Ok(pin_init!(Self {
+            req,
+            resp,
+            msg_type,
+            req_ptr,
+            resp_ptr,
+            token <- pin_init!(Token {
+                resp_actual_size: 0,
+                responded <- Completion::new(),
+            }),
+            _ph_req: PhantomData,
+            _ph_resp: PhantomData,
+        }? Error))
+    }
+
+    fn get_response(&self) -> Result<&Response, Error> {
+        if self.token.resp_actual_size as usize != core::mem::size_of::<Response>() {
+            return Err(EINVAL);
+        }
+        if self.token.resp_actual_size as usize >= core::mem::size_of::<RespHead>() {
+            let head: &RespHead = unsafe { self.resp_ptr.cast().as_ref() };
+            match head.status {
+                0 => {
+                    // OK, do nothing.
+                }
+                1 => return Err(ENOTSUPP),
+                2 => return Err(ENODEV),
+                3 => return Err(EINVAL),
+                4 | 5_u8..=u8::MAX => return Err(EIO),
+            }
+        } else {
+            return Err(EINVAL);
+        }
+        Ok(unsafe { self.resp_ptr.as_ref() })
+    }
+
+    fn send(&self, vq: &SpinLock<VirtioRtcVq>, timeout_jiffies: c_ulong) -> Result {
+        let guard = vq.lock();
+
+        let mut sg_in = core::mem::MaybeUninit::zeroed();
+        let mut sg_out = core::mem::MaybeUninit::zeroed();
+        let req = unsafe {
+            SGEntry::init_one(
+                &mut sg_out,
+                self.req_ptr.cast(),
+                core::mem::size_of::<Request>() as u32,
+            )
+        };
+        let resp = unsafe {
+            SGEntry::init_one(
+                &mut sg_in,
+                self.resp_ptr.cast(),
+                core::mem::size_of::<Response>() as u32,
+            )
+        };
+        let sgs = [req, resp];
+        // SAFETY: `self` lives at least as long until `Message::send` returns
+        unsafe {
+            guard.as_ref().add_sgs(
+                &sgs,
+                1,
+                1,
+                NonNull::new((&raw const self.token).cast_mut().cast()).unwrap(),
+                GFP_ATOMIC,
+            )?;
+        }
+
+        if guard.as_ref().kick_prepare() {
+            guard.as_ref().notify();
+        }
+        drop(guard);
+
+        if timeout_jiffies > 0 {
+            self.token
+                .responded
+                .wait_for_completion_interruptible_timeout(timeout_jiffies)?;
+        } else {
+            self.token.responded.wait_for_completion_interruptible()?;
+        }
+        Ok(())
+    }
+}
+
+// TODO: use a proper enum
+
+const VIRTIO_RTC_REQ_READ: u16 = 0x0001;
+const VIRTIO_RTC_REQ_CFG: u16 = 0x1000;
+const VIRTIO_RTC_REQ_CLOCK_CAP: u16 = 0x1001;
+
+struct VirtioRtcVq {
+    ptr: NonNull<Virtqueue>,
+}
+
+// SAFETY: `VirtioRtcVq` is safe to be send to any task.
+unsafe impl Send for VirtioRtcVq {}
+
+impl VirtioRtcVq {
+    fn new(ptr: *mut Virtqueue) -> impl PinInit<SpinLock<Self>> {
+        let ptr = NonNull::new(ptr).unwrap();
+        new_spinlock!(Self { ptr })
+    }
+
+    fn as_ref(&self) -> &Virtqueue {
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+struct VirtioRtcDriver {
+    reqvq: Pin<KBox<SpinLock<VirtioRtcVq>>>,
+    alarmvq: Option<Pin<KBox<SpinLock<VirtioRtcVq>>>>,
+    num_clocks: AtomicU16,
+    registered_clocks: Pin<KBox<Mutex<KVec<()>>>>,
+}
+
+impl Drop for VirtioRtcDriver {
+    fn drop(&mut self) {
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
+        stack_try_pin_init!(
+            let msg: Message::<ReqHead, RespCfg> =
+                Message::new(head, VIRTIO_RTC_REQ_CFG)?);
+        let msg: core::pin::Pin<&mut Message<ReqHead, RespCfg>> = msg?;
+        msg.send(&self.reqvq, 0)?;
+        pr_info!("Got response! {:?}\n", msg.get_response());
+
+        let response: &RespCfg = msg.get_response()?;
+        Ok(response.num_clocks.into())
+    }
+
+    fn process_requestq(&self) {
+        let mut cb_enabled = true;
+        loop {
+            let guard = self.reqvq.lock();
+            if cb_enabled {
+                guard.as_ref().disable_cb();
+                cb_enabled = false;
+            }
+            if let Some((token, len)) = guard.as_ref().get_buf() {
+                drop(guard);
+                pr_info!("process_requestq got buf {len} bytes\n");
+                let mut token = token.cast::<Token>();
+
+                unsafe { token.as_mut().resp_actual_size = len };
+                unsafe { token.as_mut().responded.complete_all() };
+            } else {
+                if guard.as_ref().enable_cb() {
+                    return;
+                }
+                cb_enabled = true;
+            }
+        }
+    }
+
+    fn clock_cap(&self, clock_id: u16) -> Result<RespClockCap> {
+        type ClockCapMsg = Message<ReqClockCap, RespClockCap>;
+
+        let req = ReqClockCap {
+            head: ReqHead {
+                msg_type: VIRTIO_RTC_REQ_CLOCK_CAP.into(),
+                reserved: [0; 6],
+            },
+            clock_id: clock_id.into(),
+            reserved: [0; 6],
+        };
+        stack_try_pin_init!(
+            let msg: ClockCapMsg = Message::new(req, VIRTIO_RTC_REQ_CLOCK_CAP)?
+        );
+        let msg: core::pin::Pin<&mut ClockCapMsg> = msg?;
+        msg.send(&self.reqvq, 0)?;
+        pr_info!("Got response! {:?}\n", msg.get_response());
+        let response: &RespClockCap = msg.get_response()?;
+        Ok(*response)
+    }
+
+    fn read(&self, clock_id: u16) -> Result<u64> {
+        type ReadMsg = Message<ReqRead, RespRead>;
+
+        let req = ReqRead {
+            head: ReqHead {
+                msg_type: VIRTIO_RTC_REQ_READ.into(),
+                reserved: [0; 6],
+            },
+            clock_id: clock_id.into(),
+            reserved: [0; 6],
+        };
+        stack_try_pin_init!(
+            let msg: ReadMsg = Message::new(req, VIRTIO_RTC_REQ_CLOCK_CAP)?
+        );
+        let msg: core::pin::Pin<&mut ReadMsg> = msg?;
+        msg.send(&self.reqvq, 0)?;
+        pr_info!("Got response! {:?}\n", msg.get_response());
+        let response: &RespRead = msg.get_response()?;
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
+        const VQS_INFO: [VirtqueueInfo; 1] = [
+            VirtqueueInfo::new(c"requestq", false, Some(vq_requestq_callback)),
+            //VirtqueueInfo::new(c"alarmq", false, vq_callback),
+        ];
+        let init_fn = move |slot: *mut Self| {
+            pr_info!("Probe Rust virtio driver sample.\n");
+            let vqs = match vdev.find_vqs(&VQS_INFO) {
+                Ok(vqs) => {
+                    pr_info!("Found {} vqs.\n", vqs.len());
+                    vqs
+                }
+                Err(err) => {
+                    pr_info!("Could not find vqs: {err:?}.\n");
+
+                    return Err(err);
+                }
+            };
+            let reqvq = KBox::pin_init(VirtioRtcVq::new(vqs[0]), GFP_ATOMIC)?;
+            let registered_clocks =
+                KBox::pin_init(new_mutex!(KVec::with_capacity(0, GFP_KERNEL)?), GFP_KERNEL)?;
+            unsafe {
+                core::ptr::write(
+                    slot,
+                    Self {
+                        num_clocks: AtomicU16::new(0),
+                        reqvq,
+                        alarmvq: None,
+                        registered_clocks,
+                    },
+                )
+            };
+            Ok(())
+        };
+        unsafe { pin_init::pin_init_from_closure(init_fn) }
+    }
+
+    fn init(&self, vdev: &virtio::Device<Core>) -> Result {
+        vdev.ready();
+        self.num_clocks.store(self.req_cfg()?, Ordering::SeqCst);
+        for i in 0..(self.num_clocks.load(Ordering::SeqCst)) {
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
+    fn remove(vdev: &virtio::Device<Core>, _this: Pin<&Self>) {
+        pr_info!("Removing Rust virtio driver sample.\n");
+        vdev.reset();
+        vdev.del_vqs();
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


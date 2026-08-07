Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F131328E
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111792; cv=none; b=cGs/X1OnH85Cu6L4xxw1w9HDwWBqb9dGfYyKcehqTeTknUMzVrwTxOIIHWy+Nnka2MjvUPbyXJ5YQEZ6bq8HuzX3SlMNLTrO9nHIW7xcuodu2pzVaDnv8SpZbEirk1A8cpvvMPgmY1X2KspPVavSgeBrHkmbz4u87l873lQShqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111792; c=relaxed/simple;
	bh=qdMfsQ+6JUOykZrUESeVCQ9Wa6OegXUnhtn5Av4QOoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EDHxcfs425fqskW0MpPD7rVraY7hTBCPyAdgRUTGGr7T8TtgEQOpiHthoKbuUiXheAuTjsVeOMU7lYqOiu+d1pltACsNAnOJH/hn8fvnn3wwY1BnayUz9ASAiAVkrFl8XwmbN4sJeXKXQwEBOL8TJzaQc0idy3E9cT6NZv9VYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgVj2Cjc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgVj2Cjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786111785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJmTmr1ovwUxvnG+63lZARMXkZbeLyPLyhAdbBxSq4U=;
	b=IgVj2CjcE+OPk9C+S2lKhSq/lTNipV4Ug4XjxNZtlmuMFivXCoQbZ8UQApzPjgM4OZemLS
	q8bBQAlTOJKjYfRoh9g+tplQa1wZgLgVBcL05i6HGg2ORhhEyZrly9iOVUofQKilj1CiQV
	32godLS59cl2m3nitN/8pwsU5CpKwCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-ARRzrI0yO3GdBKzgzEnAdQ-1; Fri, 07 Aug 2026 10:09:44 -0400
X-MC-Unique: ARRzrI0yO3GdBKzgzEnAdQ-1
X-Mimecast-MFC-AGG-ID: ARRzrI0yO3GdBKzgzEnAdQ_1786111782
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so23206185e9.3
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 07:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111782; x=1786716582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJmTmr1ovwUxvnG+63lZARMXkZbeLyPLyhAdbBxSq4U=;
        b=hw/SfZEg5LSu+io6+qmOFBrNVKXOqNaclBvbuclhmnebUajvZvZQEjbSQk5aHMo0HQ
         oLcxffGSznreISFZ/LDl3kKS62lNmt128WMYXtkkIfPq5eIyiq59bnvpGgSeXdjUXg5O
         nFRYuKMNCB8j47Kbcp3C2hvjTi66RoDOyqpxiSV/6rn+rf50568Th/0EugXsXzRiZ+Pn
         GslrbfAJTqGzL3PWrh9dzpEbfjIW9x7I+QBJ0DHEYv/W5Qa0yjGToGkwkbTlQtwqgYIw
         7jlAI8pN0SWbuRWLxpeyGTgaEO5snNfcUQLpih2SKu9us/GuhdJURsRVeOI4Xieu8yRx
         JRjA==
X-Forwarded-Encrypted: i=1; AHgh+RpllkGMLA14eSf5BhzIfZyDw4cpv3dfTOQIJF586tqrgqGT2L5AKPYUU2+v+9OlTZltevrIUVXhXaAGrrioKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw83Ca0q5ty3YcXgN/O2NApBuBcejjQN96XBO5IVsndd0nQECLw
	LR6dLCLj2SNkRW1TkoL7uIys4Me1V8xqOeYQTtV7mPKOM454e3gzhhFDuu+ssfRPzReTuG0kRnF
	5BRuv0sUYCfT4akgLbWZ8VZxbY2L6c9qNwqAM38PAfTaD8W6tFr1jrm7uMgfr92r+UR7l
X-Gm-Gg: AR+sD125rdEepuvDwwEyGPCOZHB63tFbHow5hPLAIENHI9ZRIPbmWrWTFCIfRO+qz3e
	nxzQ0Z7Bai6cL0S1x4TofLbWmNj9fmqTQ/P24d/B8LTW84bHWfI9NxtOhtc+i6dm8ZKmOq3nlAZ
	olS8jLS6Vmf98qh8kNjsM5LJCrAjFOI9mGHBGrPK6HFOu6Rx4vvUqxuABLJA6HcVcGMc8fGNJLO
	tvvmxmLVQ8D2CTSDfKjxWb715xa7PQWeQhPS/YT0iCx4MEpgy/x8FzLek8DhycvPWLGSOZf0eaB
	MDjsWliD1xqqhEyvxtWIzBUVzcvmlb2N9aYfzLkaBxH77x5ajgAQe8l/KgvuDueq/UXP2CmKjRL
	WZA==
X-Received: by 2002:a05:600c:a47:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-4994e71296fmr296803635e9.2.1786111782135;
        Fri, 07 Aug 2026 07:09:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-4994e71296fmr296802645e9.2.1786111781567;
        Fri, 07 Aug 2026 07:09:41 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.96.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150804sm5963244f8f.13.2026.08.07.07.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:09:40 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:09:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 6/6] samples/rust: Add sample virtio-rtc driver
 [WIP]
Message-ID: <anXiIAJelE4aj3wq@sgarzare-redhat>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <20260510-rust-virtio-v3-6-1427f14d67e1@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260510-rust-virtio-v3-6-1427f14d67e1@pitsidianak.is>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: me4pXu1SZcAsq0SSebSDdXaS6YTqiLVWMH1uhRPF1Og_1786111782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, May 10, 2026 at 04:38:19PM +0300, Manos Pitsidianakis wrote:
>While the driver queries clocks and capabilities for each clock, it
>doesn't actually register them yet (TODO).
>
>Until I implement missing functionality, there is some dead code and
>some missing SAFETY comments.
>
>Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>---
> MAINTAINERS                     |   1 +
> samples/rust/Kconfig            |  15 ++
> samples/rust/Makefile           |   1 +
> samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 420 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index e8012f708df5d4ee858c82aec3269e615fc8caad..3ed579e8d3cc64d1749cf261cd68f6338a830c4d 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27937,6 +27937,7 @@ S:	Maintained
> F:	rust/helpers/virtio.c
> F:	rust/kernel/virtio.rs
> F:	rust/kernel/virtio/
>+F:	samples/rust/rust_virtio_rtc.rs
>
> VIRTIO CRYPTO DRIVER
> M:	Gonglei <arei.gonglei@huawei.com>
>diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>index c49ab910634596aea4a1a73dac87585e084f420a..96a16aecc27198fd99f4ffd0ecdf0bc0876860c6 100644
>--- a/samples/rust/Kconfig
>+++ b/samples/rust/Kconfig
>@@ -179,4 +179,19 @@ config SAMPLE_RUST_HOSTPROGS
>
> 	  If unsure, say N.
>
>+config SAMPLE_RUST_VIRTIO_RTC
>+	tristate "Rust Virtio RTC driver"
>+	depends on VIRTIO
>+	depends on PTP_1588_CLOCK_OPTIONAL
>+	help
>+	 This driver provides current time from a Virtio RTC device. The driver
>+	 provides the time through one or more clocks. The Virtio RTC PTP
>+	 clocks and/or the Real Time Clock driver for Virtio RTC must be
>+	 enabled to expose the clocks to userspace.
>+
>+	 To compile this code as a module, choose M here: the module will be
>+	 called rust_virtio_rtc.
>+
>+	 If unsure, say M.
>+
> endif # SAMPLES_RUST
>diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>index 6c0aaa58ccccfd12ef019f68ca784f6d977bc668..0142fd8656bb8cdc95b7ef54e3183b5e51358954 100644
>--- a/samples/rust/Makefile
>+++ b/samples/rust/Makefile
>@@ -16,6 +16,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
> obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
> obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
> obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
>+obj-$(CONFIG_SAMPLE_RUST_VIRTIO_RTC)		+= rust_virtio_rtc.o
>
> rust_print-y := rust_print_main.o rust_print_events.o
>
>diff --git a/samples/rust/rust_virtio_rtc.rs b/samples/rust/rust_virtio_rtc.rs
>new file mode 100644
>index 0000000000000000000000000000000000000000..81f8b377f6c92716c17ea11542fb4262cfd90e1c
>--- /dev/null
>+++ b/samples/rust/rust_virtio_rtc.rs
>@@ -0,0 +1,403 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+//! Rust virtio driver sample.
>+
>+use core::{
>+    ptr::NonNull, //
>+    sync::atomic::{
>+        AtomicU16,
>+        Ordering, //
>+    },
>+};
>+
>+use kernel::{
>+    device::{
>+        Bound,
>+        Core, //
>+    },
>+    new_mutex,    //
>+    new_spinlock, //
>+    prelude::*,
>+    sync::{
>+        Completion,
>+        Mutex,
>+        SpinLock, //
>+    },
>+    virtio::{
>+        self,
>+        utils::*,
>+        virtqueue::*, //
>+    },
>+};
>+
>+use pin_init::{
>+    stack_pin_init,
>+    stack_try_pin_init, //
>+};
>+
>+#[pin_data]
>+struct Token {
>+    resp_actual_size: u32,
>+    #[pin]
>+    responded: Completion,
>+}
>+
>+#[derive(Copy, Clone, Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_req_head")]
>+struct ReqHead {
>+    msg_type: Le16,
>+    reserved: [u8; 6],
>+}
>+
>+#[derive(Copy, Clone, Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_resp_head")]
>+struct RespHead {
>+    status: u8,
>+    reserved: [u8; 7],
>+}
>+
>+#[derive(Copy, Clone, Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_resp_cfg")]
>+struct RespCfg {
>+    head: RespHead,
>+    /** # of clocks -> clock ids < num_clocks are valid */
>+    num_clocks: Le16,
>+    reserved: [u8; 6],
>+}
>+
>+#[derive(Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_req_clock_cap")]
>+struct ReqClockCap {
>+    head: ReqHead,
>+    clock_id: Le16,
>+    reserved: [u8; 6],
>+}
>+
>+#[derive(Copy, Clone, Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_resp_clock_cap")]
>+struct RespClockCap {
>+    head: RespHead,
>+    clock_type: u8,
>+    leap_second_smearing: u8,
>+    flags: u8,
>+    reserved: [u8; 5],
>+}
>+
>+#[derive(Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_req_read")]
>+struct ReqRead {
>+    head: ReqHead,
>+    clock_id: Le16,
>+    reserved: [u8; 6],
>+}
>+
>+#[derive(Copy, Clone, Debug, Zeroable)]
>+#[repr(C)]
>+#[doc(alias = "virtio_rtc_resp_read")]
>+struct RespRead {
>+    head: RespHead,
>+    clock_reading: Le64,
>+}
>+
>+#[repr(u8)]
>+enum ClockType {
>+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC")]
>+    Utc = 0,
>+    #[doc(alias = "VIRTIO_RTC_CLOCK_TAI")]
>+    Tai = 1,
>+    #[doc(alias = "VIRTIO_RTC_CLOCK_MONOTONIC")]
>+    Monotonic = 2,
>+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC_SMEARED")]
>+    UtcSmeared = 3,
>+    #[doc(alias = "VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED")]
>+    UtcMaybeSmeared = 4,
>+}
>+
>+/// Send a message and receive reply
>+fn send<Request: Zeroable + 'static, Response: Zeroable + Copy + 'static>(
>+    req_data: Request,
>+    vq: &SpinLock<VirtioRtcVq>,
>+    timeout_jiffies: c_ulong,
>+) -> Result<Response> {
>+    // FIXME: This lock should also disable irqs.
>+    let guard = vq.lock();
>+
>+    let req = VBox::<Request>::new(req_data, GFP_KERNEL)?;

I think we need to be careful with GFP_KERNEL allocations and spinlock, 
since IIRC GFP_KERNEL allocations may sleep.

>+    let mut resp = VBox::<Response>::new_uninit(GFP_KERNEL)?;
>+    let resp_ptr = NonNull::new(resp.as_mut_ptr()).unwrap();
>+
>+    stack_pin_init!(let token = pin_init!(Token {
>+        resp_actual_size: 0,
>+        responded <- Completion::new(),
>+    }));
>+    stack_try_pin_init!(let req_sgs = guard.reqvq().new_readable_sgtable(req, GFP_KERNEL));
>+    let req_sgs: Pin<&mut _> = req_sgs?;
>+    stack_try_pin_init!(let resp_sgs = guard.reqvq().new_writable_sgtable(resp, GFP_KERNEL));
>+    let resp_sgs: Pin<&mut _> = resp_sgs?;
>+
>+    guard
>+        .reqvq()
>+        .add_sgs(&req_sgs, &resp_sgs, token.as_ref(), GFP_ATOMIC)?;
>+
>+    if guard.reqvq().kick_prepare() {
>+        guard.reqvq().notify();
>+    }
>+    drop(guard);
>+
>+    if timeout_jiffies > 0 {
>+        token
>+            .responded
>+            .wait_for_completion_interruptible_timeout(timeout_jiffies)?;
>+    } else {
>+        token.responded.wait_for_completion_interruptible()?;
>+    }
>+
>+    if token.resp_actual_size as usize >= core::mem::size_of::<RespHead>() {
>+        // SAFETY: all response types contain a `RespHead` header at the start.
>+        let head: &RespHead = unsafe { resp_ptr.cast().as_ref() };
>+        match head.status {
>+            0 => {
>+                // OK, do nothing.
>+            }
>+            1 => return Err(ENOTSUPP),
>+            2 => return Err(ENODEV),
>+            3 => return Err(EINVAL),
>+            4 | 5_u8..=u8::MAX => return Err(EIO),
>+        }
>+    } else if token.resp_actual_size as usize != core::mem::size_of::<Response>() {

I think we should remove the else here, or check this condition first.

>+        return Err(EINVAL);
>+    }
>+    // SAFETY: we have checked that the device wrote the correct amount of bytes for this type and
>+    // has returned a successful status code.
>+    let resp = unsafe { *resp_ptr.as_ref() };
>+
>+    Ok(resp)
>+}
>+
>+const VIRTIO_RTC_REQ_READ: u16 = 0x0001;
>+const VIRTIO_RTC_REQ_CFG: u16 = 0x1000;
>+const VIRTIO_RTC_REQ_CLOCK_CAP: u16 = 0x1001;
>+
>+struct VirtioRtcVq {
>+    inner: Virtqueues,
>+}
>+
>+// SAFETY: `VirtioRtcVq` is safe to be send to any task.
>+unsafe impl Send for VirtioRtcVq {}
>+
>+impl VirtioRtcVq {
>+    fn new(inner: Virtqueues) -> impl PinInit<SpinLock<Self>> {
>+        new_spinlock!(Self { inner })
>+    }
>+
>+    fn reqvq(&self) -> &Virtqueue {
>+        unsafe { self.inner[0].as_ref() }
>+    }
>+}
>+
>+#[pin_data(PinnedDrop)]
>+struct VirtioRtcDriver {
>+    #[pin]
>+    virtqueues: SpinLock<VirtioRtcVq>,
>+    num_clocks: AtomicU16,
>+    #[pin]
>+    registered_clocks: Mutex<KVec<()>>,
>+}
>+
>+#[pinned_drop]
>+impl PinnedDrop for VirtioRtcDriver {
>+    fn drop(self: Pin<&mut Self>) {
>+        pr_info!("Remove Rust virtio driver sample.\n");
>+    }
>+}
>+
>+extern "C" fn vq_requestq_callback(vq: *mut kernel::bindings::virtqueue) {
>+    // SAFETY: The kernel called this virtqueue callback and it must have provided a valid `vq`
>+    // pointer
>+    let vq = unsafe { Virtqueue::from_raw(vq) };
>+    let dev: &virtio::Device<Bound> = vq.dev().expect("Could not get device");
>+    let data = dev
>+        .as_ref()
>+        .drvdata::<VirtioRtcDriver>()
>+        .expect("Could not borrow drvdata");
>+    data.process_requestq();
>+}
>+
>+impl VirtioRtcDriver {
>+    /// Submit `VIRTIO_RTC_REQ_CFG` and return response (`num_clocks`)
>+    fn req_cfg(&self) -> Result<u16> {
>+        let head = ReqHead {
>+            msg_type: VIRTIO_RTC_REQ_CFG.into(),
>+            reserved: [0; 6],
>+        };
>+        let response: RespCfg = send(head, &self.virtqueues, 0)?;
>+        pr_info!("Got response! {response:?}\n");
>+
>+        Ok(response.num_clocks.into())
>+    }
>+
>+    fn process_requestq(&self) {
>+        let mut cb_enabled = true;
>+        loop {
>+            // FIXME: This lock should also disable irqs.
>+            let guard = self.virtqueues.lock();
>+            if cb_enabled {
>+                guard.reqvq().disable_cb();
>+                cb_enabled = false;
>+            }
>+            if let Some((token, len)) = guard.reqvq().get_buf() {
>+                drop(guard);
>+                pr_info!("process_requestq got buf {len} bytes\n");
>+                let mut token = token.cast::<Token>();
>+                // SAFETY: pointer points to a valid Token that we have added to the virtqueue.
>+                let token_ref = unsafe { token.as_mut() };

Could this be an UB?

IIUC send() still holds a Pin<&mut Token> on its stack, blocked in the 
completion wait, so we will have 2 exclusive references to the same 
object.


>+                token_ref.resp_actual_size = len;
>+                token_ref.responded.complete_all();
>+                pr_info!("process_requestq ok\n");
>+            } else {
>+                if guard.reqvq().enable_cb() {
>+                    return;
>+                }
>+                cb_enabled = true;
>+            }
>+        }
>+    }
>+
>+    fn clock_cap(&self, clock_id: u16) -> Result<RespClockCap> {
>+        let req = ReqClockCap {
>+            head: ReqHead {
>+                msg_type: VIRTIO_RTC_REQ_CLOCK_CAP.into(),
>+                reserved: [0; 6],
>+            },
>+            clock_id: clock_id.into(),
>+            reserved: [0; 6],
>+        };
>+        let response: RespClockCap = send(req, &self.virtqueues, 0)?;
>+        pr_info!("Got response: {response:?}\n");
>+        Ok(response)
>+    }
>+
>+    fn read(&self, clock_id: u16) -> Result<u64> {
>+        let req = ReqRead {
>+            head: ReqHead {
>+                msg_type: VIRTIO_RTC_REQ_READ.into(),
>+                reserved: [0; 6],
>+            },
>+            clock_id: clock_id.into(),
>+            reserved: [0; 6],
>+        };
>+        let response: RespRead = send(req, &self.virtqueues, 0)?;
>+        pr_info!("Got response: {response:?}\n");
>+        Ok(response.clock_reading.into())
>+    }
>+}
>+
>+impl virtio::Driver for VirtioRtcDriver {
>+    type IdInfo = ();
>+
>+    /// The table of device ids supported by the driver.
>+    const ID_TABLE: virtio::IdTable<Self::IdInfo> = &VIRTIO_RTC_TABLE;
>+
>+    fn probe(vdev: &virtio::Device<Core>) -> impl PinInit<Self, Error> {
>+        let vqs_info: [VirtqueueInfo; 1] = [
>+            VirtqueueInfo::new(c"requestq", false, Some(vq_requestq_callback)),
>+            //VirtqueueInfo::new(c"alarmq", false, vq_callback),
>+        ];
>+        try_pin_init!(Self {
>+            num_clocks: AtomicU16::new(0),
>+            virtqueues <- {
>+                pr_info!("Probe Rust virtio driver sample.\n");
>+                let vqs = match vdev.find_vqs(&vqs_info) {
>+                    Ok(vqs) => {
>+                        pr_info!("Found {} vqs.\n", vqs.len());
>+                        vqs
>+                    }
>+                    Err(err) => {
>+                        pr_info!("Could not find vqs: {err:?}.\n");
>+
>+                        return Err(err);
>+                    }
>+                };
>+
>+                VirtioRtcVq::new(vqs)
>+            },
>+            registered_clocks <- new_mutex!(KVec::with_capacity(0, GFP_KERNEL)?),
>+        })
>+    }
>+
>+    fn init(&self, vdev: &virtio::Device<Bound>) -> Result {
>+        let num_clocks = self.req_cfg()?;
>+        self.num_clocks.store(num_clocks, Ordering::SeqCst);
>+        for i in 0..num_clocks {
>+            let mut is_exposed = false;
>+
>+            let resp = self.clock_cap(i)?;
>+            let (clock_type, leap_second_smearing, flags) =
>+                (resp.clock_type, resp.leap_second_smearing, resp.flags);
>+            if cfg!(CONFIG_VIRTIO_RTC_CLASS)
>+                && (clock_type == ClockType::Utc as u8
>+                    || clock_type == ClockType::UtcSmeared as u8
>+                    || clock_type == ClockType::UtcMaybeSmeared as u8)
>+            {
>+                // TODO:
>+
>+                // 	ret = viortc_init_rtc_class_clock(viortc, vio_clk_id,
>+                // 					  clock_type, flags);
>+                // 	if (ret < 0)
>+                // 		return ret;
>+                // 	if (ret > 0)
>+                // 		is_exposed = true;
>+                dev_warn!(vdev.as_ref(), "CONFIG_VIRTIO_RTC_CLASS TODO ");
>+            }
>+
>+            if cfg!(CONFIG_VIRTIO_RTC_PTP) {
>+                // TODO:
>+
>+                // 	ret = viortc_init_ptp_clock(viortc, vio_clk_id, clock_type,
>+                // 				    leap_second_smearing);
>+                // 	if (ret < 0)
>+                // 		return ret;
>+                // 	if (ret > 0)
>+                // 		is_exposed = true;
>+                // todo!()
>+                dev_warn!(vdev.as_ref(), "CONFIG_VIRTIO_RTC_PTP TODO ");
>+            }
>+
>+            if !is_exposed {
>+                dev_warn!(
>+                    vdev.as_ref(),
>+                    "cannot expose clock {i} (type {clock_type}, variant {leap_second_smearing}, \
>+                    flags {flags}) to userspace\n"
>+                );
>+            }
>+            let clock_reading = self.read(i)?;
>+            pr_info!("#{i} clock reading = {clock_reading}\n");
>+        }
>+        Ok(())
>+    }
>+
>+    fn remove(_: &virtio::Device<Core>, _this: Pin<&Self>) {
>+        pr_info!("Removing Rust virtio driver sample.\n");
>+    }
>+}
>+
>+kernel::virtio_device_table!(
>+    VIRTIO_RTC_TABLE,
>+    MODULE_VIRTIO_RTC_TABLE,
>+    <VirtioRtcDriver as virtio::Driver>::IdInfo,
>+    [(virtio::DeviceId::new(virtio::VirtioID::Clock), ())]
>+);
>+
>+kernel::module_virtio_driver! {
>+    type: VirtioRtcDriver,
>+    name: "rust_virtio_rtc",
>+    authors: ["Manos Pitsidianakis"],
>+    description: "Rust virtio driver",
>+    license: "GPL v2",
>+}
>
>-- 
>2.47.3
>


Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E538F94C
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420333; cv=none; b=tcP+dJ1KGUMCH0H7zWPEFUlpq+SSC1s7Js4OYZzI5xQNkL4zxW5Okwit8jxNMvahVqHZk6BbC+6rIDKfKt/rSdYO82KIkJfsv/aGDNhrvu5XDnUtEp16qlIALgm3/6ulZfogxNByYjq7XwIact7UTozEXPTLmS/MSn/KBy3LIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420333; c=relaxed/simple;
	bh=pzKZ6xIXKmNC75iNGr2a+BGWJ8qX9qSwFR2+WGgrR/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8MHjyEeScdkmQj/S09XybOi0bHXBWS8qHqxYze7zMDGbUmE5LQkZu7jLNkh/YVzWgV254F2D3y645sh94y+x2/32eezvKVf4yT+7Bcz+6IqbyhodUEd48bmSeRsAwlIXBy0KzEyWs285QPdhcg1eN3p/LHc8ppHSSxZB4O+zNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=nAVGi+EH; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="nAVGi+EH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420315;
	bh=pzKZ6xIXKmNC75iNGr2a+BGWJ8qX9qSwFR2+WGgrR/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=nAVGi+EHJiWZ1Ir2Z8LD3+0DJdXR0E6Gl8dAf6HAsDQThVBIvMhcDBy+6qQ4fmeOh
	 Hx+cam0qyOu+7KSaHdNunJqCRagf3w/O20E4TzrEOwNG9fGaf4afgYMix9caw/Vmaq
	 zaXk2C1wPaWwGroEiK8FDHJYZCynk9T9hBWLAKKsAbSDuzqWf+Ebi5rzjC49ObCq4O
	 6ju75C51+T+MgGhbpEs6Cx9NUhr/XkvwlSAclbHDUBNH0r26LjloNdV1IH6CSaY2Bk
	 ri55KD8E1CmnNiwWnhWi4wbcGO/IhyKcpkIWaCu4D2UFz8xpMIpqprfAe8IpdcAj1A
	 UdB4SxUqC7CCrELdwr7b72qYtDjRt3SMpo5K/GuBQ1ojEarN6VHgLsmJZnVuQjLuD3
	 0MWJXx3NOWr2sn3QzeGVaRylFBxc+2QI+yjOReuSFoTNutdHxJGMMf2/qc/EqOlZUV
	 JXV75zDs6canffMviWDd4Mzol8+GX/esQgP3njZo9dO2F1Nbm1DwyyNCHNmXhH7EQM
	 R2DqdcIO8SdPhx9NnjJb1Glwn3vYc1TGaAndCrdUti0fZfXGt71lq3OR5W1DD2QREZ
	 /pGf5sagEiFMK1aANtT2V042LBWT937cfUrSYiSDQpFjSw3lUuiJCyeNXys/lBr5nw
	 SIU06/FZaNwxR2SQCAkBcHSQ=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, 10 May 2026 16:38:17 +0300
Subject: [PATCH RFC v3 4/6] rust: add virtio module
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-rust-virtio-v3-4-1427f14d67e1@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=30065; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=pzKZ6xIXKmNC75iNGr2a+BGWJ8qX9qSwFR2+WGgrR/8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBUMVdUNzVtcktuU3VIVE92Vm1Jb3cyZTBqCkE3QVZpLzdvNEl5WjkvSmhw
 eWFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1V3QUt
 DUkIzS2Nkd2YzNEowRzlyRC85Ull1em9mNkpMY0RGSFpEMFZqb21ySFg2VVNlNHZLSDNyYWZZRg
 o3VGZnUXFkWGR1MTgzeENDbFZLSHNnTHZZM01GL1ZQNFZsdWpVYlBCd2dLU1duQndyUnBqdFNMU
 E9ybFJSdHcrCko2TDhkb1QrdTBMU0pDRk9SaTdaTFJWTnV4Rm9VTlNEbDhwVDM3ektGK0VDdmow
 RllHcUV4Ry9pNC9qcDZ6VEoKU0VyS0NJdHl1Q0lkSHAybjV4SHIrZFhDc3BUcUVCV3ZqYVV5QU5
 BSHBqVWQ0K1FKeEFJUDV5MUNoaW81L1hZcQpmUVprdGZmWmpGM0dSOU9SeHQ3NXB0QUFSV21La2
 JObzlkeDJkRE5oMWZzRm5hTy9OVDZjSE4xUzZScmJRVGhSClM5UTFGQWV0SVdGNXFOQ1AzRG1sc
 WZKMXhJNTRCV043dURWcWNLZkNjRStoRzN2eEoyR1pVMCtVSzhGZDRSVDEKRmoxRGNwU0VkUjdt
 SEcrWGhJWDAyUXpZK2Q5OGtwSDArY2drUTVXclhkbjRyaXdlRVhFR1FnUnphZjdlOGRHYgpjbzQ
 2RGw5WitMWFluRkNnVzF5b0RkZU9kNEx2dWFLbkNBR0lSMnJWaGxxbSsrTklxTDJ6bXowQXBjZU
 dlMmNDCk5OZkZ4a28xQmJRc1VuaXNFMXlJWHprQ08zWFE3S2hKRS9jd0FnaFNYREd4YU1ER24yb
 2duN3hSUVZHS01yTmIKUU1QeDVKS2Q4azJibk1BaWJoZE1xT1VaMytIWFkwbnhHaFNGaWlKR0JF
 OFlYUXBxbm5IUTFOZW9tMmZyNTg3WgpMcXc1cllEbFgvMEtlZS9DWXVzajU0SjdNSUh4ODdadTJ
 RTEpRL2w2YUFUckFNTy9RZ0x3NXdkQUY5bVdsVXF1CnBjUXRKdz09Cj05Y0UyCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add module that exposes bindings for the virtio API.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 MAINTAINERS                     |   2 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/virtio/utils.rs     |  57 ++++++
 rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
 5 files changed, 798 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48c9c666d90b5a256ab6fae1f42508b789a0ce50..e8012f708df5d4ee858c82aec3269e615fc8caad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27935,6 +27935,8 @@ M:	Manos Pitsidianakis <manos@pitsidianak.is>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	rust/helpers/virtio.c
+F:	rust/kernel/virtio.rs
+F:	rust/kernel/virtio/
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d93292d47420f1f298a452ade5feefedce5ade86..061394f441dfa27f99939b5c4160e4161a7eaa1e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -161,6 +161,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_VIRTIO = "y")]
+pub mod virtio;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/virtio.rs b/rust/kernel/virtio.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a5a4e2cfec55bc7cbca0d42b198fde6cd2b25f1c
--- /dev/null
+++ b/rust/kernel/virtio.rs
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! VIRTIO abstraction.
+//!
+//! To implement a VIRTIO driver:
+//!
+//! - Implement the [`Driver`] trait for your driver type (use [`virtio_device_table`] macro to
+//!   declare the `ID_TABLE` associated item)
+//! - Use the [`module_virtio_driver`] macro to declare your module
+
+use crate::{
+    bindings,
+    device_id::RawDeviceId,
+    error::{
+        from_result,
+        to_result,
+        Error,
+        Result, //
+    },
+    ffi::c_uint,
+    prelude::*,
+    types::Opaque, //
+};
+
+use core::{
+    marker::PhantomData,
+    pin::Pin,
+    ptr::NonNull, //
+};
+
+pub mod utils;
+pub mod virtqueue;
+
+/// IdTable type for virtio drivers.
+pub type IdTable<T> = &'static dyn crate::device_id::IdTable<DeviceId, T>;
+
+/// A VIRTIO device id.
+///
+/// [`struct virtio_device_id`]: srctree/include/linux/mod_devicetable.h
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::virtio_device_id);
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct virtio_device_id` and
+// does not add additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::virtio_device_id;
+}
+
+impl DeviceId {
+    #[inline]
+    /// Create a new device id
+    pub const fn new(device: VirtioID) -> Self {
+        Self::new_with_vendor(device, VIRTIO_DEV_ANY_ID)
+    }
+
+    #[inline]
+    /// Create a new device id with vendor
+    pub const fn new_with_vendor(device: VirtioID, vendor: u32) -> Self {
+        // Replace with `bindings::virtio_device_id::default()` once stabilized for `const`.
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut ret: bindings::virtio_device_id = unsafe { core::mem::zeroed() };
+        ret.device = device as u32;
+        ret.vendor = vendor;
+        Self(ret)
+    }
+}
+
+/// Create a virtio `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! virtio_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data:expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::virtio::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new_without_index($table_data);
+
+        $crate::module_device_table!("virtio", $module_table_name, $table_name);
+    };
+}
+
+/// Declares a kernel module that exposes a single virtio driver.
+#[macro_export]
+macro_rules! module_virtio_driver {
+($($f:tt)*) => {
+    $crate::module_driver!(<T>, $crate::virtio::Adapter<T>, { $($f)* });
+};
+}
+
+/// The Virtio driver trait.
+///
+/// Drivers must implement this trait in order to get a virtio driver registered.
+pub trait Driver: Send {
+    /// The type holding information about each device id supported by the driver.
+    // TODO: Use `associated_type_defaults` once stabilized:
+    //
+    // ```
+    // type IdInfo: 'static = ();
+    // ```
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<Self::IdInfo>;
+
+    /// virtio driver probe.
+    ///
+    /// Called when a new virtio device is added or discovered. Implementers should
+    /// attempt to initialize the device here, but should try not sleep since driver data is set
+    /// after this method returns successfully.
+    fn probe(dev: &Device<crate::device::Core>) -> impl PinInit<Self, Error>;
+
+    /// virtio driver init.
+    ///
+    /// Called after a virtio device is probed successfully, can sleep.
+    fn init(&self, dev: &Device<crate::device::Bound>) -> Result;
+
+    /// virtio driver remove.
+    ///
+    /// Called when a [`Device`] is removed from its [`Driver`]. Implementing this callback
+    /// is optional.
+    ///
+    /// This callback serves as a place for drivers to perform teardown operations that require a
+    /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
+    /// operations to gracefully tear down the device.
+    ///
+    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
+    fn remove(dev: &Device<crate::device::Core>, this: Pin<&Self>) {
+        _ = (dev, this);
+    }
+}
+
+/// Abstraction for the virtio device structure (`struct virtio_device`).
+///
+/// [`struct virtio_device`]: srctree/include/linux/virtio.h
+#[repr(transparent)]
+pub struct Device<Ctx: crate::device::DeviceContext = crate::device::Normal>(
+    Opaque<bindings::virtio_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: crate::device::DeviceContext> Device<Ctx> {
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::virtio_device {
+        self.0.get()
+    }
+}
+
+// SAFETY: `virtio::Device` is a transparent wrapper of `struct virtio_device`.
+// The offset is guaranteed to point to a valid device field inside `virtio::Device`.
+unsafe impl<Ctx: crate::device::DeviceContext> crate::device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = core::mem::offset_of!(bindings::virtio_device, dev);
+}
+
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
+
+impl<Ctx: crate::device::DeviceContext> Device<Ctx> {
+    // TODO: return VirtioID
+    /// Returns the virtio device ID.
+    #[inline]
+    pub fn device_id(&self) -> u32 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { (*self.as_raw()).id.device }
+    }
+
+    /// Returns the virtio vendor ID.
+    #[inline]
+    pub fn vendor_id(&self) -> u32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct virtio_device`.
+        unsafe { (*self.as_raw()).id.vendor }
+    }
+
+    /// Reset device.
+    #[doc(alias = "virtio_reset_device")]
+    #[inline]
+    pub fn reset(&self) {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_reset_device(self.as_raw()) }
+    }
+
+    /// Mark device as ready.
+    #[doc(alias = "virtio_device_ready")]
+    #[inline]
+    pub fn ready(&self) {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_device_ready(self.as_raw()) }
+    }
+
+    /// Return virtqueues for this device.
+    #[doc(alias = "virtio_find_vqs")]
+    pub fn find_vqs(&self, info: &[virtqueue::VirtqueueInfo]) -> Result<virtqueue::Virtqueues> {
+        let mut vqs = KVec::with_capacity(info.len(), GFP_KERNEL)?;
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        to_result(unsafe {
+            bindings::virtio_find_vqs(
+                self.as_raw(),
+                info.len().try_into()?,
+                vqs.spare_capacity_mut().as_mut_ptr().cast(),
+                info.as_ptr().cast_mut().cast(),
+                core::ptr::null_mut(),
+            )
+        })?;
+        // SAFETY: virtio_find_vqs returned successfully so `vqs` must be populated.
+        unsafe { vqs.inc_len(info.len()) };
+        let mut inner = KVec::with_capacity(vqs.len(), GFP_KERNEL)?;
+        for vq in vqs {
+            inner.push(NonNull::new(vq).ok_or(EINVAL)?, GFP_KERNEL)?;
+        }
+        Ok(virtqueue::Virtqueues { inner })
+    }
+
+    /// Delete virtqueues from this device.
+    pub(crate) fn del_vqs(&self) {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        let config = unsafe { (*self.as_raw()).config };
+        // SAFETY: `config` points to a valid virtqueue config struct.
+        if let Some(del_vqs) = unsafe { (*config).del_vqs } {
+            // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+            // `struct virtio_device`.
+            unsafe { del_vqs(self.as_raw()) }
+        }
+    }
+
+    /// Checks if the device has a feature bit.
+    #[inline]
+    pub fn has_feature(&self, fbit: c_uint) -> bool {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_has_feature(self.as_raw(), fbit) }
+    }
+}
+
+impl<Ctx: crate::device::DeviceContext> AsRef<crate::device::Device<Ctx>> for Device<Ctx> {
+    #[inline]
+    fn as_ref(&self) -> &crate::device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct virtio_device`.
+        let dev = unsafe { core::ptr::addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { crate::device::Device::from_raw(dev) }
+    }
+}
+
+/// An adapter for the registration of virtio drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY:
+// - `bindings::virtio_driver` is a C type declared as `repr(C)`.
+// - `T` is the type of the driver's device private data.
+// - `struct virtio_driver` embeds a `struct device_driver`.
+// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
+unsafe impl<T: Driver + 'static> crate::driver::DriverLayout for Adapter<T> {
+    type DriverType = bindings::virtio_driver;
+    type DriverData = T;
+    const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
+}
+
+// SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> crate::driver::RegistrationOps for Adapter<T> {
+    unsafe fn register(
+        vdrv: &Opaque<Self::DriverType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct virtio_driver` on initialization.
+        unsafe {
+            (*vdrv.get()).driver.name = name.as_char_ptr();
+            (*vdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*vdrv.get()).probe = Some(Self::probe_callback);
+            (*vdrv.get()).remove = Some(Self::remove_callback);
+        }
+
+        // SAFETY: `vdrv` is guaranteed to be a valid `DriverType`.
+        to_result(unsafe { bindings::__register_virtio_driver(vdrv.get(), module.0) })
+    }
+
+    unsafe fn unregister(vdrv: &Opaque<Self::DriverType>) {
+        // SAFETY: `vdrv` is guaranteed to be a valid `DriverType`.
+        unsafe { bindings::unregister_virtio_driver(vdrv.get()) }
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(vdev: *mut bindings::virtio_device) -> c_int {
+        // SAFETY: The kernel only ever calls the probe callback with a valid pointer to a `struct
+        // virtio_device`.
+        //
+        // INVARIANT: `vdev` is valid for the duration of `probe_callback()`.
+        let dev = unsafe { &*vdev.cast::<Device<crate::device::CoreInternal>>() };
+        from_result(|| {
+            let data = T::probe(dev);
+
+            dev.as_ref().set_drvdata(data)?;
+            // SAFETY: `Device::set_drvdata()` was just called so it's safe to borrow the data.
+            let data = unsafe { dev.as_ref().drvdata_borrow::<T>() };
+            dev.ready();
+            if let Err(err) = T::init(&data, dev) {
+                // SAFETY: `Device::set_drvdata()` was just called so it's safe to re-obtain the
+                // data.
+                let data = unsafe { dev.as_ref().drvdata_obtain::<T>() }.unwrap();
+                T::remove(dev, data.as_ref());
+                drop(data);
+                return Err(err);
+            }
+            Ok(0)
+        })
+    }
+
+    extern "C" fn remove_callback(vdev: *mut bindings::virtio_device) {
+        // SAFETY: The kernel only ever calls the remove callback with a valid pointer to a `struct
+        // virtio_device`.
+        //
+        // INVARIANT: `vdev` is valid for the duration of `remove_callback()`.
+        let dev = unsafe { &*vdev.cast::<Device<crate::device::CoreInternal>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { dev.as_ref().drvdata_borrow::<T>() };
+
+        T::remove(dev, data);
+        dev.reset();
+    }
+}
+
+/// Any vendor
+pub const VIRTIO_DEV_ANY_ID: u32 = 0xffffffff;
+
+/// Virtio IDs
+///
+/// C header: [`include/uapi/linux/virtio_ids.h`](srctree/include/uapi/linux/virtio_ids.h)
+#[repr(u32)]
+pub enum VirtioID {
+    /// virtio net
+    Net = bindings::VIRTIO_ID_NET,
+    /// virtio block
+    Block = bindings::VIRTIO_ID_BLOCK,
+    /// virtio console
+    Console = bindings::VIRTIO_ID_CONSOLE,
+    /// virtio rng
+    Rng = bindings::VIRTIO_ID_RNG,
+    /// virtio balloon
+    Balloon = bindings::VIRTIO_ID_BALLOON,
+    /// virtio ioMemory
+    IOMem = bindings::VIRTIO_ID_IOMEM,
+    /// virtio remote processor messaging
+    RPMSG = bindings::VIRTIO_ID_RPMSG,
+    /// virtio scsi
+    Scsi = bindings::VIRTIO_ID_SCSI,
+    /// 9p virtio console
+    NineP = bindings::VIRTIO_ID_9P,
+    /// virtio WLAN MAC
+    Mac80211Wlan = bindings::VIRTIO_ID_MAC80211_WLAN,
+    /// virtio remoteproc serial link
+    RPROCSerial = bindings::VIRTIO_ID_RPROC_SERIAL,
+    /// Virtio caif
+    CAIF = bindings::VIRTIO_ID_CAIF,
+    /// virtio memory balloon
+    MemoryBalloon = bindings::VIRTIO_ID_MEMORY_BALLOON,
+    /// virtio GPU
+    GPU = bindings::VIRTIO_ID_GPU,
+    /// virtio clock/timer
+    Clock = bindings::VIRTIO_ID_CLOCK,
+    /// virtio input
+    Input = bindings::VIRTIO_ID_INPUT,
+    /// virtio vsock transport
+    VSock = bindings::VIRTIO_ID_VSOCK,
+    /// virtio crypto
+    Crypto = bindings::VIRTIO_ID_CRYPTO,
+    /// virtio signal distribution device
+    SignalDist = bindings::VIRTIO_ID_SIGNAL_DIST,
+    /// virtio pstore device
+    Pstore = bindings::VIRTIO_ID_PSTORE,
+    /// virtio IOMMU
+    Iommu = bindings::VIRTIO_ID_IOMMU,
+    /// virtio mem
+    Mem = bindings::VIRTIO_ID_MEM,
+    /// virtio sound
+    Sound = bindings::VIRTIO_ID_SOUND,
+    /// virtio filesystem
+    FS = bindings::VIRTIO_ID_FS,
+    /// virtio pmem
+    PMem = bindings::VIRTIO_ID_PMEM,
+    /// virtio rpmb
+    RPMB = bindings::VIRTIO_ID_RPMB,
+    /// virtio mac80211-hwsim
+    Mac80211Hwsim = bindings::VIRTIO_ID_MAC80211_HWSIM,
+    /// virtio video encoder
+    VideoEncoder = bindings::VIRTIO_ID_VIDEO_ENCODER,
+    /// virtio video decoder
+    VideoDecoder = bindings::VIRTIO_ID_VIDEO_DECODER,
+    /// virtio SCMI
+    SCMI = bindings::VIRTIO_ID_SCMI,
+    /// virtio nitro secure module
+    NitroSecMod = bindings::VIRTIO_ID_NITRO_SEC_MOD,
+    /// virtio i2c adapter
+    I2CAdapter = bindings::VIRTIO_ID_I2C_ADAPTER,
+    /// virtio watchdog
+    Watchdog = bindings::VIRTIO_ID_WATCHDOG,
+    /// virtio can
+    CAN = bindings::VIRTIO_ID_CAN,
+    /// virtio dmabuf
+    DMABuf = bindings::VIRTIO_ID_DMABUF,
+    /// virtio parameter server
+    ParamServ = bindings::VIRTIO_ID_PARAM_SERV,
+    /// virtio audio policy
+    AudioPolicy = bindings::VIRTIO_ID_AUDIO_POLICY,
+    /// virtio bluetooth
+    BT = bindings::VIRTIO_ID_BT,
+    /// virtio gpio
+    GPIO = bindings::VIRTIO_ID_GPIO,
+    /// virtio spi
+    SPI = bindings::VIRTIO_ID_SPI,
+}
diff --git a/rust/kernel/virtio/utils.rs b/rust/kernel/virtio/utils.rs
new file mode 100644
index 0000000000000000000000000000000000000000..8dca373f10a6906b891a9420c13cd8e9e929c412
--- /dev/null
+++ b/rust/kernel/virtio/utils.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Helper types and utilities
+
+macro_rules! endian_type {
+    ($old_type:ident, $new_type:ident, $to_new:ident, $from_new:ident) => {
+        /// An unsigned integer type of with an explicit endianness.
+        #[derive(Copy, Clone, Eq, PartialEq, Debug, Default, pin_init::Zeroable)]
+        #[repr(transparent)]
+        pub struct $new_type($old_type);
+
+        $crate::static_assert!(
+            ::core::mem::align_of::<$new_type>() == ::core::mem::align_of::<$old_type>()
+        );
+        $crate::static_assert!(
+            ::core::mem::size_of::<$new_type>() == ::core::mem::size_of::<$old_type>()
+        );
+
+        impl $new_type {
+            /// Convert to CPU/native endianness.
+            pub const fn to_cpu(self) -> $old_type {
+                $old_type::$from_new(self.0)
+            }
+        }
+
+        impl PartialEq<$old_type> for $new_type {
+            fn eq(&self, other: &$old_type) -> bool {
+                self.0 == $old_type::$to_new(*other)
+            }
+        }
+
+        impl PartialEq<$new_type> for $old_type {
+            fn eq(&self, other: &$new_type) -> bool {
+                $old_type::$to_new(other.0) == *self
+            }
+        }
+
+        impl From<$new_type> for $old_type {
+            fn from(v: $new_type) -> $old_type {
+                v.to_cpu()
+            }
+        }
+
+        impl From<$old_type> for $new_type {
+            fn from(v: $old_type) -> $new_type {
+                $new_type($old_type::$to_new(v))
+            }
+        }
+    };
+}
+
+endian_type!(u16, Le16, to_le, from_le);
+endian_type!(u32, Le32, to_le, from_le);
+endian_type!(u64, Le64, to_le, from_le);
+endian_type!(u16, Be16, to_be, from_be);
+endian_type!(u32, Be32, to_be, from_be);
+endian_type!(u64, Be64, to_be, from_be);
diff --git a/rust/kernel/virtio/virtqueue.rs b/rust/kernel/virtio/virtqueue.rs
new file mode 100644
index 0000000000000000000000000000000000000000..781326c1723eb67a8c62524795ba431141fea202
--- /dev/null
+++ b/rust/kernel/virtio/virtqueue.rs
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtqueue functionality.
+//!
+//! # Discovering virtqueues
+//!
+//! Inside your driver's [`kernel::virtio::Driver::probe`] method, call
+//! [`kernel::virtio::Device::find_vqs`] method with your [`VirtqueueInfo`] struct.
+//!
+//! # Passing data to virtqueues
+//!
+//! Create your data as owned [`SGTable`] with:
+//!
+//! - [`Virtqueue::new_readable_sgtable`] for data that can be read from the device, and
+//! - [`Virtqueue::new_writable_sgtable`] for data that can be written from the device
+//!
+//! These methods will make sure to create the scatter-gather tables and DMA map them to the
+//! appropriate VIRTIO transport.
+//!
+//! To add the tables to the virtqueue, call [`Virtqueue::add_sgs`].
+
+use crate::{
+    alloc::{
+        allocator::VmallocPageIter,
+        Flags, //
+    },
+    bindings,
+    device::Bound,
+    dma::DataDirection,
+    error::{
+        code::{
+            EINVAL,
+            ENOENT, //
+        },
+        to_result,
+        Error,
+        Result, //
+    },
+    page::AsPageIter,
+    prelude::*,
+    scatterlist::{
+        Owned,
+        SGTable, //
+    },
+    str::{
+        self,
+        CStr, //
+    },
+    types::Opaque,
+    virtio::Device, //
+};
+
+use core::{
+    ptr::NonNull, //
+};
+
+/// Info for a virtqueue.
+///
+/// [`struct virtqueue_info`]: srctree/include/linux/virtio_config.h
+#[doc(alias = "virtqueue_info")]
+#[repr(transparent)]
+pub struct VirtqueueInfo(Opaque<bindings::virtqueue_info>);
+
+impl VirtqueueInfo {
+    #[inline]
+    /// Create a new [`VirtqueueInfo`]
+    pub const fn new(
+        name: &'static CStr,
+        ctx: bool,
+        callback: Option<unsafe extern "C" fn(*mut bindings::virtqueue)>,
+    ) -> Self {
+        Self(Opaque::new(bindings::virtqueue_info {
+            name: str::as_char_ptr_in_const_context(name),
+            ctx,
+            callback,
+        }))
+    }
+}
+
+/// A container for discovered virtqueues returned by [`Device::find_vqs`] method.
+///
+/// This type dereferences to a `NonNull<Virtqueue>` slice.
+///
+/// It deletes the virtqueues when dropped.
+pub struct Virtqueues {
+    pub(crate) inner: KVec<NonNull<Virtqueue>>,
+}
+
+impl Drop for Virtqueues {
+    fn drop(&mut self) {
+        let inner = core::mem::take(&mut self.inner);
+        let Some(first) = inner.into_iter().next() else {
+            return;
+        };
+        let first_ref = unsafe { first.as_ref() };
+        let Ok(vdev) = first_ref.dev() else {
+            return;
+        };
+        vdev.del_vqs();
+    }
+}
+
+impl core::ops::Deref for Virtqueues {
+    type Target = [NonNull<Virtqueue>];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+/// An opaque handler for a virtqueue.
+///
+/// [`struct virtqueue`]: srctree/include/linux/virtio.h
+#[repr(transparent)]
+pub struct Virtqueue(Opaque<bindings::virtqueue>);
+
+impl Virtqueue {
+    /// Create a [`Virtqueue`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is a properly initialized valid `virtqueue` pointer.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::virtqueue) -> &'a Self {
+        // SAFETY: The safety requirements of this function guarantee that `ptr` is a valid
+        // pointer to a `struct virtqueue` for the duration of `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct virtqueue *`.
+    #[inline]
+    pub(crate) fn as_raw(&self) -> *mut bindings::virtqueue {
+        self.0.get()
+    }
+
+    /// Get the [`Device`] associated with this virtqueue.
+    #[inline]
+    pub fn dev(&self) -> Result<&Device<Bound>> {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct
+        // virtqueue`.
+        if unsafe { (*self.as_raw()).vdev }.is_null() {
+            return Err(ENOENT);
+        }
+        // SAFETY: the pointer has been promised to be valid when self was created
+        Ok(unsafe { &*(&*self.as_raw()).vdev.cast::<Device<Bound>>() })
+    }
+
+    /// Get the vring size.
+    #[inline]
+    #[doc(alias = "virtqueue_get_vring_size")]
+    pub fn vring_size(&self) -> u32 {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_get_vring_size(self.as_raw()) }
+    }
+
+    /// Notify virtqueue.
+    #[inline]
+    #[doc(alias = "virtqueue_notify")]
+    pub fn notify(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_notify(self.as_raw()) }
+    }
+
+    /// Kick and prepare virtqueue.
+    #[inline]
+    #[doc(alias = "virtqueue_kick_prepare")]
+    pub fn kick_prepare(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_kick_prepare(self.as_raw()) }
+    }
+
+    /// Kick virtqueue.
+    #[inline]
+    #[doc(alias = "virtqueue_kick")]
+    pub fn kick(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_kick(self.as_raw()) }
+    }
+
+    /// Enable virtqueue's callback.
+    #[inline]
+    #[doc(alias = "virtqueue_enable_cb")]
+    pub fn enable_cb(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_enable_cb(self.as_raw()) }
+    }
+
+    /// Disable virtqueue's callback.
+    #[inline]
+    #[doc(alias = "virtqueue_disable_cb")]
+    pub fn disable_cb(&self) {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_disable_cb(self.as_raw()) }
+    }
+
+    /// Get a buffer from the virtqueue, if available.
+    ///
+    /// This method returns a pointer to the `token` value passed in [`Virtqueue::add_sgs`] method
+    /// and the amount of bytes that were written by the device.
+    #[inline]
+    #[doc(alias = "virtqueue_get_buf")]
+    pub fn get_buf(&'_ self) -> Option<(NonNull<u8>, u32)> {
+        let mut len = 0;
+        // SAFETY: the pointer has been promised to be valid when self was created
+        let ptr = unsafe { bindings::virtqueue_get_buf(self.as_raw(), &mut len) };
+        Some((NonNull::new(ptr.cast())?, len))
+    }
+
+    /// Add a list of scatter-gather lists to virtqueue.
+    #[inline]
+    #[doc(alias = "virtqueue_add_sgs")]
+    pub fn add_sgs<'token, PIn, POut, Token>(
+        &'_ self,
+        out_sgs: &'token SGTableReadable<POut>,
+        in_sgs: &'token SGTableWritable<PIn>,
+        token: Pin<&'token Token>,
+        gfp: Flags,
+    ) -> Result
+    where
+        for<'a> PIn: AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+        for<'a> POut: AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+    {
+        let out_sgs_num = u32::try_from(out_sgs.inner.iter().count())?;
+        let in_sgs_num = u32::try_from(in_sgs.inner.iter().count())?;
+
+        let Some(total_size) = out_sgs_num.checked_add(in_sgs_num) else {
+            return Err(EINVAL);
+        };
+
+        let mut sgs = KVec::with_capacity(2, GFP_KERNEL)?;
+
+        for entry in out_sgs.inner.iter() {
+            sgs.push(entry, GFP_KERNEL)?;
+        }
+        for entry in in_sgs.inner.iter() {
+            sgs.push(entry, GFP_KERNEL)?;
+        }
+
+        if usize::try_from(total_size) != Ok(sgs.len()) {
+            return Err(EINVAL);
+        }
+        // SAFETY: `self` has been promised to be valid when self was created
+        to_result(unsafe {
+            bindings::virtqueue_add_sgs(
+                self.as_raw(),
+                sgs.as_ptr().cast_mut().cast(),
+                out_sgs_num,
+                in_sgs_num,
+                NonNull::new(core::ptr::from_ref::<Token>(&*token.as_ref()).cast_mut())
+                    .unwrap()
+                    .as_ptr()
+                    .cast(),
+                gfp.as_raw(),
+            )
+        })
+    }
+
+    /// Create a scatter-gather table readable by the device.
+    pub fn new_readable_sgtable<P>(
+        &self,
+        pages: P,
+        flags: Flags,
+    ) -> impl PinInit<SGTableReadable<P>, Error> + '_
+    where
+        for<'a> P: AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+    {
+        pin_init!(SGTableReadable {
+            inner <- SGTable::new(
+                self.dev().unwrap().as_ref().parent().unwrap(),
+                pages,
+                DataDirection::ToDevice,
+                flags,
+            ),
+        }? Error)
+    }
+
+    /// Create a scatter-gather table writable by the device.
+    pub fn new_writable_sgtable<P>(
+        &self,
+        pages: P,
+        flags: Flags,
+    ) -> impl PinInit<SGTableWritable<P>, Error> + '_
+    where
+        for<'a> P: AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+    {
+        pin_init!(SGTableWritable {
+            inner <- SGTable::new(
+                self.dev().unwrap().as_ref().parent().unwrap(),
+                pages,
+                DataDirection::FromDevice,
+                flags,
+            ),
+        }? Error)
+    }
+}
+
+/// An [`SGTable<Owned<P>>`] that is guaranteed to have been DMA-mapped as device-readable.
+///
+/// Created by [`Virtqueue::new_readable_sgtable`].
+#[pin_data]
+pub struct SGTableReadable<P> {
+    #[pin]
+    inner: SGTable<Owned<P>>,
+}
+
+/// An [`SGTable<Owned<P>>`] that is guaranteed to have been DMA-mapped as device-writable.
+///
+/// Created by [`Virtqueue::new_writable_sgtable`].
+#[pin_data]
+pub struct SGTableWritable<P> {
+    #[pin]
+    inner: SGTable<Owned<P>>,
+}

-- 
2.47.3


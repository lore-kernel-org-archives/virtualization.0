Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401063E9F98
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968865; cv=none; b=LrSn5skTKaqVLwcoMmr6pfbG8Tbel7w1G8Hu3EKVIlZ8xIPZtuNGyqU2iZe9VL/+0imtCEH/XFpvbaPtf0mSvX80ufCH2CghwB2kLmnXS8vxbgVijxWCU1+LCv6QiVVLdJXuaFsf5uwRUEPZ2qjOhM5K86Y6q2/pd+I0vNvw1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968865; c=relaxed/simple;
	bh=wj9k7L6CpyGtzkyu5jUNg1zs7S+8H0ealzEFGpas2Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kR5ke6eeiz/1tG8YaI3WL6A5UrlmQjtVVZrq6U0zATFrpl6bGm1Yfx8FQYuaU/cLhBN7nBqeY79P1iSjX72gHQk+/CxnLHkH47hU0tDWDDex5Y/8lAGacQD2kCfHTQkZUiwPx5vZFo+QoisCICzeO1anMvBu6qNW7SNh1ecRbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=ekTjs1Z9; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="ekTjs1Z9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968858;
	bh=wj9k7L6CpyGtzkyu5jUNg1zs7S+8H0ealzEFGpas2Rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From:Subject;
	b=ekTjs1Z9e48i7oXEj9UuNJYGjfxRm6XH4V0Apr5yBb56O2eKxvBKe2evt82UoWgAw
	 p4c/hMGJykLoHYR4lSFHP2SZSo8X3np8MdGgpVs5cacMjDBi3IfKeJAnzsD54l2PcY
	 tPgnGLeq2rr9BpFNbOQtjuViz6v46NUjYLWnbufDINBGSxyq5utYJAOiMaGi9X/Jcr
	 dUznT7015j+JJsw3TdxdmCuvy8Puwo57SIpUT4PK3BzmBNWFQa6WfmPteZKLbPLS8Z
	 NHXlmpOFc/wTUnKYQ/klLveIC5AmXL4Ug3c2CbfXxau7ybjsYswk2pyQq2P9jaBv97
	 1Zh201oApLpsSLBOU0OE8Qw7WWmj8wEVpHEgwX2Ov5+VVAQuFhiWpHSz0NjjNt8uMK
	 zCMN+aKcC7rCzL47V+C6uiXjphjgcJGZ9n7C71RMbA9bz6qmT/R7eBn7GcsAtgAjC4
	 s0JLrXY0SQxn/TqnMUTgP4OaetiDtAdGEAR8hpuVMWxX4FfD3pnLeZ6/JZACMr6P68
	 MEfmM/75zNnYvEzf8Nd7M3zq89UWN4LoxZTCN/5tISH615SpMl6F00SrpFmBeNee8e
	 y91gB1qJDaNmt/+zOR+ArYw+iMHE5N2fndV1UQHBtc6PQgkz4ukCIqMetHbdCPMTbn
	 +/Zjx8TYiXc3Ws9j8kNd6LwY=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Tue, 05 May 2026 11:14:03 +0300
Subject: [PATCH RFC 3/6] rust: add virtio module
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-rust-virtio-v1-3-9563383909e4@pitsidianak.is>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=26657; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=wj9k7L6CpyGtzkyu5jUNg1zs7S+8H0ealzEFGpas2Rk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJUVXJYdDdDVDRxVUZJRjdkUnpYYVBsNGdoCk5LWkpjaiszcE5KdG1OTUsr
 MDJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTB3QUt
 DUkIzS2Nkd2YzNEowSU9IRC85WncvZ2oraVFEeFhLaldzVXJBSnFmZDRyS0oyeFlnM3kzM1FkRg
 pjdUNlc2V4dHkvd2JxU2tFN2dRM244NWU0N3ZGNitkamE0cTZyWTNMV0pIb1hMMFVaak5lNFFSZ
 mxRTTVpZkcrClZWTHBTY0lRWnl4YmI4RHd4dUNyZkdEU3VjSm9TVHhucTJIT3JHR2VBVTN6U1BX
 cHkvd1pUNEJ1Z0RzU1hxc3YKQVJTRGNNV3pPUU9lWHB5UkUvOVRBaFhYb1pRaitta3lZdWJEdXF
 kWmtGcm1XdkdtS2o0RisxR3JKVGMxaVBGaAozUFMwVGRkTTZsQ0hCZDlJeEtIOFFXM1VPWXlrcU
 tvMWp2QTZBWnpOY01YZXJSNGlFbEtSd2xheml5bDRhUVRYCmI4UTFtT3ZjYzBJVmNpWmp2dXNCY
 1pubHNzQno2K21PS055OXAxYytyTUlYTlZqYnJMd0V5K0J5YU5QMFpVTzMKMXY4NmVvblZyZVpt
 OWpQazROVWxQeHdHQnpWMlY3Mi8xeDVFeTJJT2M2d2VLK013R0c0SHh3ZzFpSk1GdTZMVApyNXl
 pL0M2L3JqcWFuZkcza0N4Qm11TFB3OTdReEZmRUdoaGtQUVB0OU80aU0wNExFTXpZSTRzYkRpUU
 5WN3JjCnZsK3oyTkY1ekphSUxlM3FCdjVVSHQrRk56TUpVRTJGdHdSLzB6Umprd2E2ZW1JQUxsa
 DI4dTlQelpENmFCYVkKTGJIL21nYjBSM0x2dWk2UXFaRGx1RkdheUNJeW9YTElQNkxzQzk0MnVZ
 SVhzYjJuL0tGdW9BVkpzTEs0dnFnZQpyMWxkV3Nwc3hvcUpzZGJ3VFJBVW1FRGtMOW4xaXRNbDN
 JeFdOSTNPeDVEdkE4TzBRT2d2TENTM2dyTjJmUWtHCjRUYjZXdz09Cj1QYlJNCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Add module that exposes bindings for the virtio API.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
 MAINTAINERS                     |   2 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/scatterlist.rs      |   2 +-
 rust/kernel/virtio.rs           | 415 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/virtio/utils.rs     |  65 +++++++
 rust/kernel/virtio/virtqueue.rs | 181 ++++++++++++++++++
 6 files changed, 666 insertions(+), 1 deletion(-)

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
index d93292d47420f1f298a452ade5feefedce5ade86..c1fe1b06fd89e80f23c5de22aeb36c80f653e1ab 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -161,6 +161,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_VIRTIO)]
+pub mod virtio;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index b83c468b5c63311f3a6d92f0f1bf05f6dfe12076..146e738cbd4351b41c11dd39a45e20f404c5cd64 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -75,7 +75,7 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
 
     /// Obtain the raw `struct scatterlist *`.
     #[inline]
-    fn as_raw(&self) -> *mut bindings::scatterlist {
+    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
         self.0.get()
     }
 
diff --git a/rust/kernel/virtio.rs b/rust/kernel/virtio.rs
new file mode 100644
index 0000000000000000000000000000000000000000..38e4f273ce76ab2dfa2e91b4ff8c4d5ddde0121c
--- /dev/null
+++ b/rust/kernel/virtio.rs
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! VIRTIO abstraction.
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
+    pin::Pin, //
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
+    /// Create a new device id with vendor
+    pub const fn new_with_vendor(device: VirtioID, vendor: u32) -> Self {
+        // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
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
+    /// attempt to initialize the device here, but not sleep, since driver data is set after this
+    /// method returns successfully.
+    fn probe(dev: &Device<crate::device::Core>) -> impl PinInit<Self, Error>;
+
+    /// virtio driver init.
+    ///
+    /// Called after a virtio device is probed successfully, can sleep.
+    fn init(&self, dev: &Device<crate::device::Core>) -> Result;
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
+    fn remove(dev: &Device, this: Pin<&Self>);
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
+    pub fn reset(&self) {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_reset_device(self.as_raw()) }
+    }
+
+    /// Mark device as ready.
+    #[doc(alias = "virtio_device_ready")]
+    pub fn ready(&self) {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_device_ready(self.as_raw()) }
+    }
+
+    /// Return virtqueues for this device.
+    #[doc(alias = "virtio_find_vqs")]
+    pub fn find_vqs(
+        &self,
+        info: &[virtqueue::VirtqueueInfo],
+    ) -> Result<KVec<*mut virtqueue::Virtqueue>> {
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
+        Ok(vqs)
+    }
+
+    /// Delete virtqueues from this device.
+    pub fn del_vqs(&self) {
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
+    pub fn has_feature(&self, fbit: c_uint) -> bool {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_has_feature(self.as_raw(), fbit) }
+    }
+
+    /// Return all feature bits for this device.
+    pub fn get_features(&self) -> u64 {
+        let mut features = 0;
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct virtio_device`.
+        unsafe { bindings::virtio_get_features(self.as_raw(), &raw mut features) };
+        features
+    }
+}
+
+impl<Ctx: crate::device::DeviceContext> AsRef<crate::device::Device<Ctx>> for Device<Ctx> {
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
+// SAFETY: A `Device` can be used rom any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}
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
+            T::init(&data, dev)?;
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
index 0000000000000000000000000000000000000000..0c078202915127d38c3ba0bb1675c7f4cd94df6e
--- /dev/null
+++ b/rust/kernel/virtio/utils.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Helper types and utilities
+
+macro_rules! endian_type {
+    (le $old_type:ident, $new_type:ident) => {
+        endian_type!($old_type, $new_type, to_le, from_le);
+    };
+    (be $old_type:ident, $new_type:ident) => {
+        endian_type!($old_type, $new_type, to_be, from_be);
+    };
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
+endian_type!(usize, LeSize, to_le, from_le);
+endian_type!(u16, Be16, to_be, from_be);
+endian_type!(u32, Be32, to_be, from_be);
+endian_type!(u64, Be64, to_be, from_be);
+endian_type!(usize, BeSize, to_be, from_be);
diff --git a/rust/kernel/virtio/virtqueue.rs b/rust/kernel/virtio/virtqueue.rs
new file mode 100644
index 0000000000000000000000000000000000000000..754fdad8c10199ee10e77658a7e773c8e4e95286
--- /dev/null
+++ b/rust/kernel/virtio/virtqueue.rs
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtqueue functionality.
+
+use crate::{
+    alloc::{
+        Flags, //
+    },
+    bindings,
+    error::{
+        code::EINVAL,
+        to_result,
+        Result, //
+    },
+    scatterlist::SGEntry,
+    str::CStr,
+    types::Opaque,
+    virtio::Device, //
+};
+
+use core::{
+    ffi::c_uint,
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
+    /// Create a new [`VirtqueueInfo`]
+    pub const fn new(
+        name: &'static CStr,
+        ctx: bool,
+        callback: unsafe extern "C" fn(*mut bindings::virtqueue),
+    ) -> Self {
+        Self(Opaque::new(bindings::virtqueue_info {
+            name: name.as_ptr(),
+            ctx,
+            callback: Some(callback),
+        }))
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
+    pub fn dev<Ctx: crate::device::DeviceContext>(&self) -> &Device<Ctx> {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        let vdev = unsafe { *self.as_raw() }.vdev;
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { &*vdev.cast::<Device<Ctx>>() }
+    }
+
+    /// Get the vring size.
+    #[doc(alias = "virtqueue_get_vring_size")]
+    pub fn vring_size(&self) -> u32 {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_get_vring_size(self.as_raw()) }
+    }
+
+    /// Notify virtqueue.
+    #[doc(alias = "virtqueue_notify")]
+    pub fn notify(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_notify(self.as_raw()) }
+    }
+
+    /// Kick and prepare virtqueue.
+    #[doc(alias = "virtqueue_kick_prepare")]
+    pub fn kick_prepare(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_kick_prepare(self.as_raw()) }
+    }
+
+    /// Kick virtqueue.
+    #[doc(alias = "virtqueue_kick")]
+    pub fn kick(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_kick(self.as_raw()) }
+    }
+
+    /// Enable virtqueue's callback.
+    #[doc(alias = "virtqueue_enable_cb")]
+    pub fn enable_cb(&self) -> bool {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_enable_cb(self.as_raw()) }
+    }
+
+    /// Disable virtqueue's callback.
+    #[doc(alias = "virtqueue_disable_cb")]
+    pub fn disable_cb(&self) {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        unsafe { bindings::virtqueue_disable_cb(self.as_raw()) }
+    }
+
+    /// Get a buffer from the virtqueue, if available.
+    #[doc(alias = "virtqueue_get_buf")]
+    pub fn get_buf(&'_ self) -> Option<(NonNull<u8>, u32)> {
+        let mut len = 0;
+        // SAFETY: the pointer has been promised to be valid when self was created
+        let ptr = unsafe { bindings::virtqueue_get_buf(self.as_raw(), &mut len) };
+        Some((NonNull::new(ptr.cast())?, len))
+    }
+
+    /// Make a device write-only buffer available.
+    #[doc(alias = "virtqueue_add_inbuf")]
+    pub fn add_inbuf(&'_ self, sg: &SGEntry, token: *mut u8, gfp: Flags) -> Result {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        to_result(unsafe {
+            bindings::virtqueue_add_inbuf(self.as_raw(), sg.as_raw(), 1, token.cast(), gfp.as_raw())
+        })
+    }
+
+    /// Make a device read-only buffer available.
+    #[doc(alias = "virtqueue_add_outbuf")]
+    pub fn add_outbuf(&'_ self, sg: &SGEntry, token: *mut u8, gfp: Flags) -> Result {
+        // SAFETY: the pointer has been promised to be valid when self was created
+        to_result(unsafe {
+            bindings::virtqueue_add_outbuf(
+                self.as_raw(),
+                sg.as_raw(),
+                1,
+                token.cast(),
+                gfp.as_raw(),
+            )
+        })
+    }
+
+    /// Add a list of scatter-gather lists to virtqueue.
+    #[doc(alias = "virtqueue_add_sgs")]
+    pub fn add_sgs(
+        &'_ self,
+        sgs: &[&SGEntry],
+        out_sgs: c_uint,
+        in_sgs: c_uint,
+        token: *mut u8,
+        gfp: Flags,
+    ) -> Result {
+        if (out_sgs + in_sgs) as usize != sgs.len() {
+            return Err(EINVAL);
+        }
+        // SAFETY: the pointer has been promised to be valid when self was created
+        to_result(unsafe {
+            bindings::virtqueue_add_sgs(
+                self.as_raw(),
+                sgs.as_ptr().cast_mut().cast(),
+                out_sgs,
+                in_sgs,
+                token.cast(),
+                gfp.as_raw(),
+            )
+        })
+    }
+}

-- 
2.47.3


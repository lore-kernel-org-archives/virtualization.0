Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D52229B12
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338064; cv=none; b=ImrNegCGu3Uxcx+GnYQT/zrxisHES3Lgau56EBXSU3xzujvv58uSdLXmSoaXX08EonauJrRyXRBzbWbzBUdVQn4X0PGRM43qzE497OR/Y5i6kxBHKq9DLo1Ibbbwf3gUIFcia10yfzp1uymNrBykQ4FgZmNAQjvdoMgevgTXskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338064; c=relaxed/simple;
	bh=AHUblVZGyMJz5JBxp1AqnulB++VVPXl4teYLqIBKzaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sc+v9RvSsCTsZUYIYen0rV/xI6NUiheRPGbsQxv/KCmb/YYpzCLWMlEiS+E1gqbtywoe9c3+nUg4BCJh2pd+MEZhK2A2mi19bqKxyHaSyqREouUqnp0Y/qX1dBz27B3J0QSXleuDcwcCeYqJfdG9daU17PV+8mgoFSkLQl2kvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=p4WBgF+x; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="p4WBgF+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778338054;
	bh=AHUblVZGyMJz5JBxp1AqnulB++VVPXl4teYLqIBKzaE=;
	h=From:Subject:Date:To:Cc:From:Subject;
	b=p4WBgF+xkjmSdDq/bGpDWO1ggBF0aBh+/ggg8H2DyVLBRFMPe/uVGWlN9tYY/4MbZ
	 8j/Ac9If8krZClKrhmnEXQ9hr3cM4I9y9fJdpIT9Ics1b642Ft+iNzy4oOTHyGFF7F
	 5YIKFJ/QnFIKa2CvTp6tF2QtdELNhDkv7OnqiYUo9D4a8lpvD8COPBHi7cgXvvBokv
	 Gk26v4rSvM/SEWbiSKZZf8an6pi2lPeJeFJcQctvCBq534E6mZ7DLIrQBwaZw/bgVk
	 7LBTTh/Hpdt0shE31pxpCW8ETqD6gBVESAD8ZCii4+SU+GN5M55o3ckrezpzVb0fUp
	 sTnb4vEcvnzMt7R73CBfs1+DQH5RaQK7Mb3Tu17boZX2E8hpZ2VfPWPCkRUdt5m/0/
	 90k4wD63O5lrU22klXRuAZSCNX0DAMpBesqjKYDYvYbkuIOZgwqt3qpSWougfzO60W
	 U9HNojFjsit5GTrxGPdOhYz4QGRcadBCv8iOHZRbiEqkTf5GiDyebOC7Nw5fm1soXG
	 YRAlaaRtItIOHuFexqAOTF2BpX1EeXgjPbpYjCiuAusUDEpmmUOHAbcVDeBdEifN4Q
	 Gzgt97ezyuAFanU++NZPlpVM7esZuXu/UOJ7ltG+plxv9oirTuowsTk4ZZO2gwaTVe
	 IxfJ++qdKSwmlb3otgYr9Ito=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Subject: [PATCH RFC v2 0/6] Add Rust virtio bindings and sample device
Date: Sat, 09 May 2026 17:46:54 +0300
Message-Id: <20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5I/2kC/1WNwQrCMBBEf6Xs2cg2aUrrqSD4AV6lh9qkdhGSk
 o1BKf13Q/Hi8c0wb1ZgG8gynIoVgk3E5F0GeShgnAf3sIJMZpAoa9RYifDiKBKFSF40Wqo7lmY
 yo4S8WIKd6L3bbnC9nKHP4UwcffjsD6ncq59M/8lSKVC0ulaqUS22tuoWikyGBjc8j8TQb9v2B
 UczBZSwAAAA
X-Change-ID: 20260504-rust-virtio-8523b01dfdc2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7157; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=AHUblVZGyMJz5JBxp1AqnulB++VVPXl4teYLqIBKzaE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnAvMGtDNHpTS0YxdlJwTU1pVkliOEdIc0JRVEhkCm9hZkpJZCt4VDVycGVwY1pm
 ZHFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWY5SkFnQUt
 DUkIzS2Nkd2YzNEowUHpIRC80Z3B1VGlNZXBFZjNncWhXWURSU1JNbms0bDNzdmJaL3d2VFVDZw
 p6YllzMVlCcklNL2hLSkJZcWphdXlITWxyamR6WFhreEhDSE5YTm93Wk9VQ1JxZzBCR01jVGdke
 mxGcExmajc1CkpoWFlGRzVieDdSTGlhZ3lHa3cxR1N0RTVVYWtINGpMWTRNTGh1WVNhR1BSUjhZ
 ODd6eWEwdXFJWEY0ZmNHbzMKVlYvVXZmYmtFMis3dmZDcTZ2bDY3T0JsZDI1WFhqa3BEVTdGajZ
 hQ0tPbHF1aFFCZGZWeit4eXM2aEQ2WkVpKwptUkRJZ0JOUjZXbmxzeC9oOHB5d05Lc3dMaWEwWl
 FvaU9Wd29sS1JWTll1N1RseDZ2WW1YYndRZis1NjNtZEV5Cm9hQ2ViMjZvRzFyVTByeTUvK3QvT
 Hg5ZTBjRmdrcGxQdU1FQ3lLRGNUK0xHWmVETHZHbW9NYTM3K2svWHNmd08KUkREQlJMYVBoRmYv
 dElKMjR1ek43Q2ZyYXBpQ1I1SnNVUkJ5dDI4eE4yU2huK0Nta0ZvY3RzK0RiN0RaVGIwLwpHZml
 ZcWQwdGVOSGpBOWtiSmlwM29GL2twUFR5VUs4QU1pRGRZTGJNeDc2NzhqOGFtOUlKeFYwK0VESF
 BYZWFMClRsR2Q5NjFHZ3E1VldIaUhDOXhUM2NOa0lHMHRXTTNVcFZuT0IxVFFtb3FqWjFwYnJHS
 zh6Tmkva3ZqcnRjVlgKeGxaVXBJQngvL1BoVnVJV21hTlNlOVNjbVlVUStWN0lpV1pFYm5keHFG
 VEVJR0MrclBtcnJKYW5DTDIrZks3UgpXZ0MrRjBoaFVJYUJqb3QwRmVibzNLYTRrSTVGNGhNZGE
 zMjJLbHNmYTIwL1ZrRTNRM1BRT21XTkhFbGpiWjdsCnIrcGZqZz09Cj1KbGl5Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos@pitsidianak.is; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

Hi all, this RFC series adds Rust bindings for Virtio drivers
(frontends in virtio parlance).

As a PoC, it also adds a sample virtio-rtc driver which performs
capability discovery through the virtqueue without registering any clock.

Before I send a cleaned-up non-RFC I would like some initial feedback
(i.e. is it something the upstream wants?)

This was tested with the rust-vmm vhost-device-rtc device backend that I
wrote[^0]:

[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc

Instructions:

  Run the daemon in a separate terminal:

  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock

  Then run the VM:

  $ qemu-system-aarch64 \
    -machine type=virt,virtualization=off,acpi=on \
    -cpu host \
    -smp 8 \
    -accel kvm \
    -drive if=virtio,format=qcow2,file=./debian-13-nocloud-arm64-daily.qcow2 \
    -device virtio-net-pci,netdev=unet \
    -device virtio-scsi-pci \
    -serial mon:stdio \
    -m 8192 \
    -object memory-backend-memfd,id=mem,size=8G,share=on \
    -numa node,memdev=mem \
    -display none \
    -vga none \
    -kernel /path/to/linux/build/arch/arm64/boot/Image \
    -device vhost-user-test-device,chardev=rtc,id=rtc,virtio-id=17,num_vqs=2,vq_size=1024 \
    -chardev socket,path=/tmp/rtc.sock,id=rtc \
    ...

  Example output:
    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
    [    1.105645] rust_virtio_rtc: Found 1 vqs.
    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (type 3, variant 0, flags 0) to userspace
    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485031060388) })
    [    1.137277] rust_virtio_rtc: #0 clock reading = 1777890485031060388
    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (type 1, variant 0, flags 0) to userspace
    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485032086075) })
    [    1.138264] rust_virtio_rtc: #1 clock reading = 1777890485032086075
    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (type 2, variant 0, flags 0) to userspace
    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(338567896865557) })
    [    1.139270] rust_virtio_rtc: #2 clock reading = 338567896865557

Concerns - Notes - TODOs
========================

- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
  of times we have to go through unsafe pointer dereferences (though
  which are guaranteed by Virtio subsystem to be valid, for example when
  a callback is called with the vq argument). There's a potential for
  misuse and definitely could use better thinking.
- `struct virtio_device` is not reference-counted like other implemented
  device types in rust/kernel. Maybe we need to change C API first to
  make them reference counted, assuming this doesn't break anything?
- Not sure if adding data smaller than PAGE_SIZE to virtqueue is safe
  (which current C code does a lot), so I made those allocations at
  least PAGE_SIZE.
- The sample driver obviously conflicts with the C implementation, so
  this would either need to move out of samples/ or figure out some way
  to handle this in kbuild.
- kernel::virtio module and its types need a few rustdoc examples that I
  will add in followup series
- Note that the registration of RTC clocks etc in the sample driver is
  not done, I'm putting it off until I receive some feedback first. The
  sample driver otherwise does send and receive data from the virtqueue
  as a PoC. The code and data structures can be cleaned up further
  before followup series.

PS: No LLMs used so any mistakes and goofs are solely written by me.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
Changes in v2:
- Move helper ifdefs to helper file (thanks Alice)
- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=m
- Split all use imports to one item per line according to style guide
- Fixed wait_for_completion_interruptible*() rustdocs
- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
- Pepper and salt #[inline]s wherever appropriate as per style guide
- Split probe() into probe() and init() to allow cleaning up if init
  fails
- Remove unnecessary Send and Sync unsafe impls for
  kernel::virtio::Device
- Remove unnecessary LeSize and BeSize 
- Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
- Made all vq buffer adding operations unsafe
- Use AtomicU16 instead of Cell<u16> for sample virtio driver
- Fix RespHead field types in sample virtio driver
- Fix response error checking in sample virtio driver
- Change some device contexts in method signatures
- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is

---
Manos Pitsidianakis (6):
      rust/bindings: generate virtio bindings
      rust/helpers: add virtio.c
      rust: add virtio module
      rust/scatterlist: add SGEntry::init_one
      rust: impl interruptible waits for Completion
      samples/rust: Add sample virtio-rtc driver [WIP]

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   5 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/virtio.c           |  37 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/scatterlist.rs      |  20 +-
 rust/kernel/sync/completion.rs  |  42 +++-
 rust/kernel/virtio.rs           | 419 ++++++++++++++++++++++++++++++++++
 rust/kernel/virtio/utils.rs     |  63 ++++++
 rust/kernel/virtio/virtqueue.rs | 241 ++++++++++++++++++++
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio_rtc.rs | 491 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 1344 insertions(+), 2 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260504-rust-virtio-8523b01dfdc2

Best regards,
-- 
Manos Pitsidianakis <manos@pitsidianak.is>


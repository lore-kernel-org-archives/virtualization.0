Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287773E929B
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968859; cv=none; b=IF1sLQiQuu4pVUOyvpFwPYm0YehC4In8qIbIVhAoGvA0wrSS7gjgC5Ygck2wie1R5cjn9nNBwU69yU0t7EBZU84jvb/eg6GJCbKpE7E26++lOerNTNy4O0ySp0AcaMecf/JhcilUMJl/dMFY6+lIzqvWX1qIJ/hOH8ghjj2DB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968859; c=relaxed/simple;
	bh=srS0KJY6aDDATKXTdP3+M8bPwx6xJgIYVSM8xP078/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hCCul+csLBDpFCULF2ib3RDddtYd/x4balFf3bHAQWwS60AZofWP6bcPY01m/t3P6iRahhP7JB6Iw7vKw9jUKN49bzjabA6eUDx564mpGxBvwVA14c+dVlp6ES+u/wzQpMIQQmucuTP4Ij+bej1uqjlMeQ/AJrd1NMPM9ntBOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=aBIq1B+N; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="aBIq1B+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1777968854;
	bh=srS0KJY6aDDATKXTdP3+M8bPwx6xJgIYVSM8xP078/U=;
	h=From:Subject:Date:To:Cc:From:Subject;
	b=aBIq1B+Ni30ziPCzKq0IhQIpjE5Pza15AS1O1mCLhHwV9vEwoCWejCHM6ENNPUj5l
	 xCxCO4fhoMEclQNvOd/NT1HZGIxdvOq0VhuKD8TEEC2m91B+l1CzD9DGodqmtLwWFO
	 kVWcqlNe8d4VSqlmINFae92KI8gJJ2oesJGMXPSPjEf3EUUAgsT4PdD972vxv5CcGJ
	 +7qiL4nDT+hd4dQkrdxM9P6pcj0zFfJWru+gVMOSl1aUD3jBYEZ74GKY+FlR3ZtxRY
	 NMioAbh1CT0eIPhb57Xs/R9N8+vMAQzIP30BikAhG/EeomQ/LAScJJcCr4oOMtMABC
	 GM5cSSW5tplKzT7U0gYKNggrC3Qq10n9XiCW+a1jXi4KGbxMLtoVj30cr60e8z+U2x
	 kZUOiBYPcVtKQz3ymPCbOeDaa6mdR8HjCWzD3O1qW17ZFkH6RKFFz96cT8uLMI9qOo
	 EbbINh0dRte8StkKZmSRg6I7+ey1SaXP6RArHPghr/mVOF6XJbCJ3OR1ecLVzySWGd
	 dMNpAO55kBfUMj3JiyycC81X9zwlRep+1j4KAoxMjBpw0ovAU5XXOe8CgweS81EKTU
	 2Vc5P64Rx9jQA22wOYNSYqcIt8YPqp/kmxkY02zE9eAqYyF3x1HNKChYQLfZAbTDpT
	 3xZYZOTW14Qkt+cbtDUc5wBw=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Subject: [PATCH RFC 0/6] Add Rust virtio bindings and sample device
Date: Tue, 05 May 2026 11:14:00 +0300
Message-Id: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmm+WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMT3aLS4hLdssyiksx8XQtTI+MkA8OUtJRkIyWgjoKi1LTMCrBp0Up
 Bbs5KsUDBjMzikvyiSpANtbW1ANzQPI9xAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6107; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=srS0KJY6aDDATKXTdP3+M8bPwx6xJgIYVSM8xP078/U=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnArYWJTMXdBd2tCWC9lSnNiZDRRZXFid1dpbmN5CldWYVRSZ2pYWDAwRVpwLzB2
 enlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWZtbTBnQUt
 DUkIzS2Nkd2YzNEowUEJQRC80by9KY1hYbXpJNGtEakdVelV6WWNvZHVBbFJ1M3ZiTWhvelRjQg
 pqcjhzODQyUjlJU1pvZElYU3V6eXdmTkJlcjhKNlFQQU5DL0N4SkRmTW5qaXFNMFFtR2dhRzUxQ
 zFUUVAzWGNNCmdZTHVKOWVYdGduWEJHSjZjYVFaNVB1aml1a0ZIcC80MUt2N1F4bGJ0TVUxOVM2
 SG1rdFBNNytHQ3hqVmRySTAKWXpHd1AxWjhqakVFMm1ET1J6ZENGR2twRU5lR2p2bG5WcEQveU9
 scWN1Mk5mSFJxVkZodm9Ba0xjUWowNk51bwptbU5vTXVZZ3NPZ3EyT3N3MmFOWXoyc3l5eDZBWF
 hVSWxqazhXekdLSS9WR3U2RVJ0KzNRdzNoenhSdWU0TURWClc2NWpoWS9nUEkyZ0NOMldjOUpmM
 k5taTVlaFlZUWlsRUtFU3pCVmY2NWRtb3pWS1VMU1ZzOHlJTERnVVZzV1YKK01QMEYvaGRJNS9E
 c1VIY0ZaRWxvZlg2S1NNazRkaGVmL2gvMVZDM1k2cW9RamoySktPODZiZ3VPYnFzUzg5awpNWTR
 3U0J6aFhKazJKUXc3TlBvbGQvNm9pTjczd2x2QWRhejRBTHJocHBwREZVRVJscmFkdUFxamF4c1
 pEY0dICnR2elNISUVIcFNqOGluczgvc2hkSkZ6VTJvUFZuMVRrZW1wSmRTd3pPb0xpbnNaaFROS
 ENYbVM0UkZVcGovQ00KSFZVc01ReTJhcFR6eE90ZUptSGJZcWJpazkzcUVhVW5BTTRyeDFjL3BP
 d0tlRXZ3MXFLdGtlUHNYY0NSME40SAprVHk3eWFxc28wWTBDbUVhRGtOMStNeFVJemxSZ21YaWx
 rby9scUhxcVpkRVZTNGFwbXp6SHFUVlIvbmFjL0NJCmFrQVRUZz09Cj1oalFMCi0tLS0tRU5EIF
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
Manos Pitsidianakis (6):
      rust/bindings: generate virtio bindings
      rust/helpers: add virtio.c
      rust: add virtio module
      rust/scatterlist: add SGEntry::init_one
      rust: impl interruptible waits for Completion
      samples/rust: Add sample virtio-rtc driver [WIP]

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   5 +
 rust/helpers/helpers.c          |   3 +
 rust/helpers/virtio.c           |  35 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/scatterlist.rs      |  20 +-
 rust/kernel/sync/completion.rs  |  39 ++++
 rust/kernel/virtio.rs           | 415 +++++++++++++++++++++++++++++++++++
 rust/kernel/virtio/utils.rs     |  65 ++++++
 rust/kernel/virtio/virtqueue.rs | 181 ++++++++++++++++
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio_rtc.rs | 470 ++++++++++++++++++++++++++++++++++++++++
 13 files changed, 1259 insertions(+), 1 deletion(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260504-rust-virtio-8523b01dfdc2

Best regards,
-- 
Manos Pitsidianakis <manos@pitsidianak.is>


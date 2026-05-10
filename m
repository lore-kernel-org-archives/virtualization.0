Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E838F252
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420321; cv=none; b=XjdBWPDpKPLJSZFywmiSTi+wPDfgSTarlNL3HHmjf8gat5InwoW2mA2Tq/20pJnulL9aADTpe11tTEPQ//nW3e8x8BapeKh1uQyUsBVNpC/MWLqBT9dxOtMqAiebViRI5iFCwzZxr8XIm7MFzhHLKHvQA+FZCUtLSolnZmJ+ShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420321; c=relaxed/simple;
	bh=7V/uIxC9Gbw93qwMU882+irwIF3lpU3PDt7Yx08MISg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NdAw7RYoIMH3NkfXuxsX7jrKZ6z9GeRmfj/KvixgMuqJaNhX5uax94QF1mTsi6eXhIcHpEdTFmUCNnsvZMYbeilxNSABDYYVohXyYsvvDcBKqNlwLSBHEWXvtbsT/YqBEcf8336A0KBiv2KJcJm/eVye2lnV59BG3yfjgH7rFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=QyFuqhPP; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="QyFuqhPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778420309;
	bh=7V/uIxC9Gbw93qwMU882+irwIF3lpU3PDt7Yx08MISg=;
	h=From:Subject:Date:To:Cc:From:Subject;
	b=QyFuqhPP7UJU3VOvE5uxzR0vgSZjmHEwLmW8POtLRM7/Rmpq8bUr+2jPseCJDlbth
	 2G2pPPcXAAXE+tDN+Tvw2XdPbgijweY43V6f88iSwe/DIFKWkS8gT0s+7Hx9GO6ghr
	 bgD1WZNPwxhB5Xbriy4wYZqMjgFht3EdKCXwydYmNPp87Wv+CpHgSeOD9acLvrOY90
	 UkQeS7uKr6myF22M1gRhREmgT8PSrIn35NXkwlmv2tz0OCaJz1rcyNq7jjg5fT5bh8
	 7uRKx07fFKj2FKGH1Jbr1uMfQxzGnZWEiZ1FNrs3XcqnIAFNhtsfssTC62DLioDfGu
	 UAbjrXrg0x1UCPHjECnOX0T4bt0IagrD3dsbCQ+sbG+V9L89B9DzJNfRARqvQ6+8Mo
	 RV+gQof8f/G1teojmoeOjM0Ychw9xRffKWDMNCf6tBGf81IdCrv3DmYJgg4CREhpsu
	 ZGhPCDfOAdyI8XGjaAk+IRUTlVc7cdGIOSPlG3DDpOXKOZjQvUZpNJLaSjDsYTPe6s
	 5d6trzAnTn6X695A5EPC+v49zsN00WHBKjIL5YIpI39wNXpE0QnGYBAFC4+t6T/iM9
	 mFt/773caVfBpdAleI6RKlUZrComJxS9JUe7siGZkFgngbPp7Idrca8PB/N8mHMZD7
	 wH3d3jowGpkdORxQ7aKos6VU=
From: Manos Pitsidianakis <manos@pitsidianak.is>
Subject: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
Date: Sun, 10 May 2026 16:38:13 +0300
Message-Id: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWKAGoC/2XNQQrCMBAF0KuUrI0kk6Y0rgTBA7gVF20ztYPQl
 iQGpfTuhuDC4vLPZ95fmEdH6NmhWJjDSJ6mMQW1K1g3NOMdOdmUGQiohBYld08feCQXaOK1BtU
 KaXvbAUsfs8OeXlm7ssv5xG7pOJAPk3vnhShz9cX0BouSC250pVStjDBYHmcKniw1Y/PYk89Yh
 F/AbAFIQCdRCeygtSD/gHVdP+U7GkPxAAAA
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
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos@pitsidianak.is>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7389; i=manos@pitsidianak.is;
 h=from:subject:message-id; bh=7V/uIxC9Gbw93qwMU882+irwIF3lpU3PDt7Yx08MISg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnFBSXBSdXdJQWNpWlBqbUFsSG1nMEMyQVpZRitqCnpKUEMyOXVka3dtb3RONHV1
 NHFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWdDS1VRQUt
 DUkIzS2Nkd2YzNEowTmF3RC85cVN1RzlZdzVXQllGUFYyT2hmSjRaM3pUcGo1TnBuSWdJK203dA
 pONUxPUUVpTUQrRTRQSWNTRDdteGIzSVprcmJzQXB4cmo5bmwrWjJJaVlWNlVoOUI3ZmlLM2dod
 kMxYkFxcHBKCk9YWFJkb1htd0ptWk9UK3pvdCtKMkQ3RFR6UXpFL0pVdldKemNNbXJBeStMRzd4
 VE5BdEF2UTRMaUhWb2c2YUMKa3dFR0NuUXZQVVdHY0Rycm5DR29VZnNIZTQzcXg4VFRDSWpJUUt
 MQ3RodzBWQ3dDaDhuUmZnMHUxWWNyZFBkZgppWXU0eFcrNVlqZTFXRlVBMnhJZEIvNkFaUXdLRj
 F0TjVIVGhDRnlMVVQxY3JlVFd6Nnp4Z3l5RnhZSEN0THViClE3N2tta05QQ2JsMnl2b3dhblZwR
 HhnV1VqMGtkVjd3UWlTc3BJdzJJY1pmQllyeDBtRnFJWHhEUGNoZjNyMEMKM0Zid2NVTHoySllO
 SEswWUJaR3JLMEdVSWxBTmYrTXBuQnRjSkxtQy9nQlBZVVdBWTA5RStMckptRm1qd043bgpZNnF
 QUkZ6VjhyUFBZL3IrWnpUeGJBZURCUFdIdkhTNkJlNjdQTkJCNVN5UmpvdEd1SlpvdlNhbldkb2
 lxTmsvCjBZS0M3eDBBME54K213aHpIb1BDRGtiZ1FKWDR5OU1XWURRYm9QR2hqRlp6VWh1dzhUV
 WV1SHJaZ2lEWjUvVlcKZDk4cHhkVXUyb3ViUjBHck01TDZHK2hVUXpuTUtWNDd2SzFQd1FQYmE3
 c1VCVnczMkxUaGpTbElsTG5PdFd3NwpXenpZd3BQcWVyT2NTRFVtdklpUDhPRDg0Rk5vaFhGNXl
 KdXZNbjEvdklJRS9XWFY4V3ZBeTdORHRyOVRNeW9ECjhoL0loUT09Cj1mWnVuCi0tLS0tRU5EIF
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
- The sample driver obviously conflicts with the C implementation, so
  this would either need to move out of samples/ or figure out some way
  to handle this in kbuild.
- kernel::virtio module and its types need a few rustdoc examples that I
  will add in followup series
- Note that the registration of RTC clocks etc in the sample driver is
  not done, I'm putting it off until I receive some feedback first. The
  sample driver otherwise does send and receive data from the virtqueue
  as a PoC.

PS: No LLMs used so any mistakes and goofs are solely written by me.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
Changes in v3:
- Removed unused methods from virtio API
- Clean up how scattergather lists are added to virtqueues by using
  owned SGTables only, and make the API safe(r)
- Add RAII cleanup for find_vqs return value that calls del_vqs
- Reset device after remove callback
- Significantly clean up sample driver as a result of the other cleanups
- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is

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
      rust/kernel/device: return parent at same context
      rust: add virtio module
      rust: impl interruptible waits for Completion
      samples/rust: Add sample virtio-rtc driver [WIP]

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   5 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/virtio.c           |  37 ++++
 rust/kernel/device.rs           |   2 +-
 rust/kernel/lib.rs              |   2 +
 rust/kernel/sync/completion.rs  |  42 +++-
 rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/virtio/utils.rs     |  57 ++++++
 rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 1309 insertions(+), 2 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260504-rust-virtio-8523b01dfdc2

Best regards,
-- 
Manos Pitsidianakis <manos@pitsidianak.is>


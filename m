Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A142D760
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615642; cv=none; b=Vp9n+CZsa4f5B64vrzEsz1L7F5p1a7tsqUdBwXHWd2NXzenKSgF2WII2Gy7k3z5JFYLsiVxHpIigSvx9dW8dqgLJkK8kQaCAOsZHU1r3fTwCmEYqgSiL4o0ql5LvwqToF9rUTIHkJiXNVKFTrgbLVo29aKu6FD13fSAQKh0iIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615642; c=relaxed/simple;
	bh=3XJuxbyJU3SOETjQPb5o1aamkVzycCtdZRVU1KptSZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=g0j9UJB8upMrSAHWIgztO3SKB+vofjmSazeKcg6XMqxOF1WHeutoQ6Mzl5fTel8z//oHOILJCsRp/4YtjtQUHQLedHbiNUESKW/LH9eJgcoTlfzGc+TVLhEYhj5ajQHf9oRcR/76fGrBi2QeeOjTMegexIFttsI3ulri0/Eu2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=hapaQfIR; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="hapaQfIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1784615081;
	bh=3XJuxbyJU3SOETjQPb5o1aamkVzycCtdZRVU1KptSZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
	b=hapaQfIR7HNwaLtNFKqQKsGT3GxCYwLXgLGN0D0kr+N7MvpdrlPl9Lud39SkHxe6a
	 0ydCRH2CdjL8cYioaXcjjeHba3WDZsdqibfB+quYpnBpCMwFUaRYgvIRdNLiQSo0uK
	 fpWgV9t1CWXX0l57rIxBdVaLgN8TvkmUd9ZtMuf9gQSbqzCsQ8tskS59hfJzSp7PCl
	 X5Jnp/SqH5EUBlkBxc4He5E5a1aVCyAkZg0NQjhJyQ3yeFTKct9Xv/zvC8kqwL8e/e
	 QieYvf0RgCmlecTn/Nj3el8syF5enm+WuY6P59kg49i80I/r4JQibxzSzx976LopW2
	 IYIIhnb7PZqXk/qsMmY4qT66MBaNoyPvk/wX29AlrRASFeIya8yt4m7OR9wI9c+/ES
	 7+zznh8HFdeozvUyyR28/1pfsx1bsEm5l0pFRGSnsr18cnq1dj3KJ0SKbIX64nwyYv
	 mct7N00LhCKKZopW4dxLQeRrMu/9wrPxzaRnVQdUVciQnLUKBbRzj1Fl5ZGahN2276
	 jL4MQPn7rgtkELThmpvkOywXLzgE1NfWu//7nmAkxiP33bK4lN36h4RCtskb1fKiR4
	 dtNjX1xGDPdh1vIy+JbIiGo5fLcpjjXc2HqNN7BBQ2oKsEx4Z59R8nNRPeUpl/tujI
	 vaHE+urZyjlGohdU2k1zzRTs=
Date: Tue, 21 Jul 2026 09:21:15 +0300
From: Manos Pitsidianakis <manos@pitsidianak.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio P=?UTF-8?B?w6lyZXo=?= <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Manos Pitsidianakis <manos@pitsidianak.is>
Subject: Re: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
User-Agent: meli/0.8.13
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
In-Reply-To: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
Message-ID: <tiiht3.22qk83rct1pd@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

Ping.

I have a different version of the series WIP with a virtio-rng instead 
of virtio-rtc, based on 
https://lore.kernel.org/lkml/20260529-rust-hw_random-virtio-rng-v1-0-b3153dd90311@pitsidianak.is/ 
(which needs a v2 also)

But since this series hasn't gotten any feedback on the virtio part, I'd 
like to ask if there is any before respinning.

Thanks!

On Sun, 10 May 2026 16:38, Manos Pitsidianakis <manos@pitsidianak.is> wrote:
>Hi all, this RFC series adds Rust bindings for Virtio drivers
>(frontends in virtio parlance).
>
>As a PoC, it also adds a sample virtio-rtc driver which performs
>capability discovery through the virtqueue without registering any clock.
>
>Before I send a cleaned-up non-RFC I would like some initial feedback
>(i.e. is it something the upstream wants?)
>
>This was tested with the rust-vmm vhost-device-rtc device backend that I
>wrote[^0]:
>
>[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc
>
>Instructions:
>
>  Run the daemon in a separate terminal:
>
>  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
>
>  Then run the VM:
>
>  $ qemu-system-aarch64 \
>    -machine type=virt,virtualization=off,acpi=on \
>    -cpu host \
>    -smp 8 \
>    -accel kvm \
>    -drive if=virtio,format=qcow2,file=./debian-13-nocloud-arm64-daily.qcow2 \
>    -device virtio-net-pci,netdev=unet \
>    -device virtio-scsi-pci \
>    -serial mon:stdio \
>    -m 8192 \
>    -object memory-backend-memfd,id=mem,size=8G,share=on \
>    -numa node,memdev=mem \
>    -display none \
>    -vga none \
>    -kernel /path/to/linux/build/arch/arm64/boot/Image \
>    -device vhost-user-test-device,chardev=rtc,id=rtc,virtio-id=17,num_vqs=2,vq_size=1024 \
>    -chardev socket,path=/tmp/rtc.sock,id=rtc \
>    ...
>
>  Example output:
>    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
>    [    1.105645] rust_virtio_rtc: Found 1 vqs.
>    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
>    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
>    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0 (type 3, variant 0, flags 0) to userspace
>    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485031060388) })
>    [    1.137277] rust_virtio_rtc: #0 clock reading = 1777890485031060388
>    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1 (type 1, variant 0, flags 0) to userspace
>    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(1777890485032086075) })
>    [    1.138264] rust_virtio_rtc: #1 clock reading = 1777890485032086075
>    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0, 0, 0] })
>    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2 (type 2, variant 0, flags 0) to userspace
>    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] }, clock_reading: Le64(338567896865557) })
>    [    1.139270] rust_virtio_rtc: #2 clock reading = 338567896865557
>
>Concerns - Notes - TODOs
>========================
>
>- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
>  of times we have to go through unsafe pointer dereferences (though
>  which are guaranteed by Virtio subsystem to be valid, for example when
>  a callback is called with the vq argument). There's a potential for
>  misuse and definitely could use better thinking.
>- `struct virtio_device` is not reference-counted like other implemented
>  device types in rust/kernel. Maybe we need to change C API first to
>  make them reference counted, assuming this doesn't break anything?
>- The sample driver obviously conflicts with the C implementation, so
>  this would either need to move out of samples/ or figure out some way
>  to handle this in kbuild.
>- kernel::virtio module and its types need a few rustdoc examples that I
>  will add in followup series
>- Note that the registration of RTC clocks etc in the sample driver is
>  not done, I'm putting it off until I receive some feedback first. The
>  sample driver otherwise does send and receive data from the virtqueue
>  as a PoC.
>
>PS: No LLMs used so any mistakes and goofs are solely written by me.
>
>Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>---
>Changes in v3:
>- Removed unused methods from virtio API
>- Clean up how scattergather lists are added to virtqueues by using
>  owned SGTables only, and make the API safe(r)
>- Add RAII cleanup for find_vqs return value that calls del_vqs
>- Reset device after remove callback
>- Significantly clean up sample driver as a result of the other cleanups
>- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is
>
>Changes in v2:
>- Move helper ifdefs to helper file (thanks Alice)
>- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=m
>- Split all use imports to one item per line according to style guide
>- Fixed wait_for_completion_interruptible*() rustdocs
>- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
>- Pepper and salt #[inline]s wherever appropriate as per style guide
>- Split probe() into probe() and init() to allow cleaning up if init
>  fails
>- Remove unnecessary Send and Sync unsafe impls for
>  kernel::virtio::Device
>- Remove unnecessary LeSize and BeSize 
>- Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
>- Made all vq buffer adding operations unsafe
>- Use AtomicU16 instead of Cell<u16> for sample virtio driver
>- Fix RespHead field types in sample virtio driver
>- Fix response error checking in sample virtio driver
>- Change some device contexts in method signatures
>- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is
>
>---
>Manos Pitsidianakis (6):
>      rust/bindings: generate virtio bindings
>      rust/helpers: add virtio.c
>      rust/kernel/device: return parent at same context
>      rust: add virtio module
>      rust: impl interruptible waits for Completion
>      samples/rust: Add sample virtio-rtc driver [WIP]
>
> MAINTAINERS                     |   9 +
> rust/bindings/bindings_helper.h |   5 +
> rust/helpers/helpers.c          |   1 +
> rust/helpers/virtio.c           |  37 ++++
> rust/kernel/device.rs           |   2 +-
> rust/kernel/lib.rs              |   2 +
> rust/kernel/sync/completion.rs  |  42 +++-
> rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++++++
> rust/kernel/virtio/utils.rs     |  57 ++++++
> rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
> samples/rust/Kconfig            |  15 ++
> samples/rust/Makefile           |   1 +
> samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++
> 13 files changed, 1309 insertions(+), 2 deletions(-)
>---
>base-commit: 028ef9c96e96197026887c0f092424679298aae8
>change-id: 20260504-rust-virtio-8523b01dfdc2
>
>Best regards,
>-- 
>Manos Pitsidianakis <manos@pitsidianak.is>
>


-- 

foo
